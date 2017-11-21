package com.dz.module.contract.invoice;

import com.dz.common.global.Page;
import com.dz.common.other.FinanceUtil;
import com.dz.common.other.PageUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.List;

public class InvoiceAction extends ActionSupport implements ServletRequestAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4287394818869106703L;
	private InvoiceStock invoiceStock;
	private InvoiceRecord invoiceRecord;
	private InvoiceService invoiceService;
	private HttpServletRequest request;
	
	public InvoiceService getInvoiceService(){
		return invoiceService;
	}
	
	public void setInvoiceService(InvoiceService invoiceService){
		this.invoiceService = invoiceService;
	}
	
	public InvoiceStock getInvoiceStock(){
		return invoiceStock;
	}
	
	public void setInvoiceStock(InvoiceStock invoiceStock){
		this.invoiceStock = invoiceStock;
	}
	public InvoiceRecord getInvoiceRecord(){
		return invoiceRecord;
	}
	
	public void setInvoiceRecord(InvoiceRecord invoiceRecord){
		this.invoiceRecord = invoiceRecord;
	}
	
	public void invoiceReady() throws IOException{
		ServletActionContext.getResponse().setContentType("text/xml");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		InvoiceStock s = invoiceService.invoiceReady();
		String stock = s.getStock()/10000 + "��" + (s.getStock()%10000)/1000 + "��";
		String num = "fpjh" + new DecimalFormat("000000").format(invoiceService.invoiceRecordTotal()+1);
		String p = (int)(s.getUnitPrice()*100)+"";
		String P = FinanceUtil.convert2Chinese(s.getUnitPrice() * 100);
		StringBuffer xml = new StringBuffer("<Ready>");
		xml.append("<num>" + num + "</num>");
		xml.append("<unit>" + s.getUnitPrice() + "</unit>");
		xml.append("<stock>" + stock + "</stock>");
		xml.append("<price>" + p + "</price>");
		xml.append("<pricech>" + P + "</pricech>");
		xml.append("</Ready>");
		System.out.println(xml);
		out.print(xml);
		out.flush();
		out.close();
	}
	
	public String invoiceBuy() throws IOException{
		invoiceRecord.setIsAbandoned(false);
		invoiceRecord.setType("1");
		invoiceRecord.setBuy(100);
		invoiceRecord.setSell(0);
		invoiceRecord.setAmount(10000);
		boolean flag = invoiceService.invoiceBuy(invoiceRecord);
		if(!flag){
			return ERROR;
		}else{
			flag = invoiceService.addStock();
			if(!flag){
				return ERROR;
			}
		}
		return SUCCESS;
	}
	
	public void invoiceSearchRecordBuy() throws IOException{
		ServletActionContext.getResponse().setContentType("text/xml");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		Page page = PageUtil.createPage(15,
				invoiceService.invoiceSearchBuyTotal(), currentPage);
		List<InvoiceRecord> l = invoiceService
				.invoiceSearchBuy(page);
		StringBuffer xml = new StringBuffer("<InvoiceList>");
		if (l != null) {
			for (int i = 0; i < l.size(); i++) {
				xml.append("<Invoice>");
				xml.append("<Id>" + l.get(i).getReceiptNum() + "</Id>");
				xml.append("<unit>" + l.get(i).getUnitPrice() + "</unit>");
				xml.append("<amount>" + l.get(i).getAmount()/100 + "</amount>");
				xml.append("<price>" + l.get(i).getPrice() + "</price>");
				xml.append("<begin>" + l.get(i).getSectionBegin() + "</begin>");
				xml.append("<end>" + l.get(i).getSectionEnd() + "</end>");
				xml.append("<year>" + l.get(i).getYearId() + "</year>");
				xml.append("</Invoice>");
			}
			xml.append("<page>");
			xml.append("<hasPrePage>" + page.isHasPrePage() + "</hasPrePage>");
			xml.append("<hasNextPage>" + page.isHasNexPage() + "</hasNextPage>");
			xml.append("<currentPage>" + currentPage + "</currentPage>");
			xml.append("<totalPage>" + page.getTotalPage() + "</totalPage>");
			xml.append("</page>");
			xml.append("</InvoiceList>");
			System.out.println(xml);
			out.print(xml);
		} else {
			out.print("NOT FOUND");
		}
		out.flush();
		out.close();
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}
}