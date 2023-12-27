<%@ page import="com.dz.common.other.FileUploadUtil" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="com.dz.module.charge.jiaotong.JiaotongService" %>
<%@ page import="com.dz.module.charge.jiaotong.Payment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.jiaotong.JiaoTongBankRecord" %><%@ page import="com.dz.module.vehicle.Vehicle"%><%@ page import="com.dz.common.factory.HibernateSessionFactory"%><%@ page import="org.hibernate.*"%><%@ page import="java.io.PrintWriter"%><%@ page import="java.util.regex.Pattern"%><%@ page import="com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException"%>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%
    String fileId = request.getParameter("fileId");
    StringBuilder message = new StringBuilder();

    PrintWriter writer = new PrintWriter(out);

//    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
//    JiaotongService jiaotongService = ctx.getBean(JiaotongService.class);

    String regex = "[\\x{1F600}-\\x{1F64F}\\x{1F300}-\\x{1F5FF}\\x{1F680}-\\x{1F6FF}\\x{1F700}-\\x{1F77F}\\x{1F780}-\\x{1F7FF}\\x{1F800}-\\x{1F8FF}\\x{1F900}-\\x{1F9FF}\\x{1FA00}-\\x{1FA6F}\\x{2600}-\\x{26FF}\\x{2700}-\\x{27BF}\\x{2B05}-\\x{2B07}\\x{2934}\\x{2935}\\x{2B06}\\x{2194}-\\x{2199}\\x{2B50}\\x{1F004}\\x{1F0CF}\\x{1F18E}\\x{3030}\\x{303D}\\x{3297}\\x{3299}\\x{1F004}\\x{1F0CF}\\x{1F18E}\\x{3030}\\x{303D}\\x{3297}\\x{3299}\\x{203C}\\x{2049}\\x{1F251}\\x{25AA}\\x{25AB}\\x{25B6}\\x{25C0}\\x{25FB}\\x{25FD}\\x{25FE}\\x{2600}\\x{2601}\\x{2602}\\x{2603}\\x{2604}\\x{260E}\\x{2611}\\x{2614}\\x{2615}\\x{261D}\\x{2620}\\x{2622}\\x{2623}\\x{2626}\\x{262A}\\x{262E}\\x{262F}\\x{2638}-\\x{263A}\\x{2640}\\x{2642}\\x{2648}-\\x{2653}\\x{2660}\\x{2663}\\x{2665}\\x{2666}\\x{2668}\\x{267B}\\x{267F}\\x{2692}\\x{2693}\\x{2694}\\x{2696}\\x{2697}\\x{2699}\\x{269B}\\x{269C}\\x{26A0}\\x{26A1}\\x{26AA}\\x{26AB}\\x{26B0}\\x{26B1}\\x{26BD}\\x{26BE}\\x{26C4}\\x{26C5}\\x{26C8}\\x{26CE}\\x{26CF}\\x{26D1}\\x{26D3}\\x{26D4}\\x{26E9}\\x{26EA}\\x{26F0}\\x{26F1}\\x{26F2}\\x{26F3}\\x{26F4}\\x{26F5}\\x{26F7}\\x{26F8}\\x{26F9}\\x{26FA}\\x{26FD}\\x{2702}\\x{2705}\\x{2708}\\x{2709}\\x{270A}\\x{270B}\\x{270C}\\x{270D}\\x{270F}\\x{2712}\\x{2714}\\x{2716}\\x{271D}\\x{2721}\\x{2728}\\x{2733}\\x{2734}\\x{2744}\\x{2747}\\x{274C}\\x{274E}\\x{2753}\\x{2754}\\x{2755}\\x{2757}\\x{2763}\\x{2764}\\x{2765}\\x{2795}\\x{2796}\\x{2797}\\x{27A1}\\x{27B0}\\x{27BF}\\x{2934}\\x{2935}\\x{2B05}-\\x{2B07}\\x{2B1B}\\x{2B1C}\\x{2B50}\\x{2B55}\\x{1F004}\\x{1F0CF}\\x{1F18E}\\x{3030}\\x{303D}\\x{3297}\\x{3299}]+";
//    Pattern emoji = Pattern.compile(regex);

    InputStream inputStream = null;
    Session hsession = null;
    Transaction tx = null;
    try {
        hsession = HibernateSessionFactory.getSession();
        tx = hsession.beginTransaction();
        final Query matchLicenseNum = hsession.createQuery("from Vehicle where licenseNum=:num order by inDate desc");
        matchLicenseNum.setMaxResults(1);

        inputStream = FileUploadUtil.getFileStream(fileId);
        List<Payment> payments = JiaotongService.loadFromInputStream(inputStream);
        for (Payment payment : payments) {
            payment.setAdditionalInfo(payment.getAdditionalInfo().replaceAll(regex,""));
            JiaoTongBankRecord record = JiaotongService.asRecord(payment);
            if (record != null) {
                JiaoTongBankRecord old = (JiaoTongBankRecord) hsession.get(JiaoTongBankRecord.class, record.getOrderNo());
                if (old == null){
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
                        hsession.save(record);
                    } catch (NonUniqueObjectException ignore){}

                    message.append(String.format("%s,%s,%s,%s,%s,%s\n",
                        record.getOrderNo(),record.getCarNo(), record.getMonth(), record.getComment(), record.getState(), record.getReason()));
                } else {
                     message.append(String.format("数据已存在：%s,%s,%s,%s,%s,%s\n",
                        old.getOrderNo(),old.getCarNo(), old.getMonth(), old.getComment(), old.getState(), old.getReason()));
                }
            }
            else{
                message.append(String.format("数据转换失败：%s,%s\n", payment.getOrderNo(),payment.getAdditionalInfo()));
            }
        }
        tx.commit();
    } catch (Exception e) {
        e.printStackTrace(writer);
        message.append("上传失败，原因是："+ e.getMessage());
        try {
                if (tx!=null){
                    tx.rollback();
                }
            }catch (TransactionException ex){
                ex.printStackTrace();
                message.append("数据库操作失败，原因是："+ ex.getMessage());
            }
    } finally{
         HibernateSessionFactory.closeSession();
    }

//    request.setAttribute("msgStr", message.toString());
%>
<%=message.toString()%>