package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.global.DateUtil;
import com.dz.common.global.TimePass;
import com.dz.common.other.ObjectAccess;
import com.dz.module.charge.bank.BankItem;
import com.dz.module.charge.bank.ZhaoShangDiscount;
import com.dz.module.charge.insurance.InsuranceBack;
import com.dz.module.charge.insurance.InsuranceBackService;
import com.dz.module.charge.insurance.InsuranceReceipt;
import com.dz.module.contract.*;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.VehicleDao;
import com.opensymphony.xwork2.ActionContext;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author doggy
 *         Created on 15-11-8.
 */
@Controller
@Scope(value = "prototype")
public class ChargeAction extends BaseAction {
    private static final int EVERYPAGE = 20;
    /**
     *
     */
    private static final long serialVersionUID = -8426604215311846476L;
    private static final String STRING_RESULT = "string_result";
    private static final String JSON_RESULT = "json_result";
    private static final String DISPATCH = "dispatch";
    @Autowired
    private ChargeService service;
    @Autowired
    private ContractService contractService;
    private String jspPage;
    private String nextAction;
    private String ajax_message;
    private Object jsonObject;
    private ChargePlan chargePlan;
    private BatchPlan batchPlan;
    private String licenseNum;
    private Date time;
    private TimePass timePass;
    private String message;
    private String visitType;
    private String jsonStr;
    private String filename;
    private String department;
    private String feeType;
    private String recorder;
    private int status;
    private int id;
    private InputStream txtFile;
    private String fileName;
    //是否使用合同结束日期
    private String isToEnd;
    //当前页.
    private int currentPage;
    //总页数.
    private int pageLimit;

    private BankRecordTmp tmp;

    /*********************************************************************************************************************/
    /**************************************Add the method that need page limit here.**************************************/
    /*********************************************************************************************************************/

    //首页显示对账表
    public String mainCharge(){
        Date current = service.getCurrentTime("total");
//        if(currentPage == 0)
//            currentPage = 1;
//        Page page = PageUtil.createPage(EVERYPAGE,(int)contractService.searchAllAvaliableCount(current,"全部"),currentPage);
//        pageLimit = page.getTotalPage();
        List<CheckChargeTable> tables = service.getAllCheckChargeTable(current,"全部",null,4);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("tables",tables);
        jspPage = "show/getCheckChargeTableByDept.jsp";
        return SUCCESS;
    }

    /**
     * 多车单月的计划详情.
     * @return SUCCESS
     */
    public String planDetailMulCar(){
        List<PlanDetail> details = new ArrayList<>();
        if(!(time == null||department==null)) {
            details = service.planDetailMultiplyCar(department,time,null);
        }
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("table",details);
        jspPage = "plan_detail_mul_car_show.jsp";
        return SUCCESS;
    }

//    private String cardClass;
//
//    public String getCardClass() {
//        return cardClass;
//    }
//
//    public void setCardClass(String cardClass) {
//        this.cardClass = cardClass;
//    }

    //导出银行文件 file:bankfile_export.jsp
    public String exportBankFile(){
        List<BankRecord> records = service.exportBankFile(time,department);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("bankRecords",records);
        jspPage = "bankfile_export.jsp";
        return SUCCESS;
    }

    private String carframeNum;

