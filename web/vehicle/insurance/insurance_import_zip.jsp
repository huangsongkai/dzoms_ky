<%@ page import="com.dz.common.other.FileUploadUtil" %>
<%@ page import="com.dz.module.vehicle.Insurance" %>
<%@ page import="com.dz.module.vehicle.InsuranceDao" %>
<%@ page import="com.dz.module.vehicle.InsurancePdfReader" %>
<%@ page import="com.dz.module.vehicle.MailReceiver" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.zip.ZipInputStream" %>
<%@ page import="java.util.zip.ZipEntry" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private static byte[] readInputStream(InputStream inputStream) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        try {
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return outputStream.toByteArray();
    }
%>
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
        try(ZipInputStream zipInputStream = new ZipInputStream(inputStream)) {
            ZipEntry entry;

            while ((entry = zipInputStream.getNextEntry()) != null) {
                if (!entry.isDirectory()) {
                    String fileName = entry.getName();
                    if (fileName.endsWith(".pdf")){
                        byte[] bytes = readInputStream(zipInputStream);
                        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

                        Insurance insurance = InsurancePdfReader.loadPdf(byteArrayInputStream);
                        if (insurance == null) continue;
                        insurance.setFilename(fileName);
                        insuranceDao.addInsurance(insurance, mailReceiver.config.isOverride());

                        byteArrayInputStream.reset();
                        FileUtils.copyInputStreamToFile(byteArrayInputStream, new File(basePath,fileName));
                    }
                }
                zipInputStream.closeEntry();
            }
            message = "上传成功！";
        } catch (IOException e) {
            message = "上传失败，原因是："+ e.getMessage();
        }
    } catch (IOException e) {
        message = "上传失败，原因是："+ e.getMessage();
    }

    request.setAttribute("msgStr", message);
    request.getRequestDispatcher(url).forward(request, response);
%>
