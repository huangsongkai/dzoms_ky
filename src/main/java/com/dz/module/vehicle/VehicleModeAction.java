package com.dz.module.vehicle;

import java.util.List;

import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;

@Controller
@Scope(value = "prototype")
public class VehicleModeAction extends ActionSupport implements
ServletRequestAware{
	private static final long serialVersionUID = 1L;
	private VehicleMode vehicleMode; // 定义值对象
	private Vehicle vehicle;
	
	@Autowired
	private VehicleModeService vehicleModeService; // 定义值对象
	private HttpServletRequest request;
	
	private String url;
	
	public VehicleModeService getVehicleModeService(){
		return vehicleModeService;
	}
	
	public void setVehicleModeService(VehicleModeService vehicleModeService){
		this.vehicleModeService = vehicleModeService;
	}
	
	public VehicleMode getVehicleMode(){
		return vehicleMode;
	}
	
	public void setVehicleMode(VehicleMode vehicleMode){
		this.vehicleMode = vehicleMode;
	}

	
	public String vehicleModeAdd() {
		//System.out.println();
		boolean flag = vehicleModeService.addVehicleMode(vehicleMode);
		if (!flag) {
			return ERROR;
		}
		return SUCCESS;
	}
	
	public String vehicleModeUpdate() {
		//System.out.println();
		boolean flag = vehicleModeService.updateVehicleMode(vehicleMode);
		if (!flag) {
			return ERROR;
		}
		return "toclose";
	}
	
	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}
	
	
	public String vehicleModeShow(){
		VehicleMode vm  = (VehicleMode) ObjectAccess.getObject("com.dz.module.vehicle.VehicleMode", vehicleMode.getCarMode());
		vehicleMode = vm;
		
		if(org.apache.commons.lang3.StringUtils.isNotEmpty(url)){
			return "success_url";
		}
		
		return SUCCESS;
	}
	
	public String vehicleModeSelect(){
		int currentPage = 0;
        String currentPagestr = request.getParameter("currentPage");
        
        if(StringUtils.isEmpty(currentPagestr)){
        	currentPage = 1;
        }else{
        	currentPage=Integer.parseInt(currentPagestr);
        }
       //vehicle.setCarMode("123");
       Page page = PageUtil.createPage(15, vehicleModeService.selectByConditionCount(vehicleMode), currentPage);
		List<Insurance> l = vehicleModeService.selectByCondition(page, vehicleMode);
		request.setAttribute("vehicleMode", l);
		//request.setAttribute("currentPage", currentPage);
		request.setAttribute("page", page);
		return SUCCESS;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}
	
	

}
