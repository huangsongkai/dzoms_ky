package com.dz.module.contract;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.module.charge.BatchPlan;
import com.dz.module.charge.ChargePlan;
import com.dz.module.charge.ChargeService;
import com.dz.module.charge.ClearTime;
import com.dz.module.driver.Driver;
import com.dz.module.user.RelationUr;
import com.dz.module.user.User;
import com.dz.module.user.message.Message;
import com.dz.module.user.message.MessageToUser;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.VehicleService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.beanutils.converters.IntegerConverter;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
@Controller
@Scope("prototype")
public class ContractAction extends BaseAction {
	private Contract contract;
	private Driver driver;
	private Vehicle vehicle;

	private Date beginDate,endDate;


	@Autowired
	private ContractService contractService;
	@Autowired
	private VehicleService vehicleService;
	@Autowired
	private ChargeService chargeService;


	public void setChargeService(ChargeService chargeService) {
		this.chargeService = chargeService;
	}

	public void setVehicleService(VehicleService vehicleService) {
		this.vehicleService = vehicleService;
	}

	private Integer id;
	//jsonObject
	private Object jsonObject;

	public ContractService getContractService(){
		return contractService;
	}

	public void setContractService(ContractService contractService){
		this.contractService = contractService;
	}

	public Contract getContract(){
		return contract;
	}

