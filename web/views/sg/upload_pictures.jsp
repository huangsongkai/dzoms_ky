<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title></title>
	<style type="text/css">
		#container{
			width:60%;
			margin:100px auto;
			
		}
		#form{
			text-align:center;
		}
		.file {
		    position: relative;
		    width:119px;
		    margin: 20px auto;
			height:89px;
		    display: inline-block;	   
		    overflow: hidden;		    
		    background: url(../../images/img.png);
		}
		.upload{
			 margin:0 auto;
			 width:154px;
			 height:36px;
			 text-align: center;
			 line-height: 20px;
			 font-size:14px;
			 border-radius: 3px;
			 border:0;
			 background-color: #108EE9;
			 color: #fff;
		}
		.upload:hover{
			 background-color: #49A9EE;
		}
		.con_upload{
			width: 250px;
			margin:0 auto;
			height:180px;
			border: 1px solid #99D3F5;
		    border-radius: 4px;
		    margin-bottom: 15px;
		    position: relative;
		}
		.con_upload input {
			position: absolute;
			bottom:20px;
			left:44px;
		}
	</style>
</head>
<body>
	<div id="container">
		<form id="form" action="/DZOMS/ky/sg/importExcel" enctype="multipart/form-data"   method="post">
			<div class="con_upload">
				<a href="javascript:;" class="file"></a>
				<input type="file" name="upfile" id="upfile" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
			</div>			
			<input class="upload" type="submit"  name="submit" value="开始上传" />
		</form>
	</div>
</body>
</html>