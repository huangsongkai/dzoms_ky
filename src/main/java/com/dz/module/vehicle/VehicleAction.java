package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.FileAccessUtil;
import com.dz.common.other.FileUploadUtil;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.module.charge.ChargePlan;
import com.dz.module.contract.Contract;
import com.dz.module.contract.ContractService;
import com.dz.module.user.RelationUr;
import com.dz.module.user.Role;
import com.dz.module.user.User;
import com.dz.module.user.message.Message;
import com.dz.module.user.message.MessageToUser;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.collections.bidimap.DualHashBidiMap;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.javatuples.Triplet;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Scope(value = "prototype")
public class VehicleAction extends BaseAction{

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public static final DualHashBidiMap photoNameMap = new DualHashBidiMap();

	static{
		photoNameMap.put("车辆照片", "photo.jpg");
		photoNameMap.put("车辆照片拓印", "photo_tuoying.jpg");
		photoNameMap.put("车体照", "license.jpg");
	}

	private Vehicle vehicle;
	@Autowired
	private VehicleService vehicleService;
	@Autowired
	private ContractService contractService;
	@Autowired
	private FileAccessUtil fileAccessUtil;

	private Contract contract;
	private Object jsonObject;

	private String photo;
	private String photo_name;

	private String photo_tuoying;

	private String condition;

	private String driverName;

	//For Search
	private Date pd_begin,pd_end;
	private Date inDate_begin,inDate_end;
	private Date operateCardTime_begin,operateCardTime_end;

	//行车执照登记日期 审批单
	private Date getCarDate;


	public void setVehicleService(VehicleService vehicleService){
		this.vehicleService = vehicleService;
	}

	public void setContractService(ContractService contractService) {
		this.contractService = contractService;
	}

	public Vehicle getVehicle(){
		return vehicle;
	}

	public VehicleMode getVehicleMode() {
		return vehicleMode;
	}

	public void setVehicleMode(VehicleMode vehicleMode) {
		this.vehicleMode = vehicleMode;
	}

	public void setVehicle(Vehicle vehicle){
		this.vehicle = vehicle;
	}

	private Integer pageSize;
	private String orderby;
	public String vehicleSele() {
		int currentPage = 0;

		String hql = selectQueryGenerate();

		if (pageSize==null||pageSize==0){
			pageSize = PageUtil.PAGE_SIZE;
		}

		Page page = null;
		if(pageSize>0){
			String currentPagestr = request.getParameter("currentPage");
			if(currentPagestr == null || "".equals(currentPagestr)){
				currentPage = 1;
			}else{
				currentPage=Integer.parseInt(currentPagestr);
			}
			long count = ObjectAccess.execute("select count(*) from Vehicle where " + hql);
			page = PageUtil.createPage(pageSize,(int)count, currentPage);
			request.setAttribute("page", page);
		}

		if(org.apache.commons.lang3.StringUtils.isBlank(orderby)){
			orderby = " licenseNum ";
		}

		List<Vehicle> l = ObjectAccess.query(Vehicle.class, hql, null, null, orderby, page);

		request.setAttribute("vehicle", l);

		if(StringUtils.isEmpty(url))
			return "select";

		return "selectToUrl";
	}

	private String selectQueryGenerate() {
		String hql = " state>=0 ";

		if(vehicle!=null){

			hql += checkAndGenerate(vehicle,"carframeNum"," and carframeNum like '%%%s%%' ");
			hql += checkAndGenerate(vehicle,"licenseNum"," and licenseNum like '%%%s%%' ");
			hql += checkAndGenerate(vehicle,"engineNum"," and engineNum like '%s%%' ");
			hql += checkAndGenerate(vehicle,"dept");
			hql += checkAndGenerate(vehicle,"invoiceNumber"," and invoiceNumber like '%s%%' ");
			hql += checkAndGenerate(vehicle,"taxNumber"," and taxNumber like '%s%%' ");
			hql += checkAndGenerate(vehicle,"operateCard"," and operateCard like '%s%%' ");
			hql += checkAndGenerate(vehicle,"moneyCountor"," and moneyCountor like '%s%%' ");
			hql += checkAndGenerate(vehicle,"businessLicenseId");

			if(vehicle.getState()!=null && vehicle.getState()>=0){
				hql += checkAndGenerate(vehicle,"state");
			}

			//hql += checkAndGenerate(vehicle,"businessLicenseBeginDate"," and businessLicenseBeginDate >= STR_TO_DATE('%tF','%%Y-%%m-%%d') ");
			//hql += checkAndGenerate(vehicle,"businessLicenseEndDate"," and businessLicenseEndDate <= STR_TO_DATE('%tF','%%Y-%%m-%%d') ");

			if(!StringUtils.isEmpty(driverName)){
				hql += " and driverId in (select idNum from Driver where name ='"+driverName+"') ";
			}
		}

		if(StringUtils.isNotEmpty(condition)){
			hql+=condition;
		}
		return hql;
	}

	private String templatePath;


