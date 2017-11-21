package com.dz.common.tablelist;

import net.sf.json.JSONObject;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class TableListService{
	@Autowired
	private TableListDao tableListDao;
	public void setTableListDao(TableListDao tableListDao) {
		this.tableListDao = tableListDao;
	}
	
	public TableList get(String name) throws HibernateException{
		return tableListDao.get(name);
	}
	
	public TableList getOrCreate(String name)throws HibernateException{
		TableList tl = tableListDao.get(name);
		
		if(tl==null){
			tl = new TableList();
			tl.setName(name);
			tableListDao.addTableList(tl);
			tl  = tableListDao.get(name);
		}
		return tl;
	}
	
	public ListValue getRoot(TableList tl) throws HibernateException {
		return tableListDao.getRoot(tl);
	}
	
	public List<ListValue> getChildren(ListValue lf) throws HibernateException {
		return tableListDao.getChildren(lf);
	}
	
	public ListValue getFather(ListValue lf) throws HibernateException {
		return tableListDao.getFather(lf);
	}
	
	public List<String> getFathersValue(ListValue lf) throws HibernateException{
		List<String> ls = new ArrayList<String>();
		//Validate.notNull(lf);
		for(ListValue lv=tableListDao.getFather(lf);lv!=null;lv=tableListDao.getFather(lf)){
			ls.add(lf.getValue());
			lf=lv;
		}
		Collections.reverse(ls);
		return ls;
	}
	
	public List<String> getFathersValue(int id){
		ListValue lf = tableListDao.getListValue(id);
		List<String> ls = new ArrayList<String>();
		for(ListValue lv=tableListDao.getFather(lf);lv!=null;lv=tableListDao.getFather(lf)){
			ls.add(lf.getValue());
			lf=lv;
		}
		Collections.reverse(ls);
		return ls;
	}
	
	public static String getFathersValueString(int id){
		TableListService tls = TableListService.getTableListService();
		List<String> ls = tls.getFathersValue(id);
		String str = ls.toString();
		return str.substring(1, str.length()-1);
	}
	
	public static String getValueOfJson(String jsonStr,String key){
		JSONObject json = JSONObject.fromObject(jsonStr);
		return json.getString(key);
	}
	
	public ListValue getListValue(int id){
		return tableListDao.getListValue(id);
	}

	public void addTableList(TableList tl) throws HibernateException {
		tableListDao.addTableList(tl);		
	}

	public void hideItem(ListValue lv) throws HibernateException {
		tableListDao.hideItem(lv);		
	}

	public void deleteItem(ListValue lv) throws HibernateException {
		tableListDao.deleteItem(lv);		
	}

	public void addSubItems(ListValue flv, ListValue... lvs)
			throws HibernateException {
		tableListDao.addSubItems(flv, lvs);		
	}

	public TableList getById(int tableListId) {
		return tableListDao.getById(tableListId);
	}

	public int addSubItem(ListValue root, ListValue listValue) {
		return tableListDao.addSubItem(root, listValue);
	}
	
	public void deleteTableList(int id) throws HibernateException{
		tableListDao.deleteTableList(id);
	}
	
	public static TableListService getTableListService(){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		TableListService tls =(TableListService) ctx.getBean("tableListService");
		return tls;
	}
	
	public static void main(String[] args){
		ApplicationContext ctx = 
	             new ClassPathXmlApplicationContext("applicationContext.xml");
		TableListService tls =(TableListService) ctx.getBean("tableListService");
		System.out.println(tls.getFathersValue(20));
	}
	
}
