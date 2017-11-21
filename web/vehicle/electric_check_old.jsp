<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>电子违章</title>
		<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
		<script>
		
		//var $thead = $('<tr><th>省份</th><th>城市</th><th>城市ID</th><th>车牌头两位</th><th>发动机号尾数(倒数)</th><th>车架号尾数(倒数)</th><th>证书号尾数(倒数)</th></tr>');
		$(document).ready(function(){
			$.post("/DZOMS/common/electricConfig",{},function(data){
/**
configs 	array 	省份数组
province_id 	int 	省份对应的ID
province_name 	string 	省份名称
province_short_name 	string 	省份对应的缩写
citys 	array 	省份下城市数组
city_id 	int 	城市对应的ID
city_name 	int 	城市名称
car_head 	string 	车牌头前两位
engineno 	int 	需要输入发动机号位数（"-1"：全部输入，"0"：不需要输入，其他的显示几位输入发动机号后面几位）
classno 	int 	需要输入车架号位数（"-1"：全部输入，"0"：不需要输入，其他的显示几位输入车架号后面几位）
registno 	int 	需要输入证书编号位数（"-1"：全部输入，"0"：不需要输入，其他的显示几位输入证书编号后面几位）
*/
					var configs = data.configs;
					
					//$('#config').html($thead);
					
					for(var i=0;i<configs.length;i++){
						var province = configs[i];
						var province_id=province.province_id;
						var province_name=province.province_name;
						var province_short_name=province.province_short_name;
						
						if(province_short_name!='黑'){
							continue;
						}
						
						var citys = province.citys;
						
						for(var j=0;j<citys.length;j++){
							var city = citys[j];
							var city_id    = city.city_id   ;
							var city_name  = city.city_name ;
							var car_head   = city.car_head  ;
							var engineno   = city.engineno  ;
							var classno    = city.classno   ;
							var registno   = city.registno  ;
							
							if(car_head!='黑'){
								continue;
							}
							
							$('input[name="cityId"]').val(city_id);
							
							/*var $tr=$('<tr></tr>')
									.append($('<td></td>').text(province_name))
									.append($('<td></td>').text(city_name))
									.append($('<td></td>').text(city_id))
									.append($('<td></td>').text(car_head))
									.append($('<td></td>').text(engineno))
									.append($('<td></td>').text(classno))
									.append($('<td></td>').text(registno));
							$('#config').append($tr);*/
						}
						
					}
					
				});
			});
			
			function getInfo(){
				$.post("/DZOMS/common/electricInfo",{"carNo":$('input[name="carNo"]').val(),"carframeNum":$('input[name="carframeNum"]').val(),"cityId":$('input[name="cityId"]').val(),"engineNo":"","carType":"02"},function(data){
					var status = data.status;
if(status=="1002"){$("#result").html("app_id有误                                   \n");}
else if(status=="1003"){$("#result").html("sign加密有误                                 \n");}
else if(status=="1004"){$("#result").html("车牌号，汽车类型，违章城市 等字段不能为空    \n");}
else if(status=="1005"){$("#result").html("carInfo有误                                  \n");}
else if(status=="2000"){$("#result").html("正常(无违章记录)                             \n");}
else if(status=="2001"){$("#result").html("正常（有违章记录）                           \n");}
else if(status=="5000"){$("#result").html("请求超时，请稍后重试                         \n");}
else if(status=="5001"){$("#result").html("交管局系统连线忙碌中，请稍后再试             \n");}
else if(status=="5002"){$("#result").html("恭喜，当前城市交管局暂无您的违章记录         \n");}
else if(status=="5003"){$("#result").html("数据异常，请重新查询                         \n");}
else if(status=="5004"){$("#result").html("系统错误，请稍后重试                         \n");}
else if(status=="5005"){$("#result").html("车辆查询数量超过限制                         \n");}
else if(status=="5006"){$("#result").html("你访问的速度过快, 请后再试                   \n");}
else if(status=="5008"){$("#result").html("输入的车辆信息有误，请查证后重新输入         \n");}
					//$('#result').html(data);
				});
			}
			
		</script>
	</head>
	<body>
		<table id="config">
			
			<!--hphm 	车牌号码
classno 	车架号
engineno 	发动机号
registno 	证书编号
city_id 	违章查询地城市ID
car_type 	车辆车类型（"02"：小型汽车）-->
		</table>
		<div>
				车牌号:<input name="carNo" /><br />
				车架号:<input name="carframeNum" /><br />
				<input type="hidden" name="cityId" /><br />
				<input type="button" onclick="getInfo()" value="提交"/>
		</div>
		<div id="result">
			
		</div>
	</body>
</html>
