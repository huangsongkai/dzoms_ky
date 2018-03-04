package com.dz.module.driver;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.vehicle.Vehicle;

import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.javatuples.Triplet;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository(value="dirverDao")
public class DriverDaoImpl implements DriverDao {

	@Override
	public boolean appendScore(String idNum, String bangonshifuzeren, float score, String bangonshifuzerenyijian) {
		Session session = null;
		Transaction tx = null;
		Driver driver = null;
		try{
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			driver = (Driver) session.get(Driver.class,idNum);
			driver.setStatus(2);
			driver.setScore(score);
			driver.setBangonshifuzeren(bangonshifuzeren);
			driver.setBangonshifuzerenyijian(bangonshifuzerenyijian);
			session.update(driver);
			tx.commit();
			return true;
		}catch(HibernateException he){
			if(tx != null){
				tx.rollback();
				return false;
			}
			he.printStackTrace();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return true;
	}

	@Override
	public boolean appendCaiWu(String idNum, String caiwufuzeren, BigDecimal fuwubaozhengjin, String caiwufuzerenyijian) {
		Session session = null;
		Transaction tx = null;
		Driver driver = null;
		try{
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			driver = (Driver) session.get(Driver.class,idNum);
			driver.setStatus(3);
			driver.setCaiwufuzeren(caiwufuzeren);
			driver.setCaiwufuzerenyijian(caiwufuzerenyijian);
			driver.setFuwubaozhengjin(fuwubaozhengjin);
			
			if(driver.getBusinessApplyTime()==null||driver.getBusinessApplyTime().before(new Date(50,0,1))){
				driver.setBusinessApplyTime(null);
				driver.setBusinessApplyRegistrant(null);
				driver.setBusinessApplyRegistTime(null);
				driver.setBusinessApplyState(null);
			}
			
			if(driver.getBusinessReciveTime()==null||driver.getBusinessReciveTime().before(new Date(50,0,1))){
				driver.setBusinessReciveTime(null);
				driver.setBusinessReciveRegistrant(null);
				driver.setBusinessReciveRegistTime(null);
			}
			
			if(driver.getBusinessApplyCancelTime()==null||driver.getBusinessApplyCancelTime().before(new Date(50,0,1))){
				driver.setBusinessApplyCancelTime(null);
				driver.setBusinessApplyCancelRegistrant(null);
				driver.setBusinessApplyCancelRegistTime(null);
			}

			if(driver.getBusinessReciveCancelTime()==null||driver.getBusinessReciveCancelTime().before(new Date(50,0,1))){
				driver.setBusinessReciveCancelTime(null);
				driver.setBusinessReciveCancelRegistrant(null);
				driver.setBusinessReciveCancelRegistTime(null);
				driver.setBusinessApplyCancelState(null);
			}
			
			session.update(driver);
			tx.commit();
			return true;
		}catch(HibernateException he){
			if(tx != null){
				tx.rollback();
				return false;
			}
			he.printStackTrace();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return true;
	}

	@Override
	public boolean  addBadRecord(Driver driver,String reason) {
		Session session = null;
		Transaction tx = null;
		try{ 
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			driver = (Driver) session.get(Driver.class,driver.getIdNum());
			driver.setBadRecord(true);
			driver.setBadRecordReason(reason);
			session.update(driver);
			tx.commit();
			return true;
		}catch(HibernateException he){
			if(tx != null){
				tx.rollback();
				return false;
			}
			he.printStackTrace();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return true;
	}

	@Override
	public boolean deleteBadRecord(Driver driver) {
		Session session = null;
		Transaction tx = null;
		try{
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			driver = (Driver) session.get(Driver.class,driver.getIdNum());
			driver.setBadRecord(false);
			driver.setBadRecordReason(null);
			session.update(driver);
			tx.commit();
			return true;
		}catch(HibernateException he){
			if(tx != null){
				tx.rollback();
				return false;
			}
			he.printStackTrace();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return true;
	}

	@Override
	public boolean driverAdd(Driver driver, List<Families> families)
			throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();

			session.save(driver);
			if(families != null)
			{
				for (int i = 0; i < families.size(); i++)
					session.save(families.get(i));
			}

			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public boolean driverUpdate(Driver driver, List<Families> families) throws HibernateException{
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();

			session.update(driver);
			
			Query query = session.createQuery("from Families f where f.idNum = :driver_id");
			query.setString("driver_id", driver.getIdNum());
			@SuppressWarnings("unchecked")
			List<Families> oldFamilies = query.list();
			if(oldFamilies != null)
			{
				for (int i = 0; i < oldFamilies.size(); i++)
					session.delete(oldFamilies.get(i));
			}
			
			if(families != null)
			{
				for (int i = 0; i < families.size(); i++)
					session.save(families.get(i));
			}

			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}
	
	@Override
	public Driver selectByName(String name) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			String str = "from Driver where name = :name ";
			Query query = session.createQuery(str);
			query.setString("name", name);
			return (Driver) query.uniqueResult();
		}catch(HibernateException he){	
			he.printStackTrace();
		}
		return null;
	}

	@Override
	public Driver selectById(String idNum){
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			Driver d = (Driver) session.get(Driver.class, idNum);
			return d;
		}catch(HibernateException e) {
			return null;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Families> selectFamily(Driver driver) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Families where idNum=:idNum");
			query.setString("idNum", driver.getIdNum());
			return query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		
	}
	
	@Override
	public int searchCount(Triplet<String, String, Object>... conditions){
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql = "select count(*) from Driver where 1=1 ";
			
			if(conditions!=null)
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format("and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}
			
			Query query = session.createQuery(sql);
			
			if(conditions!=null)
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}
			
			return Integer.parseInt(query.uniqueResult().toString());
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Driver> search(Page page,Triplet<String, String, Object>... conditions){
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql = "from Driver where 1=1 ";
			
			if(conditions!=null)
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format("and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}
			
			Query query = session.createQuery(sql);
			
			if(conditions!=null)
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}
			
			if(page!=null){
				query.setMaxResults(page.getEveryPage());
				query.setFirstResult(page.getBeginIndex());
			}
			
			return query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Driver> driverSearch(Page page) throws HibernateException {
		List<Driver> l = new ArrayList<Driver>();
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Driver");
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			l = query.list();
			
//			for(Driver driver : l){
//				System.out.println(driver.getApplyMatter());
//			}
			
			query = null;
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@SuppressWarnings("unchecked")
	public List<Driver> driverSearchCondition(Page page, String idNum,
			Date beginDate, Date endDate, Boolean isInCar,Triplet<String, String, Object>... conditions)
			throws HibernateException  {
		List<Driver> l = new ArrayList<Driver>();
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql = "from Driver where 1=1 ";
			
			if(!StringUtils.isEmpty(idNum)){
				sql+="and idNum like :idNum ";
			}
			
			if(beginDate!=null){
				sql+="and applyTime>:beginDate ";
			}
			if(endDate!=null){
				sql+="and applyTime<:endDate ";
			}
			
			if(isInCar!=null)
				sql+="and isInCar=:isInCar";
			
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format("and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}
			
			System.out.println(sql);
			Query query = session
					.createQuery(sql);
			
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}
			
			if(!StringUtils.isEmpty(idNum)){
				query.setString("idNum", "%"+idNum+"%");
			}
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			if(isInCar!=null)
				query.setBoolean("isInCar", isInCar);
			
			if(page!=null){
				query.setMaxResults(page.getEveryPage());
				query.setFirstResult(page.getBeginIndex());
			}
			
			l = query.list();
			query = null;
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	public int driverSearchConditionTotal(String idNum, Date beginDate,
			Date endDate, Boolean isInCar,Triplet<String, String, Object>... conditions) throws HibernateException {
		Session session = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			String sql = "select count(*) from Driver where 1=1 ";
			
			if(!StringUtils.isEmpty(idNum)){
				sql+="and idNum like :idNum ";
			}
			
			if(beginDate!=null){
				sql+="and applyTime>:beginDate ";
			}
			if(endDate!=null){
				sql+="and applyTime<:endDate ";
			}
			
			if((isInCar)!=null)
				sql+="and isInCar=:isInCar";

			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format("and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}
			
			System.out.println(sql);
			Query query = session
					.createQuery(sql);
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}
			if(!StringUtils.isEmpty(idNum)){
				query.setString("idNum", "%"+idNum+"%");
			}
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			if(isInCar!=null)
				query.setBoolean("isInCar", isInCar);
			
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}

	@Override
	public int driverSearchTotal() throws HibernateException {
		Session session = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("select count(*) from Driver");
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		System.out.print(c+"");
		return c;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Driver> searchAllBadDriver() {
		Session session = null;
		List<Driver> list = null;
		try{
			session = HibernateSessionFactory.getSession();
			String str = "from Driver where badRecord = true ";
			list = (List<Driver>) session.createQuery(str).list();
		}catch(HibernateException he){	
			he.printStackTrace();
			list = new ArrayList<>();
		}
		return list;
	}
	
	
	
 @Override
    public boolean updateStar(Driver driver) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Driver sql_driver = (Driver)session.get(driver.getIdNum(),Driver.class);
            sql_driver.setStar(driver.getStar());
            trans.commit();
            return true;
        }catch (HibernateException he){
            he.printStackTrace();
            if(trans != null){
                trans.rollback();
            }
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return false;
    }

 @SuppressWarnings("unchecked")
@Override
 public List<Vehicle> driverCarSearch(Page page, String idName, String idNum,
		 String linence_num) {

	 Session session = null;
	 List<Vehicle> list = null;
	 try{
		 session = HibernateSessionFactory.getSession();
		 String str = "from Vehicle v where v.licenseNum like '%"+linence_num+"%' &&"
		 		+ " v.driverId in (select d.driverId from Driver d where d.idNum like '%"+idNum+"%' &&"
		 		+ " d.name like '%"+idName+"%')";
		 Query query = session.createQuery(str);
		 query.setMaxResults(page.getEveryPage());
		 query.setFirstResult(page.getBeginIndex());
		 list = (List<Vehicle>) query.list();
	 }catch(HibernateException he){	
		 he.printStackTrace();
		 list = new ArrayList<Vehicle>();
	 }
	 return list;
 }

@Override
public int driverCarSearchTotal(String idName, String idNum, String linence_num) {
	 Session session = null;
	 try{
		 session = HibernateSessionFactory.getSession();
		 String str = "select count(*) from Vehicle v where v.licenseNum like '%"+linence_num+"%' &&"
		 		+ " v.driverId in (select d.driverId from Driver d where d.idNum like '%"+idNum+"%' &&"
		 		+ " d.name like '%"+idName+"%')";
		 Query query = session.createQuery(str);
		
		 return Integer.parseInt(query.uniqueResult().toString());
	 }catch(HibernateException he){	
		 he.printStackTrace();
	 }
	return 0;
}



@Override
public void addDriverInCarRecord(Driverincar record) {
	Session session = null;
	Transaction tx = null;
	try{ 
		session = HibernateSessionFactory.getSession();
		tx = session.beginTransaction();
		session.save(record);
		tx.commit();
	}catch(HibernateException he){
		if(tx != null){
			tx.rollback();
		}
		he.printStackTrace();
	}finally{
		HibernateSessionFactory.closeSession();
	}
}

@Override
public int selectDriverInCarByConditionCount(Date beginDate,Date endDate,Vehicle vehicle, Driver driver, String operation, Boolean finished) {
	Session session = null;
	try {
		session = HibernateSessionFactory.getSession();
		String sql = "select count(*) from Driverincar where 1=1 ";
		
		if(beginDate!=null){
			sql+="and opeTime>:beginDate ";
		}
		if(endDate!=null){
			sql+="and opeTime<:endDate ";
		}
		
		if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
			sql+="and carframeNum like :carframeNum ";
		}
		
		if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
			sql+="and carframeNum in (select carframeNum from Vehicle where licenseNum like :licenseNum ) ";
		}
		
		if(!StringUtils.isEmpty(vehicle.getDept())){
			sql+="and carframeNum in (select carframeNum from Vehicle where dept like :dept ) ";
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			sql+="and idNumber like :idNum ";
		}
		
		if(!StringUtils.isEmpty(operation)){
			sql+="and operation like :operation ";
		}
		
		if(finished!=null){
			sql+="and finished = :finished ";
		}
		
		Query query = session.createQuery(sql);
		
		if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
			query.setString("carframeNum", "%"+vehicle.getCarframeNum()+"%");
		}
		
		if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
			query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
		}
		
		if(!StringUtils.isEmpty(vehicle.getDept())){
			query.setString("dept", "%"+vehicle.getDept()+"%");
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			query.setString("idNum", "%"+driver.getIdNum()+"%");
		}
		
		if(beginDate!=null){
			query.setDate("beginDate", beginDate);
		}
		if(endDate!=null){
			query.setDate("endDate", endDate);
		}
		
		if(!StringUtils.isEmpty(operation)){
			query.setString("operation", "%"+operation+"%");
		}
		
		if(finished!=null){
			query.setBoolean("finished", finished);
			sql+="and finished = :finished ";
		}
		
		return Integer.parseInt(query.uniqueResult().toString());
	} catch (HibernateException e) {
		throw e;
	} finally {
		HibernateSessionFactory.closeSession();
	}
}

@SuppressWarnings("unchecked")
@Override
public List<Driverincar> selectDriverInCarByCondition(Page page,Date beginDate,Date endDate,
		Vehicle vehicle, Driver driver, String operation, Boolean finished) {
	Session session = null;
	try {
		session = HibernateSessionFactory.getSession();
		String sql = "from Driverincar where 1=1 ";
		
		if(beginDate!=null){
			sql+="and opeTime>:beginDate ";
		}
		if(endDate!=null){
			sql+="and opeTime<:endDate ";
		}
		
		if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
			sql+="and carframeNum like :carframeNum ";
		}
		
		if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
			sql+="and carframeNum in (select carframeNum from Vehicle where licenseNum like :licenseNum ) ";
		}
		
		if(!StringUtils.isEmpty(vehicle.getDept())){
			sql+="and carframeNum in (select carframeNum from Vehicle where dept like :dept ) ";
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			sql+="and idNumber like :idNum ";
		}
		
		if(!StringUtils.isEmpty(operation)){
			sql+="and operation like :operation ";
		}
		
		if(finished!=null){
			sql+="and finished = :finished ";
		}
		
		Query query = session.createQuery(sql);
		
		if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
			query.setString("carframeNum", "%"+vehicle.getCarframeNum()+"%");
		}
		
		if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
			query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
		}
		
