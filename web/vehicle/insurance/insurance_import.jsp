<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java"
         import="com.dz.common.other.ObjectAccess,com.dz.module.vehicle.Insurance"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="com.dz.common.other.FileUploadUtil" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.jxls.reader.XLSReader" %>
<%@ page import="org.jxls.reader.ReaderBuilder" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="org.jxls.reader.XLSReadStatus" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.dz.module.vehicle.InsuranceDao" %>
<%@ page import="com.dz.module.user.User" %>
<%@ page import="com.dz.module.vehicle.VehicleDao" %>
<%!
    static List<Vehicle> tmpList = null;
    static List<InsuranceImport> uploadExcel(String fileId){
        InputStream inputXLS = null;
        try {
            inputXLS = FileUploadUtil.getFileStream(fileId);
        } catch (IOException e) {
            e.printStackTrace();
//            return "Excel文件读取失败！"+e.getMessage();
            return null;
        }
        List<Vehicle> insurances =  resolveExcel(inputXLS);
        tmpList = insurances;
        List<InsuranceImport> results = new ArrayList<>();
        for (Vehicle insurance : insurances) {
            results.add(new InsuranceImport(insurance));
        }
        return results;
    }

    static List<Vehicle> resolveExcel(InputStream inputXLS){
        try {
            XLSReader mainReader = ReaderBuilder.buildFromXML( new ByteArrayInputStream(InsuranceXlsMapping.getBytes()) );
            Map<String, Object> beans = new HashMap<>();
            List<Vehicle> insurances = new ArrayList<>();
            beans.put("insurances", insurances);

            XLSReadStatus readStatus = mainReader.read(inputXLS, beans);
            if(readStatus.isStatusOK()){
                insurances = (List<Vehicle>) beans.get("insurances");

                return insurances;
            }
        }catch (Exception ignored){}
        return Collections.emptyList();
    }

    static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
    static Date excelEpochDate = new Date(0,0,1);
    static {
        try {
            excelEpochDate = simpleDateFormat.parse("1900/01/01");
        }catch (Exception ignored) {}
    }

    private static Date convertExcelDateToDate(int excelDate) {
        long millisPerDay = 24 * 60 * 60 * 1000; // 每天的毫秒数
        long excelEpoch = excelEpochDate.getTime();
        long excelTime = ((long) excelDate - 2) * millisPerDay;
        return new Date(excelEpoch + excelTime);
    }

    static Date parseDate(String s){
        try {
            return convertExcelDateToDate(Integer.parseInt(s));
        } catch (Exception ignored) {
            ignored.printStackTrace();
        }
        return null;
    }

    static String formatDate(Date d){
        if (d==null){
            return "";
        }
        return simpleDateFormat.format(d);
    }


    static class InsuranceImport {
        private String insuranceNum;
        private String typeCode;
        private Double insuranceMoney;
        private Date signDate;
        private Date beginDate;
        private Date endDate;
        private String carNum;
        private String carframeNum;
        private Date registTime;
        private BigDecimal insuranceBase;

        public InsuranceImport() {}
        public InsuranceImport(Vehicle vehicle) {
            this.insuranceNum = vehicle.getCarframeNum();
            this.typeCode = vehicle.getEngineNum();
            this.insuranceMoney = Double.valueOf(vehicle.getCarMode());
            this.signDate = parseDate(vehicle.getCertifyNum());
            this.beginDate = parseDate(vehicle.getDriverId());
            this.endDate = parseDate(vehicle.getLicenseNum());
            this.carNum = vehicle.getFirstDriver();
            this.carframeNum = vehicle.getSecondDriver();
            this.registTime = parseDate(vehicle.getThirdDriver());
            this.insuranceBase = BigDecimal.valueOf(Double.parseDouble(vehicle.getForthDriver()));
        }

        public String getInsuranceNum() {
            return insuranceNum;
        }

        public void setInsuranceNum(String insuranceNum) {
            this.insuranceNum = insuranceNum;
        }

        public String getTypeCode() {
            return typeCode;
        }

        public void setTypeCode(String typeCode) {
            this.typeCode = typeCode;
        }

        public Double getInsuranceMoney() {
            return insuranceMoney;
        }

        public void setInsuranceMoney(Double insuranceMoney) {
            this.insuranceMoney = insuranceMoney;
        }

        public Date getSignDate() {
            return signDate;
        }

        public void setSignDate(Date signDate) {
            this.signDate = signDate;
        }

        public Date getBeginDate() {
            return beginDate;
        }

        public void setBeginDate(Date beginDate) {
            this.beginDate = beginDate;
        }

        public Date getEndDate() {
            return endDate;
        }

        public void setEndDate(Date endDate) {
            this.endDate = endDate;
        }

        public String getCarNum() {
            return carNum;
        }

        public void setCarNum(String carNum) {
            this.carNum = carNum;
        }

        public String getCarframeNum() {
            return carframeNum;
        }

        public void setCarframeNum(String carframeNum) {
            this.carframeNum = carframeNum;
        }

        public Date getRegistTime() {
            return registTime;
        }

        public void setRegistTime(Date registTime) {
            this.registTime = registTime;
        }

        public BigDecimal getInsuranceBase() {
            return insuranceBase;
        }

        public void setInsuranceBase(BigDecimal insuranceBase) {
            this.insuranceBase = insuranceBase;
        }

        // getters and setters
    }

    static final String InsuranceXlsMapping =
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
            "<workbook>\n" +
            "    <worksheet idx=\"0\">\n" +
            "        <section startRow=\"0\" endRow=\"0\"></section>\n" +
            "        <loop startRow=\"1\" endRow=\"1\" items=\"insurances\" var=\"insurance\" varType=\"com.dz.module.vehicle.Vehicle\">\n" +
            "            <section startRow=\"1\" endRow=\"1\">\n" +
            "                <mapping row=\"1\" col=\"0\">insurance.carframeNum</mapping>\n" +
            "                <mapping row=\"1\" col=\"1\">insurance.engineNum</mapping>\n" +
            "                <mapping row=\"1\" col=\"2\">insurance.carMode</mapping>\n" +
            "                <mapping row=\"1\" col=\"3\">insurance.certifyNum</mapping>\n" +
            "                <mapping row=\"1\" col=\"4\">insurance.driverId</mapping>\n" +
            "                <mapping row=\"1\" col=\"5\">insurance.licenseNum</mapping>\n" +
            "                <mapping row=\"1\" col=\"6\">insurance.firstDriver</mapping>\n" +
            "                <mapping row=\"1\" col=\"7\">insurance.secondDriver</mapping>\n" +
            "                <mapping row=\"1\" col=\"8\">insurance.thirdDriver</mapping>\n" +
            "                <mapping row=\"1\" col=\"9\">insurance.forthDriver</mapping>\n" +
            "            </section>\n" +
            "            <loopbreakcondition>\n" +
            "                <rowcheck offset=\"0\">\n" +
            "                    <cellcheck offset=\"0\"></cellcheck>\n" +
            "                </rowcheck>\n" +
            "            </loopbreakcondition>\n" +
            "        </loop>\n" +
            "    </worksheet>\n" +
            "</workbook>";

    static String fromTypeCodeToClass(String typeCode){
        if ("DAA".equalsIgnoreCase(typeCode)){
            return "商业保险单";
        } else if ("DZA".equalsIgnoreCase(typeCode)) {
            return "交强险";
        }else {
            return "承运人责任险";
        }
    }
