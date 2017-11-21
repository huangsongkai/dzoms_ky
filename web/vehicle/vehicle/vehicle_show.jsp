<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>车辆检索</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>

</script>
  <style>
        .tableleft{
            text-align: right;
            width: 20%;
        }
    </style>

    <style type="text/css">
        #preview{width:400px;height:250px;border:1px solid #000;overflow:hidden;}
        #imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
    </style>
    <script type="text/javascript">


        //图片上传预览    IE是用了滤镜。
        function previewImage(file)
        {
            var MAXWIDTH  = 400;
            var MAXHEIGHT = 250;
            var div = document.getElementById('preview');
            if (file.files && file.files[0])
            {
                div.innerHTML ='<img id=imghead>';
                var img = document.getElementById('imghead');
                img.onload = function(){
                    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                    img.width  =  rect.width;
                    img.height =  rect.height;
//                 img.style.marginLeft = rect.left+'px';
                    img.style.marginTop = rect.top+'px';
                }
                var reader = new FileReader();
                reader.onload = function(evt){img.src = evt.target.result;}
                reader.readAsDataURL(file.files[0]);
            }
            else //兼容IE
            {
                var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
                file.select();
                var src = document.selection.createRange().text;
                div.innerHTML = '<img id=imghead>';
                var img = document.getElementById('imghead');
                img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
                div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
            }
        }
        function clacImgZoomParam( maxWidth, maxHeight, width, height ){
            var param = {top:0, left:0, width:width, height:height};
            if( width>maxWidth || height>maxHeight )
            {
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;

                if( rateWidth > rateHeight )
                {
                    param.width =  maxWidth;
                    param.height = Math.round(height / rateWidth);
                }else
                {
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }

            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
        }
       
    </script>
</head>
<body>
<div>
        <div class="container">
            <div class="xm10">
                <table class="table table-hover">
                    <tr>
                        <td class="tableleft">车辆识别代码/车架号</td>
                        <td><s:textfield name="vehicle.carframeNum"  cssClass="input input-auto"/></td>

                        <td class="tableleft">发动机号</td>
                        <td><s:textfield name="vehicle.engineNum" cssClass="input input-auto"/></td>
                    </tr>
                            <tr>
                                <td class="tableleft">车辆型号</td>
                                <td><s:textfield  name="vehicle.carMode" cssClass="input" ></s:textfield></td>
                                <td class="tableleft">购入日期</td>
                                <td><s:textfield cssClass="datepick input input-auto" name="vehicle.inDate"/></td>
                            </tr>
                            <tr>
                                <td class="tableleft">合格证编号</td>
                                <td><s:textfield  name="vehicle.certifyNum" cssClass="input input-auto"/></td>

                                <td class="tableleft">归属部门</td>
                                <td><s:textfield cssClass="input" name="vehicle.dept"></s:textfield></td>
                            </tr>
                            <tr>
                                <td class="tableleft">车辆制造日期</td>
                                <td><s:textfield  cssClass="datepick input input-auto" name="vehicle.pd" /></td>

                                <td class="tableleft">车牌号</td>
                                <td><s:textfield name="vehicle.licenseNum" cssClass="input input-auto"/></td>
                            </tr>
                            <tr>
                                <td class="tableleft">车辆照片</td>
                                <td colspan="3">
                                    <div id="preview">
                                        <img id="imghead" src="/DZOMS/data/vehicle/<s:property value="vehicle.carframeNum"/>/photo.jpg" class="img-responsive" />
                                    </div>
                                </td>
                            </tr>
                            
                </table>
            </div>
            <br/>
        </div>

</div>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</body>
</html>
