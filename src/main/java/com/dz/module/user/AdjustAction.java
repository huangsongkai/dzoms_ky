package com.dz.module.user;

import java.util.*;

import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.module.charge.*;
import com.dz.module.contract.Contract;
import com.dz.module.contract.ContractDao;
import com.dz.module.vehicle.Vehicle;

@Controller("adjustAction")
@Scope("prototype")
public class AdjustAction extends BaseAction {
	private String licenseNum;
	private Contract contract,old_contract;
	private Vehicle vehicle;
	@Autowired
	private ContractDao contractDao;
	
	public String adjustVehicle(){
		Session s = null;
		try{
			s = HibernateSessionFactory.getSession();
			Query query = s.createQuery("from Contract where id=( select max(id) from Contract where carNum = :carNum and state!=3 and state!=2 and state>=0 ) ");
			query.setString("carNum",licenseNum);
			query.setMaxResults(1);
			contract = (Contract) query.uniqueResult();
			
			if(contract == null){
				request.setAttribute("msgStr", "找不到车牌号为"+licenseNum+"的车辆的合同记录。");
				url = "/manage/adjustPlans.jsp";
				return SUCCESS;
			}
			
			vehicle = (Vehicle) s.get(Vehicle.class, contract.getCarframeNum());
			
			if(vehicle == null){
				request.setAttribute("msgStr", "找不到车牌号为"+licenseNum+"的车辆记录。");
				url = "/manage/adjustPlans.jsp";
				return SUCCESS;
			}
			
			Query q_b = s.createQuery("select cp.batchPlan from ChargePlan cp "
					+ "where cp.contractId=:contractId "
					+ "and cp.feeType like '%plan%' "
					+ "and cp.feeType != 'plan_base_contract' "
					+ "and cp.batchPlan is not null "
					+ "group by cp.batchPlan ");
			q_b.setInteger("contractId", contract.getId());
			List<BatchPlan> personal_list = q_b.list();
			request.setAttribute("personal_list", personal_list);
			
			Query q_c = s.createQuery("select cp from ChargePlan cp "
					+ "where cp.contractId=:contractId "
					+ "and cp.feeType like '%plan%' "
					+ "and cp.feeType != 'plan_base_contract' "
					+ "and cp.batchPlan is null ");
			q_c.setInteger("contractId", contract.getId());
			List<ChargePlan> auto_list = q_c.list();
			request.setAttribute("auto_list", auto_list);
			
			if(contract.getState()==1){
				url = "/manage/adjust_abandon_car.jsp";
			}else if(contract.getContractFrom()==null){
				url = "/manage/adjust_new_car.jsp";
			}else{
				url = "/manage/adjust_renew_car.jsp";
				old_contract = (Contract) s.get(Contract.class, contract.getContractFrom());
				
				Query q_b2 = s.createQuery("select cp.batchPlan from ChargePlan cp "
						+ "where cp.contractId=:contractId "
						+ "and cp.feeType like '%plan%' "
						+ "and cp.feeType != 'plan_base_contract' "
						+ "and cp.batchPlan is not null "
						+ "group by cp.batchPlan ");
				q_b2.setInteger("contractId", old_contract.getId());
				List<BatchPlan> old_personal_list = q_b2.list();
				request.setAttribute("old_personal_list", old_personal_list);
				
				Query q_c2 = s.createQuery("select cp from ChargePlan cp "
						+ "where cp.contractId=:contractId "
						+ "and cp.feeType like '%plan%' "
						+ "and cp.feeType != 'plan_base_contract' "
						+ "and cp.batchPlan is null ");
				q_c2.setInteger("contractId", old_contract.getId());
				List<ChargePlan> old_auto_list = q_c2.list();
				request.setAttribute("old_auto_list", old_auto_list);
			}

		}catch(HibernateException e){
			e.printStackTrace();
			request.setAttribute("msgStr", "数据获取失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return SUCCESS;
	}
	
	

	public String getLicenseNum() {
		return licenseNum;
	}

	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public void setContractDao(ContractDao contractDao) {
		this.contractDao = contractDao;
	}



	public Contract getOld_contract() {
		return old_contract;
	}



	public void setOld_contract(Contract old_contract) {
		this.old_contract = old_contract;
	}
	
	
	
}
