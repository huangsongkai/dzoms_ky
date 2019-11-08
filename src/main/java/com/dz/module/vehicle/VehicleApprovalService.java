package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.DateUtil;
import com.dz.common.global.ToDo;
import com.dz.common.other.ObjectAccess;
import com.dz.module.charge.ChargeDao;
import com.dz.module.charge.ChargePlan;
import com.dz.module.contract.Contract;
import com.dz.module.contract.ContractDao;
import com.dz.module.driver.Driver;
import com.dz.module.driver.DriverService;
import com.dz.module.driver.Driverincar;
import com.dz.module.user.RelationUr;
import com.dz.module.user.Role;
import com.dz.module.user.User;
import com.dz.module.user.UserDao;
import com.dz.module.user.message.Message;
import com.dz.module.user.message.MessageToUser;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
//@WaitDeal(name = "vehicleApprovalService")
//public class VehicleApprovalService implements WaitToDo {
public class VehicleApprovalService {
    @Autowired
    private ContractDao contractDao;
    @Autowired
    private VehicleApprovalDao vehicleApprovalDao;
    @Autowired
    private DuanXinDao duanXinDao;
    @Autowired
    @Qualifier("userDaoImpl")
    private UserDao userDao;


    /**
     * 新建审批单
     *
     * @param vehicleApproval
     * @param contract
     * @return
     */
    public boolean addVehicleApproval(VehicleApproval vehicleApproval, Contract contract) {
        HttpServletRequest request = ServletActionContext.getRequest();
        if (vehicleApproval == null) {
            request.setAttribute("msgStr", "审批单信息不完整。");
            return false;
        }


        long count = ObjectAccess.execute("select count(*) from VehicleApproval "
                + "where checkType='" + vehicleApproval.getCheckType() + "'"
                + " and state!=8 and state>0 "
                + "and contractId in (select id from Contract where idNum='"
                + contract.getIdNum()
                + "') ");
        if (count > 0) {
            request.setAttribute("msgStr", "该车主存在同一类型的审批单尚未结束，请先结束后再进行申请。");
            return false;
        }

        String hql = "select count(*) from VehicleApproval "
                + "where checkType='" + vehicleApproval.getCheckType() + "'"
                + " and state!=8 and state>0 "
                + (StringUtils.isEmpty(contract.getCarframeNum()) ?
                " and 1=0 " :
                "and contractId in (select id from Contract where carframeNum='"
                        + contract.getCarframeNum().trim()
                        + "') "
        );

        //System.out.println(hql);

        long count2 = ObjectAccess.execute(hql);


        if (count2 > 0) {
            request.setAttribute("msgStr", "该车存在同一类型的审批单尚未结束，请先结束后再进行申请。");
            return false;
        }

        switch (vehicleApproval.getCheckType()) { //0是开业 1 是扉页
            case 0:
                contract.setState((short) 2);
                contract.setAscription(vehicleApproval.getAscription());
                if (contract.getContractFrom() != null && contract.getContractFrom() != 0) {
                    //二手车    此处绑定人车
                    Vehicle v = ObjectAccess.getObject(Vehicle.class, contract.getCarframeNum());
                    v.setDriverId(contract.getIdNum());
                    ObjectAccess.saveOrUpdate(v);

                    if (v.getOperateCardTime() != null) {
                        vehicleApproval.setOperateCardDate(v.getOperateCardTime());
                    }

                    if (v.getLicenseRegistTime() != null) {
                        vehicleApproval.setOperateApplyDate(v.getLicenseRegistTime());
                    }

                    Contract c = ObjectAccess.getObject(Contract.class, contract.getContractFrom());
                    contract.setContractId(c.getContractId());
                    contract.setContractType(c.getContractType());
                    contract.setContractEndDate(c.getContractEndDate());

                } else if (StringUtils.isNotBlank(contract.getCarNumOld())) {
                    Contract c = ObjectAccess.execute("from Contract c where c.state=1 and c.carframeNum in (select v.carframeNum from Vehicle v where v.licenseNum='" + contract.getCarNumOld().trim() + "') order by contractBeginDate desc");

                    if (c == null || StringUtils.isBlank(c.getCarframeNum())) {
                        request.setAttribute("msgStr", "无效的原车牌号！");
                        return false;
                    }

                    Vehicle v = ObjectAccess.getObject(Vehicle.class, c.getCarframeNum());
                    if (v == null) {
                        request.setAttribute("msgStr", "原车信息获取失败！");
                        return false;
                    }
                    v.setReused(true);
                    ObjectAccess.saveOrUpdate(v);
                }

                if (!contractDao.contractWrite(contract)) {
                    return false;
                }
                vehicleApproval.setContractId(contract.getId());
                break;
            case 1:
				/*if(!contractDao.contractAbandon(contract)){
					return false;
				}*/

                Contract c = contractDao.selectById(contract.getId());
                Vehicle vehicle = (Vehicle) ObjectAccess.getObject("com.dz.module.vehicle.Vehicle", c.getCarframeNum());
                VehicleMode vehicleMode = (VehicleMode) ObjectAccess.getObject("com.dz.module.vehicle.VehicleMode", vehicle.getCarMode());
                if (vehicleMode != null)
                    vehicleApproval.setFueltype(vehicleMode.getFuel());

                c.setAbandonRequest(contract.getAbandonRequest());
                c.setAbandonReason(contract.getAbandonReason());
                ObjectAccess.saveOrUpdate(c);

                vehicleApproval.setContractId(contract.getId());
                break;
            default:
                return false;
        }

        vehicleApproval.setState(1);
        vehicleApproval.setIsFinished(false);

        if (BooleanUtils.isTrue(contract.getGeneByImport())) {
            vehicleApproval.setBranchManagerName(1);
        } else {

            vehicleApproval.setBranchManagerName(((User) request.getSession().getAttribute("user")).getUid());
        }
        vehicleApproval.setBranchManagerApprovalDate(new Date());

        Session s = null;
        try {
            s = HibernateSessionFactory.getSession();
            Query q_us = s.createQuery("from RelationUr where rid in (select rid from Role where rname = '保险员' ");
            List<RelationUr> users = q_us.list();
            for (RelationUr relationUr : users) {
                User user = userDao.getUserByUid(relationUr.getUid());
                String msg = "[哈尔滨大众:" + user.getUname() + "]";
                if (vehicleApproval.getCheckType() == 0) {//开业审批
                    msg += "您有一个开业审批未处理!";
                } else {
                    msg += "您有一个废业审批未处理!";
                }
                DuanXin duanxin = new DuanXin();
                duanxin.setBody(msg);
                duanxin.setPhone(user.getPhone());
                duanXinDao.addDuanXin(duanxin);
            }
        } catch (HibernateException e) {

        }
        postSMS("保险员", vehicleApproval);
        return vehicleApprovalDao.addVehicleApproval(vehicleApproval);
    }

