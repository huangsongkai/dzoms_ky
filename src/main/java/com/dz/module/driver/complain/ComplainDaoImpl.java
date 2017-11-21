package com.dz.module.driver.complain;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository(value="complainDao")
//@WaitDeal(name="complainDao")
public class ComplainDaoImpl implements ComplainDao {
	@Override
	public Complain selectById(Complain complain){
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			return (Complain) session.get(Complain.class, complain.getId());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Complain> selectAll(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			String hql = "from Complain c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.complainTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.complainTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public int selectAllCount(Date beginDate,
			Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			String hql = "select count(*) from Complain c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.complainTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.complainTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	/**
	 * 所有待处理的投诉
	 * @return
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Complain> selectAllByState(Page page,Date beginDate,
			Date endDate,int state) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from Complain c where c.state=:state";
			
			if(beginDate!=null){
				hql+=" and c.complainTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.complainTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			query.setInteger("state", state);
			
			//Query query = session.createQuery("from Complain c where c.alreadyDeal is null or alreadyDeal = '否'");
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public int selectAllByStateCount(Date beginDate,
			Date endDate,int state) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Complain c where c.state=:state";
			
			if(beginDate!=null){
				hql+=" and c.complainTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.complainTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			query.setInteger("state", state);
			//Query query = session.createQuery("select count(*) from Complain c where c.alreadyDeal is null or alreadyDeal = '否'");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public List<Complain> selectAllWaitForConfirm(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByState(page,beginDate,endDate,0);
	}
	
	@Override
	public int selectAllWaitForConfirmCount(Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByStateCount(beginDate,endDate,0);
	}
	
	@Override
	public List<Complain> selectAllWaitForDeal(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByState(page,beginDate,endDate,1);
	}
	
	@Override
	public int selectAllWaitForDealCount(Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByStateCount(beginDate,endDate,1);
	}
	
	/**
	 * 所有待回访的投诉
	 * @return
	 * @throws HibernateException
	 */
	@Override
	public List<Complain> selectAllWaitForVisitBack(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByState(page,beginDate,endDate,2);
	}
	
	@Override
	public int selectAllWaitForVisitBackCount(Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByStateCount(beginDate,endDate,2);
	}
	
	@Override
	public List<Complain> selectAllWaitForHandled(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByState(page,beginDate,endDate,3);
	}
	
	@Override
	public int selectAllWaitForHandledCount(Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByStateCount(beginDate,endDate,3);
	}
	

	@Override
	public List<Complain> selectAllHandled(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByState(page,beginDate,endDate,4);
	}
	
	@Override
	public int selectAllHandledCount(Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByStateCount(beginDate,endDate,4);
	}
	
	@Override
	public List<Complain> selectAllNotTrue(Page page,Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByState(page,beginDate,endDate,-1);
	}
	
	@Override
	public int selectAllNotTrueCount(Date beginDate,
			Date endDate) throws HibernateException{
		return selectAllByStateCount(beginDate,endDate,-1);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Complain> selectByDriver(Driver driver,Page page) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Complain c where c.idNum = :idnum");
			query.setString("idnum", driver.getIdNum());
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public int selectByDriverCount(Driver driver) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("select count(*) from Complain c where c.idNum = :idnum");
			query.setString("idnum", driver.getIdNum());
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void addComplain(Complain complain) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(complain);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void updateComplain(Complain complain) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.update(complain);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void deleteComplain(Complain complain) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.delete(complain);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

//	@SuppressWarnings("unchecked")
//	@Override
//	public Map<String, List<ToDo>> waitToDo(Role role) {
//		Map<String, List<ToDo>> map = new TreeMap<String, List<ToDo>>();
//		List<ToDo> toDolist = new ArrayList<ToDo>();
//		int count;
//		Page page;
//		List<Complain> complainList;
//		
//		switch(role.getRname()){
//		case "分部经理":
//			count = selectAllByStateCount(null, null, 0);
//			page = PageUtil.createPage(count, count, 0);
//			complainList = selectAllByState(page,null,null,0);
//			toDolist.addAll(CollectionUtils.collect(complainList, new ComplainToDoTransformer("待确认","/DZOMS/driver/complain/preconfirmComplain.action")));
//			
//			count = selectAllByStateCount(null, null, 3);
//			page = PageUtil.createPage(count, count, 0);
//			complainList = selectAllByState(page,null,null,3);
//			toDolist.addAll(CollectionUtils.collect(complainList, new ComplainToDoTransformer("待完结","/DZOMS/driver/complain/prefinishComplain.action")));
//			break;
//		case "运营部经理":
//			count = selectAllByStateCount(null, null, 1);
//			page = PageUtil.createPage(count, count, 0);
//			complainList = selectAllByState(page,null,null,1);
//			toDolist.addAll(CollectionUtils.collect(complainList, new ComplainToDoTransformer("待落实","/DZOMS/driver/complain/predealComplain.action")));
//			break;
//		case "副总经理":
//			count = selectAllByStateCount(null, null, 2);
//			page = PageUtil.createPage(count, count, 0);
//			complainList = selectAllByState(page,null,null,2);
//			toDolist.addAll(CollectionUtils.collect(complainList, new ComplainToDoTransformer("待回访","/DZOMS/driver/complain/previsit_backComplain.action")));
//			break;
//		default:
//			break;
//		}
//		
//		map.put("投诉处理", toDolist);
//		return map;
//	}
//
//	private static class ComplainToDoTransformer implements Transformer {
//		private String state,url;
//		public ComplainToDoTransformer(String state,String url){
//			this.state = state;
//			this.url = url;
//		}
//		
//		@Override
//		public Object transform(Object arg0) {
//			Complain comp =(Complain) arg0;
//			Vehicle vehicle = (Vehicle) ObjectAccess.getObject("com.dz.module.vehicle.Vehicle", comp.getVehicleId());
//			String msg = "";
//			if(vehicle!=null){
//				if (StringUtils.isNotEmpty(vehicle.getDept())) {
//					msg+=vehicle.getDept()+",";
//				}
//				
//				if (StringUtils.isNotEmpty(vehicle.getLicenseNum())) {
//					msg += vehicle.getLicenseNum() + ",";
//				}
//				if (comp.getComplainTime()!=null) {
//					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
//					msg += dateFormat.format(comp.getComplainTime()) + ",";
//				}
//				if (StringUtils.isNotEmpty(comp.getComplainType())) {
//					msg += comp.getComplainType();
//				}
//			}
//			
//			return new ToDo(msg,state,url+"?complain.id="+comp.getId());
//		}
//	}

	@Override
	public int selectAllByStatesCount(Complain complain,Date beginDate, Date endDate,String dept,
			Short[] states) {
		
//		System.out.println("ComplainDaoImpl.selectAllByStatesCount(),"+complain);
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Complain c where c.state in (:states)";
			
			if(beginDate!=null){
				hql+=" and c.complainTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.complainTime <= :endDate";
			}
			
			if(!StringUtils.isEmpty(dept)){
				hql+=" and c.vehicleId in (select carframeNum from Vehicle where dept like :dept) ";
			}
			
			if (complain!=null) {
				if(!StringUtils.isEmpty(complain.getCarNum())){
					hql+=" and c.vehicleId in (select carframeNum from Vehicle where licenseNum like :carNum) ";
				}
				
				if(!StringUtils.isEmpty(complain.getComplainClass())){
					hql+=" and c.complainClass like :complainClass";
				}
				
				if(!StringUtils.isEmpty(complain.getComplainObject())){
					hql+=" and c.complainObject like :complainObject";
				}
			}
			
			System.out.println(hql);
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			if(!StringUtils.isEmpty(dept)){
				query.setString("dept", "%"+dept+"%");
			}
			
			
			query.setParameterList("states", states);
			
			if (complain!=null) {
				if(!StringUtils.isEmpty(complain.getCarNum())){
					query.setString("carNum", "%"+complain.getCarNum()+"%");
				}
				
				if(!StringUtils.isEmpty(complain.getComplainClass())){
					query.setString("complainClass", "%"+complain.getComplainClass());
				}
				
				if(!StringUtils.isEmpty(complain.getComplainObject())){
					query.setString("complainObject", "%"+complain.getComplainObject()+"%");
				}
			}
			
			//Query query = session.createQuery("select count(*) from Complain c where c.alreadyDeal is null or alreadyDeal = '否'");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Complain> selectAllByStates(Complain complain,Page page, Date beginDate,
			Date endDate,String dept, Short[] states,String order) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select c from Complain c,Vehicle v where c.state in (:states)";
			
			if(beginDate!=null){
				hql+=" and c.complainTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.complainTime <= :endDate";
			}
			
			if(!StringUtils.isEmpty(dept)){
				hql+=" and c.vehicleId in (select carframeNum from Vehicle where dept like :dept) ";
			}
			
			if (complain!=null) {
				if(!StringUtils.isEmpty(complain.getCarNum())){
					hql+=" and c.vehicleId in (select carframeNum from Vehicle where licenseNum like :carNum) ";
				}
				
				if(StringUtils.isNotEmpty(complain.getComplainClass())){
					hql+=" and c.complainClass like :complainClass";
				}
				
				if(StringUtils.isNotEmpty(complain.getComplainObject())){
					hql+=" and c.complainObject like :complainObject";
				}
			}
			
			hql += " and c.vehicleId=v.carframeNum ";
			
			if(StringUtils.equals(order, "complainTime")){
				hql += " order by c.complainTime ";
			}else{
				hql += " order by v.licenseNum ";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			if(!StringUtils.isEmpty(dept)){
				query.setString("dept", "%"+dept+"%");
			}
			
			query.setParameterList("states", states);

			if (complain!=null) {
				if(!StringUtils.isEmpty(complain.getCarNum())){
					query.setString("carNum", "%"+complain.getCarNum()+"%");
				}
				
				if(StringUtils.isNotEmpty(complain.getComplainClass())){
					query.setString("complainClass","%"+ complain.getComplainClass());
				}
				
				if(StringUtils.isNotEmpty(complain.getComplainObject())){
					query.setString("complainObject","%"+  complain.getComplainObject()+"%");
				}
			}
			//Query query = session.createQuery("from Complain c where c.alreadyDeal is null or alreadyDeal = '否'");
			if(page!=null){
				query.setMaxResults(page.getEveryPage());
				query.setFirstResult(page.getBeginIndex());
			}
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
}
