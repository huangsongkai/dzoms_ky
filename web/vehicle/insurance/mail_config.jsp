<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>邮件自动导入配置</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script>
        function submitConfig() {
            var configForm = document.getElementById("configForm");
            var formData = new FormData(configForm);

            $.post('/DZOMS/vehicle/updateConfig', Object.fromEntries(formData), function (responseText) {
                alert(responseText);
            });
        }

        function loadConfig() {
            $.ajax({
                url: '/DZOMS/vehicle/loadConfig',
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    var configData = data.ItemTool;
                    // 将返回的配置数据填充到表单中
                    document.getElementById("enabled").checked = configData.enabled;
                    document.getElementById("notEnabled").checked = !configData.enabled;

                    document.getElementById("protocol").checked = configData.protocol == 'pop3';
                    document.getElementById("protocolImap").checked = configData.protocol != 'pop3';

                    document.getElementById("host").value = configData.host;
                    document.getElementById("port").value = configData.port;
                    document.getElementById("email").value = configData.email;
                    document.getElementById("password").value = configData.password;
                    document.getElementById("sender").value = configData.sender;

                    // 填充 radio 按钮
                    document.getElementById("readAll").checked = configData.readAll;
                    document.getElementById("readUnread").checked = !configData.readAll;

                    document.getElementById("updateState").checked = configData.updateState;
                    document.getElementById("noUpdateState").checked = !configData.updateState;

                    document.getElementById("override").checked = configData.override;
                    document.getElementById("noOverride").checked = !configData.override;
                },
                error: function (error) {
                    alert('读取配置失败：' + error.statusText);
                }
            });
        }

        $(document).ready(function () {
           loadConfig();
        });
    </script>
</head>
<body>
<h1>邮件自动导入配置</h1>
<button type="button" onclick="loadConfig()">刷新当前配置</button>
<p>定时任务启用后，将在每天的01:00和13:00自动执行</p>
<form id="configForm">
    <label for="enabled">是否启用定时任务：</label>
    <input type="radio" id="enabled" name="enabled" value="true"> 启用
    <input type="radio" id="notEnabled" name="enabled" value="false"> 不启用<br>

    <label for="protocol">邮件协议：</label>
    <input type="radio" id="protocol" name="protocol" value="pop3"> POP3（简易连接协议，不支持邮件状态查询, 性能略好）
    <input type="radio" id="protocolImap" name="protocol" value="imap"> IMAP (完整访问协议，支持邮件状态获取，性能略低) <br>

    <label for="host">邮件服务器（网易的POP3和IMAP分别是pop.163.com和imap.163.com）：</label>
    <input type="text" id="host" name="host" required><br>

    <label for="port">（邮件服务器）端口（网易的POP3和IMAP分别是110和143）：</label>
    <input type="number" id="port" name="port" min="1" max="65535" required><br>

    <label for="email">邮箱地址：</label>
    <input type="email" id="email" name="email" required><br>

    <label for="password">pop3/imap token：</label>
    <input type="password" id="password" name="password" required><br>

    <label for="sender">发件方地址：</label>
    <input type="email" id="sender" name="sender" required><br>

    <label for="readAll">读取策略：</label>
    <input type="radio" id="readAll" name="readAll" value="true"> 读取全部邮件
    <input type="radio" id="readUnread" name="readAll" value="false"> 只读取未读邮件<br>

    <label for="updateState">执行策略：</label>
    <input type="radio" id="updateState" name="updateState" value="true"> 读取后修改状态为已读
    <input type="radio" id="noUpdateState" name="updateState" value="false"> 保持原有状态不变<br>

    <label for="override">写入策略：</label>
    <input type="radio" id="override" name="override" value="true"> 覆盖数据
    <input type="radio" id="noOverride" name="override" value="false"> 不覆盖数据<br>

    <button type="button" onclick="submitConfig()">保存配置</button>
</form>
</body>
</html>

