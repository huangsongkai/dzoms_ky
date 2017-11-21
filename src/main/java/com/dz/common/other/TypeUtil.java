package com.dz.common.other;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.beanutils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang3.ArrayUtils;

public class TypeUtil {

	private static final class PropExcludePredicte implements Predicate {
		String[] exclude ;
		public PropExcludePredicte(String[] exclude) {
			this.exclude = exclude;
		}

		@Override
		public boolean evaluate(Object object) {
			DynaProperty prop = (DynaProperty) object;
			if(exclude!=null)
			if(ArrayUtils.contains(exclude, prop.getName())){
				return false;
			}
			return true;
		}
	}

	public static void main(String[] args) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		NestTest1 nest1 = new NestTest1("1133710503", "wyx", "hit");
		NestTest2 nest2 = new NestTest2("hit","Harbin Institute of Technology");
		DynaClass dynaClass = combineClass("combine",NestTest1.class,NestTest2.class,null,null);
		DynaBean bean = combine(dynaClass,nest1,nest2);
		
		System.out.println("Id = "+bean.get("id"));
		System.out.println("name = "+bean.get("name"));
		System.out.println("schoolId = "+bean.get( "schoolId"));
		System.out.println("schoolName = "+bean.get( "schoolName"));
	}
	
	public static DynaBean combine(DynaClass dynaClass,Object o1,Object o2){
		try {
			DynaBean dynaBean = dynaClass.newInstance();
			copyProperties(dynaBean, o1);
			copyProperties(dynaBean, o2);
			return dynaBean;
		} catch (IllegalAccessException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static DynaClass combineClass(String classname,Object clazz1,Object clazz2,String[] exclude1,String[] exclude2){
		DynaClass wdc1,wdc2;
		
		if(clazz1 instanceof DynaClass){
			wdc1 = (DynaClass) clazz1;
		}else{
			wdc1 = WrapDynaClass.createDynaClass((Class<?>) clazz1);
		}
		
		if(clazz2 instanceof DynaClass){
			wdc2 = (DynaClass) clazz2;
		}else{
			wdc2 = WrapDynaClass.createDynaClass((Class<?>) clazz2);
		}
		
		List<DynaProperty> proplist1 = new ArrayList<DynaProperty>(Arrays.asList(wdc1.getDynaProperties()));
		CollectionUtils.filter(proplist1, new PropExcludePredicte(exclude1));
		
		List<DynaProperty> proplist2 = new ArrayList<DynaProperty>(Arrays.asList(wdc2.getDynaProperties()));
		CollectionUtils.filter(proplist2, new PropExcludePredicte(exclude2));
		
		@SuppressWarnings("unchecked")
		List<DynaProperty> proplist = ListUtils.union(proplist1, proplist2);
		
		DynaProperty[] props = proplist.toArray(new DynaProperty[proplist.size()]);
		
		BasicDynaClass dynaClass = new BasicDynaClass("classname",null,props);
		return dynaClass;
	}
	
	public static void copyProperties(DynaBean dest,Object src){
		DynaBean source;
		if(src instanceof DynaBean){
			source = (DynaBean) src;
		}else{
			source = new WrapDynaBean(src);
		}
		
		DynaClass sc = source.getDynaClass();
		DynaProperty[] sps = sc.getDynaProperties();
		
		DynaClass dc = dest.getDynaClass();
		DynaProperty[] dps = dc.getDynaProperties();
		
		for(DynaProperty sp:sps){
			for(DynaProperty dp:dps){
				if(dp.getName().equals(sp.getName())){
					dest.set(dp.getName(), source.get(dp.getName()));
					break;
				}
			}
		}
		
	}
	
	public static class NestTest1{
		private String id,name,schoolId;

		public String getId() {
			return id;
		}

		public String getName() {
			return name;
		}

		public String getSchoolId() {
			return schoolId;
		}

		public void setId(String id) {
			this.id = id;
		}

		public void setName(String name) {
			this.name = name;
		}

		public void setSchoolId(String schoolId) {
			this.schoolId = schoolId;
		}

		public NestTest1() {
			super();
		}

		public NestTest1(String id, String name, String schoolId) {
			super();
			this.id = id;
			this.name = name;
			this.schoolId = schoolId;
		}
		
	}
	
	public static class NestTest2{
		private String schoolId,schoolName;

		public String getSchoolId() {
			return schoolId;
		}

		public String getSchoolName() {
			return schoolName;
		}

		public void setSchoolId(String schoolId) {
			this.schoolId = schoolId;
		}

		public void setSchoolName(String schoolName) {
			this.schoolName = schoolName;
		}

		public NestTest2() {
			super();
			// TODO 自动生成的构造函数存根
		}

		public NestTest2(String schoolId, String schoolName) {
			super();
			this.schoolId = schoolId;
			this.schoolName = schoolName;
		}
		
		
	}
}
