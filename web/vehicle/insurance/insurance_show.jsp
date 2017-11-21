<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
            />
    <meta name="renderer" content="webkit">
    <title>
        查看保险
    </title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

    <style>
        .label{
             white-space:pre-line;
        }
    </style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>查看</li>
                <li>查看保险信息</li>
        </ul>
</div>
	

    <div class="xm7 xm2-move">
    	<div class="panel">
    		
    		<div class="panel-head">查看保险信息</div>
    		<div class="panel-body">
    			<form class="form-x" action="/DZOMS/vehicle/insurance_add" method="post">
    			      <div class="form-group">
            <div class="label">
                <label>
                    保险类别
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" id="carframe_num" theme="simple" name="insurance.insuranceClass"></s:textfield>
               
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    车架号
                </label>
            </div>
            <div class="field">
  				<s:textfield cssClass="input" id="carframe_num" theme="simple" name="insurance.carframeNum" ></s:textfield>
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    保单号
                </label>
            </div>
            <div class="field">
                <s:textfield cssClass="input" type="text" size="12" maxlength="12" placeholder=""
                       name="insurance.insuranceNum" />
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    保险公司
                </label>
            </div>
            <div class="field form-inline">
                <s:textfield cssClass="input" name="insurance.insuranceCompany" id="insuranceCompany"  >
                </s:textfield>
            </div>

        </div>
        <div class="form-group" >
            <div class="label">
                <label>
                    保险金额
                </label>
            </div>
            <div class="field form-inline">
            	<s:textfield cssClass="input" name="insurance.insuranceMoney" >
                </s:textfield>
                
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    起始时间
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" name="insurance.beginDate" >
            		<s:param name="value">
            			<s:date name="insurance.beginDate" format="yyyy/MM/dd hh:mm"/>
            		</s:param>
                </s:textfield>
                
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    终止时间
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" name="insurance.endDate" >
            		<s:param name="value">
            			<s:date name="insurance.endDate" format="yyyy/MM/dd hh:mm"/>
            		</s:param>
                </s:textfield>
                
            </div>
        </div>
        <div class="form-group" >
            <div class="label">
                <label>
                    签单日期
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" name="insurance.signDate" >
            		<s:param name="value">
            			<s:date name="insurance.signDate" format="yyyy/MM/dd hh:mm"/>
            		</s:param>
                </s:textfield>
                
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    被保险人
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" name="insurance.driverId" >
                </s:textfield>
                
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    联系电话
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" name="insurance.phone" >
                </s:textfield>
            </div>       
        </div>
        <div class="form-group">
        	 <div class="label">
                <label>
                    身份证号/组织机构代码
                </label>
            </div>
            <div class="field">
                <s:textfield cssClass="input" name="insurance.enterpriseID"></s:textfield>
            </div>
        </div>
         <div class="form-group">
        	 <div class="label">
                <label>
                    被保险人地址
                </label>
            </div>
            <div class="field">
                <s:textfield cssClass="input" name="insurance.address" value="哈尔滨"></s:textfield>
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    登记人
                </label>
            </div>
            <div class="field">
            	<s:textfield  cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',insurance.register).uname}" />
            </div>
        </div>
        <div class="form-group">
            <div class="label">
                <label>
                    登记时间
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" name="insurance.registTime" >
                </s:textfield>
               
            </div>
        </div>
        
        
        
        </form>
    		</div>
    		
    	</div>
  
       <!-- <div class="form-group">
            <div class="label">
                <label>
                    联系电话
                </label>
            </div>
            <div class="field">
                <input class="input" type="text" maxlength="12" placeholder="输入手机号码/联系电话"
                       name="insurance.carframeNum" data-validate="tel:请填写手机号/电话号">
            </div>
        </div>-->
    </div>
			
</body>

</html>