	public void setContract(Contract contract){
		this.contract = contract;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String zhuanbao_contractWrite(){
		contract.setPhotoGuarantor(" ");
		User user  = (User) session.getAttribute("user");

		//String rentArrStr = request.getParameterValues("rentArr");

		String rentArr = request.getParameter("rentArr");// rentArrStr.split(",");
		JSONArray jarray = JSONArray.fromObject(rentArr);
		//	System.out.println(jarray.size());
		/*String r[] = new String[96];
		int c=0;
		for(int i=0;i<rentArr.length;i++){
			if(!rentArr[i].equals(""))
				r[c++] = rentArr[i];
		}*/
		contract.setAccount(new BigDecimal(0));

		String planList = request.getParameter("planList");
		contract.setPlanList(planList);
		contract.setInputer(user.getUid());
		contract.setInputTime(new Date());

		Session hsession = HibernateSessionFactory.getSession();
		Transaction tx = null;

		try{
			tx=hsession.beginTransaction();

//			hsession.save(contract);

			contract.setState((short)0);
			Vehicle vehicle = (Vehicle) hsession.get(Vehicle.class, contract.getCarframeNum());
			if(vehicle!=null){
				vehicle.setState(1);
				vehicle.setDriverId(contract.getIdNum());
				hsession.update(vehicle);
			}
			contract.setPlanMaked(true);
			hsession.update(contract);

			int y = 0;
			int m = 0;
			Date contractBeginDate = contract.getContractBeginDate();
			Calendar contractBeginDate_calendar = Calendar.getInstance();
			contractBeginDate_calendar.setTime(contractBeginDate);
			y = contractBeginDate_calendar.get(Calendar.YEAR);
			m = contractBeginDate.getMonth();

			if(contractBeginDate.getDate()>26){
				if(m==11){
					y++;
					m=0;
				}else{
					m++;
				}
			}

			/**原车剩余的当月费用处理*/
			Contract contract_old = (Contract) hsession.get(Contract.class,contract.getContractFrom());

			Calendar oldEndDate = Calendar.getInstance();
			oldEndDate.setTime(contractBeginDate);
			oldEndDate.add(Calendar.DATE, -1);
			contract_old.setAbandonedFinalTime(oldEndDate.getTime());

//			2018/05/25 转包前合同计费截至到新合同开始日期的前一天
//			chargeService.addAndDiv(contract_old.getId(),contract.getContractBeginDate(),hsession);
//			chargeService.setCleared(contract_old.getId(), contract.getContractBeginDate(),hsession);
			chargeService.addAndDiv(contract_old.getId(),oldEndDate.getTime(),hsession);
			chargeService.setCleared(contract_old.getId(), oldEndDate.getTime(),hsession);

			/*转包时自动迁移余额*/
			BigDecimal account = contract_old.getAccount();
			contract_old.setAccount(BigDecimal.ZERO);
			contract.setAccount(account);
			hsession.update(contract_old);
			hsession.update(contract);

			Calendar calendar = Calendar.getInstance();
			calendar.set(y, m, 1);

			//首月计算 计入原合同中
			if(jarray.size()>0)
			{
				ChargePlan chargePlan = new ChargePlan();
				chargePlan.setFeeType("plan_base_contract");
				chargePlan.setIsClear(false);
				chargePlan.setRegister(user.getUname());
				chargePlan.setContractId(contract_old.getId());
				chargePlan.setFee(BigDecimal.valueOf(Double.parseDouble(jarray.get(0).toString())));

				chargePlan.setTime(calendar.getTime());

				calendar.add(Calendar.MONTH, 1);

//				chargeService.addChargePlan(chargePlan,hsession);
				hsession.save(chargePlan);
			}

			for(int i=1 ;i<jarray.size();i++){
				ChargePlan chargePlan = new ChargePlan();
				chargePlan.setFeeType("plan_base_contract");
				chargePlan.setIsClear(false);
				chargePlan.setRegister(user.getUname());
				chargePlan.setContractId(contract.getId());
				chargePlan.setFee(BigDecimal.valueOf(Double.parseDouble(jarray.get(i).toString())));

				chargePlan.setTime(calendar.getTime());

				calendar.add(Calendar.MONTH, 1);

//				chargeService.addChargePlan(chargePlan,hsession);
				hsession.save(chargePlan);
			}

			Query q_move = hsession.createQuery("update ChargePlan set contractId=:nid where contractId=:oid and isClear=false and month(time)>=:tmonth ");
			q_move.setInteger("nid", contract.getId());
			q_move.setInteger("oid", contract_old.getId());
			q_move.setInteger("tmonth", m+1);
			q_move.executeUpdate();

			tx.commit();
		}catch(HibernateException ex){
			ex.printStackTrace();
			if(tx!=null)
				tx.rollback();
			return ERROR;
		}finally{
			HibernateSessionFactory.closeSession();
		}

		return SUCCESS;
	}

	public String contractWrite(){
		if(contract==null||contract.getId()==null||contract.getId()==0){
			request.setAttribute("msgStr", "信息不全，无法录入！");
			return SUCCESS;
		}

		Contract lc = ObjectAccess.getObject(Contract.class, contract.getId());
		if(lc==null){
			request.setAttribute("msgStr", "审批信息不全，无法录入！");
			return SUCCESS;
		}

		if(lc.getState()!=3){
			request.setAttribute("msgStr", "合同已由其它用户创建！");
			return SUCCESS;
		}

		System.out.println("Begin Contract Writting......");
		if(contract.getContractFrom()!=null)
			return zhuanbao_contractWrite();
		contract.setPhotoGuarantor(" ");
		User user  = (User) session.getAttribute("user");

		//String rentArrStr = request.getParameterValues("rentArr");

		String rentArr = request.getParameter("rentArr");// rentArrStr.split(",");
		JSONArray jarray = JSONArray.fromObject(rentArr);
		//	System.out.println(jarray.size());
		/*String r[] = new String[96];
		int c=0;
		for(int i=0;i<rentArr.length;i++){
			if(!rentArr[i].equals(""))
				r[c++] = rentArr[i];
		}*/
		contract.setAccount(new BigDecimal(0));

		String planList = request.getParameter("planList");
		contract.setPlanList(planList);
		contract.setInputer(user.getUid());
		contract.setInputTime(new Date());

		System.out.println("Before Transaction......");

		Session hsession = null;
		Transaction tx = null;
		try{
			hsession = HibernateSessionFactory.getSession();
			tx = hsession.beginTransaction();

			System.out.println("Before Transaction OK!");

			contract.setState((short)0);
			hsession.saveOrUpdate(contract);

			System.out.println(contract.getCarframeNum());
			Vehicle vehicle = (Vehicle) hsession.get(Vehicle.class, contract.getCarframeNum());
			System.out.println("Get Vehicle OK!");
			if(vehicle!=null){
				vehicle.setState(1);
				vehicle.setDriverId(contract.getIdNum());

				hsession.update(vehicle);
			}else{
				System.out.println("创建合同失败。错误原因：车辆信息不完整。");
				request.setAttribute("msgStr", "创建合同失败。错误原因：车辆信息不完整。");
				return SUCCESS;
			}



			int y = 0;
			int m = 0;
			Date contractBeginDate = contract.getContractBeginDate();
			Calendar contractBeginDate_calendar = Calendar.getInstance();
			contractBeginDate_calendar.setTime(contractBeginDate);
			y = contractBeginDate_calendar.get(Calendar.YEAR);
			m = contractBeginDate_calendar.get(Calendar.MONTH);

			System.out.println("Before Plan Making......");
			//生成合同约定
			Contract c = (Contract) hsession.get(Contract.class,contract.getId());

			if(!c.isPlanMaked() && (vehicle.getOperateCardTime()==null ||
					vehicle.getOperateCardTime().getTime()<new Date(110,1,1).getTime()) ){
				if(contractBeginDate.getDate()>26){
					if(m==11){
						y++;
						m=0;
					}else{
						m++;
					}
				}
//				System.out.println(jarray.size());
//				if(jarray.size()>0){
//					System.out.println(jarray);
//				}
				for(int i=0 ;i<jarray.size();i++){
					ChargePlan chargePlan = new ChargePlan();
					chargePlan.setFeeType("plan_base_contract");
					chargePlan.setIsClear(false);
					chargePlan.setRegister(user.getUname());
					chargePlan.setContractId(contract.getId());
					chargePlan.setFee(BigDecimal.valueOf(Double.parseDouble(jarray.get(i).toString())));
					if(m>=12){
						y++;
						m=0;
					}
					Calendar calendar = Calendar.getInstance();
					calendar.set(y, m, 1);
					chargePlan.setTime(calendar.getTime());
					m++;
					hsession.saveOrUpdate(chargePlan);
				}

				contract.setPlanMaked(true);
				hsession.update(contract);
			}

			System.out.println("Before Rent Making......");

			//自动导入或新车开业   需生成 首付摊销
			int rentFirst_Month = Integer.parseInt(request.getParameter("rentFirst_Month"));

//			BigDecimal rentFirst_MonthEach = BigDecimal.valueOf(Double.parseDouble( request.getParameter("rentFirst_MonthEach")));
			double rentFirst = contract.getRentFirst();
			long rentFirst_MonthEach = Math.round(rentFirst / rentFirst_Month);
			y = contractBeginDate_calendar.get(Calendar.YEAR);
			m = contractBeginDate.getMonth();
			for(int i=0;i<rentFirst_Month;i++){
				RentFirstDivide divide = new RentFirstDivide();
				divide.setCarframeNum(vehicle.getCarframeNum());
				if (i==rentFirst_Month-1){
					divide.setMoney(BigDecimal.valueOf(rentFirst).subtract(BigDecimal.valueOf(rentFirst_MonthEach).multiply(BigDecimal.valueOf(rentFirst_Month-1))));
				}else {
					divide.setMoney(BigDecimal.valueOf(rentFirst_MonthEach));
				}

				divide.setRegister(user.getUid());
				divide.setRegTime(new Date());

				if(m>=12){
					y++;
					m=0;
				}
				Calendar calendar = Calendar.getInstance();
				calendar.set(y, m, 1);
				divide.setMonth(calendar.getTime());

				hsession.saveOrUpdate(divide);
				m++;
			}

			System.out.println("Before Commit......");

			Message msg = new Message();

			msg.setFromUser(user.getUid());
			msg.setTime(new Date());
			String reason = "新车合同已建立";
			msg.setCarframeNum(contract.getCarframeNum());
			msg.setIdNum(contract.getIdNum());
			msg.setType("新车合同创建完成");

			driver = (Driver) hsession.get(Driver.class, contract.getIdNum());

			msg.setMsg(String.format("%tF %s发：\n"
							+ "现有车%s(%s) 承包人 %s(%s) %s 可进行证照信息录入等操作，特此通知。",
					msg.getTime(),user.getUname(),
					contract.getCarNum(),contract.getCarframeNum(),driver.getName(),contract.getIdNum(),reason));
			hsession.saveOrUpdate(msg);

			Query q_us = hsession.createQuery(String.format(
					"from RelationUr where rid in (select rid from Role where rname in ('%s','%s') ) "
					, "分部经理","证照员"));
			List<RelationUr> users = q_us.list();

			for (RelationUr relationUr : users) {
				MessageToUser mu = new MessageToUser();
				mu.setUid(relationUr.getUid());
				mu.setMid(msg.getId());
				mu.setAlreadyRead(false);
				hsession.saveOrUpdate(mu);
			}

			tx.commit();
		}catch(HibernateException ex){
			ex.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "创建合同失败。错误原因："+ex.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "创建成功！");
		return SUCCESS;
	}

	public String contractUpdate1(){
		Session s = null;
		Transaction tx = null;

		try {
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();

			Contract c = (Contract) s.get(Contract.class, contract.getId());

			org.springframework.beans.BeanUtils.copyProperties(contract, c, new String[]{
					"id",
					"carframeNum",
					"carNum",
					"contractFrom",
//					"rentFirst",
//					"rent",
//					"feeAlter",
					"contractBeginDate",
					"contractEndDate",
					"isRenew",
					"carNumOld",
					"branchFirm",
					"idNum",
					"inputer",
					"inputTime",
					"state",
					"account",
					"driverRequest",
					"planList",
					"planMaked"
			});

			User user  = (User) session.getAttribute("user");

			c.setInputer(user.getUid());
			c.setInputTime(new Date());

			s.saveOrUpdate(c);

			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			if(tx!=null)
				tx.rollback();
		} finally{
			HibernateSessionFactory.closeSession();
		}




		return SUCCESS;
	}

	public String contractUpdateBeginDate(){
		if(contract==null||contract.getId()==null||contract.getId()==0||contract.getContractBeginDate()==null){
			request.setAttribute("msgStr", "输入的信息不完整。");
			return SUCCESS;
		}

		Session s = HibernateSessionFactory.getSession();
		Transaction tx = null;

		try {
			tx = s.beginTransaction();
			Contract c = (Contract) s.get(Contract.class, contract.getId());
			if(c==null){
				request.setAttribute("msgStr", "合同不存在。");
				return SUCCESS;
			}
			c.setContractBeginDate(contract.getContractBeginDate());

			Query q_add = s.createQuery("select count(*) from ChargePlan where feeType not like '%plan_%' and feeType like '%add%' and contractId=:cid");
			q_add.setInteger("cid", c.getId());
			long size = (long) q_add.uniqueResult();

			if(size==0){
				//未开始计费

				String planStr = c.getPlanList();
				JSONArray jarr = JSONArray.fromObject(planStr);
				JSONArray narr = new JSONArray();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				Date now = contract.getContractBeginDate();

				for(int i=0;i<jarr.size();i++){
					JSONObject jobj = jarr.getJSONObject(i);

					String endStr = jobj.getString("end");
					Date endDate = sdf.parse(endStr);

					if(now.after(endDate)){
						continue;
					}

					String beginStr = jobj.getString("begin");
					Date beginDate = sdf.parse(beginStr);

					if(now.after(beginDate)){
						beginStr = sdf.format(now);
						jobj.put("begin",beginStr);
					}

					narr.add(jobj);
				}

				c.setPlanList(narr.toString());
			}
			tx.commit();
			request.setAttribute("msgStr", "操作成功。");
		} catch (HibernateException | ParseException e) {
			e.printStackTrace();
			if(tx!=null)
				tx.rollback();
			request.setAttribute("msgStr", "操作失败，原因是："+e.getMessage());
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return this.contractSelectById();
	}

	public String contractUpdateEndDate(){
		if(contract==null||contract.getId()==null||contract.getId()==0||contract.getContractEndDate()==null){
			request.setAttribute("msgStr", "输入的信息不完整。");
			return SUCCESS;
		}

		User user  = (User) session.getAttribute("user");

		Session s = HibernateSessionFactory.getSession();
		Transaction tx = null;

		try {
			tx = s.beginTransaction();
			Contract c = (Contract) s.get(Contract.class, contract.getId());

			if(c==null){
				request.setAttribute("msgStr", "合同不存在。");
				return SUCCESS;
			}

			if(c.getContractEndDate().getYear()==contract.getContractEndDate().getYear()
					&& c.getContractEndDate().getMonth()==contract.getContractEndDate().getMonth()
					&& c.getContractEndDate().getDate()==contract.getContractEndDate().getDate()){
				request.setAttribute("msgStr", "结束日期相同，不需修改。");
				return SUCCESS;
			}

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

			if(c.getContractEndDate().before(contract.getContractEndDate())){
				enlongContractEndDate(s, c,contract);
			}else{
				discountContractEndTime(s, c, contract);
			}

			tx.commit();
			request.setAttribute("msgStr", "操作成功。");
		} catch (HibernateException | ParseException e) {
			e.printStackTrace();
			if(tx!=null)
				tx.rollback();
			request.setAttribute("msgStr", "操作失败，原因是："+e.getMessage());
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return this.contractSelectById();
	}

	//缩减合同期限
	private void discountContractEndTime(Session s, Contract rawContract,Contract newContract
	) throws ParseException {
		User user = (User) session.getAttribute("user");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		//TODO 2  缩减合同期限

		//当前的合同结束所在月份
		Calendar endMonth = Calendar.getInstance();
		endMonth.setTime(newContract.getContractEndDate());

		if(endMonth.get(Calendar.DATE)>26)
			endMonth.add(Calendar.MONTH, 1);
		endMonth.set(Calendar.DATE, 26);

		endMonth.add(Calendar.MONTH, -1);

		Query q_b = s.createQuery("select cp.batchPlan from ChargePlan cp "
				+ "where cp.contractId=:contractId "
				+ "and cp.feeType like '%plan%' "
				+ "and cp.feeType != 'plan_base_contract' "
				+ "and cp.batchPlan is not null "
				+ "group by cp.batchPlan ");
		q_b.setInteger("contractId", rawContract.getId());
		List<BatchPlan> batch_list = q_b.list();

		//删掉新的合同结束日期所在月及之后各月的各项计划、约定
		Query q_del = s.createQuery("delete from ChargePlan where contractId=:id and feeType like '%plan%' and time >:date and isClear=false");
		q_del.setInteger("id", rawContract.getId());
		q_del.setDate("date", endMonth.getTime());
		q_del.executeUpdate();

		endMonth.add(Calendar.MONTH, 1);

		//合同原来的结束所在月份
		Calendar endMonthBefore = Calendar.getInstance();
		endMonthBefore.setTime(rawContract.getContractEndDate());

		if(endMonthBefore.get(Calendar.DATE)>26)
			endMonthBefore.add(Calendar.MONTH, 1);
		endMonthBefore.set(Calendar.DATE, 26);

		//当月计费天数
		int days,o_days;
		Calendar end = Calendar.getInstance();
		end.setTime(newContract.getContractEndDate());

		//计算当月计费天数
		if(end.get(Calendar.DATE)==26){
			days=30;
		}else if(end.get(Calendar.DATE)>=30){
			days = 4;
		}else if(end.get(Calendar.DATE)>26){
			days = end.get(Calendar.DATE) - 26;
		}else{
			days = 4 + end.get(Calendar.DATE);
		}

		//是否在同一个财务月份
		if(endMonth.get(Calendar.YEAR)==endMonthBefore.get(Calendar.YEAR)
				&& endMonth.get(Calendar.MONTH)==endMonthBefore.get(Calendar.MONTH)){

			Calendar o_end= Calendar.getInstance();
			o_end.setTime(rawContract.getContractEndDate());

			//计算当月原计费天数
			if(o_end.get(Calendar.DATE)==26){
				o_days=30;
			}else if(o_end.get(Calendar.DATE)>=30){
				o_days = 4;
			}else if(o_end.get(Calendar.DATE)>26){
				o_days = o_end.get(Calendar.DATE) - 26;
			}else{
				o_days = 4 + o_end.get(Calendar.DATE);
			}

		}else{
			o_days = 30;
		}

		//TODO 2.1  当月的合同租金调整
		String planStr = rawContract.getPlanList();
		JSONArray jarr = JSONArray.fromObject(planStr);

		JSONArray narr = new JSONArray();

		for(Object obj :jarr){
			JSONObject jobj = (JSONObject)obj;

			String beginStr = jobj.getString("begin");
			String endStr = jobj.getString("end");
			String moneyStr = jobj.getString("money");
			String comment = jobj.getString("comment");

			Calendar n_begin = Calendar.getInstance();
			n_begin.setTime(sdf.parse(beginStr));

			Calendar n_end = Calendar.getInstance();
			n_end.setTime(sdf.parse(endStr));

			//新合同结束日期所在计费月开始日期
			Calendar endBegin = Calendar.getInstance();
			endBegin.setTime(newContract.getContractEndDate());
			if(endBegin.get(Calendar.DATE)<27){
				endBegin.add(Calendar.MONTH,-1);
			}
			endBegin.set(Calendar.DATE,27);

			if(end.before(n_begin)){
				//约定起始日期 在 新的合同结束日期之后---->无影响，删掉结束日期之后的记录
				continue;
			}else if(endBegin.after(n_end)){
				//约定结束日期 在 新的合同结束日期月初之前---->无影响
				narr.add(jobj);
				continue;
			}else if(end.after(n_end)){
				//最后一个月有约定 但未超过结束日期 ------>以约定结束日期为准
				int n_day;
				if(n_end.get(Calendar.DATE)==26){
					n_day=30;
				}else if(n_end.get(Calendar.DATE)>=30){
					n_day = 4;
				}else if(n_end.get(Calendar.DATE)>26){
					n_day = n_end.get(Calendar.DATE) - 26;
				}else{
					n_day = 4 + n_end.get(Calendar.DATE);
				}

				{
					BigDecimal money = BigDecimal.valueOf(Double.parseDouble(moneyStr));
					money.setScale(2, RoundingMode.HALF_EVEN);
					BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(n_day/30.0));
					Calendar cd = (Calendar) endBegin.clone();
					cd.add(Calendar.MONTH, 1);
					cd.set(Calendar.DATE, 1);

					ChargePlan cp = new ChargePlan();
					cp.setFeeType("plan_base_contract");
					cp.setIsClear(false);
					cp.setRegister(user.getUname());
					cp.setContractId(rawContract.getId());
					cp.setFee(planOfRent);
					cp.setTime(cd.getTime());
					cp.setComment(comment);

					s.saveOrUpdate(cp);
				}
				narr.add(jobj);
			}else{
				//最后一个月有约定 且超过结束日期 ------>以合同结束日期为准

				{
					BigDecimal money = BigDecimal.valueOf(Double.parseDouble(moneyStr));
					money.setScale(2, RoundingMode.HALF_EVEN);
					BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));
					Calendar cd = (Calendar) endBegin.clone();
					cd.add(Calendar.MONTH, 1);
					cd.set(Calendar.DATE, 1);

					ChargePlan cp = new ChargePlan();
					cp.setFeeType("plan_base_contract");
					cp.setIsClear(false);
					cp.setRegister(user.getUname());
					cp.setContractId(rawContract.getId());
					cp.setFee(planOfRent);
					cp.setTime(cd.getTime());
					cp.setComment(comment);

					s.saveOrUpdate(cp);
				}
				jobj.put("end", sdf.format(end.getTime()));
				narr.add(jobj);
			}//end of else

			rawContract.setPlanList(narr.toString());
		}//end of for in 2.1  当月的合同租金调整


		//TODO 2.2  当月的财务约定调整
		for (BatchPlan bp : batch_list) {
			if(bp.isToEnd()){
				//使用合同终止日期
				{
					BigDecimal money = bp.getFee();
					money.setScale(2, RoundingMode.HALF_EVEN);
					BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));
					Calendar cd = (Calendar) end.clone();
					if(cd.get(Calendar.DATE)>26)
						cd.add(Calendar.MONTH, 1);
					cd.set(Calendar.DATE, 1);

					ChargePlan cp = new ChargePlan();
					cp.setFeeType(bp.getFeeType());
					cp.setIsClear(false);
					cp.setRegister(bp.getRegister());
					cp.setContractId(rawContract.getId());
					cp.setFee(planOfRent);
					cp.setTime(cd.getTime());
					cp.setInTime(new Date());
					cp.setComment(bp.getComment());

					s.saveOrUpdate(cp);
				}

			}else{
				//不使用合同终止日期

				Calendar n_begin = Calendar.getInstance();
				n_begin.setTime(bp.getStartTime());

				Calendar n_end = Calendar.getInstance();
				n_end.setTime(bp.getEndTime());

				//新合同结束日期所在计费月开始日期
				Calendar endBegin = Calendar.getInstance();
				endBegin.setTime(newContract.getContractEndDate());
				if(endBegin.get(Calendar.DATE)<27){
					endBegin.add(Calendar.MONTH,-1);
				}
				endBegin.set(Calendar.DATE,27);

				if(end.before(n_begin)){
					//约定起始日期 在 新的合同结束日期之后---->无影响，删掉结束日期之后的记录
					s.delete(bp);
					continue;
				}else if(endBegin.after(n_end)){
					//约定结束日期 在 新的合同结束日期月初之前---->无影响
					continue;
				}else if(end.after(n_end)){
					//最后一个月有约定 但未超过结束日期 ------>以约定结束日期为准
					int n_day;
					if(n_end.get(Calendar.DATE)==26){
						n_day=30;
					}else if(n_end.get(Calendar.DATE)>=30){
						n_day = 4;
					}else if(n_end.get(Calendar.DATE)>26){
						n_day = n_end.get(Calendar.DATE) - 26;
					}else{
						n_day = 4 + n_end.get(Calendar.DATE);
					}

					{
						BigDecimal money = bp.getFee();
						money.setScale(2, RoundingMode.HALF_EVEN);
						BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(n_day/30.0));

						Calendar cd = (Calendar) endBegin.clone();
						cd.add(Calendar.MONTH, 1);
						cd.set(Calendar.DATE, 1);

						ChargePlan cp = new ChargePlan();
						cp.setFeeType(bp.getFeeType());
						cp.setIsClear(false);
						cp.setRegister(bp.getRegister());
						cp.setContractId(rawContract.getId());
						cp.setFee(planOfRent);
						cp.setTime(cd.getTime());
						cp.setComment(bp.getComment());

						s.saveOrUpdate(cp);
					}
				}else{
					//最后一个月有约定 且超过结束日期 ------>以合同结束日期为准

					{
						BigDecimal money = bp.getFee();
						money.setScale(2, RoundingMode.HALF_EVEN);
						BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));

