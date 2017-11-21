package com.dz.module.driver.accident;

import com.opensymphony.xwork2.ActionSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
@Controller
@Scope(value = "prototype")
public class APLAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private static final String JSONMESSAGE = "json_message";
	private static final String JSONOBJECT = "jsonObject";
	private Object jsonObject;
	private String ajax_message;
	private Accident accident;
	private PeopleLoss loss;
	@Autowired
	private APLService service;
	public String addOne(){
		service.addOne(accident, loss);
		ajax_message = ""+loss.getPlId();
		return JSONMESSAGE;
	}
	public String removeOne(){
		service.removeOne(accident, loss);
		ajax_message = SUCCESS;
		return JSONMESSAGE;
	}
	//返回甲方人员损失
	public String search_0() {
		jsonObject = service.search(accident, 0);
		return JSONOBJECT;
	}
	public String search_1() {
		jsonObject = service.search(accident, 1);
		return JSONOBJECT;
	}
	public Accident getAccident() {
		return accident;
	}
	public void setAccident(Accident accident) {
		this.accident = accident;
	}
	public PeopleLoss getLoss() {
		return loss;
	}
	public void setLoss(PeopleLoss loss) {
		this.loss = loss;
	}
	public APLService getService() {
		return service;
	}
	public void setService(APLService service) {
		this.service = service;
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
}
