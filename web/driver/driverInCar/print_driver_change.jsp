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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印营运信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
	 function refresh(){
        	document.driverBusinessApply.action = "/DZOMS/driver/driverInCar/driverUpPrintSelect";
        	document.driverBusinessApply.submit();
        }
	 
$(document).ready(function(){

$("[name='vehicle.licenseNum']").bigAutocomplete({
	url:"/DZOMS/select/vehicleByLicenseNum",
	callback:function(){
		refresh();
	}
});
});

$(document).ready(function(){
	var licenseNum = $('[name="vehicle.licenseNum"]').val();
	if (licenseNum.length==0) {
		$('[name="vehicle.licenseNum"]').val("黑A");
	}
});
</script>
</head>
<body>
	   <style>
	   	.form-group{
	   		width: 400px;
	   	}
        .label{
            width: 140px;
            text-align: right;
        }
    </style>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>证照申请表打印</li>
        </ul>
        </div>
</div>
<div class="container">
    <form action="/DZOMS/driver/driverInCar/print_driver_change2.jsp" name="driverBusinessApply" method="post"
    	style="width: 100%;" class="form-inline form-tips" >
    	<div class="line panel">
    		<blockquote class="xm4" style="height: 100px;">
    			<div class="form-group">
                <div class="label padding">
                    <label>
                        车牌号
                    </label>
                </div>
                
                <div class="field" >
                	<s:textfield name="vehicle.licenseNum" cssClass="input"/>
                	<s:hidden name="driver.carframeNum" value="%{vehicle.carframeNum}"></s:hidden>
                	<s:hidden name="vehicle.carframeNum" value="%{vehicle.carframeNum}"></s:hidden>
                </div>
            </div>
    		</blockquote>
    			 <blockquote class="xm4" style="height: 100px;">
               <div class="form-group" style="">
               	  <div class="label"> 
               	  	 <label>发放证照</label>
               	  </div>
               	  <div class="field">
               	  	  &nbsp;添加驾驶员  <input type="radio" name="type1" value="1">
				      &nbsp;注销驾驶员  <input type="radio" name="type1" value="2">
				      &nbsp;更换驾驶员  <input type="radio" name="type1" value="3">
               	  </div>
               </div> 
             
      
    
            </blockquote>
             <blockquote class="xm4" style="height: 100px;">
               <div class="form-group" style="">
               	  <div class="label"> 
               	  	 <label>补发证照</label>
               	  </div>
               	  <div class="field">
               	  	 
      &nbsp; &nbsp;营运证 &nbsp; &nbsp;<input type="radio" name="type2" value="1">
      &nbsp; &nbsp;准驾证 &nbsp; &nbsp;<input type="radio" name="type2" value="2">
            电子营运证<input type="radio" name="type2" value="3">
    
               	  </div>
               </div> 
             
      
    
            </blockquote>
    		
    	</div>

  
           
<%
ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack"); 
Vehicle vehicle = (Vehicle)vs.findValue("vehicle");
Calendar c = Calendar.getInstance();
c.add(Calendar.MONTH, -1);
List<Driverincar> list=null;
if(vehicle==null){
	list=new ArrayList<Driverincar>();
}else{
	String hql = "carframeNum='"+vehicle.getCarframeNum()+"' and opeTime>=STR_TO_DATE('"+String.format("%tF",c.getTime())+"','%Y-%m-%d') and operation='证照申请'";      		
	list = ObjectAccess.query(Driverincar.class, hql);
}

Map<String,String> up1Driver = new TreeMap<String,String>();
Map<String,String> up2Driver = new TreeMap<String,String>();
Map<String,String> up3Driver = new TreeMap<String,String>();
Map<String,String> down1Driver = new TreeMap<String,String>();
Map<String,String> down2Driver = new TreeMap<String,String>();
Map<String,String> down3Driver = new TreeMap<String,String>();

up1Driver.put("","无");
up2Driver.put("","无");
up3Driver.put("","无");
down1Driver.put("","无");
down2Driver.put("","无");
down3Driver.put("","无");

for(Driverincar di:list){
	Driver d = ObjectAccess.getObject(Driver.class, di.getIdNumber());
	if(di.getOperation().equals("证照申请")){
		switch(di.getDriverClass()){
			case "主驾":
				up1Driver.put(d.getIdNum(), d.getName());
				break;
			case "副驾":
				up2Driver.put(d.getIdNum(), d.getName());
				break;
			case "三驾":
				up3Driver.put(d.getIdNum(), d.getName());
				break;
		}
	}else{
		switch(di.getDriverClass()){
			case "主驾":
				down1Driver.put(d.getIdNum(), d.getName());
				break;
			case "副驾":
				down2Driver.put(d.getIdNum(), d.getName());
				break;
			case "三驾":
				down3Driver.put(d.getIdNum(), d.getName());
				break;
		}
	}
}

request.setAttribute("up1Driver", up1Driver);
request.setAttribute("up2Driver", up2Driver);
request.setAttribute("up3Driver", up3Driver);
request.setAttribute("down1Driver", down1Driver);
request.setAttribute("down2Driver", down2Driver);
request.setAttribute("down3Driver", down3Driver);

    %>
    <div class="panel">
        <div class="panel-head">
           	<strong>上车驾驶员选取</strong>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        主驾
                    </label>
                </div>
                
                <div class="field" >
                <s:radio name="up1Driver" list="#request.up1Driver"></s:radio>
                </div>
            </div>
       </div>
       <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        副驾
                    </label>
                </div>
                
                <div class="field" >
                <s:radio name="up2Driver" list="#request.up2Driver"></s:radio>
                </div>
            </div>
       </div>
       <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        三驾
                    </label>
                </div>
                
                <div class="field" >
                <s:radio name="up3Driver" list="#request.up3Driver"></s:radio>
                </div>
            </div>
       </div>
    </div>

    <div class="panel">
        <div class="panel-head">
           	<strong>下车驾驶员选取</strong>
        </div>
       <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        主驾
                    </label>
                </div>
                
                <div class="field" >
                <s:radio name="down1Driver" list="#request.down1Driver"></s:radio>
                </div>
            </div>
       </div>
       <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        副驾
                    </label>
                </div>
                
                <div class="field" >
                <s:radio name="down2Driver" list="#request.down2Driver"></s:radio>
                </div>
            </div>
       </div>
       <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        三驾
                    </label>
                </div>
                
                <div class="field" >
                <s:radio  name="down3Driver" list="#request.down3Driver"></s:radio>
                </div>
            </div>
       </div>
    </div>
        
        <div class="form-group">
            	 <div class="label padding" >
                        <label>
                        </label>
                    </div>
            	<div class="field">
            		 <input type="submit" class="button bg-green submitbutton margin-big-left" value="提交"/>
            	</div>
        </div>

    </form>
    <script>
    
</script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</div>
</body>
</html>
