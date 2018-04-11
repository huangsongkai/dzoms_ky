package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.DateUtil;
import com.dz.common.global.Page;
import com.dz.common.global.TimePass;
import com.dz.common.other.ObjectAccess;
import com.dz.module.charge.bank.BankItem;
import com.dz.module.charge.bank.HttpRequest;
import com.dz.module.charge.bank.XmlPacket;
import com.dz.module.charge.bank.ZhaoShangDiscount;
import com.dz.module.contract.*;
import com.dz.module.driver.Driver;
import com.dz.module.driver.DriverDao;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.VehicleDao;
import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author doggy
 *         Created on 15-11-12.
 */
@Service
public class ChargeService {
    @Autowired
    private ChargeDao chargeDao;
    @Autowired
    private ContractDao contractDao;
    @Autowired
    private VehicleDao vehicleDao;
    @Autowired
    private DriverDao driverDao;
    @Autowired
    private BankCardDao bankCardDao;
    @Autowired
    private ClearTimeDao clearTimeDao;
    @Autowired
    private BankFileDao bankFileDao;
    @Autowired
    private BankRecordTmpDao bankRecordTmpDao;

    /*********************************************************************************************************************/
    /**************************************Add the method that need page limit here.**************************************/
    /*********************************************************************************************************************/
    /**
     * added 分页.
     * 多车单月的计划详细(合同+保险+油补+变更)
     * @param dept 搜索的部门
     * @param date
     * @return
     */
    public List<PlanDetail> planDetailMultiplyCar(String dept,Date date,Page page){
        List<PlanDetail> table = new ArrayList<>();
        List<Contract> contractList = contractDao.contractSearchAllAvilable(date,dept,null,page);
        //TODO:I don't know if it is necessary to filter here
        fileterContract(contractList);
        for(Contract c:contractList){
            int id = c.getId();
            List<ChargePlan> plans = new ArrayList<>();
            plans = chargeDao.getAllRecords(id,date);
            PlanDetail cct = new PlanDetail();
            //set header
            cct.setContractId(id);
            cct.setTime(date);
            Driver d = new Driver();
            d.setIdNum(c.getIdNum());
            Driver driver = driverDao.selectById(d.getIdNum());
            if(driver != null){
                cct.setDriverName(driver.getName());
                cct.setDriverId(driver.getIdNum());
                cct.setDept(driver.getDept());
            }
            //TODO:wait to add department
            if("全部".equals(dept)||c.getBranchFirm().equals(dept)){
                Vehicle vehicle = vehicleDao.selectByFrameId(c.getCarframeNum());
                if(vehicle != null) {
                    cct.setCarNumber(vehicle.getLicenseNum());
                    cct.setDept(vehicle.getDept());
                }
                BigDecimal heton_base = calculatePlan(plans,"plan_base_contract");
                BigDecimal heton = calculatePlan(plans,"contract");
                BigDecimal insurance = calculatePlan(plans,"insurance");
                BigDecimal other = calculatePlan(plans,"other");
                cct.setBaoxian(insurance);
                cct.setHeton(heton_base.add(heton));
                cct.setOther(other);
                cct.setTotal(insurance.add(heton).add(heton_base).add(other));
                //set message
                table.add(cct);
            }
        }
        return table;
    }

    @Value("#{configProperties['accountNumber']}")
    private String accountNumber;

    public String getLoginName() {
        String loginName = null;
        User user = (User) ActionContext.getContext().getSession().get("user") ;
        String uname = user.getUname();
        loginName =properties.getProperty(uname+".name");
        return loginName;
    }

    @Autowired
    @Qualifier("configProperties")
    private Properties properties;

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    /**
     * 发起招行扣款请求
     * @param records 扣款计划
     * @param forTime 扣款月份
     * @return 本次扣款的标识
     */
    public Map<String,String> doDiscount(List<BankRecord> records,Date forTime){
        BigDecimal totalMoney = BigDecimal.ZERO;
        totalMoney.setScale(2);
        int totalCount=0;
        XmlPacket packet = new XmlPacket("NTAGCACL", getLoginName());
        Map<String,String> resultMap = new HashMap<>();

        ZhaoShangDiscount discount = new ZhaoShangDiscount();
        List<BankItem> items = new ArrayList<>();

        User user = (User) ActionContext.getContext().getSession().get("user") ;

        Session s = HibernateSessionFactory.getSession();

        int index=1;
        for (BankRecord br : records){
            if (br.getMoney().doubleValue()<=0)
                continue;
            int cardId = 0;
            BankCard bankCard = null;
            for(BankCardOfVehicle bv:br.getBankCards()){
                if(bv.getBankCard()==null){
                    //数据错误 bankcard 不存在的情况
                    s.delete(bv);
                    continue;
                }
                if(bv.getBankCard().getCardClass().equals("招商银行")&&bv.getBankCard().getId()>cardId){
                    bankCard = bv.getBankCard();
                    cardId = bankCard.getId();
                }
            }
            if (bankCard!=null){
                Driver driver = (Driver) s.get(Driver.class,bankCard.getIdNumber());
                if(driver==null){
                    //数据错误，没有人员与之对应的情况
                    List<BankCardOfVehicle> bl = bankCard.getbOfVList();
                    if(bl!=null){
                        for (BankCardOfVehicle bankCardOfVehicle:bl)
                            s.delete(bankCardOfVehicle);
                    }
                    s.delete(bankCard);
                    continue;
                }

                Map NTAGCDTLY1 =new HashMap();
                NTAGCDTLY1.put("TRXSEQ",String.format("%08d",index));
                NTAGCDTLY1.put("ACCNBR",bankCard.getCardNumber());
                NTAGCDTLY1.put("ACCNAM",driver.getName());
                NTAGCDTLY1.put("TRSAMT",br.getMoney().setScale(2).toString());
                NTAGCDTLY1.put("BNKFLG","Y");

                BankItem item = new BankItem();
                Contract contract = (Contract) s.get(Contract.class,br.getContractId());
                item.setContract(contract);
                item.setApplyTime(new Date());
                forTime.setDate(1);
                item.setForTime(forTime);
                item.setPlanFee(br.getMoney().setScale(2));
                item.setState(0);
                item.setCardNumber(bankCard.getCardNumber());

                item.setRegister(user.getUname());
                items.add(item);

                packet.putProperty("NTAGCDTLY1",NTAGCDTLY1);
                totalMoney = totalMoney.add(br.getMoney().setScale(2));
                totalCount++;
                index++;
            }
        }
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String YURREF = df.format(new Date());
        YURREF = "QK"+YURREF;
        {
            Map NTAGCAGCX1 =new HashMap();
            NTAGCAGCX1.put("BEGTAG","Y");
            NTAGCAGCX1.put("ENDTAG","Y");
            NTAGCAGCX1.put("TTLAMT",totalMoney.toString());
            NTAGCAGCX1.put("TTLCNT",""+totalCount);
            NTAGCAGCX1.put("TTLNUM",1);
            NTAGCAGCX1.put("CURAMT",totalMoney.toString());
            NTAGCAGCX1.put("CURCNT",""+totalCount);
            NTAGCAGCX1.put("CCYNBR","10");
            NTAGCAGCX1.put("BBKNBR","45");//分行号
            NTAGCAGCX1.put("ACCNBR",accountNumber);
            NTAGCAGCX1.put("CCYMKT","0");
            NTAGCAGCX1.put("TRSTYP","AYBK");
            NTAGCAGCX1.put("NUSAGE","收出租车租金");
            NTAGCAGCX1.put("YURREF",YURREF);
            packet.putProperty("NTAGCAGCX1",NTAGCAGCX1);

            Map NTBUSMODY  =new HashMap();
            NTBUSMODY.put("BUSMOD","00001");
            packet.putProperty("NTBUSMODY",NTBUSMODY);
        }

        System.out.println(packet.toXmlString());
        String result = HttpRequest.sendRequest(packet.toXmlString());
        System.out.println(result);
        if (result != null && result.length() > 0) {
            XmlPacket response = XmlPacket.valueOf(result);
            if (response != null) {
                String returnCode = response.getReturnCode();
                resultMap.put("returnCode",returnCode);

                if (returnCode.equals("0")) {
                    Map propPayResult = response.getProperty("NTAGCAGCZ1", 0);
                    String REQNBR = (String)propPayResult.get("REQNBR");
                    String REQSTA = (String)propPayResult.get("REQSTA");
//                    switch (REQSTA){
//
//                    }
                    resultMap.put("REQNBR",REQNBR);
                    resultMap.put("REQSTA",REQSTA);

                    Transaction tx = null;
                    try {
                        tx = s.beginTransaction();
                        discount.setBankSeq(REQNBR);
                        discount.setYurref(YURREF);
                        discount.setStates(0);//状态：已申请扣款
                        discount.setChargeTime(new Date());
                        discount.setTotalCount(totalCount);
                        discount.setTotalMoney(totalMoney);
                        s.saveOrUpdate(discount);

                        for (BankItem item:items) {
                            item.setZhaoShangDiscount(discount);
                            s.saveOrUpdate(item);
                        }
                        tx.commit();
                    }catch (HibernateException ex){
                        if (tx!=null){
                            tx.rollback();
                        }
                        ex.printStackTrace();
                    }finally {
                        HibernateSessionFactory.closeSession();
                    }
                }
                else{
                    switch (returnCode){
                        case "-1":
                            System.out.println("提交主机失败");
                            break;
                        case "-2":
                            System.out.println("执行失败");
                            break;
                        case "-3":
                            System.out.println("数据格式错误");
                            break;
                        case "-4":
                            System.out.println("尚未登录系统");
                            break;
                        case "-5":
                            System.out.println("请求太频繁");
                            break;
                        case "-6":
                            System.out.println("不是证书卡用户");
                            break;
                        case "-7":
                            System.out.println("用户取消操作");
                            break;
                        case "-9":
                            System.out.println("其它错误");
                            break;
                    }
                }
            } else {
                System.out.println("响应报文解析失败");
            }
        }else{
            System.out.println("响应报文解析失败");
        }
        return resultMap;
    }

