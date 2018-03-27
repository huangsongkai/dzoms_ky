package com.dz.module.driver.homevisit;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.dz.common.other.FileAccessUtil;
import com.dz.module.driver.Driver;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.util.ArrayUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;

@Controller
@Scope("prototype")
public class HomeVisitAction extends BaseAction {

	public void setFileAccessUtil(FileAccessUtil fileAccessUtil) {
		this.fileAccessUtil = fileAccessUtil;
	}

	private HomeVisit homeVisit;
	private String condition;

	private File[] fileUploads;
	private String[] fileUploadsFileName;
	private String[] fileUploadsContentType;

	@Autowired
	private FileAccessUtil fileAccessUtil;

	public void homeVisitFiles() throws IOException{
		JSONObject json = new JSONObject();
		homeVisit = ObjectAccess.getObject(HomeVisit.class,homeVisit.getId());
		if(homeVisit!=null){
			json.put("title", ObjectAccess.getObject(Driver.class,homeVisit.getIdNum()).getName());
			json.put("id", 1);
			json.put("start", 0);

			JSONArray jarr = new JSONArray();
			String basePath = System.getProperty("com.dz.root") +"data/driver/homeVisit/"+homeVisit.getId()+"/";
			File base = new File(basePath);
			File[] photos = base.listFiles();

			int pid=0;
			if(photos!=null)
				for(File photo:photos){
					JSONObject jsonOfPhoto = new JSONObject();
					jsonOfPhoto.put("alt", photo.getName());

					jsonOfPhoto.put("pid", pid++);
					jsonOfPhoto.put("src", "/DZOMS/data/driver/homeVisit/"+homeVisit.getId()+"/"+photo.getName());
					jsonOfPhoto.put("thumb", "/DZOMS/data/driver/homeVisit/"+homeVisit.getId()+"/"+photo.getName());

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


	public String addHomeVisit(){
		if(homeVisit!=null){
			if(!ArrayUtils.isEmpty(fileUploads)){
				String basePath = session.getServletContext().getRealPath("/data/driver/homeVisit");
				try {
					ObjectAccess.saveOrUpdate(homeVisit);
					fileAccessUtil.store(basePath,""+homeVisit.getId(), fileUploads, fileUploadsFileName);
				} catch (IOException e) {
					e.printStackTrace();
					return ERROR;
				}
			}
		}
		else{
			return ERROR;
		}
		return SUCCESS;
	}
	
	public String searchHomeVisit(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

		//	System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		
		String hql = " 1=1 ";
		if(!StringUtils.isEmpty(condition)){
			hql+=condition;
		}
		
		long count = ObjectAccess.execute("select count(*) from HomeVisit where "+hql);
		
		Page page = PageUtil.createPage(15,(int)count, currentPage);
		
		List<HomeVisit> hlist = ObjectAccess.query(HomeVisit.class, hql, null, null, null, page);
		
		session.setAttribute("page", page);
		session.setAttribute("list", hlist);
		
		return SUCCESS;
	}

	public HomeVisit getHomeVisit() {
		return homeVisit;
	}

	public void setHomeVisit(HomeVisit homeVisit) {
		this.homeVisit = homeVisit;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
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
	
}
