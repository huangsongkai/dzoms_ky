package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.contract.ContractTemplate2;
import com.dz.module.driver.Driver;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class InsuranceService {
	@Autowired
	private InsuranceDao insuranceDao;
	
	
	public void addInsurance(Insurance insurance) throws HibernateException {
		insuranceDao.addInsurance(insurance);
	}

	
	public void updateInsurance(Insurance insurance) throws HibernateException {
		insuranceDao.updateInsurance(insurance);
	}

	
	public void deleteInsurance(Insurance insurance) throws HibernateException {
		insuranceDao.deleteInsurance(insurance);
	}

	
	public List<Insurance> selectAll() {
		return insuranceDao.selectAll();
	}

	
	public List<Insurance> selectByVehicle(Vehicle vehicle) {
		return insuranceDao.selectByVehicle(vehicle);
	}

	
	public List<Insurance> selectByDriver(Driver driver) {
		return insuranceDao.selectByDriver(driver);
	}

	

	public void setInsuranceDao(InsuranceDao insuranceDao) {
		this.insuranceDao = insuranceDao;
	}


	public int selectByConditionCount(Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd) {
		return insuranceDao.selectByConditionCount(insurance,vehicle,inputFrom,inputEnd,startFrom,startEnd);
	}


	public List<Insurance> selectByCondition(Page page, Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd) {
		return insuranceDao.selectByCondition(page,insurance,vehicle,inputFrom,inputEnd,startFrom,startEnd);
	}

    static void makeDivide2(Session s, Insurance insurance, BigDecimal insuranceBase) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(insurance.getBeginDate());
        int beginYear = calendar.get(Calendar.YEAR),beginMonth = calendar.get(Calendar.MONTH),beginDate = calendar.get(Calendar.DATE);
        calendar.setTime(insurance.getEndDate());
        int endYear = calendar.get(Calendar.YEAR),endMonth = calendar.get(Calendar.MONTH),endDate = calendar.get(Calendar.DATE);

        int local_months = (endYear - beginYear) * 12 + (endMonth - beginMonth)+(beginDate<27?1:0)+(endDate>26?1:0);
        int beginRank = beginYear * 12 + beginMonth + (beginDate>26?1:0) + 1; //最后的+1 是因为Calendar 的Month从0开始

        int totalDays = ContractTemplate2.TemplatePage.calDateSpan(insurance.getBeginDate(), insurance.getEndDate());
        if (totalDays==0){
            System.out.println("Insurance Error:"+insurance);
            return;
        }
        BigDecimal moneyPerDay = insuranceBase.divide(BigDecimal.valueOf(totalDays), RoundingMode.HALF_EVEN);
        int totalMoney = 0;
       // vehicle = (Vehicle) s.get(Vehicle.class, insurance.getCarframeNum());
        for (int i=1;i<local_months-1;i++) {
            double money = moneyPerDay.multiply(BigDecimal.valueOf(30)).setScale(0,RoundingMode.HALF_DOWN).doubleValue();
            totalMoney += money;
            InsuranceDivide2 divide = new InsuranceDivide2(beginRank+i, insurance.getId(), money);
            divide.setCarframeNum(insurance.getCarframeNum());
            s.saveOrUpdate(divide);
        }

        int days = 0;
        if(local_months==1){
            //这一段时间在一个月里面
            InsuranceDivide2 divide = new InsuranceDivide2(beginRank, insurance.getId(), insuranceBase.doubleValue());
            divide.setCarframeNum(insurance.getCarframeNum());
            s.saveOrUpdate(divide);
        }else{
            //这一段时间分属不同的月
            //第一个月
            if(beginDate==27){
                days=30;
            }else if(beginDate>27){
                //days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginDate+27;
                days = 57 - beginDate + (beginDate>30?1:0);
            }else{
                days = 27 - beginDate;
            }
            BigDecimal planOfRent = moneyPerDay.multiply(BigDecimal.valueOf(days)).setScale(0,RoundingMode.HALF_DOWN);
            totalMoney += planOfRent.intValue();
            InsuranceDivide2 divide = new InsuranceDivide2(beginRank, insurance.getId(),planOfRent.doubleValue());
            divide.setCarframeNum(insurance.getCarframeNum());
            s.saveOrUpdate(divide);

            //最后一个月
//						if(endDate==26){
//							days=30;
//						}else if(endDate>=30){
//							days = 4;
//						}else if(endDate>26){
//							days = endDate - 26;
//						}else{
//							//days = parseInt(getDaysOfMonth(endArr[0],endArr[1]-1))+parseInt(endDate)-26;
//							days = 4 + endDate;
//						}
//						planOfRent = moneyPerDay.multiply(BigDecimal.valueOf(days-1)) ;
//						divide = new InsuranceDivide2(beginRank+local_months-1,insurance1.getId(),planOfRent.doubleValue());
            planOfRent = insuranceBase.subtract(BigDecimal.valueOf(totalMoney));
            if (planOfRent.compareTo(BigDecimal.ZERO)>0){
                divide = new InsuranceDivide2(beginRank+local_months-1, insurance.getId(),planOfRent.doubleValue());
                divide.setCarframeNum(insurance.getCarframeNum());
                s.saveOrUpdate(divide);
            }else {
                InsuranceDivide2.InsuranceDivideID divideID = new InsuranceDivide2.InsuranceDivideID();
                divideID.setInsuranceId(insurance.getId());
                divideID.setMonthRank(beginRank+local_months-2);
                divide = (InsuranceDivide2) s.get(InsuranceDivide2.InsuranceDivideID.class,divideID);
                divide.setMoney(divide.getMoney()+planOfRent.doubleValue());
//                divide = new InsuranceDivide2(beginRank+local_months-1, insurance.getId(),planOfRent.doubleValue());
//                divide.setCarframeNum(insurance.getCarframeNum());
                s.saveOrUpdate(divide);
            }
        }
    }

    /**
     * 检查新录保险时间范围内是否已有保险记录
     * @param s
     * @param carframeNum
     * @param beginDate 新录保险的起始时间
     * @return 正常时(不存在时) 返回 true
     */
    public boolean checkInsuranceDivide(Session s, String carframeNum, Date beginDate){
        Query query = s.createQuery("select count(*) from InsuranceDivide2 where carframeNum=:car and id.monthRank > :rank ");
        query.setString("car",carframeNum);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(beginDate);
        query.setInteger("rank",calendar.get(Calendar.YEAR)*12+calendar.get(Calendar.MONTH));
        long size = (long) query.uniqueResult();
        return size==0;
    }

    static void makeDivide(Session s, Insurance insurance, BigDecimal insuranceBase) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(insurance.getBeginDate());
        int beginYear = calendar.get(Calendar.YEAR),beginMonth = calendar.get(Calendar.MONTH);
        calendar.setTime(insurance.getEndDate());
        int endYear = calendar.get(Calendar.YEAR),endMonth = calendar.get(Calendar.MONTH);

        int local_months = 12;