    /**
     * 检查扣款状态
     * @param discount 哪一笔扣款
     * @return 当前状态 0-处理中,1-成功,2-部分成功,3-全部失败
     */
    public int checkDiscountState(ZhaoShangDiscount discount){
        XmlPacket packet = new XmlPacket("GetAgentInfo", getLoginName());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Map<String,String> SDKATSQYX =new HashMap<>();
        SDKATSQYX.put("BUSCOD","N03030");
        SDKATSQYX.put("BGNDAT",sdf.format(discount.getChargeTime()));
        SDKATSQYX.put("ENDDAT",sdf.format(discount.getChargeTime()));
        SDKATSQYX.put("YURREF",discount.getYurref());
        packet.putProperty("SDKATSQYX",SDKATSQYX);
        String result = HttpRequest.sendRequest(packet.toXmlString());
        if (result != null && result.length() > 0) {
            XmlPacket response = XmlPacket.valueOf(result);
            if (response != null) {
                String returnCode = response.getReturnCode();
                if (returnCode.equals("0")) {
                    int sectionNum = response.getSectionSize("NTQATSQYZ");
                    for (int i = 0; i < sectionNum; i++) {
                        Map propPayResult = response.getProperty("NTQATSQYZ", i);
                        String REQSTA = (String) propPayResult.get("REQSTA");
                        String RTNFLG = (String) propPayResult.get("RTNFLG");
                        String REQNBR = (String) propPayResult.get("REQNBR");
                        if (org.apache.commons.lang3.StringUtils.equals(REQNBR,discount.getBankSeq())){
                            ActionContext.getContext().put("discountPackage",propPayResult);
                            if (REQSTA.equalsIgnoreCase("FIN")){
                                if (RTNFLG.equalsIgnoreCase("S")){
                                    String RSV62Z = (String) propPayResult.get("RSV62Z");
                                    if (org.apache.commons.lang3.StringUtils.startsWith(RSV62Z,"P")){
                                        return 2;
                                    }
                                    return 1;
                                }else if(RTNFLG.equalsIgnoreCase("F")){
                                    return 3;
                                }else {
                                    return 0;
                                }
                            }else {
                                return 0;
                            }
                        }else{
                            continue;
                        }
                    }
                }
            }
        }
        return 0;
    }

    /**
     * 刷新扣款状态并记入账目
     * @param discount 哪一笔扣款
     * @return 银行系统的错误号 "0" -- 成功
     */
    public String refreshDiscount(ZhaoShangDiscount discount){
        int state = checkDiscountState(discount);
        if (state!=0){
            XmlPacket packet = new XmlPacket("NTAGDINF", getLoginName());
            Map<String,String> NTAGDINFY1 =new HashMap<>();
            NTAGDINFY1.put("REQNBR",discount.getBankSeq());
            packet.putProperty("NTAGDINFY1",NTAGDINFY1);
            String result = HttpRequest.sendRequest(packet.toXmlString());
            System.out.println(result);
            if (result != null && result.length() > 0) {
                XmlPacket response = XmlPacket.valueOf(result);
                if (response != null) {
                    String returnCode = StringUtils.strip(response.getReturnCode());
                    System.out.println(returnCode);
                    if (StringUtils.equalsIgnoreCase("0",returnCode)) {
                        int sectionNum = response.getSectionSize("NTAGCDTLY1");
                        Session session = null;
                        Transaction tx = null;

                        try{
                            session = HibernateSessionFactory.getSession();
                            tx = session.beginTransaction();
                            discount = (ZhaoShangDiscount) session.get(ZhaoShangDiscount.class,discount.getId());
                            if (discount.getStates()!=0){
                                return "0";
                            }
                            Map<String,String> NTQATSQYZ = (Map<String, String>) ActionContext.getContext().get("discountPackage");
                            discount.setRealCount(Integer.parseInt(NTQATSQYZ.get("SUCNUM")));
                            discount.setRealMoney(BigDecimal.valueOf(Double.parseDouble(NTQATSQYZ.get("SUCAMT"))));
                            session.saveOrUpdate(discount);
                            for (int i = 0; i < sectionNum; i++) {
                                Map propPayResult = response.getProperty("NTAGCDTLY1", i);
                                String ACCNBR = (String) propPayResult.get("ACCNBR");
                                /**
                                 * A：待处理
                                 * C：取消（代发）撤销（代扣）
                                 * E：失败
                                 * I:待复核
                                 * S:成功
                                 */
                                String STSCOD = (String) propPayResult.get("STSCOD");//状态
                                String LGRAMT = (String) propPayResult.get("LGRAMT");//实际扣款金额
                                String ERRDSP = (String) propPayResult.get("ERRDSP");//错误信息
                                if (org.apache.commons.lang3.StringUtils.isNotBlank(ACCNBR)){
                                    Query query = session.createQuery("from BankItem bi where bi.zhaoShangDiscount.id=:did and bi.cardNumber like :cardNumber");
                                    query.setInteger("did",discount.getId());
                                    query.setString("cardNumber","%"+ACCNBR+"%");
//                                    query.setMaxResults(1);

                                    /**
                                     * 2018/03/20 使满足多车车主为同一人时当月费用回执到同一车的情况
                                     */
                                    List<BankItem> items = query.list();
                                    System.out.println(items);

                                    BigDecimal realFee = BigDecimal.valueOf(Double.parseDouble(LGRAMT));

                                    if (realFee.abs().doubleValue()>0){
                                        //扣款完成
                                        boolean finded = false;
                                        for (BankItem item : items) {
                                            BigDecimal planFee = item.getPlanFee();
                                            if(item.getRealFee()!=null && item.getRealFee().doubleValue()==0.0 && realFee.equals(planFee)) {
                                                doDiscountByZhaoshang(session, item, realFee, STSCOD, ERRDSP);
                                                finded = true;
                                                break;
                                            }else {
                                                continue;
                                            }
                                        }
                                        if (!finded) {
                                            for (BankItem item : items) {
//                                                BigDecimal planFee = item.getPlanFee();
                                                BigDecimal itemRealFee = item.getRealFee();
                                                itemRealFee = itemRealFee == null ? BigDecimal.ZERO :itemRealFee;
                                                if (itemRealFee.doubleValue() < item.getPlanFee().doubleValue()) {
                                                    BigDecimal stillPlan = item.getPlanFee().subtract(itemRealFee);
                                                    if(realFee.compareTo(stillPlan)>0){
                                                        doDiscountByZhaoshang(session,item,stillPlan,STSCOD,ERRDSP);
                                                        realFee = realFee.subtract(stillPlan);
                                                    }else{
                                                        doDiscountByZhaoshang(session, item, realFee, STSCOD, ERRDSP);
                                                        realFee = BigDecimal.ZERO;
                                                        break;
                                                    }
                                                }
                                            }

                                            if(realFee.doubleValue()>0.0){
                                                //仍有剩余的Money 一般不可能出现 停止计费 应该是错误
                                                System.out.println("仍有剩余的Money，停止计费！");
                                                return returnCode;
                                            }
                                        }
                                    }else {
                                        //扣款未完成
                                        for (BankItem item : items) {
                                            if(item.getRealFee() == null || item.getRealFee().doubleValue()==0.0) {
                                                item.setRealFee(BigDecimal.ZERO);
                                                item.setRealTime(new Date());
                                                if (org.apache.commons.lang3.StringUtils.endsWithIgnoreCase("S",STSCOD)){
                                                    item.setState(4);
                                                }else {
                                                    item.setState(2);
                                                    item.setComment(ERRDSP);
                                                }
                                                session.saveOrUpdate(item);
                                            }
                                        }
                                    }
                                }
                            }

                            discount.setStates(state);
                            session.saveOrUpdate(discount);
                            tx.commit();
                        }catch (HibernateException ex){
                            if (tx == null) {
                                tx.rollback();
                            }
                            ex.printStackTrace();
                        }finally {
                            HibernateSessionFactory.closeSession();
                        }
                    }
                    return returnCode;
                }
            }
        }else{
            //仍在处理中
            return "10";
        }
        return null;
    }

