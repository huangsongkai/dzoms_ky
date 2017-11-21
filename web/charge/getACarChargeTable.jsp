<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>单车收费查询</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
    function setDept(){
      var licenseNum = $("#licenseNum").val();
      if(licenseNum != undefined && licenseNum.trim().length==7){
        $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{'vehicle.licenseNum':licenseNum},function (data){
          data = $.parseJSON(data);
          data = data["ItemTool"]["carframeNum"];
          $.post("/DZOMS/selectContractByCarId",{'contract.carframeNum':data},function(dat){
            $("#dept").val(dat["branchFirm"]);
          });
        });
      }
    }
      function search_(){
          $("#form").attr("action","/DZOMS/charge/getACarChargeTable");
          $("#form").submit();
      }
      function exportxls(){
          $("#form").attr("action","/DZOMS/charge/exportACarChargeTable");
          $("#form").submit();
      }
      function carFocus(){
      	$("#licenseNum").val("黑A");
      }

    $(document).ready(function(){
        $("#licenseNum").bigAutocomplete({
            url:"/DZOMS/select/VehicleBylicenseNum",
            callback:setDept
        });
    });
  </script>
</head>
<body>
	<div class="line padding" style="height: 300px;">
		<form method="post" id="form" action="/DZOMS/charge/getACarChargeTable" style="width: 100%;" class="form-inline form-tips">
			
			 <div class="panel">
        <div class="panel-head">
            <strong>查询条件</strong>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        车牌号：
                    </label>
                </div>
                <div class="field">
                    <input class="input input-auto" size="9" id="licenseNum" name="licenseNum" value="黑A"  onfocus="carFocus()"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        部门：
                    </label>
                </div>
                <div class="field">
                    <input class="input input-auto" size="4"  id="dept" readonly="readonly"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        起始年月：
                    </label>
                </div>
                <div class="field">
                    <input class="input  datepick  input-auto" size="12"  name="timePass.startTime"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        结束年月：
                    </label>
                </div>
                <div class="field">
                    <input class="input datepick input-auto" size="12" name="timePass.endTime"/>                </div>
            </div>
            <input type="button" class="button bg-green" value="查询" onclick="search_()"/>
            <input type="button" class="button bg-green" value="导出" onclick="exportxls()"/>
        </div>
    </div>
</form>
	</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

<script>
    $('.datepick').simpleCanleder();
</script>
</html>
