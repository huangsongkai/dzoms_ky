<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head lang="en">

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">

    <title>
        添加
    </title>

    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css"/>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js"></script>

    <style>
        .label {
            white-space: pre-line;
        }
    </style>

    <script>
        function setCarframeNum() {
            var licenseNum = $("#licenseNum").val();
            $.post("/DZOMS/common/doit", {
                "condition": "from Vehicle where licenseNum='" + licenseNum + "'"
            }, function (data) {
                data = data["affect"];
+6+
                if (data === undefined) {
                    return;
                }

                $("#carFrameNum").val(data["carframeNum"]);
            });
        }

        function setIdNum() {
            var idName = $("#idName").val();
            $.post("/DZOMS/common/doit", {
                "condition": "from Driver where name='" + idName + "'"
            }, function (data) {
                data = data["affect"];

                if (data == undefined) {
                    return;
                }

                $("#idNum").val(data["idNum"]);
            });
        }

        $(document).ready(function () {
            $("#licenseNum").bigAutocomplete({
                url: "/DZOMS/select/vehicleByLicenseNum",
                callback: setCarframeNum
            });

            $("#idName").bigAutocomplete({
                url: "/DZOMS/select/driverByName",
                callback: setIdNum
            });

            var error_msg = "<s:property value="errorMsg"></s:property>";
            if (error_msg.length > 0) {
                alert(error_msg);
            }
        });
    </script>
</head>

<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>押金管理</li>
        <li>新增</li>
    </ul>
</div>

<div class="xm7 xm2-move">
    <div class="panel">
        <div class="panel-head">新增押金信息</div>
        <div class="panel-body">
            <form class="form-x" action="/DZOMS/charge/deposit_add" method="post">
                <div class="form-group">
                    <div class="label">
                        <label>
                            车号
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" id="licenseNum">
                        <s:hidden id="carFrameNum" name="deposit.carframeNum"></s:hidden>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            驾驶员
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" id="idName">
                        <s:hidden id="idNum" name="deposit.idNum"></s:hidden>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            押金金额
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input" name="deposit.inMoney"/>

                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            押金票号
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input" name="deposit.depositId"/>

                    </div>
                </div>
                <div class="xm6-move">
                    <input type="submit" class="button bg-green" value="提交">
                </div>
            </form>
        </div>

    </div>
</div>
</body>
</html>