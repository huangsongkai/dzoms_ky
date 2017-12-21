package com.dz.common.other;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.IgnoreFieldProcessorImpl;
import com.dz.common.global.Page;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

@Controller
@Scope("prototype")
public class ObjectAccess extends BaseAction {
	private String className;
	private String id;
	private Boolean isString;
	private String column;
	private String condition;
	private String keyword;
	private String key;
	private String orderby;
	private Boolean withoutPage;
	private Integer pageSize;
		
	public void get() throws IOException{
		Object obj=null;
		if(BooleanUtils.isNotTrue(isString)){
			obj = getObject(className,Integer.parseInt(id));
		}else{
			obj = getObject(className,id);
		}
		JSONObject json = JSONObject.fromObject(obj);
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print(json.toString());
		out.flush();
		out.close();
	}
	
	public String getObj(){
		bean = new ArrayList<Object>();
		for(ObjectId oid:ids){
			if(BooleanUtils.isNotTrue(oid.isString)){
				bean.add(getObject(oid.className,Integer.parseInt(oid.id)));
			}else{
				bean.add(getObject(oid.className,oid.id));
			}
		}
		return SUCCESS;
	}
	
	private List<Object> bean;
	private List<ObjectId> ids;
	
	public static class ObjectId{
		private String className;
		private String id;
		private Boolean isString;
		public String getClassName() {
			return className;
		}
		public void setClassName(String className) {
			this.className = className;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public Boolean getIsString() {
			return isString;
		}
		public void setIsString(Boolean isString) {
			this.isString = isString;
		}
		public ObjectId() {
			super();
			// TODO Auto-generated constructor stub
		}
		public ObjectId(String className, String id, Boolean isString) {
			super();
			this.className = className;
			this.id = id;
			this.isString = isString;
		}
		@Override
		public String toString() {
			return "ObjectId [className=" + className + ", id=" + id
					+ ", isString=" + isString + "]";
		}

	}
	
