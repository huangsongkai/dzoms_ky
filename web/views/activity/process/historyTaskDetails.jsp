<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>任务详情页</title>
	<link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
	<style type="text/css">q
		.selected>li:hover,.selected>li.active{
			background-color:#1E90FF;
		}
	</style>

</head>
<body>
<div class="container">
	<div id="header">
		<h2>任务详情</h2>
	</div>
	<div id="historyTaskDetails"></div>
</div>

</body>
<script type="text/javascript">
	var pageUrls ={
		jumpUrl:"/DZOMS/ky/activity/history/list",
	}
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/processAll-bundle.js"></script>
</html>