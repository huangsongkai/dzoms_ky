package com.dz.module.vehicle.check;

import com.dz.common.global.TimePass;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.ActionSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * @author doggy
 *         Created on 15-10-14.
 */
@Controller
@Scope(value = "prototype")
public class SelfCheckPlanAction extends ActionSupport {
    /**
	 * 
	 */
	private static final long serialVersionUID = -2729417507325605487L;
	private static final String JSONOBJECT = "jsonObject";
    private SelfCheckPlan plan;
    private List<String> carIds;
    private Vehicle vehicle;
    private String unPassReason;
    private TimePass timePass;
    private String ajax_message;
    private Object jsonObject;
    @Autowired
    private SelfCheckPlanService service;
    /**
     * Add a new plan.
     */
    public String selfCheckPlanAdd(){
        System.out.println(plan);
        if(service.addOne(plan,carIds)){
            ajax_message = SUCCESS;
        }else{
            ajax_message = ERROR;
        }
        return "ajax_message";
    }
    /**
     * Remove a plan.
     */
    public String selfCheckPlanRemove(){
        if(service.removeOne(plan)){
            ajax_message = SUCCESS;
        }else{
            ajax_message = ERROR;
        }
        return "ajax_message";
    }
    /**
     * Update a plan.
     */
    public String selfCheckPlanUpdate(){
        if(service.updateOne(plan,carIds)){
            ajax_message = SUCCESS;
        }else{
            ajax_message = ERROR;
        }
        return "ajax_message";
    }

    /**
     * Unpass a check.
     */
    public String selfCheckPlanUnPass(){
        if(service.disPass(plan,vehicle.getCarframeNum(),unPassReason)){
            ajax_message = SUCCESS;
        }else{
            ajax_message = ERROR;
        }
        return "ajax_message";
    }
    public String selfCheckPlanPass(){
        if(service.pass(plan,vehicle.getCarframeNum())){
            ajax_message = SUCCESS;
        }else{
            ajax_message = ERROR;
        }
        return "ajax_message";
    }
    /**
     * Select plan by id.
     */
    public String selfCheckPlanSelectById(){
        jsonObject = service.selectPlanById(plan);
        return JSONOBJECT;
    }
    /**
     * Get pageshows by plan.
     */
    public String selfCheckPlanSelectGetPageShowByPlan(){
        jsonObject = service.getPageShowByPlan(plan);
        return JSONOBJECT;
    }
    public String selfCheckPlanSearchPlan(){
        jsonObject = service.searchPlan(timePass);
        return JSONOBJECT;
    }
    public String selfCheckPlanSelectDisPass(){
        jsonObject = service.selectDisPass(plan);
        return JSONOBJECT;
    }
    public SelfCheckPlanService getService() {
        return service;
    }

    public void setService(SelfCheckPlanService service) {
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

    public SelfCheckPlan getPlan() {
        return plan;
    }

    public void setPlan(SelfCheckPlan plan) {
        this.plan = plan;
    }

    public TimePass getTimePass() {
        return timePass;
    }

    public void setTimePass(TimePass timePass) {
        this.timePass = timePass;
    }

    public List<String> getCarIds() {
        return carIds;
    }

    public void setCarIds(List<String> carIds) {
        this.carIds = carIds;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public String getUnPassReason() {
        return unPassReason;
    }

    public void setUnPassReason(String unPassReason) {
        this.unPassReason = unPassReason;
    }
}