    public void postSMS(String rname, VehicleApproval vehicleApproval) {
        Session s = null;
        try {
            s = HibernateSessionFactory.getSession();
            Query q_us = s.createQuery("from RelationUr where rid in (select rid from Role where rname = '保险员' ");
            List<RelationUr> users = q_us.list();
            for (RelationUr relationUr : users) {
                User user = userDao.getUserByUid(relationUr.getUid());
                String msg = "[哈尔滨大众:" + user.getUname() + "]";
                if (vehicleApproval.getCheckType() == 0) {//开业审批
                    msg += "您有一个开业审批未处理!";
                } else {
                    msg += "您有一个废业审批未处理!";
                }
                DuanXin duanxin = new DuanXin();
                duanxin.setBody(msg);
                duanxin.setPhone(user.getPhone());
                duanXinDao.addDuanXin(duanxin);
            }
        } catch (HibernateException e) {
        }
    }

    /**
     * 更新审批单
     *
     * @param _vehicleApproval
     * @return
     */
    public boolean updateVehicleApproval(VehicleApproval _vehicleApproval) {
        HttpServletRequest request = null;
        int uName = 1;

        VehicleApproval vehicleApproval = vehicleApprovalDao.queryVehicleApprovalById(_vehicleApproval.getId());
        int state = vehicleApproval.getState();

        Contract contract = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", vehicleApproval.getContractId());

        if (BooleanUtils.isTrue(contract.getGeneByImport())) {
            request = new HttpServletRequest() {
                @Override
                public AsyncContext getAsyncContext() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Object getAttribute(String name) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Enumeration<String> getAttributeNames() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getCharacterEncoding() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public int getContentLength() {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public long getContentLengthLong() {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public String getContentType() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public DispatcherType getDispatcherType() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public ServletInputStream getInputStream() throws IOException {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getLocalAddr() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getLocalName() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public int getLocalPort() {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public Locale getLocale() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Enumeration<Locale> getLocales() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getParameter(String name) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Map<String, String[]> getParameterMap() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Enumeration<String> getParameterNames() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String[] getParameterValues(String name) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getProtocol() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public BufferedReader getReader() throws IOException {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getRealPath(String path) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getRemoteAddr() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getRemoteHost() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public int getRemotePort() {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public RequestDispatcher getRequestDispatcher(String path) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getScheme() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getServerName() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public int getServerPort() {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public ServletContext getServletContext() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public boolean isAsyncStarted() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public boolean isAsyncSupported() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public boolean isSecure() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public void removeAttribute(String name) {
                    // TODO Auto-generated method stub

                }

                @Override
                public void setAttribute(String name, Object o) {
                    // TODO Auto-generated method stub

                }

                @Override
                public void setCharacterEncoding(String env)
                        throws UnsupportedEncodingException {
                    // TODO Auto-generated method stub

                }

                @Override
                public AsyncContext startAsync() throws IllegalStateException {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public AsyncContext startAsync(ServletRequest servletRequest,
                                               ServletResponse servletResponse)
                        throws IllegalStateException {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public boolean authenticate(HttpServletResponse response)
                        throws IOException, ServletException {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public String changeSessionId() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getAuthType() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getContextPath() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Cookie[] getCookies() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public long getDateHeader(String name) {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public String getHeader(String name) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Enumeration<String> getHeaderNames() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Enumeration<String> getHeaders(String name) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public int getIntHeader(String name) {
                    // TODO Auto-generated method stub
                    return 0;
                }

                @Override
                public String getMethod() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Part getPart(String name) throws IOException,
                        ServletException {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Collection<Part> getParts() throws IOException,
                        ServletException {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getPathInfo() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getPathTranslated() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getQueryString() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getRemoteUser() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getRequestURI() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public StringBuffer getRequestURL() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getRequestedSessionId() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public String getServletPath() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public HttpSession getSession() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public HttpSession getSession(boolean create) {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public Principal getUserPrincipal() {
                    // TODO Auto-generated method stub
                    return null;
                }

                @Override
                public boolean isRequestedSessionIdFromCookie() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public boolean isRequestedSessionIdFromURL() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public boolean isRequestedSessionIdFromUrl() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public boolean isRequestedSessionIdValid() {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public boolean isUserInRole(String role) {
                    // TODO Auto-generated method stub
                    return false;
                }

                @Override
                public void login(String username, String password)
                        throws ServletException {
                    // TODO Auto-generated method stub

                }

                @Override
                public void logout() throws ServletException {
                    // TODO Auto-generated method stub

                }

                @Override
                public <T extends HttpUpgradeHandler> T upgrade(
                        Class<T> handlerClass) throws IOException,
                        ServletException {
                    // TODO Auto-generated method stub
                    return null;
                }

            };
        } else {
            request = ServletActionContext.getRequest();
            uName = ((User) request.getSession().getAttribute("user")).getUid();
        }

        if (vehicleApproval.getCheckType() == 0) {
            if (state == 6)//综合办公室审批
            {
                vehicleApproval.setApprovalOfficeDate(new Date());
                vehicleApproval.setState(8);
                vehicleApproval.setOfficeName(uName);
                vehicleApproval.setOfficeRemark(_vehicleApproval.getOfficeRemark());
                vehicleApproval.setIsapprovalOffice(_vehicleApproval.getIsapprovalOffice());

//				contractDao.changeState(_vehicleApproval.getContractId(),3);

                Session session = null;
                Transaction tx = null;
                try {
                    session = HibernateSessionFactory.getSession();
                    tx = session.beginTransaction();
                    Contract cx = (Contract) session.get(Contract.class, _vehicleApproval.getContractId());
                    cx.setState((short) 3);
                    session.update(cx);

                    Message msg = new Message();
                    User u = (User) session.get(User.class, uName);
                    msg.setFromUser(uName);
                    msg.setTime(new Date());

                    msg.setCarframeNum(contract.getCarframeNum());
                    msg.setIdNum(contract.getIdNum());
                    msg.setType("开业流程完毕");

                    Driver d = (Driver) session.get(Driver.class, contract.getIdNum());

                    msg.setMsg(String.format("%tF %s发：\n"
                                    + "现有车%s(%s) 承包人 %s(%s) 开业流程已完毕，可进行合同录入。",
                            msg.getTime(), u.getUname(),
                            contract.getCarNum(), contract.getCarframeNum(), d.getName(), contract.getIdNum()));

                    session.save(msg);

                    Query q_u = session.createQuery("from RelationUr where "
                            + "rid in (select rid from Role where rname = :rname )");

                    q_u.setString("rname", "办公室主任");
                    List<RelationUr> users = q_u.list();
                    for (RelationUr relationUr : users) {
                        MessageToUser mu = new MessageToUser();
                        mu.setUid(relationUr.getUid());
                        mu.setMid(msg.getId());
                        mu.setAlreadyRead(false);
                        session.saveOrUpdate(mu);
                    }
                    session.update(vehicleApproval);

                    tx.commit();
                } catch (HibernateException e) {
                    e.printStackTrace();
                    if (tx != null) {
                        tx.rollback();
                    }
                    return false;
                } finally {
                    HibernateSessionFactory.closeSession();
                }


                return true;
            } else if (state == 3)//计财部审批
            {
                vehicleApproval.setApprovalFinanceDate(new Date());
                vehicleApproval.setState(4);
                vehicleApproval.setFinanceName(uName);
                vehicleApproval.setFinanceRemark(_vehicleApproval.getFinanceRemark());
                vehicleApproval.setIsapprovalFinance(_vehicleApproval.getIsapprovalFinance());
                return vehicleApprovalDao.executeUpdate(vehicleApproval);
            } else if (state == 4)//计财部审批
            {
                if (!BooleanUtils.isTrue(contract.getGeneByImport())) {
                    String rentStr = request.getParameter("contract.rent");
                    if (StringUtils.isNotBlank(rentStr)) {
                        double rent = NumberUtils.toDouble(rentStr);
                        contract.setRent(rent);
                        ObjectAccess.saveOrUpdate(contract);
                    }
                }

                vehicleApproval.setFinanceManagerApprovalDate(new Date());
                vehicleApproval.setState(5);
                vehicleApproval.setFinanceManagerName(uName);
                vehicleApproval.setFinanceManagerRemark(_vehicleApproval.getFinanceManagerRemark());
                vehicleApproval.setIsapprovalFinanceManager(_vehicleApproval.getIsapprovalFinanceManager());
                return vehicleApprovalDao.executeUpdate(vehicleApproval);
            }
//			else if(state==4)//运营管理部-分部经理审批
//			{
//				vehicleApproval.setBranchManagerApprovalDate(new java.util.Date());
//				vehicleApproval.setState(5);
//				vehicleApproval.setBranchManagerName(uName);
//				vehicleApproval.setBranchManagerRemark(_vehicleApproval.getBranchManagerRemark());
//				vehicleApproval.setIsapprovalBranchManager(_vehicleApproval.getIsapprovalBranchManager());
//				return vehicleApprovalDao.executeUpdate(vehicleApproval);
//			}
            else if (state == 1)//运营管理部-保险管理员审批
            {
                String carframeNum = contract.getCarframeNum();
                if (StringUtils.isEmpty(carframeNum)) {
                    request.setAttribute("msgStr", "未绑定承租人，请至车辆管理-新增-绑定承租人操作此项功能。");
                    return false;
                }

                Vehicle ve = ObjectAccess.getObject(Vehicle.class, carframeNum);
                if (ve == null) {
                    request.setAttribute("msgStr", "车架号错误。");
                    return false;
                }
                if (ve.getLicensePurseNum() == null) {
                    request.setAttribute("msgStr", "牌照信息未录入，请先补充牌照信息。");
                    return false;
                }

                if (ve.getLicensePurseNum().matches("^黑\\w{6}")) {
                    Vehicle ov = ObjectAccess.getObject(Vehicle.class, ve.getLicensePurseNum());
                    if (ov != null && ov.getState() < 2) {
                        request.setAttribute("msgStr", "原车尚未完成废业，请先完成废业流程。");
                        return false;
                    }
                }

                List<Insurance> ilist = ObjectAccess.query(Insurance.class, " carframeNum='" + contract.getCarframeNum() + "'");
                boolean hasJQX = false, hasSX = false;
                for (Insurance insurance : ilist) {
                    if (StringUtils.contains(insurance.getInsuranceClass(), "强险")) {
                        if (new Date().before(insurance.getEndDate())) {
                            hasJQX = true;
                        }
                    } else if (StringUtils.contains(insurance.getInsuranceClass(), "商业保险")) {
                        if (new Date().before(insurance.getEndDate())) {
                            hasSX = true;
                        }
                    }
                }


                if (!hasJQX) {
                    request.setAttribute("msgStr", "交强险未录入，无法审批。");
                    return false;
                }

                if (!hasSX) {
                    request.setAttribute("msgStr", "商险未录入，无法审批。");
                    return false;
                }

                vehicleApproval.setAssurerApprovalDate(new Date());
                vehicleApproval.setState(2);
                vehicleApproval.setAssurerName(uName);
                vehicleApproval.setAssurerRemark(_vehicleApproval.getAssurerRemark());
                vehicleApproval.setIsapprovalAssurer(_vehicleApproval.getIsapprovalAssurer());

                vehicleApproval.setDamageInsurance(_vehicleApproval.getDamageInsurance());
                vehicleApproval.setOnetimeAfterpay(_vehicleApproval.getOnetimeAfterpay());
                vehicleApproval.setPayBeginDate(_vehicleApproval.getPayBeginDate());
                vehicleApproval.setPayEndDate(_vehicleApproval.getPayEndDate());

                return vehicleApprovalDao.executeUpdate(vehicleApproval);
            } else if (state == 2)//运营管理部-部门经理审批
            {
//				String carframeNum = contract.getCarframeNum();
//				if(StringUtils.isEmpty(carframeNum)){
//					request.setAttribute("msgStr", "车辆信息未录入，无法审批。");
//					return false;
//				}
//
//				List<Insurance> ilist = ObjectAccess.query(Insurance.class, " carframeNum='"+contract.getCarframeNum()+"'");
//				boolean hasJQX=false,hasSX = false;
//				for(Insurance insurance:ilist){
//					if(StringUtils.equalsIgnoreCase(insurance.getInsuranceClass(),"交强险")){
//						if(new Date().before(insurance.getEndDate())){
//							hasJQX = true;
//						}
//					}else if (StringUtils.equalsIgnoreCase(insurance.getInsuranceClass(), "商业保险单")) {
//						if(new Date().before(insurance.getEndDate())){
//							hasSX = true;
//						}
//					}
//				}
//
//				if(!hasJQX){
//					request.setAttribute("msgStr", "交强险未录入，无法审批。");
//					return false;
//				}
//
//				if(!hasSX){
//					request.setAttribute("msgStr", "商险未录入，无法审批。");
//					return false;
//				}
//
//				if(vehicleApproval.getOperateCardDate()==null){
//					request.setAttribute("msgStr", "营运信息未录入，无法审批。");
//					return false;
//				}

                vehicleApproval.setManagerApprovalDate(new Date());
                vehicleApproval.setState(7);
                vehicleApproval.setManagerName(uName);
                vehicleApproval.setManagerRemark(_vehicleApproval.getManagerRemark());
                vehicleApproval.setIsapprovalManager(_vehicleApproval.getIsapprovalManager());
                return vehicleApprovalDao.executeUpdate(vehicleApproval);
            } else if (state == 5)//主管副总经理审批
            {
                String carframeNum = contract.getCarframeNum();
                if (StringUtils.isEmpty(carframeNum)) {
                    request.setAttribute("msgStr", "车辆信息未录入，无法审批。");
                    return false;
                }

                List<Insurance> ilist = ObjectAccess.query(Insurance.class, " carframeNum='" + contract.getCarframeNum() + "'");
                boolean hasJQX = false, hasSX = false;
                for (Insurance insurance : ilist) {
                    if (StringUtils.contains(insurance.getInsuranceClass(), "强险")) {
                        if (new Date().before(insurance.getEndDate())) {
                            hasJQX = true;
                        }
                    } else if (StringUtils.contains(insurance.getInsuranceClass(), "商业保险")) {
                        if (new Date().before(insurance.getEndDate())) {
                            hasSX = true;
                        }
                    }
                }

                if (!hasJQX) {
                    request.setAttribute("msgStr", "交强险未录入，无法审批。");
                    return false;
                }

                if (!hasSX) {
                    request.setAttribute("msgStr", "商险未录入，无法审批。");
                    return false;
                }

//				if(vehicleApproval.getOperateCardDate()==null){
//					request.setAttribute("msgStr", "营运信息未录入，无法审批。");
//					return false;
//				}

                vehicleApproval.setApprovalDirectorDate(new Date());
                vehicleApproval.setState(6);
                vehicleApproval.setDirectorName(uName);
                vehicleApproval.setDirectorRemark(_vehicleApproval.getDirectorRemark());
                vehicleApproval.setIsapprovalDirector(_vehicleApproval.getIsapprovalDirector());
                vehicleApproval.setDiscountDays(_vehicleApproval.getDiscountDays());

                contract.setDiscountDays(vehicleApproval.getDiscountDays());
                ObjectAccess.saveOrUpdate(contract);

//				contractDao.changeState(_vehicleApproval.getContractId(),3);

                return vehicleApprovalDao.executeUpdate(vehicleApproval);
            } else
                return false;
        } else if (vehicleApproval.getCheckType() == 1) {

            if (state == 1) {
                //contract.setAbandonedTime(contract.getAbandonedTime() == null?new Date():contract.getAbandonedTime());
                ObjectAccess.saveOrUpdate(contract);
                vehicleApproval.setAssurerRemark(_vehicleApproval.getAssurerRemark());
                vehicleApproval.setAssurerName(uName);
                vehicleApproval.setAssurerApprovalDate(new Date());
                vehicleApproval.setIsapprovalAssurer(_vehicleApproval.getIsapprovalAssurer());
                vehicleApproval.setState(3);//直接跳过收款员
            } else if (state == 2) {
                vehicleApproval.setCashierRemark(_vehicleApproval.getCashierRemark());
                vehicleApproval.setCashierName(uName);
                vehicleApproval.setCashierApprovalDate(new Date());
                vehicleApproval.setState(3);
            } else if (state == 3) {
                String carframeNum = contract.getCarframeNum();

                long count = ObjectAccess.execute(String.format("select count(*) from Accident where carId='%s' and status!=3 ", carframeNum));
                if (count > 0) {
                    request.setAttribute("msgStr", "有事故未处理，无法继续审批。");
                    return false;
                }

                vehicleApproval.setManagerRemark(_vehicleApproval.getManagerRemark());
                vehicleApproval.setManagerName(uName);
                vehicleApproval.setManagerApprovalDate(new Date());
                vehicleApproval.setState(4);
                vehicleApproval.setIsapprovalManager(_vehicleApproval.getIsapprovalManager());
            } else if (state == 4) {
                vehicleApproval.setOfficeRemark(_vehicleApproval.getOfficeRemark());
                vehicleApproval.setOfficeName(uName);
                vehicleApproval.setApprovalOfficeDate(new Date());
                vehicleApproval.setState(5);
                vehicleApproval.setIsapprovalOffice(_vehicleApproval.getIsapprovalOffice());
            } else if (state == 5) {
                vehicleApproval.setFinanceRemark(_vehicleApproval.getFinanceRemark());
                vehicleApproval.setFinanceName(uName);
                vehicleApproval.setApprovalFinanceDate(new Date());
                vehicleApproval.setState(6);
                vehicleApproval.setIsapprovalFinance(_vehicleApproval.getIsapprovalFinance());
            } else if (state == 6) {
                String rentStr = request.getParameter("contract.rent");
                if (StringUtils.isNotBlank(rentStr)) {
                    double rent = NumberUtils.toDouble(rentStr);
                    contract.setRent(rent);
                    ObjectAccess.saveOrUpdate(contract);
                }

                vehicleApproval.setFinanceManagerRemark(_vehicleApproval.getFinanceManagerRemark());
                vehicleApproval.setFinanceManagerName(uName);
                vehicleApproval.setFinanceManagerApprovalDate(new Date());
                vehicleApproval.setState(7);
                vehicleApproval.setIsapprovalFinanceManager(_vehicleApproval.getIsapprovalFinanceManager());
            } else if (state == 7) {
                vehicleApproval.setDirectorRemark(_vehicleApproval.getDirectorRemark());
                vehicleApproval.setDirectorName(uName);
                vehicleApproval.setApprovalDirectorDate(new Date());
                vehicleApproval.setState(3);
                vehicleApproval.setIsapprovalDirector(_vehicleApproval.getIsapprovalDirector());

                Vehicle vehicle = ObjectAccess.getObject(Vehicle.class, contract.getCarframeNum());

                String strT = request.getParameter("contract.abandonedChargeTime");
                if (StringUtils.isNotBlank(strT)) {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");
                    try {
                        Date abandonedChargeTime = df.parse(strT);
                        contract.setAbandonedChargeTime(abandonedChargeTime);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }

                Session session = HibernateSessionFactory.getSession();
                Transaction tx = null;

                try {
                    tx = session.beginTransaction();

                    vehicle.setDriverId(null);

                    if (vehicleApproval.getHandleMatter()) {
                        vehicle.setState(3);
                    } else {
                        vehicle.setState(2);
                        if (contract.getAbandonedTime() == null) {
                            contract.setAbandonedTime(contract.getContractEndDate());
                        }

                        //附加提前废业后的调整 -305-25
                        Calendar sp = Calendar.getInstance();
                        sp.setTime(contract.getAbandonedTime());

                        Calendar endTime = Calendar.getInstance();
                        endTime.setTime(contract.getContractEndDate());

                        sp.add(Calendar.MONTH, 1);

                        int amount = 0;

                        while (sp.before(endTime)) {
                            sp.add(Calendar.MONTH, 1);
                            if (sp.after(endTime)) {
                                if (endTime.get(Calendar.DATE) >= 20) {
                                    amount += 306 + 25;
                                }
                                break;
                            } else {
                                amount += 306 + 25;
                            }
                        }

                        sp.setTime(contract.getAbandonedTime());
                        if (sp.get(Calendar.DATE) > 26) {
                            sp.add(Calendar.MONTH, 1);
                        }
                        sp.set(Calendar.DATE, 1);

                        ChargePlan tplan = new ChargePlan();
                        tplan.setContractId(contract.getId());
                        tplan.setFee(BigDecimal.valueOf(amount));
                        tplan.setFeeType("plan_sub_contract");
                        tplan.setInTime(new Date());
                        tplan.setComment("提前废业时的306,25");
                        tplan.setTime(sp.getTime());
                        tplan.setIsClear(false);
                        session.save(tplan);


                        chargeDao.planTransfer(contract.getId(), DateUtil.getNextMonth(contract.getAbandonedTime()), contract.getId(), contract.getAbandonedTime());
                        List<String> dl = Arrays.<String>asList(vehicle.getFirstDriver(), vehicle.getSecondDriver(), vehicle.getThirdDriver(), vehicle.getTempDriver());

                        for (int i = 0; i < dl.size(); i++) {
                            String idNum = dl.get(i);
                            if (!StringUtils.isEmpty(idNum)) {
                                Driver d = (Driver) session.get(Driver.class, idNum);
                                if (d != null && d.getDriverClass() != null) {
                                    if (d.getDriverClass().equals("主驾")) {
                                        vehicle.setFirstDriver(null);
                                    } else if (d.getDriverClass().equals("副驾")) {
                                        vehicle.setSecondDriver(null);
                                    } else if (d.getDriverClass().equals("三驾")) {
                                        vehicle.setThirdDriver(null);
                                    } else if (d.getDriverClass().equals("临驾")) {
                                        vehicle.setTempDriver(null);
                                    }


                                    Driverincar record = new Driverincar(d.getCarframeNum(), d.getIdNum(), "下车", new Date());
                                    record.setFinished(true);
                                    session.saveOrUpdate(record);

                                    Query q_di = session.createQuery("update Driverincar set finished=true where carframeNum=:carframeNum and idNumber=:idNumber and (operation='证照注销' or operation='下车' ) and finished=false");
                                    q_di.setString("carframeNum", d.getCarframeNum());
                                    q_di.setString("idNumber", d.getIdNum());
                                    q_di.executeUpdate();

                                    //driverService.addDriverInCarRecord(record);

                                    d.setIsInCar(false);

                                    d.setRestTime(null);
                                    d.setCarframeNum(null);
                                    d.setDriverClass(null);
                                    d.setBusinessApplyTime(null);
                                    d.setBusinessApplyRegistrant(null);
                                    d.setBusinessApplyRegistTime(null);

                                    d.setBusinessReciveTime(null);
                                    d.setBusinessReciveRegistrant(null);
                                    d.setBusinessReciveRegistTime(null);

                                    d.setBusinessApplyCancelTime(null);
                                    d.setBusinessApplyCancelRegistrant(null);
                                    d.setBusinessApplyCancelRegistTime(null);

                                    d.setDept(null);
                                    d.setStatus(4);

                                    session.saveOrUpdate(d);
                                }
                            }
                        }

//					contract.setAbandonedFinalTime(new Date());
                    }

//				switch(contract.getAbandonReason()){
//				case "合同终止":
//					vehicle.setState(2);
//					break;
//				case "欠费":
//				case "转租":
//					vehicle.setState(3);
//					break;
//				}

                    contract.setState((short) 1);

                    session.saveOrUpdate(vehicle);
                    session.saveOrUpdate(contract);

                    session.saveOrUpdate(vehicleApproval);

                    //contractDao.changeState(_vehicleApproval.getContractId(),1);
                    Message msg = new Message();
                    User u = (User) session.get(User.class, uName);
                    msg.setFromUser(uName);
                    msg.setTime(new Date());

                    msg.setCarframeNum(contract.getCarframeNum());
                    msg.setIdNum(contract.getIdNum());
                    msg.setType("废业流程完毕");

                    Driver d = (Driver) session.get(Driver.class, contract.getIdNum());

                    msg.setMsg(String.format("%tF %s发：\n"
                                    + "现有车%s(%s) 承包人 %s(%s) 废业流程已完毕，可进行开业申请。",
                            msg.getTime(), u.getUname(),
                            contract.getCarNum(), contract.getCarframeNum(), d.getName(), contract.getIdNum()));

                    session.save(msg);

                    Query q_u = session.createQuery("from RelationUr where "
                            + "rid in (select rid from Role where rname = :rname )"
                            + "and uid in (select uid from User where position like :position)");

                    q_u.setString("rname", "分部经理");
                    q_u.setString("position", "%" + contract.getBranchFirm().trim().charAt(0) + "%");
                    List<RelationUr> users = q_u.list();
                    for (RelationUr relationUr : users) {
                        MessageToUser mu = new MessageToUser();
                        mu.setUid(relationUr.getUid());
                        mu.setMid(msg.getId());
                        mu.setAlreadyRead(false);
                        session.saveOrUpdate(mu);
                    }

                    tx.commit();
                    return true;
                } catch (HibernateException ex) {
                    ex.printStackTrace();
                    if (tx != null)
                        tx.rollback();

                } finally {
                    session.flush();
                    HibernateSessionFactory.closeSession();
                }
                return false;
            }

            return vehicleApprovalDao.executeUpdate(vehicleApproval);
        } else {
            return false;
        }
    }

    @Autowired
    private ChargeDao chargeDao;
    @Autowired
    private DriverService driverService;

    public void setDriverService(DriverService driverService) {
        this.driverService = driverService;
    }

    public VehicleApproval queryVehicleApprovalById(Integer approvalId) {
        return vehicleApprovalDao.queryVehicleApprovalById(approvalId);
    }

    public VehicleApproval queryVehicleApprovalByContractId(Integer contractId) {
        return vehicleApprovalDao.queryVehicleApprovalByContractId(contractId);
    }

    public void setContractDao(ContractDao contractDao) {
        this.contractDao = contractDao;
    }

    public void setVehicleApprovalDao(VehicleApprovalDao vehicleApprovalDao) {
        this.vehicleApprovalDao = vehicleApprovalDao;
    }

    @SuppressWarnings("unchecked")
//	@Override
    public Map<String, List<ToDo>> waitToDo(Role role) {
        Map<String, List<ToDo>> map = new TreeMap<String, List<ToDo>>();
        List<ToDo> toDolist = new ArrayList<ToDo>();
        List<VehicleApproval> approvalList;

        switch (role.getRname()) {
            case "分部经理":
                break;
            case "运营部经理":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 0, 2);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer()));
                break;
            case "副总经理":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 0, 5);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer()));
                break;
            case "保险员":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 0, 1);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer()));
                break;
            case "收款员":

                break;
            case "财务负责人":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 0, 3);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer()));
                break;
            case "财务经理":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 0, 4);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer()));
                break;
            case "办公室主任":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 0, 6);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer()));
                break;
            case "证照员":

