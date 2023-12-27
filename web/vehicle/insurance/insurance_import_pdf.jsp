<%@ page import="com.dz.common.other.FileUploadUtil" %>
<%@ page import="com.dz.module.vehicle.Insurance" %>
<%@ page import="com.dz.module.vehicle.InsuranceDao" %>
<%@ page import="com.dz.module.vehicle.InsurancePdfReader" %>
<%@ page import="com.dz.module.vehicle.MailReceiver" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = request.getParameter("url");
    String fileId = request.getParameter("fileId");

    String basePath = System.getProperty("com.dz.root") +"data/insurance/";

    String message = "";

    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
    InsuranceDao insuranceDao = ctx.getBean(InsuranceDao.class);
    MailReceiver mailReceiver = ctx.getBean(MailReceiver.class);
    mailReceiver.loadConfig();

    InputStream inputStream = null;
    try {
        inputStream = FileUploadUtil.getFileStream(fileId);
        Insurance insurance = InsurancePdfReader.loadPdf(inputStream);
        if (insurance != null){
            Map<String,String> map = (Map<String,String>)request.getServletContext().getAttribute("TempFileMap");
            String fileName = "";
            if (map == null || !map.containsKey(fileId)){
                fileName = map.get(fileId);
            }else {
                fileName = insurance.getInsuranceNum() + ".pdf";
            }
//            insurance.setFilename(fileName);
            insurance.setFilename(insurance.getInsuranceNum()+".pdf");
            boolean notOverride = insuranceDao.addInsurance(insurance, mailReceiver.config.isOverride());
            FileUploadUtil.store(fileId,new File(basePath,insurance.getInsuranceNum()+".pdf"));
            if (!notOverride){
                message = "该保险信息"+insurance.getInsuranceNum()+"已存在！";
            }else {
                message = "上传成功！";
            }
        }else {
            message = "文件识别失败！";
        }
    } catch (IOException e) {
        message = "上传失败，原因是："+ e.getMessage();
    }

    request.setAttribute("msgStr", message);
    request.getRequestDispatcher(url).forward(request, response);
%>
