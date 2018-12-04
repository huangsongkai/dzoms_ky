(function(){
    var myContext = Java.type("com.dz.common.other.ScriptContext").getInstance();
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
        return [{
            "from":beginDate,
            "to":endDate,
            "rent":totalMoney/calDateSpan(beginDate,endDate)*30
        }]
    }

    function calTotal(rentlist){
        return rentlist.map(function(rent){
            var days = calDateSpan(rent["from"],rent["to"]);
            return rent["rent"]/30.0*days;
        }).reduce(function(a,b){
            return a+b;
        })
    }

    myContext.registService("average_template_service",'1.0.0',{
        calDaysOfDate:calDaysOfDate,
        calDateSpan:calDateSpan,
        calTotal:calTotal,
        average_template:average
    });
})();