    public String getCarframeNum() {
        return carframeNum;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    public String requireDiscount(){
        List<BankRecord> records = service.exportBankFile(time,department);
        Map<String,String> resultMap = service.doDiscount(records,time);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("resultMap",resultMap);
        String returnCode = resultMap.get("returnCode");
        if (returnCode == null) {
            returnCode = "9";
        }

        switch (returnCode){
            case "0":
                request.put("msgStr","成功");
                break;
            case "1":
                request.put("msgStr","提交主机失败");
                break;
            case "2":
                request.put("msgStr","执行失败");
                break;
            case "3":
                request.put("msgStr","数据格式错误");
                break;
            case "4":
                request.put("msgStr","尚未登录系统");
                break;
            case "5":
                request.put("msgStr","请求太频繁");
                break;
            case "6":
                request.put("msgStr","不是证书卡用户");
                break;
            case "7":
                request.put("msgStr","用户取消操作");
                break;
            case "9":
                request.put("msgStr","其它错误");
                break;
        }

        jspPage = "zhaoShangStatesContext.jsp";
        return SUCCESS;
    }

    public void recoverBankItems() throws IOException {
        List<BankRecord> records = service.exportBankFile(time,department);

        Session s = HibernateSessionFactory.getSession();
        Transaction tx = null;
        try {
            ZhaoShangDiscount discount = (ZhaoShangDiscount) s.get(ZhaoShangDiscount.class,id);
            tx = s.beginTransaction();
            for (BankRecord br : records) {
                if (br.getMoney().doubleValue() <= 0)
                    continue;
                int cardId = 0;
                BankCard bankCard = null;
                for (BankCardOfVehicle bv : br.getBankCards()) {
                    if (bv.getBankCard().getCardClass().equals("招商银行") && bv.getBankCard().getId() > cardId) {
                        bankCard = bv.getBankCard();
                        cardId = bankCard.getId();
                    }
                }
                if (bankCard!=null){
                    BankItem item = new BankItem();
                    Contract contract = (Contract) s.get(Contract.class,br.getContractId());
                    item.setContract(contract);
                    item.setApplyTime(new Date());
                    item.setForTime(time);
                    item.setPlanFee(br.getMoney().setScale(2));
                    item.setState(0);
                    item.setCardNumber(bankCard.getCardNumber());

                    item.setRegister("陈东慧");
                    item.setZhaoShangDiscount(discount);
                    s.saveOrUpdate(item);
                }
            }

            tx.commit();
        }catch (HibernateException ex){
            if (tx!=null)
                tx.rollback();
            ex.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        ServletActionContext.getResponse().setContentType("application/json");
        ServletActionContext.getResponse().setCharacterEncoding("utf-8");
        PrintWriter out = ServletActionContext.getResponse().getWriter();
        out.write("{\"status\":true}");
        out.flush();
        out.close();
    }

    public void  refreshDiscountState() throws IOException {
        ServletActionContext.getResponse().setContentType("application/json");
        ServletActionContext.getResponse().setCharacterEncoding("utf-8");
        PrintWriter out = ServletActionContext.getResponse().getWriter();
        ZhaoShangDiscount discount = ObjectAccess.getObject(ZhaoShangDiscount.class,id);
        JSONObject json = new JSONObject();
        json.put("status",false);
        if (discount != null) {
            String returnCode = service.refreshDiscount(discount);
            if(returnCode==null){
                returnCode = "9";
            }
            switch (returnCode){
                case "0":
                    json.put("msgStr","成功");
                    json.put("status",true);
                    break;
                case "1":
                    json.put("msgStr","提交主机失败");
                    break;
                case "2":
                    json.put("msgStr","执行失败");
                    break;
                case "3":
                    json.put("msgStr","数据格式错误");
                    break;
                case "4":
                    json.put("msgStr","尚未登录系统");
                    break;
                case "5":
                    json.put("msgStr","请求太频繁");
                    break;
                case "6":
                    json.put("msgStr","不是证书卡用户");
                    break;
                case "7":
                    json.put("msgStr","用户取消操作");
                    break;
                case "9":
                    json.put("msgStr","其它错误");
                    break;
                case "10":
                    json.put("msgStr","扣款仍在处理中");
                    json.put("status",true);
                    break;
            }
        }
        out.write(json.toString());
        out.flush();
        out.close();
    }

    //获得某月的对账单
    public String getCheckChargeTable(){
//        if(currentPage == 0)
//            currentPage = 1;
//        Page page = PageUtil.createPage(EVERYPAGE,(int)contractService.searchAllAvaliableCount(time,department),currentPage);
//        pageLimit = page.getTotalPage();

        if(status>4||status<0)
            status=4;

        List<CheckChargeTable> tables = service.getAllCheckChargeTable(time,department,null,status);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("tables",tables);
        if (jspPage==null || jspPage.length()==0)
            jspPage = "check_charge_table.jsp";
        return SUCCESS;
    }

    //获得某月的租金比对
    public String getChargePlanCompareCheck(){
        if(status>4||status<0)
            status=4;

        Date currentTime = service.getCurrentTime(department);
        if (time == null){
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentTime);
            calendar.add(Calendar.MONTH,-1);
            time = calendar.getTime();
        }

        List<ChargePlanCompareCheck> tables;

        if (StringUtils.equals("全部",department)){
            List<ChargePlanCompareCheck> table1 = service.compareAllCheckChargeTable(currentTime,time,"一部",null,status);
            List<ChargePlanCompareCheck> table2 = service.compareAllCheckChargeTable(currentTime,time,"二部",null,status);
            List<ChargePlanCompareCheck> table3 = service.compareAllCheckChargeTable(currentTime,time,"三部",null,status);
            tables = Stream.concat(Stream.concat(table1.stream(),table2.stream()),table3.stream()).collect(Collectors.toList());
        }else {
            tables = service.compareAllCheckChargeTable(currentTime,time,department,null,status);
        }

        request.setAttribute("tables",tables);
        jspPage = "check_charge_compare.jsp";
        return SUCCESS;
    }

    public String tongji(){
        //不分页

//        if(currentPage == 0)
//            currentPage = 1;

        //status 0,1,2,3,4 欠费,正常,未交,已交,全部
//        int count;
//        if(licenseNum != null&&licenseNum.length()==7)
//        	count = 1;
//        else
//        	count = (int) contractService.searchAllAvaliableCount(time,department,licenseNum);
//        Page page = PageUtil.createPage(EVERYPAGE,count,currentPage);
//        pageLimit = page.getTotalPage();

        List<CheckChargeTable> tables = service.getAllCheckChargeTable(time,department,licenseNum,status);

        HttpServletRequest request = ServletActionContext.getRequest();

        request.setAttribute("tables", tables);
        request.setAttribute("currentClearTime", time);
        jspPage="show/tongji.jsp";
        return SUCCESS;
    }
    /***********************************************************************************************************/
    /*********************************************END***********************************************************/
    /***********************************************************************************************************/

    /**
     * 单车多月的计划详情.
     * @return SUCCESS
     */
    public String planDetailOneCar(){
        List<PlanDetail> details = new ArrayList<>();
        if(!(timePass == null||timePass.getStartTime() == null||timePass.getEndTime()==null)) {
            details = service.planDetailOneCar(licenseNum,timePass.getStartTime(),timePass.getEndTime());
        }
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("table",details);
        jspPage = "plan_detail_one_car_show.jsp";
        return SUCCESS;
    }

    public String getCheckChargeTableToExcel(){
        ActionContext actionContext = ActionContext.getContext();
        Map request = (Map)actionContext.get("request");
        request.put("templatePath","charge/check_table.xls");
        List datalist = new ArrayList();
        List<String> datasrc=new ArrayList<>();

        List<CheckChargeTable> tables = service.getAllCheckChargeTable(time, department,null,status);

        datalist.add(tables);datalist.add(department);datalist.add(time.getYear()+1900);datalist.add(time.getMonth()+1);
        datasrc.add("checks");datasrc.add("dept");datasrc.add("year");datasrc.add("month");

        request.put("datasrc", datasrc);
        request.put("datalist", datalist);
        request.put("outputName",String.format("%d年%d月对账表.xls", time.getYear()+1900,time.getMonth()+1));

        return "excel_stream";
    }

    //按部门获取对账表
    public String getCheckChargeTableByDept(){
        Date current = service.getCurrentTime(department);
        List<CheckChargeTable> tables = service.getAllCheckChargeTable(current,department,null,4);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("tables",tables);
        jspPage = "show/getCheckChargeTableByDept.jsp";
        return SUCCESS;
    }


    //获得单车多月的对账单 file:a_car_check_charge_table

    public String getACarChargeTable(){
        List<CheckTablePerCar> tables = service.getACarChargeTable(licenseNum, timePass);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("a_car_table",tables);
        jspPage = "show/a_car_check_charge_table.jsp";
        return SUCCESS;
    }
    //导出单车多月对账表
    public String exportACarChargeTable(){
        ActionContext actionContext = ActionContext.getContext();
        Map request = (Map)actionContext.get("request");
        request.put("templatePath","charge/a_car_check_table.xls");
        List datalist = new ArrayList();
        List<String> datasrc=new ArrayList<>();

        List<CheckTablePerCar> tables = service.getACarChargeTable(licenseNum, timePass);

        datalist.add(tables);
        datasrc.add("checks");

        request.put("datasrc", datasrc);
        request.put("datalist", datalist);
        request.put("outputName","单车多月对账表.xls");

        return "excel_stream";
    }

    //导出银行文件为txt
    public String exportTxt() throws Exception{
        List<BankRecord> records = service.exportBankFile(time,department);
        File f = new File("bankFile.txt");
        PrintWriter pw = new PrintWriter(f);

        for(BankRecord br:records){
            if(br.getMoney().intValue() == 0)
                continue;

            List<BankCardOfVehicle> bvList = br.getBankCards();
            BankCard bc = null;
            int cardId=0;
            for (BankCardOfVehicle bv : bvList){
                if (bv.getBankCard().getCardClass().equals("哈尔滨银行") && bv.getBankCard().getId()>cardId){
                    bc = bv.getBankCard();
                    cardId = bc.getId();
                }
            }
            if(bc == null){
                continue;
            }
            String s = br.getLicenseNum()+"|";
            s += br.getDriverName().trim()+"|";
            s += (bc == null?" ":bc.getCardNumber())+"|";
            s += br.getMoney().setScale(3).doubleValue();
            pw.println(s);
        }
        pw.close();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月-"+department+"-银行计划");
        fileName = sdf.format(time)+".txt";
        fileName = new String(fileName.getBytes(),"ISO8859-1");
        txtFile = new FileInputStream(f);

        return "stream";
    }

    //清空脏数据
    public String clearDirtyTmp(){
        service.clearBadBankRecords();
        jspPage = "bankfile_import.jsp";
        return SUCCESS;
    }
    //移动缓存至数据库
    public String fromTmpToSql(){
        service.fromTmpToSql();
        jspPage = "bankfile_import.jsp";
        return SUCCESS;
    }

    public String reimportFromTmp(){
        BankRecordTmp tmp = ObjectAccess.getObject(BankRecordTmp.class, id);
        if (tmp==null||tmp.getStatus()!=2) {
            jsonObject = false;
        }else{
            tmp.setError(null);
            tmp.setStatus(0);
            ObjectAccess.saveOrUpdate(tmp);

            service.fromTmpToSql();

            jsonObject = true;
        }

        return JSON_RESULT;
    }

    public String updateTmp(){
        BankRecordTmp r = ObjectAccess.getObject(BankRecordTmp.class, tmp.getId());
        if (r==null||r.getStatus()!=2) {
            jsonObject = false;
        }else{
            r.setLicenseNum(tmp.getLicenseNum());
            r.setDriverName(tmp.getDriverName());
            r.setBankCardNum(tmp.getBankCardNum());
            ObjectAccess.saveOrUpdate(r);
            jsonObject = true;
        }
        return JSON_RESULT;
    }

    public void rollbackImport() throws IOException{
        ServletActionContext.getResponse().setContentType("text/plain");
        ServletActionContext.getResponse().setCharacterEncoding("utf-8");
        PrintWriter out = ServletActionContext.getResponse().getWriter();

        JSONArray jarray = JSONArray.fromObject(jsonStr);

        Session session  = HibernateSessionFactory.getSession();
        Transaction tx = null;
        String msg = "操作成功！";
        int fid = 0 ;
        try{
            tx = session.beginTransaction();
            for(int i=0 ;i<jarray.size();i++){
                int id = Integer.parseInt(jarray.get(i).toString());
                BankRecordTmp bt = (BankRecordTmp) session.get(BankRecordTmp.class, id);
                String licenseNum = bt.getLicenseNum();
                fid = bt.getFid();
                Query q_v = session.createQuery("select carframeNum from Vehicle where licenseNum=:carnum");
                q_v.setString("carnum", licenseNum);
                q_v.setMaxResults(1);
                String carframeNum = q_v.uniqueResult().toString();
                Query q_dept = session.createQuery("select branchFirm from Contract where carframeNum=:id ");
                q_dept.setString("id", carframeNum);
                q_dept.setMaxResults(1);
                String dept = q_dept.uniqueResult().toString();
                Query query = session.createQuery("from ClearTime where department = :dept");
                query.setString("dept",dept);
                Object obj = query.uniqueResult();
                ClearTime ct = (ClearTime)obj;
                Date current = ct.getCurrent();
                if(isYearAndMonth(current,bt.getInTime())){
                    Query q_c = session.createQuery("delete from ChargePlan where feeType='add_bank' and comment=:id");
                    q_c.setString("id", ""+id);
                    q_c.executeUpdate();
                    session.delete(bt);
                }else{
                    msg="已结账的数据不能回退！";
                }
            }

            Query q_f = session.createQuery("select count(*) from BankRecordTmp where fid=:id ");
            q_f.setInteger("id", fid);
            long ct = (long) q_f.uniqueResult();
            if(ct==0){
                BankFile bf = (BankFile) session.get(BankFile.class, fid);
                session.delete(bf);
            }
            tx.commit();
        }catch(HibernateException ex){
            ex.printStackTrace();
            if(tx!=null){
                tx.rollback();
            }
            msg = "回退失败，错误信息："+ex.getMessage();
        }finally{
            HibernateSessionFactory.closeSession();
        }

        out.print(msg);

        out.flush();
        out.close();
    }

    //显示数据
    public String showBankRecords(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        List<BankRecordTmp> brts = service.getBankRecordByTimeAndStatus(time,status);
        request.put("tables",brts);

//        System.out.println(brts);
        jspPage = "show/showBankRecoeds.jsp";
        return SUCCESS;
    }
    //获得某个月的所有记录
    public String getAMonthRecords(){
        jsonObject = service.getAMonthRecords(licenseNum,time);
//        System.out.println(jsonObject);
        return JSON_RESULT;
    }
    public String getAMonthGetMoney(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        List<ChargePlan> plans = service.getAMonthRecords(licenseNum,time);
        CollectionUtils.filter(plans, new Predicate() {
            @Override
            public boolean evaluate(Object o) {
                ChargePlan cp = (ChargePlan)o;
                if(cp.getFeeType().startsWith("sub")){
                    return true;
                }
                return false;
            }
        });
        request.put("plans",plans);
        jspPage = "show/show_get_money_records.jsp";
        return SUCCESS;
    }

    public String finalClear(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        boolean result = service.finalClearAll(department);
        if(result){
            message = "操作成功";
        }else{
            message = "操作失败，当前月份的其他部门未清帐";
        }
        request.put("message",message);
        nextAction = "showClearPage";
        return DISPATCH;
    }
    //展示清帐列表
    public String showClearPage(){
        department = department == null?"一部":department;
        Date date = service.getCurrentTime(department);
//        System.out.println(date);
//        List<BankRecord> unClears = service.getUnClearRecord(date,department,null);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        jspPage = "showClearPage.jsp";
//        request.put("unClears",unClears);
        request.put("message",request.get("message"));
        return SUCCESS;
    }

    public String getCurrentTime(){
        if(StringUtils.isBlank(department) || "全部".equals(department)){
            department = "total";
        }

        jsonObject = service.getCurrentTime(department);
        return JSON_RESULT;
    }

    public String getCurrentMonth(){
        Date current = service.getCurrentTime(department);
        Calendar cal = Calendar.getInstance();
        cal.setTime(current);
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH)+1;
        ajax_message = year+"年"+month+"月";
        return STRING_RESULT;
    }

