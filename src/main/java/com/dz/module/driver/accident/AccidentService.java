package com.dz.module.driver.accident;

import com.dz.common.global.TimePass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class AccidentService {
    @Autowired
    AccidentDao accDao;
    @Autowired
    AccidentCheckDao accidentCheckDao;
    public String accidentAddOrUpdate(Accident accident){
		String res = accDao.addOrUpdateAccident(accident);
        if(accident!=null&&res.equals("success")){
			accDao.updateStatus(accident,0);
		}
		return res;
	}
	/**
	 * @param accident 复核通过的事故
	 * @param ac 复核实例
	 * @return success
	 */
	public String accidentChecked(Accident accident,AccidentCheck ac){
		saveCheck(ac,accident.getAccId(),true);
		accDao.addCheck(accident, ac.getChecker(), ac.getAcTime());
		return accDao.updateStatus(accident,2);
	}
	/**
	 * @param accident 复核不通过的事故
	 * @param ac 复核实例
	 * @return success
	 */
	public String accidentUnChecked(Accident accident,AccidentCheck ac){
		saveCheck(ac,accident.getAccId(),false);
		return accDao.updateStatus(accident,1);
	}
	/**
	 * @param accident 要进行赔付的事故
	 * @param pay 赔付实例
	 * @return success
	 */
	public String accidentPay(Accident accident,Pay pay){
		accDao.addPay(accident, pay.getPayer(), pay.getTime(), pay.getMoney());
        accDao.updateStatus(accident,3);
		return "success";
	}
	/**
	 * @param accident 要查询所有复核记录的事故
	 * @return 所有复核记录
	 */
	public List<AccidentCheck> selectAllCheckRecord(Accident accident){
		return accidentCheckDao.allAccidentCheck(accident);
	}
	/**
	 * @param driverId 要查询的司机id
	 * @param style 查询的格式
	 * @return 事故列表
	 */
	public List<Accident> accidentSelects(String driverId, int style, TimePass tp){
		return accDao.selectAccidents(driverId, style, tp);
	}

    /**
     * @param accident
     * @param loss:汇集车辆损失，车辆赔付，人员损失等
     * @return success/data_error
     */
	public String accidentUpdateLoss(Accident accident,Loss loss){
		return accDao.updateLoss(accident, loss);
	}
	
	private boolean saveCheck(AccidentCheck ac,int accidentId,boolean passed){
		ac.setaId(accidentId);
		ac.setPassed(passed);
		return accidentCheckDao.addOne(ac);
	}
	public Accident accidentSelectById(Accident accidnt){
		return accDao.accidentSelectById(accidnt);
	}
	public boolean addInsuranceDetail(AccidentInsurance ai){
		return accDao.addInsuranceDetail(ai);
	}
	public AccidentInsurance getAccidentInsurance(int accId){
		return accDao.getInsurance(accId);
	}
}
