<%@page import="com.dz.module.driver.complain.Complain"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@ page language="java"
	import="java.util.*,com.dz.module.user.User,com.dz.module.vehicle.*,com.dz.module.driver.*,com.dz.common.other.*,com.dz.common.global.*,com.opensymphony.xwork2.util.*"
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
<title>添加投诉信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />

<script src="/DZOMS/res/js/jquery.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>

<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<script src="/DZOMS/res/js/pintuer.js"></script>

<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>

<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/vue.js" ></script>
<script src="/DZOMS/res/js/fileUpload.js"></script>
<script type="text/javascript" src="/DZOMS/res/layer-v3.0.3/layer/layer.js" ></script>
<script>
	$(document).ready(function(){
		var jsonStr = $("#complainFromIn").val();
		var json = $.parseJSON(jsonStr);
		for(var key in json){
			$('input[name="'+key+'"]').val(json[key]);
		}
		
		$('[name="confirmReault"]').change(function(){
			if($('[name="confirmReault"]').val()=='true'){
    			$('.deal_when_true').show();
    		}else{
    			$('.deal_when_true').hide();
    		}
		});
		
		$('[name="confirmReault"]').change();
	});
	
	$(document).ready(function(){
		var complainObject = $("#complainObject").val();
		var json = $.parseJSON(complainObject);
		var str = json["complainObject2"]+":"+json["complain.complainObject"];
		$("#complainObject_show").val(str);
	});
	
	function lookfile(){
		//alert($("#filename").val());
        if( $("#filename").val()!=undefined){
            window.open($("#filename").val(),"图片预览",'resizable=no,scrollbars=no');
        }
    }

</script>
</head>
<body>
    <div class="adminmin-bread">
        <ul class="bread">
            <li><a href="" class="icon-home"> 开始</a></li>
            <li>投诉确认</li>
        </ul>
    </div>
    
    <form name="dealComplain" action="/DZOMS/driver/complain/dealComplain" method="post">
    	<s:hidden name="complain.id"/>
        <div class="container">
            <table class="table table-hover">
                <tr>
                    <td class="tableleft">投诉时间</td>
                    <td><s:textfield cssClass="datetimepicker input" type="text" name="complain.complainTime" /></td>
                    <td class="tableleft">投诉类别</td>
                    <td>
                        <s:textfield cssClass="input" name="complain.complainClass"></s:textfield>
                    </td>
                    <td class="tableleft ">投诉类型</td>
                    <td>
                    	<s:textfield cssClass="input" name="complain.complainType"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td class="tableleft">投诉项目</td>
                    <td colspan="4">
                    	<s:hidden name="complain.complainObject" id="complainObject"></s:hidden>
                        <s:textfield cssClass="input" id="complainObject_show"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td class="tableleft">信息来源</td>
                    <td style="white-space: nowrap">
                        <s:textfield cssClass="input" name="complain.complainFromOut"></s:textfield>
                    </td>
                    <s:hidden id="complainFromIn" name="complain.complainFromIn"></s:hidden>
                    <td class="tableleft">姓名</td>
                    <td><s:textfield cssClass="input" name="complainFromIn3">
                    </s:textfield></td>
                    <td class="tableleft">电话</td>
                    <td><input class="input" name="complainFromIn2"/></td>
                    <td class="tableleft">手机</td>
                    <td><input class="input" name="complain.complainFromIn"/></td>
                </tr>
                <tr>
                	<s:set name="t_vehicle" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',complain.vehicleId)}"></s:set>
                    <td class="tableleft">车牌号</td>
                    <td>
                        <s:textfield cssClass="input" value="%{#t_vehicle.licenseNum}">
                        </s:textfield>
                    </td>
                    <s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#t_vehicle.driverId)}"></s:set>
                    <td class="tableleft">承租人</td>
                    <td><s:textfield cssClass="input" name="idNum" value="%{#t_driver.name}"/></td>
                    <td class="tableleft">电话</td>
                    <td><s:textfield cssClass="input" name="telephone" value="%{#t_driver.phoneNum1}"/></td>
                    <td class="tableleft">分公司归属</td>
                    <td><s:textfield cssClass="input" name="company" value="%{#t_vehicle.dept}"/></td>
                </tr>
                <tr>
                    <td class="tableleft">投诉人姓名</td>
                    <td><s:textfield cssClass="input" name="complain.complainPersonName"/></td>
                    <td class="tableleft">投诉任性别</td>
                    <td>
                        <s:textfield cssClass="input" value="%{complain.complainPersonSex?'男':'女'}">
                        </s:textfield>
                    </td>
                    <td class="tableleft">投诉人电话</td>
                    <td><s:textfield cssClass="input" name="complain.complainPersonPhone"/></td>
                    <td class="tableleft">发票号</td>
                    <td><s:textfield cssClass="input" name="complain.ticketNumber"/></td>
                </tr>
                <tr>
                	<td>相关照片</td>
                	<td colspan="7" >
                		<div class="line" id="main_div">
                			<table class="table table-striped table-bordered table-hover">
			                	<thead><tr>
			                        <th class="name selected_able">名称</th>
			                        <th class="yulan selected_able">查看</th>
			                        <th class="download selected_able">查看</th>
			                        <th class="delete selected_able">删除</th> 
			                    </tr></thead>
			                    <tbody v-for="(finfo, index) in photos.data"><tr>
			                    	<td class="name selected_able">{{finfo.alt}}</td>
			                        <td class="yulan selected_able"><a v-on:click="showPic(finfo.src)">查看</a></td>
			                        <td class="download selected_able"><a v-on:click="downloadPic(finfo.alt)">下载</a></td>
			                        <td class="delete selected_able"><a v-on:click="delPic(finfo.alt)">删除</a></td> 
			                    </tr></tbody>
							</table>
							<div>
								<button type="button" class="button icon-search text-blue addbtn1" style="line-height: 6px;">添加新文件</button>
								<input id="photoSeq" class="dz-file" name="photo" data-target=".addbtn1" sessuss-function="_add();">
							</div>
                		</div>
                    </td>
                </tr>
                <tr>
                    <td>投诉内容</td>
                    <td colspan="7">
                        <s:textarea rows="5" cssClass="input" placeholder="多行文本框" name="complain.complainContext"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td>投诉登记人</td>
                    <td><s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',complain.registrant).uname}"/></td>
                    <td colspan="3"></td>
                    <td>投诉登记时间</td>
                    <td><s:textfield cssClass="input" name="complain.registTime"/></td>
                </tr>
               <tr>
                    <td>确认结果</td>
                    <td colspan="7">
                        <s:select rows="5" cssClass="input" name="confirmReault" list="#{'true':'属实','flase':'不属实'}"></s:select>
                    </td>
                </tr>
                <tr>
                    <td>处理结果</td>
                    <td colspan="7">
                        <s:textarea rows="5" cssClass="input" placeholder="多行文本框" name="complain.dealContext"></s:textarea>
                    </td>
                </tr>
