<%@ page import="com.dz.module.driver.accident.Accident" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-10-23
  Time: 下午2:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>事故登记</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/jquery.form.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/fileUpload.js" ></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        function addLoss(){
            var sum = 0;
            $('input.lossType').each(function () {
                sum+=eval($(this).val());
            });
            $('td.lossType').each(function () {
                sum+=eval($(this).text());
            });
//      sum += eval($("#carLoss").val());
//      sum += eval($("#carPaid").val());
//      sum += eval($("#peopleLoss").val());
            $("#allLoss").val(sum);
        }

        function add3(){
            var data={"accident.accId":"<%=((Accident)request.getAttribute("accident")).getAccId()%>","loss.part":1,
                "loss.hd":$(".dialog-win .sw").val(),"loss.name":$(".dialog-win .swrxm").val(),
                "loss.loss":$(".dialog-win .swrss").val()};
            $.post('/DZOMS/apl_addOne',data,function(data){
                var hdstr = $(".dialog-win .sw").val() == 0?"伤":"亡";
                var txt =
                        '<tr id="3t'+data+'">'
                        +'<td>'+hdstr+'</td>'
                        +'<td>'+$(".dialog-win .swrxm").val()+'</td>'
                        +'<td class="lossType">'+$(".dialog-win .swrss").val()+'</td>'+
                        +'<input type="text" id="data"/>'+
                        '</tr>';
                $("#table3").append(txt);
                addLoss();
                alert(hdstr+"_"+$(".dialog-win .swrxm").val()+"_"+$(".dialog-win .swrss").val()+"添加成功");
            });
        };
        //车辆
        function add2(){
            var data={"accident.accId":"<%=((Accident)request.getAttribute("accident")).getAccId()%>","loss.part":1,
                "loss.carId":$(".dialog-win .cph").val(),"loss.carType":$(".dialog-win .cx").val(),
                "loss.carLoss":$(".dialog-win .ss").val()};
            $.post('/DZOMS/acl_addOne',data,function(data){
                var txt =
                        '<tr id="2t'+data+'">'
                        +'<td>'+$(".dialog-win .cph").val()+'</td>'
                        +'<td>'+$(".dialog-win .cx").val()+'</td>'
                        +'<td class="lossType">'+$(".dialog-win .ss").val()+'</td>'+
                        '</tr>';
                $("#table2").append(txt);
                addLoss();
                alert($(".dialog-win .cph").val()+"_"+$(".dialog-win .cx").val()+"_"+$(".dialog-win .ss").val()+"添加成功");
            });
        };
        function add1(){
            var data={"accident.accId":"<%=((Accident)request.getAttribute("accident")).getAccId()%>","loss.part":0,
                "loss.hd":$(".dialog-win .sw").val(),"loss.name":$(".dialog-win .swrxm").val(),
                "loss.loss":$(".dialog-win .swrss").val()};
            $.post('/DZOMS/apl_addOne',data,function(data){
                var hdstr = $(".dialog-win .sw").val() == 0?"伤":"亡";
                var txt =
                        '<tr id="1t'+data+'">'
                        +'<td>'+hdstr+'</td>'
                        +'<td>'+$(".dialog-win .swrxm").val()+'</td>'
                        +'<td class="lossType">'+$(".dialog-win .swrss").val()+'</td>'+
                        '</tr>';
                $("#table1").append(txt);
                addLoss();
                alert(hdstr+"_"+$(".dialog-win .swrxm").val()+"_"+$(".dialog-win .swrss").val()+"添加成功");
            });
        }
        function delete1(){
            if($("#table1 tr:last").html() !=$("#table1 tr:first").html()){
                var id = $("#table1 tr:last").attr("id").slice(2);
                var data={"accident.accId":"<%=((Accident)request.getAttribute("accident")).getAccId()%>",
                    "loss.plId":id};
                $.post('/DZOMS/apl_removeOne',data,function(data){
                    $("#table1 tr:last").remove();
                });
            }
            else{
                alert("已无数据");
            }
            addLoss();
        }
        function delete2(){
            if($("#table2 tr:last").html() !=$("#table2 tr:first").html()){
                var id = $("#table2 tr:last").attr("id").slice(2);
                var data={"accident.accId":"<%=((Accident)request.getAttribute("accident")).getAccId()%>",
                    "loss.clId":id};
                $.post('/DZOMS/acl_removeOne',data,function(data){
                    $("#table2 tr:last").remove();
                });
            }
            else{
                alert("已无数据");
            }
            addLoss();
        }
        function delete3(){
            if($("#table3 tr:last").html() !=$("#table3 tr:first").html()){
                var id = $("#table3 tr:last").attr("id").slice(2);
                var data={"accident.accId":"<%=((Accident)request.getAttribute("accident")).getAccId()%>",
                    "loss.plId":id};
                $.post('/DZOMS/apl_removeOne',data,function(data){
//          alert(data);
                    $("#table3 tr:last").remove();
                });
            }
            else{
                alert("已无数据");
            }
            addLoss();
        }
        function setLicenseNum(){
            var dat = {"vehicle.carframeNum":"<%=((Accident)request.getAttribute("accident")).getCarId()%>"};
            $.post('/DZOMS/vehicle/vehicleSelectById',dat,function(data){
                da = $.parseJSON(data);
                $("#licenseNum").attr("value",da["ItemTool"]["licenseNum"]);
            });
        };
        $(document).ready(function(){
            var id = '<input type="hidden" name="accident.accId" value="<%=((Accident)request.getAttribute("accident")).getAccId()%>">';
            $("#base_form",parent.document).append(id);
            $("#saver",parent.document).val("更新");
            $("#base_form",parent.document).attr("action","/DZOMS/accident_Update");
            $("#base_form",parent.document).attr("target","hidefucker");
            $("#saver",parent.document).click(function(){
                $("#base_form",parent.document).submit();
            });
            setLicenseNum();
            addLoss();
            load1("<%=((Accident)request.getAttribute("accident")).getAccId()%>");
            load2("<%=((Accident)request.getAttribute("accident")).getAccId()%>");
            load3("<%=((Accident)request.getAttribute("accident")).getAccId()%>");
            loadX("<%=((Accident)request.getAttribute("accident")).getAccId()%>");
        });
        function load1(accidentId){
            var dat = {'accident.accId':accidentId};
            $.post('/DZOMS/apl_search_0',dat,function(data){
                data = $.parseJSON(data);
                data = data["list"][0]["com.dz.module.driver.accident.PeopleLoss"];
                if(data.length == undefined){
                    data = [data];
                }
                for(var i = 0;i < data.length;++i){
                    var cur = data[i];
                    var hdstr = cur["hd"] == 0?"伤":"亡";
                    var txt =
                            '<tr id="1t'+cur["plId"]+'">'
                            +'<td>'+hdstr+'</td>'
                            +'<td>'+cur["name"]+'</td>'
                            +'<td>'+cur["loss"]+'</td>'+
                            '</tr>';
                    $("#table1").append(txt);
                }
            });
        };
        function load2(accidentId){
            var dat = {'accident.accId':accidentId};
            $.post('/DZOMS/acl_search_1',dat,function(data){
                data = $.parseJSON(data);
                data = data["list"][0]["com.dz.module.driver.accident.CarLoss"];
                if(data.length == undefined){
                    data = [data];
                }
                for(var i = 0;i < data.length;++i){
                    var cur = data[i];
                    var txt =
                            '<tr id="2t'+cur["clId"]+'">'
                            +'<td>'+cur["carId"]+'</td>'
                            +'<td>'+cur["carType"]+'</td>'
                            +'<td>'+cur["carLoss"]+'</td>'+
                            '</tr>';
                    $("#table2").append(txt);
                }
            });
        };
        function load3(accidentId){
            var dat = {'accident.accId':accidentId};
            $.post('/DZOMS/apl_search_1',dat,function(data){
                data = $.parseJSON(data);
                data = data["list"][0]["com.dz.module.driver.accident.PeopleLoss"];
                if(data.length == undefined){
                    data = [data];
                }
                for(var i = 0;i < data.length;++i){
                    var cur = data[i];
                    var hdstr = cur["hd"] == 0?"伤":"亡";
                    var txt =
                            '<tr id="3t'+cur["plId"]+'">'
                            +'<td>'+hdstr+'</td>'
                            +'<td>'+cur["name"]+'</td>'
                            +'<td>'+cur["loss"]+'</td>'+
                            '</tr>';
                    $("#table3").append(txt);
                }
            });
        };
        function loadX(accidentId){
            $.post("/DZOMS/accident_InsuranceGet", {"accident.accId":accidentId},function(data){
                data = $.parseJSON(data);
                data = data["ItemTool"];
                if(data["com_thief"] == true){
                    $("#com_thief").attr("checked","checked");
                }
                if(data["com_car"] == true){
                    $("#com_car").attr("checked","checked");
                }
                if(data["com_people"] == true){
                    $("#com_people").attr("checked","checked");
                }
                if(data["com_other"] == true){
                    $("#com_other").attr("checked","checked");
                }
                if(data["tra_doc"] == true){
                    $("#tra_doc").attr("checked","checked");
                }
                if(data["tra_car"] == true){
                    $("#tra_car").attr("checked","checked");
                }
                if(data["tra_people"] == true){
                    $("#tra_people").attr("checked","checked");
                }
                if(data["tra_other"] == true){
                    $("#tra_other").attr("checked","checked");
                }
                $("#acc_learn").val(data["acc_learn"]);
                var filePaths = data["filePaths"][0]["string"];
                if(typeof filePaths == 'string')
                    filePaths = [filePaths];
                for(var each in filePaths){
                    var filePath = filePaths[each];
                    var nameArray = filePath.toString().split("/");
                    var fileName = nameArray[nameArray.length - 1];
                    var kk = "kk"+each;
                    var oneRow = "<input type='checkbox' class='"+kk+"'><input type='text' class='"+kk+"' name='fids' value='"+fileName+"' readonly><a class='"+kk+"' href='/DZOMS/download?filePath="+filePath+"'>查看</a><br class='"+kk+"'/>"
                    $("#fileHolder").append(oneRow);
                }
            });
        };
        function dosubmit(){
            $("#form").ajaxSubmit(function (data) {
                alert("添加成功！！");
                parent.location.href = "/DZOMS/driver/accident/accident_add.jsp";
            });
        }
    </script>
    <script>
        function successFuc(x){
            $("#show"+x).val(fileObjMap[$("#up"+x).attr("dz-index")]["filename"]);
        }
        var fileCounter = 0;
        function addFile(){
            var checkBox = "<input type='checkbox' class='f"+fileCounter+"'>";
            var file = "<input class='dz-file f"+fileCounter+"' name='fids' data-toggle='click' data-target='.addbtn"+fileCounter+" ' sessuss-function='successFuc("+fileCounter+");' id='up"+fileCounter+"'/>";
            var show = "<input type='text' readonly id='show"+fileCounter+"' class='f"+fileCounter+"'>";
            var but = "<input type='button' id='but"+fileCounter+"' style='display: none' class='button input-file bg-green addbtn"+fileCounter+" f"+fileCounter+"'><br class='f"+fileCounter+"'/>";
            $("#fileHolder").append(checkBox);
            $("#fileHolder").append(file);
            $("#fileHolder").append(show);
            $("#fileHolder").append(but);
            fileRefresh();
            $("#but"+fileCounter).click();
            fileCounter++;
        }
        function deleteFile(){
            $("#fileHolder input[type='checkbox']:checked").each(function(){
                var classToDelete = $(this).attr("class");
                $("."+classToDelete).remove();
            });
        }
    </script>
    <style>
        .label{
            width: 100px;
            text-align: right;
        }
    </style>