    private void doDiscountByZhaoshang(Session session, BankItem item, BigDecimal realFee, String STSCOD, String ERRDSP) {
        item.setRealFee(realFee);
        item.setRealTime(new Date());
        if (org.apache.commons.lang3.StringUtils.endsWithIgnoreCase("S",STSCOD)){
            item.setState(4);
//                                                    if (realFee.abs().doubleValue()>0){
                ChargePlan cp = new ChargePlan();
                cp.setContractId(item.getContract().getId());
                cp.setFeeType("add_bank2");
                cp.setFee(realFee);
                cp.setTime(item.getForTime());
                cp.setIsClear(false);
                cp.setInTime(item.getRealTime());
                cp.setRegister(item.getRegister());
                cp.setComment(""+item.getId());
                session.saveOrUpdate(cp);
//                                                    }
        }else {
            item.setState(2);
            item.setComment(ERRDSP);
        }
        session.saveOrUpdate(item);
    }

    public BankRecord getBankRecord(Date time,String carframeNum){
        BankRecord record = null;

        Session session = null;
        try{
            session = HibernateSessionFactory.getSession();
            String hql = "select new com.dz.module.charge.BankRecord("
                    + "d.idNum as idNum,"
                    + "d.name as driverName,"
                    + "c.carframeNum as carframeNum,"
                    + "c.carNum as licenseNum,"
                    + "sum(case when year(p.time)>year(:date) then 0.0 "
                    + "         when year(p.time)=year(:date) and month(p.time)>month(:date) then 0.0 "
                    + "         when year(cl.current)>year(p.time) then 0.0 "
                    + "         when year(cl.current)=year(p.time) and month(cl.current)>month(p.time) then 0.0 "
                    + "         when p.feeType like 'plan%add%' then -p.fee "
                    + "         when p.feeType like 'plan%sub%' then p.fee "
                    + "         when p.feeType like 'plan%' then -p.fee "
                    + "         when p.feeType like '%add%' then p.fee "
                    + "         else -p.fee "
                    + "end) as derserve"
                    + ","
                    + "avg(case when year(cl.current)<year(:date) then c.account"
                    + "      when year(cl.current)=year(:date) and month(cl.current)<=month(:date) then c.account "
                    + "      when p.feeType='last_month_left' then p.fee"
                    + "      else 0.0 "
                    + "end) as left,"
                    + "c.id as contractId "
                    + ") "
                    + "from ChargePlan p,Contract c,ClearTime cl,Driver d "
                    + "where cl.department=c.branchFirm "
                    + "and p.contractId=c.id "
                    + "and c.state in (0,-1,1,4) "
                    + "and c.carframeNum like :carframeNum "
                    + "and c.idNum=d.idNum "
                    + "and p.isClear != true "
                    + "and ( "
                    + "    (c.abandonedFinalTime is null) "
                    + "  or (YEAR(c.abandonedFinalTime )*12+MONTH(c.abandonedFinalTime )+(case when DAY(c.abandonedFinalTime )>26 then 1 else 0 end) >= (YEAR(:date)*12+MONTH(:date)))"
                    + ") "
                    + "group by c.id "
                    + "order by c.branchFirm,c.carNum";

            Query query = session.createQuery(hql);

            query.setString("carframeNum", "%"+carframeNum+"%");

            query.setDate("date", time);
            query.setMaxResults(1);
            record = (BankRecord) query.uniqueResult();
        }catch(HibernateException ex){
            ex.printStackTrace();
        }finally{
            HibernateSessionFactory.closeSession();
        }

        return record;
    }

    public List<BankRecord> exportBankFile(Date time,String dept){
        List<BankRecord> records = new ArrayList<>();

        Session session = null;
        try{
            session = HibernateSessionFactory.getSession();
            String hql = "select new com.dz.module.charge.BankRecord("
                    + "d.idNum as idNum,"
                    + "d.name as driverName,"
                    + "c.carframeNum as carframeNum,"
                    + "c.carNum as licenseNum,"
                    + "sum(case when year(p.time)>year(:date) then 0.0 "
                    + "         when year(p.time)=year(:date) and month(p.time)>month(:date) then 0.0 "
                    + "         when year(cl.current)>year(p.time) then 0.0 "
                    + "         when year(cl.current)=year(p.time) and month(cl.current)>month(p.time) then 0.0 "
                    + "         when p.feeType like 'plan%add%' then -p.fee "
                    + "         when p.feeType like 'plan%sub%' then p.fee "
                    + "         when p.feeType like 'plan%' then -p.fee "
                    + "         when p.feeType like '%add%' then p.fee "
                    + "         else -p.fee "
                    + "end) as derserve"
                    + ","
                    + "avg(case when year(cl.current)<year(:date) then c.account"
                    + "      when year(cl.current)=year(:date) and month(cl.current)<=month(:date) then c.account "
                    + "      when p.feeType='last_month_left' then p.fee"
                    + "      else 0.0 "
                    + "end) as left ,"
                    + "c.id as contractId "
                    + ") "
                    + "from ChargePlan p,Contract c,ClearTime cl,Driver d "
                    + "where cl.department=c.branchFirm "
                    + "and p.contractId=c.id "
                    + "and c.state in (0,-1,1,4) "
                    + "and c.branchFirm like :dept "
                    + "and c.idNum=d.idNum "
                    + "and p.isClear != true "
                    + "and ( "
                    + "    (c.abandonedFinalTime is null) "
                    + "  or (YEAR(c.abandonedFinalTime )*12+MONTH(c.abandonedFinalTime )+(case when DAY(c.abandonedFinalTime )>26 then 1 else 0 end) >= (YEAR(:date)*12+MONTH(:date)))"
                    + ") "
                    + "group by c.id "
                    + "order by c.branchFirm,c.carNum";

            Query query = session.createQuery(hql);

            if(dept.equals("全部")){
                query.setString("dept", "%");
            }else{
                query.setString("dept", "%"+dept+"%");
            }

            query.setDate("date", time);

            records = query.list();
        }catch(HibernateException ex){
            ex.printStackTrace();
        }finally{
            HibernateSessionFactory.closeSession();
        }

        return records;
    }

    /***********************************************************************************************************/
    /*********************************************END***********************************************************/
    /***********************************************************************************************************/

    /**
     * 获得某月的所有记录,该方法用于对不同类型的财务收入/支出进行统计
     * @param date 查询的年月
     * @return 记录列表
     */
    public List<ChargePlan> getAll(Date date,String feeType){
        return chargeDao.getAll(date,feeType);
    }

    /**
     * 单车多月计划详情
     * @param licenseNum 要查询的车牌号
     * @param startTime 开始年月
     * @param endTime 结束年月
     * @return
     */
    public List<PlanDetail> planDetailOneCar(String licenseNum,Date startTime,Date endTime){
        List<PlanDetail> table = new ArrayList<>();
        Vehicle tmp = new Vehicle();
        tmp.setLicenseNum(licenseNum);
        Vehicle vehicle = vehicleDao.selectByLicense(tmp);
        if(vehicle == null) return table;

        int startYear = startTime.getYear();
        int startMonth = startTime.getMonth();
        int endYear = endTime.getYear();
        int endMonth = endTime.getMonth();
        while(startYear <= endYear){
            if(startYear == endYear && startMonth > endMonth)break;
            Date d = new Date();
            d.setYear(startYear);
            d.setMonth(startMonth);
            d.setDate(1);
            Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),d);
            if(contract == null) return table;
            List<ChargePlan> plans = chargeDao.getAllRecords(contract.getId(),d);
//            System.out.println(plans);
//            System.out.println(contract.getId());
//            System.out.println(d.getYear()+"-"+d.getMonth());
            //set base header
            PlanDetail cpc  = new PlanDetail();
            cpc.setTime(d);
            cpc.setPlans(plans);
            Driver dx = new Driver();
            dx.setIdNum(contract.getIdNum());
            Driver driver = driverDao.selectById(dx.getIdNum());
            if(driver != null){
                cpc.setDriverName(driver.getName());
                cpc.setDriverId(driver.getIdNum());
                cpc.setDept(driver.getDept());
            }
            cpc.setCarNumber(vehicle.getLicenseNum());
            cpc.setDept(vehicle.getDept());
            //数据设置
            BigDecimal heton_base = calculatePlan(plans,"plan_base_contract");
            BigDecimal heton_base_raw = calculatePlanNoClear(plans,"plan_base_contract");

            BigDecimal heton,insurance,other;
            if(heton_base.equals(heton_base_raw)||heton_base_raw.equals(BigDecimal.ZERO)){
                heton = calculatePlan(plans,"contract");
                insurance = calculatePlan(plans,"insurance");
                other = calculatePlan(plans,"other");
            }else{
                heton = calculatePlanNoClear(plans,"contract");
                insurance = calculatePlanNoClear(plans,"insurance");
                other = calculatePlanNoClear(plans,"other");
                heton_base = heton_base_raw;
            }

