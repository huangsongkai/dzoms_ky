package com.dz.module.contract;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;
import com.dz.common.other.TimeComm;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONObject;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

@Controller
@Scope("prototype")
public class BankCardAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
    public String bankCardAdd() {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            bankCard.setOperator(user.getUid());
            bankCard.setOpeTime(TimeComm.getCurrentTime());
        }
        boolean flag = bankCardService.bankCardAdd(bankCard);
        if (!flag) {
            this.addActionError("添加银行卡失败。");
            return "add_success";
        } else {
            if(!org.apache.commons.lang3.StringUtils.isBlank(bankCard.getCarNum())){
                Transaction tx = null;
                try {
                    Session s = HibernateSessionFactory.getSession();
                    tx = s.beginTransaction();
                    bindCard(s);
                    tx.commit();
                }catch (HibernateException ex){
                    ex.printStackTrace();
                    if (tx!=null)
                        tx.rollback();
                    this.addActionError("添加银行卡成功,但未能成功绑定到车辆，原因是："+ex.getMessage());
                    return "add_success";
                }finally {
                    HibernateSessionFactory.closeSession();
                }
            }
            this.addActionError("添加成功。");
            return "add_success";
        }
    }

    public String bankCardUpdate() {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            bankCard.setOperator(user.getUid());
            bankCard.setOpeTime(TimeComm.getCurrentTime());
        }

        if (bankCardService.bankCardUpdate(bankCard))
            return "update_success";

        return ERROR;
    }

    public String bankCardDelete() {
        Session s = HibernateSessionFactory.getSession();
        Transaction tx = null;
        try {
            tx = s.beginTransaction();
            Query query = s.createQuery("delete from BankCardOfVehicle where bankCard.id=:cardId");
            query.setInteger("cardId",bankCard.getId());
            s.delete(bankCard);
            query.executeUpdate();
            tx.commit();

            this.addActionError("删除成功。");
        } catch (HibernateException e) {
            e.printStackTrace();
            if (tx != null)
                tx.rollback();
            this.addActionError("删除失败。");
        }
        return "add_success";
    }

    /**
     * 绑定银行卡到车辆 一卡可绑多车 一车可绑多卡
     */
    public void bindVehicle() throws IOException {
        Session s = null;
        Transaction tx = null;
        JSONObject jsonObject = new JSONObject();
        try {
            s = HibernateSessionFactory.getSession();
            tx = s.beginTransaction();
            bindCard(s);
            tx.commit();
            jsonObject.put("status",true);
        }catch (HibernateException ex){
            if(tx!=null){
                tx.rollback();
            }
            jsonObject.put("status",false);
            jsonObject.put("msg",ex.getMessage());
            ex.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

    private void bindCard(Session s) {
        Query query = s.createQuery("delete from BankCardOfVehicle where bankCard.id=:cardId and vehicle.carframeNum=:carNum");
        query.setInteger("cardId",bankCard.getId());
        query.setString("carNum",bankCard.getCarNum());
        query.executeUpdate();
        BankCardOfVehicle bv = new BankCardOfVehicle();
        bv.setBankCard((BankCard) s.get(BankCard.class,bankCard.getId()));
        bv.setVehicle((Vehicle) s.get(Vehicle.class,bankCard.getCarNum()));

        Query query_rcv_count = s.createQuery("select count(*) from BankCardOfVehicle bv " +
                "where bv.isDefaultRecive=true " +
                "and bv.vehicle.carframeNum=:carNum ");
        query_rcv_count.setString("carNum",bankCard.getCarNum());
        long rcv_count = (long) query_rcv_count.uniqueResult();
        if (rcv_count==0){
            bv.setIsDefaultRecive(true);
        }else if(BooleanUtils.isTrue(bankCard.getIsDefaultRecive())){
            Query query1 = s.createQuery("update BankCardOfVehicle set isDefaultRecive=false where vehicle.carframeNum=:carNum");
            query1.setString("carNum",bv.getVehicle().getCarframeNum());
            query1.executeUpdate();
            bv.setIsDefaultRecive(true);
        }

        s.saveOrUpdate(bv);
    }

    /**
     * 解绑银行卡--车辆
     */
    public void unbindVehicle() throws IOException {
        Session s = null;
        Transaction tx = null;
        JSONObject jsonObject = new JSONObject();
        try {
            s = HibernateSessionFactory.getSession();
            tx = s.beginTransaction();
            Query query = s.createQuery("delete from BankCardOfVehicle where bankCard.id=:cardId and vehicle.carframeNum=:carNum");
            query.setInteger("cardId",bankCard.getId());
            query.setString("carNum",bankCard.getCarNum());
            query.executeUpdate();

            Query query_rcv_count = s.createQuery("select count(*) from BankCardOfVehicle bv " +
                    "where bv.isDefaultRecive=true " +
                    "and bv.vehicle.carframeNum=:carNum ");
            query_rcv_count.setString("carNum",bankCard.getCarNum());
            long rcv_count = (long) query_rcv_count.uniqueResult();
            if (rcv_count==0){
                Query query_rcv_top1= s.createQuery(
                        "from BankCardOfVehicle bv " +
                                "where bv.vehicle.carframeNum=:carNum " +
                                "order by bv.bankCard.id");
                query_rcv_top1.setString("carNum",bankCard.getCarNum());
                query_rcv_top1.setMaxResults(1);
                BankCardOfVehicle bankCardOfVehicle = (BankCardOfVehicle) query_rcv_top1.uniqueResult();
                if (bankCardOfVehicle!=null){
                    bankCardOfVehicle.setIsDefaultRecive(true);
                    s.saveOrUpdate(bankCardOfVehicle);
                }
            }

            tx.commit();
            jsonObject.put("status",true);
        }catch (HibernateException ex){
            if(tx!=null){
                tx.rollback();
            }
            jsonObject.put("status",false);
            jsonObject.put("msg",ex.getMessage());
            ex.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

    public void assignDefaultReceive() throws IOException {
        Session s = null;
        Transaction tx = null;
        JSONObject jsonObject = new JSONObject();
        try_block:
        try {
            s = HibernateSessionFactory.getSession();
            tx = s.beginTransaction();

            Query query = s.createQuery("from BankCardOfVehicle where bankCard.id=:cardId and vehicle.carframeNum=:carNum");
            query.setInteger("cardId",bankCard.getId());
            query.setString("carNum",bankCard.getCarNum());
            query.setMaxResults(1);
            BankCardOfVehicle bv = (BankCardOfVehicle) query.uniqueResult();
            if (bv==null){
                jsonObject.put("status",false);
                jsonObject.put("msg","不存在该绑定");
                break try_block;
            }

            if (BooleanUtils.isTrue(bv.getIsDefaultRecive())){
                jsonObject.put("status",true);
                jsonObject.put("msg","该银行卡已经是默认支付卡了。");
                break try_block;
            }

            Query query1 = s.createQuery("update BankCardOfVehicle set isDefaultRecive=false where vehicle.carframeNum=:carNum");
            query1.setString("carNum",bv.getVehicle().getCarframeNum());
            query1.executeUpdate();
            bv.setIsDefaultRecive(true);
            s.saveOrUpdate(bv);

            tx.commit();
            jsonObject.put("status",true);
        }catch (HibernateException ex){
            if(tx!=null){
                tx.rollback();
            }
            jsonObject.put("status",false);
            jsonObject.put("msg",ex.getMessage());
            ex.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

    public String bankCardShow() {
        BankCard card = null;
        card = (BankCard) ObjectAccess.getObject("com.dz.module.contract.BankCard", id);
        if (card == null) {
            return ERROR;
        }
        request.getSession().setAttribute("card", card);
        return "show_success";
    }

    public String searchCard() {
        int currentPage = 0;
        if (request.getParameter("currentPage") != null
                && !(request.getParameter("currentPage")).isEmpty()) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));

            System.out.println(request.getParameter("currentPage"));
        } else {
            currentPage = 1;
        }

        if (bankCard == null) {
            bankCard = new BankCard();
        }

        String hql = "from BankCard where 1=1 ";

        if (!StringUtils.isEmpty(dept) && !dept.startsWith("all")) {
            hql += String.format("and id in (select bankCard.id from BankCardOfVehicle where vehicle.dept='%s') ", dept);
        }

        if (!StringUtils.isEmpty(bankCard.getIdNumber())) {
            hql += String.format("and idNumber like '%%%s%%' ", bankCard.getIdNumber());
        }

        if (!StringUtils.isEmpty(bankCard.getCardNumber())) {
            hql += String.format("and cardNumber like '%%%s%%' ", bankCard.getCardNumber());
        }

        if (!StringUtils.isEmpty(bankCard.getCardClass())) {
            hql += String.format("and cardClass like '%%%s%%' ", bankCard.getCardClass());
        }

        if (!StringUtils.isEmpty(bankCard.getCarNum())&&bankCard.getCarNum().length()>2) {
            hql += String.format("and id in(select bankCard.id from BankCardOfVehicle where vehicle.carframeNum like '%%%s%%') ", bankCard.getCarNum());
        }

        hql += " order by " + order;

        if (BooleanUtils.isFalse(rank)) {
            hql += " desc ";
        }

        Session session = HibernateSessionFactory.getSession();
        Query query = session.createQuery(hql);
        Query query2 = session.createQuery("select count(*) " + hql);

        long count = (long) query2.uniqueResult();

        Page page = PageUtil.createPage(30, (int) count, currentPage);

        query.setFirstResult(page.getBeginIndex());
        query.setMaxResults(page.getEveryPage());


        List<BankCard> cardList = query.list();

        HibernateSessionFactory.closeSession();

        request.setAttribute("list", cardList);
        request.setAttribute("page", page);

        return SUCCESS;
    }

    public String exportExcel(){
        if (bankCard == null) {
            bankCard = new BankCard();
        }

        String hql = "from BankCard where 1=1 ";

        if (!StringUtils.isEmpty(dept) && !dept.startsWith("all")) {
            hql += String.format("and id in (select bankCard.id from BankCardOfVehicle where vehicle.dept='%s') ", dept);
        }

        if (!StringUtils.isEmpty(bankCard.getIdNumber())) {
            hql += String.format("and idNumber like '%%%s%%' ", bankCard.getIdNumber());
        }

        if (!StringUtils.isEmpty(bankCard.getCardNumber())) {
            hql += String.format("and cardNumber like '%%%s%%' ", bankCard.getCardNumber());
        }

        if (!StringUtils.isEmpty(bankCard.getCardClass())) {
            hql += String.format("and cardClass like '%%%s%%' ", bankCard.getCardClass());
        }

        if (!StringUtils.isEmpty(bankCard.getCarNum())&&bankCard.getCarNum().length()>2) {
            hql += String.format("and id in(select bankCard.id from BankCardOfVehicle where vehicle.carframeNum like '%%%s%%') ", bankCard.getCarNum());
        }

        hql += " order by " + order;

        if (BooleanUtils.isFalse(rank)) {
            hql += " desc ";
        }

        Session session = HibernateSessionFactory.getSession();
        Query query = session.createQuery(hql);
        List<BankCard> cardList = query.list();

        HibernateSessionFactory.closeSession();
        List datalist = Arrays.asList(cardList);
        List<String> datasrc = Arrays.asList("cards");

        request.setAttribute("datasrc", datasrc);
        request.setAttribute("datalist", datalist);
        return SUCCESS;
    }

    public String selectByCardNumber(){
        if(bankCard!=null&& org.apache.commons.lang3.StringUtils.isNotBlank(bankCard.getCardNumber()))
            bankCard = bankCardService.getBankCardByCardNumber(bankCard.getCardNumber());
        return SUCCESS;
    }

    public void bankCardSearch() throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        int currentPage = 0;
        if (request.getParameter("currentPage") != null
                && !(request.getParameter("currentPage")).isEmpty()) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));

            System.out.println(request.getParameter("currentPage"));
        } else {
            currentPage = 1;
        }
        Page page = PageUtil.createPage(PageUtil.PAGE_SIZE,
                bankCardService.queryCardCount(), currentPage);
        List<BankCard> cardList = bankCardService.bankCardSearch(page);

        JSONObject json = new JSONObject();
        json.put("list", cardList);
        json.accumulate("hasPrePage", page.isHasPrePage());
        json.accumulate("hasNextPage", page.isHasNexPage());
        json.accumulate("currentPage", currentPage);
        json.accumulate("totalPage", page.getTotalPage());

        out.print(json.toString());

        out.flush();
        out.close();
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public Boolean getRank() {
        return rank;
    }

    public void setRank(Boolean rank) {
        this.rank = rank;
    }
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private BankCard bankCard;
    @Autowired
    private BankCardService bankCardService;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private int id;
    private String dept, order;
    private Boolean rank;

    protected String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BankCardService getBankCardService() {
        return bankCardService;
    }

    public void setBankCardService(BankCardService bankCardService) {
        this.bankCardService = bankCardService;
    }

    public BankCard getBankCard() {
        return bankCard;
    }

    public void setBankCard(BankCard bankCard) {
        this.bankCard = bankCard;
    }

    @Override
    public void setServletRequest(HttpServletRequest arg0) {
        this.request = arg0;
    }

    @Override
    public void setServletResponse(
            HttpServletResponse response){
        this.response = response;
    }
}
