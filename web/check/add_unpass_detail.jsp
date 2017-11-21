<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-3-25
  Time: 下午4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%int x = (Integer)(request.getAttribute("checkRecordId"));%>
<head>
    <title>fydan</title>
   
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/down_menu/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="/DZOMS/res/down_menu/css/default.css">
	<link rel='stylesheet prefetch' href='/DZOMS/res/down_menu/css/foundation.css'>
	<link rel="stylesheet" type="text/css" href="/DZOMS/res/down_menu/css/styles.css">
  <script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/jquery.form.js"></script>
  <script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
  <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
  <script src="/DZOMS/res/js/fileUpload.js"></script>
    <script>
        var y = 0;
        var count = 0;
        
        function loadThePicture(){
        	
        }
        <%--function dealForm(x){--%>
            <%--y++;--%>
            <%--if($(x).is(":checked")){--%>
                <%--var value  = $(x).val();--%>
                <%--var values = value.split("|");--%>
                <%--var id = $(x).attr("id");--%>
                <%--var form_before =--%>
                        <%--"<form class='kk"+id+"' method='post' action='/DZOMS/check/addUnPassDetail' enctype='multipart/form-data' target='"+id+"'>" +--%>
                        <%--"<input type='text' value='"+values[0]+"' name='unPassDetail.unPassReason'>";--%>
                <%--var form_middle = "<input type='text' class='sl' value='"+values[1]+"' style='display:none;' name='unPassDetail.passPicture' readonly>";--%>
                <%--if($("#isTogether",parent.document).is(":checked")){--%>
                    <%--form_middle = "<input type='text' class='sl' value='"+values[1]+"' name='unPassDetail.passPicture' readonly>";--%>
                <%--}--%>
                <%--var form_after = "<input class='dz-file' name='image' data-toggle='click' data-target='.addbtn"+y+"' sessuss-function='loadThePicture();'/>" +--%>
                        <%--"<input type='hidden' name='checkRecord.id' value='<%=x%>'>" +--%>
                        <%--"<a class='button input-file bg-green addbtn"+y+"'>装入</a>"+--%>
                        <%--"<input type='button' value='清除'>" +--%>
                        <%--"<input type='button' value='查看'>" +--%>
                        <%--"</form>";--%>
                <%--var form = $(form_before+form_middle+form_after);--%>
                <%--var iframe = $("<iframe name='"+id+"' class='"+id+"'></iframe>");--%>
                <%--$("#lala").append(form);--%>
                <%--$("#iframes").append(iframe);--%>

            <%--}else{--%>
                <%--var id = $(x).attr("id");--%>
                <%--$("."+id).remove();--%>
            <%--}--%>
            <%--fileRefresh();--%>
        <%--}--%>
        function submitAll(){
			for(var each in fileObjMap){
				if(fileObjMap[""+each]["filename"] != undefined && fileStateMap[""+each] != '1'){
					alert("文件未上传完成！");
					return false;
				}
			}
			check_json();
			$("#form").ajaxSubmit(function(){
				alert("添加成功！");
				parent.window.location.href = parent.window.location.href;
			});

        }
         function dele_check(x){
           $(x).parent().remove();
          
        }
        function add_check(x){
        	y++;
        	var threename = $(x).next().text();
          var fen =  $(x).next().next().text();
          var filebutton= "<input class='dz-file' name='image' data-toggle='click' data-target='.addbtn"+y+"' sessuss-function='loadThePicture();'/>";
          var filea = "<input type='button' class='addbtn"+y+"' value='装入'/>";
        	var clear = "<input type='button' onclick='dele_file(this)' value='清除'>";
        	var photo = "<input type='button' onclick='show_file(this)' value='查看'>";
        	
        	$("#check_table").append("<tr>" +"<td ondblclick='dele_check(this)'>"+threename+"</td>"+"<td class='sl'>"+fen+"</td>"+"<td>"+filebutton+filea+clear+photo+"</td>"+"</tr>");
          if(!$("#isTogether",parent.document).is(":checked")){
       		$(".sl").hide();
       	  }
          fileRefresh();
        }
       function dele_file(x){
       	  y++;
       	  var filebutton= "<input class='dz-file' name='image' data-toggle='click' data-target='.addbtn"+y+"' sessuss-function='loadThePicture();'/>"
       	  var filea = "<input type='button' class='addbtn"+y+"' value='装入'/>"
       	  
       	 
       	  $(x).prev().prev().remove();
       	  $(x).prev().remove();
       	  
       	  index--;
       	 
       	  $(x).before(filebutton);
       	  $(x).before(filea);
           fileRefresh();
           alert("清除成功")
       }
      
       function diy_add_check(x){
       var value = prompt('输入自定义三级菜单：', ''); 
       if(value ==null){
       	alert("您取消了操作");
       }
       else if(value == ''){  
        alert('输入为空，请重新输入！');  
        show_prompt();  
       }
       else{
       	y++;
       	 var secondname = $(x).next().text();   
       	 var threename = secondname+'_'+value;     	
       	 var fen =  $(x).next().next().text();
       	 
         var filebutton= "<input class='dz-file' name='image' data-toggle='click' data-target='.addbtn"+y+"' sessuss-function='loadThePicture();'/>";
         var filea = "<input type='button' class='addbtn"+y+"' value='装入'/>";
         var clear = "<input type='button' onclick='dele_file(this)' value='清除'>";
         var photo = "<input type='button' onclick='show_file(this)' value='查看'>";
        	
        	$("#check_table").append("<tr>" +"<td ondblclick='dele_check(this)'>"+threename+"</td>"+"<td class='sl'>"+fen+"</td>"+"<td>"+filebutton+filea+clear+photo+"</td>"+"</tr>");
          if(!$("#isTogether",parent.document).is(":checked")){
       		$(".sl").hide();
       	  }
          fileRefresh();
       	 
       }
       }
       //拼接json数据
       function check_json(){
//     	alert($("#check_table tr:first").next().html());
       	var x =$("#check_table tr:first").next();
       	var jsonArr = [];
       	
       	while(x.html()!=undefined){
       		
       		var title = x.children().eq(0).html();
       		var fen   = x.children().eq(1).html();
       		var photo = x.children().eq(2).children().eq(0).val();
       		var obj = {'title':title, 'fen':fen, 'photo':photo};
       		
       		jsonArr.push(obj)
       		
       		x=x.next();
       	}
       	var value = $.toJSON(jsonArr);
       	$("#json").val(value);
       }
       //初始化查看是否有扣分这一项
       $(document).ready(function(){
       	if(!$("#isTogether",parent.document).is(":checked")){
       		$(".sl").hide();
       	}
       });
       
    </script>
