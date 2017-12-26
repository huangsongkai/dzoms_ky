package com.dz.module.driver;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.itemtool.ItemTool;
import com.dz.common.itemtool.ItemToolService;
import com.dz.common.other.FileAccessUtil;
import com.dz.common.other.FileUploadUtil;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.module.contract.BankCard;
import com.dz.module.contract.BankCardService;
import com.dz.module.user.*;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.VehicleService;
import com.opensymphony.xwork2.ActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.bidimap.DualHashBidiMap;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.javatuples.Triplet;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.*;
import java.util.*;

@Controller
@Scope("prototype")
public class DriverAction extends BaseAction{
	public static final DualHashBidiMap photoNameMap = new DualHashBidiMap();

	static{
		photoNameMap.put("身份证", "P_IdCard.jpg");
		photoNameMap.put("驾驶证", "P_DriverLicense.jpg");
		photoNameMap.put("从业人员资格证", "P_Qualification.jpg");
		photoNameMap.put("户口本首页", "P_Location.jpg");
		photoNameMap.put("暂住证（呼兰、阿城除外）", "P_TempLocton.jpg");
		photoNameMap.put("驾驶员聘用协议", "P_EmployContract.jpg");
		photoNameMap.put("服务质量承诺书", "P_Server.jpg");
		photoNameMap.put("个人免冠彩色一寸照", "P_photo.jpg");
		photoNameMap.put("车体照（四寸）", "P_vehicle.jpg");
		photoNameMap.put("驾驶员登记表", "P_table.jpg");
		photoNameMap.put("户口本本人页", "P_personal.jpg");
		photoNameMap.put("驾驶员表彰证书", "P_praise.jpg");
		photoNameMap.put("人车照", "drive_vehicle_photo.jpg");
		photoNameMap.put("驾驶员照片", "photo.jpg");
	}

	private String msg;
	@Autowired
	private ManagerService managerService;
	private String hzw;

