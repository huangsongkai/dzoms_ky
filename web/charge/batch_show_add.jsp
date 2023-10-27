<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.user.User" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-15
  Time: 下午8:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>批量约定结果</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">

</head>
<body onload="tiao()">
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>批量变更约定</li>
    </ul>
</div>
<form method="post" id="formx" action="/DZOMS/charge/addBatchPlan" class="form-tips form-inline" style="width: 100%">
    <div class="line">
        <div class="panel xm11 margin-small">
            <div class="panel-head">
                <strong>新增约定</strong>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定名称
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto" size="40"  value="财务计划" name="batchPlan.title"/>
                    </div>
                </div>

                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            开始日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input  datepick input-auto" size="14" name="batchPlan.startTime" value="%{batchPlan.getStartTime()}"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            结束日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input datepick input-auto" size="14" value="%{batchPlan.getEndTime()}" name="batchPlan.endTime"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            使用合同结束日期
                        </label>
                    </div>
                    <div class="field">
                        <input type="checkbox" name="isToEnd">
                    </div>
                </div>
                <br>
                	
               
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定类型
                        </label>
                    </div>
                    <div class="field">
                        <select size="1" name="batchPlan.feeType" class="input">
                            <option value="plan_add_insurance">保险费用</option>
                            <option value="plan_sub_insurance" style="display:none">保险费用下降</option>
                            <option value="plan_add_contract">合同费用</option>
                            <option value="plan_sub_contract" style="display:none">合同费用下降</option>
                            <option value="plan_add_other">其他费用</option>
                            <option value="plan_sub_other" style="display:none">其他费用下降</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            费用
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input "  name="batchPlan.fee" placeholder="单位（元）"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            备注
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input" name="batchPlan.comment"/>
                    </div>
                </div>
                <input type="button" value="提交" class="button bg-main" onclick="btnClk()"/>
            </div>
        </div>
        </div>
        <div class="line">
        	<div class="xm11 margin-small">
        		<%Object message = request.getAttribute("message");%>
          <%if(message != null){%>
          <div class="alert">
		      <span class="close rotate-hover"></span><strong>操作结果：</strong><%=message.toString()%></div>
           <%}%>
        	</div>
        	
        
        	
        </div>

       
            <div class="line">
                <div class="xm5">
                    <div class="panel" style="height: 600px;overflow:auto; ">
                        <div class="panel-head">
                            <strong>全部车辆:</strong>
                            <label>一部</label><input id='pc1' type='checkbox' onchange='active_all(this)'>
                            <label>二部</label><input id='pc2' type='checkbox' onchange='active_all(this)'>
                            <label>三部</label><input id='pc3' type='checkbox' onchange='active_all(this)'>
                        </div>
                        <table class="table table-bordered" id="table1">
                            <tr>
                                <th>选择</th>
                                <th>档案号</th>
                                <th>车牌号</th>
                                <th>承包形式</th>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="xm1">
                    <div style="height: 200px"></div>
                    <div class="margin-small"><input type="button" class="button bg-gray" value="添加->" onclick="tianjia()"></div>
                    <div class="margin-small"><input type="button" class="button bg-gray" value="<-删除" onclick="shanchu()"></div>
                </div>
                <div class="xm5">

                    <div class="panel" style="height: 600px;overflow:auto; ">
                        <div class="panel-head">
                            <strong>选择车辆:</strong>
                        </div>
                        <table class="table table-bordered" id="table2">
                            <tr>
                                <th>选择</th>
                                <th>档案号</th>
                                <th>车牌号</th>
                                <th>承包形式</th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>


      
  
        <input type="hidden" name="batchPlan.register" value="<%=((User)session.getAttribute("user")).getUname()%>"/>

   

</form>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/js/DateTimeHelper.js">
</script>
</html>