</head>
<body>
<form method="post" action="/DZOMS/check/addUnPassDetail" id="form">
	<input type="hidden" name="json" id="json">
	<input type="hidden" name="checkRecord.id" value="<%=x%>">
</form>
  <div class="padding" style="width: 100%;margin-top: 20px;">
          <table style="border: 0px;">
            <tr>
               <td>行驶里程:</td>
               <td><input type="text" style="width: 120px;" placeholder="km"/></td>
            </tr>
          </table>
          
          
  </div>
	<div class="padding">
	
		<div class="htmleaf-container" style="width: 250px;float: left;">
		
		<div class="htmleaf-content" style="padding-top: 0px;padding-right: 50px;">
			<!-- This is mtree list -->
			<ul class="mtree" style="margin: 0px;">
			  <li><a href="#">严重违章</a>
			    <ul>
			      <li>
			           <a onclick="diy_add_check(this)">非法营运</a>
			           <span style="display: none;">严重违章_非法营运</span>
			      	   <span style="display: none;">50</span>	    	  
			      </li>
			      <li>
			          <a onclick="diy_add_check(this)">拒绝检查</a>
			      	 <span style="display: none;">严重违章_拒绝检查</span>
			      	 <span style="display: none;">50</span>
			      </li>
			      <li>
			          <a onclick="diy_add_check(this)">威胁辱骂检查人员</a>
			          <span style="display: none;">严重违章_威胁辱骂检查人员</span>
			      	  <span style="display: none;">50</span>
			      </li>
			      <li>
			          <a onclick="diy_add_check(this)">擅自将乘客截至宾馆住宿</a>
			          <span style="display: none;">严重违章_擅自将乘客截至宾馆住宿</span>
			      	  <span style="display: none;">50</span>
			      </li>
			      <li>
			         <a onclick="diy_add_check(this)">为非法经营提供条件</a>
			          <span style="display: none;">严重违章_为非法经营提供条件</span>
			      	  <span style="display: none;">50</span>
			      </li>
			      <li>
			      	 <a onclick="diy_add_check(this)">伪造证件经营</a>
			      	  <span style="display: none;">严重违章_伪造证件经营</span>
			      	  <span style="display: none;">50</span>
			      </li>
			      <li>
			      	<a onclick="diy_add_check(this)">欺行霸市行为的</a>
			      	 <span style="display: none;">严重违章_欺行霸市行为的</span>
			      	  <span style="display: none;">50</span>
			      </li>
			      <li>
			          <a onclick="diy_add_check(this)">将车交给无资格证的经营</a>
			          <span style="display: none;">严重违章_将车交给无资格证的经营</span>
			      	  <span style="display: none;">50</span>
			      </li>
			      <li>
			          <a onclick="diy_add_check(this)">将车交给无驾驶证的人经营</a>
			           <span style="display: none;">严重违章_将车交给无驾驶证的人经营</span>
			      	  <span style="display: none;">50</span>
			      </li>
			    </ul>
			  </li>
			   
			  <li><a href="#" class="first_menu">一般违章</a>
			    <ul>
			      <li><a href="#" class="second_menu">违反营运条例</a>
			        <ul>
			          <li><a class="three_menu" onclick="add_check(this)">营运中拒载</a>
			              <span style="display: none;">一般违章_违反营运条例_营运中拒载</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">营运中绕行</a>
			              <span style="display: none;">一般违章_违反营运条例_营运中绕行</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">营运中违价</a>
			              <span style="display: none;">一般违章_违反营运条例_营运中违价</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">营运中倒客</a>
			              <span style="display: none;">一般违章_违反营运条例_营运中倒客</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">营运中串价</a>
			              <span style="display: none;">一般违章_违反营运条例_营运中串价</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未经乘客同意擅自合乘</a>
			              <span style="display: none;">一般违章_违反营运条例_未经同意擅自合乘</span>
			              <span style="display: none;">10.5</span>
			          </li>
			        </ul>
			      </li>
			       <li><a href="#">擅自改动车辆设施</a>
			        <ul>
			         <li><a class="three_menu" onclick="add_check(this)">擅自改装车载系统</a>
			              <span style="display: none;">一般违章_擅自改动车辆设施_擅自改装车载系统</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">擅自改装清洁能源</a>
			              <span style="display: none;">一般违章_擅自改动车辆设施_擅自改装清洁能源</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="add_check(this)">发动机变更未到公司申请备案</a>
			              <span style="display: none;">一般违章_擅自改动车辆设施_发动机变更未到公司申请备案</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">车架子变更未到公司申请备案</a>
			              <span style="display: none;">一般违章_擅自改动车辆设施_车架子变更未到公司申请备案</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          
			          
			        
			        </ul>
			      </li>
			       <li><a class="three_menu" onclick="diy_add_check(this)">未在专用停车场依次上下车</a>
			              <span style="display: none;">一般违章_未在专用停车场依次上下车</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="diy_add_check(this)">未按时接受违制调查处理</a>
			              <span style="display: none;">一般违章_未按时接受违制调查处理</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="diy_add_check(this)">未接受资格证审验</a>
			              <span style="display: none;">一般违章_未接受资格证审验</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="diy_add_check(this)">未正确使用对讲机</a>
			              <span style="display: none;">一般违章_未正确使用对讲机</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="diy_add_check(this)">未按时检计价器</a>
			              <span style="display: none;">一般违章_未按时检计价器</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="diy_add_check(this)">未按时二级维护</a>
			              <span style="display: none;">一般违章_未按时二级维护</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="diy_add_check(this)">未按时检定车辆</a>
			              <span style="display: none;">一般违章_未按时检定车辆</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="diy_add_check(this)">车辆设施</a>
			              <span style="display: none;">一般违章_车辆设施</span>
			              <span style="display: none;">10.5</span>
			          </li>
			      
			    </ul>
			</li>
	      	 
			  <li><a href="#">轻微违制</a>
			    <ul>
			      <li><a href="#">运营服务违制</a>
			        <ul>
			          <li><a class="three_menu" onclick="add_check(this)">服务态度引发乘车纠纷</a>
			              <span style="display: none;">轻微违章_运营服务违制_服务态度引发乘车纠纷</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未按规定使用计价器</a>
			              <span style="display: none;">轻微违章_运营服务违制_未按规定使用计价器</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未办理监督卡从事营运</a>
			              <span style="display: none;">轻微违章_运营服务违制_未办理监督卡从事营运</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">转借、串用票据</a>
			              <span style="display: none;">轻微违章_运营服务违制_转借、串用票据</span>
			              <span style="display: none;">10.5</span>
			          </li>
			        
			        </ul>
			      </li>
			       <li><a href="#">不符合营运标准的</a>
			        <ul>
			          <li><a class="three_menu" onclick="add_check(this)">营运时吸烟</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_营运时吸烟</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">行驶中打手机</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_行驶中打手机</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">营运中衣着不整</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_营运中衣着不整</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未按乘客要求使用空调音响</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_未按乘客要求使用空调音响</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未如实给付乘客有效票据</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_未如实给付乘客有效票据</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未携带有效相关证件运营</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_未携带有效相关证件运营</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">场外违法等客</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_场外违法等客</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">未按公司规定着装</a>
			              <span style="display: none;">轻微违章_不符合营运标准的_未按公司规定着装</span>
			              <span style="display: none;">10.5</span>
			          </li>
			        </ul>
			      </li>
			       <li><a href="#">车容不整</a>
			        <ul>
			          <li><a class="three_menu" onclick="add_check(this)">后风挡台有杂物</a>
			              <span style="display: none;">轻微违章_车容不整_后风挡台有杂物</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">座套不符合标准</a>
			              <span style="display: none;">轻微违章_车容不整_座套不符合标准</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">后备箱卫生不合格</a>
			              <span style="display: none;">轻微违章_车容不整_后备箱卫生不合格</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">价格贴缺失</a>
			              <span style="display: none;">轻微违章_车容不整_价格贴缺失</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">价格贴字迹不清晰</a>
			              <span style="display: none;">轻微违章_车容不整_价格贴字迹不清晰</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">牌照陈旧需要更换</a>
			              <span style="display: none;">轻微违章_车容不整_未牌照陈旧需要更换</span>
			              <span style="display: none;">10.5</span>
			          </li>
			        </ul>
			      </li>
			        <li><a href="#">车辆外观及设施不达标</a>
			        <ul>
			          <li><a class="three_menu" onclick="add_check(this)">灭火器不合格</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_灭火器不合格</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">标志灯不合格</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_标志灯不合格</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">门标缺失</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_门标缺失</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">车体灯光缺失</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_车体灯光缺失</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">保险杠损坏</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_保险杠损坏</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">刹车灯不亮</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_刹车灯不亮</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">后盖板掉漆或裂痕</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_后盖板掉漆或裂痕</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="add_check(this)">安装怪音喇叭</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_安装怪音喇叭</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="add_check(this)">牌照未安装好</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_牌照未安装好</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="add_check(this)">计价器铅封不全</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_计价器铅封不全</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="add_check(this)">不是本公司套座</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_不是本公司套座</span>
			              <span style="display: none;">10.5</span>
			          </li>
			           <li><a class="three_menu" onclick="add_check(this)">装饰灯掉</a>
			              <span style="display: none;">轻微违章_车辆外观及设施不达标_装饰灯掉</span>
			              <span style="display: none;">10.5</span>
			          </li>
			        </ul>
			      </li>
			       <li><a href="#">不文明营运</a>
			        <ul>
			          <li><a class="three_menu" onclick="add_check(this)">营运中未使用文明用语</a>
			              <span style="display: none;">轻微违章_不文明营运_灭火器不合格</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">营运过程中饮食</a>
			              <span style="display: none;">轻微违章_不文明营运_营运过程中饮食</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">随地大小便</a>
			              <span style="display: none;">轻微违章_不文明营运_随地大小便</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          <li><a class="three_menu" onclick="add_check(this)">机动车道下客</a>
			              <span style="display: none;">轻微违章_不文明营运_机动车道下客</span>
			              <span style="display: none;">10.5</span>
			          </li>
			          
			        </ul>
			      </li>
			    </ul>
			  </li>
			  
			</ul>
		</div>
	</div>
	
	<div>
		  <table id="check_table" style="width: 500px;background-color:#EEE;" border="1">
		  	<tr>
		  		<td>不合格项目</td>
		  		<td class="sl">扣分</td>
		  		<td>添加照片</td>
		  	</tr>
		  </table>
	</div>
    <!--<span><input type="checkbox" onclick="dealForm(this)" value="one|10.5" id="1">one</span>
    <span><input type="checkbox" onclick="dealForm(this)" value="two|11.5" id="2">two</span>-->

	</div>

