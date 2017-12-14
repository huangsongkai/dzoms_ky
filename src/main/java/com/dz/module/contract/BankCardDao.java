package com.dz.module.contract;

import com.dz.common.global.Page;

import org.hibernate.HibernateException;

import java.util.List;

public interface BankCardDao {
	public boolean bankCardAdd(BankCard card) throws HibernateException;
	public boolean bankCardUpdate(BankCard card) throws HibernateException;
	public BankCard getBankCardByCardNumber(String id) throws HibernateException;
	public List<BankCard> queryAllCard(Page page) throws HibernateException;
	public int queryCardCount() throws HibernateException;
	public BankCard getBankCardForPayByDriverId(String driverId, String carNum, String cardClass);
	public BankCard getBankCardForPayByDriverIdWithoutCloseSession(String driverId, String carNum, String cardClass);
	BankCard getBankCardForRecieveByDriverId(String driverId, String carNum);
}	
