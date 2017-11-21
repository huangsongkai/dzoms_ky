package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
@Repository(value = "aplDao")
public class APLDaoImp implements APLDao{
	@Override
	public void addOne(Relation_Accident_PeopleLoss rac) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			session.save(rac);
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public void removeOne(Relation_Accident_PeopleLoss rac) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			List<Relation_Accident_PeopleLoss> del = null;
			Query query = session.createQuery("from Relation_Accident_PeopleLoss where accId = :accId and plId = :plId");
			query.setInteger("plId",rac.getPlId());
			query.setInteger("accId",rac.getAccId());
			del = query.list();
			session.delete(del.get(0));
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PeopleLoss> search(Accident accident, int part) {
		List<PeopleLoss> list = new ArrayList<PeopleLoss>();
		Transaction tx = null;
		PeopleLossDao dao = new PeopleLossDaoImp();
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			List<Relation_Accident_PeopleLoss> ascs = null;
			String sql = "from Relation_Accident_PeopleLoss where accId = :accId";
			Query query = session.createQuery(sql);
			query.setInteger("accId",accident.getAccId());
			ascs = query.list();
			tx.commit();
			for(Relation_Accident_PeopleLoss rac : ascs){
				PeopleLoss pl = dao.selectById(rac.getPlId());
				if(pl.getPart() == part){
					list.add(pl);
				}
			}
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return list;
	}

}