						Calendar cd = (Calendar) endBegin.clone();
						cd.add(Calendar.MONTH, 1);
						cd.set(Calendar.DATE, 1);

						ChargePlan cp = new ChargePlan();
						cp.setFeeType(bp.getFeeType());
						cp.setIsClear(false);
						cp.setRegister(bp.getRegister());
						cp.setContractId(rawContract.getId());
						cp.setFee(planOfRent);
						cp.setTime(cd.getTime());
						cp.setComment(bp.getComment());

						s.saveOrUpdate(cp);
					}
					bp.setEndTime(end.getTime());
					s.saveOrUpdate(bp);
				}//end of else
			}//end of else of isToEnd
		}//end of for in 2.2

		rawContract.setContractEndDate(newContract.getContractEndDate());
		s.saveOrUpdate(rawContract);
	}

	//延长合同期限，并补充新约定
	private void enlongContractEndDate(Session s, Contract rawContract,Contract newContract) throws ParseException {
		User user = (User) session.getAttribute("user");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		//TODO 1.  延长合同期限，并补充新约定
		String planStr = newContract.getPlanList();
		JSONArray jarr = JSONArray.fromObject(planStr);

		JSONArray narr = JSONArray.fromObject(rawContract.getPlanList());

		for(Object obj :jarr){
			JSONObject jobj = (JSONObject)obj;
			narr.add(jobj);

			String beginStr = jobj.getString("begin");
			String endStr = jobj.getString("end");
			String moneyStr = jobj.getString("money");
			String comment = jobj.getString("comment");

			Calendar begin = Calendar.getInstance();
			begin.setTime(sdf.parse(beginStr));

			Calendar end = Calendar.getInstance();
			end.setTime(sdf.parse(endStr));

			BigDecimal money = BigDecimal.valueOf(Double.parseDouble(moneyStr));
			money.setScale(2, RoundingMode.HALF_EVEN);

			int month_rank = (begin.get(Calendar.DATE)>26?1:0);
			int local_months = (end.get(Calendar.YEAR) - begin.get(Calendar.YEAR)) * 12
					+ (end.get(Calendar.MONTH) - begin.get(Calendar.MONTH))
					+(begin.get(Calendar.DATE)<27?1:0)
					+(end.get(Calendar.DATE)>26?1:0);

			System.out.println(sdf.format(begin.getTime()));
			System.out.println(month_rank);
			System.out.println(local_months);

			for (int j=1;j<local_months-1;j++) {
				Calendar cd = (Calendar) begin.clone();
				cd.add(Calendar.MONTH, j+month_rank);
				cd.set(Calendar.DATE, 1);

				ChargePlan cp = new ChargePlan();
				cp.setFeeType("plan_base_contract");
				cp.setIsClear(false);
				cp.setRegister(user.getUname());
				cp.setContractId(rawContract.getId());
				cp.setFee(money);
				cp.setTime(cd.getTime());
				cp.setComment(comment);

				s.saveOrUpdate(cp);
			}

			if(local_months==1){
				//这一段时间在一个月里面
				int days = 0;
				if(begin.get(Calendar.DATE)==27&&end.get(Calendar.DATE)==26){
					days=30;
				}else
				if(begin.get(Calendar.DATE)>26){
					if(end.get(Calendar.DATE)>26){
						days = end.get(Calendar.DATE) - begin.get(Calendar.DATE) + 1;
					}else{
						//days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginArr[2]+1+parseInt(endArr[2]);
						days = 31 - begin.get(Calendar.DATE) + end.get(Calendar.DATE) + (begin.get(Calendar.DATE)>30?1:0);
					}
				}else{
					days = end.get(Calendar.DATE) - begin.get(Calendar.DATE) + 1;
				}
				BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));


				Calendar cd = (Calendar) begin.clone();
				cd.add(Calendar.MONTH, month_rank);
				cd.set(Calendar.DATE, 1);

				ChargePlan cp = new ChargePlan();
				cp.setFeeType("plan_base_contract");
				cp.setIsClear(false);
				cp.setRegister(user.getUname());
				cp.setContractId(rawContract.getId());
				cp.setFee(planOfRent);
				cp.setTime(cd.getTime());
				cp.setComment(comment);

				s.saveOrUpdate(cp);
			}else{
				//这一段时间分属不同的月
				//第一个月
				int days;
				if(begin.get(Calendar.DATE)==27){
					days=30;
				}else if(begin.get(Calendar.DATE)>27){
					//days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginArr[2]+27;
					days = 57 - begin.get(Calendar.DATE) + (begin.get(Calendar.DATE)>30?1:0);
				}else{
					days = 27 - begin.get(Calendar.DATE);
				}

				{
					BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));
					Calendar cd = (Calendar) begin.clone();
					cd.add(Calendar.MONTH, month_rank);
					cd.set(Calendar.DATE, 1);

					ChargePlan cp = new ChargePlan();
					cp.setFeeType("plan_base_contract");
					cp.setIsClear(false);
					cp.setRegister(user.getUname());
					cp.setContractId(rawContract.getId());
					cp.setFee(planOfRent);
					cp.setTime(cd.getTime());
					cp.setComment(comment);

					s.saveOrUpdate(cp);
				}

				//最后一个月
				if(end.get(Calendar.DATE)==26){
					days=30;
				}else if(end.get(Calendar.DATE)>=30){
					days = 4;
				}else if(end.get(Calendar.DATE)>26){
					days = end.get(Calendar.DATE) - 26;
				}else{
					//days = parseInt(getDaysOfMonth(endArr[0],endArr[1]-1))+parseInt(endArr[2])-26;
					days = 4 + end.get(Calendar.DATE);
				}
				{
					BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));
					Calendar cd = (Calendar) begin.clone();
					cd.add(Calendar.MONTH, month_rank+local_months-1);
					cd.set(Calendar.DATE, 1);

					ChargePlan cp = new ChargePlan();
					cp.setFeeType("plan_base_contract");
					cp.setIsClear(false);
					cp.setRegister(user.getUname());
					cp.setContractId(rawContract.getId());
					cp.setFee(planOfRent);
					cp.setTime(cd.getTime());
					cp.setComment(comment);

					s.saveOrUpdate(cp);
				}
			}

		}

		rawContract.setContractEndDate(newContract.getContractEndDate());
		rawContract.setPlanList(narr.toString());
		s.saveOrUpdate(rawContract);
	}

	public String contractPlanClear(){
		if(contract==null||contract.getId()==null||contract.getId()==0){
			request.setAttribute("msgStr", "输入的信息不完整。");
			return SUCCESS;
		}

		Session s = HibernateSessionFactory.getSession();
		Transaction tx = null;

		try {
			tx = s.beginTransaction();
			Contract c = (Contract) s.get(Contract.class, contract.getId());
			if(c==null){
				request.setAttribute("msgStr", "合同不存在。");
				return SUCCESS;
			}

			String planStr = contract.getPlanList();
			JSONArray jarr = JSONArray.fromObject(planStr);
			JSONArray yarr = JSONArray.fromObject(c.getPlanList());//原约定

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

			Query q_del = s.createQuery("delete from ChargePlan where contractId=:id and feeType like '%plan%' and time >=:date and isClear=false");
			q_del.setInteger("id", c.getId());

			String dept = c.getBranchFirm();
			Query q_clearTime = s.createQuery("from ClearTime where department=:dept ");
			q_clearTime.setString("dept", dept);
			ClearTime clearTime = (ClearTime) q_clearTime.uniqueResult();

			Calendar clearMonthBegin = Calendar.getInstance();
			clearMonthBegin.setTime(clearTime.getCurrent());
			clearMonthBegin.add(Calendar.MONTH, -1);
			clearMonthBegin.set(Calendar.DATE, 27);

			q_del.setDate("date", clearMonthBegin.getTime());
			q_del.executeUpdate();

			Query q_add = s.createQuery("select count(*) from ChargePlan where feeType not like '%plan_%' and feeType like '%add%' and contractId=:cid");
			q_add.setInteger("cid", c.getId());
			long size = (long) q_add.uniqueResult();

			Date c_endDate = c.getContractEndDate();

			if(size>0){
				//已开始计费
				Contract newContract = new Contract();
				newContract.setId(c.getId());
				newContract.setContractEndDate(clearMonthBegin.getTime());
				this.discountContractEndTime(s, c, newContract);

				contract.setContractEndDate(c_endDate);
				contract.setPlanList(planStr);
				this.enlongContractEndDate(s, c, contract);
			}else{
				c.setContractEndDate(c.getContractBeginDate());

				contract.setContractEndDate(c_endDate);
				contract.setPlanList(planStr);
				this.enlongContractEndDate(s, c, contract);
			}

			tx.commit();
			request.setAttribute("msgStr", "操作成功。");
		} catch (HibernateException | ParseException e) {
			e.printStackTrace();
			if(tx!=null)
				tx.rollback();
			request.setAttribute("msgStr", "操作失败，原因是："+e.getMessage());
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return this.contractSelectById();
	}

	public String contractToExcel(){
		Short[] states = getContractStates();

		Session session = HibernateSessionFactory.getSession();

		String hql = "from Contract where state in (:states) ";

		if (!StringUtils.isEmpty(dept)&&!dept.startsWith("all")) {
			hql+= String.format("and branchFirm='%s' ", dept);
		}

		if (!StringUtils.isEmpty(idNum)) {
			hql+= String.format("and idNum like '%%%s%%' ", idNum);
		}

		if (!StringUtils.isEmpty(carNum)) {
			hql+= String.format("and carNum like '%%%s%%' ", carNum);
		}

		if (beginDateStart!=null) {
			hql+= String.format("and contractBeginDate >= :%s ", "beginDateStart");
		}

		if (beginDateEnd!=null) {
			hql+= String.format("and contractBeginDate <= :%s ", "beginDateEnd");
		}

		if (endDateStart!=null) {
			hql+= String.format("and contractEndDate >= :%s ", "endDateStart");
		}

		if (endDateEnd!=null) {
			hql+= String.format("and contractEndDate <= :%s ", "endDateEnd");
		}

		hql += " order by "+order;

		if (BooleanUtils.isFalse(rank)){
			hql += " desc ";
		}

		Query query = session.createQuery(hql);

		query.setParameterList("states", states);

		if (beginDateStart!=null) {
			query.setDate("beginDateStart", beginDateStart);
		}

		if (beginDateEnd!=null) {
			query.setDate("beginDateEnd", beginDateEnd);
		}

		if (endDateStart!=null) {
			query.setDate("endDateStart", endDateStart);
		}

		if (endDateEnd!=null) {
			query.setDate("endDateEnd", endDateEnd);
		}

		List<Contract> l = query.list();
		HibernateSessionFactory.closeSession();

		List<List<? extends Serializable>> datalist = new ArrayList<List<? extends Serializable>>();
		List<String> datasrc;
		datasrc = Arrays.asList("contracts");
		datalist.add(l);
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		return SUCCESS;
	}

//	private String zhuanbao_contractWrite() {
//		contract.setPhotoGuarantor(" ");
//
//		contract.setAccount(new BigDecimal(0));
//		boolean flag = contractService.contractWrite(contract);
//		if(!flag){
//			return ERROR;
//		}
//		contractService.changeState(contract,0);
//
//		Vehicle vehicle = new Vehicle();
//		vehicle.setCarframeNum(contract.getCarframeNum());
//
//		vehicle = vehicleService.selectById(vehicle);
//		vehicle.setState(1);
//
//		vehicle.setDriverId(contract.getIdNum());
//
//		flag &= vehicleService.updateVehicle(vehicle);
//
//		User user  = (User) session.getAttribute("user");
//		List<ChargePlan> chargePlans = ObjectAccess.query(ChargePlan.class, " contractId='"+contract.getContractFrom()+"'");
//		Contract beforeContract = (Contract)ObjectAccess.getObject("com.dz.module.contract.Contract",contract.getContractFrom());
//
//		for (ChargePlan chargePlan : chargePlans) {
//			if (!chargePlan.isClear()) {
//				ChargePlan plan = new ChargePlan();
//				try {
//					BeanUtils.copyProperties(plan, chargePlan);
//				} catch (IllegalAccessException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				} catch (InvocationTargetException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//				plan.setId(0);
//				plan.setRegister(user.getUname());
//				plan.setContractId(contract.getId());
//				chargeService.addChargePlan(plan);
//			}
//		}
//
//		String rentGrowEveryMonth = request.getParameter("rentEachMonth");
//		BatchPlan batchPlan = new BatchPlan();
//		batchPlan.setComment("转包上浮");
//		batchPlan.setContractIdList(Arrays.asList(contract.getId()));
//		batchPlan.setStartTime(contract.getContractBeginDate());
//		batchPlan.setEndTime(contract.getContractEndDate());
//		batchPlan.setFee(new BigDecimal(Double.parseDouble(rentGrowEveryMonth)));
//		batchPlan.setFeeType("plan_add_other");
//		batchPlan.setInTime(new Date());
//		batchPlan.setRegister(user.getUname());
//
//		flag &= chargeService.addBatchPlan(batchPlan, false);
//
//		if(!flag){
//			contractService.changeState(contract,3);
//			return ERROR;
//		}
//
//		return SUCCESS;
//	}

	public String contractIdUpdate(){
		Contract c  = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", contract.getId());
		c.setContractId(contract.getContractId());
		contractService.contractWrite(c);
		return SUCCESS;
	}

	private String data;

	public void setData(String data) {
		this.data = data;
	}

	public String getData() {
		return data;
	}

	public void contractSort() throws IOException {
		JSONArray jsonArray = JSONArray.fromObject(data);

		Session s = HibernateSessionFactory.getSession();
		Transaction tx = null;
		boolean isSuccess = true;
		String error_message = "";
		try {
			tx = s.beginTransaction();
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject pair = jsonArray.getJSONObject(i);
				int id = pair.getInt("id");
				String contractId = pair.getString("contractId");
				Contract c = (Contract) s.get(Contract.class,id);
				c.setContractId(contractId);
				s.update(c);
			}
			tx.commit();
		}catch (Exception ex){
			isSuccess = false;
			error_message = ex.getMessage();
		}finally {
			if (tx!=null){
				tx.rollback();
			}
			HibernateSessionFactory.closeSession();
		}

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter pw = response.getWriter();
		JSONObject result = new JSONObject();
		result.put("state",isSuccess);
		result.put("msg",error_message);
		pw.append(result.toString());
		pw.flush();
		pw.close();
	}

	public String contractAbandon(){
		Contract c = contractService.selectById(contract.getId());

		c.setAbandonedTime(contract.getAbandonedTime());
		c.setAbandonedUser(contract.getAbandonedUser());
		c.setAbandonedTimeControl(contract.getAbandonedTimeControl());
		c.setState((short) 1);

		Vehicle vehicle = new Vehicle();
		vehicle.setCarframeNum(contract.getCarframeNum());

		vehicle = vehicleService.selectById(vehicle);
		vehicle.setState(0);
		vehicle.setDriverId("");

		vehicleService.updateVehicle(vehicle);

		if (contractService.contractAbandon(c)) {
			return "abandoned";
		} else {
			return ERROR;
		}
	}

	public String contractSearchAllAvilable(){
		jsonObject = contractService.contractSearchAllAvilable();
		return "jsonObject";
	}

	private Boolean withoutPage;

	public void setWithoutPage(Boolean withoutPage) {
		this.withoutPage = withoutPage;
	}

	public Boolean getWithoutPage() {
		return withoutPage;
	}

	public String contractSearch(){
		int currentPage = getCurrentPage();

		Short[] states = getContractStates();

		Session session = HibernateSessionFactory.getSession();

		String hql = "from Contract where state in (:states) ";

		if (!StringUtils.isEmpty(dept)&&!dept.startsWith("all")) {
			hql+= String.format("and branchFirm='%s' ", dept);
		}

		if (!StringUtils.isEmpty(idNum)) {
			hql+= String.format("and idNum like '%%%s%%' ", idNum);
		}

		if (!StringUtils.isEmpty(carNum)) {
			hql+= String.format("and carNum like '%%%s%%' ", carNum);
		}

		if (beginDateStart!=null) {
			hql+= String.format("and contractBeginDate >= :%s ", "beginDateStart");
		}

		if (beginDateEnd!=null) {
			hql+= String.format("and contractBeginDate <= :%s ", "beginDateEnd");
		}

		if (endDateStart!=null) {
			hql+= String.format("and contractEndDate >= :%s ", "endDateStart");
		}

		if (endDateEnd!=null) {
			hql+= String.format("and contractEndDate <= :%s ", "endDateEnd");
		}

		hql += " order by "+order;

		if (BooleanUtils.isFalse(rank)){
			hql += " desc ";
		}

		Query query = session.createQuery(hql);
		Query query2 = session.createQuery("select count(*) "+hql);

		query.setParameterList("states", states);
		query2.setParameterList("states", states);

		if (beginDateStart!=null) {
			query.setDate("beginDateStart", beginDateStart);
			query2.setDate("beginDateStart", beginDateStart);
		}

		if (beginDateEnd!=null) {
			query.setDate("beginDateEnd", beginDateEnd);
			query2.setDate("beginDateEnd", beginDateEnd);
		}

		if (endDateStart!=null) {
			query.setDate("endDateStart", endDateStart);
			query2.setDate("endDateStart", endDateStart);
		}

		if (endDateEnd!=null) {
			query.setDate("endDateEnd", endDateEnd);
			query2.setDate("endDateEnd", endDateEnd);
		}

		Page page;
		if (withoutPage==null || !withoutPage){
			long count = (long)query2.uniqueResult();
			page = PageUtil.createPage(15, (int)count, currentPage);
			query.setFirstResult(page.getBeginIndex());
			query.setMaxResults(page.getEveryPage());
			request.setAttribute("page", page);
		}
		List<Contract> l = query.list();
		HibernateSessionFactory.closeSession();

		request.setAttribute("list", l);
		//request.setAttribute("currentPage", currentPage);

		return SUCCESS;
	}

	public String contractSearchAvilable(){
		int currentPage = getCurrentPage();
		Session session = HibernateSessionFactory.getSession();

		String hql = "from Contract where state in (0,1) ";

		if (!StringUtils.isEmpty(dept)&&!dept.startsWith("all")) {
			hql+= String.format("and branchFirm='%s' ", dept);
		}

		if (!StringUtils.isEmpty(idNum)) {
			hql+= String.format("and idNum like '%%%s%%' ", idNum);
		}

		if (!StringUtils.isEmpty(carNum)) {
			hql+= String.format("and carNum like '%%%s%%' ", carNum);
		}

		String innerCondition = " contractBeginDate >= contractEndDate ";

		if (beginDateStart!=null) {
			innerCondition += "or (contractBeginDate <= :beginDateStart and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) >= :beginDateStart ) ";
		}

		if (beginDateEnd!=null) {
			innerCondition += "or (contractBeginDate <= :beginDateEnd and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null && endDateStart !=null){
			innerCondition += "or (contractBeginDate >= :beginDateStart and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) <= :beginDateEnd ) ";
			innerCondition += "or (contractBeginDate <= :beginDateStart and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null || endDateStart !=null){
			hql += " and (" + innerCondition+ ") ";
		}


		Query query2 = session.createQuery("select count(*) "+hql);
		hql += " order by "+order;

		if (BooleanUtils.isFalse(rank)){
			hql += " desc ";
		}
		Query query = session.createQuery(hql);

		if (beginDateStart!=null) {
			query.setDate("beginDateStart", beginDateStart);
			query2.setDate("beginDateStart", beginDateStart);
		}

		if (beginDateEnd!=null) {
			query.setDate("beginDateEnd", beginDateEnd);
			query2.setDate("beginDateEnd", beginDateEnd);
		}

		long count = (long)query2.uniqueResult();

		Page page = PageUtil.createPage(15, (int)count, currentPage);

		query.setFirstResult(page.getBeginIndex());
		query.setMaxResults(page.getEveryPage());

		List<Contract> l = query.list();
		HibernateSessionFactory.closeSession();

		request.setAttribute("list", l);
		//request.setAttribute("currentPage", currentPage);
		request.setAttribute("page", page);
//		setUrl("/contract/search_result.jsp");
		return "selectToUrl";
	}

	public String contractToExcelAvliable(){
		Session session = HibernateSessionFactory.getSession();

		String hql = "from Contract where state in (0,1) ";

		if (!StringUtils.isEmpty(dept)&&!dept.startsWith("all")) {
			hql+= String.format("and branchFirm='%s' ", dept);
		}

		if (!StringUtils.isEmpty(idNum)) {
			hql+= String.format("and idNum like '%%%s%%' ", idNum);
		}

		if (!StringUtils.isEmpty(carNum)) {
			hql+= String.format("and carNum like '%%%s%%' ", carNum);
		}

		String innerCondition = " contractBeginDate >= contractEndDate ";

		if (beginDateStart!=null) {
			innerCondition += "or (contractBeginDate <= :beginDateStart and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) >= :beginDateStart ) ";
		}

		if (beginDateEnd!=null) {
			innerCondition += "or (contractBeginDate <= :beginDateEnd and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null && endDateStart !=null){
			innerCondition += "or (contractBeginDate >= :beginDateStart and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) <= :beginDateEnd ) ";
			innerCondition += "or (contractBeginDate <= :beginDateStart and (case when abandonedFinalTime is null then contractEndDate else abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null || endDateStart !=null){
			hql += " and (" + innerCondition+ ") ";
		}
		hql += " order by "+order;

		if (BooleanUtils.isFalse(rank)){
			hql += " desc ";
		}
		Query query = session.createQuery(hql);

		if (beginDateStart!=null) {
			query.setDate("beginDateStart", beginDateStart);
		}

		if (beginDateEnd!=null) {
			query.setDate("beginDateEnd", beginDateEnd);
		}

		List<Contract> l = query.list();
		HibernateSessionFactory.closeSession();

		List<List<? extends Serializable>> datalist = new ArrayList<List<? extends Serializable>>();
		List<String> datasrc;
		datasrc = Arrays.asList("contracts");
		datalist.add(l);
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		return SUCCESS;
	}

	public String searchRentFirstDivide(){
		int currentPage = getCurrentPage();

		Short[] states = getContractStates();

		Session session = HibernateSessionFactory.getSession();

		String select = "select new com.dz.module.contract.RentFirstAnaylse(" +
				"c.id as contractId," +
				"CONCAT(YEAR(c.contractBeginDate),'-',MONTH(c.contractBeginDate)) as begin_month," +
				"CONCAT(YEAR(c.contractEndDate),'-',MONTH(c.contractEndDate)) as end_month," +
				"c.carNum as carNum," +
				"c.branchFirm as dept," +
				"SUM(case when rd.money=NULL then 0.0 else rd.money end ) as total_money," +
				"COUNT(*) as total_months," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)>= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then 1 else 0 end)," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then rd.money else 0.0 end)," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)>= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then rd.money else 0.0 end)" +
				")  " +
				" from Contract c, RentFirstDivide rd " +
				"where c.state in (:states) and c.carframeNum = rd.carframeNum " +
				"and YEAR (rd.month)*12+MONTH(rd.month) >= " +
				" YEAR(c.contractBeginDate)*12+MONTH(c.contractBeginDate) " +
				"AND (( c.state=1 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.abandonedFinalTime)*12+MONTH(c.abandonedFinalTime) ) or " +
					"( c.state=0 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.contractEndDate)*12+MONTH(c.contractEndDate) ))" +
				"AND rd.money <> 0 ";

		String hql = "";

		if (!StringUtils.isEmpty(dept)&&!dept.startsWith("all")) {
			hql+= String.format("and c.branchFirm='%s' ", dept);
		}

		if (!StringUtils.isEmpty(idNum)) {
			hql+= String.format("and c.idNum like '%%%s%%' ", idNum);
		}

		if (!StringUtils.isEmpty(carNum)) {
			hql+= String.format("and c.carNum like '%%%s%%' ", carNum);
		}

		String innerCondition = " c.contractBeginDate >= c.contractEndDate ";

		if (beginDateStart!=null) {
			innerCondition += "or (c.contractBeginDate <= :beginDateStart and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) >= :beginDateStart ) ";
		}

		if (beginDateEnd!=null) {
			innerCondition += "or (c.contractBeginDate <= :beginDateEnd and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null && endDateStart !=null){
			innerCondition += "or (c.contractBeginDate >= :beginDateStart and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) <= :beginDateEnd ) ";
			innerCondition += "or (c.contractBeginDate <= :beginDateStart and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null || endDateStart !=null){
			hql += " and (" + innerCondition+ ") ";
		}

