<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-13
  Time: 下午6:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
 <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
  <script>
    function openView(view,args){
      window.showModalDialog(view,args,
             'dialogWidth:1024px;dialogHeight:800px;edge:raised;resizable:yes;scroll:no;status:no;center:yes;help:no;minimize:yes;maximize:yes;');
    }
    function addGroup(){
      openView("/DZOMS/check/addGroup.jsp", {"planId":"<s:property value='plan.id'/>"});
      $("#plan_detail_show").submit();
    }
    function showUsers(groupId){
      $.post("/DZOMS/check/getUserNamesByGroupId",{"groupId":groupId},function(data){
        data = $.parseJSON(data);
        data = data["list"][0];
        data = data["string"];
        if(data.length == undefined){
          data = [data];
        }
        alert(data);
      });
    }
    function showRecords(groupId){
      openView("/DZOMS/check/getGroupWithRecord_1?groupId="+groupId, {});
    }
  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>自检计划</li>
                <li>查看自检计划</li>
        </ul>
</div>
<div class="line">
	<div class="panel margin-small" >
          	<div class="panel-head">
    <s:if test="plan != null">
   <strong>标题:</strong><s:property value="plan.title"/>
    <strong>年月:</strong><s:property value="plan.time"/>
          	</div>
          	<div class="panel-body">
     
  <table class="table table-hover table-striped table-bordered">
    <tr>
      <th>组名</th>
      <th>地点</th>
      <th>开始时间</th>
      <th>结束时间</th>
      <th>最少检查人数</th>
      <th>已检查人数</th>
      <th>检查人员</th>
      <th>详细记录</th>
    </tr>
    <s:iterator value="plan.groups" id="group" status="cur">
      <tr>
        <td>组<s:property value="#cur.index+1"/></td>
        <td><s:property value="#group.location"/></td>
        <td><s:property value="#group.startTime"/></td>
        <td><s:property value="#group.endTime"/></td>
        <td><s:property value="#group.minNum"/></td>
        <td><s:property value="#group.checkRecords.size()"/></td>
        <td><a class="bg-blue button" onclick="showUsers(<s:property value='#group.id'/>)">查看</a></td>
        <td><a class="bg-blue button" onclick="showRecords(<s:property value='#group.id'/>)">查看</a></td>
      </tr>
    </s:iterator>
  </table>
</s:if>
          		
          	</div>
	
</div>
</div>
</body>

</html>
