<%@ page language="java"
	import="com.dz.module.user.User, com.dz.module.vehicle.VehicleApproval"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>驾驶员上下车管理</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script type="text/javascript">

	var selectedDriverId;
	var selectedLicenseNum;
	var posit;
	var opration;
	
	function driverSelectDialogRefresh(){
		
	}
	
	function driverSelect(){
		alert(opration);
	}


	function InCar(ta,ps){
		var $td = $(ta).parent().siblings(".licenseNum");
		selectedLicenseNum = $td.html().trim();
		posit = ps;
		opration="InCar";
	}



	function setContractor(idNum) {
		var dat = {
			"className" : "com.dz.module.driver.Driver",
			"id" : idNum,
			"isString" : true
		};
		$.post('/DZOMS/common/getObject', dat, function(data) {
			var da = $.parseJSON(data);
			$(".drivername" + userid).html(da["name"]);
		});
	}

	function setDriver(idNum) {
		if (idNum.trim().length == 0) {
			var ta = '<a href="javascript:InCar(this,1)" class="dialogs" data-toggle="click" data-target="#driverSelectDialog" data-mask="1" data-width="50%">上车</a>';
			$(".driverid" + userid).html(ta);
			return false;
		}

		var dat = {
			"className" : "com.dz.module.driver.Driver",
			"id" : idNum,
			"isString" : true
		};
		$.post('/DZOMS/common/getObject', dat, function(data) {
			var da = $.parseJSON(data);
			$(".driverid" + userid).html(da["name"]);
			var ta = '<a href="javascript:OutCar(this,1)">下车</a>';
			$(".driverid" + userid).append(ta);
			ta = '<a href="javascript:ToCar(this,2)">转为副驾</a>';
			$(".driverid" + userid).append(ta);
		});
	}

	function setDriver2(idNum) {
		if (idNum.trim().length == 0) {
			var ta = '<a href="javascript:InCar(this,2)">上车</a>';
			$(".driverid" + userid).html(ta);
			return false;
		}

		var dat = {
			"className" : "com.dz.module.driver.Driver",
			"id" : idNum,
			"isString" : true
		};
		$.post('/DZOMS/common/getObject', dat, function(data) {
			var da = $.parseJSON(data);
			$(".driverid" + userid).html(da["name"]);
			var ta = '<a href="javascript:OutCar(this,2)">下车</a>';
			$(".driverid" + userid).append(ta);
			ta = '<a href="javascript:ToCar(this,1)">转为主驾</a>';
			$(".driverid" + userid).append(ta);
		});
	}

	function setTempDriver(idNum) {
		if (idNum.trim().length == 0) {
			var ta = '<a href="javascript:InCar(this,3)">上车</a>';
			$(".driverid" + userid).html(ta);
			return false;
		}

		var dat = {
			"className" : "com.dz.module.driver.Driver",
			"id" : idNum,
			"isString" : true
		};
		$.post('/DZOMS/common/getObject', dat, function(data) {
			var da = $.parseJSON(data);
			$(".setTempDriver" + userid).html(da["name"]);
			var ta = '<a href="javascript:OutCar(this,3)">下车</a>';
			$(".driverid" + userid).append(ta);
		});
	}

	var currentPage = 0;
	function dealResult(data) {
		var obj = data;//$.parseJSON(data);

		var list = obj["list"];
		var hasPrePage = obj["hasPrePage"];
		var hasNextPage = obj["hasNextPage"];
		var currentPage = obj["currentPage"];
		var totalPage = obj["totalPage"];

		if (list.length == 0) {
			alert("未找到数据！");
		}

		var HTML = "<tr><td>车牌号</td><td>承租人</td><td>身份证号</td><td>分公司归属</td><td>主驾</td><td>副驾</td><td>临驾</td></tr>";
		$("#driver").html(HTML);
		for (var i = 0; i < list.length; i++) {
			HTML = "<tr>";
			HTML = HTML + '<td class="licenseNum">' + list[i]["licenseNum"] + "</td>";
			HTML += +'<td class="drivername'+list[i]["driverId"]+'">'
					+ list[i]["driverId"] + "</td>";

			HTML = HTML + "<td>" + list[i]["driverId"] + "</td>";
			HTML = HTML + "<td>" + list[i]["dept"] + "</td>";
			HTML += +'<td class="firstDriver driverid'+list[i]["firstDriver"]+'">'
					+ list[i]["firstDriver"] + "</td>";
			HTML += +'<td class="secondDriver driverid2'+list[i]["secondDriver"]+'">'
					+ list[i]["secondDriver"] + "</td>";
			HTML += +'<td class="tempDriver tempdriver'+list[i]["tempDriver"]+'">'
					+ list[i]["tempDriver"] + "</td>";

			$("#driver").append(HTML);
			setContractor(list[i]["driverId"]);
			setDriver(list[i]["firstDriver"]);
			setDriver2(list[i]["secondDriver"]);
			setTempDriver(list[i]["tempDriver"]);

		}

		HTML = "<tr align = \"center\"><td colspan=\"17\">";
		if (hasPrePage) {
			var prePage = currentPage - 1;
			HTML = HTML
					+ "<a href=\"javascript:search(1,)\">首页</a>| <a href=\"javascript:search("
					+ prePage + ")\">前一页</a>";
		} else {
			HTML = HTML + "首页 | 前一页";
		}

		HTML = HTML
				+ "<span style=\"margin-left: 50px;margin-right: 50px;\">第&nbsp;&nbsp;<input type=\"button\" class=\"btn btn-info\" disabled=\"disabled\" value=\""+currentPage+"\"/>&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;共&nbsp;&nbsp;<input type=\"button\" class=\"btn btn-info\" disabled=\"disabled\" value=\""+totalPage+"\"/>&nbsp;&nbsp;页</span>";
		if (hasNextPage) {
			var nexPage = currentPage + 1;
			HTML = HTML + "<a href=\"javascript:search(" + nexPage
					+ ")\">后一页</a>| <a href=\"javascript:search(" + totalPage
					+ ")\">末页</a>";
		} else {
			HTML = HTML + "后一页 | 末页";
		}
		HTML = HTML + "</tr>";
		$("#driver").append(HTML);

	}
	function search() {
		var idNum = $("#idNum").val();
		var idName = $("#idName").val();
		var linence_num = $("#linence_num").val();
		$.post("/DZOMS/driver/driverCarSearch", {
			"currentPage" : currentPage,
			"idNum" : idNum,
			"linence_num" : linence_num,
			"idName" : idName
		}, dealResult);
	}