//		if (beginDateStart!=null) {
//			hql+= String.format("and c.contractBeginDate >= :%s ", "beginDateStart");
//		}
//
//		if (beginDateEnd!=null) {
//			hql+= String.format("and c.contractBeginDate <= :%s ", "beginDateEnd");
//		}
//
//		if (endDateStart!=null) {
//			hql+= String.format("and c.contractEndDate >= :%s ", "endDateStart");
//		}
//
//		if (endDateEnd!=null) {
//			hql+= String.format("and c.contractEndDate <= :%s ", "endDateEnd");
//		}

		String groupAndOrder = " GROUP BY c.id ";
		groupAndOrder += " order by c."+order;
		if (BooleanUtils.isFalse(rank)){
			groupAndOrder += " desc ";
		}

		Query query = session.createQuery(select + hql + groupAndOrder);
		Query query2 = session.createQuery("select count(*) from Contract c where c.state in (:states) "+hql);

		query.setParameterList("states", states);
		query2.setParameterList("states", states);

		if (beginDateStart!=null) {
			query.setDate("beginDateStart", beginDateStart);
			query2.setDate("beginDateStart", beginDateStart);
		}

		if (beginDateEnd!=null) {
			query.setDate("beginDateEnd", beginDateEnd);
			query2.setDate("beginDateEnd", beginDateEnd);
		}

