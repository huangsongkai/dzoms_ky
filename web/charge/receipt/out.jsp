<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-28
  Time: 下午11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>测试</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <script src="/DZOMS/res/js/admin.js"></script>
  <script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <jsp:include page="/common/msg_info.jsp"></jsp:include>
  <script>
	  $(document).ready(function (){
		  $('.datetimepicker').datetimepicker({
			  lang:"ch",           //语言选择中文
			  format:"Y/m/d",      //格式化日期
			  timepicker:false,    //关闭时间选项
			  yearStart:2000,     //设置最小年份
			  yearEnd:2050,        //设置最大年份
			  //todayButton:false    //关闭选择今天按钮

		  });
		  var time = new Date();
//		  $("#recordTime").val(time.toLocaleString());
		  $.post("/DZOMS/charge/receipt/getStorage",{},function(data){
			  data = parseInt(data);
			  var txt = "";
			  var num = data * 100;
			  var box = num / 10000;
			  box = Math.floor(box);
			  if(box >= 1){
				  txt = txt+box+"箱";
			  }
			  var bag = (num-box*10000) / 1000;
			  bag = Math.floor(bag);
			  if(bag >= 1){
				  txt = txt+bag+"袋";
			  }
			  var roll = (num-box*10000-bag*1000) / 100;
			  roll = Math.floor(roll);
			  if(roll >= 1){
				  txt = txt+roll+"卷";
			  }
			 $("#storage").val(txt);
		  });
		  $.post("/DZOMS/common/getIndex?kind=2",[],function(data){
			  var wei = data.length;
			  var s = "fapiaoxiaoshou";
			  for(var i = 0;i < 7-wei;i++){
				  s += "0";
			  }
			  s+=data;
			  $("#proveNum").val(s);
			  $("#hp").val(s);
			  $("#show_form").submit();
		  });
		  $("#carId").bigAutocomplete({
			  url:"/DZOMS/select/VehicleBylicenseNum",
			  callback:setBase
		  });
	  });
	  function setBase(){
		  var licenseNum = $("#carId").val();
		  $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{"vehicle.licenseNum":licenseNum},function(data){
			  data = $.parseJSON(data);
			  var vehicle = data["ItemTool"];
			  var firstId = vehicle["firstDriver"];
			  firstId = firstId.substring(0,firstId.length-1);
			  var secondId = vehicle["secondDriver"];
			  secondId = secondId.substring(0,secondId.length-1);
			  var thirdId = vehicle["thirdDriver"];
			  thirdId = thirdId.substring(0,thirdId.length-1);
			  var forthId = vehicle["forthDriver"];
			  forthId = forthId.substring(0,forthId.length-1);
			  $("#CI").val(licenseNum);
			  $("#show").submit();
			  $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":firstId},function(tmp){
				  $("#firstDriver").html(tmp["name"]);
			  });
			  $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":secondId},function(tmp){
				  $("#secondDriver").html(tmp["name"]);
			  });
			  $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":thirdId},function(tmp){
				  $("#thirdDriver").html(tmp["name"]);
			  });
			  $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":forthId},function(tmp){
				  $("#forthDriver").html(tmp["name"]);
			  });
			  var did = vehicle["driverId"];
			  did = did.substring(0,did.length-1);
			  $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":did},function(tmp){
				  $("#renter").val(tmp["name"]);
			  });
		  });
	  };

	  var pattern =/^([a-zA-Z0]*)([1-9][0-9]*)$/;
	  var patternR =/^([0-9]*)\S*/;
    function fillEnd(){
      var startNum = $("#startNum").val();
		if (/^[a-zA-Z0-9]*[0-9]{5}$/.test(startNum)){
			var startNumReverse = startNum.split('').reverse().join('');
			var atLeastSize = startNumReverse.match(patternR)[1].length;
			var startNumRight = startNum.substr(startNum.length-atLeastSize);
			startNumRight = startNumRight.match(pattern)[2];
			var startNumLeft = startNum.substr(0,startNum.length-startNumRight.length);
			$('#prefix').val(startNumLeft);
			$('#start').val(startNumRight);
			var endNum = parseInt(startNumRight)+999;
			$('#end').val(endNum);
			$("#endNum").val(startNumLeft+''+endNum);
			$("#showNum").html("1袋");
			$("#numb").val(10);

			$("#allPrice").val(10*eval($("input[name='rr.price']").val()));
		} else {
			alert('起始票号不符合规范')
		}
    }
    function calNum(){
      var startNum = $("#start").val();
      var prefix = $('#prefix').val();
      var endFullNum = $("#endNum").val();
      var  endNum = endFullNum.substr(prefix.length);

      var num = eval(endNum)-eval(startNum)+1;
      
      if(num%100!=0){
      	alert("出售数量应为整袋！");
      	$("#endNum").val("");
      }else{
      	$("#allPrice").val(num/100*eval($("input[name='rr.price']").val()));
      }
      $("#numb").val((endNum-startNum+1)/100);
      var txt = "";
      var box = num / 10000;
      box = Math.floor(box);
      if(box >= 1){
        txt = txt+box+"箱";
      }
      var bag = (num-box*10000) / 1000;
      bag = Math.floor(bag);
      if(bag >= 1){
        txt = txt+bag+"袋";
      }
      var roll = (num-box*10000-bag*1000) / 100;
      roll = Math.floor(roll);
      if(roll >= 1){
        txt = txt+roll+"卷";
      }
      $("#showNum").html(txt);
    }
    function validate(){
		var happenTime = $("#happenTime").val();
		if(happenTime == ""||happenTime==undefined){
			//alert("年月不得为空");
			//return false;
			$("#happenTime").val($("#recordTime").val());
		}
      var startNum = $("#startNum").val();
      var endNum = $("#endNum").val();
      if(startNum == undefined || startNum==""||endNum==undefined||endNum==""){
        alert("发票开始编号与结束编号必填！！！");
        return false;
      }else{
		  var start = $("#start").val();
		  var end = $("#end").val();
		  var prefix = $("#prefix").val();
        if((eval(end)-eval(start)+1)%100 != 0){
          alert("发票开始编号与结束编号错误！！！");
        }else{
          $.post("/DZOMS/charge/receipt/validateOut",{"startNum":start,"endNum":end,"prefix":prefix},function(data){
            if(data.startsWith("success")){
              $("#form").submit();
            }else{
              alert("该发票段不存在或者已经售出！！！");
            }
          })
        }
      }
    }
	function carFocus(){
		$('input[name="rr.carId"]').val("黑A");
	}
  </script>
    <style>
  	.label{
  		width: 100px;
  		text-align: right;
  	}
  </style>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>发票销售</li>
    </ul>
    </div>
