<%--
  Created by IntelliJ IDEA.
  User: Wang
  Date: 2017/12/20
  Time: 13:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>驾驶员聘用协议</title>
    <style>
        .A4Size {
            width: 175mm;
            height: 262mm;
            border: solid hidden;
        }
        @media print {
            p{
                margin-top: 0;
                margin-bottom: 0;
            }
        }

    </style>
</head>
<body>
<div class="A4Size">
    <%
        Driver d = ObjectAccess.getObject(Driver.class,request.getParameter("idNum"));
        request.setAttribute("d",d);
    %>
    <h1 align="center">驾驶员聘用协议</h1>
    <table width="100%" style="text-align: left;">
        <tr>
            <td width="45%">甲方（出租车承包方）：</td>
            <td >身份证号：</td>
        </tr>
        <tr>
            <td >乙方（被聘用驾驶员）：${d.name}</td>
            <td  >身份证号：${d.idNum}</td>
        </tr>
        <tr>
            <td colspan="2">
                <p>&nbsp;&nbsp;&nbsp;&nbsp;为了贯彻落实《哈尔滨市出租汽车客运管理条例》为市民创造安全能畅通的交通环境，提升出租汽 车客运服务水平，甲乙双方本着友好协商的原则，特制定此协议，被聘用驾驶员应按此协议严格遵守。
                </p>
                <p>一、持有巡游出租汽车驾驶员证两年以上、三年内无重大交通安全事故、所持有的身份证、驾驶证、 从业资格证等证件齐全、合法有效、禁止发生逾期审验、违规失效等问题。
                </p>
                <p>二、应严格遵守《中华人民共和国道路交通安全法》、《哈尔滨市出租汽车客运管理条例》、 《哈尔滨市出租汽车运营服务考核办法》、《公司运营安全管理制度》等相关的法律法规、行业管理规定和公司管理制度。
                </p>
                <p>三、在营运服务中，有下列情形之一的，依照上述第二条相关法律法规、行业及公司管理规定进行处理。
                </p>
                <p>（一）未经乘客同意合载、绕道行驶的；</p>
                <p>（二）未达车容整洁、设施、设备完好的；</p>
                <p>（三）未按规定使用计价器、未如实给付乘客有效票据的；</p>
                <p>（四）未按规定使用文明用语、服务态度恶劣的；</p>
                <p>（五）未按行业规定着装的；</p>
                <p>（六）未按公司规定参加例会、违制培训的；</p>
                <p>（七）未按规定遵章驾驶、行驶中吸烟、打电话、向车外抛物的；</p>
                <p>（八）其他违反法律法规、行业管理规定及公司管理制度的行为。</p>
                <p>四、根据甲方（出租车承包方）与大众公司签约的《哈尔滨市客运出租汽车承包经营合同》中第七条聘用驾驶员的约定、制作本驾驶员聘用协议。</p>
                <p>（一）乙方（出租车承包方）客运在承包期内聘用一名驾驶员轮换驾驶，聘用的驾驶员必须向甲方（大众公司）申报，经甲方（大众公司）审核备案并办理相关的营运手续后，方可驾驶营运车辆。</p>
                <p>（二）乙方（出租车承包方）对所聘用的驾驶员从事的营运行为引起的法律后果，承担经济赔偿连带责任。</p>

            </td>
        </tr>
        <tr>
            <td >
                甲方（签字，捺印）：
                <br><br><br>&nbsp;
            </td>
            <td >车牌号码：${d.applyLicenseNum}<br><br><br>&nbsp;</td>
        </tr>
        <tr>
            <td>乙方（签字，捺印）：<br><br><br>&nbsp;</td>
            <td >车辆所属公司：哈尔滨大众交通运输有限责任公司<br><br><br>&nbsp;</td>
        </tr>
    </table>
    <div style="float: right;">签订日期：&nbsp;&nbsp;年&nbsp;&nbsp;月&nbsp;&nbsp;日</div>
</div>
</body>
</html>