//        int local_months = (beginYear-endYear)*12+endMonth-beginMonth;
        int beginRank = beginYear * 12 + beginMonth + 1; //最后的+1 是因为Calendar 的Month从0开始

//        if (local_months!=12){
//            System.out.println("该保险起止时间范围不为12个月，存在错误:"+insurance);
//            return;
//        }

        BigDecimal moneyPerDay = insuranceBase.setScale(2).divide(BigDecimal.valueOf(12.0), RoundingMode.HALF_EVEN);
        BigDecimal totalMoney = BigDecimal.ZERO.setScale(2,RoundingMode.HALF_EVEN);
       // vehicle = (Vehicle) s.get(Vehicle.class, insurance.getCarframeNum());
        for (int i=0;i<11;i++) {
            totalMoney = totalMoney.add(moneyPerDay);
            InsuranceDivide2 divide = new InsuranceDivide2(beginRank+i, insurance.getId(), moneyPerDay.doubleValue());
            divide.setCarframeNum(insurance.getCarframeNum());
            s.saveOrUpdate(divide);
        }

            //最后一个月
        BigDecimal planOfRent = insuranceBase.subtract(totalMoney);
        if (planOfRent.compareTo(BigDecimal.ZERO)>0){
            InsuranceDivide2 divide = new InsuranceDivide2(beginRank+local_months-1, insurance.getId(),planOfRent.doubleValue());
            divide.setCarframeNum(insurance.getCarframeNum());
            s.saveOrUpdate(divide);
        }else {
            //一般不可能出现，除非 每月租金在 0.5 -- 12/13 之间
            InsuranceDivide2.InsuranceDivideID divideID = new InsuranceDivide2.InsuranceDivideID();
            divideID.setInsuranceId(insurance.getId());
            divideID.setMonthRank(beginRank+local_months-2);
            InsuranceDivide2 divide = (InsuranceDivide2) s.get(InsuranceDivide2.InsuranceDivideID.class,divideID);
            divide.setMoney(divide.getMoney()+planOfRent.doubleValue());
//            divide = new InsuranceDivide2(beginRank+local_months-1, insurance.getId(),planOfRent.doubleValue());
//            divide.setCarframeNum(insurance.getCarframeNum());
            s.saveOrUpdate(divide);
        }

    }

    public static void main(String[] args) {
        ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        HibernateSessionFactory.rebuildSessionFactory(applicationContext);

        Session session = HibernateSessionFactory.getSession();
        SQLQuery sqlQuery = session.createSQLQuery("SELECT\n" +
                "ii.insuranceId,\n" +
                "ii.money\n" +
                "FROM\n" +
                "insurance_divide_import AS ii\n" +
                "WHERE ii.insuranceId IS NOT NULL\n" +
                "AND NOT EXISTS (SELECT 1 FROM insurance_divide WHERE insurance_divide.insuranceId = ii.insuranceId)");
        List<Object[]> list = sqlQuery.list();
//        List<Object[]> list = Collections.singletonList(new Object[]{179,6383.0});

        for (Object[] objects : list) {
            int insuranceId = (int) objects[0];
            BigDecimal money = BigDecimal.valueOf(((Number) objects[1]).doubleValue());
//            System.out.println(insuranceId+"\t"+money);

            Insurance insurance = (Insurance) session.get(Insurance.class,insuranceId);
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                makeDivide(session,insurance,money);
                tx.commit();
            }catch (Exception ex){
                ex.printStackTrace();
                System.out.println(Arrays.toString(objects));
                if (tx!=null){
                    tx.rollback();
                }
            }
        }

        HibernateSessionFactory.closeSession();
    }
}
