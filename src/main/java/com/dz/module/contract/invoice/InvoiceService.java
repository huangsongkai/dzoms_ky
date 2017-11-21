package com.dz.module.contract.invoice;

import com.dz.common.global.Page;

import java.util.List;


public class InvoiceService {

	public boolean invoiceBuy(InvoiceRecord invoiceRecord) {
		if(invoiceRecord==null){
			return false;
		}
		InvoiceDao invoiceDao = new InvoiceDaoImpl();
		return invoiceDao.invoiceBuy(invoiceRecord);
	}

	public InvoiceStock invoiceReady() {
		InvoiceDao invoiceDao = new InvoiceDaoImpl();
		return invoiceDao.invoiceReady();
	}

	public int invoiceRecordTotal() {
		InvoiceDao invoiceDao = new InvoiceDaoImpl();
		return invoiceDao.invoiceRecordTotal();
	}

	public List<InvoiceRecord> invoiceSearchBuy(Page page) {
		InvoiceDao invoiceDao = new InvoiceDaoImpl();
		return invoiceDao.invoiceSearchBuy(page);
	}

	public int invoiceSearchBuyTotal() {
		InvoiceDao invoiceDao = new InvoiceDaoImpl();
		return invoiceDao.invoiceSearchBuyTotal();
	}

	public boolean addStock() {
		InvoiceDao invoiceDao = new InvoiceDaoImpl();
		return invoiceDao.addStock();
	}
}