    @SuppressWarnings("deprecation")
    private boolean isYearAndMonth(Date date1,Date date2){
        if(date1 == null||date2 == null) return false;
        return date1.getYear() == date2.getYear() && date1.getMonth() == date2.getMonth();
    }

    @SuppressWarnings("deprecation")
    private boolean isYM1BGYM2(Date date1,Date date2){
        int year1 = date1.getYear();
        int month1 = date1.getMonth();
        int year2 = date2.getYear();
        int month2 = date2.getMonth();
        if(year1 > year2) return true;
        if(year1 == year2 && month1 >= month2) return true;
        return false;
    }

    private boolean useContractEnd;
    @Autowired
    private VehicleDao vehicleDao;
    @Autowired
    private ContractDao contractDao;

    public void setVehicleDao(VehicleDao vehicleDao) {
        this.vehicleDao = vehicleDao;
    }


    public void setContractService(ContractService contractService) {
        this.contractService = contractService;
    }


    public void setContractDao(ContractDao contractDao) {
        this.contractDao = contractDao;
    }


    //展示的表格！！！
    //单车多月的台帐
    public String singleCarAndMuiltyMonthCheckShow(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        List<CheckChargeTable> tables = new ArrayList<>();

        block:{
            if(timePass == null || licenseNum == null || timePass.getStartTime() == null){

            }
            else{
                Date start = timePass.getStartTime();
                Date end = timePass.getEndTime();

                if(useContractEnd||timePass.getEndTime()==null){
                    Vehicle vehicle = new Vehicle();
                    vehicle.setLicenseNum(licenseNum);
                    vehicle = vehicleDao.selectByLicense(vehicle);
                    if(vehicle == null){
                        break block;
                    }
                    Contract contract = contractDao.selectByCarId(vehicle.getCarframeNum(),timePass.getStartTime());
                    if(contract == null){
                        break block;
                    }
                    end = contract.getContractEndDate();
                }


                while(isYM1BGYM2(end, start)){
                    CheckChargeTable cct = service.getSingleCarAndMonthCheckTableByLicenseNum(licenseNum, start);
                    if(cct != null){
                        tables.add(cct);
                    }
                    start = DateUtil.getNextMonth(start);
                }

            }
        }
        jspPage = "show/singleCarAndMuiltyMonthCheckShow.jsp";
        request.put("tables",tables);
        return SUCCESS;
    }
    //单车多月的明细
    public String singleCarAndMuiltyMonthDetailShow(){
        Map<Date,List<ChargePlan>> map = new HashMap<>();
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        Date start = timePass.getStartTime();
        Date end = timePass.getEndTime();
        if(end == null || start ==null);
        else{
            while(isYM1BGYM2(end, start)){
                List<ChargePlan> plans = service.getAMonthRecords(licenseNum, start);

                if (start.getDate()>26) {
                    Calendar dt = Calendar.getInstance();
                    dt.setTime(start);
                    dt.add(Calendar.MONTH, 1);
                    plans = service.getAMonthRecords(licenseNum, dt.getTime());
                } else {
                    plans = service.getAMonthRecords(licenseNum, start);
                }

                CollectionUtils.filter(plans,new Predicate(){
                    @Override
                    public boolean evaluate(Object o) {
                        if(o==null)
                            return false;
                        ChargePlan cp = (ChargePlan)o;
                        if(!cp.getFeeType().startsWith("plan"))
                            return false;
                        return true;
                    }
                });
                map.put(start,plans);
                start = DateUtil.getNextMonth(start);
            }
        }
        request.put("map",map);
        jspPage = "show/singleCarAndMuiltyMonthDetailShow.jsp";
        return SUCCESS;
    }
    /**单车单月财务对账表*/
    public String getACarAndAMonthCheckTable(){
        TimePass tp = new TimePass();
        tp.setStartTime(time);
        tp.setEndTime(time);
        List<CheckTablePerCar> tables = service.getACarChargeTable(licenseNum, tp);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        request.put("a_car_table",tables);
        jspPage = "show/a_car_a_month_check_charge_table.jsp";
        return SUCCESS;
    }

