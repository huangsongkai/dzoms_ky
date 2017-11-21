package com.dz.module.contract;

import com.dz.common.global.Page;

import java.util.List;

import com.dz.module.charge.ChargeDao;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BankCardService {
	@Autowired
	private BankCardDao bankCardDao;
	@Autowired
	private ContractDao contractDao;
	@Autowired
	private ChargeDao chargeDao;

	public boolean bankCardAdd(BankCard card) {
		if (card == null) {
			return false;
		}
		return bankCardDao.bankCardAdd(card);
	}

	public int queryCardCount() {
		return bankCardDao.queryCardCount();
	}

	public List<BankCard> bankCardSearch(Page page){
		return bankCardDao.queryAllCard(page);
	}

	public BankCard getBankCardByCardNumber(String id) {
		return bankCardDao.getBankCardByCardNumber(id);
	}

	public BankCard getBankCardForPayByDriverId(String idNum,String carNum,String cardClass) {
		if (StringUtils.isEmpty(idNum)) {
			return null;
		}
		return bankCardDao.getBankCardForPayByDriverId(idNum,carNum,cardClass);
	}

	public BankCard getBankCardForReceiveByDriverId(String idNum,String carNum) {
		if (StringUtils.isEmpty(idNum)) {
			return null;
		}
		return bankCardDao.getBankCardForRecieveByDriverId(idNum,carNum);
	}

	public boolean bankCardUpdate(BankCard card) {
		if (card == null) {
			return false;
		}

		return bankCardDao.bankCardUpdate(card);
	}

	public void setBankCardDao(BankCardDao bankCardDao) {
		this.bankCardDao = bankCardDao;
	}
}
