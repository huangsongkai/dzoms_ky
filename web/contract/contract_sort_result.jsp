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
    <title>档案号重排查询结果</title>
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
        function _updateContractId() {
            var trs = $("tr.data-tr").filter(function (tr) {
                var rawId = $(tr).find("td.contractId").text().trim();
                var newId = $(tr).find("td.contractId2").text().trim();
                if(newId.length !=5){
                    alert("存在数据缺失，"+$(tr).find("td.licenseNum").text()+"将在重排时被忽略！");
                    return false;
                }
                return rawId != newId;
            });
            if (trs.length>0 && confirm('确定对以下'+trs.length+"条进行调整？")){
                var arr = trs.map(function (tr) {
                    var id = $(tr).attr("data-id");
                    var newId = $(tr).find("td.contractId2").text();
                    return {
                        id:id,
                        contractId:newId
                    }
                });
                $.post('/DZOMS/contract/contractSort',{
                    json:JSON.stringify(arr)
                },function (data) {
                    if (data["state"]){
                        alert("操作成功！");
                        document.location.reload(true);
                    } else {
                        alert("操作失败！原因是："+data["msg"])
                    }
                });
            }
        }
    </script>
</head>
<body>
<div>
    <div class="panel  margin-small" >
        <div class="panel-head">
            <div class="line">
                <div class="xm6 xm4-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <s:if test="#session.roles.{?#this.rname=='合同档案号修改权限'}.size>0">
                                <button onclick="_updateContractId()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                    全部重排</button>
                            </s:if>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="panel-body">
            <table class="table table-hover table-bordered  table-striped">
                <tr>
                    <th class="branchFirm  selected_able">部门                    </th>
                    <th class="licenseNum  selected_able">车牌号                    </th>
                    <th class="contractId  selected_able">当前档案号                    </th>
                    <th class="contractId  selected_able">重排后档案号                    </th>
                    <%--<th class="idName  selected_able">承包人                    </th>--%>
                    <%--<th class="idNumber  selected_able">身份证号码                    </th>--%>
                    <%--<th class="phoneNum  selected_able">手机号码                    </th>--%>
                    <%--<th class="beginDate  selected_able">合同开始日期                    </th>--%>
                    <%--<th class="endDate  selected_able">合同终止日期                    </th>--%>
                    <%--<th class="abandonedTime  selected_able">实际终止日期                    </th>--%>
                    <%--<th class="businessForm  selected_able">承包形式                    </th>--%>
                   <%----%>
                    <%--<th class="ascription  selected_able">营运手续归属                    </th>--%>
                    <%--<th class="rentFirst  selected_able">一次性预付租金                    </th>--%>
                    <%--<th class="deposit  selected_able">定金                    </th>--%>
                    <%--<th class="contractFrom  selected_able">合同种类                    </th>--%>
                    <%--<th class="state  selected_able">是否废止                    </th>--%>
                    <%--<th class="abandonReason  selected_able">废止种类                    </th>--%>

                </tr>
                <s:if test="%{#request.list!=null}">
                    <s:set name="deptMap" value="#{'一部':1,'二部':2,'三部':3}"></s:set>
                    <s:iterator value="%{#request.list}" var="v" status="L">
                        <%--<s:set name="driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver', #v.idNum)}"></s:set>--%>
                        <%--<s:set name="vp" value="%{@com.dz.common.other.ObjectAccess@execute('from VehicleApproval where checkType=1 and contractId='+#v.id)}"></s:set>--%>
                        <tr class="data-tr" data-id="${v.id}">
                            <%--<td><input type="radio" name="cbx" value="<s:property value="%{#v.id}" />" ></td>--%>
                                <td class="branchFirm	  selected_able"><s:property value="%{#v.branchFirm}" />   </td>
                                <td class="licenseNum	  selected_able"><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle",#v.carframeNum).licenseNum}'/></td>
                                <td class="contractId	  selected_able"><s:property value="%{#v.contractId}" />          </td>
                                <td class="contractId2	  selected_able"><s:property value="%{#deptMap[#v.branchFirm]+&quot;&quot;+#v.contractType+@java.lang.String@format('%03d',#L.index+1) }" />          </td>
                                <%--<td class="idName  		  selected_able">--%>
                                <%--<s:property value='%{#driver.name}'/>--%>
                            <%--</td>--%>
                            <%--<td class="idNumber 	  selected_able"><s:property value="%{#v.idNum}" />     </td>--%>
                            <%--<td class="phoneNum 	  selected_able">--%>
                                <%--<s:property value='%{#driver.phoneNum1}'/>--%>
                            <%--</td>--%>
                            <%--<td class="beginDate	  selected_able"><s:property value="%{#v.contractBeginDate}" />     </td>--%>
                            <%--<td class="endDate		  selected_able"><s:property value="%{#v.contractEndDate}" />           </td>--%>
                            <%--<td class="abandonedTime  selected_able"><s:property value="%{#v.abandonedFinalTime}" />         </td>--%>
                            <%--<td class="businessForm   selected_able"><s:property value="%{#v.businessForm}" />     </td>--%>
                           <%----%>
                            <%--<td class="ascription	  selected_able"><s:property value="%{#v.ascription?'个人':'公司'}" />    </td>--%>
                            <%--<td class="rentFirst	  selected_able"><s:property value="%{#v.rentFirst}" />        </td>--%>
                            <%--<td class="deposit		  selected_able"><s:property value="%{#v.deposit}" /> </td>--%>
                            <%--<td class="contractFrom	  selected_able"><s:property value="%{#v.contractType}" />     </td>--%>
                            <%--<td class="state		  selected_able"><s:property value="%{#v.state==1?'是':'否'}" />  </td>--%>
                            <%--<td class="abandonReason  selected_able">--%>
                                <%--[--%>
                                <%--<s:if test="#vp.handleMatter">--%>
                                    <%--转包--%>
                                <%--</s:if>--%>
                                <%--<s:else>--%>
                                    <%--废业--%>
                                <%--</s:else>--%>
                                <%--]--%>
                                <%--<s:property value="%{#v.abandonReason}" />--%>
                            <%--</td>--%>
                        </tr>
                    </s:iterator>
                </s:if>
            </table>
        </div>
    </div>
</div>
</body>
</html>
