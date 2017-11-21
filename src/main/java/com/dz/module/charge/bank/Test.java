package com.dz.module.charge.bank;

import com.dz.module.contract.Contract;
import com.dz.module.vehicle.Vehicle;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Test {
    public static void main(String[] args) throws ParseException {
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        SessionFactory sessionFactory = (SessionFactory) app.getBean("sessionFactory");
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        ZhaoShangDiscount discount = new ZhaoShangDiscount();
        /**
         * <NTQATSQYZ><ACCNBR>451904469910901</ACCNBR><ATHFLG>N</ATHFLG><BBKNBR>45</BBKNBR>
         * <BUSCOD>N03030</BUSCOD><BUSMOD>00001</BUSMOD><CCYNBR>10</CCYNBR><C_CCYNBR>人民币</C_CCYNBR>
         * <C_TRSTYP>代扣其他</C_TRSTYP><EPTDAT>20170828</EPTDAT><EPTTIM>000000</EPTTIM>
         * <NUSAGE>收出租车租金</NUSAGE><OPRDAT>20170828</OPRDAT><REQNBR>1011362260</REQNBR>
         * <REQSTA>FIN</REQSTA><RSV62Z>P</RSV62Z><RTNFLG>S</RTNFLG><SUCAMT>665740.31</SUCAMT>
         * <SUCNUM>000169</SUCNUM><TOTAMT>774816.49</TOTAMT><TRSNUM>000196</TRSNUM><TRSTYP>AYBK</TRSTYP>
         * <YURREF>QK20170828183251</YURREF></NTQATSQYZ>
         */
        discount.setTotalMoney(BigDecimal.valueOf(774816.49));
        discount.setTotalCount(196);
        discount.setChargeTime(new Date());
        discount.setYurref("QK20170828183251");
        discount.setBankSeq("1011362260");
        discount.setStates(0);

//        BankCardOfVehicle bv = new BankCardOfVehicle();
//        BankCard bankCard = (BankCard) session.get(BankCard.class,2);
//        Vehicle vehicle = (Vehicle) session.get(Vehicle.class,"LFV2A11G283082324");
//        bv.setBankCard(bankCard);
//        bv.setVehicle(vehicle);
//        bv.setIsDefaultRecive(true);
        session.saveOrUpdate(discount);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        BankItem item = new BankItem();
        item.setState(0);
        item.setCardNumber("620000123456");
        item.setZhaoShangDiscount(discount);
        item.setRegister("陈东慧");
        item.setForTime(sdf.parse("2017-08-01"));
        item.setPlanFee(BigDecimal.valueOf(4096.00));
        item.setApplyTime(discount.getChargeTime());
        item.setContract((Contract) session.get(Contract.class,1));
        session.saveOrUpdate(item);

        tx.commit();
//        Query query = session.createQuery("select count(*) from com.dz.module.vehicle.Vehicle where  state>=0  and licenseNum like '%黑A%'  and state in (1,3)  and carframeNum in (select vehicle.carframeNum from BankCardOfVehicle )");
//        long count = (long) query.uniqueResult();
//        System.out.println(count);
        sessionFactory.close();
    }
}
