package com.dz.module.contract.invoice;

import com.dz.common.global.Page;
import org.hibernate.HibernateException;

import java.util.List;

public interface InvoiceDao {
	public boolean invoiceBuy(InvoiceRecord invoiceRecord) throws HibernateException;
	public InvoiceStock invoiceReady() throws HibernateException;
	public int invoiceRecordTotal() throws HibernateException;
	public int invoiceSearchBuyTotal() throws HibernateException;
	public List<InvoiceRecord> invoiceSearchBuy(Page page) throws HibernateException;
	public boolean addStock() throws HibernateException;
}
