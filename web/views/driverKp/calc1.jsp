<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>百分考核子项分数设置</title>
    <style>
        .div{
            width: 80%;
            border:1px solid #c1ccd1;
            margin: 3px auto;
            border-radius:5px;
        }
        .div input{
            border-radius:5px;
        }

    </style>
</head>
<body>
    <h4 align="center">百分考核子项分数设置</h4>

    <form id="DriverKpCalcParams" action="calcParams" method="post" >
        <div>
            <div class="div">
                <p >租金迟交分数设置<p/><hr/>
                <p>小分上限：<input type="text" name="zj_total" value="${driverKpParams.zj_total}" autocomplete="off" size="2" >分<p/>
                <p>单次分数：<input type="text" name="zj_0" value="${driverKpParams.zj_0}"  autocomplete="off" size="2">分</p>
            </div>

            <div class="div">
                <p>保险迟交分数设置<p/><hr/>
                <p>小分上限：<input type="text" name="insurance_total" value="${driverKpParams.insurance_total}"  autocomplete="off" size="2">分<p/>
                <p>单次分数：<input type="text" name="insurance_0" value="${driverKpParams.insurance_0}"  autocomplete="off" size="2">分</p>
            </div>
            
            <div class="div">
                <p>法律投诉分数设置<p/><hr/>
                <p>小分上限：<input type="text" name="law_total" value="${driverKpParams.law_total}"  autocomplete="off" size="2">分<p/>
                <p>单次分数：<input type="text" name="law_0" value="${driverKpParams.law_0}"   autocomplete="off" size="2">分</p>
            </div>

            <div class="div">
                <p>投诉分数设置<p/><hr/>
                <p>小分上限：<input type="text" name="ts_total" value="${driverKpParams.ts_total}"   autocomplete="off" size="2">分<p/>
                <a href="/DZOMS/common/SingleListEditor.jsp?dialogArguments=%5B%22complain.complainObject%22,%5B%22complain.complainObject%22,%22complainObject2%22,%22complain.grade%22%5D,%5B%22%E6%8A%95%E8%AF%89%E9%A1%B9%E7%9B%AE%22,%22%E6%9D%A1%E6%AC%BE%22,%22%E5%88%86%E5%80%BC%22%5D%5D">投诉修改</a>
            </div>
            <div class="div">
            <p>事故管理分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="sg_total" value="${driverKpParams.sg_total}"   autocomplete="off" size="2">分<p/>
            <p>严重事故（单次）：<input type="text" name="sg_2" value="${driverKpParams.sg_2}"   autocomplete="off" size="2">分</p>
            <p>一般事故（单次）：<input type="text" name="sg_1" value="${driverKpParams.sg_1}"   autocomplete="off" size="2">分</p>
            <p>轻微事故（单次）：<input type="text" name="sg_0" value="${driverKpParams.sg_0}"   autocomplete="off" size="2">分</p>
            </div>
            
            <div class="div">
            <p>电子违章分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="wz_total" value="${driverKpParams.wz_total}"   autocomplete="off" size="2">分<p/>
            <p>单次分数：<input type="text" name="wz_0" value="${driverKpParams.wz_0}"   autocomplete="off" size="2">分</p>
            <a href="getAllElectric">违章修改</a>
            </div>
            
            <div class="div">
            <p>路检路查分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="lj_total" value="${driverKpParams.lj_total}"   autocomplete="off" size="2">分<p/>
            <p>单次分数：<input type="text" name="lj_0" value="${driverKpParams.lj_0}"   autocomplete="off" size="2">分</p>
            </div>
            
            <div class="div">
            <p>例会分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="lh_total" value="${driverKpParams.lh_total}"   autocomplete="off" size="2">分<p/>
            <p>单次分数：<input type="text" name="lh_0" value="${driverKpParams.lh_0}"   autocomplete="off" size="2">分</p>
            </div>

            <div class="div">
                <p>加分项分数设置<p/><hr/>
                <p>小分上限：<input type="text" name="score2" value="${driverKpParams.score2}"   autocomplete="off" size="2">分<p/>
            </div>

            <div class="div">
            <p>参加活动设置<p/><hr/>
            <p>小分上限：<input type="text" name="hd_total" value="${driverKpParams.hd_total}"  autocomplete="off" size="2">分<p/>
            </div>
            
            <div class="div">
            <p>媒体表扬分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="mt_total" value="${driverKpParams.mt_total}"  autocomplete="off" size="2">分<p/>
            </div>

            <div class="div">
            <p>乘客表扬分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="praise_total" value="${driverKpParams.praise_total}"  autocomplete="off" size="2">分<p/>
            </div>

            <div class="div">
            <p>企业表彰分数设置<p/><hr/>
            <p>小分上限：<input type="text" name="pay_total" value="${driverKpParams.pay_total}"  autocomplete="off" size="2">分<p/>
            <p>单次分数：<input type="text" name="pay_0" value="${driverKpParams.pay_0}"  autocomplete="off" size="2">分</p>
                <input align="right" type="submit" id="fs" value="提交" >
            </div>

        </div>
    </form>

</body>
<script type="javascript">
    $("#fs").click(function () {
        var dataObj = $("#DriverKpCalcParams").serializeArray();
        console.log(dataObj);
            $.ajax({
                type: "post",
                contentType : 'application/json',
                dataType:"json",
                data:JSON.stringify(dataObj),
                url:"driverKp/calcParams",
                success:function(){
                        alert("修改成功");
                }
            });
    });
</script>

</html>