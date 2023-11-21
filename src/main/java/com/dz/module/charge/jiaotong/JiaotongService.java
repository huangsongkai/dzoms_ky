package com.dz.module.charge.jiaotong;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.other.ObjectAccess;
import com.dz.module.charge.ChargePlan;
import com.dz.module.charge.ChargeService;
import com.dz.module.charge.ClearTimeDao;
import com.dz.module.charge.insurance.InsuranceBack;
import com.dz.module.contract.Contract;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import org.hibernate.*;
import org.javatuples.Pair;
import org.jxls.reader.ReaderBuilder;
import org.jxls.reader.XLSReadStatus;
import org.jxls.reader.XLSReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.dz.module.charge.insurance.InsuranceBackService.selectByCarId;

@Service
public class JiaotongService {
    @Autowired
    private ClearTimeDao clearTimeDao;
    @Autowired
    private ChargeService chargeService;

    public String uploadExcel(InputStream inputXLS){
        List<Payment> payments = loadFromInputStream(inputXLS);
        if (payments==null || payments.size()==0){
            return "文件解析失败或文件中无数据！";
        }
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateSessionFactory.getSession();
            final Query matchLicenseNum = session.createQuery("from Vehicle where licenseNum=:num order by inDate desc");
            matchLicenseNum.setMaxResults(1);
            tx = session.beginTransaction();

            for (Payment payment : payments) {
                JiaoTongBankRecord record = asRecord(payment);
                if(record==null)
                    continue;
                if (record.getState()==1){
                    matchLicenseNum.setString("num", record.getCarNo());
                    Vehicle vehicle = (Vehicle) matchLicenseNum.uniqueResult();
                    if (vehicle == null){
                        record.setState((short) 2);
                        record.setReason("无法找到对应车辆");
                    }else {
                        record.setCarframeNum(vehicle.getCarframeNum());
                    }
                }

                try {
                    session.save(record);
                } catch (NonUniqueObjectException ignore){}
            }

            tx.commit();
        }catch (HibernateException e){
            e.printStackTrace();
            try {
                if (tx!=null){
                    tx.rollback();
                }
            }catch (TransactionException ex){
                ex.printStackTrace();
                return  "数据库操作失败！"+ex.getMessage();
            }
        }finally {
            HibernateSessionFactory.closeSession();
        }

