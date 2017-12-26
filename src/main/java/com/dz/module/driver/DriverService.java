package com.dz.module.driver;

import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;

import org.apache.commons.lang.BooleanUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.javatuples.Triplet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class DriverService {
	@Autowired
	private DriverDao driverDao;
	
	public DriverService(){
		
	}

	public boolean appendScore(Driver driver){
		return driverDao.appendScore(driver.getIdNum(),driver.getBangonshifuzeren(),driver.getScore(),driver.getBangonshifuzerenyijian());
	}
	public boolean appendCaiWu(Driver driver){
		return driverDao.appendCaiWu(driver.getIdNum(),driver.getCaiwufuzeren(),driver.getFuwubaozhengjin(),driver.getCaiwufuzerenyijian());
	}
	public Driver selectById(String idNum){
		return driverDao.selectById(idNum);
	}
	
	public boolean driverAdd(Driver driver, List<Families> families) {
		User user = ((User)ServletActionContext.getRequest().getSession().getAttribute("user"));
		if (driver == null) {
			return false;
		}
		
		driver.setIsInCar(false);
		driver.setRegistrant(user.getUid());
		
		if(families != null)
		{
			for (int i = 0; i < families.size(); i++)
				families.get(i).setIdNum(driver.getIdNum());
		}
		return driverDao.driverAdd(driver, families);
	}
	
	public boolean driverUpdate(Driver driver, List<Families> families) {
		if (driver == null) {
			return false;
		}
		
		Driver d = driverDao.selectById(driver.getIdNum());
		if(d==null){
			//该司机不存在
			return false;
		}
		if(d.getStatus() != 0)
			driver.setStatus(d.getStatus());
		
		if(families != null)
		{
			for (int i = 0; i < families.size(); i++)
				families.get(i).setIdNum(driver.getIdNum());
		}
		
		driver.setShenqingren(d.getShenqingren());
		driver.setLururen(d.getLururen());
		driver.setBangonshifuzeren(d.getBangonshifuzeren());
		driver.setCaiwufuzeren(d.getCaiwufuzeren());
		driver.setBangonshifuzerenyijian(d.getBangonshifuzerenyijian());
		driver.setCaiwufuzerenyijian(d.getCaiwufuzerenyijian());
		driver.setFuwubaozhengjin(d.getFuwubaozhengjin());
		driver.setApplyTime(d.getApplyTime());

		driver.setBusinessApplyTime(d.getBusinessApplyTime());
		driver.setBusinessApplyRegistrant(d.getBusinessApplyRegistrant());
		driver.setBusinessApplyRegistTime(d.getBusinessApplyRegistTime());
		driver.setBusinessReciveTime(d.getBusinessReciveTime());
		driver.setBusinessReciveRegistrant(d.getBusinessReciveRegistrant());
		driver.setBusinessReciveRegistTime(d.getBusinessReciveRegistTime());
		driver.setBusinessApplyCancelTime(d.getBusinessApplyCancelTime());
		driver.setBusinessApplyCancelRegistrant(d.getBusinessApplyCancelRegistrant());
		driver.setBusinessApplyCancelRegistTime(d.getBusinessApplyCancelRegistTime());
		driver.setBusinessReciveCancelTime(d.getBusinessReciveCancelTime());
		driver.setBusinessReciveCancelRegistrant(d.getBusinessReciveCancelRegistrant());
		driver.setBusinessReciveCancelRegistTime(d.getBusinessReciveCancelRegistTime());
		driver.setBusinessApplyState(d.getBusinessApplyState());
		driver.setBusinessApplyCancelState(d.getBusinessApplyCancelState());
		
		driver.setBusinessApplyCarframeNum(d.getBusinessApplyCarframeNum());
		driver.setBusinessApplyDriverClass(d.getBusinessApplyDriverClass());
		
		driver.setCarframeNum(d.getCarframeNum());
		driver.setIsInCar(d.getIsInCar());
		driver.setDept(d.getDept());
		driver.setHasBadRecord(d.getHasBadRecord());
		driver.setBreakRecord(d.getBreakRecord());
		driver.setAccidentRecord(d.getAccidentRecord());
		driver.setInsertTime(d.getInsertTime());
		driver.setIsQualified(d.getIsQualified());
		driver.setIsContractorPassed(d.getIsContractorPassed());
		//driver.setApplyLicenseNum(d.getApplyLicenseNum());
		driver.setScore(d.getScore());
		
		return driverDao.driverUpdate(driver, families);
	}
	
	public boolean driverSaveOrUpdate(Driver driver, List<Families> families){
		if (driver == null) {
			return false;
		}
		
		Driver d = driverDao.selectById(driver.getIdNum());
		if(d==null){//该司机不存在
			//TODO 此处由于不存在培训与承租人员审批过程，故全部直接设为true
			//TODO 将来加入 培训与承租人员审批过程 时应全部设为false
			driver.setIsQualified(true);
			driver.setIsContractorPassed(true);
			return this.driverAdd(driver, families);
		}
		return this.driverUpdate(driver, families);
	}
	
	public int driverSearchTotal(){
		return driverDao.searchCount((Triplet<String,String,Object>[]) null);
	}
	
	public List<Driver> driverSearch(Page page){
		return driverDao.search(page,(Triplet<String,String,Object>[])null);
	}

	@Deprecated
	public List<Driver> driverSearchCondition(Page page, String idNum,
			Date beginDate, Date endDate, Boolean isInCar,Triplet<String, String, Object>... conditions) {
		
		return driverDao.driverSearchCondition(page,idNum,beginDate,endDate,isInCar,conditions);
	}
	
	@Deprecated
	public int driverSearchConditionTotal(String idNum, Date beginDate,
			Date endDate, Boolean isInCar,Triplet<String, String, Object>... conditions){
		return driverDao.driverSearchConditionTotal(idNum, beginDate, endDate, isInCar,conditions);
	}
	
	public Boolean addBadRecord(Driver driver,String reason){
		if(driver != null ){
			Driver d = driverDao.selectById(driver.getIdNum());
			if(d!=null&&BooleanUtils.isNotTrue(d.getBadRecord())){
				driverDao.addBadRecord(driver, reason);
				return true;
			}
		}
		return false;
	}
	public Boolean removeBadRecord(Driver driver){
		if(driver != null ){
			Driver d = driverDao.selectById(driver.getIdNum());
			if(d!=null){
				driverDao.deleteBadRecord(driver);
				return true;
			}
		}
		return false;
	}
	
	@Deprecated
	public List<Driver> searchAllBadDriver(){
		return driverDao.searchAllBadDriver();
	}
	
	public void setDriverDao(DriverDao driverDao) {
		this.driverDao = driverDao;
	}
	
	public DriverDao getDriverDao() {
		return driverDao;
	}
	public boolean updateStar(Driver driver){
		return driverDao.updateStar(driver);
	}

	@Deprecated
	public List<Vehicle> driverCarSearch(Page page, String idName, String idNum, String linence_num) {		
		return driverDao.driverCarSearch(page,idName,idNum,linence_num);
	}

	@Deprecated
	public int driverCarSearchTotal(String idName, String idNum,
			String linence_num) {
		return driverDao.driverCarSearchTotal(idName,idNum,linence_num);
	}
	
	public Driver selectByName(String name,String carframeNum) {
		return ObjectAccess.execute("from Driver d where d.name='"+name+"' and (d.carframeNum='"+carframeNum+"' or d.businessApplyCarframeNum='"+carframeNum+"' )");
	}
	
	public List<Families> selectFamily(Driver driver){
		return driverDao.selectFamily(driver);
	}
	
	public void addDriverInCarRecord(Driverincar record) {
		driverDao.addDriverInCarRecord(record);
	}
	
	@Deprecated
	public int selectDriverInCarByConditionCount(Date beginDate,Date endDate,Vehicle vehicle,Driver driver, String operation, Boolean finished) {
		return driverDao.selectDriverInCarByConditionCount(beginDate, endDate, vehicle, driver,operation,finished);
	}
	
	@Deprecated
	public List<Driverincar> selectDriverInCarByCondition(Page page,Date beginDate,Date endDate,Vehicle vehicle,Driver driver, String operation, Boolean finished) {
		return driverDao.selectDriverInCarByCondition(page, beginDate, endDate, vehicle, driver,operation,finished);
	}
	
	@Deprecated
	public int driverSearchConditionTotal( Date beginDate,
			Date endDate,Driver driver) throws HibernateException {
		return driverDao.driverSearchConditionTotal(beginDate, endDate, driver);
	}
	
	@Deprecated
	public List<Driver> driverSearchCondition(Page page, 
			Date beginDate, Date endDate, Driver driver)
			throws HibernateException {
		return driverDao.driverSearchCondition(page, beginDate, endDate, driver);
	}
	
	public void addLeaveRecord(Driverleave record) {
		driverDao.addLeaveRecord(record);
	}

	public int selectDriverLeaveByConditionCount(Date beginDate, Date endDate,
			Vehicle vehicle, Driver driver, Boolean finished, String operation) {
		return driverDao.selectDriverLeaveByConditionCount(beginDate, endDate, vehicle, driver,finished,operation);
	}

	public List<Driverleave> selectDriverLeaveByCondition(Page page, Date beginDate,
			Date endDate, Vehicle vehicle, Driver driver, Boolean finished, String operation) {
		return driverDao.selectDriverLeaveByCondition(page, beginDate, endDate, vehicle, driver,finished,operation);
	}
	
	int searchCount(Triplet<String, String, Object>... conditions) {
		return driverDao.searchCount(conditions);
	}

	List<Driver> search(Page page, Triplet<String, String, Object>... conditions) {
		return driverDao.search(page, conditions);
	}
}
