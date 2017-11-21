package com.dz.module.driver.accident;

import com.opensymphony.xwork2.ActionSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
@Scope(value = "prototype")
public class ACLAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private static final String JSONMESSAGE = "json_message";
	private static final String JSONOBJECT = "jsonObject";
	private Accident accident;
	private CarLoss loss;
	@Autowired
	private ACLService service;
	private Object jsonObject;
	private String ajax_message;
	public String addOne(){
		service.addOne(accident, loss);
		ajax_message = ""+loss.getClId();
		return JSONMESSAGE;
	}
	public String removeOne(){
		service.removeOne(accident, loss);
		ajax_message = SUCCESS;
		return JSONMESSAGE;
	}
	//返回甲方车辆损失
	public String search_0() {
		List<CarLoss> list = service.search(accident, 0);
		jsonObject = list;
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
	public CarLoss getLoss() {
		return loss;
	}
	public void setLoss(CarLoss loss) {
		this.loss = loss;
	}
	public ACLService getService() {
		return service;
	}
	public void setService(ACLService service) {
		this.service = service;
	}

	public String getAjax_message() {
		return ajax_message;
	}

	public void setAjax_message(String ajax_message) {
		this.ajax_message = ajax_message;
	}

	public Object getJsonObject() {

		return jsonObject;
	}

	public void setJsonObject(Object jsonObject) {
		this.jsonObject = jsonObject;
	}
}
