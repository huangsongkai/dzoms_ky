package com.dz.module.driver.accident;

import com.dz.common.global.TimePass;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface AccidentDao {
	String addOrUpdateAccident(Accident accident);
	String updateStatus(Accident accident, int status);
	String updateLoss(Accident accident, Loss loss);
	List<Accident> selectAccidents(String driverId, int style, TimePass tp);
	boolean addCheck(Accident ac, int checker, Date time);
	boolean addPay(Accident ac, String payer, Date time, BigDecimal money);
	Accident accidentSelectById(Accident accident);
	boolean addInsuranceDetail(AccidentInsurance insurance);
	AccidentInsurance getInsurance(int accId);
}
