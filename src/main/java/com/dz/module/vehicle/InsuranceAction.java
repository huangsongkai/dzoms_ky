package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.module.driver.Driver;
import net.sf.json.JSONObject;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.Cookie;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.function.Function;

@Controller
@Scope("prototype")
public class InsuranceAction extends BaseAction{
	@Autowired
	private InsuranceService insuranceService;
	@Autowired
	private MailReceiver mailReceiver;

	private Insurance insurance;
	private Vehicle vehicle;
	private Driver driver;

    private Object jsonObject;
    private String ajax_message;
	
	public String addInsurance() {
		try{
//			insurance.setState(0);
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

	public void checkInsuranceDivide() throws IOException{
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();

        Session session = HibernateSessionFactory.getSession();
        boolean checked = insuranceService.checkInsuranceDivide(session,vehicle.getCarframeNum(),insurance.getBeginDate());

        JSONObject json = new JSONObject();
        json.put("result",checked);
        out.print(json.toString());
        out.flush();
        out.close();
    }
	
	public String relookInsurance(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
//			Query q = s.createQuery("update Insurance set state=1 where state=0");
			Query qx = s.createQuery("from Insurance where state!=1");

			List<Insurance> list = qx.list();
			for (Insurance insurance1 : list) {
				if ("商业保险单".equals(insurance1.getInsuranceClass()) && insurance1.getState()==3){
					vehicle = (Vehicle) s.get(Vehicle.class, insurance1.getCarframeNum());
					if(vehicle.getInsuranceBase()!=null && vehicle.getInsuranceBase().compareTo(BigDecimal.ZERO)>0){
						InsuranceService.makeDivide(s, insurance1, vehicle.getInsuranceBase());
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

	public void remakeDivide() throws IOException{
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		Session session = HibernateSessionFactory.getSession();
		//TODO 重新生成摊销

		JSONObject json = new JSONObject();
		json.put("result",true);
		out.print(json.toString());
		out.flush();
		out.close();
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
			if(v == null||(v.getState()!=0 && v.getState()!=3)){
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

	private Date inputFrom,inputEnd,startFrom,startEnd;
	public String selectByCondition(){
		int currentPage = 0;
        String currentPagestr = request.getParameter("currentPage");
        if(currentPagestr == null || "".equals(currentPagestr)){
        	currentPage = 1;
        }else{
        	currentPage=Integer.parseInt(currentPagestr);
        }

       //vehicle.setCarMode("123");
       Page page = PageUtil.createPage(15, insuranceService.selectByConditionCount(insurance,vehicle,inputFrom,inputEnd,startFrom,startEnd), currentPage);
		List<Insurance> l = insuranceService.selectByCondition(page, insurance,vehicle,inputFrom,inputEnd,startFrom,startEnd);
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

	public String loadConfig(){
		mailReceiver.loadConfig();
        jsonObject = mailReceiver.config;
		return "jsonresult";
	}

	Boolean enabled;
	String protocol = "pop3";
	int port;
	String host;
	String email;
	String password;
	String sender;
	Boolean readAll;
	Boolean updateState;
	Boolean override;

	private static <T> void checkEqualOrUpdate(Query query, String key, T value, T rawValue, Function<T,String> toString)
			throws HibernateException{
		if (value != null && !value.equals(rawValue)){
			query.setString("key", key);
			query.setString("value", toString.apply(value));
			query.executeUpdate();
		}
	}

	public String updateConfig() {
		mailReceiver.loadConfig();
		MailReceiver.MailReceiverConfig config = mailReceiver.config;
		Session s = null;
		Transaction tx = null;
		ajax_message = "修改成功！";
		try {
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createSQLQuery("UPDATE `sys_config` SET `value` = :value WHERE `key` = :key");
			checkEqualOrUpdate(query,"mail.enabled",enabled,config.enabled, Object::toString);
			checkEqualOrUpdate(query,"mail.store.protocol",protocol,config.protocol, Function.identity());
			checkEqualOrUpdate(query,"mail.pop3.port",port,config.port, Objects::toString);
			checkEqualOrUpdate(query,"mail.pop3.host",host,config.host,Function.identity());
			checkEqualOrUpdate(query,"mail.email",email,config.email,Function.identity());
			checkEqualOrUpdate(query,"mail.password",password,config.password,Function.identity());
			checkEqualOrUpdate(query,"mail.sender",sender,config.sender,Function.identity());
			checkEqualOrUpdate(query,"strategy.readAll",readAll,config.readAll,Objects::toString);
			checkEqualOrUpdate(query,"strategy.updateState",updateState,config.updateState,Objects::toString);
			checkEqualOrUpdate(query,"strategy.override",override,config.override,Objects::toString);

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
            ajax_message = "修改失败，原因是：" + e.getMessage();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return "stringresult";
	}

	public String manualDoReceive() {
		mailReceiver.doReceive(true);
        ajax_message = "任务已开始！";
        return "stringresult";
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

	public Date getInputFrom() {
		return inputFrom;
	}

	public void setInputFrom(Date inputFrom) {
		this.inputFrom = inputFrom;
	}

	public Date getInputEnd() {
		return inputEnd;
	}

	public void setInputEnd(Date inputEnd) {
		this.inputEnd = inputEnd;
	}

	public Date getStartFrom() {
		return startFrom;
	}

	public void setStartFrom(Date startFrom) {
		this.startFrom = startFrom;
	}

	public Date getStartEnd() {
		return startEnd;
	}

	public void setStartEnd(Date startEnd) {
		this.startEnd = startEnd;
	}

	public void setMailReceiver(MailReceiver mailReceiver) {
		this.mailReceiver = mailReceiver;
	}

    public InsuranceService getInsuranceService() {
        return insuranceService;
    }

    public MailReceiver getMailReceiver() {
        return mailReceiver;
    }

    public Object getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(Object jsonObject) {
        this.jsonObject = jsonObject;
    }

    public String getAjax_message() {
        return ajax_message;
    }

    public void setAjax_message(String ajax_message) {
        this.ajax_message = ajax_message;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public Boolean getReadAll() {
        return readAll;
    }

    public void setReadAll(Boolean readAll) {
        this.readAll = readAll;
    }

    public Boolean getUpdateState() {
        return updateState;
    }

    public void setUpdateState(Boolean updateState) {
        this.updateState = updateState;
    }

    public Boolean getOverride() {
        return override;
    }

    public void setOverride(Boolean override) {
        this.override = override;
    }
}
