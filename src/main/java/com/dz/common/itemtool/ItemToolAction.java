package com.dz.common.itemtool;

import com.opensymphony.xwork2.ActionSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
@Scope("prototype")
public class ItemToolAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	@Autowired
	private ItemToolService service ;
	private ItemTool item;
	//for ajax
	private String ajax_message;
	private List<ItemTool> jsonObject;
	private static final String SELECTRESULT = "select_result";
	private static final String ADCRESULT = "adc_result";
	
	public String selectItem(){
		jsonObject = service.selectByKey(item);
		return SELECTRESULT;
	}
	public String removeItem(){
		if(service.removeItem(item)){
			ajax_message = SUCCESS;
		}else{
			ajax_message = "删除失败";
		}
		return ADCRESULT;
	}
	public String addItem(){
		if(service.addItem(item)){
			ajax_message =  SUCCESS;
		}else{
			ajax_message = "添加失败";
		}
		return ADCRESULT;
	}
	
	public String changeItem(){
		if(service.changeItem(item)){
			ajax_message = SUCCESS;
		}else{
			ajax_message = "修改失败";
		}
		return ADCRESULT;
	}
	
	public ItemToolService getService() {
		return service;
	}

	public void setService(ItemToolService service) {
		this.service = service;
	}
	
	public List<ItemTool> getJsonObject() {
		return jsonObject;
	}
	public void setJsonObject(List<ItemTool> jsonObject) {
		this.jsonObject = jsonObject;
	}
	public ItemTool getItem() {
		return item;
	}
	public void setItem(ItemTool item) {
		this.item = item;
	}
	
	public String getAjax_message() {
		return ajax_message;
	}
	public void setAjax_message(String ajax_message) {
		this.ajax_message = ajax_message;
	}
}