	public String driverApply(){
		if(driver==null||StringUtils.isBlank(driver.getIdNum())){
			request.setAttribute("msgStr", "身份证号不可为空。");
			url = "/driver/applycheck/driver_apply.jsp";
			return "selectToUrl";
		}

		driver.setStatus(0);
		driver.setApplyTime(new Date());
		driver.setDrivingLicenseDate(new Date());
		driver.setQualificationDate(new Date());
		driver.setQualificationValidDate(new Date());

		if(StringUtils.contains(driver.getApplyMatter(), "临")){
			driver.setStatus(1);
		}

		User user = (User) session.getAttribute("user");
		String position = user.getPosition();
		String dept="";

		if(position==null)
			dept="";
		else
		if(position.contains("一"))
			dept = "一部";
		else if(position.contains("二"))
			dept = "二部";
		else if(position.contains("三"))
			dept = "三部";

		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Driver rd = (Driver) s.get(Driver.class, driver.getIdNum());
//			Driver rd = driverService.selectById(driver.getIdNum());

			if(rd!=null){
				if(BooleanUtils.isTrue(rd.getIsInCar())){
					request.setAttribute("msgStr", "该驾驶员已上车。");
					url = "/driver/applycheck/driver_apply.jsp";
					return "selectToUrl";
				}

				rd.setStatus(0);
				rd.setApplyMatter(driver.getApplyMatter());
				rd.setFuwubaozhengjin(driver.getFuwubaozhengjin());
				rd.setApplyLicenseNum(driver.getApplyLicenseNum());
				rd.setApplyTime(new Date());
				rd.setDept(dept);
//				ObjectAccess.saveOrUpdate(rd);
				s.saveOrUpdate(rd);

				driver = rd;

				url = "/driver/applycheck/driver_apply_prt.jsp";
			}else{
//				driverService.driverAdd(driver,null);
				s.saveOrUpdate(driver);
				url = "/driver/applycheck/driver_apply_prt.jsp";
			}

			tx.commit();
			request.setAttribute("msgStr", "申请成功。");
		}catch (HibernateException e){
			request.setAttribute("msgStr", "申请失败 "+e.getMessage());
			if(tx!=null)
				tx.rollback();
			url = "/driver/applycheck/driver_apply.jsp";
		}
		return "selectToUrl";
	}
	public String driverToDifferentPage(){
		Driver d = driverService.selectById(driver.getIdNum());
		this.setDriver(d);
		this.families = driverService.selectFamily(driver);

		File[] fs = FileAccessUtil.list(System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum()+"/checkfiles");

		if(hzw.equals("1")){
			url = "/driver/applycheck/score_in.jsp";
		}else{
			url = "/driver/applycheck/caiwu_pass.jsp";
		}
		return "selectToUrl";
	}

	public String driverAppendScore(){
		driverService.appendScore(driver);
		url = "driverCheck";
		return "nextAction";
	}
	public String driverAppendCaiWu(){
		driverService.appendCaiWu(driver);
		url = "driverCheck";
		return "nextAction";
	}

	public String driverCheck(){
		User user = (User)session.getAttribute("user");
		List<RelationUr> relationUrs = managerService.searchAuthoritiesByUser(user);
		boolean isLuRuRen = false;
		boolean isYunYinBuJinLi = false;
		boolean isCaiWuJinLi = false;
		for(RelationUr ur:relationUrs){
			Role role = ObjectAccess.getObject(Role.class, ur.getRid());
			if(role==null||role.getRname()==null)
				continue;
			//role.getRname().equals("财务经理");
			if(role.getRname().contains("财务"))
				isCaiWuJinLi = true;
			if(role.getRname().contains("提请聘用"))
				isLuRuRen = true;
			if(role.getRname().contains("聘用审核"))
				isYunYinBuJinLi = true;
		}
		List<UrlAttachBean> urlAttachBeen = new ArrayList<>();
//		int total = driverService.driverSearchTotal();
//		List<Driver> drivers = driverService.driverSearch(PageUtil.createPage(total,total,1));
//
		Session s = HibernateSessionFactory.getSession();

		String hql = "from Driver where status in (1,2) ";
		if(driver!=null && StringUtils.isNotBlank(driver.getApplyLicenseNum()))
			hql += " and (applyLicenseNum is null or applyLicenseNum like :carNum )";
		Query q_d = s.createQuery(hql);

		if(driver!=null && StringUtils.isNotBlank(driver.getApplyLicenseNum())){
			q_d.setString("carNum", "%"+driver.getApplyLicenseNum().trim()+"%");
		}
		List<Driver> drivers = q_d.list();
//		int total = drivers.size();

		System.out.println("d:"+drivers.size());
		System.out.println(isLuRuRen+"|"+isYunYinBuJinLi+"|"+isCaiWuJinLi);
		for(Driver driver:drivers){
//			if(driver.getStatus() == 0 && isLuRuRen){
//				urlAttachBeen.add(new UrlAttachBean(driver.getIdNum(),driver.getName(),"/DZOMS/driver/driverPreupdate?driver.idNum="+driver.getIdNum()+"&hzw=123",driver.getApplyLicenseNum(),driver.getApplyTime()));
//			}
			if(driver.getStatus() == 1 && isYunYinBuJinLi){
				urlAttachBeen.add(new UrlAttachBean(driver.getIdNum(),driver.getName(),"/DZOMS/driver/driverToDifferentPage?driver.idNum="+driver.getIdNum()+"&hzw=1",driver.getApplyLicenseNum(),driver.getApplyTime()));
			}
			if(driver.getStatus() == 2 && isCaiWuJinLi){
				urlAttachBeen.add(new UrlAttachBean(driver.getIdNum(),driver.getName(),"/DZOMS/driver/driverToDifferentPage?driver.idNum="+driver.getIdNum()+"&hzw=2",driver.getApplyLicenseNum(),driver.getApplyTime()));
			}
		}
		Collections.sort(urlAttachBeen);
		request.setAttribute("urlAttachBeen",urlAttachBeen);
		url = "/driver/applycheck/dispatch.jsp";
		return "selectToUrl";
	}

	public void driverPhotos() throws IOException{
		JSONObject json = new JSONObject();
		driver = driverService.selectById(driver.getIdNum());
		if(driver!=null){
			json.put("title", driver.getName());
			json.put("id", 1);
			json.put("start", 0);

			JSONArray jarr = new JSONArray();
			String basePath = System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum()+"/";
			File base = new File(basePath);
			File[] photos = base.listFiles(new FilenameFilter() {
				@Override
				public boolean accept(File dir, String name) {
					return name.endsWith(".jpg")||name.endsWith(".JPG");
				}
			});

			int pid=0;
			if(photos!=null)
				for(File photo:photos){
					JSONObject jsonOfPhoto = new JSONObject();
					if(photoNameMap.containsValue(photo.getName())){
						jsonOfPhoto.put("alt", photoNameMap.getKey(photo.getName()));
					}else{
						jsonOfPhoto.put("alt", photo.getName());
					}
					jsonOfPhoto.put("pid", pid++);
					jsonOfPhoto.put("src", "/DZOMS/data/driver/"+driver.getIdNum()+"/"+photo.getName());
					jsonOfPhoto.put("thumb", "/DZOMS/data/driver/"+driver.getIdNum()+"/"+photo.getName());

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

	public void driverUploadPhoto() throws IOException{
		String basePath = System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum()+"/";
		File base = new File(basePath);
		if (!base.exists()) {
			base.mkdirs();
		}

		JSONObject json = new JSONObject();

		if(StringUtils.isNotEmpty(photo_name)&&StringUtils.length(photo)==30){
			File file;
			if(photoNameMap.containsKey(photo_name)){
				file = new File(base,(String)photoNameMap.get(photo_name));
			}else{
				file = new File(base,photo_name+".jpg");
			}
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

	public void driverDeletePhoto() throws IOException{
		String basePath = System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum()+"/";
		File base = new File(basePath);
		if (!base.exists()) {
			base.mkdirs();
		}

		JSONObject json = new JSONObject();

		if(StringUtils.isNotEmpty(photo_name)){
			File file;
			if(photoNameMap.containsKey(photo_name)){
				file = new File(base,(String)photoNameMap.get(photo_name));
			}else{
				file = new File(base,photo_name);
			}
//			if(file.exists()&&file.delete()){
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

	public String driverAdd() throws IOException {
		if(driver==null){
			request.setAttribute("msgStr", "添加失败。数据未传入。");
			return "selectToUrl";
		}else{
			System.out.println(driver.getIdNum());
		}
		String basePath = System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum();

		File baseFile = new File(basePath);

		if(photo!=null&&StringUtils.length(photo)==30)
			FileUploadUtil.store(photo,new File(baseFile,"photo.jpg"));

		if(StringUtils.length(P_IdCard         )==30) FileUploadUtil.store(P_IdCard         ,new File(baseFile,"P_IdCard.jpg"));
		if(StringUtils.length(P_DriverLicense  )==30) FileUploadUtil.store(P_DriverLicense  ,new File(baseFile,"P_DriverLicense.jpg"));
		if(StringUtils.length(P_Qualification  )==30) FileUploadUtil.store(P_Qualification  ,new File(baseFile,"P_Qualification.jpg"));
		if(StringUtils.length(P_Location       )==30) FileUploadUtil.store(P_Location       ,new File(baseFile,"P_Location.jpg"));
		if(StringUtils.length(P_TempLocton     )==30) FileUploadUtil.store(P_TempLocton     ,new File(baseFile,"P_TempLocton.jpg"));
		if(StringUtils.length(P_EmployContract )==30) FileUploadUtil.store(P_EmployContract ,new File(baseFile,"P_EmployContract.jpg"));
		if(StringUtils.length(P_Server         )==30) FileUploadUtil.store(P_Server         ,new File(baseFile,"P_Server.jpg"));
		if(StringUtils.length(P_photo          )==30) FileUploadUtil.store(P_photo          ,new File(baseFile,"P_photo.jpg"));
		if(StringUtils.length(P_vehicle        )==30) FileUploadUtil.store(P_vehicle        ,new File(baseFile,"P_vehicle.jpg"));
		if(StringUtils.length(P_table          )==30) FileUploadUtil.store(P_table          ,new File(baseFile,"P_table.jpg"));
		if(StringUtils.length(P_personal       )==30) FileUploadUtil.store(P_personal       ,new File(baseFile,"P_personal.jpg"));
		if(StringUtils.length(P_praise         )==30) FileUploadUtil.store(P_praise         ,new File(baseFile,"P_praise.jpg"));

		if(checkfile!=null&&checkfile.length>0){
			File checkfiles = new File(baseFile,"checkfiles");
			checkfiles.mkdir();

			ActionContext actionContext = ActionContext.getContext();
			Map<String,Object> fmaps = actionContext.getApplication();
			Map<String,String> fmap = (Map)fmaps.get("TempFileMap");

			for (String seq:checkfile){
				FileUploadUtil.store(seq ,new File(checkfiles,fmap.get(seq)));
			}
		}

		User user = (User) session.getAttribute("user");
		if(bankCard!=null){
			bankCard.setIdNumber(driver.getIdNum());
			bankCard.setOperator(user.getUid());
			bankCard.setOpeTime(new Date());
			if(!bankCardService.bankCardAdd(bankCard)){
				request.setAttribute("msgStr", "添加失败。银行卡录入失败，请检查是否已存在同号的银行卡，或同一用户绑定了多张主支付卡。");
				return "selectToUrl";
			}
		}

		boolean flag = driverService.driverSaveOrUpdate(driver, families);
		if (!flag) {
			request.setAttribute("msgStr", "添加失败。用户信息不完全。");
			return "selectToUrl";
		}
		request.setAttribute("msgStr", "添加成功。");
		driver=null;
		return "selectToUrl";
	}

	public String driverPreupdate(){
		Driver d = driverService.selectById(driver.getIdNum());

		if(d==null)
			return ERROR;
		this.setDriver(d);
		this.families = driverService.selectFamily(driver);

		File[] fs = FileAccessUtil.list(System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum()+"/checkfiles");
//		if(fs!=null){
//			this.checkfileFileName = new String[fs.length];
//			for(int i=0;i<fs.length;i++)
//				checkfileFileName[i] = fs[i].getName();
//		}

//		bankCard  = bankCardService.getBankCardForPayByDriverId(driver.getIdNum(),null);
//		bankCardForReceive = bankCardService.getBankCardForReceiveByDriverId(driver.getIdNum(),null);
		return SUCCESS;
	}

	public String driverUpdate(){
		boolean flag = driverService.driverUpdate(driver, families);
		System.out.println(hzw+"-------------------------------------------");
		if (!flag) {
			return ERROR;
		}
		if("123".equals(hzw)){
			System.out.println("-------------------------------------------");
			url = "/driver/applycheck/driver_in_product.jsp";
			return "selectToUrl";
		}
		return SUCCESS;
	}

	public String driverShowApplyCheckPrint(){
		driver = driverService.selectById(driver.getIdNum());
		this.families = driverService.selectFamily(driver);
		url = "/driver/applycheck/driver_in_product.jsp";
		return "selectToUrl";
	}

	private String licenseNum,name;

	public String searchDriver(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			//	System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}

		if(driver==null){
			driver = new Driver();
		}

		if(!StringUtils.isEmpty(idNum)){
			driver.setIdNum(idNum);
		}

		if(!StringUtils.isEmpty(name)){
			driver.setName(name);
		}

		if(isInCar!=null){
			driver.setIsInCar(isInCar);
		}

		Triplet<String,String,Object> condition_applyTime_from = new Triplet<String,String,Object>("applyTime",">",beginDate);
		Triplet<String,String,Object> condition_applyTime_end = new Triplet<String,String,Object>("applyTime","<=",endDate);
		Triplet<String,String,Object> condition_idName_like = new Triplet<String,String,Object>("name","like","%"+driver.getName()+"%");
		Triplet<String,String,Object> condition_idNum_like = new Triplet<String,String,Object>("idNum","like","%"+driver.getIdNum()+"%");
		Triplet<String,String,Object> condition_isInCar_true = new Triplet<String,String,Object>("isInCar","=",true);
		Triplet<String,String,Object> condition_isInCar_false = new Triplet<String,String,Object>("idNum","=idNum and (isInCar is null or isInCar = false) and 1=",1);
		Triplet<String,String,Object> condition_dept = new Triplet<String,String,Object>("dept","=",driver.getDept());
		Triplet<String, String, Object> condition_license_num_like = Triplet.with("carframeNum", "in (select carframeNum from Vehicle where licenseNum like '%"+licenseNum+"%' ) and 1=", (Object)1);

		ArrayList<Triplet<String,String,Object>> conditionList = new ArrayList<Triplet<String,String,Object>>();
		if(beginDate!=null)
			conditionList.add(condition_applyTime_from);
		if(endDate!=null)
			conditionList.add(condition_applyTime_end);
		if(!StringUtils.isEmpty(driver.getIdNum())){
			conditionList.add(condition_idNum_like);
		}
		if(!StringUtils.isEmpty(driver.getName())){
			conditionList.add(condition_idName_like);
		}

		if (!StringUtils.isEmpty(driver.getDept())&&!driver.getDept().startsWith("all")) {
			conditionList.add(condition_dept);
		}

		if(!StringUtils.isEmpty(licenseNum)&&!licenseNum.equals("黑A")){
			conditionList.add(condition_license_num_like);
		}

		if(driver.getFingerprintNum()!=null&&driver.getFingerprintNum()!=0){
			conditionList.add(new Triplet<String, String, Object>("fingerprintNum","=fingerprintNum and (CONVERT(fingerprintNum,char) like '"+driver.getFingerprintNum()+"%') and 1=",1));
		}

		if(driver.getIsInCar()!=null){
			if(driver.getIsInCar())
				conditionList.add(condition_isInCar_true);
			else
				conditionList.add(condition_isInCar_false);
		}
		@SuppressWarnings("unchecked")
		Triplet<String,String,Object>[] conditions = new Triplet[conditionList.size()];
		conditions = conditionList.toArray(conditions);

		Page page = PageUtil.createPage(15,
				driverService.searchCount( conditions), currentPage);
		List<Driver> l = driverService.search(page, conditions);

		request.setAttribute("list", l);
		request.setAttribute("page", page);

		if(StringUtils.isBlank(url)){
			url = "/driver/search_result.jsp";
		}

		return SUCCESS;
	}

	public String searchDriverWithoutPage(){
		if(driver==null){
			driver = new Driver();
		}

		if(!StringUtils.isEmpty(idNum)){
			driver.setIdNum(idNum);
		}
		if(isInCar!=null){
			driver.setIsInCar(isInCar);
		}

		List<Driver> l = driverService.driverSearchCondition(null, beginDate, endDate, driver);

		request.setAttribute("list", l);
		return SUCCESS;
	}

	private String templatePath;

	public String driverToExcel(){
		if(StringUtils.isBlank(templatePath)){
			templatePath = "driver/driver_template.xls";
		}

		request.setAttribute("templatePath", templatePath);

		List<List<? extends Serializable>> datalist = new ArrayList<List<? extends Serializable>>();
		List<String> datasrc;
		datasrc = Arrays.asList("drivers");

		if(driver==null){
			driver = new Driver();
		}

		if(!StringUtils.isEmpty(idNum)){
			driver.setIdNum(idNum);
		}

		if(!StringUtils.isEmpty(name)){
			driver.setName(name);
		}

		if(isInCar!=null){
			driver.setIsInCar(isInCar);
		}

		Triplet<String,String,Object> condition_applyTime_from = new Triplet<String,String,Object>("applyTime",">",beginDate);
		Triplet<String,String,Object> condition_applyTime_end = new Triplet<String,String,Object>("applyTime","<=",endDate);
		Triplet<String,String,Object> condition_idName_like = new Triplet<String,String,Object>("name","like","%"+driver.getName()+"%");
		Triplet<String,String,Object> condition_idNum_like = new Triplet<String,String,Object>("idNum","like","%"+driver.getIdNum()+"%");
		Triplet<String,String,Object> condition_isInCar_true = new Triplet<String,String,Object>("isInCar","=",true);
		Triplet<String,String,Object> condition_isInCar_false = new Triplet<String,String,Object>("idNum","=idNum and (isInCar is null or isInCar = false) and 1=",1);
		Triplet<String,String,Object> condition_dept = new Triplet<String,String,Object>("dept","=",driver.getDept());
		Triplet<String, String, Object> condition_license_num_like = Triplet.with("carframeNum", "in (select carframeNum from Vehicle where licenseNum like '%"+licenseNum+"%' ) and 1=", (Object)1);

		ArrayList<Triplet<String,String,Object>> conditionList = new ArrayList<Triplet<String,String,Object>>();
		if(beginDate!=null)
			conditionList.add(condition_applyTime_from);
		if(endDate!=null)
			conditionList.add(condition_applyTime_end);
		if(!StringUtils.isEmpty(driver.getIdNum())){
			conditionList.add(condition_idNum_like);
		}
		if(!StringUtils.isEmpty(driver.getName())){
			conditionList.add(condition_idName_like);
		}

		if (!StringUtils.isEmpty(driver.getDept())&&!driver.getDept().startsWith("all")) {
			conditionList.add(condition_dept);
		}

		if(!StringUtils.isEmpty(licenseNum)&&!licenseNum.equals("黑A")){
			conditionList.add(condition_license_num_like);
		}

		if(driver.getFingerprintNum()!=null&&driver.getFingerprintNum()!=0){
			conditionList.add(new Triplet<String, String, Object>("fingerprintNum","=fingerprintNum and (CONVERT(fingerprintNum,char) like '"+driver.getFingerprintNum()+"%') and 1=",1));
		}

		if(driver.getIsInCar()!=null){
			if(driver.getIsInCar())
				conditionList.add(condition_isInCar_true);
			else
				conditionList.add(condition_isInCar_false);
		}
		@SuppressWarnings("unchecked")
		Triplet<String,String,Object>[] conditions = new Triplet[conditionList.size()];
		conditions = conditionList.toArray(conditions);

		List<Driver> l = driverService.search(null, conditions);

		datalist.add(l);
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		return SUCCESS;
	}

	public String driverInCarToExcel(){
		if(StringUtils.isBlank(templatePath)){
			templatePath = "driver/driver_in_car_template.xls";
		}
		request.setAttribute("templatePath", templatePath);

		List<List<? extends Serializable>> datalist = new ArrayList<List<? extends Serializable>>();
		List<String> datasrc = Arrays.asList("records");
		List<Driverincar> l = driverService.selectDriverInCarByCondition(null,beginDate, endDate, vehicle, driver,operation,finished);
		datalist.add(l);
		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		return SUCCESS;
	}

	public String badDriverSearch(){
		List<Driver> list = driverService.searchAllBadDriver();
		request.setAttribute("bad_drivers", list);
		return SUCCESS;
	}

	public String driverUpdateStar(){
		boolean result = driverService.updateStar(driver);
		if(result){
			ajax_message = "success";
		}else{
			ajax_message = "fail";
		}
		return SUCCESS;
	}

	public String addBusinessApply() throws IOException{
		Driver d = driverService.selectById(driver.getIdNum());

		Vehicle v = new Vehicle();
		v.setCarframeNum(driver.getCarframeNum());
		v = vehicleService.selectById(v);

		d.setRestTime(driver.getRestTime());
		d.setBusinessApplyCarframeNum(driver.getCarframeNum());
		d.setBusinessApplyDriverClass(driver.getDriverClass());
		d.setBusinessApplyTime(driver.getBusinessApplyTime());
		d.setBusinessApplyRegistrant(driver.getBusinessApplyRegistrant());
		d.setBusinessApplyRegistTime(driver.getBusinessApplyRegistTime());

		d.setBusinessApplyState(1);
		//driverService.driverUpdate(d,families);
		ObjectAccess.saveOrUpdate(d);

//		if(d.getDriverClass().equals("主驾")){
//			v.setFirstDriver(d.getIdNum());
//			if(d.getIdNum().equals(v.getSecondDriver())){
//				v.setSecondDriver(null);
//			}
//			if(d.getIdNum().equals(v.getThirdDriver())){
//				v.setThirdDriver(null);
//			}
//			if(d.getIdNum().equals(v.getTempDriver())){
//				v.setTempDriver(null);
//			}
//		}else if(d.getDriverClass().equals("副驾")){
//			v.setSecondDriver(d.getIdNum());
//			if(d.getIdNum().equals(v.getFirstDriver())){
//				v.setFirstDriver(null);
//			}
//			if(d.getIdNum().equals(v.getThirdDriver())){
//				v.setThirdDriver(null);
//			}
//			if(d.getIdNum().equals(v.getTempDriver())){
//				v.setTempDriver(null);
//			}
//		}else if(d.getDriverClass().equals("三驾")){
//			v.setThirdDriver(d.getIdNum());
//			if(d.getIdNum().equals(v.getFirstDriver())){
//				v.setFirstDriver(null);
//			}
//			if(d.getIdNum().equals(v.getSecondDriver())){
//				v.setSecondDriver(null);
//			}
//			if(d.getIdNum().equals(v.getTempDriver())){
//				v.setTempDriver(null);
//			}
//		}else if(d.getDriverClass().equals("临驾")){
//			v.setTempDriver(d.getIdNum());
//		}
//
//		vehicleService.updateVehicle(v);

		String basePath = System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum();

//		System.out.println(drive_vehicle_photo);
//		System.out.println(drive_photo);

		if(StringUtils.length(drive_vehicle_photo)==30)
			FileUploadUtil.store(drive_vehicle_photo,new File(basePath,"drive_vehicle_photo.jpg"));
		if(StringUtils.length(drive_photo)==30)
			FileUploadUtil.store(drive_photo,new File(basePath,"photo.jpg"));

		Driverincar record = new Driverincar(d.getBusinessApplyCarframeNum(),d.getIdNum(),"证照申请",d.getBusinessApplyTime());
		record.setFinished(false);
		record.setDriverClass(d.getBusinessApplyDriverClass());
		driverService.addDriverInCarRecord(record);
		return SUCCESS;
	}

	public String addBusinessRecive(){
		Driver d = driverService.selectById(driver.getIdNum());

		//Vehicle v = new Vehicle();
		//v.setCarframeNum(driver.getCarframeNum());
		//v = vehicleService.selectById(v);
		Vehicle v = ObjectAccess.getObject(Vehicle.class, d.getBusinessApplyCarframeNum());

		String rawIdnum = null;
		switch (d.getBusinessApplyDriverClass()){
			case "主驾":
				rawIdnum = v.getFirstDriver();
				break;
			case "副驾":
				rawIdnum = v.getSecondDriver();
				break;
			case "三驾":
				rawIdnum = v.getThirdDriver();
		}
		if(StringUtils.isNotEmpty(rawIdnum)){
			Driver rd = ObjectAccess.getObject(Driver.class,rawIdnum);
			request.setAttribute("msgStr",
					String.format("%s驾驶员%s,%s未下车，请先进行下车操作",v.getLicenseNum(),rd.getName(),rd.getIdNum()));
			return SUCCESS;
		}

		Session s = null;
		Transaction tx = null;

		try {
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();

			d.setBusinessReciveTime(driver.getBusinessReciveTime());
			d.setBusinessReciveRegistrant(driver.getBusinessReciveRegistrant());
			d.setBusinessReciveRegistTime(driver.getBusinessReciveRegistTime());
			d.setEmployeeNum(driver.getEmployeeNum());
			d.setIsInCar(true);
			d.setBusinessApplyState(2);
			d.setDriverClass(d.getBusinessApplyDriverClass());
			d.setCarframeNum(v.getCarframeNum());
			d.setDept(v.getDept());

			s.saveOrUpdate(d);
			//driverService.driverUpdate(d,families);

			if("主驾".equals(d.getDriverClass())){
				v.setFirstDriver(d.getIdNum());
				if(d.getIdNum().equals(v.getSecondDriver())){
					v.setSecondDriver(null);
				}
				if(d.getIdNum().equals(v.getThirdDriver())){
					v.setThirdDriver(null);
				}
				if(d.getIdNum().equals(v.getTempDriver())){
					v.setTempDriver(null);
				}
			}else if("副驾".equals(d.getDriverClass())){
				v.setSecondDriver(d.getIdNum());
				if(d.getIdNum().equals(v.getFirstDriver())){
					v.setFirstDriver(null);
				}
				if(d.getIdNum().equals(v.getThirdDriver())){
					v.setThirdDriver(null);
				}
				if(d.getIdNum().equals(v.getTempDriver())){
					v.setTempDriver(null);
				}
			}else if("三驾".equals(d.getDriverClass())){
				v.setThirdDriver(d.getIdNum());
				if(d.getIdNum().equals(v.getFirstDriver())){
					v.setFirstDriver(null);
				}
				if(d.getIdNum().equals(v.getSecondDriver())){
					v.setSecondDriver(null);
				}
				if(d.getIdNum().equals(v.getTempDriver())){
					v.setTempDriver(null);
				}
			}else if("临驾".equals(d.getDriverClass())){
				v.setTempDriver(d.getIdNum());
			}

			//vehicleService.updateVehicle(v);
			s.saveOrUpdate(v);

			String basePath = System.getProperty("com.dz.root") +"data/driver/"+driver.getIdNum();

//	System.out.println(drive_vehicle_photo);
//	System.out.println(drive_photo);

			if(StringUtils.length(drive_vehicle_photo)==30)
				FileUploadUtil.store(drive_vehicle_photo,new File(basePath,"drive_vehicle_photo.jpg"));
			if(StringUtils.length(drive_photo)==30)
				FileUploadUtil.store(drive_photo,new File(basePath,"photo.jpg"));

			Driverincar record = ObjectAccess.executeSingle(String.format("from Driverincar where carframeNum='%s' and idNumber='%s' and operation='证照申请' and finished=false", v.getCarframeNum(),d.getIdNum()),s);
			record.setFinished(true);
			s.saveOrUpdate(record);

			tx.commit();
		}catch (HibernateException ex){
			ex.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
		}finally {
			HibernateSessionFactory.closeSession();
		}

		//record = new Driverincar(d.getCarframeNum(),d.getIdNum(),"上车",d.getBusinessReciveTime());
		//driverService.addDriverInCarRecord(record);
		return SUCCESS;
	}

	public String addBusinessApplyCancel(){
		Driver d = driverService.selectById(driver.getIdNum());
		d.setBusinessApplyCancelTime(driver.getBusinessApplyCancelTime());
		d.setBusinessApplyCancelRegistrant(driver.getBusinessApplyCancelRegistrant());
		d.setBusinessApplyCancelRegistTime(driver.getBusinessApplyCancelRegistTime());
		d.setBusinessApplyCancelState(1);

		ObjectAccess.saveOrUpdate(d);

		Driverincar record = new Driverincar(d.getCarframeNum(),d.getIdNum(),"证照注销",d.getBusinessApplyCancelTime());
		record.setFinished(false);
		record.setDriverClass(d.getDriverClass());
		driverService.addDriverInCarRecord(record);
		return SUCCESS;
	}

	public String addBusinessReciveCancel(){
		Driver d = driverService.selectById(driver.getIdNum());

		Vehicle v = new Vehicle();
		v.setCarframeNum(driver.getCarframeNum());
		v = vehicleService.selectById(v);

		if(d.getBusinessApplyState()!=2||!StringUtils.equals(d.getBusinessApplyDriverClass(), d.getDriverClass())||!StringUtils.equalsIgnoreCase(d.getBusinessApplyCarframeNum(), d.getCarframeNum())){
			//申请与注销不是同一件事

		}else{
			d.setBusinessApplyTime(null);
			d.setBusinessApplyRegistrant(null);
			d.setBusinessApplyRegistTime(null);

			d.setBusinessReciveTime(null);
			d.setBusinessReciveRegistrant(null);
			d.setBusinessReciveRegistTime(null);

			d.setBusinessApplyState(0);
			d.setBusinessApplyDriverClass(null);
			d.setBusinessApplyCarframeNum(null);
		}

		if(d.getDriverClass().equals("主驾")){
			v.setFirstDriver(null);
		}else if(d.getDriverClass().equals("副驾")){
			v.setSecondDriver(null);
		}else if(d.getDriverClass().equals("三驾")){
			v.setThirdDriver(null);
		}else if(d.getDriverClass().equals("临驾")){
			v.setTempDriver(null);
		}

		ObjectAccess.saveOrUpdate(v);

		ObjectAccess.execute(String.format("update Driverincar set finished=true where carframeNum='%s' and idNumber='%s' and (operation='证照注销' or operation='下车' ) and finished=false",
				v.getCarframeNum(),d.getIdNum()));
//		Driverincar record = new Driverincar(d.getCarframeNum(),d.getIdNum(),"下车",driver.getBusinessReciveCancelRegistTime());
//		driverService.addDriverInCarRecord(record);

		d.setIsInCar(false);

		d.setRestTime(null);
		d.setCarframeNum(null);
		d.setDriverClass(null);
		d.setBusinessApplyCancelState(0);

		d.setBusinessApplyCancelTime(null);
		d.setBusinessApplyCancelRegistrant(null);
		d.setBusinessApplyCancelRegistTime(null);

		d.setDept(null);
		d.setStatus(4);

		ObjectAccess.saveOrUpdate(d);

		return SUCCESS;
	}

	private String operation;
	private Boolean finished;

	public String selectDriverInCarRecord(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		Page page = PageUtil.createPage(15,
				driverService.selectDriverInCarByConditionCount(beginDate, endDate, vehicle, driver,operation,finished), currentPage);
		List<Driverincar> l = driverService.selectDriverInCarByCondition(page,beginDate, endDate, vehicle, driver,operation,finished);

		request.setAttribute("list", l);
		request.setAttribute("page", page);
		return SUCCESS;
	}

	public String addLeaveApply(){
		Driver d = ObjectAccess.getObject(Driver.class, driver.getIdNum());
		//d.setIsLeave(true);
		//driverService.driverUpdate(d,families);

		driverleave.setCarframeNum(d.getCarframeNum());
		driverleave.setIdNumber(d.getIdNum());
		driverleave.setOperation("待岗申请");
		driverleave.setFinished(false);

		driverService.addLeaveRecord(driverleave);
		return SUCCESS;
	}

	public void leaveApply() throws IOException{
		Driverleave l = ObjectAccess.getObject(Driverleave.class, driverleave.getId());
		l.setFinished(true);
		Driver d = ObjectAccess.getObject(Driver.class, l.getIdNumber());
		d.setIsLeave(true);
		ObjectAccess.saveOrUpdate(l);
		ObjectAccess.saveOrUpdate(d);

		ServletActionContext.getResponse().setContentType("text/plain");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		out.print("success");
		out.flush();
		out.close();
	}

	public String addLeaveCancelApply() {
		Driver d = driverService.selectById(driver.getIdNum());
		//d.setIsLeave(false);
		//driverService.driverUpdate(d,families);

		driverleave.setCarframeNum(d.getCarframeNum());
		driverleave.setIdNumber(d.getIdNum());
		driverleave.setOperation("上岗申请");
		driverleave.setFinished(false);

		driverService.addLeaveRecord(driverleave);

		return SUCCESS;
	}

	public void leaveApplyCancel() throws IOException{
		Driverleave l = ObjectAccess.getObject(Driverleave.class, driverleave.getId());
		l.setFinished(true);
		Driver d = ObjectAccess.getObject(Driver.class, l.getIdNumber());
		d.setIsLeave(false);
		ObjectAccess.saveOrUpdate(l);
		ObjectAccess.saveOrUpdate(d);
		ServletActionContext.getResponse().setContentType("text/plain");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		out.print("success");
		out.flush();
		out.close();
	}

	public String selectLeaveRecord(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		//System.out.println(finished);
		Page page = PageUtil.createPage(15,
				driverService.selectDriverLeaveByConditionCount(beginDate, endDate, vehicle, driver,finished,operation), currentPage);
		List<Driverleave> l = driverService.selectDriverLeaveByCondition(page,beginDate, endDate, vehicle, driver,finished,operation);

		request.setAttribute("list", l);
		request.setAttribute("page", page);
		return SUCCESS;
	}

	public void badRecordAdd() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		Boolean result = driverService.addBadRecord(driver,reason );

		if(result){
			out.print("<!DOCTYPE html>                                                           ");
			out.print("<html>                                                                    ");
			out.print("	<head>                                                                   ");
			out.print("		<meta charset=\"utf-8\">                                             ");
			out.print("		<title>Jump</title>                                                  ");
			out.print("		<script>                                                             ");
			out.print("			setTimeout(\"window.location.href='/DZOMS/driver/badDriverSearch';\",1000);");
			out.print("		</script>                                                            ");
			out.print("	</head>                                                                  ");
			out.print("	<body>                                                                   ");
			out.print("		录入成功。                                                           ");
			out.print("	</body>                                                                  ");
			out.print("</html>                                                                   ");
		}else{
			out.print("<!DOCTYPE html>                                                           ");
			out.print("<html>                                                                    ");
			out.print("	<head>                                                                   ");
			out.print("		<meta charset=\"utf-8\">                                             ");
			out.print("		<title>Jump</title>                                                  ");
			out.print("		<script>                                                             ");
			out.print("			setTimeout(\"window.location.href='/DZOMS/driver/badrecord_add.jsp';\",1000);");
			out.print("		</script>                                                            ");
			out.print("	</head>                                                                  ");
			out.print("	<body>                                                                   ");
			out.print("		该司机已录入黑名单!                                           ");
			out.print("	</body>                                                                  ");
			out.print("</html>                                                                   ");
		}

		out.flush();
		out.close();
	}

	public void removeBadRecord()throws IOException{
		ServletActionContext.getResponse().setContentType("text/html");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		Boolean result = driverService.removeBadRecord(driver);

		if(result){
			out.print("<!DOCTYPE html>                                                           ");
			out.print("<html>                                                                    ");
			out.print("	<head>                                                                   ");
			out.print("		<meta charset=\"utf-8\">                                             ");
			out.print("		<title>Jump</title>                                                  ");
			out.print("		<script>                                                             ");
			out.print("			setTimeout(\"window.location.href='/DZOMS/driver/badDriverSearch';\",1000);");
			out.print("		</script>                                                            ");
			out.print("	</head>                                                                  ");
			out.print("	<body>                                                                   ");
			out.print("		移除成功。                                                           ");
			out.print("	</body>                                                                  ");
			out.print("</html>                                                                   ");
		}else{
			out.print("<!DOCTYPE html>                                                           ");
			out.print("<html>                                                                    ");
			out.print("	<head>                                                                   ");
			out.print("		<meta charset=\"utf-8\">                                             ");
			out.print("		<title>Jump</title>                                                  ");
			out.print("		<script>                                                             ");
			out.print("			setTimeout(\"window.location.href='/DZOMS/driver/badrecord_add.jsp';\",1000);");
			out.print("		</script>                                                            ");
			out.print("	</head>                                                                  ");
			out.print("	<body>                                                                   ");
			out.print("		移除失败!                                           ");
			out.print("	</body>                                                                  ");
			out.print("</html>                                                                   ");
		}

		out.flush();
		out.close();
	}

	public void driverSelectById() throws IOException {
		Driver d = (Driver) ObjectAccess.getObject("com.dz.module.driver.Driver", driver.getIdNum());
		if(d != null){
			jsonObject = d;
		}else{
			jsonObject = driver;
			//System.out.println("WTFFFFFFFFFFFFFFFFF");
		}

		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		JSONObject json = JSONObject.fromObject(jsonObject);

		out.print(json.toString());

		out.flush();
		out.close();
	}

	public void driverSearch() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		Page page = PageUtil.createPage(15,
				driverService.driverSearchTotal(), currentPage);
		List<Driver> l = driverService
				.driverSearch(page);

		JSONObject json = new JSONObject();
		json.put("list", l);
		json.accumulate("hasPrePage", page.isHasPrePage());
		json.accumulate("hasNextPage", page.isHasNexPage());
		json.accumulate("currentPage", currentPage);
		json.accumulate("totalPage", page.getTotalPage());

		out.print(json.toString());

		out.flush();
		out.close();
	}

	public void driverSearchByName() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		Driver driver = new Driver();
		driver.setName(idName);
		List<Driver> l = driverService.driverSearchCondition(null, null, null, driver);

		if(l==null){
			l = new ArrayList<Driver>();
		}

		JSONObject json = new JSONObject();
		json.put("list", l);
		json.put("size", l.size());

		out.print(json.toString());

		out.flush();
		out.close();
	}

	public void driverSearchCondition() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}

		if(driver==null){
			driver = new Driver();
		}

		if(!StringUtils.isEmpty(idNum)){
			driver.setIdNum(idNum);
		}
		if(isInCar!=null){
			driver.setIsInCar(isInCar);
		}

		Page page = PageUtil.createPage(15,
				driverService.driverSearchConditionTotal(beginDate, endDate, driver), currentPage);
		List<Driver> l = driverService
				.driverSearchCondition(page,idNum,beginDate,endDate,isInCar);
		JSONObject json = new JSONObject();
		json.accumulate("list", l);
		json.accumulate("hasPrePage", page.isHasPrePage());
		json.accumulate("hasNextPage", page.isHasNexPage());
		json.accumulate("currentPage", currentPage);
		json.accumulate("totalPage", page.getTotalPage());
		out.print(json.toString());

		out.flush();
		out.close();
	}

	public void driverSearchConditionCount() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		if(driver==null){
			driver = new Driver();
		}

		if(!StringUtils.isEmpty(idNum)){
			driver.setIdNum(idNum);
		}
		if(isInCar!=null){
			driver.setIsInCar(isInCar);
		}

		int total = driverService.driverSearchConditionTotal(beginDate, endDate, driver);

		out.print(total);

		out.flush();
		out.close();
	}

	public String teamQuery(){
		ItemTool item = new ItemTool();
		item.setKey("driverTeam");
		List<ItemTool> il = itemToolService.selectByKey(item);
		Map<String,Long> map = new TreeMap<String,Long>();
		for(ItemTool it:il){
			String team = it.getValue();
			long num = ObjectAccess.execute("select count(*) from Driver where team='"+team+"' and isInCar=true");
			map.put(team, num);
		}
		session.setAttribute("teamMap", map);
		return SUCCESS;
	}

	@Autowired
	private VehicleService vehicleService;

	public void setVehicleService(VehicleService vehicleService) {
		this.vehicleService = vehicleService;
	}

	@Autowired
	private ItemToolService itemToolService ;

	public void setItemToolService(ItemToolService itemToolService) {
		this.itemToolService = itemToolService;
	}

	public String selectByVehicle(){
		vehicle = vehicleService.selectByLicenseNum(vehicle);
		return SUCCESS;
	}

	public String selectByName(){
		driver = driverService.selectByName(driver.getName(),driver.getCarframeNum());

		return this.driverPreupdate();
	}

	private String idName;

	public void driverCarSearch() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

			System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		Page page = PageUtil.createPage(15,
				driverService.driverCarSearchTotal(idName,idNum,licenseNum), currentPage);
		List<Vehicle> l = driverService.driverCarSearch(page,idName,idNum,licenseNum);

		JSONObject json = new JSONObject();
		json.put("list", l);
		json.accumulate("hasPrePage", page.isHasPrePage());
		json.accumulate("hasNextPage", page.isHasNexPage());
		json.accumulate("currentPage", currentPage);
		json.accumulate("totalPage", page.getTotalPage());

		out.print(json.toString());

		out.flush();
		out.close();
	}

	private Driver driver;
	private String idNum;
	private Date beginDate;
	private Date endDate;
	private Boolean isInCar;
	private Vehicle vehicle;
	private BankCard bankCard,bankCardForReceive;
	private Driverleave driverleave;

	@Autowired
	private BankCardService bankCardService;


	//添加到黑名单的原�
	private String reason;
	private List<Families> families;
	private String ajax_message;

	private String photo;
	private String photo_name;

	private String P_IdCard           ;
	private String P_DriverLicense    ;
	private String P_Qualification    ;
	private String P_Location         ;
	private String P_TempLocton       ;
	private String P_EmployContract   ;
	private String P_Server           ;
	private String P_photo            ;
	private String P_vehicle          ;
	private String P_table            ;
	private String P_personal         ;
	private String P_praise           ;

	private String[] checkfile;

	//人车照片   证照申请时
	private String drive_vehicle_photo;
	private String drive_photo;

	private Object jsonObject;

	private InputStream excelStream;

	@Autowired
	private DriverService driverService;
	@Autowired
	private FileAccessUtil fileAccessUtil;

	public String getIdNum() {
		return idNum;
	}


	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Boolean getIsInCar() {
		return isInCar;
	}

	public void setIsInCar(Boolean isInCar) {
		this.isInCar = isInCar;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}

	public DriverService getDriverService() {
		return driverService;
	}

	public void setDriverService(DriverService driverService) {
		this.driverService = driverService;
	}

	public List<Families> getFamilies() {
		return families;
	}

	public void setFamilies(List<Families> families) {
		this.families = families;
	}

	public String getAjax_message() {
		return ajax_message;
	}

	public void setAjax_message(String ajax_message) {
		this.ajax_message = ajax_message;
	}

	public void setFileAccessUtil(FileAccessUtil fileAccessUtil) {
		this.fileAccessUtil = fileAccessUtil;
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

	public String getIdName() {
		return idName;
	}

	public void setIdName(String idName) {
		this.idName = idName;
	}

	public String getLinence_num() {
		return licenseNum;
	}

	public void setLinence_num(String linence_num) {
		this.licenseNum = linence_num;
	}

	public InputStream getExcelStream() {
		return excelStream;
	}

	public void setExcelStream(InputStream excelStream) {
		this.excelStream = excelStream;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public BankCard getBankCard() {
		return bankCard;
	}

	public void setBankCard(BankCard bankCard) {
		this.bankCard = bankCard;
	}

	public BankCard getBankCardForReceive() {
		return bankCardForReceive;
	}

	public void setBankCardForReceive(BankCard bankCardForReceive) {
		this.bankCardForReceive = bankCardForReceive;
	}

	public void setBankCardService(BankCardService bankCardService) {
		this.bankCardService = bankCardService;
	}

	public Driverleave getDriverleave() {
		return driverleave;
	}

	public void setDriverleave(Driverleave driverleave) {
		this.driverleave = driverleave;
	}

	public String getP_IdCard() {
		return P_IdCard;
	}

	public void setP_IdCard(String p_IdCard) {
		P_IdCard = p_IdCard;
	}

	public String getP_DriverLicense() {
		return P_DriverLicense;
	}

	public void setP_DriverLicense(String p_DriverLicense) {
		P_DriverLicense = p_DriverLicense;
	}

	public String getP_Qualification() {
		return P_Qualification;
	}

	public void setP_Qualification(String p_Qualification) {
		P_Qualification = p_Qualification;
	}

	public String getP_Location() {
		return P_Location;
	}

	public void setP_Location(String p_Location) {
		P_Location = p_Location;
	}

	public String getP_TempLocton() {
		return P_TempLocton;
	}

	public void setP_TempLocton(String p_TempLocton) {
		P_TempLocton = p_TempLocton;
	}

	public String getP_EmployContract() {
		return P_EmployContract;
	}

	public void setP_EmployContract(String p_EmployContract) {
		P_EmployContract = p_EmployContract;
	}

	public String getP_Server() {
		return P_Server;
	}

	public void setP_Server(String p_Server) {
		P_Server = p_Server;
	}

	public String getP_photo() {
		return P_photo;
	}

	public void setP_photo(String p_photo) {
		P_photo = p_photo;
	}

	public String getP_vehicle() {
		return P_vehicle;
	}

	public void setP_vehicle(String p_vehicle) {
		P_vehicle = p_vehicle;
	}

	public String getP_table() {
		return P_table;
	}

	public void setP_table(String p_table) {
		P_table = p_table;
	}

	public String getP_personal() {
		return P_personal;
	}

	public void setP_personal(String p_personal) {
		P_personal = p_personal;
	}

	public String getP_praise() {
		return P_praise;
	}

	public void setP_praise(String p_praise) {
		P_praise = p_praise;
	}

	public String[] getCheckfile() {
		return checkfile;
	}

	public void setCheckfile(String[] checkfile) {
		this.checkfile = checkfile;
	}

	public String getDrive_vehicle_photo() {
		return drive_vehicle_photo;
	}

	public void setDrive_vehicle_photo(String drive_vehicle_photo) {
		this.drive_vehicle_photo = drive_vehicle_photo;
	}

	public Boolean getInCar() {
		return isInCar;
	}

	public void setInCar(Boolean inCar) {
		isInCar = inCar;
	}


	public Object getJsonObject() {
		return jsonObject;
	}

	public void setJsonObject(Object jsonObject) {
		this.jsonObject = jsonObject;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getHzw() {
		return hzw;
	}

	public void setHzw(String hzw) {
		this.hzw = hzw;
	}
	public String getLicenseNum() {
		return licenseNum;
	}
	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDrive_photo() {
		return drive_photo;
	}
	public void setDrive_photo(String drive_photo) {
		this.drive_photo = drive_photo;
	}
	public Boolean getFinished() {
		return finished;
	}
	public void setFinished(Boolean finished) {
		this.finished = finished;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public String getTemplatePath() {
		return templatePath;
	}
	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}


}
