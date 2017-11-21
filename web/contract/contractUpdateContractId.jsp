<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
	<%@ page language="java"
	import="java.util.*,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>合同档案号修改</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script type="text/javascript">
    	
    </script>
    <style>
        .label{
            width: 120px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="adminmin-bread">
    <ul class="bread">
        <li><a href="" class="icon-home"> 开始</a></li>
        <li>合同</li>
        <li>档案号修改</li>
    </ul>
</div>
<div class="padding">
    <form method="post" action="/DZOMS/contract/contractIdUpdate" class="form-inline" style="width: 100%">
        <s:hidden name="contract.id"></s:hidden>
	
        <blockquote class="border-main form-disabled">
            <strong>承租人信息</strong>

            <div class="line">
                <div class="xm2 padding">
                    <img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/photo.jpg" class="radius img-responsive">
                </div>
                <div class="xm10">
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车架号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield name="contract.carframeNum" />
                        </div>
                    </div>

                    <br>


                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车牌号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" name="contract.carNum"></s:textfield>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                经营形式
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield name="vehicle.businessForm" cssClass="input"/>
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                合同种类
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" id="contract_businessForm" name="contract.businessForm" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                营运手续归属
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield  cssClass="input" value="%{contract.ascription?'个人':'公司'}"/>
                            <s:hidden name="contract.ascription"></s:hidden>
                        </div>
                    </div>
                  
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                起始日期
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input datepick"  id="startdate" onBlur="set_date()" name="contract.contractBeginDate" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                终止日期
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input datepick" id="enddate" onchange="dateRefresh()" name="contract.contractEndDate" />
                        </div>
                    </div>

                   
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                分公司归属
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield name="contract.branchFirm" cssClass="input"/>
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                身份证号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input"  name="driver.idNum" />
                            <s:hidden  name="contract.idNum" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                承包人
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input"  name="driver.name" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                性别
                            </label>
                        </div>
                        <div class="field" >
                            <s:select cssClass="input"  name="driver.sex"
                                      list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.sex')"></s:select>
                        </div>
                    </div>
                 </div>
                 </div>
        </blockquote>
       
       <div class="form-group">
                        <div class="label padding">
                            <label>
                                档案号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input"  name="contract.contractId"/>
                        </div>
        </div>
        <br />
        <div class="form-group">
            <input type="button" class="button bg-green button-big submitbutton" value="提交" data-width="50%" data-mask="1"/>
        </div>
       <input type="submit" style="display: none;" id="submit-button"/>
    </form>

</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
<script>
	button_bind(".submitbutton","确定提交?","$('#submit-button').click();");
</script>
</html>