</div>
<div class="line">
	<div class="panel  margin-small" >
          	<div class="panel-head">
          	发票销售
           	</div>
          	<div class="panel-body">
          	<form action="/DZOMS/charge/receipt/addRecord" method="post" id="form" class="form-inline form-tips" style="width: 100%;">
				<div class="form-group">
					<div class="label">
						<label>库存</label>
					</div>
					<div class="field">
						<input type="text" class="input input-auto" id="storage" readonly>
					</div>
				</div>
							<br/>
							

          		       	   <div class="form-group form-disabled">
          		       	      <div class="label">
          		       	   	     <label>日期</label>
          		       	      </div>
          		       	    <div class="field">
          		       	   	  <s:textfield   name="rr.recordTime" id="recordTime" cssClass="input input-auto" size="20" value="%{@com.dz.common.other.TimeComm@getDate()}" />
          		       	    </div>
          		       	    </div>

          		       	    <div class="form-group form-disabled">
          		       	      <div class="label">
          		       	   	     <label>发放人</label>
          		       	      </div>
          		       	    <div class="field">
          		       	    	<s:textfield  value="%{#session.user.uname}" name="rr.recorder" cssClass="input input-auto" size="20" />
          		       	    </div>
          		       </div>
          		       <div class="form-group" style="display:none">
          		       	   <div class="label">
          		       	   	  <label>单据编号</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	 <input type="text" name="rr.proveNum" class="input input-auto" size="20" id="proveNum" readonly>
          		       	   </div>
          		       </div>
          		       <br/>
          		       
						<div class="form-group">
							<div class="label">
								<label>单位</label>
							</div>
							<div class="field">
								<input type="text" class="input input-auto" size="20" readonly value="卷">
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label>张数</label>
							</div>
							<div class="field">
								<input type="text" class="input input-auto" size="20" readonly value="100">
							</div>
						</div>
						<div class="form-group" style="display:none">
							<div class="label">
								<label>单价</label>
							</div>
							<div class="field">
								<input type="text" name="rr.price" class="input input-auto" size="20" readonly value="3.6">
							</div>
						</div>
						<br/>
						




          		       	    <div class="form-group">
          		       	   <div class="label">
          		       	   	  <label>车号</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	 <input type="text" name="rr.carId" class="input input-auto" value="黑A" size="20" id="carId" onblur="setBase()" onfocus="carFocus()">

          		       	   </div>
          		       </div>
          		           <div class="form-group">
          		       	   <div class="label">
          		       	   	  <label>承租人</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	<input type="text" name="rr.renter" class="input input-auto" size="20" id="renter">

          		       	   </div>
          		       </div>
          		           <div class="form-group">
          		       	   <div class="label">
          		       	   	  <label>领购人</label>
          		       	   </div>
          		       	   <div class="field">
							    <select id="taker" name="rr.taker" class="input">
									<option id="firstDriver"></option>
									<option id="secondDriver"></option>
									<option id="thirdDriver"></option>
									<option id="forthDriver"></option>
							   </select>
          		       	   </div>
          		       </div>
          		       <br>
          		           <div class="form-group" style="display: none;">
          		       	   <div class="label" >
          		       	   	  <label>档案号</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	 <input type="text" id="contractNum" class="input input-auto" size="20" readonly id="contrctNum">

          		       	   </div>
          		       </div>

						<div class="form-group">
							<div class="label">
								<label>起始号</label>
							</div>
							<div class="field">
								<input type="hidden" name="rr.prefix" id="prefix">
								<input type="hidden" name="rr.startNum" id="start">
								<input type="text" name="rr.startFullNum" id="startNum" onblur="fillEnd()" class="input input-auto" size="20">
							</div>
						</div>
          		        <div class="form-group">
          		       	   <div class="label">
          		       	   	  <label>结束号</label>
          		       	   </div>
          		       	   <div class="field">
							   <input type="hidden" name="rr.endNum" id="end">
          		       	   	 <input type="text" name="rr.endFullNum" id="endNum" onchange="calNum()" class="input input-auto" size="20">
          		       	   </div>
          		       </div>
            <div class="form-group">
							<div class="label">
								<label>数量</label>
							</div>
							<div class="field">
								<input type="text" id="numb" readonly class="input input-auto" size="20">
							</div>
						</div>
						<div class="form-group" style="display:none">
							<div class="label">
								<label>发放日期</label>
							</div>
							<div class="field">
								<input type="text" id="happenTime" name="rr.happenTime" class="input input-auto datetimepicker" size="20">
							</div>
						</div>
				<!-- <br/> -->
          		       
          		       	  <div class="form-group" style="display:none">
          		       	   <div class="label">
          		       	   	  <label>备注</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	 <input type="text" name="rr.comment" class="input input-auto" size="40">
          		       	   </div>
          		       </div>
						<select name="rr.style" style="display: none">
							<option value="销售">销售</option>
							<option value="发放" selected>发放</option>
						</select>
          		       <br/>
          		       <div class="form-group" style="display:none">
          		       	   <div class="label">
          		       	   	  <label>合计金额</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	 <input type="text" id="allPrice" name="rr.allPrice" class="input input-auto" size="20">
          		       	   </div>
          		       </div>
          		       <div class="form-group">
          		       	   <div class="label">
          		       	   	  <label>数量：</label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	  <strong id="showNum"></strong>
          		       	   </div>
          		       </div>
          		       	<br>
          		          <s:actionmessage/>
          		           <div class="form-group">
          		       	   <div class="label">
          		       	   	  <label></label>
          		       	   </div>
          		       	   <div class="field">
          		       	   	 <input type="button" value="提交" class="button bg-main" onclick="validate()">
          		       	   </div>
          		       </div>
                        
          		 </form>
				<form id="show" action="/DZOMS/charge/receipt/searchRecords" method="post" target="sh">
					<input type="hidden" name="carId" id="CI">
				</form>
          		<iframe name="sh" style="width: 100%"/>
          	</div>
  </div>