    /**
     * 收费类型查询.
     * @return
     */
    public String getChargeCount(){
        System.out.println("Invoked.");
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        Map<String,List<ChargePlan>> map = new HashMap<>();
        List<ChargePlan> plans = service.getAll(time,feeType);

        List<ChargePlan> p_cash = new ArrayList<>();
        List<ChargePlan> p_bank = new ArrayList<>();
        List<ChargePlan> p_bank2 = new ArrayList<>();
        List<ChargePlan> p_insurance = new ArrayList<>();
        List<ChargePlan> p_oil = new ArrayList<>();
        List<ChargePlan> p_other = new ArrayList<>();
        BigDecimal bd_cash = new BigDecimal(0.00);
        BigDecimal bd_bank = new BigDecimal(0.00);
        BigDecimal bd_bank2 = new BigDecimal(0.00);
        BigDecimal bd_insurance = new BigDecimal(0.00);
        BigDecimal bd_oil = new BigDecimal(0.00);
        BigDecimal bd_other = new BigDecimal(0.00);
        for(ChargePlan p:plans){
            switch (p.getFeeType()){
                case "add_insurance":
                    p_insurance.add(p);
                    bd_insurance = bd_insurance.add(p.getFee());
                    break;
                case "add_bank":
                    p_bank.add(p);
                    bd_bank = bd_bank.add(p.getFee());
                    break;
                case "add_bank2":
                    p_bank2.add(p);
                    bd_bank2 = bd_bank2.add(p.getFee());
                    break;
                case "add_oil":
                    p_oil.add(p);
                    bd_oil = bd_oil.add(p.getFee());
                    break;
                case "add_cash":
                    p_cash.add(p);
                    bd_cash = bd_cash.add(p.getFee());
                    break;
                case "add_other":
                    p_other.add(p);
                    bd_other = bd_other.add(p.getFee());
                    break;
            }
        }
        if(p_oil.size() > 0){
            ChargePlan cp_oil = new ChargePlan();
            cp_oil.setFeeType("total");
            cp_oil.setFee(bd_oil);
            p_oil.add(cp_oil);
            map.put("oil", p_oil);
        }
        if(p_bank.size() > 0){
            ChargePlan cp_bank = new ChargePlan();
            cp_bank.setFeeType("total");
            cp_bank.setFee(bd_bank);
            p_bank.add(cp_bank);
            map.put("bank",p_bank);
        }
        if(p_insurance.size() > 0){
            ChargePlan cp_insurance = new ChargePlan();
            cp_insurance.setFeeType("total");
            cp_insurance.setFee(bd_insurance);
            p_insurance.add(cp_insurance);
            map.put("insurance",p_insurance);
        }
        if(p_cash.size() > 0){
            ChargePlan cp_cash = new ChargePlan();
            cp_cash.setFeeType("total");
            cp_cash.setFee(bd_cash);
            p_cash.add(cp_cash);
            map.put("cash",p_cash);
        }
        if(p_other.size() > 0) {
            ChargePlan cp_other = new ChargePlan();
            cp_other.setFeeType("total");
            cp_other.setFee(bd_other);
            p_other.add(cp_other);
            map.put("other",p_other);
        }
        request.put("map",map);
        System.out.println(map.size());
        jspPage = "chargeCount.jsp";
        return SUCCESS;
    }


