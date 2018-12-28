
(function(){
    var myContext = Java.type("com.dz.common.other.ScriptContext").getInstance();

    var ContractPlanItem = Java.type("com.dz.module.contract.ContractPlanItem");

    function calDaysOfDate(date){
        var dt = date.getDate();
        if(dt>26){
            return dt - 26;
        }else {
            return dt + 4;
        }
    }
    function calDateSpan(beginDate,endDate){
        var monthDiff = (endDate.getYear() - beginDate.getYear())*12 + endDate.getMonth()-beginDate.getMonth();
        return monthDiff*30 + calDaysOfDate(endDate)-calDaysOfDate(beginDate);
    }
    function average(beginDate,endDate,totalMoney){
        return Java.to([
                new ContractPlanItem(beginDate,endDate,totalMoney/calDateSpan(beginDate,endDate)*30)
            ],
            "java.util.List");
    }

    function calTotal(rentlist){
        //print(rentlist);
        //print(__FILE__, __LINE__, __DIR__);
        return Java.from(rentlist).map(function(rent){
            var days = calDateSpan(rent.from,rent.to);
            return rent.rent/30.0*days;
        }).reduce(function(a,b){
            return a+b;
        })
    }

    function warp(obj){
        var ScriptUtils = Java.type("jdk.nashorn.api.scripting.ScriptUtils");
        return ScriptUtils.wrap(obj);
    }

    myContext.registService("calDaysOfDate",'1.0.0',warp(calDaysOfDate));
    myContext.registService("calDateSpan",'1.0.0',warp(calDateSpan));
    myContext.registService("calTotal",'1.0.0',warp(calTotal));
    myContext.registService("average_template",'1.0.0',warp(average));

})();