        return "操作成功";
    }

    public String updateComment(String id, String additionalInfo){
        JiaoTongBankRecord record = ObjectAccess.getObject(JiaoTongBankRecord.class,id);

        if (record==null){
            return "数据不存在";
        }

        Pair<String,Integer> pair = parse(additionalInfo);
        String carNo = pair.getValue0();
        int month = pair.getValue1();

        if (carNo==null || month==-1){
            record.setState((short) 2);
            record.setReason("备注文本格式错误");
            ObjectAccess.saveOrUpdate(record);
            return "格式仍然不正确";
        }

        Vehicle vehicle = ObjectAccess.execute("from Vehicle where licenseNum='"+record.getCarNo()+"' order by inDate desc");
        if (vehicle==null){
            record.setState((short) 2);
            record.setReason("无法找到对应车辆");
            return "无法找到对应车辆";
        }
        record.setCarframeNum(vehicle.getCarframeNum());
        record.setState((short) 1);
        record.setReason(null);
        return "操作成功";
    }

    public void confirmChecked(List<JiaoTongBankRecord> backs, User user){
        Session session;
        Transaction tx = null;

        Date chargeClearTime = clearTimeDao.getCurrent("total");

        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();

            for (JiaoTongBankRecord back : backs) {
                back = (JiaoTongBankRecord) session.get(JiaoTongBankRecord.class,back.getOrderNo());
                if (back!=null && back.getState()==1){
                    ChargePlan chargePlan = new ChargePlan();
                    chargePlan.setFeeType("add_bank");
                    chargePlan.setFee(back.getAmount());
                    chargePlan.setTime(chargeClearTime);

                    Calendar calendar = Calendar.getInstance();
                    if (calendar.get(Calendar.MONTH)+1 >= back.getMonth()){
                        calendar.set(Calendar.MONTH,back.getMonth()-1);
                    }else {
                        calendar.add(Calendar.YEAR,-1);
                        calendar.set(Calendar.MONTH,back.getMonth()-1);
                    }

                    Contract contract = selectByCarId(back.getCarframeNum(),calendar.getTime(),session);
                    if (contract==null || ! contract.getCarframeNum().equalsIgnoreCase(back.getCarframeNum())){
                        back.setState((short) 4);
                        back.setReason("找不到对应的合同");
                        session.saveOrUpdate(back);
                        continue;
                    }

                    chargePlan.setContractId(contract.getId());
                    chargePlan.setComment(back.getOrderNo());
                    chargePlan.setInTime(new Date());
                    chargePlan.setRegister(user.getUname());
                    chargeService.addChargePlan(chargePlan,session);

                    back.setState((short) 3);
                    back.setChargeId(chargePlan.getId());
                    session.saveOrUpdate(back);
                }
            }

            tx.commit();
        }catch (HibernateException e){
            e.printStackTrace();
            try {
                if (tx!=null){
                    tx.rollback();
                }
            }catch (TransactionException ex){ }
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    public static List<Payment> loadFromInputStream(InputStream inputXLS){
        try {
            XLSReader mainReader = ReaderBuilder.buildFromXML( new ByteArrayInputStream(JiaoTongXlsMapping.getBytes()) );
            Map<String, Object> beans = new HashMap<>();
            List<Payment> payments = new ArrayList<>();
            beans.put("payments", payments);

            XLSReadStatus readStatus = mainReader.read(inputXLS, beans);
            if(readStatus.isStatusOK()){
                payments = (List<Payment>) beans.get("payments");
                return payments;
            }
        }catch (Exception ignored){}
        return Collections.emptyList();
    }

    public static JiaoTongBankRecord asRecord(Payment payment){
        if ("租金（公司收款）".equals(payment.getProject())) {
            JiaoTongBankRecord record = new JiaoTongBankRecord();
            record.setOrderNo(payment.getOrderNo());
            record.setComment(payment.getAdditionalInfo());
            record.setAmount(BigDecimal.valueOf(payment.getTransactionAmount()));

            String additionalInfo = payment.getAdditionalInfo();

            Pair<String,Integer> pair = parse(additionalInfo);
            String carNo = pair.getValue0();
            int month = pair.getValue1();

            if (carNo==null || month==-1){
                record.setState((short) 2);
                record.setReason("备注文本格式错误");
            }else {
                record.setCarNo(carNo);
                record.setMonth(month);
                record.setState((short) 1);
            }
            return record;
        }else {
            return null;
        }
    }

    static Pattern pattern = Pattern.compile("车号:(黑A)?([a-zA-Z0-9]{5,6}).*?月份:(\\S+)(.*)");

    public static Pair<String,Integer> parse(String line) {
        // 在当前行中查找车号、月份和剩余部分
        Matcher matcher = pattern.matcher(line);
        if (matcher.matches()) {
//            String prefix = matcher.group(1);  // 车号前缀（可能为空）
            String vehicleNo = matcher.group(2);  // 车号
//            int month = Integer.parseInt(matcher.group(3));  // 月份
            int month = parseChineseMonth(matcher.group(3));  // 月份
//            String suffix = matcher.group(4);  // 剩余部分

            // 如果车号前缀为空，则添加“黑A”前缀
            vehicleNo = "黑A" + vehicleNo;

            // 将车号转换为大写字母
            vehicleNo = vehicleNo.toUpperCase();

            // 输出车号、月份和剩余部分
            return new Pair<>(vehicleNo,month);
        }
        return new Pair<>(null,-1);
    }

    static final String[] MONTH_STRING ={"十二", "十一", "十", "九", "八", "七", "六", "五", "四", "三", "二", "一","12", "11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1"};
    static final int[] MONTH_RANK = {12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1,12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1};

    private static int parseChineseMonth(String s) {
        for (int i = 0; i < MONTH_STRING.length; i++) {
            if (s.startsWith(MONTH_STRING[i])) {
                return MONTH_RANK[i];
            }
        }
        return -1;
    }

    static final String JiaoTongXlsMapping = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
            "<workbook>\n" +
            "    <worksheet idx=\"0\">\n" +
            "        <section startRow=\"0\" endRow=\"1\"></section>\n" +
            "        <loop startRow=\"1\" endRow=\"1\" items=\"payments\" var=\"payment\" varType=\"com.dz.module.charge.jiaotong.Payment\">\n" +
            "            <section startRow=\"1\" endRow=\"1\">\n" +
            "                <mapping row=\"1\" col=\"0\">payment.project</mapping>\n" +
            "                <mapping row=\"1\" col=\"4\">payment.transactionDate</mapping>\n" +
            "                <mapping row=\"1\" col=\"5\">payment.transactionTime</mapping>\n" +
            "                <mapping row=\"1\" col=\"6\">payment.transactionAmount</mapping>\n" +
            "                <mapping row=\"1\" col=\"13\">payment.additionalInfo</mapping>\n" +
            "                <mapping row=\"1\" col=\"16\">payment.orderNo</mapping>\n" +
            "            </section>\n" +
            "            <loopbreakcondition>\n" +
            "                <rowcheck offset=\"0\">\n" +
            "                    <cellcheck offset=\"0\"></cellcheck>\n" +
            "                </rowcheck>\n" +
            "            </loopbreakcondition>\n" +
            "        </loop>\n" +
            "    </worksheet>\n" +
            "</workbook>";

    public void setClearTimeDao(ClearTimeDao clearTimeDao) {
        this.clearTimeDao = clearTimeDao;
    }

    public void setChargeService(ChargeService chargeService) {
        this.chargeService = chargeService;
    }
}
