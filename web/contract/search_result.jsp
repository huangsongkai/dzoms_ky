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
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }

            var url = "/DZOMS/contract/contractPreShow?contract.id="+selected_val;
            window.open(url,"合同明细",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _update(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
            var url = "/DZOMS/contract/contractPreUpdate1?contract.id="+selected_val;
            window.open(url,"合同修改",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _updateContractId(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
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
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
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
                                查看</button>
                            <s:if test="#session.roles.{?#this.rname=='合同修改权限'}.size>0">
                                <button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                    修改</button>
                            </s:if>
                            <s:if test="#session.roles.{?#this.rname=='合同档案号修改权限'}.size>0">
                                <button onclick="_updateContractId()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                    修改档案号</button>
                            </s:if>
                            <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
                                导出</button>
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
                    <th class="contractId  selected_able">合同档案号                    </th>
                    <th class="licenseNum  selected_able">车牌号                    </th>
                    <th class="idName  selected_able">承包人                    </th>
                    <th class="idNumber  selected_able">身份证号码                    </th>
                    <th class="phoneNum  selected_able">手机号码                    </th>
                    <th class="beginDate  selected_able">合同开始日期                    </th>
                    <th class="endDate  selected_able">合同终止日期                    </th>
                    <th class="abandonedTime  selected_able">实际终止日期                    </th>
                    <th class="businessForm  selected_able">承包形式                    </th>
                    <th class="branchFirm  selected_able">分公司归属                    </th>
                    <th class="ascription  selected_able">营运手续归属                    </th>
                    <th class="rentFirst  selected_able">一次性预付租金                    </th>
                    <th class="deposit  selected_able">定金                    </th>
                    <th class="contractFrom  selected_able">合同种类                    </th>
                    <th class="state  selected_able">是否废止                    </th>
                    <th class="abandonReason  selected_able">废止种类                    </th>

                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <s:set name="driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver', #v.idNum)}"></s:set>
                        <s:set name="vp" value="%{@com.dz.common.other.ObjectAccess@execute('from VehicleApproval where checkType=1 and contractId='+#v.id)}"></s:set>
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value="%{#v.id}" />" ></td>
                            <td class="contractId	  selected_able"><s:property value="%{#v.contractId}" />          </td>
                            <td class="licenseNum	  selected_able"><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle",#v.carframeNum).licenseNum}'/></td>
                            <td class="idName  		  selected_able">
                                <s:property value='%{#driver.name}'/>
                            </td>
                            <td class="idNumber 	  selected_able"><s:property value="%{#v.idNum}" />     </td>
                            <td class="phoneNum 	  selected_able">
                                <s:property value='%{#driver.phoneNum1}'/>
                            </td>
                            <td class="beginDate	  selected_able"><s:property value="%{#v.contractBeginDate}" />     </td>
                            <td class="endDate		  selected_able"><s:property value="%{#v.contractEndDate}" />           </td>
                            <td class="abandonedTime  selected_able"><s:property value="%{#v.abandonedFinalTime}" />         </td>
                            <td class="businessForm   selected_able"><s:property value="%{#v.businessForm}" />     </td>
                            <td class="branchFirm	  selected_able"><s:property value="%{#v.branchFirm}" />   </td>
                            <td class="ascription	  selected_able"><s:property value="%{#v.ascription?'个人':'公司'}" />    </td>
                            <td class="rentFirst	  selected_able"><s:property value="%{#v.rentFirst}" />        </td>
                            <td class="deposit		  selected_able"><s:property value="%{#v.deposit}" /> </td>
                            <td class="contractFrom	  selected_able"><s:property value="%{#v.contractType}" />     </td>
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
                <label class="button active"><input type="checkbox" name="sbx" value="idName" checked="checked"><span class="icon icon-check text-green"></span>承包人         </label>
                <label class="button "><input type="checkbox" name="sbx" value="idNumber"><span class="icon icon-check text-green"></span>身份证号码     </label>
                <label class="button "><input type="checkbox" name="sbx" value="phoneNum"><span class="icon icon-check text-green"></span>手机号码       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="beginDate" checked="checked"><span class="icon icon-check text-green"></span>合同开始日期   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="endDate" checked="checked"><span class="icon icon-check text-green"></span>合同终止日期   </label>
                <label class="button"><input type="checkbox" name="sbx" value="abandonedTime"><span class="icon icon-check text-green"></span>实际终止日期   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="businessForm" checked="checked"><span class="icon icon-check text-green"></span>承包形式       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="branchFirm" checked="checked"><span class="icon icon-check text-green"></span>分公司归属     </label>
                <label class="button active"><input type="checkbox" name="sbx" value="ascription" checked="checked"><span class="icon icon-check text-green"></span>营运手续归属   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="rentFirst" checked="checked"><span class="icon icon-check text-green"></span>一次性预付租金 </label>
                <label class="button"><input type="checkbox" name="sbx" value="deposit"><span class="icon icon-check text-green"></span>定金           </label>
                <label class="button active"><input type="checkbox" name="sbx" value="contractFrom" checked="checked"><span class="icon icon-check text-green"></span>合同种类       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>是否废止       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="abandonReason" checked="checked"><span class="icon icon-check text-green"></span>废止种类       </label>

            </div>

        </div>

    </div>
    <form action="/DZOMS/contract/contractSearch" method="post" name="vehicleSele">
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