            cpc.setBaoxian(insurance);
            cpc.setHeton(heton_base.add(heton));
            cpc.setOther(other);
            cpc.setTotal(insurance.add(heton).add(heton_base).add(other));
            table.add(cpc);
            if(startMonth < 11){
                startMonth++;
            }else {
                startMonth = 0;
                startYear++;
            }
        }
        return table;

    }


    /**
     * 单车单月的财务对账表获取
     * @param licenseNum 车牌号
     * @param time 要获取的对账表月份
     * @return CheckChargeTable that presen
     */
    public CheckChargeTable getSingleCarAndMonthCheckTableByLicenseNum(String licenseNum,Date time){
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(licenseNum);
        vehicle = vehicleDao.selectByLicense(vehicle);
        if(vehicle == null) return null;
//        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum());
        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),time);
        if(contract == null) return null;
        List<ChargePlan> plans = chargeDao.getAllRecords(contract.getId(),time);
        CheckChargeTable cct = new CheckChargeTable();
        //set header
        cct.setContractId(contract.getId());
        cct.setTime(time);
        Driver d = new Driver();
        d.setIdNum(contract.getIdNum());
        Driver driver = driverDao.selectById(d.getIdNum());
        if(driver != null){
            cct.setDriverName(driver.getName());
            cct.setDriverId(driver.getIdNum());
            cct.setDept(driver.getDept());
        }
        cct.setDept(vehicle.getDept());
        //set message
        cct.setCarNumber(licenseNum);
        cct.setBank(calculateItemIn(plans, "bank"));
        cct.setCash(calculateItemIn(plans,"cash"));
        cct.setInsurance(calculateItemIn(plans,"insurance"));
        cct.setOilAdd(calculateItemIn(plans,"oil"));
        cct.setOther(calculateItemIn(plans, "other"));
        cct.setPlanAll(calculateTotalPlan(plans));
        BigDecimal lastMonth = getlastMontAccountLeft(contract.getId(),time);
        cct.generated(lastMonth);
        return cct;
    }

    /**
     * 单车多月的财务对账表
     * @param CarId 车牌号
     * @param timePass 时间段
     * @return 单车多月对账表
     */
    @SuppressWarnings("deprecation")
    public List<CheckTablePerCar> getACarChargeTable(String CarId,TimePass timePass){
        List<CheckTablePerCar> table = new ArrayList<>();
        Vehicle tmp = new Vehicle();
        tmp.setLicenseNum(CarId);
        Vehicle vehicle = vehicleDao.selectByLicense(tmp);
        if(vehicle == null) return table;

        if(timePass == null || timePass.getStartTime() == null || timePass.getEndTime()==null){
            return new ArrayList<>();
        }

        int startYear = timePass.getStartTime().getYear();
        int startMonth = timePass.getStartTime().getMonth();
        int endYear = timePass.getEndTime().getYear();
        int endMonth = timePass.getEndTime().getMonth();
        while(startYear <= endYear){
            if(startYear == endYear && startMonth > endMonth)break;
            Date d = new Date();
            d.setYear(startYear);
            d.setMonth(startMonth);
            d.setDate(1);
            Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),d);
            if(contract == null) return table;
            List<ChargePlan> plans = chargeDao.getAllRecords(contract.getId(),d);
            //set base header
            CheckTablePerCar cpc  = new CheckTablePerCar();
            cpc.setTime(d);
            cpc.setPlans(plans);
            Driver dx = new Driver();
            dx.setIdNum(contract.getIdNum());
            Driver driver = driverDao.selectById(dx.getIdNum());
            if(driver != null){
                cpc.setDriverName(driver.getName());
                cpc.setDriverId(driver.getIdNum());
                cpc.setDept(driver.getDept());
            }
            cpc.setCarNumber(vehicle.getLicenseNum());
            cpc.setDept(vehicle.getDept());
            //set data
            cpc.setOil(calculateItemIn(plans,"oil"));
            cpc.setInsurance(calculateItemIn(plans,"insurance"));
            cpc.setBank(calculateItemIn(plans,"bank"));
            cpc.setOther(calculateItemIn(plans,"other"));
            cpc.setCash(calculateItemIn(plans,"cash"));
            cpc.setPlanAll(calculateTotalPlan(plans));

            cpc.setRealAll(calculateItemIn(plans, "other").add(calculateItemIn(plans, "insurance")).add(calculateItemIn(plans, "cash")).add(calculateItemIn(plans,"bank")).add(calculateItemIn(plans,"oil")));

            String hql = "from CheckChargeTable where contractId="+contract.getId()+" and year(time)="+(startYear+1900)+" and month(time)="+(startMonth+1);

            CheckChargeTable cct = ObjectAccess.execute(hql);

            if(cct==null){
                cpc.setLeft(getlastMontAccountLeft(contract.getId(), d));
            }else{
                cpc.setLeft(cct.getLastMonthOwe());
            }

            cpc.setThisMonthLeft(cpc.getRealAll().subtract(cpc.getPlanAll()));
            table.add(cpc);
            if(startMonth < 11){
                startMonth++;
            }else {
                startMonth = 0;
                startYear++;
            }
        }
        return table;
    }

    /**
     * 封帐操作,无需分页
     * @param dept 部门
     * @return true if success
     */
    public boolean finalClearAll(String dept){
        //如果其他部门不清帐则不往前清帐
        if(!("一部".equals(dept) || "二部".equals(dept) ||"三部".equals(dept))) return  false;
        Date totalTime = clearTimeDao.getCurrent("total");
        Date deptTime = clearTimeDao.getCurrent(dept);
        if(!DateUtil.isYearAndMonth(totalTime,deptTime)) return false;

//        2017/06/06 使用对账表的结果直接作为清账结果
//        List<Contract> contractList = contractDao.contractSearchAllAvilable(deptTime,dept,null,null);
//        fileterContract(contractList);

        List<CheckChargeTable> tables = this.getAllCheckChargeTable(deptTime,dept,null,4);

        Session session = HibernateSessionFactory.getSession();
        Transaction tx = null;

        try{
            tx= session.beginTransaction();

//        	2017/06/06 使用对账表的结果直接作为清账结果
//        	for(Contract contract:contractList){
//        		clear(contract.getId(),deptTime);
//        	}


            for(CheckChargeTable cct : tables){
//            	2017/06/06 使用对账表的结果直接作为清账结果      下面3行此次新增
                Contract c = (Contract) session.get(Contract.class, cct.getContractId());

                c.setAccount(cct.getThisMonthTotalOwe());
                session.saveOrUpdate(c);

                session.save(cct);
            }
            Query stateQuery = session.createQuery(
                    "update ChargePlan cp " +
                            "set cp.isClear=true " +
                            "where cp.contractId IN (SELECT c.id FROM Contract c WHERE cp.contractId=c.id AND c.branchFirm=:dept) " +
                            "and (YEAR(cp.time)*12+MONTH(cp.time)+(case when DAY(cp.time)>26 then 1 else 0 end) " +
                            "< (YEAR(:currentClearTime)*12+MONTH(:currentClearTime))+1)");
            stateQuery.setDate("currentClearTime",deptTime);
            stateQuery.setString("dept",dept);

            stateQuery.executeUpdate();

            /**
             * 迁移账户余额到转包后的合同
             */
            moveAccount(dept, deptTime, session);

            //清账后对整体的清账日期进行再计算
            boolean res = clearTimeDao.plusAMonth(dept,session);
            Date time1 = clearTimeDao.getCurrent("一部",session);
            Date time2 = clearTimeDao.getCurrent("二部",session);
            Date time3 = clearTimeDao.getCurrent("三部",session);
            if(!DateUtil.isYearAndMonth(totalTime,time1) && !DateUtil.isYearAndMonth(totalTime,time2) && !DateUtil.isYearAndMonth(totalTime,time3)){
                clearTimeDao.plusAMonth("total",session);
            }else{
//                System.out.println(dept);
//                System.out.println(res);
//                System.out.println(time1);
//                System.out.println(time2);
//                System.out.println(time3);
//                System.out.println(totalTime);
            }

            tx.commit();
        }catch(HibernateException ex){
            ex.printStackTrace();
            if(tx!=null)
                tx.rollback();
            return false;
        }finally{
            HibernateSessionFactory.closeSession();
        }

        return true;
    }

    private void moveAccount(String dept, Date deptTime, Session session) {
        String hql="select c1,c2 from Contract c1,Contract c2 where c1.contractFrom=c2.id " +
                (dept!=null?"and c1.branchFirm=:dept ":" ") +
                "and c2.account!=0 " +
                "and (c2.abandonedFinalTime is null or (YEAR(c2.abandonedFinalTime)*12+MONTH(c2.abandonedFinalTime)+(case when DAY(c2.abandonedFinalTime)>26 then 1 else 0 end) >= (YEAR(:currentClearTime)*12+MONTH(:currentClearTime)) ))";

        Query query = session.createQuery(hql);
        if(dept!=null){
            query.setString("dept",dept);
        }
        query.setDate("currentClearTime", deptTime);

        List<Object[]> list = query.list();

        for(Object[] oarr:list){
            Contract c = (Contract) oarr[0];
            Contract oc = (Contract) oarr[1];

            if(c.getAccount()==null)
                c.setAccount(BigDecimal.ZERO);

            if(oc.getAccount()!=null)
                c.setAccount(c.getAccount().add(oc.getAccount()));

            oc.setAccount(BigDecimal.ZERO);
            session.saveOrUpdate(c);
            session.saveOrUpdate(oc);
        }
    }

    /**
     * 获得某月某车的所有记录
     * @param licenseNum 车牌号
     * @param date 只精确到月份，日期部分将被忽略
     * @return
     */
    public List<ChargePlan> getAMonthRecords(String licenseNum,Date date){
        List<ChargePlan> plans = new ArrayList<>();
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(licenseNum);
        vehicle = vehicleDao.selectByLicense(vehicle);
        if(vehicle == null){
            return plans;
        }
//        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum());
        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),date);
        if(contract == null){
            return plans;
        }else if(contract.getState() != 0){
            if(contract.getBranchFirm()!=null&&contract.getContractEndDate()!=null){
                Calendar cl = Calendar.getInstance();
                Date clearTime = clearTimeDao.getCurrent(contract.getBranchFirm());
                cl.setTime(clearTime);
                cl.add(Calendar.MONTH, -1);
                if(cl.getTime().after(contract.getContractEndDate())){
                    return plans;
                }
            }else{
                return plans;
            }
        }

        plans = chargeDao.getAllRecords(contract.getId(),date);
        for(ChargePlan plan:plans){
            plan.setBatchPlan(null);
        }
        return plans;
    }

    /**
     * 获得当前可以取出的不同类型的剩余钱款
     * @param licenseNum 车牌号
     * @param time 年月
     * @return 列表中的第一个值为油补进账,第二个值为保险进账,第三个为账户余额
     */
    public List<BigDecimal> couldGetMoney(String licenseNum,Date time){
        List<BigDecimal> moneys = new ArrayList<>();
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(licenseNum);
        vehicle = vehicleDao.selectByLicense(vehicle);
        if(vehicle == null){
            System.out.println("找不到车辆！");
            return moneys;
        }
        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),time);
        if(contract == null || ( contract.getState() != 0 && contract.getState() != 1)){
            System.out.println("找不到合同！");
            return moneys;
        }
        List<ChargePlan> plans = chargeDao.getUnclears(contract.getId(), time);
        BigDecimal oil = calculateItemIn(plans,"oil");
        BigDecimal insurance = calculateItemIn(plans,"insurance");
        BigDecimal account = contract.getAccount();
        account = account.add(getUnClearAdd(contract.getId(),time));
