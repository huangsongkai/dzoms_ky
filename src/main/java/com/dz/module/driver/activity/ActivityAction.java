package com.dz.module.driver.activity;

import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.FileAccessUtil;
import com.dz.common.other.PageUtil;
import com.dz.common.tablelist.ListValue;
import com.dz.common.tablelist.TableList;
import com.dz.common.tablelist.TableListService;
import com.dz.module.user.User;
import com.opensymphony.xwork2.util.ArrayUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Controller
@Scope("prototype")
public class ActivityAction extends BaseAction {

	@Autowired
	private ActivityService activityService;
	@Autowired
	private FileAccessUtil fileAccessUtil;
	
	public void setActivityService(ActivityService activityService) {
		this.activityService = activityService;
	}
	
	public void setFileAccessUtil(FileAccessUtil fileAccessUtil) {
		this.fileAccessUtil = fileAccessUtil;
	}
	
	private Activity activity;
	private List<String> driverlist;
	
	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}
	
	private File[] fileUploads;
	private String[] fileUploadsFileName;
	private String[] fileUploadsContentType;
	
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
	
	private String[] idNumberList;
	
	public String[] getIdNumberList() {
		return idNumberList;
	}

	public void setIdNumberList(String[] idNumberList) {
		this.idNumberList = idNumberList;
	}
	
	private TableListService tableListService;
	

	public void setTableListService(TableListService tableListService) {
		this.tableListService = tableListService;
	}

	public String addActivity(){
		try {
			User user = (User) session.getAttribute("user");
			activity.setRegistrant(user.getUid());
			activity.setDriverList(driverlist.size());
			
			activityService.addActivity(activity);
			
			for(String idNum:driverlist){
				activityService.addActivityDriver(new ActivityDriver(activity.getId(),idNum));
			}
			
			String basePath = System.getProperty("com.dz.root") +"data/driver/activity/";
			if(fileUploads!=null&&fileUploads.length>0){
				fileAccessUtil.store(basePath,""+ activity.getId(), fileUploads, fileUploadsFileName);
			}
			
		} catch (Exception e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	private String[] fileRemoveList;
	private String[] removeDriverList;
	
	public String updateActivity(){
		try {
			int fileListNumber = activity.getFileInfo();
			
			if(!ArrayUtils.isEmpty(fileRemoveList)){
				fileAccessUtil.remove(fileListNumber, fileRemoveList);
			}
			
			if(!ArrayUtils.isEmpty(fileUploads)){
				fileAccessUtil.addMoreFile(fileListNumber, fileUploads, fileUploadsFileName);
			}
			
			int driverList = activity.getDriverList();
			TableList tl = tableListService.getById(driverList);
			ListValue root = tableListService.getRoot(tl);
			
			if(!ArrayUtils.isEmpty(removeDriverList)){
				List<ListValue> ls = tableListService.getChildren(root);
				for(ListValue lv:ls){
					if(org.apache.commons.lang.ArrayUtils.contains(removeDriverList,lv.getValue())){
						tableListService.deleteItem(lv);
					}
				}
			}
			
			if(!ArrayUtils.isEmpty(idNumberList)){
				for(String str:idNumberList){
					tableListService.addSubItem(root, new ListValue(str,null,null));
				}
			}
			
			User user = (User) session.getAttribute("user");
			activity.setRegistrant(user.getUid());
			
			activityService.updateActivity(activity);
		} catch (Exception e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	public String deleteActivity(){
		int fileListNumber = activity.getFileInfo();
		fileAccessUtil.removeList(fileListNumber);
		int driverList = activity.getDriverList();
		tableListService.deleteTableList(driverList);
		activityService.deleteActivity(activity);
		return SUCCESS;
	}

	public String searchActivity(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				activityService.selectAllActivityCount(beginDate, endDate), currentPage);
		List<Activity> praiseList = activityService.selectAllActivity(page,beginDate,endDate);
		
		request.setAttribute("list", praiseList);
		request.setAttribute("page", page);
		return SUCCESS;
	}
	
 	public String[] getFileRemoveList() {
		return fileRemoveList;
	}

	public void setFileRemoveList(String[] fileRemoveList) {
		this.fileRemoveList = fileRemoveList;
	}

	public String[] getRemoveDriverList() {
		return removeDriverList;
	}

	public void setRemoveDriverList(String[] removeDriverList) {
		this.removeDriverList = removeDriverList;
	}

	public List<String> getDriverlist() {
		return driverlist;
	}

	public void setDriverlist(List<String> driverlist) {
		this.driverlist = driverlist;
	}
}