</script>
</head>

<body>
	<div class="adminmin-bread">
		<ul class="bread">
			<li><a href="" class="icon-home"> 开始</a></li>
			<li>驾驶员上下车管理</li>
		</ul>
	</div>

	<div>
		<!-- 主页面 -->
		<form method="post" class="definewidth m20">
			<input type="hidden" id="isSearchAll">
			<table class="table table-stiped table-bordered table-condecsed">
				<tr>
					<td class="tableleft">车牌号</td>
                    <td><input type="text" id="linence_num"/></td>
                    <td class="tableleft">承包人</td>
                    <td><input type="text" id="idName"/></td>
                    <td class="tableleft">身份证号码</td>
                    <td><input type="text" id="idNum"/></td>
                </tr>
                    
				<tr>
                    <td colspan=8 style="text-align:right;">
                    	<input type="button" class="btn btn-primary" id="btn1" value="查询" onclick="search()" />
                    </td>
				</tr>
			</table>
			<table class="table table-striped table-bordered table-condensed" id="driver">
				
			</table>
			<input type="hidden" id="searchcondition"/>
		</form>
	</div>
	
	<div id="driverSelectDialog">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close"></span>
            <strong>选取驾驶员</strong>
        </div>
        <div class="dialog-body">
            <div>身份证号</div>
            <div><input class="input idNum" onchange="driverSelectDialogRefresh()"/></div>
            <div>驾驶员姓名</div>
            <div><input class="input idName" onchange="driverSelectDialogRefresh()"/></div>
            <div>
            <table class="result-table">
            	<thead><tr>
            		<td>身份证号</td><td>驾驶员姓名</td><td>性别</td>
            	</tr></thead>
            	<tbody class="result-table-tbody"></tbody>
            	<tfoot class="result-table-tfoot"></tfoot>
            </table>
            </div>
        </div>
        <div class="dialog-foot">
            <button class="button bg-green" onclick="driverSelect()">添加</button>
            <button class="button dialog-close">取消</button>
        </div>
    </div>
</div>
</body>
</html>