    /************** Stable and changeless methods below. **************/

    /**分析银行文件 file:none.jsp*/
    public String analyseFile(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        jspPage = "bankfile_import.jsp";
        if(!isYearAndMonth(time,service.getCurrentTime("total"))){
            message = "不在当前清帐年月\n";
            request.put("message",message);
            return SUCCESS;
        }

//        MD5 md5 = MD5.getInstance();
//        String md5Str = md5.GetMD5Code(brs.toString());
//        boolean isFileExisted = service.isFileExisted(md5Str);
        boolean isFileExisted = service.isFileExisted(filename);
        if(isFileExisted == true){
            message = "导入文件失败，该文件已导入！";
        }else{
            JSONArray json = JSONArray.fromObject(jsonStr);
//           json.toArray();
            @SuppressWarnings("unchecked")
            List<BankRecord> brs= (List<BankRecord>) CollectionUtils.collect(json, new Transformer() {
                @Override
                public Object transform(Object obj) {
                    JSONObject jso = (JSONObject) obj;
                    BankRecord ai = new BankRecord();
                    ai.setDriverName(jso.getString("name"));
                    ai.setLicenseNum(jso.getString("licenseNum"));
                    ai.setMoney(BigDecimal.valueOf(Double.parseDouble(jso.getString("Money"))));
                    Map<String,BankCard> map = new HashMap<String, BankCard>();
                    BankCard bc = new BankCard();
                    bc.setCardNumber(jso.getString("cardNum"));
                    bc.setCardClass("哈尔滨银行");
//                   System.out.println("bc --> "+bc.getCardNumber());
                    BankCardOfVehicle bv = new BankCardOfVehicle();
                    bv.setBankCard(bc);
                    ai.setBankCards(Arrays.asList(bv));
                    return ai;
                }
            });

            Calendar nm = Calendar.getInstance();
            nm.setTime(time);
            if(nm.get(Calendar.DATE)>26){
                nm.add(Calendar.MONTH, 1);
            }
            nm.set(Calendar.DATE, 1);
            int fid = service.writeMd5(filename,nm.getTime());

            service.importFile(brs,recorder,fid);
            message = " 数据导入成功\n";
//            service.writeMd5(md5Str);


        }
        request.put("message",message);
        return SUCCESS;
    }

