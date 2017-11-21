package com.dz.module.contract;


import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;


@Repository(value="bankCardDao")
public class BankCardDaoImpl implements BankCardDao {
	
	@Override
	public boolean bankCardAdd(BankCard card) throws HibernateException {
		return bankCardUpdate(card);
	}

	@Override
	public boolean bankCardUpdate(BankCard card) throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		
		try {	
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			
			String hql = "from BankCard where cardNumber=:cid ";
			Query query = session.createQuery(hql);
			query.setString("cid", card.getCardNumber());
			
			List<BankCard> list = query.list();
			if(list!=null){
				for(BankCard cd : list){
					int id = cd.getId();
					cd = (BankCard) session.get(BankCard.class, id);
					session.delete(cd);
				}
			}
			
			session.saveOrUpdate(card);
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
	public int queryCardCount() throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int count = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("select count(*) from BankCard ");
			count = Integer.parseInt(query.uniqueResult().toString());
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return count;
	}
	
	/**
	 * 银行卡信息查询Dao层实现
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BankCard> queryAllCard(Page page) throws HibernateException {
		List<BankCard> cardList = null;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("from BankCard");
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			cardList = query.list();
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return cardList;		
	}
	
	@Override
	public BankCard getBankCardByCardNumber(String id) throws HibernateException {
		BankCard card = null;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from BankCard where cardNumber=:id");
		query.setString("id", id);
		card = (BankCard)query.uniqueResult();
		HibernateSessionFactory.closeSession();
		return card;
	}

	@Override
	public BankCard getBankCardForRecieveByDriverId(String driverId,String carNum) {
		List<BankCardOfVehicle> bankCards = null;
		Session session;
		Query query;
		
		if(StringUtils.isEmpty(carNum)){
			bankCards = Arrays.asList();
		}else{
			session = HibernateSessionFactory.getSession();
			query = session.createQuery("from BankCardOfVehicle " +
					"where vehicle.carframeNum like :carNum " +
					"and bankCard.idNumber=:driverId");
			query.setString("driverId", driverId);
			query.setString("carNum","%"+ carNum+"%");
			bankCards = query.list();
			HibernateSessionFactory.closeSession();
		}
		
		if(bankCards.size()>0){
			for (BankCardOfVehicle bankCard : bankCards) {
				if(bankCard.getIsDefaultRecive())
					return bankCard.getBankCard();
			}
			return bankCards.get(0).getBankCard();
		}else{
			session = HibernateSessionFactory.getSession();
			query = session.createQuery("from BankCardOfVehicle where bankCard.idNumber=:driverId and isDefaultRecive=true");
			query.setString("driverId", driverId);
			bankCards = query.list();
			HibernateSessionFactory.closeSession();
			if(bankCards == null || bankCards.size()==0) return null;
		}
		return bankCards.get(0).getBankCard();
	}

	@Override
	public BankCard getBankCardForPayByDriverId(String driverId,String carNum,String cardClass) {
		try {
			return getBankCardForPayByDriverIdWithoutCloseSession(driverId,carNum,cardClass);
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public BankCard getBankCardForPayByDriverIdWithoutCloseSession(
			String driverId, String carNum,String cardClass) {
		List<BankCard> bankCards = null;
		Session session;
		Query query;
		
		if(StringUtils.isEmpty(carNum)){
			bankCards = Arrays.asList();
		}else{
			session = HibernateSessionFactory.getSession();
			query = session.createQuery(
					"select bankCard from BankCardOfVehicle " +
							"where vehicle.carframeNum like :carNum " +
							"and bankCard.idNumber=:driverId "
			);
			query.setString("driverId", driverId);
			query.setString("carNum", "%"+carNum+"%");
			bankCards = query.list();
		}

		if(bankCards.size()>0){
			for (BankCard bankCard : bankCards) {
				if(bankCard.getCardClass().equals(cardClass))
					return bankCard;
			}
			return bankCards.get(0);
		}
		
		{
			session = HibernateSessionFactory.getSession();
			query = session.createQuery("select bankCard from BankCardOfVehicle where vehicle.carframeNum like :carNum");
			query.setString("carNum", "%"+carNum+"%");
			bankCards = query.list();
			if(bankCards == null || bankCards.size()==0) return null;
		}
		return bankCards.get(0);
	}
}
