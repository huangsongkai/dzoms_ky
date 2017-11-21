package com.dz.module.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author doggy
 *         Created on 16-3-16.
 */
@Controller("managerAction")
@Scope("prototype")
public class ManagerAction extends ActionSupport{
    private static String MESSAGE = "message";
    private static String DISPATCH = "dispatch";
    @Autowired
    @Qualifier("managerService")
    private ManagerService service;
    private User user;
    private int[] roleIds;
    private Object jsonObject;
    private String jspPage;
    private String dispatchUrl;

    public String addUser(){
        service.addUser(user);
        jspPage="adduser.jsp";
        return SUCCESS;
    }
    public String deleteUser(){
        service.deleteUser(user);
        dispatchUrl = "selectAllUsers";
        return DISPATCH;
    }
    public String selectAllUsers(){ 
    	ActionContext ac = ActionContext.getContext();
    	Map<String,Object> request = (Map)(ac.get("request"));
    	request.put("users", service.searchAllUser());
    	jspPage = "user_search.jsp";
        return SUCCESS;
    }
    public String assignAuthority(){
        System.out.println(roleIds.length);
        service.assignAuthority(user,roleIds);
        dispatchUrl = "selectAllUsers";
        return DISPATCH;
    }
    public String getAuthoritiesByUser(){
        jsonObject = service.searchAuthoritiesByUser(user);
        return MESSAGE;
    }


    public ManagerService getService() {
        return service;
    }

    public ManagerAction setService(ManagerService service) {
        this.service = service;
        return this;
    }

    public User getUser() {
        return user;
    }

    public ManagerAction setUser(User user) {
        this.user = user;
        return this;
    }

    public int[] getRoleIds() {
        return roleIds;
    }

    public ManagerAction setRoleIds(int[] roleIds) {
        this.roleIds = roleIds;
        return this;
    }

    public Object getJsonObject() {
        return jsonObject;
    }

    public ManagerAction setJsonObject(Object jsonObject) {
        this.jsonObject = jsonObject;
        return this;
    }

    public String getJspPage() {
        return jspPage;
    }

    public ManagerAction setJspPage(String jspPage) {
        this.jspPage = jspPage;
        return this;
    }
	public String getDispatchUrl() {
		return dispatchUrl;
	}
	public void setDispatchUrl(String dispatchUrl) {
		this.dispatchUrl = dispatchUrl;
	}
    	
}
