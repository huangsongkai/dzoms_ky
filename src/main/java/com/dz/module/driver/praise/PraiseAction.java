package com.dz.module.driver.praise;

import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.FileAccessUtil;
import com.dz.common.other.ObjectAccess;
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
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Set;
@Controller
@Scope("prototype")
public class PraiseAction extends BaseAction {
	
	@Autowired
	private PraiseService praiseService;
	@Autowired
	private FileAccessUtil fileAccessUtil;
	
	public void setPraiseService(PraiseService praiseService) {
		this.praiseService = praiseService;
	}
	
	public void setFileAccessUtil(FileAccessUtil fileAccessUtil) {
		this.fileAccessUtil = fileAccessUtil;
	}
	
	private Praise praise;
	private GroupPraise groupPraise;

	public Praise getPraise() {
		return praise;
	}

	public GroupPraise getGroupPraise() {
		return groupPraise;
	}

	public void setPraise(Praise praise) {
		this.praise = praise;
	}

	public void setGroupPraise(GroupPraise groupPraise) {
		this.groupPraise = groupPraise;
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
	
	public String selectPraiseById(){
		praise = (Praise) ObjectAccess.getObject("com.dz.module.driver.praise.Praise", praise.getId());
		return SUCCESS;
	}
	
	public String addPraise(){
		try {
			//if(!ArrayUtils.isEmpty(fileUploads)){
				String basePath = session.getServletContext().getRealPath("/data/driver/praise");
				int fileListNumber = fileAccessUtil.store(basePath, fileUploads, fileUploadsFileName);
				praise.setFileInfo(fileListNumber);
		//	}
			
			User user = (User) session.getAttribute("user");
			praise.setRegistrant(user.getUid());
			
			praiseService.addPraise(praise);
		} catch (IOException e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	private String[] fileRemoveList;
	public String updatePraise(){
		try {			
			int fileListNumber = praise.getFileInfo();

			if(!ArrayUtils.isEmpty(fileRemoveList)){
				fileAccessUtil.remove(fileListNumber, fileRemoveList);
			}
			
			if(!ArrayUtils.isEmpty(fileUploads)){
				fileAccessUtil.addMoreFile(fileListNumber, fileUploads, fileUploadsFileName);
			}
			
			User user = (User) session.getAttribute("user");
			praise.setRegistrant(user.getUid());
			
			praiseService.updatePraise(praise);
		} catch (IOException e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	public String dealPraise(){
		try{
			Praise oc = praiseService.selectById(praise);
			oc.setAlreadyDeal(praise.getAlreadyDeal());
			oc.setDealTime(praise.getDealTime());
			oc.setGrade(praise.getGrade());

			User user = (User) session.getAttribute("user");
			oc.setDealPerson(user.getUid());

			praiseService.dealPraise(oc);
		}catch(Exception e){
			e.printStackTrace();
			return ERROR;
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

	public String searchPraise(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				praiseService.selectAllCount(beginDate,endDate), currentPage);
		List<Praise> praiseList = praiseService.selectAll(page,beginDate,endDate);
		
		request.setAttribute("list", praiseList);
		request.setAttribute("page", page);
		return SUCCESS;
	}
	
	private String[] idNumberList;
	
	public String[] getIdNumberList() {
		return idNumberList;
	}

	public void setIdNumberList(String[] idNumberList) {
		this.idNumberList = idNumberList;
	}
	@Autowired
	private TableListService tableListService;
	

	public void setTableListService(TableListService tableListService) {
		this.tableListService = tableListService;
	}
	
	private List<String> driverlist;

	public String addGroupPraise(){
		try {
			User user = (User) session.getAttribute("user");
			groupPraise.setRegistrant(user.getUname());
			groupPraise.setDriverList(driverlist.size());
			
			praiseService.addGroupPraise(groupPraise);
			
			for(String idNum:driverlist){
				praiseService.addGroupPraiseDriver(new GroupPraiseDriver(groupPraise.getId(),idNum));
			}
		} catch (Exception e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	private String[] removeDriverList;
	public String updateGroupPraise(){
		try {
			int driverList = groupPraise.getDriverList();
			TableList tl = tableListService.getById(driverList);
			ListValue root = tableListService.getRoot(tl);
			
			if(!ArrayUtils.isEmpty(removeDriverList)){
				List<ListValue> ls = tableListService.getChildren(root);
				for(ListValue lv:ls){
					if(org.apache.commons.lang.ArrayUtils.contains(removeDriverList, lv.getValue())){
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
			groupPraise.setRegistrant(user.getUname());
			
			praiseService.updateGroupPraise(groupPraise);
		} catch (Exception e) {
				e.printStackTrace();
				return ERROR;
		}
		return SUCCESS;
	}
	
	public String deleteGroupPraise(){
		tableListService.deleteTableList(groupPraise.getDriverList());
		praiseService.deleteGroupPraise(groupPraise);
		return SUCCESS;
	}

	public String searchGroupPraise(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		Page page = PageUtil.createPage(15,
				praiseService.selectAllGroupPraiseCount(beginDate, endDate), currentPage);
		List<GroupPraise> praiseList = praiseService.selectAllGroupPraise(page,beginDate,endDate);
		
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
