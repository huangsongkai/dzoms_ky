<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Page pg = (Page)request.getAttribute("page");
%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="合同新增,合同查询,合同修改权限" any="true">
    <jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>查询结果</title>

    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
    <script>
        $(document).ready(function(){
            $("#show_div").find("input").change(resetClass);

            resetClass();
        });

        function resetClass(){
            $(".selected_able").hide();
            var selects = [];
            $("input[name='sbx']:checked").each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
                selects.push($(this).val());//将选中的值添加到数组chk_value中
            });

            for(var i = 0;i<selects.length;i++){
                $("."+selects[i]).show();
            }
        }

        function _detail(){
            //提前摊销
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
            var input = "";
            while (!/20[0-9]{2}-(0[1-9])|(1[0-2])/.test(input)){
                input = prompt("请输入提前摊销月份：(格式：YYYY-MM),取消操作则输入Q");
                if(input.indexOf("Q")>=0)
                    return;
            }

            var url = "/DZOMS/contract/resetRentFirstDivide?contract.id="+selected_val+"&resetMonth="+input;
            $.get(url,function(data){
                if(data.state==true){
                    alert("提前摊销成功，请刷新页面。")
                }else {
                    alert("操作失败，"+data.msg);
                }
            });
        }

        function _update(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined)
                alert('您没有选择任何一条数据');
            var url = "/DZOMS/contract/contractPreUpdate1?contract.id="+selected_val;
            window.open(url,"合同修改",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _updateContractId(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined)
                alert('您没有选择任何一条数据');
            var url = "/DZOMS/contract/contractPreUpdateContractId?contract.id="+selected_val;
            window.open(url,"档案号修改",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _toExcel(){
            var path = $("[name='vehicleSele']").attr("action");
            var target = $("[name='vehicleSele']").attr("target");

            var url = "/DZOMS/contractToExcel";
            $("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();
        }

        function _toPrint(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined)
                alert('您没有选择任何一条数据');
            var url = "/DZOMS/driver/driverPreprint?driver.idNum="+selected_val;
            window.open(url,"驾驶员打印",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function toBeforePage(){
            var currentPage = parseInt($("input[name='currentPage']").val());
            if(currentPage==1){
                alert("没有上一页了。");
                return ;
            }
            $("input[name='currentPage']").val($("input[name='currentPage']").val()-1);
            document.vehicleSele.submit();
        }

        function toNextPage(){
            var currentPage = parseInt($("input[name='currentPage']").val());
            if(currentPage==<%=pg.getTotalPage()%>){
                alert("没有下一页了。");
                return ;
            }
            $("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val())+1);
            document.vehicleSele.submit();
        }

        function toPage(pg){

            $("input[name='currentPage']").val(pg);
            document.vehicleSele.submit();
        }

        $(document).ready(function(){
            var currentPage = parseInt($("input[name='currentPage']").val());
            $("#page-input").val(currentPage + "/<%=pg.getTotalPage()%>");

            $("#page-input").change(function(){

                var pg_num = parseInt($("#page-input").val());
                toPage(pg_num);
            });

            $("#page-input").focus(function(){
                $(this).val("");
            });
        });
    </script>
</head>
<body>
<div>
    <div class="panel  margin-small" >
        <div class="panel-head">
            <div class="line">
                <div class="xm2">
                    查询结果合计：<%=pg.getTotalCount() %>条记录
                </div>
                <div class="xm6 xm4-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                                提前摊销</button>
                            <%--<button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">--%>
                                <%--导出</button>--%>
                            <!--<button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                                      打印</button>-->
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="panel-body">
            <table class="table table-hover table-bordered  table-striped">
                <tr>
                    <th>选择</th>
                    <th class="contractId  selected_able">合同档案号</th>
                    <th class="licenseNum  selected_able">车牌号</th>
                    <th class="beginDate  selected_able">合同开始日期</th>
                    <th class="endDate  selected_able">合同终止日期</th>
                    <th class="abandonedTime  selected_able">实际终止日期</th>
                    <th class="branchFirm  selected_able">部门</th>
                    <th class="deposit  selected_able">摊销月数</th>
                    <th class="rentFirst  selected_able">预付租金总额</th>
                    <th>当前月份</th>
                    <th>本期摊销额</th>
                    <th>已摊销月数</th>
                    <th>累计摊销额</th>
                    <th>未摊销月数</th>
                    <th>未摊销总额</th>
                    <th class="state  selected_able">是否废止</th>
                    <th class="abandonReason  selected_able">废止种类</th>
                </tr>
                <s:if test="%{#request.list!=null}">
                    <s:iterator value="%{#request.list}" var="x">
                        <s:set name="v" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract', #x.contractId)}"></s:set>
                        <s:set name="vp" value="%{@com.dz.common.other.ObjectAccess@execute('from VehicleApproval where checkType=1 and contractId='+#v.id)}"></s:set>
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value="%{#v.id}" />" ></td>
                            <td class="contractId	  selected_able"><s:property value="%{#v.contractId}" />          </td>
                            <td class="licenseNum	  selected_able"><s:property value='%{#v.carNum}'/></td>
                            <td class="beginDate	  selected_able"><s:property value="%{#v.contractBeginDate}" />     </td>
                            <td class="endDate		  selected_able"><s:property value="%{#v.contractEndDate}" />           </td>
                            <td class="abandonedTime  selected_able"><s:property value="%{#v.abandonedFinalTime}" />         </td>
                            <td class="branchFirm	  selected_able"><s:property value="%{#v.branchFirm}" />   </td>

                            <td class="deposit		  selected_able"><s:property value="%{#x.total_months}" /> </td>
                            <td class="rentFirst	  selected_able"><s:property value="%{#x.total_money}" /></td>
                            <td><s:date name="new java.util.Date()" format="yyyy-MM" /></td>
                            <td><s:property value="%{#x.current_account}"/></td>
                            <td><s:property value="%{#x.finsh_months}"/></td>
                            <td><s:property value="%{#x.finsh_account}"/></td>
                            <td><s:property value="%{#x.total_months - #x.finsh_months}"/></td>
                            <td><s:property value="%{#x.total_money - #x.finsh_account}"/></td>

                            <td class="state		  selected_able"><s:property value="%{#v.state==1?'是':'否'}" />  </td>
                            <td class="abandonReason  selected_able">
                                [
                                <s:if test="#vp.handleMatter">
                                    转包
                                </s:if>
                                <s:else>
                                    废业
                                </s:else>
                                ]
                                <s:property value="%{#v.abandonReason}" />
                            </td>
                        </tr>
                    </s:iterator>
                </s:if>
            </table>

            <s:if test="%{#request.list!=null}">

                <div class="line padding">
                    <div class="xm5-move">
                        <div>
                            <ul class="pagination">
                                <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                            </ul>
                            <ul class="pagination pagination-group">
                                <li style="border: 0px;">
                                    <form>
                                        <div class="form-group">
                                            <div class="field">
                                                <input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>" id="page-input" >
                                            </div>
                                        </div>
                                    </form>
                                </li>
                            </ul>
                            <ul class="pagination">
                                <li><a href="javascript:toNextPage()">下一页</a></li>
                            </ul>

                        </div>
                    </div>
                </div>
            </s:if>
            <s:else>
                无查询结果
            </s:else>
        </div>
        <div class="panel-foot border-red-light bg-red-light">

        </div>
    </div>
    <div class="panel  margin-small" >
        <div class="panel-head">
            显示项
        </div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="contractId" checked="checked"><span class="icon icon-check text-green"></span>合同档案号     </label>
                <label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号         </label>
                <label class="button "><input type="checkbox" name="sbx" value="carframeNum"><span class="icon icon-check text-green"></span>车架号       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="idName" checked="checked"><span class="icon icon-check text-green"></span>承包人         </label>
                <label class="button "><input type="checkbox" name="sbx" value="idNumber"><span class="icon icon-check text-green"></span>身份证号码     </label>

                <label class="button active"><input type="checkbox" name="sbx" value="beginDate" checked="checked"><span class="icon icon-check text-green"></span>合同开始日期   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="endDate" checked="checked"><span class="icon icon-check text-green"></span>合同终止日期   </label>
                <label class="button"><input type="checkbox" name="sbx" value="abandonedTime"><span class="icon icon-check text-green"></span>实际终止日期   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="branchFirm" checked="checked"><span class="icon icon-check text-green"></span>部门     </label>
                <label class="button active"><input type="checkbox" name="sbx" value="rentFirst" checked="checked"><span class="icon icon-check text-green"></span>一次性预付租金 </label>
                <label class="button active"><input type="checkbox" name="sbx" value="deposit"  checked="checked"><span class="icon icon-check text-green"></span>摊销月数           </label>
                <label class="button active"><input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>是否废止       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="abandonReason" checked="checked"><span class="icon icon-check text-green"></span>废止种类       </label>
            </div>

        </div>

    </div>
    <form action="/DZOMS/contract/searchRentFirstDivide" method="post" name="vehicleSele">
        <s:hidden name="url"></s:hidden>
        <s:hidden name="contract.carNum" />
        <s:hidden name="contract.idNum" />
        <s:hidden name="beginDateStart" />
        <s:hidden name="beginDateEnd" />
        <s:hidden name="endDateStart" />
        <s:hidden name="endDateEnd" />
        <s:hidden name="dept" />
        <s:hidden name="carNum" />
        <s:hidden name="idNum"></s:hidden>
        <s:hidden name="states" value="%{#parameters.states}"/>
        <s:hidden name="order"></s:hidden>
        <s:hidden name="rank"></s:hidden>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
    </form>
</div>
</body>
</html>
