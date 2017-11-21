package com.dz.common.tablelist;

import com.dz.common.global.BaseAction;

import net.sf.json.JSONArray;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.BooleanUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
@Controller
@Scope("prototype")
public class TableListAction extends BaseAction {
	@Autowired
	private TableListService tableListService;

	public void setTableListService(TableListService tableListService) {
		this.tableListService = tableListService;
	}
	
	private String name;//TableList 的 name
	private ListValue listValue; 
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public ListValue getListValue() {
		return listValue;
	}
	public void setListValue(ListValue listValue) {
		this.listValue = listValue;
	}
	
	public void getRootId() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		TableList tableList = tableListService.getOrCreate(name);
		if(tableList==null){
			System.err.println("无法获取名称为"+name+"的TableList");
			return;
		}
		
		ListValue root = tableListService.getRoot(tableList);
		
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print(root.getId());
		out.flush();
		out.close();
	}
	
/**
 * 根据列表名称，获取该列表的1级元素
 * @throws IOException 
 */
	@SuppressWarnings("unchecked")
	public void getList() throws IOException{
		TableList tableList = tableListService.getOrCreate(name);
		if(tableList==null){
			System.err.println("无法获取名称为"+name+"的TableList");
			return;
		}
		
		ListValue root = tableListService.getRoot(tableList);
		List<ListValue> ls = tableListService.getChildren(root);
		
		ls = (List<ListValue>) CollectionUtils.select(ls, new Predicate(){
			@Override
			public boolean evaluate(Object object) {
				Boolean visable=null;
				try {
					visable = (Boolean) PropertyUtils.getProperty(object, "visible");
				} catch (IllegalAccessException | InvocationTargetException
						| NoSuchMethodException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return BooleanUtils.isNotFalse(visable);
			}
		});
		
		JSONArray json = JSONArray.fromObject(ls);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print(json.toString());
		out.flush();
		out.close();
	}
	
	@SuppressWarnings("unchecked")
	public void getSubList() throws IOException{
		if(listValue==null){
			System.err.println("listValue为null");
			return;
		}
		
		ListValue flv = tableListService.getListValue(listValue.getId());
		
		if(flv==null){
			System.err.println("无法获取id为"+listValue.getId()+"的ListValue");
			return;
		}
		
		List<ListValue> ls = tableListService.getChildren(flv);
		ls = (List<ListValue>) CollectionUtils.select(ls, new Predicate(){
			@Override
			public boolean evaluate(Object object) {
				Boolean visable=null;
				try {
					visable = (Boolean) PropertyUtils.getProperty(object, "visible");
				} catch (IllegalAccessException | InvocationTargetException
						| NoSuchMethodException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return BooleanUtils.isNotFalse(visable);
			}
		});
		
		JSONArray json = JSONArray.fromObject(ls);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print(json.toString());
		out.flush();
		out.close();
	}
	
	public void getFathersValue() throws IOException{
		if(listValue==null){
			System.err.println("listValue为null");
			return;
		}
		
		ListValue flv = tableListService.getListValue(listValue.getId());
		
		if(flv==null){
			System.err.println("无法获取id为"+listValue.getId()+"的ListValue");
			return;
		}
		
		List<String> ls = tableListService.getFathersValue(flv);
		
		JSONArray  json = JSONArray .fromObject(ls);
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print(json.toString());
		out.flush();
		out.close();
	}
	
	private String subItemName;
	
	public String getSubItemName() {
		return subItemName;
	}
	public void setSubItemName(String subItemName) {
		this.subItemName = subItemName;
	}
	
	public void addSubItem() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		
		if(listValue==null){
			System.err.println("listValue为null");
			out.print(false);
			return;
		}
		
		ListValue flv = tableListService.getListValue(listValue.getId());
		
		if(flv==null){
			System.err.println("无法获取id为"+listValue.getId()+"的ListValue");
			out.print(false);
			return;
		}
		
		int id = tableListService.addSubItem(flv, new ListValue(subItemName,null,null));
		
		out.print(id);
		out.flush();
		out.close();
	}
	
	public void addSuperItem() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		
		TableList tableList = tableListService.getOrCreate(name);
		if(tableList==null){
			System.err.println("无法获取名称为"+name+"的TableList");
			out.print(false);
			return;
		}
		
		ListValue root = tableListService.getRoot(tableList);
		
		tableListService.addSubItem(root, new ListValue(subItemName,null,null));
		
		out.print(true);
		out.flush();
		out.close();
	}
	
	public void updateItem() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		
		if(listValue==null){
			System.err.println("listValue为null");
			out.print(false);
			return;
		}
		
		ListValue lv = tableListService.getListValue(listValue.getId());
		
		if(lv==null){
			System.err.println("无法获取id为"+listValue.getId()+"的ListValue");
			out.print(false);
			return;
		}
		
		ListValue flv = tableListService.getFather(lv);
		tableListService.addSubItem(flv, lv);
		
		out.print(true);
		out.flush();
		out.close();
	}
	
	/**
	 * 此处为伪删除，实质为隐藏
	 * @throws IOException 
	 */
	public void deleteItem() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		
		if(listValue==null){
			System.err.println("listValue为null");
			out.print(false);
			return;
		}
		
		ListValue lv = tableListService.getListValue(listValue.getId());
		
		if(lv==null){
			System.err.println("无法获取id为"+listValue.getId()+"的ListValue");
			out.print(false);
			return;
		}
		
		tableListService.hideItem(lv);
		
		out.print(true);
		out.flush();
		out.close();
	}

}
