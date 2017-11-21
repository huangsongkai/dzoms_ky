<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 2017/7/14
  Time: 下午5:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>统计</title>
    <style type="text/css">
        .container,#main{
            width: 100%;
            background-color:#fff;
            margin: 0 auto;
        }
        #main{
            min-height: 500px;
            overflow: hidden;
        }
        #main1-1{
            width: 800px;
            height:700px;
            margin:0 auto;
        }
        .statistics{
            width:580px;
            height:400px;
            float:left;
            margin:20px 2px;
            border: 1px solid #ddd;
        }

    </style>
    <!-- 引入 echarts.js -->
    <script src="/DZOMS/ky/js/jquery-2.2.1.min.js"></script>
    <script src="/DZOMS/ky/js/echarts-all.js"></script>
</head>
<body>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div class="container">
    <div id="main1-1"></div>
    <div id="main">
        <div id="main1-2" class="statistics" ></div>
        <div id="main1-3" class="statistics" ></div>
        <div id="main1-4" class="statistics" ></div>
        <div id="main1-5" class="statistics" ></div>
        <div id="main2-1" class="statistics" ></div>
        <div id="main2-2" class="statistics" ></div>
        <div id="main3-1" class="statistics" ></div>
        <div id="main3-2" class="statistics" ></div>
        <div id="main4-1" class="statistics" ></div>
        <div id="main5-1" class="statistics" ></div>
        <div id="main6-1" class="statistics" ></div>
    </div>
</div>