    /**
     * 根据车号给出这辆车的所有约定变更记录
     * @return SUCCESS
     */
    public String searchBPS(){
        List<BatchPlan> bps = service.searchBatchPlans(licenseNum);

//        Collections.sort(bps,new Comparator<BatchPlan>() {
//            @Override
//            public int compare(BatchPlan o1, BatchPlan o2) {
//                if(o1.getStartTime().getTime() >= o2.getStartTime().getTime()){
//                    return 1;
//                }else{
//                    return -1;
//                }
//            }
//        });

        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
//        System.out.println(bps);

        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(licenseNum);
        Vehicle v = vehicleDao.selectByLicense(vehicle);

        Contract contract = null;
        if(v != null){
            contract = contractDao.selectByCarId(v.getCarframeNum());
            request.put("contract",contract);
        }
        Session hsession = HibernateSessionFactory.getSession();
        for(BatchPlan bp:bps){
            if (contract != null && bp.getFee()==null) {
                Contract finalContract = contract;
                BatchPlan bp2 = (BatchPlan) hsession.get(BatchPlan.class,bp.getId());
                Optional<ChargePlan> chargePlanOptional = bp2.getChargePlanList().stream()
                        .filter(cp->cp.getContractId()== finalContract.getId())
                        .findFirst();
                bp.setFee(chargePlanOptional.map(ChargePlan::getFee)
                        .orElse(BigDecimal.ZERO));
            }

            String type = bp.getFeeType();
            if(type.equals("plan_base_contract")){
                bp.setFeeType("合同基本费用");
            }else if(type.equals("plan_add_insurance")){
                bp.setFeeType("保险费用");
            }else if(type.equals("plan_sub_insurance")){
                bp.setFeeType("保险费用");
                bp.setFee(bp.getFee().negate());
            }else if(type.equals("plan_add_contract")){
                bp.setFeeType("合同费用");
            }else if(type.equals("plan_sub_contract")){
                bp.setFeeType("合同费用");
                bp.setFee(bp.getFee().negate());
            }else if(type.equals("plan_add_other")){
                bp.setFeeType("其他费用");
            }else if(type.equals("plan_sub_other")){
                bp.setFeeType("其他费用");
                bp.setFee(bp.getFee().negate());
            }
        }

        request.put("bps",bps);
        jspPage = "bps_show.jsp";
        return SUCCESS;
    }