<div id="lala">
</div>
<div id="iframes">

</div>
<input type="button" onclick="submitAll()" value="添加"/>

<!--手风琴js-->
<script src='/DZOMS/res/down_menu/js/stopExecutionOnTimeout.js?t=1'></script>
<script src='/DZOMS/res/down_menu/js/jquery.velocity.min.js'></script><script>
	;(function ($, window, document, undefined) {
	    if ($('ul.mtree').length) {
	        var collapsed = true;
	        var close_same_level = false;
	        var duration = 400;
	        var listAnim = true;
	        var easing = 'easeOutQuart';
	        $('.mtree ul').css({
	            'overflow': 'hidden',
	            'height': collapsed ? 0 : 'auto',
	            'display': collapsed ? 'none' : 'block'
	        });
	        var node = $('.mtree li:has(ul)');
	        node.each(function (index, val) {
	            $(this).children(':first-child').css('cursor', 'pointer');
	            $(this).addClass('mtree-node mtree-' + (collapsed ? 'closed' : 'open'));
	            $(this).children('ul').addClass('mtree-level-' + ($(this).parentsUntil($('ul.mtree'), 'ul').length + 1));
	        });
	        $('.mtree li > *:first-child').on('click.mtree-active', function (e) {
	            if ($(this).parent().hasClass('mtree-closed')) {
	                $('.mtree-active').not($(this).parent()).removeClass('mtree-active');
	                $(this).parent().addClass('mtree-active');
	            } else if ($(this).parent().hasClass('mtree-open')) {
	                $(this).parent().removeClass('mtree-active');
	            } else {
	                $('.mtree-active').not($(this).parent()).removeClass('mtree-active');
	                $(this).parent().toggleClass('mtree-active');
	            }
	        });
	        node.children(':first-child').on('click.mtree', function (e) {
	            var el = $(this).parent().children('ul').first();
	            var isOpen = $(this).parent().hasClass('mtree-open');
	            if ((close_same_level || $('.csl').hasClass('active')) && !isOpen) {
	                var close_items = $(this).closest('ul').children('.mtree-open').not($(this).parent()).children('ul');
	                if ($.Velocity) {
	                    close_items.velocity({ height: 0 }, {
	                        duration: duration,
	                        easing: easing,
	                        display: 'none',
	                        delay: 100,
	                        complete: function () {
	                            setNodeClass($(this).parent(), true);
	                        }
	                    });
	                } else {
	                    close_items.delay(100).slideToggle(duration, function () {
	                        setNodeClass($(this).parent(), true);
	                    });
	                }
	            }
	            el.css({ 'height': 'auto' });
	            if (!isOpen && $.Velocity && listAnim)
	                el.find(' > li, li.mtree-open > ul > li').css({ 'opacity': 0 }).velocity('stop').velocity('list');
	            if ($.Velocity) {
	                el.velocity('stop').velocity({
	                    height: isOpen ? [
	                        0,
	                        el.outerHeight()
	                    ] : [
	                        el.outerHeight(),
	                        0
	                    ]
	                }, {
	                    queue: false,
	                    duration: duration,
	                    easing: easing,
	                    display: isOpen ? 'none' : 'block',
	                    begin: setNodeClass($(this).parent(), isOpen),
	                    complete: function () {
	                        if (!isOpen)
	                            $(this).css('height', 'auto');
	                    }
	                });
	            } else {
	                setNodeClass($(this).parent(), isOpen);
	                el.slideToggle(duration);
	            }
	            e.preventDefault();
	        });
	        function setNodeClass(el, isOpen) {
	            if (isOpen) {
	                el.removeClass('mtree-open').addClass('mtree-closed');
	            } else {
	                el.removeClass('mtree-closed').addClass('mtree-open');
	            }
	        }
	        if ($.Velocity && listAnim) {
	            $.Velocity.Sequences.list = function (element, options, index, size) {
	                $.Velocity.animate(element, {
	                    opacity: [
	                        1,
	                        0
	                    ],
	                    translateY: [
	                        0,
	                        -(index + 1)
	                    ]
	                }, {
	                    delay: index * (duration / size / 2),
	                    duration: duration,
	                    easing: easing
	                });
	            };
	        }
	        if ($('.mtree').css('opacity') == 0) {
	            if ($.Velocity) {
	                $('.mtree').css('opacity', 1).children().css('opacity', 0).velocity('list');
	            } else {
	                $('.mtree').show(200);
	            }
	        }
	    }
	}(jQuery, this, this.document));
	$(document).ready(function () {
	    var mtree = $('ul.mtree');
	    mtree.wrap('<div class=mtree-demo></div>');
	    var skins = [
	        'bubba',
	        'skinny',
	        'transit',
	        'jet',
	        'nix'
	    ];
	    mtree.addClass(skins[0]);
	   
	    var s = $('.mtree-skin-selector');
	    $.each(skins, function (index, val) {
	        s.find('ul').append('<li><button class="small skin">' + val + '</button></li>');
	    });
	    s.find('ul').append('<li><button class="small csl active">Close Same Level</button></li>');
	    s.find('button.skin').each(function (index) {
	        $(this).on('click.mtree-skin-selector', function () {
	            s.find('button.skin.active').removeClass('active');
	            $(this).addClass('active');
	            mtree.removeClass(skins.join(' ')).addClass(skins[index]);
	        });
	    });
	    s.find('button:first').addClass('active');
	    s.find('.csl').on('click.mtree-close-same-level', function () {
	        $(this).toggleClass('active');
	    });
	});
	</script>
</body>
</html>