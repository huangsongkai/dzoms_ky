<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>单车收费查询</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <style>
        .plan{
            background-color:yellow
        }

        .pay{
            background-color:Chartreuse
        }
    </style>
    <script>
        function setDept(){
            var licenseNum = $("#licenseNum").val();
            if(licenseNum != undefined && licenseNum != ""){
                $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{'vehicle.licenseNum':licenseNum},function (data){
                    data = $.parseJSON(data);
                    data = data["ItemTool"]["carframeNum"];
                    $.post("/DZOMS/selectContractByCarId",{'contract.carframeNum':data},function(dat){
                        $("#dept").val(dat["branchFirm"]);
                    });
                });
            }
        }
        $.ready(function(){
            setDept();
        });
        function search_(){
            $("#form").attr("action","/DZOMS/charge/getACarChargeTable");
            $("#form").submit();
        }
        function exportxls(){
            $("#form").attr("action","/DZOMS/charge/exportACarChargeTable");
            $("#form").submit();
        }

        var isShow=true;
        function tiggerPlans(){
            if (isShow) {
                $("tr.plan").hide();
            } else{
                $("tr.plan").show();
            }

            isShow = ! isShow;
        }

        $(document).ready(function(){
            tiggerPlans();
        });
    </script>
</head>
<body>
<form method="post" id="form" style="width: 100%;" action="/DZOMS/charge/getACarChargeTable" class="form-inline form-tips">
    <div class="padding" style="height:600px; overflow:auto">
        <div class="panel">
            <div class="panel-head">
                <strong>查询条件</strong>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input input-auto" size="9" value="%{licenseNum}" name="licenseNum" placeholder="车牌号" id="licenseNum" onblur="setDept()"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门：
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto" size="4" id="dept" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            起始年月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input  datepick  input-auto" size="12" name="timePass.startTime">
                            <s:param name="value">
                                <s:date name="timePass.startTime" format="yyyy/MM"/>
                            </s:param>
                        </s:textfield>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            结束年月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input  datepick input-auto" size="12"   name="timePass.endTime" >
                            <s:param name="value">
                                <s:date name="timePass.endTime" format="yyyy/MM"/>
                            </s:param>
                        </s:textfield>                </div>
                </div>
                <input type="button" class="button bg-green" value="查询" onclick="search_()"/>
                <input type="button" class="button bg-green" value="导出" onclick="exportxls()"/>
            </div>
        </div>
        <br>
        <div class="panel">
            <div class="panel-head">
                <strong>查询结果</strong><input type="button" class="button" onclick="tiggerPlans()" value="显示/隐藏计划详情"></input>
            </div>
            <div class="panel-body" >
                <div>
                    <table class="table table-bordered table-responsive">
                        <tr>
                            <th>年月</th>
                            <th>车牌号</th>
                            <th>司机</th>
                            <th>身份证</th>
                            <th>计划总额</th>
                            <th>银行</th>
                            <th>现金</th>
                            <th>保险</th>
                            <th>油补</th>
                            <th>其他</th>
                            <th>收入合计</th>
                            <th>上月存款</th>
                            <th>本月累计存款</th>
                        </tr>
                        <%List<CheckTablePerCar> tables = (List<CheckTablePerCar>)request.getAttribute("a_car_table");%>
                        <%BigDecimal bd1 = new BigDecimal(0.00);%>
                        <%BigDecimal bd2 = new BigDecimal(0.00);%>
                        <%BigDecimal bd3 = new BigDecimal(0.00);%>
                        <%BigDecimal bd4 = new BigDecimal(0.00);%>
                        <%BigDecimal bd5 = new BigDecimal(0.00);%>
                        <%BigDecimal bd6 = new BigDecimal(0.00);%>
                        <%BigDecimal bd7 = new BigDecimal(0.00);%>
                        <%BigDecimal bd8 = new BigDecimal(0.00);%>
                        <%BigDecimal bd9 = new BigDecimal(0.00);%>
                        <%BigDecimal bd10 = new BigDecimal(0.00);%>
                        <%for(CheckTablePerCar record:tables){%>
                        <tr>
                            <%Calendar cal = Calendar.getInstance();cal.setTime(record.getTime());%>
                            <td><%=cal.get(Calendar.YEAR)+"年"+(cal.get(Calendar.MONTH)+1)+"月"%></td>
                            <td><%=record.getCarNumber()%></td>
                            <td><%=record.getDriverName()%></td>
                            <td><%=record.getDriverId()%></td>
                            <td><%=record.getPlanAll()%></td>
                            <%bd1 = bd1.add(record.getPlanAll());%>
                            <td><%=record.getBank()%></td>
                            <%bd2 = bd2.add(record.getBank());%>
                            <td><%=record.getCash()%></td>
                            <%bd3 = bd3.add(record.getCash());%>
                            <td><%=record.getInsurance()%></td>
                            <%bd4 = bd4.add(record.getInsurance());%>
                            <td><%=record.getOil()%></td>
                            <%bd5 = bd5.add(record.getOil());%>
                            <td><%=record.getOther()%></td>
                            <%bd6 = bd6.add(record.getOther());%>
                            <td><%=record.getRealAll()%></td>
                            <%bd7 = bd7.add(record.getRealAll());%>
                            <td><%=record.getLeft()==null?new BigDecimal(0.00):record.getLeft()%></td>
                            <%bd8 = bd8.add(record.getLeft()==null?new BigDecimal(0.00):record.getLeft());%>
                            <td><%=record.getThisMonthLeft().add(record.getLeft()==null?new BigDecimal(0.00):record.getLeft())%></td>
                            <%bd9 = bd9.add(record.getThisMonthLeft()==null?new BigDecimal(0.00):record.getThisMonthLeft());%>
                        </tr>
                        <%}%>
                        <tr>
                            <th>合计</th>
                            <th>-</th>
                            <th>-</th>
                            <th>-</th>
                            <th><%=bd1%></th>
                            <th><%=bd2%></th>
                            <th><%=bd3%></th>
                            <th><%=bd4%></th>
                            <th><%=bd5%></th>
                            <th><%=bd6%></th>
                            <th><%=bd7%></th>
                            <th><%=bd8%></th>
                            <th><%=bd9.add(bd8)%></th>
                    </table>
                </div>

                <hr></hr>

                <div>
                    <%for(CheckTablePerCar record:tables){%>
                    <div>
                        <%Calendar cal = Calendar.getInstance();cal.setTime(record.getTime());%>
                        <p><h2><%=cal.get(Calendar.YEAR)+"年"+(cal.get(Calendar.MONTH)+1)+"月"%></h2></p>
                        <table class="table table-bordered table-responsive">
                            <tr>
								<th>内部ID</th>
                                <th>车牌号</th>
                                <th>司机</th>
                                <th>身份证</th>
                                <th>类型</th>
                                <th>数额</th>
                            </tr>
                            <%for(ChargePlan plan : record.getPlans()){ %>
                            <%boolean isSub = false;boolean isPlan = true;//计划为黄色 收入为蓝色
                                String chargeType=null;
                                switch(plan.getFeeType()){
                                    case "plan_base_contract":
                                        chargeType=("银行计划");
                                        break;
                                    case "plan_add_insurance":
                                        chargeType=("保费调整");
                                        break;
                                    case "plan_sub_insurance":
                                        chargeType=("保费调整");
                                        isSub = true;
                                        break;
                                    case "plan_add_contract":
                                        chargeType=("合同费用调整");
                                        break;
                                    case "plan_sub_contract":
                                        chargeType=("合同费用调整");
                                        isSub = true;
                                        break;
                                    case "plan_add_other":
                                        chargeType=("其它费用调整");
                                        break;
                                    case "plan_sub_other":
                                        chargeType=("其它费用调整");
                                        isSub = true;
                                        break;
                                    case "add_bank":
                                        chargeType=("哈尔滨银行回款");
                                        isPlan = false;
                                        break;
                                    case "add_bank2":
                                        chargeType=("招商银行回款");
                                        isPlan = false;
                                        break;
                                    case "add_cash":
                                        chargeType=("现金回款");
                                        isPlan = false;
                                        break;
                                    case "add_oil":
                                        chargeType=("油补回款");
                                        isPlan = false;
                                        break;
                                    case "add_insurance":
                                        chargeType=("保险转入");
                                        isPlan = false;
                                        break;
                                    case "add_other":
                                        chargeType=("其它回款");
                                        isPlan = false;
                                        break;
                                    case "sub_oil":
                                        chargeType=("油补取款");
                                        isPlan = false;
                                        isSub = true;
                                        break;
                                    case "sub_insurance":
                                        chargeType=("保险取款");
                                        isPlan = false;
                                        isSub = true;
                                        break;
                                }

                                if(chargeType==null)
                                    continue;
                            %>
                            <tr class="<%=isPlan?"plan":"pay"%>" >
								<td><%=plan.getId()%></td>
                                <td><%=record.getCarNumber()%></td>
                                <td><%=record.getDriverName()%></td>
                                <td><%=record.getDriverId()%></td>
                                <td><%=chargeType %></td>
                                <td><%=isSub?plan.getFee().negate():plan.getFee() %></td>
                            </tr>
                            <%} %>
                        </table>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>


    </div>

</form>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datepick').simpleCanleder();
</script>
</html>
