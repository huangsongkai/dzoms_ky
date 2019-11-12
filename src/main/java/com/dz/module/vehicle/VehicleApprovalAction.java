package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.other.ObjectAccess;
import com.dz.module.contract.Contract;
import com.dz.module.driver.Driver;
import com.dz.module.user.RelationUr;
import com.dz.module.user.User;
import com.dz.module.user.message.Message;
import com.dz.module.user.message.MessageToUser;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
@Controller
@Scope(value = "prototype")
public class VehicleApprovalAction extends BaseAction{

	private VehicleApproval vehicleApproval;
	@Autowired
	private VehicleApprovalService vehicleApprovalService;
	private Contract contract;

	private Integer state;
	private Integer approvalId;

	private String url;

	/**
	 * 新建审批单
	 * @return
	 */
	public String vehicleApprovalCreate() {
		boolean flag = vehicleApprovalService.addVehicleApproval(vehicleApproval,contract);
		if (flag) {
			return SUCCESS;
		}
		return ERROR;
	}

	/**
	 * 按ID查找审批单
	 * @return
	 * @throws IOException
	 */
	public void vehicleApprovalId() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		VehicleApproval va = vehicleApprovalService.queryVehicleApprovalById(approvalId);
		this.setVehicleApproval(va);

		JSONObject json = JSONObject.fromObject(va);

		out.print(json.toString());

		out.flush();
		out.close();
	}

	public String vehicleApprovalInterrupt(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();

			Message msg = new Message();

			msg.setFromUser(vehicleApproval.getInterruptPerson());
			msg.setTime(new Date());

			String reason = vehicleApproval.getInterruptReason();

			User u = (User) s.get(User.class, vehicleApproval.getInterruptPerson());
			vehicleApproval = (VehicleApproval) s.get(VehicleApproval.class,vehicleApproval.getId());
			Contract c = (Contract) s.get(Contract.class, vehicleApproval.getContractId());

			vehicleApproval.setState(-vehicleApproval.getState());
			vehicleApproval.setInterruptTime(new Date());
			vehicleApproval.setInterruptPerson(u.getUid());
			vehicleApproval.setInterruptReason(reason);
			s.saveOrUpdate(vehicleApproval);

			msg.setCarframeNum(c.getCarframeNum());
			msg.setIdNum(c.getIdNum());

			if(vehicleApproval.getCheckType()==0){
				msg.setType("开业审批中止");
				c.setState((short) -2);
				s.saveOrUpdate(c);

				if(StringUtils.isNotBlank(c.getCarNumOld())&&(c.getContractFrom()==null||c.getContractFrom()==0)){
					Query q_v = s.createQuery("from Vehicle where licenseNum = :carNum ");
					q_v.setString("carNum", c.getCarNumOld().trim());
					q_v.setMaxResults(1);
					Vehicle v = (Vehicle) q_v.uniqueResult();
					if(v!=null){
						v.setReused(false);
						s.saveOrUpdate(v);
					}
				}
			}else{
				msg.setType("废业审批中止");
			}

			Driver d = (Driver) s.get(Driver.class, c.getIdNum());

			msg.setMsg(String.format("%tF %s发：\n"
							+ "现有车%s(%s) 承包人 %s(%s) 因%s 中止审批，特此通知。",
					msg.getTime(),u.getUname(),
					c.getCarNum(),c.getCarframeNum(),d.getName(),c.getIdNum(),reason));

			s.saveOrUpdate(msg);

			Query q_us = s.createQuery(String.format(
					"from RelationUr where rid in (select rid from Role where rname in ('%s','%s','%s','%s','%s','%s','%s') ) "
					, "分部经理","运营部经理","副总经理","保险员","财务负责人","财务经理","办公室主任"));
			List<RelationUr> users = q_us.list();

			for (RelationUr relationUr : users) {
				MessageToUser mu = new MessageToUser();
				mu.setUid(relationUr.getUid());
				mu.setMid(msg.getId());
				mu.setAlreadyRead(false);
				s.saveOrUpdate(mu);
			}

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public void vehicleApprovalByContract() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		VehicleApproval va = vehicleApprovalService.queryVehicleApprovalByContractId(contract.getId());
		this.setVehicleApproval(va);

		JSONObject json = JSONObject.fromObject(va);

		out.print(json.toString());

		out.flush();
		out.close();
	}

	//												  0,1,2,3,4,5,6,7
	private static final int[] stateTransferMap = {1,2,7,4,5,6,8,3};
	private static final int[] stateTransferMap2= {1,3,4,2,5,6,7,8};
	public String vehicleApprovalPreUpdate() {
		vehicleApproval = vehicleApprovalService.queryVehicleApprovalById(vehicleApproval.getId());
		contract = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", vehicleApproval.getContractId());
		if(vehicleApproval.getCheckType()==0){
			url = "/vehicle/CreateApproval/vehicle_approval0"+(stateTransferMap[vehicleApproval.getState()])+".jsp";
		}else{
			url = "/vehicle/AbandonApproval/vehicle_abandon0"+(stateTransferMap2[vehicleApproval.getState()])+".jsp";
		}

		return SUCCESS;
	}

	public String vehicleApprovalPreAbandond(){
		contract = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", contract.getId());
		request.setAttribute("contract", contract);
		return SUCCESS;
	}

	public String vehicleApprovalPreCreate(){
		Contract c = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", contract.getContractFrom());
		request.setAttribute("contractFrom", c);
		return SUCCESS;
	}

	/**
	 * 更新审批单
	 * @return
	 */
	public String vehicleApprovalUpdate() {
		if (vehicleApprovalService.updateVehicleApproval(vehicleApproval)){
			request.setAttribute("msgStr", "操作成功。");
		}else{
			if(request.getAttribute("msgStr")==null){
				request.setAttribute("msgStr", "操作失败。");
			}
		}
		return SUCCESS;
	}

	public String vehicleApprovalUpdateHandleMatter(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			vehicleApproval = (VehicleApproval) s.get(VehicleApproval.class, vehicleApproval.getId());
			if(vehicleApproval==null){
				request.setAttribute("msgStr","找不到该审批单！");
			}else{
				if(vehicleApproval.getState()==8){
					Contract c = (Contract) s.get(Contract.class, vehicleApproval.getContractId());
					Vehicle v = (Vehicle) s.get(Vehicle.class, c.getCarframeNum());
					if(vehicleApproval.getHandleMatter()==true){
						v.setState(2);
					}else{
						v.setState(3);
					}
					s.saveOrUpdate(v);
				}

				vehicleApproval.setHandleMatter(BooleanUtils.negate(vehicleApproval.getHandleMatter()));
				request.setAttribute("msgStr","操作成功！");
			}
			tx.commit();
		}catch(HibernateException ex){
			ex.printStackTrace();
			if(tx!=null)
				tx.rollback();
			request.setAttribute("msgStr","操作失败！原因是："+ex.getMessage());
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return "chain2show";
	}

	public VehicleApproval getVehicleApproval() {
		return vehicleApproval;
	}

	public void setVehicleApproval(VehicleApproval vehicleApproval) {
		this.vehicleApproval = vehicleApproval;
	}

	public VehicleApprovalService getVehicleApprovalService() {
		return vehicleApprovalService;
	}

	public void setVehicleApprovalService(
			VehicleApprovalService vehicleApprovalService) {
		this.vehicleApprovalService = vehicleApprovalService;
	}

	public Contract getContract() {
		return contract;
	}

	public Integer getState() {
		return state;
	}

	public Integer getApprovalId() {
		return approvalId;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public void setApprovalId(Integer approvalId) {
		this.approvalId = approvalId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