//		if (endDateStart!=null) {
//			query.setDate("endDateStart", endDateStart);
//			query2.setDate("endDateStart", endDateStart);
//		}
//
//		if (endDateEnd!=null) {
//			query.setDate("endDateEnd", endDateEnd);
//			query2.setDate("endDateEnd", endDateEnd);
//		}

		long count = (long)query2.uniqueResult();

		Page page = PageUtil.createPage(15, (int)count, currentPage);

		query.setFirstResult(page.getBeginIndex());
		query.setMaxResults(page.getEveryPage());

		List<RentFirstDetail> l = query.list();
//		System.out.println(l);
		HibernateSessionFactory.closeSession();

		request.setAttribute("list", l);
		//request.setAttribute("currentPage", currentPage);
		request.setAttribute("page", page);
		return SUCCESS;
	}


	public String searchRentFirstDivideToExcel(){
		Short[] states = getContractStates();

		Session session = HibernateSessionFactory.getSession();

		String select = "select new com.dz.module.contract.RentFirstAnaylse(" +
				"c.id as contractId," +
				"CONCAT(YEAR(c.contractBeginDate),'-',MONTH(c.contractBeginDate)) as begin_month," +
				"CONCAT(YEAR(c.contractEndDate),'-',MONTH(c.contractEndDate)) as end_month," +
				"c.carNum as carNum," +
				"c.branchFirm as dept," +
				"SUM(case when rd.money=NULL then 0.0 else rd.money end ) as total_money," +
				"COUNT(*) as total_months," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)>= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then 1 else 0 end)," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then rd.money else 0.0 end)," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)>= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then rd.money else 0.0 end)" +
				")  " +
				" from Contract c, RentFirstDivide rd " +
				"where c.state in (:states) and c.carframeNum = rd.carframeNum " +
				"and YEAR (rd.month)*12+MONTH(rd.month) >= " +
				" YEAR(c.contractBeginDate)*12+MONTH(c.contractBeginDate) " +
				"AND (( c.state=1 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.abandonedFinalTime)*12+MONTH(c.abandonedFinalTime) ) or " +
				"( c.state=0 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.contractEndDate)*12+MONTH(c.contractEndDate) ))" +
				"AND rd.money <> 0 ";

		String hql = "";

		if (!StringUtils.isEmpty(dept)&&!dept.startsWith("all")) {
			hql+= String.format("and c.branchFirm='%s' ", dept);
		}

		if (!StringUtils.isEmpty(idNum)) {
			hql+= String.format("and c.idNum like '%%%s%%' ", idNum);
		}

		if (!StringUtils.isEmpty(carNum)) {
			hql+= String.format("and c.carNum like '%%%s%%' ", carNum);
		}

		String innerCondition = " c.contractBeginDate >= c.contractEndDate ";

		if (beginDateStart!=null) {
			innerCondition += "or (c.contractBeginDate <= :beginDateStart and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) >= :beginDateStart ) ";
		}

		if (beginDateEnd!=null) {
			innerCondition += "or (c.contractBeginDate <= :beginDateEnd and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null && endDateStart !=null){
			innerCondition += "or (c.contractBeginDate >= :beginDateStart and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) <= :beginDateEnd ) ";
			innerCondition += "or (c.contractBeginDate <= :beginDateStart and (case when c.abandonedFinalTime is null then c.contractEndDate else c.abandonedFinalTime end) >= :beginDateEnd ) ";
		}

		if (beginDateStart!=null || endDateStart !=null){
			hql += " and (" + innerCondition+ ") ";
		}

