package com.dz.module.driver.complain;

import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.FileAccessUtil;
import com.dz.common.other.FileUploadUtil;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.module.driver.Driver;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ArrayUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
public class ComplainAction extends BaseAction {

	@Autowired
	private ComplainService complainService;
	@Autowired
	private FileAccessUtil fileAccessUtil;
	
	public void setComplainService(ComplainService complainService) {
		this.complainService = complainService;
	}
	
	public void setFileAccessUtil(FileAccessUtil fileAccessUtil) {
		this.fileAccessUtil = fileAccessUtil;
	}

	private Complain complain;
	
	public Complain getComplain() {
		return complain;
	}
	public void setComplain(Complain complain) {
		this.complain = complain;
	}

	private File[] fileUploads;
	private String[] fileUploadsFileName;
	private String[] fileUploadsContentType;
	
	public void complainFiles() throws IOException{
		JSONObject json = new JSONObject();
		complain = complainService.selectById(complain);
		if(complain!=null){
			json.put("title", ObjectAccess.getObject(Vehicle.class, complain.getVehicleId()).getLicenseNum());
			json.put("id", 1);
			json.put("start", 0);
			
			JSONArray jarr = new JSONArray();
			String basePath = System.getProperty("com.dz.root") +"data/driver/complain/"+complain.getId()+"/";
			File base = new File(basePath);
			File[] photos = base.listFiles();
			
			int pid=0;
			if(photos!=null)
			for(File photo:photos){
				JSONObject jsonOfPhoto = new JSONObject();
				jsonOfPhoto.put("alt", photo.getName());
				
				jsonOfPhoto.put("pid", pid++);
				jsonOfPhoto.put("src", "/DZOMS/data/driver/complain/"+complain.getId()+"/"+photo.getName());
				jsonOfPhoto.put("thumb", "/DZOMS/data/driver/complain/"+complain.getId()+"/"+photo.getName());
				
				jarr.add(jsonOfPhoto);
			}
			
			json.put("data", jarr);
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(json.toString());
		
		out.flush();
		out.close();
	}
	
	private String photo;
	private String photo_name;
	
	public void complainUploadPhoto() throws IOException{
		String basePath = System.getProperty("com.dz.root") +"data/driver/complain/"+complain.getId()+"/";
		File base = new File(basePath);
		if (!base.exists()) {
			base.mkdirs();
		}
		
		JSONObject json = new JSONObject();
		
		if(StringUtils.isNotEmpty(photo_name)&&StringUtils.length(photo)==30){
			Map<String,String> map = (Map<String,String>)request.getServletContext().getAttribute("TempFileMap");
			String rawName = map.get(photo);
			int index = rawName.lastIndexOf('.');
			
			if(index>=0){
				photo_name+= "."+rawName.substring(index+1);
			}
			
			System.out.println(rawName+","+index+","+photo_name);
			
			File file = new File(base,photo_name);

			FileUploadUtil.store(photo, file);
			json.put("status", true);
		}else{
			//参数不足
			json.put("status", false);
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(json.toString());
		
		out.flush();
		out.close();
	}
	
	public void complainDeletePhoto() throws IOException{
		String basePath = System.getProperty("com.dz.root") +"data/driver/complain/"+complain.getId()+"/";
		File base = new File(basePath);
		if (!base.exists()) {
			base.mkdirs();
		}
		
		JSONObject json = new JSONObject();
		
		if(StringUtils.isNotEmpty(photo_name)){
			File file = new File(base,photo_name);

			if(FileUtils.deleteQuietly(file)){
				json.put("status", true);
			}else{
				json.put("status", false);
			}
		}else{
			//参数不足
			json.put("status", false);
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(json.toString());
		
		out.flush();
		out.close();
	}
	
	public String addComplain(){
		try {
			User user = (User) session.getAttribute("user");
			complain.setRegistrant(user.getUid());
			complain.setState(0);
//			complain.setComplainTime(new Date());
			
			complainService.addComplain(complain);
			
			if(!ArrayUtils.isEmpty(fileUploads)){
				String basePath = session.getServletContext().getRealPath("/data/driver/complain");
				fileAccessUtil.store(basePath,""+complain.getId(), fileUploads, fileUploadsFileName);
				//int fileListNumber = fileAccessUtil.store(basePath, fileUploads, fileUploadsFileName);
				int fileListNumber = fileUploads==null?0:fileUploads.length;
				complain.setComplainFile(fileListNumber);
			}
		} catch (IOException e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	private Boolean confirmReault;
	
	
	public Boolean getConfirmReault() {
		return confirmReault;
	}

	public void setConfirmReault(Boolean confirmReault) {
		this.confirmReault = confirmReault;
	}
	
	public String confirmComplain(){
		try{
			Complain oc = complainService.selectById(complain);
			oc.setConfirmTime(complain.getDealTime());
			User user = (User) session.getAttribute("user");
			oc.setConfirmPerson(user.getUid());
			oc.setDealContext(complain.getDealContext());

			/**
			 * 2018-03-12 投诉无论是否属实，均落实到具体驾驶员
			 */
			{
				oc.setComplainContext(complain.getComplainContext());
				oc.setDealReault(complain.getDealReault());
				oc.setDealTime(complain.getDealTime());
				oc.setGrade(complain.getGrade());

				oc.setDealPerson(user.getUid());
			}

			if(confirmReault){
//				oc.setState(1);
				oc.setState(2);
			}
			else{
				oc.setState(-1);
			}
			complainService.updateComplain(oc);
		}catch(Exception e){
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	public String dealComplain(){
		return this.confirmComplain();
	}
	
	public String handledComplain(){
		try{
			Complain oc = complainService.selectById(complain);
			oc.setFinishTime(complain.getVisitBackTime());
			oc.setState(4);
			oc.setComplainContext(complain.getComplainContext());

			User user = (User) session.getAttribute("user");
			oc.setFinishPerson(user.getUid());

			complainService.updateComplain(oc);
		}catch(Exception e){
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	//Handled
	public String visitBackComplain(){
		try{
			Complain oc = complainService.selectById(complain);
			oc.setVisitBackResult(complain.getVisitBackResult());
			oc.setVisitBackTime(complain.getVisitBackTime());
			oc.setComplainContext(complain.getComplainContext());
			//oc.setState(3);
			
			User user = (User) session.getAttribute("user");
			oc.setVisitBackPerson(user.getUid());
			
			oc.setFinishTime(new Date());
			oc.setState(4);

			oc.setFinishPerson(user.getUid());

			complainService.updateComplain(oc);
			
		}catch(Exception e){
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	private String[] fileRemoved;
	public String[] getFileRemoved() {
		return fileRemoved;
	}

	public void setFileRemoved(String[] fileRemoved) {
		this.fileRemoved = fileRemoved;
	}
	
	public String updateComplain(){
		//Complain oc = complainService.selectById(complain);
//		Complain oc = ObjectAccess.getObject(Complain.class, complain.getId());

		complainService.updateComplain(complain);
		return SUCCESS;
	}
	
	public String attachComplain(){
		try {
			Complain oc = complainService.selectById(complain);
			oc.setAttachDetail(complain.getAttachDetail());
			oc.setComplainContext(complain.getComplainContext());
			if(complain.getState()<0){
				oc.setState(-Math.abs(complain.getState()));
			}
			
			User user = (User)session.getAttribute("user");
			oc.setAttachPerson(user.getUid());
			oc.setAttachTime(new Date());
			
			ObjectAccess.saveOrUpdate(oc);
		} catch (Exception e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	public String deleteComplain(){
		try {
			Complain oc = complainService.selectById(complain);
			int fileListNumber = ObjectUtils.defaultIfNull(oc.getComplainFile(), 0);
			if(fileListNumber!=0){
				String basePath = session.getServletContext().getRealPath("/data/driver/complain");
				fileAccessUtil.remove(basePath, ""+complain.getId());
			}
			
			complainService.deleteComplain(complain);
		} catch (Exception e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	public String complainToExcel(){
		request.setAttribute("templatePath", "driver/complain/complain_export.xls");
		Short[] states={};
        String[] ss = request.getParameterValues("states");
        if(ss.length==1){
        	ss = ss[0].split(",");
        }
        if(ss!=null){
        	final boolean[] hasNeg = new boolean[1];
        	@SuppressWarnings("unchecked")
			List<Short> statelist = (List<Short>) CollectionUtils.collect(Arrays.asList(ss), new Transformer(){
				@Override
				public Object transform(Object input) {
					String str = (String)input;
					short val = Short.parseShort(str.trim());
					if(val<0)
						hasNeg[0] = true;
					return val;
				}
        	});
        	states = new Short[0];
        	if(hasNeg[0]){
        		statelist.add((short)-2);
        		statelist.add((short)-3);
        		statelist.add((short)-4);
        	}
        	states = statelist.toArray(states);
        }
        List<Complain> l = complainService.selectByStates(null,complain, beginDate,endDate,dept,states,order);
        
        List<List<? extends Serializable>> datalist = new ArrayList<List<? extends Serializable>>();
		List<String> datasrc;
		datasrc = Arrays.asList("complains");
		datalist.add(l);
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		
		return SUCCESS;
	}
	
	
	public String searchComplain(){
			int currentPage = 0;
	        String currentPagestr = request.getParameter("currentPage");
	        if(currentPagestr == null || "".equals(currentPagestr)){
	        	currentPage = 1;
	        }else{
	        	currentPage=Integer.parseInt(currentPagestr);
	        }
	        
	        Short[] states={};
	        String[] ss = request.getParameterValues("states");
	        if(ss.length==1){
	        	ss = ss[0].split(",");
	        }
	        if(ss!=null){
	        	final boolean[] hasNeg = new boolean[1];
	        	@SuppressWarnings("unchecked")
				List<Short> statelist = (List<Short>) CollectionUtils.collect(Arrays.asList(ss), new Transformer(){
					@Override
					public Object transform(Object input) {
						String str = (String)input;
						short val = Short.parseShort(str.trim());
						if(val<0)
							hasNeg[0] = true;
						return val;
					}
	        	});
	        	states = new Short[0];
	        	if(hasNeg[0]){
	        		statelist.add((short)-2);
	        		statelist.add((short)-3);
	        		statelist.add((short)-4);
	        	}
	        	states = statelist.toArray(states);
	        }
	       //vehicle.setCarMode("123");
	        
	//        System.out.println("ComplainAction.searchComplain(),"+complain);
	        
	       Page page = PageUtil.createPage(15, complainService.selectAllByStatesCount(complain,beginDate,endDate,dept,states), currentPage);
			List<Complain> l = complainService.selectByStates(page,complain, beginDate,endDate,dept,states,order);
			request.setAttribute("list", l);
			request.setAttribute("page", page);
			
			if(StringUtils.isBlank(url)){
				url="/driver/complain/complain_search_result.jsp";
			}
			
			return SUCCESS;
		}

	private Date beginDate,endDate;
	
	public Date getBeginDate() {
		return beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
/*
	public void selectAll() throws IOException{
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				complainService.selectAllCount(beginDate,endDate), currentPage);
		List<Complain> complainList = complainService.selectAll(page,beginDate,endDate);
		
		JSONObject json = new JSONObject();
		json.put("complains", complainList);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}
	
	public void selectAllWaitForDeal() throws IOException{
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				complainService.selectAllWaitForDealCount(beginDate, endDate), currentPage);
		List<Complain> complainList = complainService.selectAllWaitForDeal(page,beginDate,endDate);
		
		JSONObject json = new JSONObject();
		json.accumulate("complains", complainList);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}
	
	public void selectAllWaitForVisitBack() throws IOException{
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				complainService.selectAllWaitForVisitBackCount(beginDate,endDate), currentPage);
		List<Complain> complainList = complainService.selectAllWaitForVisitBack(page,beginDate,endDate);
		
		JSONObject json = new JSONObject();
		json.accumulate("complains", complainList);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}
	
	public void selectAllHandled() throws IOException{
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				complainService.selectAllHandledCount(beginDate,endDate), currentPage);
		List<Complain> complainList = complainService.selectAllHandled(page,beginDate,endDate);
		
		JSONObject json = new JSONObject();
		json.accumulate("complains", complainList);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}
	
	public void selectAllByState() throws IOException{
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				complainService.selectAllByStateCount(beginDate,endDate,complain.getState()), currentPage);
		List<Complain> complainList = complainService.selectAllByState(page,beginDate,endDate,complain.getState());
		
		JSONObject json = new JSONObject();
		json.accumulate("complains", complainList);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}*/
	
	private String order,dept;
	
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	private Driver driver;
	public void selectByDriver() throws IOException{
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				complainService.selectByDriverCount(driver), currentPage);
		List<Complain> complainList = complainService.selectByDriver(driver,page);
		
		JSONObject json = new JSONObject();
		json.accumulate("complains", complainList);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}
	
	public String selectComplainById(){
		//complain = complainService.selectById(complain);
		complain = ObjectAccess.getObject(Complain.class, complain.getId());
		return SUCCESS;
	}
	
	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver dirver) {
		this.driver = dirver;
	}

	public File[] getFileUploads() {
		return fileUploads;
	}
	public String[] getFileUploadsFileName() {
		return fileUploadsFileName;
	}
	public String[] getFileUploadsContentType() {
		return fileUploadsContentType;
	}
	public void setFileUploads(File[] fileUploads) {
		this.fileUploads = fileUploads;
	}
	public void setFileUploadsFileName(String[] fileUploadsFileName) {
		this.fileUploadsFileName = fileUploadsFileName;
	}
	public void setFileUploadsContentType(String[] fileUploadsContentType) {
		this.fileUploadsContentType = fileUploadsContentType;
	}
	
	private String complainObject2,complainFromIn2,complainFromIn3,idNum,telephone,company;

	public String getComplainObject2() {
		return complainObject2;
	}

	public String getComplainFromIn2() {
		return complainFromIn2;
	}

	public String getComplainFromIn3() {
		return complainFromIn3;
	}

	public String getIdNum() {
		return idNum;
	}

	public String getTelephone() {
		return telephone;
	}

	public String getCompany() {
		return company;
	}

	public void setComplainObject2(String complainObject2) {
		this.complainObject2 = complainObject2;
	}

	public void setComplainFromIn2(String complainFromIn2) {
		this.complainFromIn2 = complainFromIn2;
	}

	public void setComplainFromIn3(String complainFromIn3) {
		this.complainFromIn3 = complainFromIn3;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}
	
	
	
}