//        account = account.add(getlastMontAccountLeft(contract.getId(),time));
        moneys.add(oil);
        moneys.add(insurance);
        moneys.add(account);
        return moneys;
    }

    /**
     * 导入银行计划文件并保存到临时表中.
     * @param brs
     * @param recorder
     * @param fid
     * @return
     */
    public boolean importFile(List<BankRecord> brs,final String recorder, final int fid){
        @SuppressWarnings("unchecked")
        List<BankRecordTmp> list = (List<BankRecordTmp>)CollectionUtils.collect(brs, new Transformer() {
            @Override
            public Object transform(Object o) {
                if(o == null) return null;
                BankRecord br = (BankRecord)o;
                BankRecordTmp brt = new BankRecordTmp();
                brt.setFid(fid);
                brt.setStatus(0);
                brt.setLicenseNum(br.getLicenseNum());
                brt.setDriverName(br.getDriverName());
                brt.setInTime(clearTimeDao.getCurrent("total"));
                brt.setRecodeTime(new Date());
                brt.setMoney(br.getMoney());
                brt.setRecorder(recorder);

                BankCard bc = null;
                for (BankCardOfVehicle bv : br.getBankCards()){
                    if (bv.getBankCard()!=null&& bv.getBankCard().getCardClass().equals("哈尔滨银行")){
                        bc = bv.getBankCard();
                        break;
                    }
                }
                if (bc==null) return null;
                brt.setBankCardNum(bc.getCardNumber());
                return brt;
            }
        });
        CollectionUtils.filter(list,new Predicate(){
            @Override
            public boolean evaluate(Object o) {
                if (o == null) return false;
                else return true;
            }
        });
        return bankRecordTmpDao.saveList(list);
    }

    /**
     * 清除错误的银行记录
     * @return true if no exception else false.
     */
    public boolean clearBadBankRecords(){
        return bankRecordTmpDao.clearBadRecord();
    }

    /**
     * 将银行计划从临时表中导入到ChargePlan中,将错误数据进行提取.
     * @return true.
     */
    public boolean fromTmpToSql(){
        Date current = clearTimeDao.getCurrent("total");
        List<BankRecordTmp> list = bankRecordTmpDao.selectByTimeAndStaus(current,0);
        List<BankRecordTmp> badRecords = new ArrayList<>();
        List<ChargePlan> cps = new ArrayList<>();
        Date now = new Date();

        for(BankRecordTmp brt:list) {
            Vehicle vehicle = new Vehicle();
            vehicle.setLicenseNum(brt.getLicenseNum());
            vehicle = vehicleDao.selectByLicense(vehicle);
            if(vehicle == null){
                brt.setError("找不到车号");
                badRecords.add(brt);
                continue;
            }
            Contract c = contractDao.selectByCarId(vehicle.getCarframeNum(),DateUtil.getNextMonth26(brt.getInTime()));
            if(c == null){
                brt.setError("找不到车号");
                badRecords.add(brt);
                continue;
            }

            Contract nc = contractDao.selectByCarId(vehicle.getCarframeNum(),now);

            Driver driver = driverDao.selectById(nc.getIdNum());
//            if(driver == null || !driver.getName().equals(brt.getDriverName())){
//            	if(nc.getContractFrom()!=null){
//            		Contract oldC = contractDao.selectById(nc.getContractFrom());
//                    driver = driverDao.selectById(oldC.getIdNum());
//
//                    if(driver == null || !driver.getName().equals(brt.getDriverName())){
//                    	brt.setError("驾驶员不匹配");
//                        badRecords.add(brt);
//                        continue;
//                    }
//            	}else{
//            		brt.setError("驾驶员不匹配");
//                    badRecords.add(brt);
//                    continue;
//            	}
//            }

            BankCard bc=bankCardDao.getBankCardByCardNumber(brt.getBankCardNum());
//            BankCard bc=bankCardDao.getBankCardForPayByDriverId(driver.getIdNum(),vehicle.getCarframeNum(),"哈尔滨银行");

            if(bc==null){
                brt.setError("银行卡信息未录入");
                badRecords.add(brt);
                continue;
            }

//            String cardNum = bc.getCardNumber();
//
//            if(!cardNum.equals(brt.getBankCardNum())){
//            	brt.setError("银行卡号不匹配");
//                badRecords.add(brt);
//                continue;
//            }

            ChargePlan cp = new ChargePlan();
            cp.setContractId(c.getId());
            cp.setFeeType("add_bank");
            cp.setFee(brt.getMoney());
            cp.setTime(brt.getInTime());
            cp.setIsClear(false);
            cp.setInTime(brt.getRecodeTime());
            cp.setRegister(brt.getRecorder());
            cp.setComment(""+brt.getId());
            cps.add(cp);
            //chargeDao.addChargePlan(cp);
        }

        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();
            for(ChargePlan cp:cps)
                session.save(cp);
            for(BankRecordTmp brt:badRecords){
                brt.setStatus(2);
                session.update(brt);
            }

            Query query = session.createQuery("update BankRecordTmp set status = 1 where status = 0");
            query.executeUpdate();

            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            HibernateSessionFactory.closeSession();
        }

        return true;
    }

    /**
     * 银行的临时记录查询.
     * @param time 要查询的年月
     * @param status 临时记录的状态
     * @return
     */
    public List<BankRecordTmp> getBankRecordByTimeAndStatus(Date time,int status){
        return bankRecordTmpDao.selectByTimeAndStaus(time,status);
    }

    /**
     * 写文件的MD5值.
     * @param md5 银行文件的md5值
     * @param date
     * @return true if this file never imported else false.
     */
    public int writeMd5(String md5, Date date){
        return bankFileDao.importFile(md5,date);
    }

    /**
     * 合计计划总额
     * @param plans none
     * @return none
     */
    private BigDecimal calculateTotalPlan(List<ChargePlan> plans){
        BigDecimal totalPlan = new BigDecimal(0);
        for(ChargePlan plan:plans){
            String feeType = plan.getFeeType();
            if(feeType.startsWith("plan")){
                if(feeType.contains("sub")){
                    totalPlan = totalPlan.subtract(plan.getFee());
                }else{
                    totalPlan = totalPlan.add(plan.getFee());
                }
            }
        }
        return totalPlan;
    }
    public Date getCurrentTime(String dept){
        return clearTimeDao.getCurrent(dept);
    }

    /**
     * 合计某一项进账总和
     * @param plans 要合计的所有chargePlan
     * @param feeType 费用类型,只给出中缀即可.
     * @return 合计金额.
     */
    private BigDecimal calculateItemIn(List<ChargePlan> plans,String feeType){
        //函数相当于：以insurance为例
        //sql select COALESCE(sum(fee),0)-(select COALESCE(sum(fee),0) from Charge_Plan where fee_Type like 'plan%' and fee_Type like '%insurance%' and fee_Type like '%sub%') from Charge_Plan where fee_Type like 'plan%' and fee_Type like '%insurance%' and fee_Type like '%add%'
        //hql select COALESCE(sum(fee),0)-(select COALESCE(sum(fee),0) from ChargePlan where feeType like 'plan%' and feeType like '%insurance%' and feeType like '%sub%') from ChargePlan where feeType like 'plan%' and feeType like '%insurance%' and feeType like '%add%'
        BigDecimal fee = new BigDecimal(0);
        for(ChargePlan plan:plans){
            if(!plan.getFeeType().startsWith("plan") && plan.getFeeType().contains(feeType)){
                if(plan.getFeeType().contains("add")){
                    fee = fee.add(plan.getFee());
                }else {
                    fee = fee.subtract(plan.getFee());
                }
            }
        }
        return fee;
    }

    /**
     * 计算某个计划项的总金额
     * @param plans 所有要累计的ChargePlan.
     * @param type 计划类型的中缀.
     * @return 合计金额.
     */
    private BigDecimal calculatePlan(List<ChargePlan> plans,String type){
        BigDecimal fee = new BigDecimal(0);
        for(ChargePlan plan:plans){
            if(type.equals("plan_base_contract")){
                if(plan.getFeeType().equals("plan_base_contract"))
                    fee = fee.add(plan.getFee());
                continue;
            }
            if(plan.getFeeType().startsWith("plan") && plan.getFeeType().contains(type)){
                if(type.equals("contract") && plan.getFeeType().equals("plan_base_contract"))
                    continue;
                if(plan.getFeeType().contains("add")){
                    fee = fee.add(plan.getFee());
                }else {
                    fee = fee.subtract(plan.getFee());
                }
            }
        }
        return fee;
    }


    private BigDecimal calculatePlanNoClear(List<ChargePlan> plans,String type){
        BigDecimal fee = new BigDecimal(0);
        for(ChargePlan plan:plans){
            if(plan.isClear())
                continue;
            if(type.equals("plan_base_contract")){
                if(plan.getFeeType().equals("plan_base_contract"))
                    fee = fee.add(plan.getFee());
                continue;
            }
            if(plan.getFeeType().startsWith("plan") && plan.getFeeType().contains(type)){
                if(type.equals("contract") && plan.getFeeType().equals("plan_base_contract"))
                    continue;
                if(plan.getFeeType().contains("add")){
                    fee = fee.add(plan.getFee());
                }else {
                    fee = fee.subtract(plan.getFee());
                }
            }
        }
        return fee;
    }

    /**
     * 获得上月账户余额
     * @param contractId 要查询的合同id(账户)
     * @param date 查询的月份X,实际返回X的前一个月的账户余额.
     * @return 金额
     */
    public BigDecimal getlastMontAccountLeft(int contractId,Date date){
        //该函数相当于：
        //select
        //(case when year(cl.current)<year(:date) then c.account
        //      when year(cl.current)=year(:date) and month(cl.current)<=month(:date) then c.account
        //      else sum(case when feeType='last_month_left' then fee else 0 end)
        //end)
        //from Contract c,ClearTime cl where cl.department=c.branchFirm and c.id=:cid

        BigDecimal left = null;
        // from Contract c where c.id=:cid
        Contract contract = contractDao.selectById(contractId);
        // select cl.current from ClearTime cl,Contract c where cl.department=c.branchFirm and c.id=:cid
        Date currentMonth = clearTimeDao.getCurrent(contract.getBranchFirm());
        //(case when year(cl.current)<year(:date) then c.account
        //      when year(cl.current)=year(:date) and month(cl.current)<=month(:date) then c.account
        //      else sum(case when feeType='last_month_left' then fee else 0 end)
        //end)
        if(DateUtil.isYM1BGYM2(date,currentMonth)){
            left = contractDao.getAccount(contractId);
        }else{
            //该else block相当于 select fee from ChargePlan where contractId = :contractId  and time is not null and year(time)=year(:date) and month(time)=month(:date) and feeType='last_month_left'

            List<ChargePlan> plans = chargeDao.getAllRecords(contractId,date);
            for(ChargePlan plan:plans){
                if("last_month_left".equals(plan.getFeeType())){
                    left = plan.getFee();
                }
            }
            if(left == null){
                left = new BigDecimal(0);
            }
        }
        return left;
    }


    /**
     * 对单个账户进行清帐
     * @param contractId none
     * @param clearTime none
     * @return none
     */
    private boolean clear(int contractId,Date clearTime) throws HibernateException{
        Session session = HibernateSessionFactory.getSession();
        Contract c = (Contract) session.get(Contract.class,contractId);
        BigDecimal account = c.getAccount();
        //记录上月余额
        ChargePlan lastMonthRecord = new ChargePlan();
        lastMonthRecord.setFee(account);
        lastMonthRecord.setIsClear(true);
        lastMonthRecord.setContractId(contractId);
        lastMonthRecord.setTime(clearTime);
        lastMonthRecord.setFeeType("last_month_left");
        session.saveOrUpdate(lastMonthRecord);

        Query query = session.createQuery("from ChargePlan where contractId = :contractId and isClear=false and year(time)=year(:date) and month(time)=month(:date)");
        query.setInteger("contractId", contractId);
        query.setDate("date", clearTime);

//        List<ChargePlan> plans = chargeDao.getUnclears(contractId,clearTime);
        List<ChargePlan> plans = query.list();

        for(ChargePlan plan:plans){
//            System.out.println(plan.getFeeType() + " test "+plan.getFee());
            String feeType = plan.getFeeType();
            if(feeType.startsWith("add") || feeType.startsWith("plan_sub")){
                account = account.add(plan.getFee());
            }else if(feeType.startsWith("sub") || feeType.startsWith("plan_add") || feeType.startsWith("plan_base")){
                account = account.subtract(plan.getFee());
            }
//            chargeDao.cleared(plan);
            plan.setIsClear(true);
            session.saveOrUpdate(plan);
        }
//        contractDao.updateAccount(contractId,account);
        c.setAccount(account);
        session.saveOrUpdate(c);

        return true;
    }

    /**
     * 获得一个账户到当前月份为止，未结清的金额（不计上月账户）
     * @param contractId 合同id(账户)
     * @param clearTime 清账时间
     * @return 未结清金额
     */
    private BigDecimal getUnClearAdd(int contractId,Date clearTime){
        List<ChargePlan> plans = new ArrayList<>();
        Contract contract = contractDao.selectById(contractId);
        String dept = contract.getBranchFirm();
        if(dept != null){
            Date currentMonth = clearTimeDao.getCurrent(dept);
            if(DateUtil.isYM1BGYM2(clearTime,currentMonth)){
                while(DateUtil.isYM1BGYM2(clearTime,currentMonth)){
                    plans.addAll(chargeDao.getAllRecords(contractId,currentMonth));
                    currentMonth = DateUtil.getNextMonth(currentMonth);
                }
            }
        }
        BigDecimal account = new BigDecimal(0);
        for(ChargePlan plan:plans){
            String feeType = plan.getFeeType();
            if(feeType.startsWith("add") || feeType.startsWith("plan_sub")){
                account = account.add(plan.getFee());
            }else if(feeType.startsWith("sub") || feeType.startsWith("plan_add")||feeType.startsWith("plan_base")){
                account = account.subtract(plan.getFee());
            }
        }
        return account;
    }

    /**
     * 根据车牌号查询一辆车的批计划(约定变更)
     * @param license 车牌号
     * @return 所有与该车有关的批计划
     */
    public List<BatchPlan> searchBatchPlans(String license){
        List<BatchPlan> bps = new ArrayList<BatchPlan>();
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(license);
        Vehicle v = vehicleDao.selectByLicense(vehicle);
        if(v != null){
            Contract contract = contractDao.selectByCarId(v.getCarframeNum());
            if(contract == null || contract.getId() == null){
                bps = new ArrayList<>();
            }else{
                bps = chargeDao.searchBatchPlan(contract.getId());
            }
        }
        return bps;
    }


    /**
     * OK,please ignore this file check.
     * @param md5 md5check code
     * @return true if this file's md5 is imported else false.
     */
    public boolean isFileExisted(String md5){
        return bankFileDao.isFileImported(md5);
    }


    /**
     * 过滤合同,只显示合同开始日期在清帐日期之前的合同
     */
    private void fileterContract(List<Contract> contractList){
        CollectionUtils.filter(contractList, new Predicate() {
            @Override
            public boolean evaluate(Object object) {
                if(object == null) return false;
                Contract contract = (Contract)object;
                Date clearTime = clearTimeDao.getCurrent("total");
                //TODO
                return DateUtil.isYM1BGYM2(clearTime,contract.getContractBeginDate());
            }
        });
    }

    /**
     * 所有跨月份的计划都使用该方法添加
     * generate + casecase.all => 插入了所有数据
     * @param plan
     * @param isToEnd
     * @return true if success else false.
     */
    public boolean addBatchPlan(BatchPlan plan, boolean isToEnd){
        if(plan == null) throw new NullPointerException("the plan shouldn't be null");
        plan.setToEnd(isToEnd);
        plan.generate();
        System.out.println("ChargePlan size:"+plan.getChargePlanList().size());
        chargeDao.addBatchPlan(plan);
        return true;
    }

    /**
     * 给一辆车下多月计划
     * @param plan 批计划
     * @param licenseNum 车牌号
     * @param isToEnd 是否使用
     * @return true if success else false
     */
    public boolean addBatchPlanPerCar(BatchPlan plan,String licenseNum, boolean isToEnd){
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(licenseNum);
        vehicle = vehicleDao.selectByLicense(vehicle);
        if(vehicle == null){
            return  false;
        }
        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),plan.getStartTime());
