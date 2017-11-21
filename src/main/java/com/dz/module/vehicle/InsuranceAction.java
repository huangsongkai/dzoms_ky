package com.dz.module.vehicle;

import java.util.List;

import javax.servlet.http.Cookie;

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
			Query q = s.createQuery("update Insurance set state=1 where state=0");
			q.executeUpdate();
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