//		if (beginDateStart!=null) {
//			hql+= String.format("and c.contractBeginDate >= :%s ", "beginDateStart");
//		}
//
//		if (beginDateEnd!=null) {
//			hql+= String.format("and c.contractBeginDate <= :%s ", "beginDateEnd");
//		}
//
//		if (endDateStart!=null) {
//			hql+= String.format("and c.contractEndDate >= :%s ", "endDateStart");
//		}
//
//		if (endDateEnd!=null) {
//			hql+= String.format("and c.contractEndDate <= :%s ", "endDateEnd");
//		}

		String groupAndOrder = " GROUP BY c.id ";
		groupAndOrder += " order by c."+order;
		if (BooleanUtils.isFalse(rank)){
			groupAndOrder += " desc ";
		}

		Query query = session.createQuery(select + hql + groupAndOrder);

		query.setParameterList("states", states);

		if (beginDateStart!=null) {
			query.setDate("beginDateStart", beginDateStart);
		}

		if (beginDateEnd!=null) {
			query.setDate("beginDateEnd", beginDateEnd);
		}

//		if (endDateStart!=null) {
//			query.setDate("endDateStart", endDateStart);
//			query2.setDate("endDateStart", endDateStart);
//		}
//
//		if (endDateEnd!=null) {
//			query.setDate("endDateEnd", endDateEnd);
//			query2.setDate("endDateEnd", endDateEnd);
//		}
		List<RentFirstDetail> l = query.list();
