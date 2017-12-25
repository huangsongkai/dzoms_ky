package com.dz.module.vehicle.electric;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.other.ObjectAccess;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.service.ServiceDetail;
import com.dz.module.vehicle.service.ServiceError;
import com.dz.module.vehicle.service.ServiceSpace;

@Controller
@Scope(value="prototype")
public class ElectricAction extends BaseAction {
	@Autowired
	private ElectricService electricService;
	
	private String carList;
	
	public void fecth() throws IOException{
		ElectricFetch electricFetch = new ElectricFetch();
		electricFetch.setFetchTime(new Date());
		String[] slist = StringUtils.split(carList, ",");
		electricFetch.setFetchNum(slist.length);
		ObjectAccess.saveOrUpdate(electricFetch);
		
		for(String cno : slist){
			Vehicle v = (Vehicle) ObjectAccess.getObject(Vehicle.class, cno);
			if(v!=null){
				try {
					electricService.fetch(v, electricFetch.getId());
				} catch (IOException e) {
					e.printStackTrace();
				}
				v.setElectricLastTime(electricFetch.getFetchTime());
				ObjectAccess.saveOrUpdate(v);
			}
		}
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print("true");
		out.flush();
		out.close();
	}
	
	public void fecthAll() throws IOException{
		ElectricFetch electricFetch = new ElectricFetch();
		electricFetch.setFetchTime(new Date());
		
		if(condition==null)
			condition="";
		List<Vehicle> l = ObjectAccess.query(Vehicle.class," 1=1 " + condition);
		
		electricFetch.setFetchNum(l.size());
		ObjectAccess.saveOrUpdate(electricFetch);
		
		for(Vehicle v : l){
			if(v!=null){
				try {
					electricService.fetch(v, electricFetch.getId());
				} catch (IOException e) {
					e.printStackTrace();
				}
				v.setElectricLastTime(electricFetch.getFetchTime());
				ObjectAccess.saveOrUpdate(v);
			}
		}
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print("true");
		out.flush();
		out.close();
	}
	
	public String exportToExcel(){
		List<List<? extends Serializable>> datalist = new ArrayList<List<? extends Serializable>>();
		List<String> datasrc;
		datasrc = Arrays.asList("historys");
		//TODO 添加日期范围
//		List<ElectricHistory> l = ObjectAccess.query(ElectricHistory.class,String.format("date >= STR_TO_DATE('%tF 00:00','%%Y-%%m-%%d %%H:%%i') "
//	    		+ " and date <= STR_TO_DATE('%tF 23:59','%%Y-%%m-%%d %%H:%%i') ", beginDate,endDate));
		if(condition==null)
			condition="";
		
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("select h " +  condition);
			
		List<ElectricHistory> l = query.list();
		datalist.add(l);
		
		HibernateSessionFactory.closeSession();
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		return SUCCESS;
	}
	
	private Date beginDate,endDate;
	
	private String condition;
	
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

	public ElectricService getElectricService() {
		return electricService;
	}

	public void setElectricService(ElectricService electricService) {
		this.electricService = electricService;
	}

	public String getCarList() {
		return carList;
	}

	public void setCarList(String carList) {
		this.carList = carList;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
}
