package com.dz.module.driver.meeting;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.driver.Driverleave;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.javatuples.Triplet;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository(value="meetingDao")
public class MeetingDaoImpl implements MeetingDao {
	@SuppressWarnings("unchecked")
	@Override
	public List<Meeting> selectAllMeeting(Page page,Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from Meeting c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.meetingTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.meetingTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			//Query query = session.createQuery("from Meeting");
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
	public int selectAllMeetingCount(Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Meeting c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.meetingTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.meetingTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			//Query query = session.createQuery("select count(*) from Meeting");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void addMeeting(Meeting meeting) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(meeting);
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
	public void updateMeeting(Meeting meeting) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.update(meeting);
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
	public void deleteMeeting(Meeting meeting) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.delete(meeting);
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
	public void addMeetingCheck(MeetingCheck meetingCheck) {
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(meetingCheck);
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
	public void updateMeetingCheck(MeetingCheck meetingCheck) {
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.update(meetingCheck);
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
	public MeetingCheck selectMeetingCheck(Integer meetingId, String idNum) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from MeetingCheck c where 1=1";
			
			if(meetingId!=null){
				hql+=" and c.meetingId = :meetingId";
			}
			
			if(!StringUtils.isEmpty(idNum)){
				hql+=" and c.idNum = :idNum";
			}
			
			Query query = session.createQuery(hql);
			
			if(meetingId!=null){
				query.setInteger("meetingId", meetingId);
			}
			
			if(!StringUtils.isEmpty(idNum)){
				query.setString("idNum", idNum);
			}
			
			return (MeetingCheck) query.uniqueResult();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public List<MeetingCheck> selectMeetingCheck(Integer meetingId,Triplet<String, String, Object>... conditions){
		return this.selectMeetingCheck(null,meetingId,conditions);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MeetingCheck> selectMeetingCheck(String dept,Integer meetingId,Triplet<String, String, Object>... conditions) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select distinct c from MeetingCheck c where 1=1";
			
			if(meetingId!=null){
				hql+=" and c.meetingId = :meetingId";
			}
			
			if(!StringUtils.isEmpty(dept)){
				hql+=" and c.idNum in (select d.idNum from Driver d where d.dept=:dept)";
			}
			
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					hql += String.format(" and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}
			
			Query query = session.createQuery(hql);
			
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}
			
			if(meetingId!=null){
				query.setInteger("meetingId", meetingId);
			}
			
			if(!StringUtils.isEmpty(dept)){
				query.setString("dept", dept);
			}
			
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public int selectLeaveNumber(Integer meetingId,String dept) {
		List<MeetingCheck> checks = this.selectMeetingCheck(dept,meetingId);
		int leave = 0;
		for(MeetingCheck check:checks){
			if(this.isLeave(check)){
				leave++;
			}
		}
			
		return leave;
	}
	
	@Override
	public int selectMeetingCheckCount(Integer meetingId,Triplet<String, String, Object>... conditions){
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();

			String sql = "select count(*) from MeetingCheck where 1=1 ";

			if(meetingId!=null){
				sql+=" and meetingId = :meetingId";
			}
			
			
			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format(" and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}

			Query query = session.createQuery(sql);

			if(meetingId!=null){
				query.setInteger("meetingId", meetingId);
			}
			
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
	
	private boolean isLeave(MeetingCheck mc){
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			Date needCheckTime = mc.getNeedCheckTime();
			
			String hql = "FROM Driverleave AS t_apply where t_apply.idNumber=:idNum and t_apply.operation = '待岗申请' and t_apply.opeTime <= :needCheckTime ";
			Query query = session.createQuery(hql);
			query.setString("idNum",mc.getIdNum());
			query.setDate("needCheckTime", needCheckTime);
			
			@SuppressWarnings("unchecked")
			List<Driverleave> leaveApply = query.list();
			
			String hql2 = "select count(*) FROM "+
					"Driverleave AS t1 "+
					"WHERE " +
					"t1.idNumber=:idNum "+
					"AND t1.operation = '上岗申请' "+
					"AND t1.opeTime >= :checkTime "+
					"AND t1.opeTime <= ALL ("+
						"SELECT "+
						"t2.opeTime "+
						"FROM "+
						"Driverleave AS t2 "+
						"WHERE " +
						"t2.idNumber=:idNum "+
						"AND t2.operation = '上岗申请' "+
						"AND t2.opeTime >= :applyTime"+
					")";
			
			Query query2 = session.createQuery(hql2);
			for(Driverleave la:leaveApply){
				query2.setString("idNum",mc.getIdNum());
				query2.setDate("checkTime", needCheckTime);
				query2.setDate("applyTime", la.getOpeTime());
				
				long num = (long) query2.uniqueResult();
				
				if(num>0){
					return true;
				}
			}
			
			return false;
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
}