		if(!StringUtils.isEmpty(vehicle.getDept())){
			query.setString("dept", "%"+vehicle.getDept()+"%");
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			query.setString("idNum", "%"+driver.getIdNum()+"%");
		}
		
		if(beginDate!=null){
			query.setDate("beginDate", beginDate);
		}
		if(endDate!=null){
			query.setDate("endDate", endDate);
		}
		
		if(!StringUtils.isEmpty(operation)){
			query.setString("operation", "%"+operation+"%");
		}
		
		if(finished!=null){
			query.setBoolean("finished", finished);
			sql+="and finished = :finished ";
		}
		
		if(page!=null){
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
		}
		return query.list();
	} catch (HibernateException e) {
		throw e;
	} finally {
		HibernateSessionFactory.closeSession();
	}
}

@SuppressWarnings("unchecked")
@Override
public List<Driver> driverSearchCondition(Page page, 
		Date beginDate, Date endDate,Driver driver)
		throws HibernateException  {
	Session session = null;
	try {
		session = HibernateSessionFactory.getSession();
		String sql = "from Driver d where 1=1 ";
		
		if(BooleanUtils.isTrue(driver.getIsInCar())){
			sql = "select d from Driver d,Vehicle v where v.carframeNum = d.carframeNum ";
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			sql+="and d.idNum like :idNum ";
		}
		
		if(!StringUtils.isEmpty(driver.getName())){
			sql+="and d.name like :name ";
		}
		
		if(!StringUtils.isEmpty(driver.getDept())){
			sql+="and d.dept like :dept ";
		}
		
		if(!StringUtils.isEmpty(driver.getTeam())){
			sql+="and d.team like :team ";
		}
		
		if(beginDate!=null){
			sql+="and d.applyTime>:beginDate ";
		}
		if(endDate!=null){
			sql+="and d.applyTime<:endDate ";
		}
		
		if(driver.getIsInCar()!=null)
			sql+="and d.isInCar=:isInCar";
		
		if(BooleanUtils.isTrue(driver.getIsInCar())){
			sql+=" order by v.licenseNum ";
		}

		Query query = session
				.createQuery(sql);
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			query.setString("idNum", "%"+driver.getIdNum()+"%");
		}
		
		if(!StringUtils.isEmpty(driver.getName())){
			query.setString("name", "%"+driver.getName()+"%");
		}
		
		if(beginDate!=null){
			query.setDate("beginDate", beginDate);
		}
		
		if(endDate!=null){
			query.setDate("endDate", endDate);
		}
		
		if(!StringUtils.isEmpty(driver.getDept())){
			query.setString("dept", "%"+driver.getDept()+"%");
			sql+="and dept like :dept ";
		}
		
		if(!StringUtils.isEmpty(driver.getTeam())){
			query.setString("team", "%"+driver.getTeam()+"%");
			sql+="and team like :team ";
		}
		
		if(driver.getIsInCar()!=null)
			query.setBoolean("isInCar", driver.getIsInCar());
		
		if(page!=null){
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
		}
		return query.list();
	} catch (HibernateException e) {
		throw e;
	} finally {
		HibernateSessionFactory.closeSession();
	}
}

