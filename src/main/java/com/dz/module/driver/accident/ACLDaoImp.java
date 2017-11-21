package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository(value = "aclDao")
public class ACLDaoImp implements ACLDao{
	@Override
	public void addOne(Relation_Accident_CarLoss rac) {
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
	public void removeOne(Relation_Accident_CarLoss rac) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			List<Relation_Accident_CarLoss> del = null;
			Query query = session.createQuery("from Relation_Accident_CarLoss where accId = :accId and clId = :clId");
			query.setInteger("clId",rac.getClId());
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
	public List<CarLoss> search(Accident accident, int part) {
		List<CarLoss> list = new ArrayList<CarLoss>();
		Transaction tx = null;
		CarLossDao dao = new CarLossDaoImp();
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			List<Relation_Accident_CarLoss> ascs = null;
			String sql = "from Relation_Accident_CarLoss where accId = :accId";
			Query query = session.createQuery(sql);
			query.setInteger("accId", accident.getAccId());
			ascs = query.list();
			tx.commit();
			for(Relation_Accident_CarLoss rac : ascs){
				CarLoss loss = dao.selectById(rac.getClId());
				if(loss.getPart() == part){
					list.add(loss);
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