	public String exportToExcel(){
		if(StringUtils.isBlank(templatePath)){
			templatePath = "vehicle/vehicle/vehicle_template.xls";
		}
		request.setAttribute("templatePath", templatePath);

		List datalist = new ArrayList();
		List<String> datasrc = new ArrayList<>();
		datasrc.add("vehicles");


		String hql = selectQueryGenerate();
		List<Vehicle> l = ObjectAccess.query(Vehicle.class, hql, null, null, null, null);
		datalist.add(l);

		String withInsurance = request.getParameter("withInsurance");
		if("true".equals(withInsurance)){
			Map<String,Insurance> jq=new HashMap<>(),sx=new HashMap<>(),cy=new HashMap<>();
			Session s = null;
			try {
				s = HibernateSessionFactory.getSession();
				Query query = s.createQuery("select max(i.id) from Insurance i where i.carframeNum=:carno and i.insuranceClass like :insuranceClass ");
				for (Vehicle v : l) {
					query.setString("carno",v.getCarframeNum() );
					query.setString("insuranceClass", "%强%");
					Integer iid = (Integer) query.uniqueResult();
					if(iid!=null)
						jq.put(v.getCarframeNum(), (Insurance) s.get(Insurance.class, iid));

					query.setString("insuranceClass", "%商%");
					iid = (Integer) query.uniqueResult();
					if(iid!=null)
						sx.put(v.getCarframeNum(), (Insurance) s.get(Insurance.class, iid));

					query.setString("insuranceClass", "%承运%");
					iid = (Integer) query.uniqueResult();
					if(iid!=null)
						cy.put(v.getCarframeNum(), (Insurance) s.get(Insurance.class, iid));
				}
			} catch (HibernateException e) {
				e.printStackTrace();
			}finally{
				datasrc.add("jq");
				datalist.add(jq);
				datasrc.add("sx");
				datalist.add(sx);
				datasrc.add("cy");
				datalist.add(cy);
				request.setAttribute("outputName", "保险续保信息");
			}
		}else{
			request.setAttribute("outputName", "车辆信息");
		}

		request.setAttribute("datasrc", datasrc);
		request.setAttribute("datalist", datalist);
		return SUCCESS;
	}

	public String vehicleBind(){
		Vehicle v = ObjectAccess.getObject(Vehicle.class, vehicle.getCarframeNum());
		Contract c = ObjectAccess.execute("select c from Contract c where c.idNum='"+vehicle.getDriverId()+
				"' and c.state=2 ");
		if(c==null){
			request.setAttribute("msgStr", "添加失败。请先进行新车开业，新车开业后才可进行人辆绑定。");
			return ERROR;
		}
		c.setCarframeNum(v.getCarframeNum());
		c.setCarNum(v.getLicenseNum());

		ObjectAccess.saveOrUpdate(c);

		v.setDriverId(vehicle.getDriverId());
		ObjectAccess.saveOrUpdate(v);

		if(v.getOperateCardTime()!=null){
			VehicleApproval approval = ObjectAccess.execute("from VehicleApproval c where c.contractId="+c.getId()+
					" and c.checkType=0 ");
			approval.setOperateCardDate(v.getOperateCardTime());
			ObjectAccess.saveOrUpdate(approval);
		}

		if(v.getGetCarDate()!=null){
			VehicleApproval approval = ObjectAccess.execute("from VehicleApproval c where c.contractId="+c.getId()+
					" and c.checkType=0 ");
			approval.setGetCarDate(v.getGetCarDate());
			ObjectAccess.saveOrUpdate(approval);
		}

		if(v.getLicenseNumRegDate()!=null){
			VehicleApproval approval = ObjectAccess.execute("from VehicleApproval c where c.contractId="+c.getId()+
					" and c.checkType=0 ");
			approval.setLicenseRegisterDate(v.getLicenseNumRegDate());
			approval.setOperateApplyDate(new Date());
			ObjectAccess.saveOrUpdate(approval);
		}

		return SUCCESS;
	}

	public void vehicleSelectValidCount() throws IOException{
		Triplet<String,String,Object> condition = new Triplet<String,String,Object>("state","<",2);
		Triplet<String,String,Object> condition2 = new Triplet<String,String,Object>("state","!=",-1);
		int total = vehicleService.seleVehicleCount(null,condition,condition2);

		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		out.print(total);

		out.flush();
		out.close();
	}

	public String vehicleSelectAll(){
		jsonObject = vehicleService.selectAll();
		return "jsonObject";
	}

