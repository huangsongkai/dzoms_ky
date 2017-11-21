<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dz.module.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("user");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>续保查询</title>

	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />

	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>

	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>

	<script>
        function refreshSearch(){
            $("[name='vehicleSele']").submit();
        }

        $(document).ready(function(){
            $("[name='vehicleSele']").find("select").change(function(){
                $("[name='vehicleSele']").submit();
            });

            $("[name='vehicleSele']").submit();

            $("[name='vehicleSele']").find("input").change(function(){
                if($(this).val().trim().length==0)
                    $("[name='vehicleSele']").submit();
            });

            $("#driver_name").bigAutocomplete({
                url:"/DZOMS/select/driverByName",
                callback:refreshSearch
            });

            $("#carframe_num").bigAutocomplete({
                url:"/DZOMS/select/vehicleById",
                callback:refreshSearch,
                doubleClick:true
//				doubleClickDefault:'LFV'
            });

            $("#license_num").bigAutocomplete({
                url:"/DZOMS/select/vehicleByLicenseNum",
                callback:refreshSearch
            });

            $("#engine_num").bigAutocomplete({
                url:"/DZOMS/select/vehicleByEngineNum",
                callback:refreshSearch
            });

            <%
        String position = user.getPosition();
                                    String dept="";

                                    if(position==null)
                                        dept="";
                                    else if(position.contains("一"))
                                        dept = "一部";
                                    else if(position.contains("二"))
                                        dept = "二部";
                                    else if(position.contains("三"))
                                        dept = "三部";
      %>
            $('select[name="vehicle.dept"]').val("<%=dept%>");

        });

        function beforeSubmit(){
            var insuranceClass = $('[name="insuranceClass"]').val();

            var condition = "and state in (0,1,3) "+
                "and carframeNum in ("+
                "select carframeNum from Insurance "+
                (insuranceClass=='all'?'':'where insuranceClass like \'%'+insuranceClass+'%\' ')+
                "group by carframeNum,insuranceClass "+
                "having max(endDate) < '"+$('input[name="insurance_end_date"]').val()+"' ) ";

            $('input[name="condition"]').val(condition);
            return true;
        }
	</script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
	<ul class="bread text-main" style="font-size: larger;">
		<li>车辆管理</li>
		<li>查询</li>
		<li>查询待续保车辆</li>
	</ul>
</div>

<form name="vehicleSele" action="/DZOMS/vehicle/vehicleSele" method="post"
	  class="definewidth m20" target="result_form" style="width: 100%;" onsubmit="return beforeSubmit()">
	<%
		Calendar ndt = Calendar.getInstance();
		ndt.add(Calendar.MONTH, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String cs = sdf.format(ndt.getTime());
	%>
	<input type="hidden" name="condition" value=" "/>
	<input type="hidden" name="url" value="/vehicle/insurance/vehicle_search_result.jsp" />
	<div class="line">
		<div class="panel  margin-small" >
			<div class="panel-head">
				查询条件
			</div>
			<div class="panel-body">
				<div class="line">
					<div class="xm12 padding">

						<blockquote class="panel-body">
							<table class="table" style="border: 0px;">
								<!--<tr>
                                    <td>车辆购入日期</td>
                                    <td><input type="text" id="vehicle.in_date" name="vehicle.inDate" class="input datepick" /></td>
                                </tr>
                                <tr>
                                    <td>车辆制造日期</td>
                                    <td><input type="text" id="vehicle.pd" name="vehicle.pd"  class="input datepick"/></td>

                                </tr>
                                  <tr>
                                    <td>承租人身份证号</td>
                                    <td><input type="text" id="vehicle.driver_id" name="vehicle.driverId" class="input" /></td>
                                </tr>-->
								<tr>
									<td style="border-top: 0px;">承租人</td>
									<td style="border-top: 0px;"><input type="text" id="driver_name" name="driverName" class="input"/></td>


									<td style="border-top: 0px;">归属部门</td>
									<td style="border-top: 0px;"><select name="vehicle.dept" class="input">
										<option value="">全部</option>
										<option value="一部">一部</option>
										<option value="二部">二部</option>
										<option value="三部">三部</option>
									</select></td>

									<td style="border-top: 0px;">车辆识别代码/车架号</td>
									<td style="border-top: 0px;"><input type="text" id="carframe_num" name="vehicle.carframeNum" class="input" /></td>

									<td style="border-top: 0px;">发动机号</td>
									<td style="border-top: 0px;"><input type="text" id="engine_num" name="vehicle.engineNum" class="input" /></td>

									<td style="border-top: 0px;">车牌号</td>
									<td style="border-top: 0px;"><input type="text" id="license_num" value="黑A" name="vehicle.licenseNum" class="input" /></td>

									<td style="border-top: 0px;">险种</td>
									<td style="border-top: 0px;"><select name="insuranceClass" class="input">
										<option value="all">全部</option>
										<option value="强险">交强险</option>
										<option value="商业">商险</option>
										<option value="承运">承运人责任险</option>
									</select></td>

									<td style="border-top: 0px;">截止日期</td>
									<td style="border-top: 0px;"><input type="text" name="insurance_end_date" class="input datepick" value="<%=cs%>" /></td>


									<td style="border-top: 0px;"><input type="submit" value="查询"></td>
								</tr>
								<!--<tr>
                                    <td>车辆型号</td>
                                    <td><input type="text" id="vehicle.car_mode" name="vehicle.carMode" class="input"/></td>
                                </tr>
                                <tr>
                                    <td class="tableleft">合格证编号</td>
                                    <td><input type="text" id="vehicle.certify_num" name="vehicle.certifyNum" class="input"/></td>
                                </tr>
                                <tr>
                                    <td class="tableleft">车牌号</td>
                                    <td><input type="text" id="vehicle.license_num" name="vehicle.licenseNum" class="input" /></td>
                                </tr>-->
							</table>
						</blockquote>
					</div>
				</div>
			</div>
		</div>
	</div>


</form>
<div>
	<iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

	</iframe>

</div>

<script type="text/javascript" >
    $(".datepick").datetimepicker({
        lang:"ch",           //语言选择中文
        format:"Y-m-d",      //格式化日期
        timepicker:false,    //关闭时间选项
        yearStart:2000,     //设置最小年份
        yearEnd:2100,        //设置最大年份
        //todayButton:false    //关闭选择今天按钮
        onClose:function(){
            $("[name='vehicleSele']").submit();
        }
    });
</script>
</body>
</html>
