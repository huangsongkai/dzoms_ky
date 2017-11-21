package com.dz.module.vehicle;

//import java.util.ArrayList;

import org.hibernate.HibernateException;

public interface DuanXinDao {
	public void addDuanXin(DuanXin duanXin) throws HibernateException;
	public void updateDuanXin(DuanXin duanXin) throws HibernateException;
	public void deleteDuanXin(DuanXin duanXin) throws HibernateException;

}
