<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java"
         import="java.util.*,com.dz.module.user.User"
         pageEncoding="UTF-8"%>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="com.dz.module.contract.ContractTemplate2" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="合同新增">
    <jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>合同创建</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
    <script type="text/javascript">
        function tablehide(){
            if($("#head").text()=="隐藏制定计划"){
                $("#head").text("显示制定计划");
            }
            else{
                $("#head").text("隐藏制定计划");
            }
            $(".hide").toggle();

        }

        function set_date(){
            if($("#enddate").val().trim().length==0){
                var arr = $("#startdate").val().split("/");
                var date = new Date();
                date.setFullYear(parseInt(arr[0])+8,arr[1]-1,arr[2]);
                date = new Date(date.getTime()-24*60*60*1000);
                //var enddate = ""+(parseInt(arr[0])+8)+"/"+arr[1]+"/"+arr[2];
                $("#enddate").val(date.format("yyyy/MM/dd"));
            }
            dateRefresh();
        }

        var monthArr = [31,28,31,30,31,30,31,31,30,31,30,31];
        //月份从0开始
        function getDaysOfMonth(year,month){
            if(month==1&&(year%400==0||(year%100!=0&&year%4==0))){
                return monthArr[month]+1;
            }
            return monthArr[month];
        }

        var months;

        //此处月份从1开始
        var beginMonth={
            "year":0,
            "month":0
        },endMonth={
            "year":0,
            "month":0
        };

        function dateRefresh() {
            var arr = $("#startdate").val().split("/");

            var startdate = {
                "year":parseInt(arr[0]),
                "month":parseInt(arr[1]),
                "date":parseInt(arr[2])
            };

            arr = $("#enddate").val().split("/");
            var enddate = {
                "year":parseInt(arr[0]),
                "month":parseInt(arr[1]),
                "date":parseInt(arr[2])
            };

            months = (enddate.year - startdate.year) * 12 + (enddate.month-startdate.month);

            //上月27-本月26 为一个月
            if(startdate.date<27) {
                months++;
                beginMonth.year = startdate.year;
                beginMonth.month = startdate.month;
            }else{
                if(startdate.month==12){
                    beginMonth.year = startdate.year+1;
                    beginMonth.month = 1;
                }else{
                    beginMonth.year = startdate.year;
                    beginMonth.month = startdate.month+1;
                }
            }

            if(enddate.date>=27){
                months++;
                if(enddate.month==12){
                    endMonth.year = enddate.year+1;
                    endMonth.month = 1;
                }else{
                    endMonth.year = enddate.year;
                    endMonth.month = enddate.month+1;
                }
            }else{
                endMonth.year = enddate.year;
                endMonth.month = enddate.month;
            }

//          if($("input[name='rentFirst_Month']").val()==""||$("input[name='rentFirst_Month']").val()=="NaN")
//          	$("input[name='rentFirst_Month']").val(months);


            /* var HTML = "<tr></th><th colspan=14 onclick='tablehide()'><h4  id='head'><p>隐藏制定计划</p></h4></th></tr>";

             HTML += "<tr class='hide'><th></th><th>1月</th><th>2月</th><th>3月</th><th>4月</th><th>5月</th><th>6月</th><th>7月</th><th>8月</th><th>9月</th><th>10月</th><th>11月</th><th>12月</th></tr>";
             for (i = 0; i <= enddate["year"]-startdate["year"]; i++) {
                 HTML += "<tr class='hide'><th>" + (startdate["year"]+i) + "年</th>";
                 for (j = 0; j < 12; j++) {
                     HTML += "<td><input type=\"text\" id=" + i + "," + j+ " size=\"10\" class='input' name='rentArr' value=\""+per_money+"\"/></td>";
                 }
                 HTML += "</tr>";
             }
             //alert(HTML);

             $("#plan").html(HTML);

             for (i = 0; i < startdate["month"] - 1; i++) {
                 $("#0," + i).attr("disabled", "disabled");
             }
             for (i = enddate["month"] - 1; i < 12; i++) {
                 $("#"+enddate["year"]-startdate["year"]+"," + i).attr("disabled", "disabled");
             }

             $("#plan input[disabled]").val("");*/
        }

        function delRentPlan(){
            var $selected_option = $("#rentList").find("option:selected");
            $selected_option.remove();
            geneRentPlanState=2;
        }

        function addRentItem(beginTime,endTime,rentAmount,comment){
            comment = comment || "";

            var $option = $('<option></option>');
            $option.append($('<input name="beginTime" readonly="readonly" style="display:none;"/>').val(beginTime));

            $option.append("" + beginTime);

            $option.append("--");
            $option.append($('<input name="endTime" readonly="readonly" style="display:none;"/>').val(endTime));

            $option.append("" + endTime);

            $option.append("\t￥");
            $option.append($('<input name="rentAmount" style="display:none;"/>').val(rentAmount));

            $option.append("" + rentAmount);

            $option.append("\t");
            $option.append($('<input name="comment" style="display:none;"/>').val(comment));

            $option.append("" + comment);

            $("#rentList").append($option);

            geneRentPlanState = 2;
        }

        function addRent(){
            var beginTime = $(".dialog-win .beginTime").val();
            var endTime = $(".dialog-win .endTime").val();
            var rentAmount = $(".dialog-win .rentAmount").val();
            var comment = $(".dialog-win .comment").val();

            if ($("#startdate").val() != beginTime ){
                if (!confirm("该约定起始日期为"+beginTime+",与合同起始日期"+$("#startdate").val()+"不同，是否继续？")){
                    return;
                }
            }
            if ($("#enddate").val() != endTime ){
                if (!confirm("该约定结束日期为"+endTime+",与合同结束日期"+$("#enddate").val()+"不同，是否继续？")){
                    return;
                }
            }

            addRentItem(beginTime,endTime,rentAmount,comment);
        }

        var dialogHTML;
        $(document).ready(function(){
            dialogHTML = $("#mydialog").html();
        });
        var geneRentPlanState = 0;
        function geneRentPlan(){
            var rentArr = [];
            for(var i=0;i<months;i++) rentArr.push(0);

            var planListArr=[];
            var hasContractBegin=false,hasContractEnd=false;
            $("#rentList option").each(function(){
                var begin = $(this).find("input[name='beginTime']").val();
                var end = $(this).find("input[name='endTime']").val();
                var money = $(this).find("input[name='rentAmount']").val();
                var comment = $(this).find("input[name='comment']").val();

                planListArr.push({"begin":begin,"end":end,"money":money,"comment":comment});

//		if($("#startdate").val()==begin){
//			hasContractBegin=true;
//		}
//		
//		if($("#enddate").val()==end){
//			hasContractEnd=true;
//		}

            });

//	if (!((hasContractBegin||confirm('合同开始日期'+$('#startdate').val()+'不在约定中，是否继续？'))&&
//		(hasContractEnd||confirm('合同结束日期'+$('#enddate').val()+'不在约定中，是否继续？'))) ){
//		return false;
//	}

            $("input[name='planList']").val($.toJSON(planListArr));

            $("#rentList option").each(function(){
                var begin = $(this).find("input[name='beginTime']").val();
                var end = $(this).find("input[name='endTime']").val();
                var money = $(this).find("input[name='rentAmount']").val();

                var beginArr = begin.split("/");
                var endArr = end.split("/");
                //这一段时间的起始月在数组中的位置
                var month_rank = (beginArr[0]-beginMonth.year)*12 + (beginArr[1]-beginMonth.month)+(beginArr[2]>26?1:0);
                var local_months = (endArr[0] - beginArr[0]) * 12 + (endArr[1] - beginArr[1])+(beginArr[2]<27?1:0)+(endArr[2]>26?1:0);

                for (var i=1;i<local_months-1;i++) {
                    rentArr[month_rank+i]+=parseFloat(money)*1.00;
                }

                if(local_months==1){
                    //这一段时间在一个月里面
                    var days = 0;
                    if(beginArr[2]==27&&endArr[2]==26){
                        days=30;
                    }else
                    if(beginArr[2]>26){
                        if(endArr[2]>26){
                            days = endArr[2] - beginArr[2] + 1;
                        }else{
                            //days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginArr[2]+1+parseInt(endArr[2]);
                            days = 31 - beginArr[2] + parseInt(endArr[2]) + (beginArr[2]>30?1:0);
                        }
                    }else{
                        days = endArr[2] - beginArr[2] + 1;
                    }
                    var planOfRent = parseFloat(money) /30 * days;
                    rentArr[month_rank] += planOfRent;/*.toFixed(2)*/
                }else{
                    //这一段时间分属不同的月
                    //第一个月
                    if(beginArr[2]==27){
                        days=30;
                    }else if(beginArr[2]>27){
                        //days = getDaysOfMonth(beginArr[0],beginArr[1]-1)-beginArr[2]+27;
                        days = 57 - beginArr[2] + (beginArr[2]>30?1:0);
                    }else{
                        days = 27 - beginArr[2];
                    }
                    var planOfRent = parseFloat(money) /30 * days;
                    rentArr[month_rank] += planOfRent;

                    //最后一个月
                    if(endArr[2]==26){
                        days=30;
                    }else if(endArr[2]>=30){
                        days = 4;
                    }else if(endArr[2]>26){
                        days = endArr[2] - 26;
                    }else{
                        //days = parseInt(getDaysOfMonth(endArr[0],endArr[1]-1))+parseInt(endArr[2])-26;
                        days = 4 + parseInt(endArr[2]);
                    }
                    planOfRent = parseFloat(money) /30 * days;
                    rentArr[month_rank+local_months-1] += planOfRent;
                }

            });

            $("#plan tr.data-tr").remove();

            var $plan = $("#plan");
            var rentArrIndex=0;
            if (beginMonth.year == endMonth.year) {
                var $tr = $('<tr class="hide data-tr"></tr>').append($("<td />").text(beginMonth.year+"年"));
                for (var month = 1;month<beginMonth.month;month++) {
                    var $td = $("<td />").text("  ").appendTo($tr);
                }
                for (var month = beginMonth.month;month<=endMonth.month;month++) {
                    var $td = $("<td />").appendTo($tr);
                    var $input = $('<input class="data-td input auto" size="10" />').val(rentArr[rentArrIndex++].toFixed(2)).appendTo($td);
                }
                for (var month = endMonth.month;month<12;month++) {
                    var $td = $("<td />").text("  ").appendTo($tr);
                }
                $plan.append($tr);
            }
            else{
                //首年
                var $tr = $('<tr class="hide data-tr"></tr>').append($("<td />").text(beginMonth.year+"年"));
                for (var month = 1;month<beginMonth.month;month++) {
                    var $td = $("<td />").text("  ").appendTo($tr);
                }
                for (var month = beginMonth.month;month<=12;month++) {
                    var $td = $("<td />").appendTo($tr);
                    var $input = $('<input class="data-td input auto" size="10" />').val(rentArr[rentArrIndex++].toFixed(2)).appendTo($td);
                }
                $plan.append($tr);

                //第二年 -- 倒数第二年
                for (var year = beginMonth.year+1;year<endMonth.year;year++) {
                    $tr = $('<tr class="hide data-tr"></tr>').append($("<td />").text(year+"年"));
                    for (var month = 1;month<=12;month++) {
                        var $td = $("<td />").appendTo($tr);
                        var $input = $('<input class="data-td input auto" size="10" />').val(rentArr[rentArrIndex++].toFixed(2)).appendTo($td);
                    }
                    $plan.append($tr);
                }

                //最后一年
                $tr = $('<tr class="hide data-tr"></tr>').append($("<td />").text(endMonth.year+"年"));
                for (var month = 1;month<=endMonth.month;month++) {
                    var $td = $("<td />").appendTo($tr);
                    var $input = $('<input class="data-td input auto " size="10" />').val(rentArr[rentArrIndex++].toFixed(2)).appendTo($td);
                }
                for (var month = endMonth.month;month<12;month++) {
                    var $td = $("<td />").text("  ").appendTo($tr);
                }
                $plan.append($tr);
            }

            geneRentPlanState = 1;
        }

        $(document).ready(function(){
            $("#contract_businessForm").change(function(){
                $("#purseForm").val($("#contract_businessForm").children(":selected").val());
            });

            $(".abandoned-form").hide();

            $("#vehicleApprovalCheckType").change(function(){
                var checkType = $("#vehicleApprovalCheckType").children(":selected").val();
                switch(checkType){
                    case "0":
                        $(".setup-form").show();
                        $(".abandoned-form").hide();
                        break;
                    case "1":
                        $(".setup-form").hide();
                        $(".abandoned-form").show();
                        break;
                    case "2":
                        $(".setup-form").show();
                        $(".abandoned-form").show();
                        break;
                }
            });

            var arr = $("#startdate").val().split("/");

            var startdate = {
                "year":parseInt(arr[0]),
                "month":parseInt(arr[1]),
                "date":parseInt(arr[2])
            };

            arr = $("#enddate").val().split("/");
            var enddate = {
                "year":parseInt(arr[0]),
                "month":parseInt(arr[1]),
                "date":parseInt(arr[2])
            };

            months = (enddate.year - startdate.year) * 12 + (enddate.month-startdate.month);

            //上月27-本月26 为一个月
            if(startdate.date<27) {
                months++;
                beginMonth.year = startdate.year;
                beginMonth.month = startdate.month;
            }else{
                if(startdate.month==12){
                    beginMonth.year = startdate.year+1;
                    beginMonth.month = 1;
                }else{
                    beginMonth.year = startdate.year;
                    beginMonth.month = startdate.month+1;
                }
            }

            if(enddate.date>=27){
                months++;
                if(enddate.month==12){
                    endMonth.year = enddate.year+1;
                    endMonth.month = 1;
                }else{
                    endMonth.year = enddate.year;
                    endMonth.month = enddate.month+1;
                }
            }else{
                endMonth.year = enddate.year;
                endMonth.month = enddate.month;
            }

        });
        //计算 第month_rank月之前有几天
        function calculateDays(rentDays,month_rank){
            var sum =0;
            for (var i = 0; i < month_rank; i++) {
                sum+=rentDays[i];
            }
            return sum;
        }
    </script>
    <style>
        .label{
            width: 120px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>合同</li>
        <li>合同新增</li>
        <li>合同新增--二手车转包</li>
    </ul>
</div>

<div class="padding">
    <form method="post" action="/DZOMS/contract/contractWrite" class="form-inline form-tips" style="width: 100%">
        <s:hidden name="contract.id"></s:hidden>
        <s:hidden name="contract.state" value="%{contract.state+1}"></s:hidden>
        <s:hidden name="contract.geneByImport"></s:hidden>

        <blockquote class="border-main">
            <strong>承租人信息</strong>

            <div class="line">
                <div class="xm2 padding">
                    <img src="image/driverhead.png" class="radius img-responsive">
                </div>
                <div class="xm10">
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车架号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield name="contract.carframeNum" readonly="readonly"/>
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
                            <s:textfield cssClass="input" name="contract.carNum" readonly="true"></s:textfield>
                        </div>
                    </div>
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
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                合同种类
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield name="contract.contractType" cssClass="input"/>
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                经营形式
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

                    <br>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                起始日期
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input datepick"  id="startdate" onBlur="set_date()" name="contract.contractBeginDate" data-validate="required:必填" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                终止日期
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" id="enddate"  name="contract.contractEndDate" readonly="true" />
                        </div>
                    </div>
                    <br>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                合同模版
                            </label>
                        </div>
                        <div class="field" >
                            <%
                                List<ContractTemplate2> templates = ObjectAccess.query(ContractTemplate2.class,null);
                            %>
                            <div class="input-group">
                                <select class="input" id="templateId">
                                    <option value="0">不使用</option>
                                    <%
                                        for (ContractTemplate2 s : templates) {
                                            if(s.isEnabled()){
                                    %>
                                    <option value="<%=s.getId()%>"><%=s.getName()%></option>
                                    <%      }
                                        }
                                    %>
                                </select>
                                <div class="addbtn">
                                    <div class="button-group">
                                        <input type="button" id="addToRentBtn" class="button" value="应用模版">
                                    </div>
                                </div>
                            </div>
                            <script>
                                $(document).ready(function(){
                                    $("#addToRentBtn").click(function(){
                                        $.post("/DZOMS/contract/template2/template_json.jsp",{
                                            id:$("#templateId").val(),
                                            beginDate:$("#startdate").val(),
                                            endDate:$("#enddate").val()
                                        },function(data){
                                            if(data!=null && data.rentlist!=null){
                                                $('input[name="contract.rentFirst"]').val(data['rentFirst']);
                                                $('input[name="rentFirst_Month"]').val(data['rentDivideStages']);
                                                $('input[name="contract.deposit"]').val(data['deposit']);

                                                for(var i=0;i<data['rentlist'].length;i++){
                                                    addRentItem(data['rentlist'][i]["from"],data['rentlist'][i]["to"],data['rentlist'][i]["rent"]);
                                                }
                                            }
                                        })
                                    });
                                });
                            </script>
                        </div>
                    </div>
                    <br>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                一次性预付租金
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" name="contract.rentFirst" data-validate="required:必填"/>
                        </div>
                    </div>
                    <!-- <div class="form-group">
                        <div class="label padding">
                            <label>
                                每月上调费用
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" name="rentEachMonth" />
                        </div>
                    </div>-->
                    <!--<div class="form-group">
                        <div class="label padding">
                            <label>
                                摊销月数
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" name="rentFirst_Month" />
                            <input type="hidden" name="rentFirst_MonthEach" />
                        </div>
                    </div>-->
                    <br />
                    <div class="form-group">
                        <s:hidden name="contract.discountDays" value="0"></s:hidden>
                        <div  style="width: 100%">
                            <div class="float-left" style="width: 80px; text-align: right;">
                                <strong>租金计划</strong>
                            </div>
                            <div class="float-left">
                                <select  id="rentList" size="5" style="width: 400px;"  class="float-left"></select>
                            </div>
                        </div>

                        <div class="form-group margin-small">
                            <div class="margin-small">
                                <a id="add_rent_but"  class="button dialogs bg-gray margin" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%">添加</a>
                            </div>
                            <div class="margin-small">
                                <a class="button input-file bg-blue" href="javascript:void(0);" onclick="delRentPlan()">删除</a>
                            </div>
                            <div class="margin-small">
                                <a class="button input-file bg-blue" href="javascript:void(0);" onclick="geneRentPlan()">生成租金计划</a>
                            </div>
                        </div>
                    </div>
                    <br>


                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                定金
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" name="contract.deposit" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                服务保证金
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield type="text" name="contract.feeAlter" cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',contract.idNum).fuwubaozhengjin}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                违约金
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input" name="contract.penalty" />
                        </div>
                    </div>
                    <br>


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

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                是否更新车辆
                            </label>
                        </div>
                        <div class="field" >
                            <input value="否" readonly="readonly">
                        </div>
                    </div>
                    <s:if test="%{contract.contractFrom!=null}">
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    原车牌号
                                </label>
                            </div>
                            <div class="field">
                                <s:hidden name="contract.contractFrom"></s:hidden>
                                <s:if test="%{contract.contractFrom!=null}">
                                    <s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract',contract.contractFrom).carNum}"></s:textfield>
                                </s:if>
                            </div>
                        </div>
                    </s:if>

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
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                电话号码
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input"  name="driver.phoneNum1" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                驾驶证号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input"  name="driver.drivingLicenseNum" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                资格证号
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input"  name="driver.qualificationNum" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                证件地址
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input input-auto" size="40" name="driver.accountLocation" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                归属区域
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input input-auto" size="40"  name="driver.accountLocation" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                现居住地
                            </label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input input-auto" size="40"  name="driver.address" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                备注
                            </label>
                        </div>
                        <div class="field">
                            <s:textarea  name="contract.remark" cssClass="input"></s:textarea>
                        </div>
                    </div>
                </div>
            </div>
        </blockquote>
        <br>
        <blockquote class="border-main">
            <strong>担保人信息</strong>
            <div class="line">
                <div class="xm2 padding">
                    <img src="image/driverhead.png" class="radius img-responsive">
                </div>
                <div class="xm10">
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                身份证号
                            </label>
                        </div>
                        <div class="field" >
                            <input class="input" name="contract.identityGuarantor"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                担保人
                            </label>
                        </div>
                        <div class="field" >
                            <input class="input" name="contract.guarantorName" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                电话号码
                            </label>
                        </div>
                        <div class="field" >
                            <input class="input" name="contract.phoneNumGuarantor" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                证件地址
                            </label>
                        </div>
                        <div class="field" >
                            <input class="input input-auto" size="40" name="contract.addressLicenseGuarantor" />
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                现居地址
                            </label>
                        </div>
                        <div class="field">
                            <input class="input input-auto" name="contract.addressCurrentGuarantor"  size="40"/>
                        </div>
                    </div>

                </div>
            </div>
        </blockquote>
        <br>
        <!--<table class="table table-bordered table-hover m10" id="plan">

        </table>-->
        <input type="hidden" name="rentArr" />
        <input type="hidden" name="planList" />
        <div class="xm11-move ">
            <input class="button bg-green button-big submitbutton" type="button" value="保存"/>
        </div>
        <input type="submit" style="display: none;" id="submit-button"/>
    </form>
    <table class="table table-bordered table-hover m10" id="plan">
        <tr></th><th colspan=14 onclick='tablehide()'><h4  id='head'><p>隐藏制定计划</p></h4></th></tr>
        <tr class='hide'><th></th><th>1月</th><th>2月</th><th>3月</th><th>4月</th><th>5月</th><th>6月</th><th>7月</th><th>8月</th><th>9月</th><th>10月</th><th>11月</th><th>12月</th></tr>
    </table>
</div>
<div id="mydialog">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>租金计划</strong>
        </div>
        <div class="dialog-body">
            <div>
                <strong>起始日期</strong>
                <input class="datepick2 input beginTime" />
                <strong>结束时间</strong>
                <input  class="datepick2 input endTime"/>
                <strong>租金数额</strong>
                <input class="input rentAmount" />
                <strong>备注</strong>
                <input class="input comment" />
            </div>
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close"> 取消</button>
            <button class="button bg-green dialog-close" onclick="addRent()">添加</button>
        </div>
    </div>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
<script type="text/javascript" src="/DZOMS/res/jquery-ui/jquery-ui.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/jquery-ui/jquery-ui.css" />
<script>
    var geneRentPlanStateMsgArr = ["未生成租金计划！","正常","租金计划已修改，请重新生成！"];
    function beforeSubmit(){

        if (geneRentPlanState!=1) {
            alert(geneRentPlanStateMsgArr[geneRentPlanState]);
            return false;
        }

        //计算每月的数值并验证、提交
        var rentArr = [];

        $("#plan input.data-td").each(function(){
            rentArr.push($(this).val());
        });

        //验证 是否有空余月份未计费
        var hasNotFilled = rentArr.indexOf(0);
        if(hasNotFilled>=0){
            var nyear = beginMonth.year + (hasNotFilled/12-0.5).toFixed(0);
            var nmonth = hasNotFilled - (hasNotFilled/12-0.5).toFixed(0)*12 + beginMonth.month;
            if(nmonth>12){
                nyear++;
                nmonth-=12;
            }
            alert(""+nyear+"/"+nmonth+"未计费！");
        }else{
            var rentArrJsonStr = $.toJSON(rentArr);
            $("input[name='rentArr']").val(rentArrJsonStr);

            //预付租金摊销
            /*var per_money = parseFloat($("input[name='contract.rentFirst']").val()) / months;
               per_money = per_money.toFixed(2);
            $("input[name='rentFirst_MonthEach']").val(per_money);*/

            $('#submit-button').click();
        }
    }

    function getInfo(){
        var info = '<p>请确认本次输入的信息：</p>';
        info += '<p>合同开始日期：'+$("#startdate").val()+'&nbsp;&nbsp;合同终止日期：'+$("#enddate").val()+'&nbsp;&nbsp;</p>';
        $("#rentList option").each(function(index){
            var begin = $(this).find("input[name='beginTime']").val();
            var end = $(this).find("input[name='endTime']").val();
            var money = $(this).find("input[name='rentAmount']").val();
            var comment = $(this).find("input[name='comment']").val();
            info += '<p>约定'+(index+1)+':&nbsp;&nbsp;开始日期：'+begin+':&nbsp;&nbsp;终止日期：'+end+':&nbsp;&nbsp;金额：'+money+'&nbsp;&nbsp;</p>';
        });

        return info;
    }

    //button_bind(".submitbutton","确定提交?","beforeSubmit()");
    button_bind_html(".submitbutton",getInfo,"beforeSubmit()");

    function doSubmit(){
        $('#submit-button').click();
    }



    $(function(){
        $showdialogs=function(e){
            var trigger=e.attr("data-toggle");
            var getid=e.attr("data-target");
            var data=e.attr("data-url");
            var mask=e.attr("data-mask");
            var width=e.attr("data-width");
            var functionName = e.attr("data-function");
            var detail="";
            var masklayout=$('<div class="dialog-mask"></div>');
            if(width==null){width="80%";}

            if (mask=="1"){
                $("body").append(masklayout);
            }
            detail='<div class="dialog-win" style="position:fixed;width:'+width+';z-index:11;">';
            if(getid!=null){detail=detail+$(getid).html();}
            if(data!=null){detail=detail+$.ajax({url:data,async:false}).responseText;}
            detail=detail+'</div>';

            var win=$(detail);
            win.find(".dialog").addClass("open");
            $("body").append(win);
            var x=parseInt($(window).width()-win.outerWidth())/2;
            var y=e.offset().top - win.outerHeight()/2;

            if(functionName!=undefined&&functionName!=null){
                var info = eval(functionName+"()");
                win.find(".dialog").find('.dialog-body').html(info);
            }

            if (y<=10){y="10"}
            win.css({"left":x,"top":y});
            win.find(".dialog-close,.close").each(function(){
                $(this).click(function(){
                    win.remove();
                    $('.dialog-mask').remove();
                    $("#mydialog").html(dialogHTML);
                });
            });
            masklayout.click(function(){
                win.remove();
                $(this).remove();
            });

            $.datepicker.setDefaults($.datepicker.regional['']);//先清理一下语言包的regional
            $(".datepick2.beginTime").datepicker({
                showMonthAfterYear: true,
                onSelect : function(dateText, inst){
                    $(".datepick2.endTime").datepicker("option","minDate",dateText);
                }
            });
            $(".datepick2.endTime").datepicker({
                showMonthAfterYear: true,
                onSelect : function(dateText, inst){
                    $(".datepick2.beginTime").datepicker("option","maxDate",dateText);
                }
            });
            //$(".datepick2").datepicker(/*{ altFormat: 'yy/mm/dd' }*/{showMonthAfterYear: true});
            $(".datepick2").datepicker('option', $.datepicker.regional['zh-CN']);
            $(".datepick2").datepicker('option', 'dateFormat','yy/mm/dd');

            var startDate,endDate;
            var arr = $("#startdate").val().split("/");
            startDate = new Date(arr[0],arr[1]-1,arr[2]);
            arr = $("#enddate").val().split("/");
            endDate = new Date(arr[0],arr[1]-1,arr[2]);

            $(".datepick2").datepicker("option","minDate",startDate);
            $(".datepick2").datepicker("option","maxDate",endDate);
            $('.datepick2').datepicker('option', 'changeYear', true);
            $('.datepick2').datepicker('option', 'changeMonth', true);

        };
    });
</script>
</html>