</head>
<body>
<%Accident accident = (Accident)request.getAttribute("accident");%>
<div class="line">
    <form method="post" class="form-tips form-inline" action="/DZOMS/accident_UpdateLoss" id="form">
        <div class="panel">
            <div class="panel-body">
                <!--保险-->
                <div class="line">
                    <blockquote class="xm6">
                        <strong>商业险</strong>
                        <input type="checkbox" name="com_thief" id="com_thief"><label>盗抢险</label>
                        <input type="checkbox" name="com_car" id="com_car"><label>车损险</label>
                        <input type="checkbox" name="com_people" id="com_people"><label>车上人员险</label>
                        <input type="checkbox" name="com_other" id="com_other"><label>其他</label>
                    </blockquote>
                    <blockquote class="xm6">
                        <strong>交强险</strong>
                        <input type="checkbox" name="tra_doc" id="tra_doc"><label>医疗险</label>
                        <input type="checkbox" name="tra_car" id="tra_car"><label>车损险</label>
                        <input type="checkbox" name="tra_people" id="tra_people"><label>伤残险</label>
                        <input type="checkbox" name="tra_other" id="tra_other"><label>其他</label>
                    </blockquote>
                </div>
                <!--教训-->
                <div class="line">
                    <blockquote>
                        <div class="form-group margin">
                            <div style="width: 100px; float: left;">
                                <strong>事故教训:</strong>
                            </div>
                            <div class="field">
                                <textarea rows="5" style="width: 500px;" type="text" name="accidentinsurance.acc_learn" id="acc_learn" class="input"></textarea>
                            </div>
                        </div>
                    </blockquote>
                </div>
                <!--文件-->
                <div class="line">
                    <blockquote>
                        <div class="form-group margin">
                            <div style="width: 100px; float: left;">
                                <strong>文件:</strong>
                            </div>
                            <div class="field">
                                <div id="fileHolder"></div>
                                <input type="button" value="添加" onclick="addFile()"/>
                                <input type="button" value="删除" onclick="deleteFile()"/>
                            </div>
                        </div>
                    </blockquote>
                </div>
                <!--甲方-->
                <input type="hidden" name="accident.accId" value="<%=accident.getAccId()%>">
                <div class="line">
                    <blockquote>
                        <strong>甲方损失:</strong>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    车牌号
                                </label>
                            </div>
                            <div class="field">
                                <input class="input input-auto"  type="text" size="20" id="licenseNum" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    车损失
                                </label>
                            </div>
                            <div class="field">
                                <input class="input input-auto lossType" size="20" id="carLoss" name="loss.carLoss" onblur="addLoss()" value="<%=accident==null?0:(accident.getCarLoss()==null?0:accident.getCarLoss())%>">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    车赔付
                                </label>
                            </div>
                            <div class="field">
                                <input class="input input-auto" size="20" id="carPaid" name="loss.carPaid" onblur="addLoss()" value="<%=accident==null?0:(accident.getCarPaid()==null?0:accident.getCarPaid())%>">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="float-left" style="width: 100px;">伤亡人数：</div>
                            <div class="float-left">
                                <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
                                    <table class="table table-bordered table-striped" id="table1">
                                        <tr>
                                            <th>伤亡</th>
                                            <th>伤亡人姓名</th>
                                            <th>伤亡人损失</th>
                                        </tr>
                                    </table>
                                </div>
                                <input class="dialogs button margin-small" data-toggle="click" data-target="#swrs1" data-mask="1"  data-width="40%"type="button" value="添加">
                                <br>
                                <input type="button" class="button margin-small" onclick="delete1()" value="删除">
                            </div>
                        </div>


                    </blockquote>
                </div>
                <!--乙方-->
                <div class="line">
                    <blockquote>
                        <strong>乙方损失</strong>
                        <div class="line">
                            <div class="float-left">车辆损失：</div>
                            <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
                                <table class="table table-bordered table-striped" id="table2">
                                    <tr>
                                        <th>车牌号</th>
                                        <th>车型</th>
                                        <th>损失</th>
                                    </tr>
                                </table>
                            </div>


                            <input class="dialogs button margin-small" data-toggle="click" data-target="#clss" data-mask="1" data-width="40%" type="button" value="添加">
                            <br>
                            <input type="button" class="button margin-small" onclick="delete2()" value="删除">
                        </div>
                        <div class="line">
                            <div class="float-left">伤亡人数：</div>
                            <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
                                <table class="table table-bordered table-striped" id="table3">
                                    <tr>
                                        <th>伤亡</th>
                                        <th>伤亡人姓名</th>
                                        <th>伤亡人损失</th>
                                    </tr>
                                </table>

                            </div>

                            <input class="dialogs button margin-small" data-toggle="click" data-target="#swrs3" data-mask="1" data-width="40%" type="button" value="添加">
                            <br>
                            <input type="button" class="button margin-small" onclick="delete3()" value="删除">

                        </div>
                        <div class="line">
                            <div class="form-group">
                                <div class="label">
                                    <label>财产损失：</label>
                                </div>
                                <div class="field">
                                    <input class="input input-auto lossType" size="40" name="loss.peopleLoss" id="peopleLoss" onblur="addLoss();" value="<%=accident==null?0:(accident.getPeopleLoss()==null?0:accident.getPeopleLoss())%>">
                                </div>

                            </div>
                        </div>
                    </blockquote>
                </div>
                <!--总损失-->
                <div class="line">
                    <div class="form-group">
                        <div class="label">
                            <label>
                                总损失：
                            </label>
                        </div>
                        <div class="field">
                            <input class="input input-auto margin-small" size="40" id="allLoss">
                        </div>
                    </div>
                    <input type="button" class="button button-big bg-green" value="提交" onclick="dosubmit()"/>

                </div>
            </div>
        </div>
