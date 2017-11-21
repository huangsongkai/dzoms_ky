package com.dz.common.tablelist;

import org.hibernate.HibernateException;

import java.util.List;

public interface TableListDao {

	TableList get(String name) throws HibernateException;

	ListValue getRoot(TableList tl) throws HibernateException;

	List<ListValue> getChildren(ListValue lf) throws HibernateException;

	ListValue getFather(ListValue lf) throws HibernateException;

	void addTableList(TableList tl) throws HibernateException;

	void hideItem(ListValue lv) throws HibernateException;

	void deleteItem(ListValue lv) throws HibernateException;

	void addSubItems(ListValue flv, ListValue... lvs) throws HibernateException;

	ListValue getListValue(int id);

	TableList getById(int tableListId);

	int addSubItem(ListValue root, ListValue listValue);

	void deleteTableList(int id) throws HibernateException;

}