//        if(contract == null || contract.getState() != 0){
        if(contract == null){
            return false;
        }
        List<Integer> cil = new ArrayList<>();
        cil.add(contract.getId());
        plan.setContractIdList(cil);
        return addBatchPlan(plan, isToEnd);
    }


    /**
     * 添加单车单月计划，除了约定变更，所有的其他添加都最终调用该方法,不再具有清帐功能
     * @param plan
     * @return
     */
    public boolean addChargePlan(ChargePlan plan){
        if(plan == null) throw new NullPointerException("the plan shouldn't be null");
        plan.setIsClear(false);
        int contractId = plan.getContractId();
        Contract contract = contractDao.selectById(contractId);
        if(contract == null) return false;
        //对合同由于有旧数据所以不做限制.
        if(!plan.getFeeType().equals("plan_base_contract")){
            if((plan.getFeeType().startsWith("add") || plan.getFeeType().startsWith("sub"))){
                if(!DateUtil.isYearAndMonth(plan.getTime(),clearTimeDao.getCurrent(contract.getBranchFirm())))
                    return false;
            }else{
                plan.setTime(clearTimeDao.getCurrent(contract.getBranchFirm()));
            }
        }

        {
            Calendar tm = Calendar.getInstance();
            tm.setTime(plan.getTime());
            if(tm.get(Calendar.DATE)>26){
                tm.add(Calendar.MONTH, 1);
            }
            tm.set(Calendar.DATE, 1);
        }
        if(plan.getFee() == null) return false;
        boolean flag = chargeDao.addChargePlan(plan);
        return flag;
    }

    /**
     * 添加单车单月计划，除了约定变更，所有的其他添加都最终调用该方法,不再具有清帐功能
     * @param plan
     * @return
     */
    public void addChargePlan(ChargePlan plan,Session session) throws HibernateException{
        if(plan == null) throw new HibernateException("the plan shouldn't be null");
        plan.setIsClear(false);
        int contractId = plan.getContractId();
        Contract contract = (Contract) session.get(Contract.class,contractId);
        if(contract == null) return ;
        //对合同由于有旧数据所以不做限制.
        if(!plan.getFeeType().equals("plan_base_contract"))
            if((plan.getFeeType().startsWith("add") || plan.getFeeType().startsWith("sub"))){
                if(!DateUtil.isYearAndMonth(plan.getTime(),clearTimeDao.getCurrent(contract.getBranchFirm(),session)))
                    return;
            }else{
                plan.setTime(clearTimeDao.getCurrent(contract.getBranchFirm(),session));
            }
        {
            Calendar tm = Calendar.getInstance();
            tm.setTime(plan.getTime());
            if(tm.get(Calendar.DATE)>26){
                tm.add(Calendar.MONTH, 1);
            }
            tm.set(Calendar.DATE, 1);
        }
        if(plan.getFee() == null) return;
        session.saveOrUpdate(plan);
    }

    /**
     * 根据车牌号添加一条财务计划,最终调用addChargePlan.
     * @param plan 财务计划
     * @param licenseNum 车牌号
     * @return
     */
    public boolean addChargePlanByLicenseNum(ChargePlan plan,String licenseNum){
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(licenseNum);
        vehicle = vehicleDao.selectByLicense(vehicle);
        if(vehicle == null){
            return  false;
        }
        Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),plan.getTime());
