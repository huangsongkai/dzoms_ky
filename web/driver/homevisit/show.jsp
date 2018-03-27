<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.vehicle.VehicleApproval,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>查看家访信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>

	<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<script src="/DZOMS/res/js/itemtool.js"></script>

    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <style>
						.label{
							width: 80px;
							text-align: right;
						}
						.form-group{
							width: 300px;
						}
					</style>
	<script type="text/javascript" src="/DZOMS/res/js/vue.js" ></script>
	<script src="/DZOMS/res/js/fileUpload.js"></script>
	<script type="text/javascript" src="/DZOMS/res/layer-v3.0.3/layer/layer.js" ></script>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>家访</li>
                <li>家访查看</li>
              
        </ul>
        </div>
</div>
<form class="form-inline form-tips" name="addPraise" action="/DZOMS/driver/homevisit/addHomeVisit" method="post" enctype="multipart/form-data">
            <div class="panel bored-main">
							<div class="panel-head bg-main">
								<h3><strong>家访登记</strong></h3>
							</div>
							<div class="panel-boby">
								<div class="form-group margin-small">
									<div class="label">
										<label>
											家访时间</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" type="text" value="%{bean[0].time}"></s:textfield>
									</div>
								</div>
								
								
								<br>

								<div class="form-group margin-small">
									<div class="label">
										<label>车牌号</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',bean[0].carframeNum).licenseNum}"></s:textfield>
									</div>
								</div>
								<div class="form-group margin-small">
									<div class="label">
										<label>司机姓名</label>
									</div>
									<div class="field">
										<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',bean[0].idNum)}"/>
										<s:textfield cssClass="input" value="%{#t_driver.name}"></s:textfield>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>身份证号</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" value="%{#t_driver.idNum}"></s:textfield>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>家庭住址</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" value="%{#t_driver.address}"></s:textfield>
									</div>
								</div>

								<br>
								<div  style="width:  600px;min-height: 100px">
									<div class="float-left" style="width: 80px; text-align: right;">
										<strong>文件</strong>
									</div>
									<div class="float">
										<div class="line" id="main_div">
											<table class="table table-striped table-bordered table-hover">
												<thead><tr>
													<th class="name selected_able">名称</th>
													<th class="yulan selected_able">查看</th>
													<th class="download selected_able">查看</th>
													<%--<th class="delete selected_able">删除</th>--%>
												</tr></thead>
												<tbody v-for="(finfo, index) in photos.data"><tr>
													<td class="name selected_able">{{finfo.alt}}</td>
													<td class="yulan selected_able"><a v-on:click="showPic(finfo.src)">查看</a></td>
													<td class="download selected_able"><a v-on:click="downloadPic(finfo.alt)">下载</a></td>
													<%--<td class="delete selected_able"><a v-on:click="delPic(finfo.alt)">删除</a></td>--%>
												</tr></tbody>
											</table>
											<div style="display: none">
												<button type="button" class="button icon-search text-blue addbtn1" style="line-height: 6px;">添加新文件</button>
												<input id="photoSeq" class="dz-file" name="photo" data-target=".addbtn1" sessuss-function="_add();">
											</div>
										</div>
									</div>
								</div>

								<div></div>
								<br>
					            <div style="width: 600px;float: left">
									<div class="float-left" style="width: 80px; text-align: right;">
										<strong>家访记录</strong>
									</div>
									<div class="field">
										<s:textarea cssStyle="width: 500px;" rows="5" cssClass="input" placeholder="多行文本" value="%{bean[0].record}"></s:textarea>
									</div>
								</div>
								<br>
								<div style="width: 600px;">
										<div class="float-left" style="width: 80px; text-align: right;">
											<strong>备注</strong>
										</div>
									
									<div class="field">
										<s:textarea cssStyle="width: 500px;" rows="5" cssClass="input" placeholder="多行文本" value="%{bean[0].comment}"></s:textarea>
									</div>
								</div>
								
					<br>
					
					          <div class="form-group margin-small">
									<div class="label">
										<label>家访人</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" type="text" readonly="true" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',bean[0].register).uname}"></s:textfield>
									</div>
								</div>
								
							</div>
							<br>
						</div>		
    </form>
   <script src="/DZOMS/res/js/DateTimeHelper.js"></script>
<script>
    var info = new Vue({
        el:"#main_div",
        data:{
            photos:{
                title:"",
                data:[]
            }
        },methods:{
            showPic:function (src) {
                if(!/\.(gif|jpg|jpeg|png|GIF|JPG|PNG|JPEG|BMP|bmp)$/.test(src)){
                    alert("该文件不是图片，请下载后查看！");
                    return;
                }

                layer.open({
                    type: 2,
                    title: false,
                    area: ['360px', '630px'],
                    shade: 0.8,
                    closeBtn: 0,
                    shadeClose: true,
                    content: src
                });
            },
            downloadPic:function(alt){
                window.open("/DZOMS/download?path=%2fdata%2fdriver%2fhomeVisit%2f${bean[0].id}%2f"+alt);
            }
            <%--,--%>
            <%--delPic:function (alt) {--%>
                <%--$.getJSON('/DZOMS/driver/complain/complainDeletePhoto?complain.id=${complain.id}&photo_name='+encodeURI(alt),function(json){--%>
                    <%--if(json.status){--%>
                        <%--alert('删除成功！');--%>
                        <%--refreshPhotos();--%>
                    <%--}else{--%>
                        <%--alert('删除失败！');--%>
                    <%--}--%>

                <%--});--%>
            <%--}--%>
        }
    });

    function refreshPhotos(){
        $.getJSON('/DZOMS/driver/homevisit/homeVisitFiles?homeVisit.id=${bean[0].id}',function(json){
            info.photos = json;
        });
    }
    refreshPhotos();

    function _add(){
        var fileName = prompt("请输入文件名称:");

        if (fileName.trim().length==0) {
            alert("请输入一个长度大于0的文件名！");
            return false;
        }

        $.getJSON('/DZOMS/driver/homeVisit/homeVisitUploadPhoto?complain.id=${bean[0].id}&photo_name='+encodeURI(fileName)+'&photo='+$('#photoSeq').val(),function(json){
            if(json.status){
                alert('上传成功！');
                refreshPhotos();
            }else{
                alert('上传失败！');
            }
        });
    }
</script>
</body>
</html>