                break;
            default:
                break;
        }
        map.put("开业审批", toDolist);

        toDolist = new ArrayList<ToDo>();
        switch (role.getRname()) {
            case "分部经理":
                break;
            case "运营部经理":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1, 3);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "副总经理":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1, 7);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "保险员":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1, 1);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "收款员":
                //approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1,2);
                //toDolist.addAll((List<ToDo>) CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "财务负责人":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1, 5);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "财务经理":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1, 6);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "办公室主任":
                approvalList = vehicleApprovalDao.queryVehicleApprovalByState((short) 1, 4);
                toDolist.addAll(CollectionUtils.collect(approvalList, new VehicleApprovalWaitDealTransformer("废业审批")));
                break;
            case "证照员":
                break;
            default:
                break;
        }
        map.put("废业审批", toDolist);

        return map;
    }


    private static class VehicleApprovalWaitDealTransformer implements Transformer {
        private String base;

        public VehicleApprovalWaitDealTransformer() {
            this("开业审批");
        }

        public VehicleApprovalWaitDealTransformer(String base) {
            this.base = base;
        }

        @Override
        public Object transform(Object arg0) {
            VehicleApproval comp = (VehicleApproval) arg0;
            String msg = base + geneMsg(comp);

            return new ToDo(msg, "待审核", "/DZOMS/vehicle/vehicleApprovalPreUpdate.action?vehicleApproval.id=" + comp.getId());
        }

        protected String geneMsg(VehicleApproval comp) {
            String msg = "";
            try {
                int cid = comp.getContractId();
                Contract c = (Contract) ObjectAccess.getObject("com.dz.module.contract.Contract", cid);
                List<String> sl = new ArrayList<String>();

                if (StringUtils.isNotEmpty(c.getCarframeNum()))
                    sl.add("车架号:" + c.getCarframeNum());
                if (StringUtils.isNotEmpty(c.getCarNum()))
                    sl.add("车牌号:" + c.getCarNum());
                if (StringUtils.isNotEmpty(c.getIdNum())) {
                    Driver d = (Driver) ObjectAccess.getObject("com.dz.module.driver.Driver", c.getIdNum());
                    sl.add("承租人:" + d.getName());
                }

                msg = sl.toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return msg;
        }
    }
}
