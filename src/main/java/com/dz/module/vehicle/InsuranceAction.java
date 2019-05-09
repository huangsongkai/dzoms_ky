package com.dz.module.vehicle;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.Cookie;

import com.dz.module.contract.ContractTemplate2;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.module.driver.Driver;

@Controller
@Scope("prototype")
public class InsuranceAction extends BaseAction{
	@Autowired
	private InsuranceService insuranceService;
	private Insurance insurance;
	private Vehicle vehicle;
	private Driver driver;
	
	public String addInsurance() {
		try{
			insurance.setState(0);
			insuranceService.addInsurance(insurance);
			Cookie cookie;
			if(insurance.getInsuranceClass().equals("交强险")){
				cookie = new Cookie("jqx", insurance.getInsuranceNum());
			}else if(insurance.getInsuranceClass().equals("商业保险单")){
				cookie = new Cookie("sx", insurance.getInsuranceNum());
			}else{
				cookie = new Cookie("cyrx", insurance.getInsuranceNum());
			}
						
			cookie.setMaxAge(24*60*60*30); //一个月内有效
			response.addCookie(cookie);
		}catch(Exception e){
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}
		request.setAttribute("msgStr", "添加成功。");
		return SUCCESS;
	}
	
	public String relookInsurance(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
//			Query q = s.createQuery("update Insurance set state=1 where state=0");
			Query qx = s.createQuery("from Insurance where state=0");

			List<Insurance> list = qx.list();
			for (Insurance insurance1 : list) {
				if (insurance1.getInsuranceClass().equals("商业保险单")){
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(insurance1.getBeginDate());
					int beginYear = calendar.get(Calendar.YEAR),beginMonth = calendar.get(Calendar.MONTH),beginDate = calendar.get(Calendar.DATE);
					calendar.setTime(insurance1.getEndDate());
					int endYear = calendar.get(Calendar.YEAR),endMonth = calendar.get(Calendar.MONTH),endDate = calendar.get(Calendar.DATE);

					int local_months = (endYear - beginYear) * 12 + (endMonth - beginMonth)+(beginDate<27?1:0)+(endDate>26?1:0);
					int beginRank = beginYear * 12 + beginMonth + (beginDate>26?1:0) + 1; //最后的+1 是因为Calendar 的Month从0开始

					int totalDays = ContractTemplate2.TemplatePage.calDateSpan(insurance1.getBeginDate(),insurance1.getEndDate());
					BigDecimal moneyPerDay = vehicle.getInsuranceBase().divide(BigDecimal.valueOf(totalDays),RoundingMode.HALF_EVEN);
					int totalMoney = 0;
					vehicle = (Vehicle) s.get(Vehicle.class,insurance1.getCarframeNum());
					for (int i=1;i<local_months-1;i++) {
						double money = moneyPerDay.multiply(BigDecimal.valueOf(30)).setScale(0,RoundingMode.HALF_DOWN).doubleValue();
						totalMoney += money;
						InsuranceDivide2 divide = new InsuranceDivide2(beginRank+i,insurance1.getId(), money);
						s.saveOrUpdate(divide);
					}

					int days = 0;
					if(local_months==1){
						//这一段时间在一个月里面

//						if(beginDate==27&&endDate==26){
//							days=30;
//						}else
//						if(beginDate>26){
//							if(endDate>26){
//								days = endDate - beginDate + 1;
//							}else{
//								//days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginDate+1+parseInt(endDate);
//								days = 31 - beginDate + endDate + (beginDate>30?1:0);
//							}
//						}else{
//							days = endDate - beginDate + 1;
//						}
//						BigDecimal planOfRent = moneyPerDay.multiply(BigDecimal.valueOf(days)) ;
//						InsuranceDivide2 divide = new InsuranceDivide2(beginRank,insurance1.getId(),planOfRent.doubleValue());
						InsuranceDivide2 divide = new InsuranceDivide2(beginRank,insurance1.getId(),vehicle.getInsuranceBase().doubleValue());
						s.saveOrUpdate(divide);
					}else{
						//这一段时间分属不同的月
						//第一个月
						if(beginDate==27){
							days=30;
						}else if(beginDate>27){
							//days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginDate+27;
							days = 57 - beginDate + (beginDate>30?1:0);
						}else{
							days = 27 - beginDate;
						}
						BigDecimal planOfRent = moneyPerDay.multiply(BigDecimal.valueOf(days)).setScale(0,RoundingMode.HALF_DOWN);
						totalMoney += planOfRent.intValue();
						InsuranceDivide2 divide = new InsuranceDivide2(beginRank,insurance1.getId(),planOfRent.doubleValue());
						s.saveOrUpdate(divide);

						//最后一个月
//						if(endDate==26){
//							days=30;
//						}else if(endDate>=30){
//							days = 4;
//						}else if(endDate>26){
//							days = endDate - 26;
//						}else{
//							//days = parseInt(getDaysOfMonth(endArr[0],endArr[1]-1))+parseInt(endDate)-26;
//							days = 4 + endDate;
//						}
//						planOfRent = moneyPerDay.multiply(BigDecimal.valueOf(days-1)) ;
//						divide = new InsuranceDivide2(beginRank+local_months-1,insurance1.getId(),planOfRent.doubleValue());
						planOfRent = vehicle.getInsuranceBase().subtract(BigDecimal.valueOf(totalDays));
						divide = new InsuranceDivide2(beginRank+local_months-1,insurance1.getId(),planOfRent.doubleValue());
						s.saveOrUpdate(divide);
					}
				}
				insurance1.setState(1);
				s.update(insurance1);
			}
//			q.executeUpdate();
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "操作失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}
	
	public String revokeInsurance(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Insurance v = (Insurance) s.get(Insurance.class, insurance.getId());
			if(v == null||v.getState()!=1){
				request.setAttribute("msgStr", "回退失败。");
				return SUCCESS;
			}else{
				v.setState(0);
				s.saveOrUpdate(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	
	public String updateInsurance() {
		try{
			insuranceService.updateInsurance(insurance);
		}catch(Exception e){
			return ERROR;
		}
		return SUCCESS;
	}

	
	public String deleteInsurance() {
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Insurance v = (Insurance) s.get(Insurance.class, insurance.getId());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String selectByCondition(){
		int currentPage = 0;
        String currentPagestr = request.getParameter("currentPage");
        if(currentPagestr == null || "".equals(currentPagestr)){
        	currentPage = 1;
        }else{
        	currentPage=Integer.parseInt(currentPagestr);
        }
       //vehicle.setCarMode("123");
       Page page = PageUtil.createPage(15, insuranceService.selectByConditionCount(insurance,vehicle), currentPage);
		List<Insurance> l = insuranceService.selectByCondition(page, insurance,vehicle);
		request.setAttribute("insurance", l);
		//request.setAttribute("currentPage", currentPage);
		request.setAttribute("page", page);
		return SUCCESS;
	}
	
	
	
	public String insuranceSelectById(){
		this.insurance = (Insurance) ObjectAccess.getObject(Insurance.class, insurance.getId());
		return SUCCESS;
	}
	
	public List<Insurance> selectAll() {
		return insuranceService.selectAll();
	}

	
	public List<Insurance> selectByVehicle() {
		return insuranceService.selectByVehicle(vehicle);
	}

	
	public List<Insurance> selectByDriver() {
		return insuranceService.selectByDriver(driver);
	}


	public Insurance getInsurance() {
		return insurance;
	}


	public Vehicle getVehicle() {
		return vehicle;
	}


	public Driver getDriver() {
		return driver;
	}


	public void setInsuranceService(InsuranceService insuranceService) {
		this.insuranceService = insuranceService;
	}


	public void setInsurance(Insurance insurance) {
		this.insurance = insurance;
	}


	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}


	public void setDriver(Driver driver) {
		this.driver = driver;
	}
	

}
