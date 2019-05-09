<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="com.dz.module.user.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";


	String uid = request.getParameter("user.uid");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
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
            $.post("/DZOMS/manage/getAuthoritiesByUser",{"user.uid":<%=uid%>},function(data){
                console.log(data);
                var json = $.parseJSON(data);
                var json = json["list"][0]["com.dz.module.user.RelationUr"];

                for (var i = 0; i < json.length; i++) {

                    var robj = json[i];

                    $(".role"+robj["rid"]+"").prop("checked",true);



                }

            });
        });
	</script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
	<ul class="bread text-main" style="font-size: larger;">
		<li>系统管理</li>
		<li>权限管理</li>
	</ul>
</div>
<body>
<div class="panel">
	<div class="panel-head">
		权限分配
	</div>
	<div class="panel-body">
		<form action="/DZOMS/manage/assignAuthority?user.uid=<%=uid%>" method="post">
			<div>
				<table>
					<td>

						选择角色：
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role149" value="149" />
						分部经理
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role150" value="150" />
						保险员
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role151" value="151" />
						收款员

					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role152" value="152" />
						运营部经理
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role153" value="153" />
						财务负责人
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role154" value="154" />
						财务经理
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role155" value="155" />
						办公室主任
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role156" value="156" />
						副总经理
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role156" value="157" />
						证照员
					</td>
					<td>
						<input type="checkbox" name="roleIds" class="role156" value="157" />
						安全员
					</td>
				</table>
			</div>
			<div class="tab">
				<div class="tab-head">
					<strong>
						分类：
					</strong>

					<ul class="tab-nav">
						<li class="active">
							<a href="#tab-contract">
								合同
							</a>
						</li>
						<li>
							<a href="#tab-car">
								车辆
							</a>
						</li>
						<li>
							<a href="#tab-driver">
								驾驶员
							</a>
						</li>
						<li>
							<a href="#tab-charge">
								财务
							</a>
						</li>
						<li>
							<a href="#tab-check">
								审批
							</a>
						</li>
						<li>
							<a href="#tab-permission">
								系统管理
							</a>
						</li>
						<li>
							<a href="#tab-statistics">
								统计分析
							</a>
						</li>
						<li>
							<a href="#tab-update">
								特殊修改权限
							</a>
						</li>
					</ul>
				</div>
				<div class="tab-body">
					<div class="tab-panel active" id="tab-contract">
						<div class="panel">
							<div class="panel-head">
								合同
							</div>
							<div class="panel-body">
								<table class="table table-bordered">
									<tr>
										<td>
											<input type="checkbox" name="roleIds" class="role18" value="18" />
											合同新增
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role22" value="22" />
											合同查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role19" value="19" />
											所有合同
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role20" value="20" />
											有效合同
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role21" value="21" />
											已废止合同
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role404" value="404" />
											合同修改权限
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role414" value="414" />
											合同档案号修改权限
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="tab-panel" id="tab-car">
						<div class="panel">
							<div class="panel-head">
								车辆管理
							</div>
							<div class="panel-body">
								<table class="table table-bordered">
									<tr>
										<td>
											<strong>
												新增：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role31" value="31" />
											新增车辆型号
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role28" value="28" />
											新增车辆技术信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role56" value="56" />
											新增发票信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role58" value="58" />
											新增购置税信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role60" value="60" />
											新增牌照信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role72" value="72" />
											新增保险信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role308" value="308" />
											保险续保
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role180" value="180" />
											绑定承租人
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role62" value="62" />
											新增计价器信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role181" value="181" />
											新增营运证信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role64" value="64" />
											新增经营权信息
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												查看：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role30" value="30" />
											查询车辆型号
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role29" value="29" />
											查询车辆技术信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role57" value="57" />
											查询发票信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role59" value="59" />
											查询购置税信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role73" value="73" />
											查询保险信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role61" value="61" />
											查询牌照信息
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role63" value="63" />
											查看计价器信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role182" value="182" />
											查看营运证信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role65" value="65" />
											查看经营权信息
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												修改：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role406" value="406" />
											修改车辆型号
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role405" value="405" />
											修改车辆技术信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role407" value="407" />
											修改发票信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role408" value="408" />
											修改购置税信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role409" value="409" />
											修改保险信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role410" value="410" />
											修改牌照信息
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role411" value="411" />
											修改计价器信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role412" value="412" />
											修改营运证信息
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role413" value="413" />
											修改经营权信息
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												自检：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role300" value="300" />
											复检
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role301" value="301" />
											统计
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role46" value="46" />
											新增自检计划
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role47" value="47" />
											查询计划执行结果
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role147" value="147" />
											添加车辆
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												客运检车：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role66" value="66" />
											客运检车
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												营运数据导入：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role160" value="160" />
											导入文件
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role161" value="161" />
											查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role162" value="162" />
											错误数据查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role163" value="163" />
											未导入的车辆
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role164" value="164" />
											导入菜单
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role165" value="165" />
											手工补充
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role166" value="166" />
											数据清理
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role167" value="167" />
											日报表统计
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												电子违章：
											</strong>
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role420" value="420" />
											违章统计
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role171" value="171" />
											电子违章查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role172" value="172" />
											电子违章下载(旧)
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role67" value="67" />
											单车查询
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												车辆废业
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role100" value="100" />
											车辆废业计划
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role422" value="422" />
											车辆废业起始日期修改权限
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role423" value="423" />
											车辆废业结束日期修改权限
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role432" value="432" />
											车辆废业——更新对照
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="tab-panel" id="tab-driver">
						<div class="panel">
							<div class="panel-head">
								驾驶员管理
							</div>
							<div class="panel-body">
								<table class="table table-bordered">
									<tr>
										<td>
											<strong>
												聘用：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role302" value="302" />
											提请聘用
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role16" value="16" />
											聘用审核
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role17" value="17" />
											驾驶员查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role416" value="416" />
											驾驶员修改
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												黑名单：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role37" value="37" />
											新增黑名单
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role34" value="34" />
											查询黑名单
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												证照申请：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role48" value="48" />
											申请登记
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role70" value="70" />
											申请注销
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												证照办领：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role49" value="49" />
											办理登记
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role71" value="71" />
											办理注销
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												证照查询：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role50" value="50" />
											证照查询
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												上下车记录查询：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role51" value="51" />
											上下车记录查询
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												事故：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role32" value="32" />
											事故登记
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role33" value="33" />
											事故查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role102" value="102" />
											事故处理
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												投诉：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role38" value="38" />
											添加投诉
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role39" value="39" />
											查询投诉
										</td>
										<td><input type="checkbox" name="roleIds" class="role433" value="433" />投诉落实</td>
										<td><input type="checkbox" name="roleIds" class="role434" value="434" />投诉回访</td>
										<td><input type="checkbox" name="roleIds" class="role435" value="435" />投诉完结</td>
										<td><input type="checkbox" name="roleIds" class="role436" value="436" />投诉补充登记</td>
									</tr>
									<tr>
										<td>
											<strong>
												表扬：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role40" value="40" />
											添加表扬
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role41" value="41" />
											查询表扬
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role103" value="103" />
											表扬处理
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												例会：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role52" value="52" />
											新增例会
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role53" value="53" />
											例会查询
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												家访：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role105" value="105" />
											登记
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role106" value="106" />
											查询
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												活动：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role44" value="44" />
											添加
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role45" value="45" />
											查询
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												待岗管理：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role54" value="54" />
											待岗申请
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role68" value="68" />
											上岗申请
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role69" value="69" />
											待岗记录查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role421" value="421" />
											待岗审批权限
										</td>
									</tr>
									<!--晚上更新-->
									<tr>
										<td>
											<strong>
												车队管理：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role55" value="55" />
											车队管理
										</td>
									</tr>
									<tr>
										<td>
											<strong>
												媒体荣誉：
											</strong>
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role42" value="42" />
											添加媒体荣誉
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role43" value="43" />
											查询媒体荣誉
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="tab-panel" id="tab-charge">
						<div class="panel">
							<div class="panel-head">
								财务管理
							</div>
							<div class="panel-body">
								<table class="table table-bordered">
									<tr>
										<td>银行卡管理：</td>
										<td>
											<input type="checkbox" name="roleIds" class="role23" value="23" />
											银行卡新增
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role24" value="24" />
											银行卡查看
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role107" value="107" />
											银行卡车辆关联查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role415" value="415" />
											银行卡修改
										</td>
									</tr>
									<tr>
										<td>发票管理：</td>
										<td>
											<input type="checkbox" name="roleIds" class="role26" value="26" />
											发票进货
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role148" value="148" />
											发票销售
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role158" value="158" />
											库存管理
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role159" value="159" />
											作废查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role27" value="27" />
											发票进货记录
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role418" value="418" />
											发票作废权限
										</td>
									</tr>
									<tr>
										<td>计划管理：</td>
										<td>
											<input type="checkbox" name="roleIds" class="role75" value="75" />
											单车约定
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role74" value="74" />
											批量约定
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role77" value="77" />
											银行计划
										</td>
									</tr>
									<tr>
										<td>收费管理：</td>
										<td>
											<input type="checkbox" name="roleIds" class="role76" value="76" />
											银行导入
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role80" value="80" />
											单车收款
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role83" value="83" />
											欠款清账
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role79" value="79" />
											取款
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role82" value="82" />
											清账
										</td>
									</tr>
									<tr>
										<td>查询：</td>
										<td>
											<input type="checkbox" name="roleIds" class="role78" value="78" />
											财务对账表
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role81" value="81" />
											单车收费查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role84" value="84" />
											收费类型查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role85" value="85" />
											收费统计
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role424" value="424" />
											银行导入查询
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
											<input type="checkbox" name="roleIds" class="role306" value="306" />
											单车计划查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role304" value="304" />
											多车计划查询
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role305" value="305" />
											单车约定查询
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>

					<div class="tab-panel" id="tab-check">
						<div class="panel">
							<div class="panel-head">
								审批
							</div>
							<div class="panel-body">
								<table class="table table-bordered">

									<tr>

										<td>
											<input type="checkbox" name="roleIds" class="role15" value="15" />
											生成开业
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role1" value="1" />
											生成废业
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role190" value="190" />
											审批状态查询
										</td>

									</tr>

								</table>
							</div>
						</div>
					</div>

					<div class="tab-panel" id="tab-permission">
						<div class="panel">
							<div class="panel-head">
								系统管理
							</div>
							<div class="panel-body">
								<input type="checkbox" name="roleIds" class="role2" value="2" checked="checked" style="display: none;" />
								<table class="table table-bordered">
									<tr>
										<td>
											<input type="checkbox" name="roleIds" class="role201" value="201" />
											添加用户
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role202" value="202" />
											查询用户
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role427" value="427" />
											财务查错
										</td>
									</tr>

								</table>
							</div>
						</div>
					</div>

					<div class="tab-panel" id="tab-statistics">
						<div class="panel">
							<div class="panel-head">
								统计分析
							</div>
							<div class="panel-body">
								<table class="table table-bordered">

									<tr>
										<td>
											<input type="checkbox" name="roleIds" class="role425" value="425" />
											审批流程统计
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role426" value="426" />
											财务统计
										</td>

									</tr>

								</table>
							</div>
						</div>
					</div>

					<div class="tab-panel" id="tab-update">
						<div class="panel">
							<div class="panel-head">
								特殊修改权限<span style="color: red;">(建议只分给管理员)</span>
							</div>
							<div class="panel-body">
								<table class="table table-bordered">

									<tr>
										<td>
											<input type="checkbox" name="roleIds" class="role428" value="428" />
											废业办理事项修改权限
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role429" value="429" />
											合同起始日期修改权限
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role430" value="430" />
											合同终止日期修改权限
										</td>

										<td>
											<input type="checkbox" name="roleIds" class="role431" value="431" />
											约定重新生成权限
										</td>
										<td>
											<input type="checkbox" name="roleIds" class="role437" value="437" />
											营运证状态回退
										</td>
									</tr>

								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
			<input type="submit" value="提交" />
		</form>
	</div>
</div>
</body>

</html>