<script type="text/javascript">
    stat_driver_location_distribution(document.getElementById('main1-1'));
    stat_driver_age_distribution(document.getElementById('main1-2'));
    stat_driver_status_distribution(document.getElementById('main1-3'));
    stat_driver_month_distribution(document.getElementById('main1-4'));
    stat_driver_count_branch_pie(document.getElementById('main1-5'))
    stat_contract_month_distribution(document.getElementById('main2-1'));
    stat_contract_month_distribution_branch(document.getElementById('main2-2'));
    stat_vehicle_status_distribution_pie(document.getElementById('main3-1'));
    stat_vehicle_month_distribution(document.getElementById('main3-2'));
    stat_meeting_month_distribution(document.getElementById('main4-1'));
    stat_electric_month_distribution(document.getElementById('main5-1'));
    stat_finance_month_distribution(document.getElementById('main6-1'));
    // stat_vehicle_status_distribution_bar(document.getElementById('main4'));
    // 地图

    function stat_driver_location_distribution(dom){
        $.get("/DZOMS/ky/statistics/driver/locationDistribution").done(function (data) {
            // var worldMapContainer = document.getElementById('main1-1');
            // var resizeWorldMapContainer = function () {
            //     worldMapContainer.style.width = window.innerWidth+'px';
            //     worldMapContainer.style.height = window.innerWidth+'px';
            // };
            // //设置容器高宽
            // resizeWorldMapContainer();
            // // 基于准备好的dom，初始化echarts实例
            // var myChart = echarts.init(worldMapContainer);
            var option = {
                title : {
                    text: '驾驶员地域分布',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    x:'left',
                    data:['驾驶员']
                },
                dataRange: {
                    min: 0,
                    max: 2500,
                    x: 'left',
                    y: 'bottom',
                    text:['高','低'],           // 文本，默认为数值文本
                    calculable : true
                },
                toolbox: {
                    show: true,
                    orient : 'vertical',
                    x: 'right',
                    y: 'center',
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                roamController: {
                    show: true,
                    x: 'right',
                    mapTypeControl: {
                        'china': true
                    }
                },
                series : [
                    {
                        name: '驾驶员',
                        type: 'map',
                        mapType: 'china',
                        roam: false,
                        itemStyle:{
                            normal:{label:{show:true}},
                            emphasis:{label:{show:true}}
                        },
                    },
                ]
            };
            option.series[0].data = data.data;
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);

            // window.onresize = function () {
            //     //重置容器高宽
            //     resizeWorldMapContainer();
            //     myChart.resize();
            // };
        })
    }

    function stat_driver_age_distribution(dom){
        $.get("/DZOMS/ky/statistics/driver/ageDistribution").done(function (data) {
            var option = {
                title : {
                    text: '驾驶员年龄人数分布',
                },
                tooltip : {
                    trigger: 'axis'
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 人'
                        }
                    }
                ],
                series : [
                    {
                        name:'人数',
                        type:'line',
                        markPoint : {
                            data : [
                                {type : 'max', name: '最大值'},
                                {type : 'min', name: '最小值'}
                            ]
                        },
                    },
                ]
            };
            option.xAxis[0].data = data.data.map(function(i){
                return i[0]+'岁'
            });
            option.series[0].data = data.data.map(function(i){
                return i[1]
            });
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }

    function stat_driver_status_distribution(dom){
        $.get("/DZOMS/ky/statistics/driver/statusDistribution").done(function (data) {
            var option = {
                title : {
                    text: '驾驶员在岗状态分布',
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    y : 'bottom',
                    x : 'center',
                    data:['在职', '离职']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel']
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : false,
                series : [
                    {
                        name:'驾驶员状态',
                        type:'pie',
                        selectedMode: 'single',
                        radius : [0, 70],

                        // for funnel
                        x: '20%',
                        width: '40%',
                        funnelAlign: 'right',
                        // max: 1548,

                        itemStyle : {
                            normal : {
                                label : {
                                    position : 'inner'
                                },
                                labelLine : {
                                    show : false
                                }
                            }
                        },
                        data:[
                            data.data[1],
                            data.data[0],
                        ]
                    },
                    {
                        name:'驾驶员状态',
                        type:'pie',
                        radius : [100, 140],

                        // for funnel
                        x: '60%',
                        width: '35%',
                        funnelAlign: 'left',
                        // max: 1048,

                        data:[
                            data.data[1],
                            data.data[2],
                            data.data[3],
                        ]
                    }
                ]
            };
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        })
    }

    function stat_driver_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/driver/monthsNewEmployee").done(function (data) {
            var option = {
                title : {
                    text: '驾驶员入职情况全年统计',
                },
                tooltip : {
                    trigger: 'axis'
                },

                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['新入职驾驶员']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }
    function stat_driver_count_branch_pie(dom=document.getElementById("stat_driver_count_branch_pie")){
        $.get("/DZOMS/ky/statistics/driver/countByBranch").done(function (data) {
            var option = {
                title : {
                    text: '驾驶员分部统计',
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:data.data.map(function(item){return item.name})
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel']
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                series : [
                    {
                        name:'人数',
                        type:'pie',
                        radius : [30, 110],
                        center : ['50%', 200],
                        roseType : 'area',
                        // x: '50%',               // for funnel
                        max: 40,                // for funnel
                        sort : 'descending',     // for funnel
                        // for funnel
                        // width: '35%',
                        funnelAlign: 'left',
                        // max: 1048,

                        data:data.data
                    }
                ]
            };
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        })
    }


    function stat_vehicle_status_distribution_pie(dom=document.getElementById("stat_vehicle_status_distribution_pie")){
        $.get("/DZOMS/ky/statistics/vehicle/statusDistribution").done(function (data) {
            var option = {
                title : {
                    text: '车辆运营状态分布',
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    // data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他']
                    data:data.data.map(function(item){return item.name})
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel']
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                series : [
                    {
                        name:'车辆状态',
                        type:'pie',
                        radius : [30, 110],
                        center : ['50%', 200],
                        roseType : 'area',
                        // x: '50%',               // for funnel
                        max: 40,                // for funnel
                        sort : 'descending',     // for funnel
                        // for funnel
                        // width: '35%',
                        funnelAlign: 'left',
                        // max: 1048,

                        data:data.data
                    }
                ]
            };
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        })
    }
    function stat_vehicle_status_distribution_bar(dom){
        $.get("/DZOMS/ky/statistics/vehicle/statusDistribution").done(function (data) {
            var option = {
                title : {
                    text: '车辆运营状态分布',
                },
                tooltip : {
                    trigger: 'axis'
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 辆'
                        }
                    }
                ],
                series : [
                    {
                        name:'人数',
                        type:'bar',
                        markPoint : {
                            data : [
                                {type : 'max', name: '最大值'},
                                {type : 'min', name: '最小值'}
                            ]
                        },
                    },
                ]
            };
            option.xAxis[0].data = data.data.map(function(i){
                return i.name
            });
            option.series[0].data = data.data.map(function(i){
                return i.value
            });
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }

    function stat_vehicle_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/vehicle/wholeYear").done(function (data) {
            var option = {
                title : {
                    text: '车辆情况统计',
                },
                tooltip : {
                    trigger: 'axis'
                },

                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['新购车辆','开业车辆','计划废业','废业车辆']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }

    function stat_contract_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/contract/wholeYear").done(function (data) {
            var option = {
                title : {
                    text: '合同统计',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['有效合同','新增合同','终止合同','转包合同']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['有效合同','新增合同','终止合同','转包合同']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }
    function stat_contract_month_distribution_branch(dom){
        $.get("/DZOMS/ky/statistics/contract/branch").done(function (data) {
            var option = {
                title : {
                    text: '各分部发包统计',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['一部','二部','三部']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['一部','二部','三部']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }

    function stat_meeting_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/contract/branch").done(function (data) {
            var option = {
                title : {
                    text: '例会考勤统计',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['未签','签到']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['未签','签到']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }
    function stat_electric_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/electric/wholeYear").done(function (data) {
            var option = {
                title : {
                    text: '电子违章',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['一部','二部','三部']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['一部','二部','三部']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }
    function stat_finance_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/finance/wholeYear").done(function (data) {
            var option = {
                title : {
                    text: '财务统计',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['计划金额','实收金额']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['计划金额','实收金额']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }


    function stat_finance_month_distribution(dom){
        $.get("/DZOMS/ky/statistics/finance/wholeYear").done(function (data) {
            var option = {
                title : {
                    text: '事故统计',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:['计划金额','实收金额']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value} 个'
                        }
                    }
                ],
                series : [
                ]
            };
            option.xAxis[0].data = data.data.keys
            var names = ['事故数量','实收金额']
            for(var i = 0; i < names.length; i++){
                var s = {
                    name:names[i],
                    type:'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                };;
                s.data = data.data.counts[i];
                option.series.push(s);
            }
            var myCharts = echarts.init(dom, "macarons");
            myCharts.setOption(option);
        });
    }

</script>




</body>
</html>
