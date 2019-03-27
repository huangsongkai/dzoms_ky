<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.util.ValueStack" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="com.dz.module.contract.BankCard" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Page pg = (Page)request.getAttribute("page");
%>

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
    <script>
        $(document).ready(function(){
            $("#show_div").find("input").change(resetClass);
        });

        function resetClass(){
            $(".selected_able").hide();
            var selects = [];
            $("input[name='sbx']:checked").each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
                selects.push($(this).val());//将选中的值添加到数组chk_value中
            });
            //	alert(selects);

            for(var i = 0;i<selects.length;i++){
                $("."+selects[i]).show();
            }
        }

        function _detail(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined)
                alert('您没有选择任何一条数据');
            var url = "/DZOMS/driver/driverPreshow?driver.idNum="+selected_val;
            window.open(url,"驾驶员明细",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function showDetail(id){
            //alert(id);
            layer.open({
                type: 2,
                title: '人员档案',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                content: '/DZOMS/driver/driver_photo.html?id='+id
            });
        }

        function showCard(cardId,driverId) {
            new MyRequest('/DZOMS/common/getObj')
                .param("ids[0].className","com.dz.module.contract.BankCard")
                .param("ids[0].id",cardId)
                .param("ids[0].isString",false)
                .param("ids[1].className","com.dz.module.driver.Driver")
                .param("ids[1].id",driverId)
                .param("ids[1].isString",true)
                .param("url","/contract/bank_card/card_show.jsp")
                .openWindow("银行卡信息");
            // var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id=" + cardId + "&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id=" + driverId + "&url=%2fcontract%2fbank_card%2fcard_show.jsp";
            // window.open(url, "银行卡信息", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function unbindCard(cardId,carNo) {
            if(confirm('确认要解除绑定？'))
                $.post('/DZOMS/contract/bank_card/unbindVehicle',{
                    'bankCard.id':cardId,
                    'bankCard.carNum':carNo
                },function (data) {
                    if(!data.status){
                        alert(data.msg);
                    }else {
                        document.vehicleSele.submit();
                    }
                });
        }

        function deleteCard(cardId) {
            var url = "/DZOMS/bankCardDelete?bankCard.id=" + cardId;
            if(confirm('删除该银行卡，请确认'))
                $.get(url, {}, function () {
                    document.vehicleSele.submit();
                });
        }

        function bindCard(cardId) {
            var url = "/DZOMS/contract/bank_card/selectByCardNumber?bankCard.cardNumber="+cardId
                +"&url=%2fcontract%2fbank_card%2fcard_bind.jsp";
            window.open(url, "绑定银行卡", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function addCard(driverId,carId) {
            new MyRequest('/DZOMS/common/getObj',"_parent")
                .param("ids[0].className","com.dz.module.vehicle.Vehicle")
                .param("ids[0].id",carId)
                .param("ids[0].isString",true)
                .param("ids[1].className","com.dz.module.driver.Driver")
                .param("ids[1].id",driverId)
                .param("ids[1].isString",true)
                .param("url","/contract/bank_card/card_add.jsp")
                .submit();
            // var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.vehicle.Vehicle&ids[0].id=" + carId + "&ids[0].isString=true" +
            //     "&ids[1].className=com.dz.module.driver.Driver&ids[1].id=" + driverId + "&ids[1].isString=true" +
            //     "&url=%2fcontract%2fbank_card%2fcard_add.jsp";
            // window.parent.location = url;
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
                <div class="xm2">查询结果</div>
                <div class="xm4 xm6-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                                查看人员信息</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        <div class="panel-body">
            <table class="table table-hover table-bordered  table-striped">

                <tr>
                    <th>选择</th>
                    <th class="licenseNum              selected_able">车牌号      </th>
                    <th class="name                    selected_able">姓名        </th>
                    <th class="sex                     selected_able">性别        </th>
                    <th class="driverClass selected_able">驾驶员属性</th>
                    <th class="phoneNum1 selected_able">电话号码</th>
                    <th class="idNum                   selected_able">身份证号    </th>
                    <th class="isInCar                 selected_able">是否在车    </th>
                    <th class="department              selected_able">分公司归属  </th>
                    <th class="archive selected_able">档案详情</th>

                    <th class="cardClass selected_able">银行卡类别</th>
                    <th class="cardNumber selected_able">银行卡号</th>
                    <th class="licenseNum selected_able">绑定的车辆</th>
                    <th class="opetion selected_able">操作</th>
                </tr>
                <%
                    ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
                %>
                <s:if test="%{#request.list!=null}">
                    <s:set name="hs" value="%{@com.dz.common.factory.HibernateSessionFactory@getSession()}"></s:set>
                    <s:set name="query" value="%{#hs.createQuery('from BankCard where idNumber=:idNum')}"></s:set>
                    <%Query query = (Query)vs.findValue("query");%>
                    <s:iterator value="%{#request.list}" var="v">
                        <%
                            Driver driver = (Driver) vs.findValue("v");
                            String idNum = driver.getIdNum();
                            query.setString("idNum",idNum);
                            List list = query.list();
                            request.setAttribute("blist",list);
                        %>
                        <s:set name="blist" value="%{#request.blist}"></s:set>
                        <s:if test="%{#blist!=null && #blist.size()!=0}">
                            <s:iterator value="%{#blist}" var="b" status="I">
                                <tr>
                                    <s:if test="%{#I.index==0}">
                                        <td rowspan="${blist.size()}"><input type="radio" name="cbx" value="<s:property value='%{#v.idNum}'/>" ></td>
                                        <td rowspan="${blist.size()}" class="licenseNum selected_able"><s:property value='%{#hs.get("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
                                        <td rowspan="${blist.size()}" class="name selected_able"><s:property value='%{#v.name}'/></td>
                                        <td rowspan="${blist.size()}" class="sex selected_able"><s:property value="%{#v.sex?'男':'女'}"/></td>
                                        <td rowspan="${blist.size()}" class="driverClass selected_able"><s:property value="%{#v.driverClass}"/></td>
                                        <td rowspan="${blist.size()}" class="phoneNum1 selected_able"><s:property value="%{#v.phoneNum1}"/></td>
                                        <td rowspan="${blist.size()}" class="idNum selected_able"><s:property value='%{#v.idNum}'/></td>
                                        <td rowspan="${blist.size()}" class="isInCar selected_able"><s:property value="%{#v.isInCar?'是':'否'}"/></td>
                                        <td rowspan="${blist.size()}" class="department selected_able"><s:property value='%{#v.dept}'/></td>
                                        <td rowspan="${blist.size()}" class="archive selected_able"><a href="javascript:showDetail('${v.idNum}')">档案详情</a></td>
                                    </s:if>

                                    <td class="cardClass selected_able"><s:property value="%{#b.cardClass}"/></td>
                                    <td class="cardNumber selected_able"><s:property value="%{#b.cardNumber}"/></td>
                                    <td class="licenseNum selected_able">
                                        <s:iterator value="%{#b.fetchBofVList()}" var="bov">
                                            <span style="margin-right: 2px"><s:property value='%{#bov.vehicle.licenseNum}'/>&nbsp;<a href="#" onclick="unbindCard('${bov.bankCard.id}','${bov.vehicle.carframeNum}')">解除绑定</a></span>
                                        </s:iterator>
                                    </td>
                                    <td class="opetion selected_able">
                                        <span style="margin-right: 2px"><a href="#" onclick="showCard('${b.id}','${v.idNum}')">查看</a></span>
                                        <span style="margin-right: 2px"><a href="#" onclick="deleteCard('${b.id}')">删除</a></span>
                                        <span style="margin-right: 2px"><a href="#" onclick="bindCard('${b.cardNumber}')">绑定到车辆</a></span>
                                    </td>
                                </tr>
                            </s:iterator>
                         </s:if>
                        <s:else>
                            <tr>
                                <td><input type="radio" name="cbx" value="<s:property value='%{#v.idNum}'/>" ></td>
                                <td class="licenseNum selected_able"><s:property value='%{#hs.get("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
                                <td class="name selected_able"><s:property value='%{#v.name}'/></td>
                                <td class="sex selected_able"><s:property value="%{#v.sex?'男':'女'}"/></td>
                                <td class="driverClass selected_able"><s:property value="%{#v.driverClass}"/></td>
                                <td class="phoneNum1 selected_able"><s:property value="%{#v.phoneNum1}"/></td>
                                <td class="idNum selected_able"><s:property value='%{#v.idNum}'/></td>
                                <td class="isInCar selected_able"><s:property value="%{#v.isInCar?'是':'否'}"/></td>
                                <td class="department selected_able"><s:property value='%{#v.dept}'/></td>
                                <td class="archive selected_able"><a href="javascript:showDetail('${v.idNum}')">档案详情</a></td>

                                <td class="cardClass selected_able">-</td>
                                <td class="cardNumber selected_able">-</td>
                                <td class="licenseNum selected_able">-</td>
                                <td class="opetion selected_able">
                                    <span style="margin-right: 2px"><a href="#" onclick="addCard('${v.idNum}','${v.carframeNum}')">新增银行卡</a></span>
                                </td>
                            </tr>
                        </s:else>
                    </s:iterator>
                    <s:property value="%{@com.dz.common.factory.HibernateSessionFactory@closeSession()}"></s:property>
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
                <div class="panel-foot border-red-light bg-red-light">
                    合计：<%=pg.getTotalCount() %>条记录。
                </div>
            </s:if>
            <s:else>
                无查询结果
            </s:else>
        </div>

    </div>
    <div class="panel  margin-small" >
        <div class="panel-head">
            显示项
        </div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="name" checked="checked"><span class="icon icon-check text-green"></span>姓名       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="sex" checked="checked"><span class="icon icon-check text-green"></span>性别       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="phoneNum1" checked="checked"><span class="icon icon-check text-green"></span>电话号码 </label>
                <label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="driverClass" checked="checked"><span class="icon icon-check text-green"></span>驾驶员属性</label>
                <label class="button active"><input type="checkbox" name="sbx" value="isInCar" checked="checked"><span class="icon icon-check text-green"></span>是否在车   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号     </label>
                <label class="button active"><input type="checkbox" name="sbx" value="department" checked="checked"><span class="icon icon-check text-green"></span>分公司归属 </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="archive" checked="checked"><span class="icon icon-check text-green"></span>档案详情
                </label>

                <label class="button active">
                    <input type="checkbox" name="sbx" value="cardClass" checked="checked"><span class="icon icon-check text-green"></span>银行卡类别
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="cardNumber" checked="checked"><span class="icon icon-check text-green"></span>银行卡号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>绑定的车辆
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="opetion" checked="checked"><span class="icon icon-check text-green"></span>操作
                </label>
            </div>
        </div>
    </div>

    <form action="/DZOMS/driver/searchDriver" method="post" name="vehicleSele">
        <input type="hidden" name="className" value="com.dz.module.driver.Driver"/>
        <s:hidden name="url" />
        <s:hidden name="condition" />
        <s:hidden name="beginDate" />
        <s:hidden name="endDate" />
        <s:hidden name="idNum"/>
        <s:hidden name="name"/>
        <s:if test="%{isInCar!=null}">
            <s:hidden name="isInCar"/>
        </s:if>
        <s:hidden name="driver.dept"></s:hidden>
        <s:hidden name="licenseNum"></s:hidden>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage" />
    </form>
</div>
</body>
</html>
