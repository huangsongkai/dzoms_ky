package com.dz.module.contract.invoice;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;


public class InvoiceDaoImpl implements InvoiceDao {
	public boolean invoiceBuy(InvoiceRecord invoiceRecord)
			throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();

			session.save(invoiceRecord);
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
	public InvoiceStock invoiceReady() throws HibernateException {
		InvoiceStock s = null;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from InvoiceStock where id= 1");
		s = (InvoiceStock) query.uniqueResult();
		HibernateSessionFactory.closeSession();
		return s;
	}

	@Override
	public int invoiceRecordTotal() throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session
					.createQuery("select count(*) from InvoiceRecord");
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}

	@Override
	public int invoiceSearchBuyTotal() throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("select count(*) from InvoiceRecord where sell='0' and isAbandoned='0'");
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InvoiceRecord> invoiceSearchBuy(Page page)
			throws HibernateException {
		List<InvoiceRecord> l = new ArrayList<InvoiceRecord>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("from InvoiceRecord where sell='0' and isAbandoned='0'");
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			l = query.list();
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@Override
	public boolean addStock() throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("from InvoiceStock");
			InvoiceStock s = (InvoiceStock) query.uniqueResult();
			s.setStock(s.getStock()+10000);
			session.save(s);
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

}