@Override
public int driverSearchConditionTotal(Date beginDate,
		Date endDate, Driver driver) throws HibernateException {
	Session session = null;
	try {
		session = HibernateSessionFactory.getSession();
		String sql = "select count(*) from Driver where 1=1 ";
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			sql+="and idNum like :idNum ";
		}
		
		if(!StringUtils.isEmpty(driver.getDept())){
			sql+="and dept like :dept ";
		}
		
		if(!StringUtils.isEmpty(driver.getTeam())){
			sql+="and team like :team ";
		}
		
		if(beginDate!=null){
			sql+="and applyTime>:beginDate ";
		}
		if(endDate!=null){
			sql+="and applyTime<:endDate ";
		}
		
		if(driver.getIsInCar()!=null)
			sql+="and isInCar=:isInCar";

		Query query = session
				.createQuery(sql);
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			query.setString("idNum", "%"+driver.getIdNum()+"%");
		}
		
		if(beginDate!=null){
			query.setDate("beginDate", beginDate);
		}
		
		if(endDate!=null){
			query.setDate("endDate", endDate);
		}
		
		if(!StringUtils.isEmpty(driver.getDept())){
			query.setString("dept", "%"+driver.getDept()+"%");
			sql+="and dept like :dept ";
		}
		
		if(!StringUtils.isEmpty(driver.getTeam())){
			query.setString("team", "%"+driver.getTeam()+"%");
			sql+="and team like :team ";
		}
		
		if(driver.getIsInCar()!=null)
			query.setBoolean("isInCar", driver.getIsInCar());
		
		return  Integer.parseInt(query.uniqueResult().toString());
	} catch (HibernateException e) {
		throw e;
	} finally {
		HibernateSessionFactory.closeSession();
	}
}