%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    String fileId = request.getParameter("fileId");
    List<InsuranceImport> insuranceImports = uploadExcel(fileId);

    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
    InsuranceDao insuranceDao = ctx.getBean(InsuranceDao.class);
    VehicleDao vehicleDao = ctx.getBean(VehicleDao.class);

    String doImport = request.getParameter("doImport");
    if (doImport!=null && doImport.equalsIgnoreCase("true")){

        for (InsuranceImport insuranceImport : insuranceImports) {
            Insurance insurance = new Insurance();
            
            insurance.setInsuranceClass(fromTypeCodeToClass(insuranceImport.getTypeCode()));
            Vehicle vehicle = vehicleDao.selectByFrameId(insuranceImport.carframeNum);
            if (vehicle == null){
                continue;
            }
            insurance.setCarframeNum(vehicle.getCarframeNum());
            insurance.setInsuranceNum(insuranceImport.getInsuranceNum());
            insurance.setInsuranceCompany("来自导入");
            insurance.setInsuranceMoney(insuranceImport.getInsuranceMoney());
            insurance.setBeginDate(insuranceImport.getBeginDate());
            insurance.setEndDate(insuranceImport.getEndDate());
            insurance.setSignDate(insuranceImport.getSignDate());
            insurance.setDriverId("哈尔滨大众交通运输有限责任公司");
            insurance.setRegister(((User)session.getAttribute("user")).getUid());
            insurance.setRegistTime(insuranceImport.registTime);
            insurance.setPhone("86661212");
            insurance.setEnterpriseID("12759066-9");
            insurance.setAddress("哈尔滨 南岗区征仪路311");
            insurance.setState(0);
            insuranceDao.addInsurance(insurance);
        }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>导入成功</title>
</head>
<body>
导入成功，请在保险续保界面审批通过!
<a href="/DZOMS/vehicle/insurance/vehicle_search.jsp" class="button icon-search text-blue" style="line-height: 6px;" >回到续保查询页面</a>
<a href="/DZOMS/vehicle/insurance/insurance_addNew.jsp" class="button icon-search text-blue" style="line-height: 6px;" >转到续保添加页面进行审批</a>
</body>
</html>
<%
    }else {
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>导入预览</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script>
        function _do_import() {

        }
    </script>
</head>
<body>
<div>
    <div class="panel  margin-small" >
        <div class="panel-head">
            <div class="line">
                <div class="xm2">导入预览</div>
                <div class="xm4 xm6-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <form action="/DZOMS/vehicle/insurance/insurance_import.jsp">
                                <input type="hidden" name="fileId" value="<%=fileId%>" >
                                <input type="hidden" name="doImport" value="true" >
                                <button type="submit" class="button icon-search text-blue" style="line-height: 6px;">
                                    进行导入</button>
                                <a href="/DZOMS/vehicle/insurance/vehicle_search.jsp" class="button icon-search text-blue" style="line-height: 6px;" >回到续保查询页面</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">
                <tr>
<%--                    <th>选择</th>--%>
                    <th>序号</th>
                    <th>保单号</th>
                    <th>险种代码</th>
                    <th>保费</th>
                    <th>签单日期</th>
                    <th>起保日期</th>
                    <th>终保日期</th>
                    <th>车牌号</th>
                    <th>车架号</th>
                    <th>行车执照发放日期</th>
                    <th>基础保额</th>
                </tr>
                <% if (insuranceImports != null && insuranceImports.size() > 0){
                    int index = 1;
                    for (InsuranceImport insurance : insuranceImports) {
                        Vehicle vehicle = vehicleDao.selectByFrameId(insurance.carframeNum);
                %>
                <tr>
                    <td><%=index%></td>
                    <td><%=insurance.insuranceNum%></td>
                    <td><%=insurance.typeCode%></td>
                    <td><%=insurance.insuranceMoney%></td>
                    <td><%=formatDate(insurance.signDate)%></td>
                    <td><%=formatDate(insurance.beginDate)%></td>
                    <td><%=formatDate(insurance.endDate)%></td>
                    <td style='<%=vehicle==null?"color: red;":""%>'><%=vehicle==null ? insurance.carNum : vehicle.getLicenseNum()%></td>
                    <td style='<%=vehicle==null?"color: red;":""%>'><%=insurance.carframeNum%></td>
                    <td><%=formatDate(insurance.registTime)%></td>
                    <td><%=insurance.insuranceBase%></td>
                </tr>
                  <%
                        index = index + 1;
                    }
                } else { %>
                 <tr><td colspan="10"> 导入失败！ </td></tr>
                <% } %>
            </table>
        </div>
    </div>
</div>
</body>
</html>
<% } %>