	public static Object getObject(String className,Serializable id){
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			return session.get(className, id);
		}
		catch(HibernateException e) {
			e.printStackTrace();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	
	public static <T> T getObject(Class<T> clazz,Serializable id){
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			return (T) session.get(clazz, id);
		}
		catch(HibernateException e) {
			e.printStackTrace();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	public static<T> List<T> query(Class<T> requiredType,String where,String groupBy,String having,String orderBy,Page page){
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			return query(session, requiredType, where, groupBy, having,
					orderBy, page);
		}
		catch(HibernateException e) {
			e.printStackTrace();
			return null;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	public static <T> List<T> query(Session session, Class<T> requiredType,
			String where, String groupBy, String having, String orderBy,
			Page page) {
		String hql = "from " + requiredType.getName();
		
		if(StringUtils.isNotEmpty(where)){
			hql+=" where "+where;
		}
		
		if(StringUtils.isNotEmpty(groupBy)){
			hql+=" group by "+groupBy;
			
			if(StringUtils.isNotEmpty(having)){
				hql+=" having "+having;
			}
		}
		
		if(StringUtils.isNotEmpty(orderBy)){
			hql+=" order by "+orderBy;
		}
		
		Query query = session.createQuery(hql);
		
		if(page!=null){
			query.setFirstResult(page.getBeginIndex());
			query.setMaxResults(page.getEveryPage());
		}
		
		return query.list();
	}
	
	public static<T> List<T> query(Class<T> requiredType,String where){
		return query(requiredType,where,null,null,null,null);
	}
	
	public static<T> List<T> query(Session session,Class<T> requiredType,String where){
		return query(session,requiredType,where,null,null,null,null);
	}
	
	public static <T> T execute(String hql){
		Session session = null;
		Transaction t = null;
		T result = null;
		try {	
			session = HibernateSessionFactory.getSession();
			
			t = session.beginTransaction();
			
			if(StringUtils.contains(hql, ";")){
				for(String hs:StringUtils.split(hql, ";")){
					result = executeSingle(hs, session);
				}
			}else{
				result = executeSingle(hql, session);
			}
			t.commit();
			return result;
		}
		catch(HibernateException e) {
			t.rollback();
			e.printStackTrace();
			return null;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T executeSingle(String hql,Session session) throws HibernateException{
		Query query = session.createQuery(hql);
			
		if (org.apache.commons.lang3.BooleanUtils.or(new boolean[]{
				StringUtils.startsWithIgnoreCase(hql.trim(), "update"),
				StringUtils.startsWithIgnoreCase(hql.trim(), "delete"),
				StringUtils.startsWithIgnoreCase(hql.trim(), "insert"),
				StringUtils.startsWithIgnoreCase(hql.trim(), "create"),
				StringUtils.startsWithIgnoreCase(hql.trim(), "drop")
		})) {
			return (T)(Object)query.executeUpdate();
		}
		query.setMaxResults(1);
		return (T) query.uniqueResult();
	}
	
	public void option() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		        
        Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			String hql = "from " + className +" where "+column+" like :keyword ";
			
			if(StringUtils.isNotEmpty(condition)){
				hql+=" and "+condition;
			}
			
			Query query = session.createQuery(hql);
			query.setString("keyword",keyword+"%");
			
			query.setFirstResult(0);
			query.setMaxResults(15);
			
			List l = query.list();
		
			JSONArray jarray = new JSONArray();
		
			for(Object d:l){
				JSONObject jobj = new JSONObject();
				jobj.accumulate("title", BeanUtils.getProperty(d, column));
				jarray.add(jobj);
			}
		
			JSONObject json = new JSONObject();
			json.accumulate("data", jarray);
		
			out.print(json.toString());
		
			out.flush();
			out.close();
		}catch(HibernateException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
			e.printStackTrace();
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	
	public void optionByitems()throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		        
        Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			String hql = "from ItemTool where key like :key and value like :value and key not like '%.default' ";
			
			if(StringUtils.isNotEmpty(condition)){
				hql+=" and "+condition;
			}
			
			Query query = session.createQuery(hql);
			query.setString("key",key+"%");
			query.setString("value",keyword+"%");
			
			List l = query.list();
		
			JSONArray jarray = new JSONArray();
		
			for(Object d:l){
				JSONObject jobj = new JSONObject();
				jobj.accumulate("title", BeanUtils.getProperty(d, "value"));
				jarray.add(jobj);
			}
		
			JSONObject json = new JSONObject();
			json.accumulate("data", jarray);
		
			out.print(json.toString());
		
			out.flush();
			out.close();
		}catch(HibernateException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
			e.printStackTrace();
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	
	public void itemsDefault()throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		        
        Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			String hql = "select value from ItemTool where key = :key ";
			
			Query query = session.createQuery(hql);
			query.setString("key",key+".default");
			query.setMaxResults(1);
			
			Object value = query.uniqueResult();
			String str = "";
			if(value!=null){
				str = (String) value;
			}
		
			JSONObject json = new JSONObject();
			json.accumulate("data", str);
		
			out.print(json.toString());
		
			out.flush();
			out.close();
		}catch(HibernateException e) {
			e.printStackTrace();
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	public String select(){
		int currentPage = 0;
        String currentPagestr = request.getParameter("currentPage");
        if(currentPagestr == null || "".equals(currentPagestr)){
        	currentPage = 1;
        }else{
        	currentPage=Integer.parseInt(currentPagestr);
        }
        
        String hql = " 1=1 ";
        
        if(StringUtils.isNotEmpty(condition)){
			hql+=condition;
		}

		int position = StringUtils.lastIndexOf(hql,"order by");
		long count;
        if(position>0){
			count = ObjectAccess.execute("select count(*) from "+className+" where " + StringUtils.substring(hql,0,position));
		}else{
			count = ObjectAccess.execute("select count(*) from "+className+" where " + hql);
		}

        Page page;
        if (BooleanUtils.isTrue(withoutPage)) {
        	page = PageUtil.createPage((int)count,(int)count, 0);
		} else {
			page = PageUtil.createPage((pageSize==null||pageSize<=0)?15:pageSize,(int)count, currentPage);
		}
        
        try {
			List<?> l = ObjectAccess.query(Class.forName(className), hql, null, null, orderby, page);
			request.setAttribute("list", l);
			//request.setAttribute("currentPage", currentPage);
			request.setAttribute("page", page);			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ERROR;
		}
        
        if(StringUtils.isEmpty(url))
			return ERROR;
		
		return "selectToUrl";
	}
	
	public String selectJoin(){
		int currentPage = 0;
        String currentPagestr = request.getParameter("currentPage");
        if(currentPagestr == null || "".equals(currentPagestr)){
        	currentPage = 1;
        }else{
        	currentPage=Integer.parseInt(currentPagestr);
        }
        
        String hql = " ";
        
        if(StringUtils.isNotEmpty(condition)){
			hql+=condition;
		}
        
        long count = ObjectAccess.execute("select count(*) "+ hql);
        
        Page page;
        
        if (BooleanUtils.isTrue(withoutPage)) {
        	page = PageUtil.createPage((int)count,(int)count, 0);
		} else {
			page = PageUtil.createPage((pageSize==null||pageSize<=0)?15:pageSize,(int)count, currentPage);
		}
        
        Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("select " + column + " "+ hql);
		
		query.setFirstResult(page.getBeginIndex());
		query.setMaxResults(page.getEveryPage());
		
		List<?> l = query.list();
		request.setAttribute("list", l);
		//request.setAttribute("currentPage", currentPage);
		request.setAttribute("page", page);
		HibernateSessionFactory.closeSession();
        
        if(StringUtils.isEmpty(url))
			return ERROR;
		
		return "selectToUrl";
	}
	
	public void doit() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		        
		Object exec = execute(condition);
		
		JSONObject json = new JSONObject();
		json.accumulate("affect", exec, IgnoreFieldProcessorImpl.getDefaultConfig(true,"bovList","bOfVList"));
		
		out.print(json.toString());
		
		out.flush();
		out.close();
	}
	
	public String doitToUrl() throws IOException{
		Object exec = execute(condition);
		request.setAttribute("affect", exec);
		return "selectToUrl";
	}
	
	public static <T> void saveOrUpdate(T t){
		Session session = null;
		Transaction trans = null;
		
		try {	
			session = HibernateSessionFactory.getSession();
			
			trans = session.beginTransaction();
			
			session.saveOrUpdate(t);
			
			trans.commit();
		}
		catch(HibernateException e) {
			trans.rollback();
			e.printStackTrace();
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	public String url;
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getClassName() {
		return className;
	}

	public String getId() {
		return id;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Boolean getIsString() {
		return isString;
	}

	public void setIsString(Boolean isString) {
		this.isString = isString;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Boolean getWithoutPage() {
		return withoutPage;
	}

	public void setWithoutPage(Boolean withoutPage) {
		this.withoutPage = withoutPage;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public List<Object> getBean() {
		return bean;
	}

	public void setBean(List<Object> bean) {
		this.bean = bean;
	}

	public List<ObjectId> getIds() {
		return ids;
	}

	public void setIds(List<ObjectId> ids) {
		this.ids = ids;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public static<T> void delete(T obj) {
		HibernateSessionFactory.getSession().delete(obj);
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	public String getOrderby() {
		return orderby;
	}
}