@Override
public void addLeaveRecord(Driverleave record) {
	Session session = null;
	Transaction tx = null;
	try{ 
		session = HibernateSessionFactory.getSession();
		tx = session.beginTransaction();
		session.save(record);
		tx.commit();
	}catch(HibernateException he){
		if(tx != null){
			tx.rollback();
		}
		he.printStackTrace();
	}finally{
		HibernateSessionFactory.closeSession();
	}
}

@Override
public int selectDriverLeaveByConditionCount(Date beginDate,Date endDate,Vehicle vehicle, Driver driver, Boolean finished,String operation) {
	Session session = null;
	try {
		session = HibernateSessionFactory.getSession();
		String sql = "select count(*) from Driverleave where finished=:finished ";
		
		if(beginDate!=null){
			sql+="and opeTime>:beginDate ";
		}
		if(endDate!=null){
			sql+="and opeTime<:endDate ";
		}

		if(vehicle!=null){
			String vehicleCondition="select carframeNum from Vehicle where 1=1 ";
			if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
				vehicleCondition+="and carframeNum like :carframeNum ";
			}

			if(!StringUtils.isEmpty(vehicle.getDept())){
				vehicleCondition+="and dept = :dept ";
			}

			sql += String.format("and carframeNum in (%s) ", vehicleCondition);
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			sql+="and idNumber like :idNum ";
		}
		
		if(!StringUtils.isEmpty(operation)){
			sql+="and operation like :operation ";
		}

		Query query = session.createQuery(sql);
		
		query.setBoolean("finished", finished);

		if(vehicle!=null){
			if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
				query.setString("carframeNum", "%"+vehicle.getCarframeNum()+"%");
			}
			if(!StringUtils.isEmpty(vehicle.getDept())){
				query.setString("dept", vehicle.getDept());
			}
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			query.setString("idNum", "%"+driver.getIdNum()+"%");
		}
		
		if(beginDate!=null){
			query.setDate("beginDate", beginDate);
		}
		if(endDate!=null){
			query.setDate("endDate", endDate);
		}
		
		if(!StringUtils.isEmpty(operation)){
			query.setString("operation","%"+operation+"%");
		}
		
		return Integer.parseInt(query.uniqueResult().toString());
	} catch (HibernateException e) {
		throw e;
	} finally {
		HibernateSessionFactory.closeSession();
	}
}