//        if(contract == null || contract.getState() != 0){
        if(contract == null){
            return false;
        }
        plan.setContractId(contract.getId());
        return addChargePlan(plan);
    }

    /**
     * 删除一条财务计划,useless
     * @param plan the plan to delete,it must contains id  attribute.
     * @return true if db success else false.
     */
    public boolean deleteChargePlan(ChargePlan plan){
        if(plan == null) throw new NullPointerException("the plan shouldn't be null");
        plan = chargeDao.getChargePlanById(plan.getId());
        if(plan != null || plan.getIsClear() != true){
            return chargeDao.deleteChargePlan(plan);
        }
        return false;
    }

    /**
     * Actually this method is useless.
     * @param plan
     * @return
     */
    public boolean deleteBatchPlan(BatchPlan plan){
        if(plan == null) throw new NullPointerException("the plan shouldn't be null");
        plan = chargeDao.getBatchPlanById(plan.getId());
        if(plan != null && plan.getStartTime().getTime() > Calendar.getInstance().getTime().getTime()){
            return chargeDao.deleteBatchPlan(plan);
        }
        return false;
    }

    /**
     * 设置从beginDate开始的月份之后的chargePlan为已清账,beginDate为承包日期.
     * @param srcId 合同id
     * @param time 承包日期
     * @return
     */
    public boolean setCleared(int srcId,Date time){
        return chargeDao.setCleared(srcId,time);
    }
    /**
     * 把计划在合同之间进行迁移
     * @param srcId 源合同号id
     * @param srcTime 将>=该年月的未清算合同进行迁移
     * @param destId 目标合同id
     * @param destTime 迁移到的年月
     * @return
     */
    public boolean planTransfer(int srcId,Date srcTime,int destId,Date destTime){
        return chargeDao.planTransfer(srcId,srcTime,destId,destTime);
    }
    public void addAndDiv(int cid,Date time){
        chargeDao.addAndDiv(cid,time);
    }

    /**
     * Page limit added.
     * 获得一个/全部部门 一个月的财务对账表.
     * @param date 要查询的月份
     * @param dept 查询的部门 若为"全部" 则查询所有
     * @param page 分页
     * @return
     */
    @Deprecated
    public List<CheckChargeTable> getAllCheckChargeTable(Date date, String dept, Page page){
        List<CheckChargeTable> table = new ArrayList<>();
        //相当于：from Contract where state in (0,-1,1,4) and (abandonedFinalTime is null or (YEAR(abandonedFinalTime)*12+MONTH(abandonedFinalTime)+(case when DAY(abandonedFinalTime)>26 then 1 else 0 end) >= (YEAR(:currentClearTime)*12+MONTH(:currentClearTime))))
        List<Contract> contractList = contractDao.contractSearchAllAvilable(date,dept,page);
        //TODO:I don't know if it is necessary to filter here
        fileterContract(contractList);
        for(Contract c:contractList){
            int id = c.getId();
            List<ChargePlan> plans = new ArrayList<>();
            //            Date currentMonth = clearTimeDao.getCurrent(c.getBranchFirm());
            //            if(isYM1BGYM2(date,currentMonth)){
            //                while(isYM1BGYM2(date,currentMonth)){
            //                    plans.addAll(chargeDao.getAllRecords(id,currentMonth));
            //                    currentMonth = getNextMonth(currentMonth);
            //                }
            //            }else{
            //相当于from ChargePlan where contractId = :contractId  and time is not null and year(time)=year(:date) and month(time)=month(:date)
            plans = chargeDao.getAllRecords(id,date);
            //            }
            CheckChargeTable cct = new CheckChargeTable();
            //set header
            cct.setContractId(id);
            cct.setTime(date);
            Driver d = new Driver();
            d.setIdNum(c.getIdNum());
            Driver driver = driverDao.selectById(d.getIdNum());
            if(driver != null){
                cct.setDriverName(driver.getName());
                cct.setDriverId(driver.getIdNum());
                cct.setDept(driver.getDept());
            }
            //TODO:wait to add department
            if("全部".equals(dept)||c.getBranchFirm().equals(dept)){
                Vehicle vehicle = vehicleDao.selectByFrameId(c.getCarframeNum());
                if(vehicle != null) {
                    cct.setCarNumber(vehicle.getLicenseNum());
                    cct.setDept(vehicle.getDept());
                }
                //set message

                //函数相当于：以insurance为例
                //hql select COALESCE(sum(fee),0)-(select COALESCE(sum(fee),0) from ChargePlan where feeType like 'plan%' and feeType like '%insurance%' and feeType like '%sub%') from ChargePlan where feeType like 'plan%' and feeType like '%insurance%' and feeType like '%add%'
                //或          select (sum(case when feeType like '%add%' then fee else (-fee) end)) from ChargePlan where feeType like '%insurance%'
                //或          select (
                //       sum(case
                //	       when feeType not like '%insurance%' then 0
                //           when feeType like '%add%' then fee
                //           else (-fee) end)
                //     ) from ChargePlan
                cct.setBank(calculateItemIn(plans, "bank"));
                cct.setCash(calculateItemIn(plans,"cash"));
                cct.setInsurance(calculateItemIn(plans,"insurance"));
                cct.setOilAdd(calculateItemIn(plans,"oil"));
                cct.setOther(calculateItemIn(plans, "other"));
                cct.setPlanAll(calculateTotalPlan(plans));
                BigDecimal lastMonth = getlastMontAccountLeft(id,date);
                cct.generated(lastMonth);
                table.add(cct);
            }
        }
        return table;
    }

    /**
     * 查询对账表
     * @param date 月份
     * @param dept 部门 可以是 一部、二部、三部、全部
     * @param licenseNum 车牌号
     * @param status 状态 0,1,2,3,4 -- 欠费,正常,未交,已交,全部
     * @return
     */
    public List<CheckChargeTable> getAllCheckChargeTable(Date date,String dept, String licenseNum, int status) {
        if(date==null)
            date=new Date();

        Calendar clear_time = Calendar.getInstance();
        clear_time.setTime(getCurrentTime("全部".equals(dept)?"total":dept));
        clear_time.add(Calendar.DATE, -1);

        Session session = HibernateSessionFactory.getSession();
        try{
            if(date.before(clear_time.getTime())){
                String ql = "from CheckChargeTable where YEAR(time)=:year and MONTH(time)=:month ";

                if (dept!=null&&!"全部".equals(dept)) {
                    ql+="and dept = :dept ";
                }

                if(!StringUtils.isEmpty(licenseNum)){
                    ql+="and carNumber like :carNum ";
                }

                String ql2;
                switch(status){
                    case 1://正常  ThisMonthTotalOwe>0
                        ql2 =  "and thisMonthTotalOwe >=0.0 ";
                        break;
                    case 0://欠费
                        ql2 =  "and thisMonthTotalOwe<0.0 ";
                        break;
                    case 2://未交
                        ql2 = "and bank <= 0.0 ";
                        break;
                    case 3://已交
                        ql2 = "and bank >0.0 ";
                        break;
                    default:
                        ql2 = "";
                }

                Query qy = session.createQuery(ql+ql2);

                if (dept!=null&&!"全部".equals(dept)) {
                    qy.setString("dept",dept);
                }

                if(!StringUtils.isEmpty(licenseNum)){
                    qy.setString("carNum","%"+licenseNum+"%");
                }
                qy.setInteger("year", date.getYear()+1900);
                qy.setInteger("month", date.getMonth()+1);

                List<CheckChargeTable> lst = qy.list();
                return lst;
            }

            String hql =// "select c.id "
                    //+ "from Contract c "
                    //+ "where c.state in (0,-1,1,4) "
                    "and c.state in (0,-1,1,4) "
                            + "and (c.abandonedFinalTime is null or (YEAR(c.abandonedFinalTime)*12+MONTH(c.abandonedFinalTime)+(case when DAY(c.abandonedFinalTime)>26 then 1 else 0 end) "
                            + ">= (YEAR(:currentClearTime)*12+MONTH(:currentClearTime)))) ";

            if (dept!=null&&!"全部".equals(dept)) {
                hql+="and c.branchFirm = :dept ";
            }

            if(!StringUtils.isEmpty(licenseNum)){
                hql+="and c.carNum like :carNum ";
            }

            String hql2;

            switch(status){
                case 1://正常  ThisMonthTotalOwe>0
                    hql2 =  "having "
//						+ "avg(case when year(cl.current)<year(:currentClearTime) then c.account"
//				        + "      when year(cl.current)=year(:currentClearTime) and month(cl.current)<=month(:currentClearTime) then c.account "
//				        + "      when p.feeType='last_month_left' then p.fee"
//				        + "      else 0.0 "
//				        + "end)- "
                            + " avg(c.account) - "
                            + "sum(case "
                            + "when p.feeType like '%plan_sub%' then -p.fee "
                            + "when p.feeType like '%plan_%' then p.fee "
//						+ "when p.feeType like '%bank%' then 0.0 "
//						+ "when p.feeType like '%cash%' then 0.0 "
//						+ "when p.feeType like '%oilAdd%' then 0.0 "
//						+ "when p.feeType like '%insurance%' then 0.0 "
//						+ "when p.feeType like '%other%' then 0.0 "
                            + "when p.feeType like '%sub%' then p.fee "
                            + "else (-p.fee) end)>=0.0 ";
                    break;
                case 0://欠费
                    hql2 =  "having "
//						+ "avg(case when year(cl.current)<year(:currentClearTime) then c.account"
//				        + "      when year(cl.current)=year(:currentClearTime) and month(cl.current)<=month(:currentClearTime) then c.account "
//				        + "      when p.feeType='last_month_left' then p.fee"
//				        + "      else 0.0 "
//				        + "end)- "
                            +" avg(c.account) - "
                            + "sum(case "
                            + "when p.feeType like '%plan_sub%' then -p.fee "
                            + "when p.feeType like '%plan_%' then p.fee "
//						+ "when p.feeType like '%bank%' then 0.0 "
//						+ "when p.feeType like '%cash%' then 0.0 "
//						+ "when p.feeType like '%oilAdd%' then 0.0 "
//						+ "when p.feeType like '%insurance%' then 0.0 "
//						+ "when p.feeType like '%other%' then 0.0 "
                            + "when p.feeType like '%sub%' then p.fee "
                            + "else (-p.fee) end)<0.0 ";
                    break;
                case 2://未交
                    hql2 = "having "
                            + "sum(case "
                            + "when p.feeType not like '%bank%' then 0.0 "
                            + "when p.feeType like '%add%' then p.fee "
                            + "else (-p.fee) end) <=0.0 ";
                    break;
                case 3://已交
                    hql2 = "having "
                            + "sum(case "
                            + "when p.feeType not like '%bank%' then 0.0 "
                            + "when p.feeType like '%add%' then p.fee "
                            + "else (-p.fee) end) >0.0 ";
                    break;
                default:
                    hql2 = "";
            }

            String hql_out ="select new com.dz.module.charge.CheckChargeTable("
                    + "p.contractId as contractId,p.time as time,"
                    + "sum(case "
                    + "when p.feeType not like '%bank' then 0.0 "
                    + "when p.feeType like '%plan%' then 0.0 "
                    + "when p.feeType like '%add%' then p.fee "
                    + "else (-p.fee) end) as bank1"
                    + ","
                    + "sum(case "
                    + "when p.feeType not like '%bank2%' then 0.0 "
                    + "when p.feeType like '%plan%' then 0.0 "
                    + "when p.feeType like '%add%' then p.fee "
                    + "else (-p.fee) end) as bank2"
                    + ","
                    + "sum(case "
                    + "when p.feeType not like '%cash%' then 0.0 "
                    + "when p.feeType like '%plan%' then 0.0 "
                    + "when p.feeType like '%add%' then p.fee "
                    + "else (-p.fee) end) as cash"
                    + ","
                    + "sum(case "
                    + "when p.feeType not like '%insurance%' then 0.0 "
                    + "when p.feeType like '%plan%' then 0.0 "
                    + "when p.feeType like '%add%' then p.fee "
                    + "else (-p.fee) end) as insurance"
                    + ","
                    + "sum(case "
                    + "when p.feeType not like '%oil%' then 0.0 "
                    + "when p.feeType like '%plan%' then 0.0 "
                    + "when p.feeType like '%add%' then p.fee "
                    + "else (-p.fee) end) as oilAdd"
                    + ","
                    + "sum(case "
                    + "when p.feeType not like '%other%' then 0.0 "
                    + "when p.feeType like '%plan%' then 0.0 "
                    + "when p.feeType like '%add%' then p.fee "
                    + "else (-p.fee) end) as other"
                    + ","
                    + "sum(case "
                    + "when p.feeType not like '%plan%' then 0.0 "
                    + "when p.feeType like '%sub%' then -p.fee "
                    + "else (p.fee) end) as planAll "
                    + ","
                    + "c.carNum as carNumber,"
                    + "c.branchFirm as dept,"
                    + "d.name as driverName, "
                    + "avg(case when year(cl.current)<year(:currentClearTime) then c.account"
                    + "      when year(cl.current)=year(:currentClearTime) and month(cl.current)<=month(:currentClearTime) then c.account "
                    + "      when p.feeType='last_month_left' then p.fee"
                    + "      else 0.0 "
                    + "end) as lastMonthOwe "
                    + ") from ChargePlan "
                    //+ "where contractId in (" + hql+ " ) "
                    + "p ,Contract c,Driver d,ClearTime cl "
                    + "where p.contractId=c.id and d.idNum=c.idNum and cl.department=c.branchFirm "
                    + "and p.isClear != true "
                    + hql

                    + "and p.time is not null and year(p.time)=year(:currentClearTime) and month(p.time)=month(:currentClearTime) "

                    + "group by c.id "
                    + hql2

                    + "order by c.branchFirm,c.carNum";

//			Query query = session.createQuery(hql_out).setResultTransformer(Transformers.aliasToBean(CheckChargeTable.class));
            Query query = session.createQuery(hql_out);

            if (dept!=null&&!"全部".equals(dept)) {
                query.setString("dept",dept);
            }

            if(!StringUtils.isEmpty(licenseNum)){
                query.setString("carNum","%"+licenseNum+"%");
            }

            query.setDate("currentClearTime", date);

            return query.list();
        }catch(HibernateException ex){
            ex.printStackTrace();
            return new ArrayList<>();
        }finally{
            HibernateSessionFactory.closeSession();
        }
    }

    public void addAndDiv(Integer cid, Date time, Session session) throws HibernateException {
        chargeDao.addAndDiv(cid, time, session);
    }

    public void setCleared(Integer srcId, Date beginDate, Session session) throws HibernateException{
        // TODO Auto-generated method stub
        chargeDao.setCleared(srcId, beginDate,session);
    }
}
