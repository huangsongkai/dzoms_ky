package com.dz.module.charge.insurance;

import com.dz.common.el.ELUtil;
import com.dz.common.factory.HibernateSessionFactory;
import com.dz.module.charge.ChargePlan;
import com.dz.module.charge.ChargeService;
import com.dz.module.charge.ClearTime;
import com.dz.module.charge.ClearTimeDao;
import com.dz.module.contract.Contract;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.lang3.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class InsuranceBackService {
    @Value("#{configProperties['accountNumber']}")
    private String accountNumber;

    @Autowired
    @Qualifier("configProperties")
    private Properties properties;

    @Autowired
    private ClearTimeDao clearTimeDao;
    @Autowired
    private ChargeService chargeService;

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public static String sendRequest(String urlString, String data) {
        StringBuilder result = new StringBuilder("");

        try {
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoInput(true);
            conn.setDoOutput(true);
            OutputStream os = conn.getOutputStream();
            os.write(data.getBytes("GBK"));
            os.close();
            BufferedInputStream br = new BufferedInputStream(conn.getInputStream());
            byte[] buffer = new byte[1024];

            int size;
            do {
                size = br.read(buffer, 0, 1024);
                if (size > 0) {
                    result.append(new String(buffer, 0, size, "GBK"));
                }
            } while(size > 0);

            br.close();
        } catch (IOException var9) {
            var9.printStackTrace();
        }

        return result.toString();
    }
    public static String sendRequestWithTemplate(String template, String url, Map<String,String> data){
        final ELUtil el = new ELUtil();
        data.forEach((key,value)->el.getContext().set(key,value));
        String xmlContext = el.eval(template);

        System.out.println(url);
        System.out.println(xmlContext);
        String result = sendRequest(url,xmlContext);
        System.out.println(result);

        return result;
    }

    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
    public List<InsuranceReceipt> requestReceipt(Date time) throws DocumentException {
//        Date clearTime = clearTimeDao.getCurrent("保险回款");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(time);
        if (calendar.get(Calendar.DATE)>25){
            calendar.set(Calendar.DATE,26);
        }else {
            calendar.add(Calendar.MONTH,-1);
            calendar.set(Calendar.DATE,26);
        }

        Date clearTime = calendar.getTime();
        calendar.add(Calendar.MONTH,1);
        calendar.add(Calendar.DATE,-1);
        Map<String,String> templateMap = new HashMap<>();

        User user = (User) ActionContext.getContext().getSession().get("user") ;
        String uname = user.getUname();
        String loginName =properties.getProperty(uname+".name");

        templateMap.put("username",loginName);
        templateMap.put("account_number",accountNumber);
        templateMap.put("begin_date",simpleDateFormat.format(clearTime));
        templateMap.put("end_date",simpleDateFormat.format(calendar.getTime()));

        String serverIp = properties.getProperty(uname+".serverIp");
        String port = properties.getProperty(uname+".port");

        String responseXmlString = sendRequestWithTemplate(INSURANCE_TEMPLATE,String.format("http://%s:%s",serverIp,port),templateMap);
        if (!StringUtils.isNotBlank(responseXmlString)){
            return null;
        }

        System.out.println(responseXmlString);
        Document document = DocumentHelper.parseText(responseXmlString);
        Element root = document.getRootElement();

        List<InsuranceReceipt> receipts;

        String errmsg = root.element("INFO").elementText("ERRMSG");
        if (!(errmsg==null || StringUtils.isBlank(errmsg))){
            throw new RuntimeException(errmsg);
        }

        Stream<InsuranceReceipt> receiptStream = root.elements("CPRRCRCVX1").stream().map(cprr->{
    Element receipt = (Element) cprr;
    String sendName = receipt.elementText("SNDEAN");//对方的账户名
    if (sendName.equalsIgnoreCase("中国人民财产保险股份有限公司黑龙江省分公司")) {
        InsuranceReceipt insuranceReceipt = new InsuranceReceipt();
        insuranceReceipt.setReceiptId("b"+receipt.elementText("ISTNBR"));//回单编号
        insuranceReceipt.setAttachment(receipt.elementText("NARTXT"));
        insuranceReceipt.setAmount(BigDecimal.valueOf(Double.parseDouble(receipt.elementText("TRSAMT"))).setScale(2));
        String isuDate = receipt.elementText("ISUDAT");

        try {
            insuranceReceipt.setTimestamp(simpleDateFormat.parse(isuDate));//此处可能需要转换
        } catch (ParseException e) {
            e.printStackTrace();
            return (InsuranceReceipt)null;
        }
        insuranceReceipt.setState(0);
        System.out.println(insuranceReceipt);
        return insuranceReceipt;
    }
    return (InsuranceReceipt)null;
}).filter(x->x!=null);
        receipts = receiptStream.collect(Collectors.toList());

//        JSONObject responseJson = XmlUtil.documentToJSONObject(responseXmlString);
//        System.out.println(responseJson);
//
//        JSONArray receiveArray = responseJson.getJSONArray("CPRRCRCVX1");
//        if (receiveArray==null || receiveArray.size()==0){
////            System.out.println("本次没有保险回款。");
//            return Collections.emptyList();
//        }
//
//        List<InsuranceReceipt> receipts = new ArrayList<>();
//        for (int i = 0; i < receiveArray.size(); i++) {
//            JSONObject receipt = receiveArray.getJSONObject(i);
//            //TODO 此处条件应当在确认后设定
//            String sendName = receipt.getString("SNDEAN");//对方的账户名
////            String receiptType = receipt.getString("BUSNAR");
//            if (sendName.equalsIgnoreCase("中国人民财产保险股份有限公司黑龙江省分公司")) {
//                InsuranceReceipt insuranceReceipt = new InsuranceReceipt();
//                insuranceReceipt.setReceiptId(receipt.getString("ISTNBR"));//回单编号
//                insuranceReceipt.setAttachment(receipt.getString("NARTXT"));
//                insuranceReceipt.setAmount(receipt.getBigDecimal("TRSAMT"));
//                String isuDate = receipt.getString("ISUDAT");
//
//                insuranceReceipt.setTimestamp(simpleDateFormat.parse(isuDate));//此处可能需要转换
//                insuranceReceipt.setState(0);
//                receipts.add(insuranceReceipt);
//            }
//        }

        Session session;
        Transaction tx = null;

        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();
            for (InsuranceReceipt receipt : receipts) {
                if (session.get(InsuranceReceipt.class,receipt.getReceiptId())==null){
                    if (receipt.getReceiptId()==null || receipt.getReceiptId().trim().length()==0){
                        System.out.println(receipt);
                    }else
                    session.save(receipt);
                }
            }

            ClearTime fetchClearTime = (ClearTime) session.get(ClearTime.class,7);
            fetchClearTime.setCurrent(new Date());
            session.update(fetchClearTime);

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

        return receipts;
    }

    public void tryAttachVehicle(){
        final Session session = HibernateSessionFactory.getSession();
        List<InsuranceReceipt> receipts = session.createQuery("from InsuranceReceipt where state=0 ").list();
        if (receipts==null) receipts = Collections.emptyList();
        final List<InsuranceReceipt> unmatched = new ArrayList<>();

        final Query matchLicenseNum = session.createQuery("from Vehicle where licenseNum=:num ");
        matchLicenseNum.setMaxResults(1);
        final Query matchMachineNo = session.createQuery("from Vehicle where engineNum=:num ");
        matchMachineNo.setMaxResults(1);

        List<InsuranceBack> backs = receipts.stream().map(receipt->{
            InsuranceBack back = new InsuranceBack();
            back.setReceiptId(receipt.getReceiptId());
            back.setAmount(receipt.getAmount());
            back.setAttachment(receipt.getAttachment());
            back.setTimestamp(receipt.getTimestamp());

            String attachment = receipt.getAttachment();
            if (!StringUtils.contains(attachment,"赔款")){
                unmatched.add(receipt);
                return back;
            }
            Vehicle vehicle = null;
            //预期的格式为： 000001MDB450，黑ATQ643，哈尔滨大众交通。。。
            //或 ： 附言：000001MHA2N6，黑ATK778，哈尔滨。。。
            String[] splits = attachment.split("，",3);
            if (splits.length>1){
                String toMatch = splits[1].trim();
                if (toMatch.startsWith("黑")){
                    matchLicenseNum.setString("num",toMatch);
                    vehicle = (Vehicle) matchLicenseNum.uniqueResult();
                }else {
                    matchMachineNo.setString("num",toMatch);
                    vehicle = (Vehicle) matchMachineNo.uniqueResult();
                }
            }

            if (vehicle!=null){
                back.setCarframeNum(vehicle.getCarframeNum());
                back.setCarNum(vehicle.getLicenseNum());
            }else {
                unmatched.add(receipt);
            }
            return back;
        }).filter(back->back.getCarframeNum()!=null).collect(Collectors.toList());;

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (InsuranceBack back : backs) {
                session.saveOrUpdate(back);
                InsuranceReceipt receipt = (InsuranceReceipt) session.get(InsuranceReceipt.class,back.getReceiptId());
                receipt.setState(back.getId());
                session.saveOrUpdate(receipt);
            }

            for (InsuranceReceipt receipt : unmatched) {
                receipt.setState(-1);
                session.saveOrUpdate(receipt);
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

    public void manalAttachVehicle(InsuranceReceipt receipt,Vehicle vehicle){
        final Session session = HibernateSessionFactory.getSession();
        InsuranceBack back = new InsuranceBack();
        back.setReceiptId(receipt.getReceiptId());
        back.setAmount(receipt.getAmount());
        back.setAttachment(receipt.getAttachment());
        back.setTimestamp(receipt.getTimestamp());
        back.setCarframeNum(vehicle.getCarframeNum());
        back.setCarNum(vehicle.getLicenseNum());
        Transaction tx = null;
        try {
            tx = session.beginTransaction();

            session.saveOrUpdate(back);
            receipt = (InsuranceReceipt) session.get(InsuranceReceipt.class,back.getReceiptId());
            receipt.setState(back.getId());
            session.saveOrUpdate(receipt);
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

    public void confirmChecked(List<InsuranceBack> backs,User user){
        Session session;
        Transaction tx = null;

        Date chargeClearTime = clearTimeDao.getCurrent("total");

        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();

            for (InsuranceBack back : backs) {
                back = (InsuranceBack) session.get(InsuranceBack.class,back.getId());
                if (back!=null && back.getState()==0){
                    ChargePlan chargePlan = new ChargePlan();
                    chargePlan.setFeeType("add_insurance");
                    chargePlan.setFee(back.getAmount());
                    chargePlan.setTime(chargeClearTime);

                    Contract contract = selectByCarId(back.getCarframeNum(),session);
                    if (contract==null || ! contract.getCarframeNum().equalsIgnoreCase(back.getCarframeNum())){
                        back.setState(-2);
                        session.saveOrUpdate(back);
                        continue;
                    }

                    chargePlan.setContractId(contract.getId());
                    chargePlan.setComment(""+back.getId()+","+back.getAttachment());
                    chargePlan.setInTime(new Date());
                    chargePlan.setRegister(user.getUname());
                    chargeService.addChargePlan(chargePlan,session);

                    back.setState(chargePlan.getId());
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

    public void refuseInsuranceBack(List<InsuranceBack> backs){
        Session session;
        Transaction tx = null;

        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();

            for (InsuranceBack back : backs) {
                back = (InsuranceBack) session.get(InsuranceBack.class,back.getId());
                if (back!=null && back.getState()==0){
                    back.setState(-1);
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

    public static Contract selectByCarId(String carId,Session session){
        Contract c;
        Query query = session.createQuery("from Contract where carframeNum = :id and state=0");
        query.setMaxResults(1);
        query.setString("id",carId);
        c = (Contract) query.uniqueResult();

        if(c!=null){
            return c;
        }

        Date d = new Date();
        return selectByCarId(carId,d,session);
    }

    public static Contract selectByCarId(String id, Date d,Session session) {
        Contract c = null;
        Query query = session.createQuery("from Contract where id=( select max(id) from Contract where carframeNum = :id and state!=3 and state!=2 and state>=0 ) ");
        query.setString("id",id);
        query.setMaxResults(1);
        c = (Contract) query.uniqueResult();

        Calendar dt = Calendar.getInstance();
        if(c!=null&&c.getContractBeginDate()!=null){
            dt.setTime(c.getContractBeginDate());
        }else{
            return c;
        }

        if(dt.get(Calendar.DATE)>26){

            dt.set(Calendar.DATE, 26);
        }else{
            dt.add(Calendar.MONTH, -1);
            dt.set(Calendar.DATE, 26);
        }

//		System.out.println("ContractDaoImpl.selectByCarId(),"+dt.getTime().toString());

        if(dt.getTime().before(d)){
            return c;
        }else{
            while(c.getContractFrom()!=null){
                Contract last = (Contract) session.get(Contract.class, c.getContractFrom());
                if(last!=null) c = last;
                else return c;

                dt.setTime(c.getContractBeginDate());
                if(dt.get(Calendar.DATE)>26){
                    dt.set(Calendar.DATE, 26);
                }else{
                    dt.add(Calendar.MONTH, -1);
                    dt.set(Calendar.DATE, 26);
                }
//				System.out.println(dt.getTime().toString());

                if(dt.getTime().before(d))
                    return c;
            }
        }

        return c;
    }

    public void setClearTimeDao(ClearTimeDao clearTimeDao) {
        this.clearTimeDao = clearTimeDao;
    }

    public void setChargeService(ChargeService chargeService) {
        this.chargeService = chargeService;
    }

    private static final String INSURANCE_TEMPLATE=
            "<?xml version=\"1.0\" encoding = \"GBK\"?>\n" +
            "<CMBSDKPGK>\n" +
            "    <INFO>\n" +
            "        <FUNNAM>SDKCSFDFBRT</FUNNAM>\n" +
            "        <DATTYP>2</DATTYP>\n" +
            "        <LGNNAM>${username}</LGNNAM>\n" +
            "    </INFO>\n" +
            "    <CSRRCFDFY0>\n" +
            "        <EACNBR>${account_number}</EACNBR>\n" +
            "        <BEGDAT>${begin_date}</BEGDAT>\n" + //起始日期 eg. 20180701
            "        <ENDDAT>${end_date}</ENDDAT>\n" +
            "        <RRCFLG>2</RRCFLG>\n" +
            "    </CSRRCFDFY0>\n" +
            "</CMBSDKPGK>";
}