<%
ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
Complain complain = (Complain)vs.findValue("complain");
Vehicle vehicle = ObjectAccess.getObject(Vehicle.class, complain.getVehicleId());
Calendar c = Calendar.getInstance();
c.add(Calendar.YEAR, -1);
List<Driverincar> list=null;
if(vehicle==null){
	list=new ArrayList<Driverincar>();
}else{
	String hql = "carframeNum='"+vehicle.getCarframeNum()+"' and operation='证照注销' and opeTime>=STR_TO_DATE('"+String.format("%tF",c.getTime())+"','%Y-%m-%d')";      		
	list = ObjectAccess.query(Driverincar.class, hql);
}

Map<String,String> dl = new TreeMap<String,String>();

Driver d=null;
for(Driverincar di:list){
	d = ObjectAccess.getObject(Driver.class, di.getIdNumber());
	dl.put(d.getIdNum(), d.getName());
}

if(vehicle.getFirstDriver()!=null)
d = ObjectAccess.getObject(Driver.class, vehicle.getFirstDriver());
if(d!=null)
	dl.put(d.getIdNum(), d.getName());

if(vehicle.getSecondDriver()!=null)
d = ObjectAccess.getObject(Driver.class, vehicle.getSecondDriver());
if(d!=null)
	dl.put(d.getIdNum(), d.getName());

if(vehicle.getThirdDriver()!=null)
d = ObjectAccess.getObject(Driver.class, vehicle.getThirdDriver());
if(d!=null)
	dl.put(d.getIdNum(), d.getName());
	
if(vehicle.getTempDriver()!=null)
d = ObjectAccess.getObject(Driver.class, vehicle.getTempDriver());
if(d!=null)
	dl.put(d.getIdNum(), d.getName());


request.setAttribute("dl", dl);
%>
                <tr class="deal_when_true">
                    <td>落实结果</td>
                    <td colspan="7">
                    	<s:select name="complain.dealReault" cssClass="input" list="#request.dl"></s:select>
                    </td>
                </tr>
                <tr class="deal_when_true">
                	<td class="tableleft">分值</td>
                    <td><s:textfield cssClass="input" name="complain.grade"/></td>
                </tr>
                <tr>
                    <td>负责人</td>
                    <td>
                    <input class="input"  value="<%=((User)session.getAttribute("user")).getUname()%>"/>
                    <input type="hidden" name="complain.dealPerson" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
                    </td>

                    <td colspan="3"></td>
                    <td>时间</td>
                    <td><input  class="datepick input" name="complain.dealTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/></td>
                </tr>
                <tr>
                    <td colspan="6"> <div class="form-button"><input class="button bg-green" type="submit" value="录入"></input></div></td>
                    <td> <div class="form-button"><input type="button" class="button" value="退出"></input></div></td>
                </tr>
            </table>
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
            	window.open("/DZOMS/download?path=%2fdata%2fdriver%2fcomplain%2f${complain.id}%2f"+alt);
            },
            delPic:function (alt) {
                $.getJSON('/DZOMS/driver/complain/complainDeletePhoto?complain.id=${complain.id}&photo_name='+encodeURI(alt),function(json){
					if(json.status){
						alert('删除成功！');
						refreshPhotos();
					}else{
						alert('删除失败！');
					}
					
				});
            }
        }
	});
	
	function refreshPhotos(){
		$.getJSON('/DZOMS/driver/complain/complainFiles?complain.id=${complain.id}',function(json){
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
        
        $.getJSON('/DZOMS/driver/complain/complainUploadPhoto?complain.id=${complain.id}&photo_name='+encodeURI(fileName)+'&photo='+$('#photoSeq').val(),function(json){
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