    /**
     * 获得单车单月的欠款.
     * @return JSON_RESULT.
     */
    public String getOweByLicenseNumAndMonth(){
        jsonObject = service.getSingleCarAndMonthCheckTableByLicenseNum(licenseNum,time);
        return JSON_RESULT;
    }

    /**
     * 欠款清账用.
     * @return SUCCESS.
     */
    public String getOweDeleteList(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        List<ChargePlan> plans = service.getAMonthRecords(licenseNum, time);
        CollectionUtils.filter(plans,new Predicate(){
            @Override
            public boolean evaluate(Object o) {
                if(o==null)
                    return false;
                ChargePlan cp = (ChargePlan)o;
                if(!cp.getFeeType().startsWith("add"))
                    return false;
                return true;
            }
        });
        request.put("plans",plans);
        jspPage = "oweDeletePage.jsp";
        return SUCCESS;
    }

    public String addChargePlan(){
        boolean success = service.addChargePlan(chargePlan);
        if(success){
            jspPage = "success.jsp";
        }else{
            jspPage = "error.jsp";
        }
        return SUCCESS;
    }
    public String addChargePlanByLicenseNum(){
        boolean success = service.addChargePlanByLicenseNum(chargePlan,licenseNum);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        if("get_money".equals(visitType)){
            if(success){
                jspPage = "get_money.jsp";
                message = "已成功取款。";
            }else{
                jspPage = "get_money.jsp";
                message = "取款失败,不在当前清帐月份！";
            }
        }else if("charge_add".equals(visitType)){
            if(success){
                request.put("chargePlan", chargePlan);
                jspPage = "charge_add.jsp";
                message = "添加收入成功。";
            }else{
                jspPage = "charge_add.jsp";
                message = "添加收入失败，不在当前清帐月份！";
            }
        }else{
            if(success){
                jspPage = "success.jsp";
                message = "添加收入成功。";
            }else{
                jspPage = "error.jsp";
                message = "添加收入失败，不在当前清帐月份！";
            }
        }
        request.put("message",message);
        return SUCCESS;
    }
    public String deleteChargePlan(){
        boolean success = service.deleteChargePlan(chargePlan);
        if(success){
            ajax_message = "success";
        }else{
            ajax_message = "error";
        }
        return STRING_RESULT;
    }
    public String addBatchPlan(){
        boolean success = false;
        if("on".equals(isToEnd)){
            batchPlan.setEndTime(null);
            success = service.addBatchPlan(batchPlan, true);
        }else{
            success = service.addBatchPlan(batchPlan, false);
        }
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String,Object>)context.get("request");
        jspPage = "batch_add.jsp";
        request.put("message",message);
        return SUCCESS;
    }
    public String addBatchPlanPerCar(){
        boolean success = false;
        if("on".equals(isToEnd)){
            batchPlan.setEndTime(null);
            success = service.addBatchPlanPerCar(batchPlan,licenseNum, true);
        }else{
            success = service.addBatchPlanPerCar(batchPlan,licenseNum, false);
        }
        ActionContext context = ActionContext.getContext();
        context.get("request");
        if(success){
            jspPage = "percar_add.jsp";
            message = "添加成功";
        }else {
            jspPage = "percar_add.jsp";
            message = "添加失败,请重新添加";
        }
        return SUCCESS;
    }
    public String deleteBatchPlan(){
        boolean success = service.deleteBatchPlan(batchPlan);
        if(success){
            ajax_message = "success";
        }else{
            ajax_message = "error";
        }
        return STRING_RESULT;
    }
    //
    public String couldGetMoney(){
        jsonObject = service.couldGetMoney(licenseNum,time);
        return JSON_RESULT;
    }

    /************** Setter and getter methods below. ******************/

    public ChargeService getService() {
        return service;
    }

    public void setService(ChargeService service) {
        this.service = service;
    }

    public ChargePlan getChargePlan() {
        return chargePlan;
    }

    public void setChargePlan(ChargePlan chargePlan) {
        this.chargePlan = chargePlan;
    }

    public String getJspPage() {
        return jspPage;
    }

    public void setJspPage(String jspPage) {
        this.jspPage = jspPage;
    }

    public String getAjax_message() {
        return ajax_message;
    }

    public void setAjax_message(String ajax_message) {
        this.ajax_message = ajax_message;
    }

    public Object getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(Object jsonObject) {
        this.jsonObject = jsonObject;
    }

    public BatchPlan getBatchPlan() {
        return batchPlan;
    }


    public void setBatchPlan(BatchPlan batchPlan) {

        this.batchPlan = batchPlan;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {

        this.licenseNum = licenseNum;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public TimePass getTimePass() {
        return timePass;
    }

    public void setTimePass(TimePass timePass) {
        this.timePass = timePass;
    }

    public String getNextAction() {
        return nextAction;
    }

    public void setNextAction(String nextAction) {
        this.nextAction = nextAction;
    }

    public String getMessage() {
        return message;
    }

    public String getVisitType() {
        return visitType;
    }

    public void setVisitType(String visitType) {
        this.visitType = visitType;
    }

    public void setMessage(String message) {

        this.message = message;
    }

    public String getDepartment() {
        return department;
    }

    public ChargeAction setDepartment(String department) {
        this.department = department;
        return this;
    }

    public String getRecorder() {
        return recorder;
    }

    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    public String getJsonStr() {
        return jsonStr;
    }

    public void setJsonStr(String jsonStr) {
        this.jsonStr = jsonStr;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public InputStream getTxtFile() {
        return txtFile;
    }

    public void setTxtFile(InputStream txtFile) {
        this.txtFile = txtFile;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getIsToEnd() {
        return isToEnd;
    }

    public void setIsToEnd(String isToEnd)
    {
        this.isToEnd = isToEnd;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage)
    {
        this.currentPage = currentPage;
    }

    public int getPageLimit() {
        return pageLimit;
    }

    public void setPageLimit(int pageLimit) {
        this.pageLimit = pageLimit;
    }



    public int getId() {
        return id;
    }



    public void setId(int id) {
        this.id = id;
    }



    public BankRecordTmp getTmp() {
        return tmp;
    }



    public void setTmp(BankRecordTmp tmp) {
        this.tmp = tmp;
    }


    public boolean getUseContractEnd() {
        return useContractEnd;
    }


    public void setUseContractEnd(boolean useContractEnd) {
        this.useContractEnd = useContractEnd;
    }


    public String getFilename() {
        return filename;
    }


    public void setFilename(String filename) {
        this.filename = filename;
    }

    @Autowired
    private InsuranceBackService insuranceBackService;

    public void setInsuranceBackService(InsuranceBackService insuranceBackService) {
        this.insuranceBackService = insuranceBackService;
    }

    public String requestInsuranceReceipt()  {
        List list = null;
        try {
            list = insuranceBackService.requestReceipt(time);
            ajax_message = "操作成功";
        } catch (Exception e) {
            e.printStackTrace();
            ajax_message = "操作失败,"+e.getMessage();
        }
        return STRING_RESULT;
    }

    public String tryAttachVehicle(){
        insuranceBackService.tryAttachVehicle();
        ajax_message = "success";
        return STRING_RESULT;
    }

    public String manalAttachVehicle(){
        String carNum = request.getParameter("carNum");
        String receiptId = request.getParameter("receiptId");
        Vehicle vehicle = new Vehicle();
        vehicle.setLicenseNum(carNum);
        vehicle = vehicleDao.selectByLicense(vehicle);

        if (vehicle==null){
            ajax_message = "操作失败，找不到车牌号为"+carNum+"的车辆！";
            return STRING_RESULT;
        }

        InsuranceReceipt receipt = ObjectAccess.getObject(InsuranceReceipt.class,receiptId);
        if (receipt==null){
            ajax_message = "操作失败，找不到单号为"+receiptId+"的单据，确认是否已被其它用户删除？";
            return STRING_RESULT;
        }

        if (receipt.getState()>0){
            ajax_message = "操作失败，该单据已成功匹配，不可再次匹配。";
            return STRING_RESULT;
        }

        insuranceBackService.manalAttachVehicle(receipt,vehicle);
        ajax_message = "操作成功！";
        return STRING_RESULT;
    }

    public String removeRecipt(){
        String receiptId = request.getParameter("receiptId");
        InsuranceReceipt receipt = ObjectAccess.getObject(InsuranceReceipt.class,receiptId);
        if (receipt==null){
            ajax_message = "操作失败，找不到单号为"+receiptId+"的单据，确认是否已被其它用户删除？";
            return STRING_RESULT;
        }

        if (receipt.getState()>0){
            ajax_message = "操作失败，该单据已成功匹配，不可删除！";
            return STRING_RESULT;
        }

        ajax_message = "操作成功！";

        Session hsession;
        Transaction transaction;
        try {
            hsession = HibernateSessionFactory.getSession();
            transaction = hsession.beginTransaction();
            hsession.delete(receipt);
            transaction.commit();
        }catch (HibernateException ex){
            ajax_message = "操作失败，数据库错误："+ ex.getMessage();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return STRING_RESULT;
    }

    public String confirmChecked(){
        String ids = request.getParameter("ids");
        List<InsuranceBack> backs = Arrays.stream(ids.split(",")).mapToInt(Integer::parseInt)
                .mapToObj(i-> ObjectAccess.getObject(InsuranceBack.class, i))
                .collect(Collectors.toList());
        User user = (User) session.getAttribute("user");
        insuranceBackService.confirmChecked(backs,user);
        ajax_message = "success";
        return STRING_RESULT;
    }

    public String refuseInsuranceBack(){
        String ids = request.getParameter("ids");
        List<InsuranceBack> backs = Arrays.stream(ids.split(",")).mapToInt(Integer::parseInt)
                .mapToObj(i-> ObjectAccess.getObject(InsuranceBack.class, i))
                .collect(Collectors.toList());
        insuranceBackService.refuseInsuranceBack(backs);
        ajax_message = "success";
        return STRING_RESULT;
    }
}