//		System.out.println(l);
		HibernateSessionFactory.closeSession();

		List<String> datasrc = Arrays.asList("list");
		List datalist = Arrays.asList(l);
		String templatePath = "contract/rent_first_detail.xls";
		String outputName = "预付金摊销";
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		request.setAttribute("templatePath", templatePath);
		request.setAttribute("outputName", outputName);
		//request.setAttribute("currentPage", currentPage);
		return SUCCESS;
	}


	public void resetRentFirstDivide() throws IOException {
		int cid = contract.getId();
		String dateString = request.getParameter("resetMonth");
		int year = Integer.parseInt(dateString.split("-",2)[0]);
		int month = Integer.parseInt(dateString.split("-",2)[1]);

		Session hsession = null;
		Transaction tx = null;

		boolean isSuccess = false;
		String error_message = "";

		try_block:
		try {
			hsession = HibernateSessionFactory.getSession();
			tx = hsession.beginTransaction();

			Calendar toDate = Calendar.getInstance();
			toDate.set(Calendar.YEAR,year);
			toDate.set(Calendar.MONTH,month);
			toDate.set(Calendar.DATE,1);

			toDate.add(Calendar.MONTH,1);
			Contract c = (Contract) hsession.get(Contract.class,cid);
			if(c.getContractBeginDate()==null||c.getContractBeginDate().after(toDate.getTime())){
				error_message = "提前摊销月份不可早于合同起始日期";
				break try_block;
			}

			toDate.add(Calendar.MONTH,-1);
			if(c.getContractEndDate()==null||c.getContractEndDate().before(toDate.getTime())){
				error_message = "提前摊销月份不可迟于合同结束日期";
				break try_block;
			}

			if(c.getState()==1){
				if(c.getAbandonedFinalTime()==null||c.getAbandonedFinalTime().before(toDate.getTime())){
					error_message = "提前摊销月份不可迟于废业日期";
					break try_block;
				}
			}

			Query ncQuery = hsession.createQuery("select count(*) from Contract where contractFrom=:cid ");
			ncQuery.setInteger("cid",cid);
			long ncCount = (Long) ncQuery.uniqueResult();
			if(ncCount>0){
				error_message = "在该合同基础上已发生过转包，提前摊销请在新合同上进行";
				break try_block;
			}

			Query totalAccount = hsession.createQuery("select sum(money) from RentFirstDivide " +
					"where carframeNum=:carNo and YEAR(month)*12+MONTH(month)>=:monthRank ");
			Query clearAccount = hsession.createQuery("update RentFirstDivide set money=0 " +
					"where carframeNum=:carNo and YEAR(month)*12+MONTH(month)>:monthRank");
			Query resetAccount = hsession.createQuery("update RentFirstDivide set money=:total " +
					"where carframeNum=:carNo and YEAR(month)*12+MONTH(month)=:monthRank");

			totalAccount.setString("carNo",c.getCarframeNum());
			totalAccount.setInteger("monthRank",year*12+month);
			Number totalMoney = (Number)totalAccount.uniqueResult();

			clearAccount.setString("carNo",c.getCarframeNum());
			clearAccount.setInteger("monthRank",year*12+month);
			clearAccount.executeUpdate();

			resetAccount.setDouble("total",totalMoney.doubleValue());
			resetAccount.setString("carNo",c.getCarframeNum());
			resetAccount.setInteger("monthRank",year*12+month);
			resetAccount.executeUpdate();

			tx.commit();
			isSuccess = true;
		}catch (HibernateException ex){
			ex.printStackTrace();
			error_message = "数据处理失败，原因是："+ex.getMessage();
		}finally {
			HibernateSessionFactory.closeSession();
		}

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter pw = response.getWriter();
		JSONObject result = new JSONObject();
		result.put("state",isSuccess);
		result.put("msg",error_message);
		pw.append(result.toString());
		pw.flush();
		pw.close();
	}

	private Short[] getContractStates() {
		Short[] states={};
		String[] ss = request.getParameterValues("states");
		if(ss.length==1){
			ss = ss[0].split(",");
		}
		if(ss!=null){
			@SuppressWarnings("unchecked")
			List<Short> statelist = (List<Short>) CollectionUtils.collect(Arrays.asList(ss), new Transformer(){

				@Override
				public Object transform(Object input) {
					String str = (String)input;
					return Short.parseShort(str.trim());
				}

			});
			states = new Short[statelist.size()];
			states = statelist.toArray(states);
		}
		return states;
	}

	private int getCurrentPage() {
		int currentPage = 0;
		String currentPagestr = request.getParameter("currentPage");
		if(currentPagestr == null || "".equals(currentPagestr)){
			currentPage = 1;
		}else{
			currentPage=Integer.parseInt(currentPagestr);
		}
		return currentPage;
	}

	private Date beginDateStart,beginDateEnd,endDateStart,endDateEnd;
	private String dept,carNum,idNum,order;
	private boolean rank;

	public Date getBeginDateStart() {
		return beginDateStart;
	}

	public void setBeginDateStart(Date beginDateStart) {
		this.beginDateStart = beginDateStart;
	}

	public Date getBeginDateEnd() {
		return beginDateEnd;
	}

	public void setBeginDateEnd(Date beginDateEnd) {
		this.beginDateEnd = beginDateEnd;
	}

	public Date getEndDateStart() {
		return endDateStart;
	}

	public void setEndDateStart(Date endDateStart) {
		this.endDateStart = endDateStart;
	}

	public Date getEndDateEnd() {
		return endDateEnd;
	}

	public void setEndDateEnd(Date endDateEnd) {
		this.endDateEnd = endDateEnd;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getCarNum() {
		return carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	public String getIdNum() {
		return idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public boolean isRank() {
		return rank;
	}

	public void setRank(boolean rank) {
		this.rank = rank;
	}

	public void contractValidCount() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		Short[] states={0,-1};
		int total = contractService.selectAllByStatesCount(null, null, null, null, null, states);

		out.print(total);

		out.flush();
		out.close();
	}

	private int addType;

	public String contractSelectById(){
		Contract vm  = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", contract.getId());
		this.setContract(vm);
		this.driver = (Driver) ObjectAccess.getObject("com.dz.module.driver.Driver", contract.getIdNum());

		if(BooleanUtils.isTrue(contract.getGeneByImport())){
			//自动导入的合同
			addType=1;
		}else if(contract.getContractFrom()==null){
			//新车开业
			addType=2;
		}else{
			//车辆转包
			addType=3;
		}

		return SUCCESS;
	}

	public String contractPreAdd(){
		Contract vm  = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", contract.getId());
		this.setContract(vm);
		this.driver = (Driver) ObjectAccess.getObject("com.dz.module.driver.Driver", contract.getIdNum());

		if(vm==null||vm.getState()!=3){
			url = "/contract/contract_new_context.jsp";
			return SUCCESS;
		}

		if(BooleanUtils.isTrue(contract.getGeneByImport())){
			//自动导入的合同
			addType=1;
		}else if(contract.getContractFrom()==null){
			//新车开业
			addType=2;
		}else{
			//车辆转包
			addType=3;
		}

		url = String.format("/contract/contractAdd%d.jsp", addType);

		return SUCCESS;
	}

	public void selectByCarId() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		Contract c = contractService.selectByCarId(contract.getCarframeNum());

		JSONObject json = JSONObject.fromObject(c);

		out.print(json.toString());

		out.flush();
		out.close();
	}

	public Object getJsonObject() {
		return jsonObject;
	}

	public void setJsonObject(Object jsonObject) {
		this.jsonObject = jsonObject;
	}

	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getAddType() {
		return addType;
	}

	public void setAddType(int addType) {
		this.addType = addType;
	}

	public static void main(String[] args){
		ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		HibernateSessionFactory.rebuildSessionFactory(applicationContext);

		String hql = "select new com.dz.module.contract.RentFirstAnaylse(" +
				"c.id as contractId," +
				"CONCAT(YEAR(c.contractBeginDate),'-',MONTH(c.contractBeginDate)) as begin_month," +
				"CONCAT(YEAR(c.contractEndDate),'-',MONTH(c.contractEndDate)) as end_month," +
				"c.carNum as carNum," +
				"c.branchFirm as dept," +
				"SUM(case when rd.money=NULL then 0.0 else rd.money end ) as total_money," +
				"COUNT(*) as total_months," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)>= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then 1 else 0 end)," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then rd.money else 0.0 end)," +
				"sum(case when YEAR (CURRENT_DATE)*12+MONTH(CURRENT_DATE)>= YEAR(rd.month)*12+MONTH(rd.month) " +
				"then rd.money else 0.0 end)" +
				")  " +
				"from Contract c , RentFirstDivide rd " +
				"where  c.carframeNum = rd.carframeNum  " +
				"and YEAR (rd.month)*12+MONTH(rd.month) >=  " +
				" YEAR(c.contractBeginDate)*12+MONTH(c.contractBeginDate) " +
				"AND (( c.state=1 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.abandonedFinalTime)*12+MONTH(c.abandonedFinalTime) ) or " +
				"( c.state=0 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.contractEndDate)*12+MONTH(c.contractEndDate) ))" +
				"AND rd.money <> 0 " +
				"group by c.id ";

		Session hsession = HibernateSessionFactory.getSession();
		Query query = hsession.createQuery(hql);
		List<RentFirstDetail> details = query.list();
		for (RentFirstDetail detail : details) {
			System.out.println(detail);
		}
		hsession.close();
	}
}