	public void vehiclePhotos() throws IOException{
		JSONObject json = new JSONObject();
		vehicle = vehicleService.selectById(vehicle);
		if(vehicle!=null){
			json.put("title", vehicle.getLicenseNum());
			json.put("id", 1);
			json.put("start", 0);

			JSONArray jarr = new JSONArray();
			String basePath = System.getProperty("com.dz.root") +"data/vehicle/"+vehicle.getCarframeNum()+"/";
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
					jsonOfPhoto.put("src", "/DZOMS/data/vehicle/"+vehicle.getCarframeNum()+"/"+photo.getName());
					jsonOfPhoto.put("thumb", "/DZOMS/data/vehicle/"+vehicle.getCarframeNum()+"/"+photo.getName());

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

	public void vehicleUploadPhoto() throws IOException{
		String basePath = System.getProperty("com.dz.root") +"data/vehicle/"+vehicle.getCarframeNum()+"/";
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

	public void vehicleDeletePhoto() throws IOException{
		String basePath = System.getProperty("com.dz.root") +"data/vehicle/"+vehicle.getCarframeNum()+"/";
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

	public String vehicleAdd() {
		try {
			String basePath = System.getProperty("com.dz.root") +"data/vehicle/"+vehicle.getCarframeNum()+"/";
			File base = new File(basePath);
			if (!base.exists()) {
				base.mkdirs();
			}
			if(StringUtils.length(photo)==30){
				FileUploadUtil.store(photo, new File(base,"photo.jpg"));
			}

			if(StringUtils.length(photo_tuoying)==30){
				FileUploadUtil.store(photo_tuoying, new File(base,"photo_tuoying.jpg"));
			}

			vehicle.setState(-1);

			vehicle.setGetCarDate(getCarDate);

			boolean flag = vehicleService.addVehicle(vehicle);
			if (!flag) {
				request.setAttribute("msgStr", "添加失败。");
				return ERROR;
			}
			request.setAttribute("msgStr", "添加成功。");
			vehicle=null;
			return SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return ERROR;
		}
	}


	public String vehicleRelook(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query q = s.createQuery("update Vehicle set state=0 where state=-1");
			q.executeUpdate();
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "添加成功。");
		return SUCCESS;
	}

	public String vehicleDelete(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Vehicle v = (Vehicle) s.get(Vehicle.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=-1){
				request.setAttribute("msgStr", "删除失败。不存在未审核的车架号为"+vehicle.getCarframeNum()+"的车辆。");
				return SUCCESS;
			}else{
				Query query = s.createQuery("delete from BankCardOfVehicle where vehicle.carframeNum=:carNum");
				query.setString("carNum",v.getCarframeNum());
				s.delete(v);
				query.executeUpdate();
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}


	public void vehicleSearch() throws IOException {
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();

		int count = vehicleService.seleVehicleCount(vehicle);
		Page page = PageUtil.createPage(count,count, 0);
		List<Vehicle> l = vehicleService.seleVehicle(page, vehicle);

		JSONArray json = JSONArray.fromObject(l);

		out.print(json.toString());

		out.flush();
		out.close();
	}

	public String vehicleSelectByLicenseNum(){
		Vehicle v = vehicleService.selectByLicenseNum(vehicle);
		v.setDriverId(v.getDriverId()+"p");
		v.setFirstDriver(v.getFirstDriver()+"p");
		v.setSecondDriver(v.getSecondDriver()+"p");
		v.setThirdDriver(v.getThirdDriver()+"p");
		v.setForthDriver(v.getForthDriver()+"p");
//		System.out.println(v);
		jsonObject = v;
		return "selectByLicenseNum";
	}

	public String vehicleUpdate() {
		boolean flag = vehicleService.updateVehicle(vehicle);
		if(!flag) {
			request.setAttribute("msgStr", "操作失败。");
			return ERROR;
		}
		return SUCCESS;
	}

	public String addInvoice(){
		Invoice i = new Invoice();
		BeanUtils.copyProperties(vehicle,i, new String[]{"state"});
		i.setState(0);
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			s.saveOrUpdate(i);
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String relookInvoice(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createQuery("from Invoice where state=0");
			List<Invoice> is = query.list();
			for(Invoice i:is){
				Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
				BeanUtils.copyProperties(i,v, new String[]{"state"});
				s.update(v);
				i.setState(1);
				s.update(i);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String revokeInvoice(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Invoice v = (Invoice) s.get(Invoice.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=1){
				request.setAttribute("msgStr", "回退失败。");
				return SUCCESS;
			}else{
				v.setState(0);
				s.saveOrUpdate(v);
			}

			Vehicle vh = (Vehicle) s.get(Vehicle.class, vehicle.getCarframeNum());
			Invoice ispace = new Invoice();
			BeanUtils.copyProperties(ispace,vh, new String[]{"state","carframeNum"});
			s.saveOrUpdate(vh);

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String deleteInvoice(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Invoice v = (Invoice) s.get(Invoice.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String addTax(){
		Tax i = new Tax();
		BeanUtils.copyProperties(vehicle,i, new String[]{"state"});
		i.setState(0);
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			s.saveOrUpdate(i);
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String relookTax(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createQuery("from Tax where state=0");
			List<Tax> is = query.list();
			for(Tax i:is){
				Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
				BeanUtils.copyProperties(i,v, new String[]{"state"});
				s.update(v);
				i.setState(1);
				s.update(i);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String revokeTax(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Tax v = (Tax) s.get(Tax.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=1){
				request.setAttribute("msgStr", "回退失败。");
				return SUCCESS;
			}else{
				v.setState(0);
				s.saveOrUpdate(v);
			}

			Vehicle vh = (Vehicle) s.get(Vehicle.class, vehicle.getCarframeNum());
			Tax ispace = new Tax();
			BeanUtils.copyProperties(ispace,vh, new String[]{"state","carframeNum"});
			s.saveOrUpdate(vh);

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String deleteTax(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Tax v = (Tax) s.get(Tax.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String addLicence(){
		Vehicle v = vehicleService.selectById(vehicle);

		if(v==null){
			request.setAttribute("msgStr", "添加失败。车架号错误，该车不存在！");
			return SUCCESS;
		}

		String basePath = System.getProperty("com.dz.root") +"data/vehicle/"+vehicle.getCarframeNum()+"/";
		File base = new File(basePath);
		if (!base.exists()) {
			base.mkdirs();
		}
		if(StringUtils.length(photo)==30){
			FileUploadUtil.store(photo, new File(base,"license.jpg"));
		}

		License i = new License();
		BeanUtils.copyProperties(vehicle,i, new String[]{"state"});
		i.setState(0);
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			s.saveOrUpdate(i);
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String relookLicence(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createQuery("from License where state=0");
			List<License> is = query.list();
			for(License i:is){
				Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
				BeanUtils.copyProperties(i,v, new String[]{"state"});
				s.update(v);
				i.setState(1);
				s.update(i);

				Query q_c = s.createQuery("select c from Contract c where c.state in (2,3) and c.idNum=:idNum and c.carframeNum=:carframeNum ");
				q_c.setString("idNum", v.getDriverId());
				q_c.setString("carframeNum", v.getCarframeNum());
				q_c.setMaxResults(1);
				Contract c = (Contract) q_c.uniqueResult();

				if(c!=null){
					c.setCarNum(v.getLicenseNum());

					s.saveOrUpdate(c);

					Query q_va = s.createQuery("from VehicleApproval c where c.contractId=:cid and c.checkType=0 ");
					q_va.setInteger("cid", c.getId());
					q_va.setMaxResults(1);
					VehicleApproval approval = (VehicleApproval) q_va.uniqueResult();

					approval.setLicenseRegisterDate(v.getLicenseNumRegDate());
					approval.setOperateApplyDate(new Date());
					s.saveOrUpdate(approval);
				}

				Message msg = new Message();

				User u = (User) s.get(User.class, v.getLicenseRegister());
				msg.setFromUser(v.getLicenseRegister());
				msg.setTime(new Date());

				msg.setCarframeNum(v.getCarframeNum());
				msg.setType("车辆牌照录入完毕");
				msg.setMsg(String.format("%tF %s发：\n"
								+ "现有车%s(%s) 已录入完毕，可进行绑定承租人操作。",
						msg.getTime(),u.getUname(),
						v.getLicenseNum(),v.getCarframeNum()));

				s.saveOrUpdate(msg);

				Query q_us = s.createQuery("from RelationUr where rid in (select rid from Role where rname = '绑定承租人')");
				List<RelationUr> users = q_us.list();

				for (RelationUr relationUr : users) {
					MessageToUser mu = new MessageToUser();
					mu.setUid(relationUr.getUid());
					mu.setMid(msg.getId());
					mu.setAlreadyRead(false);
					s.saveOrUpdate(mu);
				}
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String deleteLicence(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			License v = (License) s.get(License.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String revokeLicence(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			License i = (License) s.get(License.class, vehicle.getCarframeNum());

			if(i == null||i.getState()!=1){
				request.setAttribute("msgStr", "回退失败。");
				return SUCCESS;
			}

			Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());

			Query q_c = s.createQuery("select c from Contract c where c.state=0 and c.idNum=:idNum and c.carframeNum=:carframeNum ");
			q_c.setString("idNum", v.getDriverId());
			q_c.setString("carframeNum", v.getCarframeNum());
			q_c.setMaxResults(1);
			Contract c = (Contract) q_c.uniqueResult();

			if(c!=null){
				request.setAttribute("msgStr", "合同已生效，不可修改。");
				return SUCCESS;
			}

			License ispace = new License();
			ispace.setCarframeNum(v.getCarframeNum());
			BeanUtils.copyProperties(ispace,v, new String[]{"state"});

			i.setState(0);
			s.saveOrUpdate(i);
			s.saveOrUpdate(v);

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	/**
	 * 添加计价器信息
	 */
	public String addService(){
		Vehicle v = vehicleService.selectById(vehicle);
		if(v==null){
			request.setAttribute("msgStr", "添加失败。车架号错误，该车不存在！");
			return SUCCESS;
		}

		ServiceInfo i = new ServiceInfo();
		BeanUtils.copyProperties(vehicle,i, new String[]{"state"});
		i.setState(0);
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			s.saveOrUpdate(i);
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String relookService(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createQuery("from ServiceInfo where state=0");
			List<ServiceInfo> is = query.list();
			for(ServiceInfo i:is){
				Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
				BeanUtils.copyProperties(i,v, new String[]{"state"});
				s.update(v);
				i.setState(1);
				s.update(i);

				Query q_c = s.createQuery("select c from Contract c where c.state in (2,3) and c.idNum=:idNum and c.carframeNum=:carframeNum ");
				q_c.setString("idNum", v.getDriverId());
				q_c.setString("carframeNum", v.getCarframeNum());
				q_c.setMaxResults(1);
				Contract c = (Contract) q_c.uniqueResult();

				if(c!=null){
					Query q_va = s.createQuery("from VehicleApproval c where c.contractId=:cid and c.checkType=0 ");
					q_va.setInteger("cid", c.getId());
					q_va.setMaxResults(1);
					VehicleApproval approval = (VehicleApproval) q_va.uniqueResult();
					approval.setOperateCardDate(v.getOperateCardTime());
					s.saveOrUpdate(approval);
				}

			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String deleteService(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			ServiceInfo v = (ServiceInfo) s.get(ServiceInfo.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}


	public String revokeService(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			ServiceInfo i = (ServiceInfo) s.get(ServiceInfo.class, vehicle.getCarframeNum());

			if(i == null||i.getState()!=1){
				request.setAttribute("msgStr", "回退失败。");
				return SUCCESS;
			}

			Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());

			ServiceInfo ispace = new ServiceInfo();
			BeanUtils.copyProperties(ispace,v, new String[]{"state","carframeNum"});

			i.setState(0);
			s.saveOrUpdate(i);
			s.saveOrUpdate(v);

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	/**
	 * 添加经营权信息
	 */
	public String addServiceRight(){
		Vehicle v = vehicleService.selectById(vehicle);
		if(v==null){
			request.setAttribute("msgStr", "添加失败。车架号错误，该车不存在！");
			return SUCCESS;
		}

		ServiceRightInfo i = new ServiceRightInfo();
		BeanUtils.copyProperties(vehicle,i, new String[]{"state"});
		i.setState(0);
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			s.saveOrUpdate(i);
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String relookServiceRight(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createQuery("from ServiceRightInfo where state=0");
			List<ServiceRightInfo> is = query.list();
			for(ServiceRightInfo i:is){
				Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
				BeanUtils.copyProperties(i,v, new String[]{"state"});
				s.update(v);
				i.setState(1);
				s.update(i);

				Query q_c = s.createQuery("select c from Contract c where c.state in (2,3) and c.idNum=:idNum and c.carframeNum=:carframeNum ");
				q_c.setString("idNum", v.getDriverId());
				q_c.setString("carframeNum", v.getCarframeNum());
				q_c.setMaxResults(1);
				Contract c = (Contract) q_c.uniqueResult();

				if(c!=null){
					Query q_va = s.createQuery("from VehicleApproval c where c.contractId=:cid and c.checkType=0 ");
					q_va.setInteger("cid", c.getId());
					q_va.setMaxResults(1);
					VehicleApproval approval = (VehicleApproval) q_va.uniqueResult();
					approval.setOperateCardDate(v.getOperateCardTime());
					s.saveOrUpdate(approval);
				}else{
					Query q_c1 = s.createQuery("select c from Contract c where c.state in (0,1) and c.idNum=:idNum and c.carframeNum=:carframeNum and planMaked=false");
					q_c1.setString("idNum", v.getDriverId());
					q_c1.setString("carframeNum", v.getCarframeNum());
					q_c1.setMaxResults(1);
					Contract c1 = (Contract) q_c1.uniqueResult();

					if(c1!=null){
						Query q_va = s.createQuery("from VehicleApproval c where c.contractId=:cid and c.checkType=0 ");
						q_va.setInteger("cid", c1.getId());
						q_va.setMaxResults(1);
						VehicleApproval approval = (VehicleApproval) q_va.uniqueResult();
						approval.setOperateCardDate(v.getOperateCardTime());
						s.saveOrUpdate(approval);

						//生成财务计划：
						c1.setPlanMaked(true);
						s.saveOrUpdate(c1);

						String planStr = c1.getPlanList();
						JSONArray jarr = JSONArray.fromObject(planStr);

						SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
						Date operateCardTime=i.getOperateCardTime();
						Calendar operateCardTimeCalendar=Calendar.getInstance();
						int discountDays = c1.getDiscountDays();
						operateCardTimeCalendar.setTime(operateCardTime);
						{
							int y = operateCardTimeCalendar.get(Calendar.YEAR);
							int m = operateCardTimeCalendar.get(Calendar.MONTH);
							int d = operateCardTimeCalendar.get(Calendar.DATE);

							//计算实际收费开始日期
							for (int j = 0; j < discountDays; j++) {
								d++;
								if ( d > 30) {
									d -= 30;
									m++;

									if ( m > 12) {
										m -= 12;
										y++;
									}
								}
							}

							operateCardTimeCalendar.set(Calendar.YEAR, y);
							operateCardTimeCalendar.set(Calendar.MONTH, m);
							operateCardTimeCalendar.set(Calendar.DATE, d);
						}
						User user  = (User) session.getAttribute("user");

						for(Object obj :jarr){
							JSONObject jobj = (JSONObject)obj;
							String beginStr = jobj.getString("begin");
							String endStr = jobj.getString("end");
							String moneyStr = jobj.getString("money");
							String comment = jobj.getString("comment");

							Calendar begin = Calendar.getInstance();
							begin.setTime(sdf.parse(beginStr));

							Calendar end = Calendar.getInstance();
							end.setTime(sdf.parse(endStr));

							BigDecimal money = BigDecimal.valueOf(Double.parseDouble(moneyStr));
							money.setScale(2, RoundingMode.HALF_EVEN);

							if(begin.before(operateCardTimeCalendar)){
								begin.setTime(operateCardTimeCalendar.getTime());
							}

							int month_rank = (begin.get(Calendar.DATE)>26?1:0);
							int local_months = (end.get(Calendar.YEAR) - begin.get(Calendar.YEAR)) * 12
									+ (end.get(Calendar.MONTH) - begin.get(Calendar.MONTH))
									+(begin.get(Calendar.DATE)<27?1:0)
									+(end.get(Calendar.DATE)>26?1:0);

							System.out.println(sdf.format(begin.getTime()));
							System.out.println(month_rank);
							System.out.println(local_months);

							for (int j=1;j<local_months-1;j++) {
								Calendar cd = (Calendar) begin.clone();
								cd.add(Calendar.MONTH, j+month_rank);
								cd.set(Calendar.DATE, 1);

								ChargePlan cp = new ChargePlan();
								cp.setFeeType("plan_base_contract");
								cp.setIsClear(false);
								cp.setRegister(user.getUname());
								cp.setContractId(c1.getId());
								cp.setFee(money);
								cp.setTime(cd.getTime());
								cp.setComment(comment);

								s.saveOrUpdate(cp);
							}

							if(local_months==1){
								//这一段时间在一个月里面
								int days = 0;
								if(begin.get(Calendar.DATE)==27&&end.get(Calendar.DATE)==26){
									days=30;
								}else
								if(begin.get(Calendar.DATE)>26){
									if(end.get(Calendar.DATE)>26){
										days = end.get(Calendar.DATE) - begin.get(Calendar.DATE) + 1;
									}else{
										//days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginArr[2]+1+parseInt(endArr[2]);
										days = 31 - begin.get(Calendar.DATE) + end.get(Calendar.DATE) + (begin.get(Calendar.DATE)>30?1:0);
									}
								}else{
									days = end.get(Calendar.DATE) - begin.get(Calendar.DATE) + 1;
								}
								BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));


								Calendar cd = (Calendar) begin.clone();
								cd.add(Calendar.MONTH, month_rank);
								cd.set(Calendar.DATE, 1);

								ChargePlan cp = new ChargePlan();
								cp.setFeeType("plan_base_contract");
								cp.setIsClear(false);
								cp.setRegister(user.getUname());
								cp.setContractId(c1.getId());
								cp.setFee(planOfRent);
								cp.setTime(cd.getTime());
								cp.setComment(comment);

								s.saveOrUpdate(cp);
							}else{
								//这一段时间分属不同的月
								//第一个月
								int days;
								if(begin.get(Calendar.DATE)==27){
									days=30;
								}else if(begin.get(Calendar.DATE)>27){
									//days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginArr[2]+27;
									days = 57 - begin.get(Calendar.DATE) + (begin.get(Calendar.DATE)>30?1:0);
								}else{
									days = 27 - begin.get(Calendar.DATE);
								}

								{
									BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));
									Calendar cd = (Calendar) begin.clone();
									cd.add(Calendar.MONTH, month_rank);
									cd.set(Calendar.DATE, 1);

									ChargePlan cp = new ChargePlan();
									cp.setFeeType("plan_base_contract");
									cp.setIsClear(false);
									cp.setRegister(user.getUname());
									cp.setContractId(c1.getId());
									cp.setFee(planOfRent);
									cp.setTime(cd.getTime());
									cp.setComment(comment);

									s.saveOrUpdate(cp);
								}

								//最后一个月
								if(end.get(Calendar.DATE)==26){
									days=30;
								}else if(end.get(Calendar.DATE)>=30){
									days = 4;
								}else if(end.get(Calendar.DATE)>26){
									days = end.get(Calendar.DATE) - 26;
								}else{
									//days = parseInt(getDaysOfMonth(endArr[0],endArr[1]-1))+parseInt(endArr[2])-26;
									days = 4 + end.get(Calendar.DATE);
								}
								{
									BigDecimal planOfRent = money.multiply(BigDecimal.valueOf(days/30.0));
									Calendar cd = (Calendar) begin.clone();
									cd.add(Calendar.MONTH, month_rank+local_months-1);
									cd.set(Calendar.DATE, 1);

									ChargePlan cp = new ChargePlan();
									cp.setFeeType("plan_base_contract");
									cp.setIsClear(false);
									cp.setRegister(user.getUname());
									cp.setContractId(c1.getId());
									cp.setFee(planOfRent);
									cp.setTime(cd.getTime());
									cp.setComment(comment);

									s.saveOrUpdate(cp);
								}
							}
						}// end of for each of the chargeplan

					}
				}

			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String deleteServiceRight(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			ServiceRightInfo v = (ServiceRightInfo) s.get(ServiceRightInfo.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String revokeServiceRight(){
		List<Role> roles = (List<Role>) session.getAttribute("roles");
		Optional<Role> roleOptional = roles.stream().filter(r->r.getRname().equals("营运证状态回退")).findAny();
		if (roleOptional.isPresent()){
			request.setAttribute("msgStr", "由于与合同计费发生挂钩，该功能需要“营运证状态回退”权限。");
		}else {
			Session s = null;
			Transaction tx = null;
			try {
				s = HibernateSessionFactory.getSession();
				tx = s.beginTransaction();
				ServiceRightInfo i = (ServiceRightInfo) s.get(ServiceRightInfo.class, vehicle.getCarframeNum());

				if (i == null || i.getState() != 1) {
					request.setAttribute("msgStr", "回退失败。");
					return SUCCESS;
				}
				i.setState(0);
				s.saveOrUpdate(i);
				tx.commit();
			}catch(HibernateException e){
				e.printStackTrace();
				if(tx!=null){
					tx.rollback();
				}
				request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
				return SUCCESS;
			}finally{
				HibernateSessionFactory.closeSession();
			}
			request.setAttribute("msgStr", "操作成功。");
		}
		return SUCCESS;

//		Session s = null;
//		Transaction tx = null;
//		try{
//			s = HibernateSessionFactory.getSession();
//			tx = s.beginTransaction();
//			ServiceRightInfo i = (ServiceRightInfo) s.get(ServiceRightInfo.class, vehicle.getCarframeNum());
//
//			if(i == null||i.getState()!=1){
//				request.setAttribute("msgStr", "回退失败。");
//				return SUCCESS;
//			}
//
//			Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
//
//			Query q_c = s.createQuery("select c from Contract c where c.state=0 and c.idNum=:idNum and c.carframeNum=:carframeNum ");
//			q_c.setString("idNum", v.getDriverId());
//			q_c.setString("carframeNum", v.getCarframeNum());
//			q_c.setMaxResults(1);
//			Contract c = (Contract) q_c.uniqueResult();
//
//			if(c!=null){
//				request.setAttribute("msgStr", "合同已生效，不可修改。");
//				return SUCCESS;
//			}
//
//			ServiceRightInfo ispace = new ServiceRightInfo();
//			ispace.setCarframeNum(v.getCarframeNum());
//			BeanUtils.copyProperties(ispace,v, new String[]{"state"});
//
//			i.setState(0);
//			s.saveOrUpdate(i);
//			s.saveOrUpdate(v);
//
//			tx.commit();
//		}catch(HibernateException e){
//			e.printStackTrace();
//			if(tx!=null){
//				tx.rollback();
//			}
//			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
//			return SUCCESS;
//		}finally{
//			HibernateSessionFactory.closeSession();
//		}
//		request.setAttribute("msgStr", "操作成功。");
//		return SUCCESS;
	}


	private Date beginDate,endDate;

	/**
	 *  查询 更新车 的新旧车了匹配，功能类似于SQL语句：
	 */
	public String vehicleFindMatch(){
		Session s = HibernateSessionFactory.getSession();
		Query query = s.createQuery(
				"select vold,vnew "
						+ "from Vehicle vold,Vehicle vnew "
						+ "WHERE vold.licenseNum = vnew.licensePurseNum "
						+ "AND vold.carframeNum != vnew.carframeNum "
						+ "AND vold.state=2 "
						+ "AND EXISTS("
						+ "SELECT 1 from Contract c "
						+ "WHERE c.carframeNum=vold.carframeNum "
						+ "AND c.contractEndDate>=:beginDate "
						+ "AND c.contractEndDate<=:endDate"
						+ ") "

						+ " UNION " +

						"select vold,vnew "
						+ "from Vehicle AS vold,Vehicle AS vnew "
						+ "WHERE vold.licenseNum = vnew.licensePurseNum "
						+ "AND vold.carframeNum != vnew.carframeNum "
						+ "AND vnew.state=1 "
						+ "AND EXISTS("
						+ "SELECT 1 from Contract c "
						+ "WHERE c.carframeNum=vnew.carframeNum "
						+ "AND c.contractBeginDate>=:beginDate "
						+ "AND c.contractBeginDate<=:endDate"
						+ ") "

		);

		Query query2 = s.createQuery(
				"select vold "
						+ "from Vehicle vold "
						+ "where vold.state=2 "
						+ "AND EXISTS("
						+ "SELECT 1 from Contract c "
						+ "WHERE c.carframeNum=vold.carframeNum "
						+ "AND c.contractEndDate>=:beginDate "
						+ "AND c.contractEndDate<=:endDate"
						+ ") "
						+ "and not exists("
						+ "SELECT 1 from Vehicle vnew "
						+ "WHERE vold.carframeNum != vnew.carframeNum "
						+ "AND vold.licenseNum = vnew.licensePurseNum "
						+ ")"
		);

		Query query3 = s.createQuery(
				"select vnew "
						+ "from Vehicle vnew "
						+ "where vnew.state=1 "
						+ "AND EXISTS("
						+ "SELECT 1 from Contract c "
						+ "WHERE c.carframeNum=vnew.carframeNum "
						+ "AND c.contractBeginDate>=:beginDate "
						+ "AND c.contractBeginDate<=:endDate"
						+ ") "
						+ "and not exists("
						+ "SELECT 1 from Vehicle vold "
						+ "WHERE vold.carframeNum != vnew.carframeNum "
						+ "AND vold.licenseNum = vnew.licensePurseNum "
						+ ")"
		);
		query.setDate("beginDate", beginDate);
		query.setDate("endDate", endDate);
		query2.setDate("beginDate", beginDate);
		query2.setDate("endDate", endDate);
		query3.setDate("beginDate", beginDate);
		query3.setDate("endDate", endDate);

		List<Object[]> pairlist = query.list();

		List<Vehicle> pairlist2 = query2.list();
		List<Vehicle> pairlist3 = query3.list();

		for (Vehicle vold : pairlist2) {
			pairlist.add(new Object[]{vold,null});
		}

		for (Vehicle vnew : pairlist3) {
			pairlist.add(new Object[]{null,vnew});
		}

		request.setAttribute("pairlist", pairlist);
		HibernateSessionFactory.closeSession();
		return SUCCESS;
	}

//	public static void main(String[] args) {
//		Session s = HibernateSessionFactory.getSession();
//		Query query = s.createQuery(
//				"select vold,vnew "
//				+ "from Vehicle vold,Vehicle vnew "
//				+ "WHERE vold.licenseNum = vnew.licensePurseNum "
//				+ "AND vold.carframeNum != vnew.carframeNum "
//				+ "AND vold.state=2 "
//				+ "AND EXISTS("
//					+ "SELECT 1 from Contract c "
//					+ "WHERE c.carframeNum=vold.carframeNum "
//					+ "AND c.contractEndDate>=:beginDate "
//					+ "AND c.contractEndDate<=:endDate"
//					+ ") "
//
//				+ " UNION " +
//
//				"select vold,vnew "
//				+ "from Vehicle AS vold,Vehicle AS vnew "
//				+ "WHERE vold.licenseNum = vnew.licensePurseNum "
//				+ "AND vold.carframeNum != vnew.carframeNum "
//				+ "AND vnew.state=1 "
//				+ "AND EXISTS("
//					+ "SELECT 1 from Contract c "
//					+ "WHERE c.carframeNum=vnew.carframeNum "
//					+ "AND c.contractBeginDate>=:beginDate "
//					+ "AND c.contractBeginDate<=:endDate"
//					+ ") "
//
//				);
//
//		Query query2 = s.createQuery(
//			"select vold "
//			+ "from Vehicle vold "
//			+ "where vold.state=2 "
//			+ "AND EXISTS("
//				+ "SELECT 1 from Contract c "
//				+ "WHERE c.carframeNum=vold.carframeNum "
//				+ "AND c.contractEndDate>=:beginDate "
//				+ "AND c.contractEndDate<=:endDate"
//				+ ") "
//			+ "and not exists("
//				+ "SELECT 1 from Vehicle vnew "
//				+ "WHERE vold.carframeNum != vnew.carframeNum "
//				+ "AND vold.licenseNum = vnew.licensePurseNum "
//			+ ")"
//				);
//
//		Query query3 = s.createQuery(
//				"select vnew "
//						+ "from Vehicle vnew "
//						+ "where vnew.state=1 "
//						+ "AND EXISTS("
//							+ "SELECT 1 from Contract c "
//							+ "WHERE c.carframeNum=vnew.carframeNum "
//							+ "AND c.contractBeginDate>=:beginDate "
//							+ "AND c.contractBeginDate<=:endDate"
//						+ ") "
//						+ "and not exists("
//							+ "SELECT 1 from Vehicle vold "
//							+ "WHERE vold.carframeNum != vnew.carframeNum "
//							+ "AND vold.licenseNum = vnew.licensePurseNum "
//						+ ")"
//							);
//
//
//		query.setDate("beginDate", new Date(117,4,1));
//		query.setDate("endDate", new Date(117,5,1));
//		query2.setDate("beginDate", new Date(117,4,1));
//		query2.setDate("endDate", new Date(117,5,1));
//		query3.setDate("beginDate", new Date(117,4,1));
//		query3.setDate("endDate", new Date(117,5,1));
//		List<Object[]> pairlist = query.list();
//		List<Vehicle> pairlist2 = query2.list();
//		List<Vehicle> pairlist3 = query3.list();
//
//		for (Vehicle vold : pairlist2) {
//			pairlist.add(new Object[]{vold,null});
//		}
//
//		for (Vehicle vnew : pairlist3) {
//			pairlist.add(new Object[]{null,vnew});
//		}
//
//		System.out.println(pairlist);
//	}

	private BusinessLicense businessLicense;

	public String addTrade(){
		Vehicle v = vehicleService.selectById(vehicle);
		if(v==null){
			request.setAttribute("msgStr", "添加失败。车架号错误，该车不存在！");
			return SUCCESS;
		}

		Trade i = new Trade();
		BeanUtils.copyProperties(businessLicense,i, new String[]{"state"});
		i.setCarframeNum(vehicle.getCarframeNum());
		i.setBusinessLicenseComment(vehicle.getBusinessLicenseComment());

		i.setState(0);

		String str = "";
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			s.saveOrUpdate(i);

			BusinessLicense bl = (BusinessLicense) s.get(BusinessLicense.class, i.getLicenseNum());
			if(bl!=null){
				str="注意：已存在一条资格证号相同的记录，审核时将自动覆盖。";
			}

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。"+str);
		return SUCCESS;
	}

	public String relookTrade(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Query query = s.createQuery("from Trade where state=0");
			List<Trade> is = query.list();
			for(Trade i:is){
				Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());
				BusinessLicense ls = new BusinessLicense();
				BeanUtils.copyProperties(i,ls, new String[]{"state"});
				s.saveOrUpdate(ls);

				v.setBusinessLicenseComment(i.getBusinessLicenseComment());
				v.setBusinessLicenseId(i.getLicenseNum());
				s.update(v);
				i.setState(1);
				s.update(i);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "添加失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String deleteTrade(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Trade v = (Trade) s.get(Trade.class, vehicle.getCarframeNum());
			if(v == null||v.getState()!=0){
				request.setAttribute("msgStr", "删除失败。");
				return SUCCESS;
			}else{
				s.delete(v);
			}
			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "删除失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	public String revokeTrade(){
		Session s = null;
		Transaction tx = null;
		try{
			s = HibernateSessionFactory.getSession();
			tx = s.beginTransaction();
			Trade i = (Trade) s.get(Trade.class, vehicle.getCarframeNum());

			if(i == null||i.getState()!=1){
				request.setAttribute("msgStr", "回退失败。");
				return SUCCESS;
			}

			Vehicle v = (Vehicle) s.get(Vehicle.class, i.getCarframeNum());

			BusinessLicense ls = (BusinessLicense) s.get(BusinessLicense.class, i.getLicenseNum());
			if(ls!=null){
				s.delete(ls);
			}

			v.setBusinessLicenseComment(null);
			v.setBusinessLicenseId(null);

			i.setState(0);
			s.saveOrUpdate(i);
			s.saveOrUpdate(v);

			tx.commit();
		}catch(HibernateException e){
			e.printStackTrace();
			if(tx!=null){
				tx.rollback();
			}
			request.setAttribute("msgStr", "回退失败。原因是"+e.getMessage());
			return SUCCESS;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		request.setAttribute("msgStr", "操作成功。");
		return SUCCESS;
	}

	private VehicleMode vehicleMode;
	public String vehicleSelectById(){
		Vehicle vs = vehicleService.selectById(vehicle);
		vs.setFirstDriver(vs.getFirstDriver()+ " ");
		vs.setSecondDriver(vs.getSecondDriver()+" ");
		vs.setThirdDriver(vs.getThirdDriver()+" ");
		vs.setForthDriver(vs.getForthDriver()+" ");

		vehicleMode  = (VehicleMode) ObjectAccess.getObject("com.dz.module.vehicle.VehicleMode", vs.getCarMode());

		this.vehicle = vs;

		jsonObject = vs;
		vehicle.setDriverId(vehicle.getDriverId()+" ");
		return "selectById";
	}

	public Object getJsonObject() {
		return jsonObject;
	}

	public void setJsonObject(Object jsonObject) {
		this.jsonObject = jsonObject;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getPhoto_tuoying() {
		return photo_tuoying;
	}

	public void setPhoto_tuoying(String photo_tuoying) {
		this.photo_tuoying = photo_tuoying;
	}

	public void setFileAccessUtil(FileAccessUtil fileAccessUtil) {
		this.fileAccessUtil = fileAccessUtil;
	}

	public Date getPd_begin() {
		return pd_begin;
	}

	public void setPd_begin(Date pd_begin) {
		this.pd_begin = pd_begin;
	}

	public Date getPd_end() {
		return pd_end;
	}

	public void setPd_end(Date pd_end) {
		this.pd_end = pd_end;
	}

	public Date getInDate_begin() {
		return inDate_begin;
	}

	public void setInDate_begin(Date inDate_begin) {
		this.inDate_begin = inDate_begin;
	}

	public Date getInDate_end() {
		return inDate_end;
	}

	public void setInDate_end(Date inDate_end) {
		this.inDate_end = inDate_end;
	}

	public Date getOperateCardTime_begin() {
		return operateCardTime_begin;
	}

	public void setOperateCardTime_begin(Date operateCardTime_begin) {
		this.operateCardTime_begin = operateCardTime_begin;
	}

	public Date getOperateCardTime_end() {
		return operateCardTime_end;
	}

	public void setOperateCardTime_end(Date operateCardTime_end) {
		this.operateCardTime_end = operateCardTime_end;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public Date getGetCarDate() {
		return getCarDate;
	}

	public void setGetCarDate(Date getCarDate) {
		this.getCarDate = getCarDate;
	}

	public BusinessLicense getBusinessLicense() {
		return businessLicense;
	}

	public void setBusinessLicense(BusinessLicense businessLicense) {
		this.businessLicense = businessLicense;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
}