</div>


</form>

<!--对话框-->
<div id="clss">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close"></span>
            <strong>录入车辆损失信息</strong>
        </div>
        <div class="dialog-body">
            <div>车牌号</div>
            <div><input class="input cph"/></div>
            <div>车型</div>
            <div><input class="input cx"/></div>
            <div>损失</div>
            <div><input class="input ss"/></div>
        </div>
        <div class="dialog-foot">
            <button class="button bg-green" onclick="add2()">添加</button>
            <button class="button dialog-close">取消</button>
        </div>
    </div>
</div>
<div id="swrs1">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close"></span>
            <strong>录入伤亡人数信息</strong>
        </div>
        <div class="dialog-body">
            <div>伤亡</div>
            <select class="input sw">
                <option value="0">伤</option>
                <option value="1">亡</option>
            </select>
            <div>伤亡人姓名</div>
            <div><input class="input swrxm"/></div>
            <div>伤亡人损失</div>
            <div><input class="input swrss"/></div>
        </div>
        <div class="dialog-foot">
            <button class="button bg-green" onclick="add1()">添加</button>
            <button class="button dialog-close">取消</button>
        </div>
    </div>
</div>
<!--对话框-->
<div id="swrs3">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close"></span>
            <strong>录入伤亡人数信息</strong>
        </div>
        <div class="dialog-body">
            <div>伤亡</div>
            <div>
                <select class="input sw">
                    <option value="0">伤</option>
                    <option value="1">亡</option>
                </select>
            </div>
            <div>伤亡人姓名</div>
            <div><input class="input swrxm"/></div>
            <div>伤亡人损失</div>
            <div><input class="input swrss"/></div>
        </div>
        <div class="dialog-foot">
            <button class="button bg-green" onclick="add3()">添加</button>
            <button class="button dialog-close">取消</button>
        </div>
    </div>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker();
</script>
</html>