</div>
	
	
	
	
<!--<form action="/DZOMS/charge/receipt/addRecord" method="post" id="form">
  <input type="hidden" name="rr.style" value="销货">
  <span>记录日期</span><input type="text" name="rr.recordTime"><span>记录人员</span><input type="text" name="rr.recorder"><br/>
  <span>单据编号</span><input type="text" name="rr.proveNum"><br/>
  <span>单位：卷</span><br/>
  <span>车号</span><input type="text" name="rr.carId">
  <span>承包人</span><input type="text" name="rr.renter">
  <span>领购人</span><input type="text" name="rr.taker">
  <span>档案号</span><input type="text" id="contractNum"><br/>
  <span>单价：</span><input type="text" name="rr.price"><br/>
  <span>年份</span><input type="text" name="rr.happenTime"><br/>
  <span>起始号</span><input type="text" name="rr.startNum" id="startNum" onblur="fillEnd()"><br/>
  <span>结束号</span><input type="text" name="rr.endNum" id="endNum" onchange="calNum()"><br/>
  <span>备注</span><input type="text" name="rr.comment"><br/>
  <span>合计金额</span><input type="text" name="rr.allPrice"><br/>
  <span id="showNum">数量</span><br/>
  <s:actionmessage/>
  <input type="button" value="提交" onclick="validate()">
</form>-->
</body>
</html>