@SuppressWarnings("unchecked")
@Override
public List<Driverleave> selectDriverLeaveByCondition(Page page,Date beginDate,Date endDate,
		Vehicle vehicle, Driver driver, Boolean finished,String operation) {
	Session session = null;
	try {
		session = HibernateSessionFactory.getSession();
		String sql = "select dl from Driverleave dl,Vehicle v where dl.carframeNum=v.carframeNum and finished=:finished ";
		
		if(beginDate!=null){
			sql+="and dl.opeTime>:beginDate ";
		}
		if(endDate!=null){
			sql+="and dl.opeTime<:endDate ";
		}

		if(vehicle!=null){
			if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
				sql+="and v.carframeNum like :carframeNum ";
			}

			if(!StringUtils.isEmpty(vehicle.getDept())){
				sql+="and v.dept = :dept ";
			}
		}

		if(!StringUtils.isEmpty(driver.getIdNum())){
			sql+="and dl.idNumber like :idNum ";
		}
		
		if(!StringUtils.isEmpty(operation)){
			sql+="and dl.operation like :operation ";
		}

		sql+="order by (CASE v.dept WHEN '一部' THEN 1 WHEN '二部' THEN 2 WHEN '三部' THEN 3 ELSE 4 END),v.license_num ";

		Query query = session.createQuery(sql);
		
		query.setBoolean("finished", finished);

		if(vehicle!=null){
			if(!StringUtils.isEmpty(vehicle.getCarframeNum())){
				query.setString("carframeNum", "%"+vehicle.getCarframeNum()+"%");
			}
			if(!StringUtils.isEmpty(vehicle.getDept())){
				query.setString("dept", vehicle.getDept());
			}
		}
		
		if(!StringUtils.isEmpty(driver.getIdNum())){
			query.setString("idNum", "%"+driver.getIdNum()+"%");
		}
		
		if(beginDate!=null){
			query.setDate("beginDate", beginDate);
		}
		if(endDate!=null){
			query.setDate("endDate", endDate);
		}
		if(!StringUtils.isEmpty(operation)){
			query.setString("operation","%"+operation+"%");
		}
		if(page!=null){
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
		}
		return query.list();
	} catch (HibernateException e) {
		throw e;
	} finally {
		HibernateSessionFactory.closeSession();
	}
}

}
