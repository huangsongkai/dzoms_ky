function getJsonList(path, selectArray) {
	$.getJSON(path, null, function(obj) {

		for (var j = 0; j < selectArray.length; j++) {
			var selectName = selectArray[j];
			var values = obj[selectName];

			if (values instanceof Array) {
				for (var i = 0; i < values.length; i++) {
					$("select[name='" + selectName + "']").append("<option>" + values[i] + "</option>");
				}
			} else {
				for (var key in values) {
					$("select[name='" + selectName + "']").append('<option value="' + key + '">' + values[key] + "</option>");
				}
			}
		}

	});
}

function getObject(fn, name, id, isString) {
	if (isString == undefined)
		$.post('/DZOMS/common/getObject.action', {
			"className": name,
			"id": id
		}, function(data) {
			var obj = data; //$.parseJSON(data);
			fn(obj);
		});
	else
		$.post('/DZOMS/common/getObject.action', {
			"className": name,
			"id": id,
			"isString": isString
		}, function(data) {
			var obj = data; //$.parseJSON(data);
			fn(obj);
		});
}

function dateToString(fmt, dateObject) {
	if (dateObject == null) {
		return "-";
	}

	var date = new Date();
	date.setTime(dateObject["time"]);

	var o = {
		"M+": date.getMonth() + 1, //月份   
		"d+": date.getDate(), //日   
		"h+": date.getHours(), //小时   
		"m+": date.getMinutes(), //分   
		"s+": date.getSeconds(), //秒   
		"q+": Math.floor((date.getMonth() + 3) / 3), //季度   
		"S": date.getMilliseconds() //毫秒   
	};

	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

function getMonthAndDay(startdate, enddate) {  
    var month = 0;  
    var day = 0;  
    if (enddate.getDate() >= startdate.getDate()) {  
        month = (enddate.getFullYear() - startdate.getFullYear()) * 12  
                + enddate.getMonth() - startdate.getMonth();  
        day = enddate.getDate() - startdate.getDate();  
    } else {  
        if (startdate.getDate() == getlastDay(startdate)) {  
            if (enddate.getDate() == getlastDay(enddate)) {  
                month = enddate.getFullYear() - startdate.getFullYear() * 12  
                        + enddate.getMonth() - startdate.getMonth();  
                day = 0;  
            } else {  
                month = enddate.getFullYear() - startdate.getFullYear() * 12  
                        + enddate.getMonth() - startdate.getMonth() - 1;  
                day = startdate.getDate();  
  
            }  
        } else {  
            if (enddate.getDate() == getlastDay(enddate)) {  
                month = enddate.getFullYear() - startdate.getFullYear() * 12  
                        + enddate.getMonth() - startdate.getMonth();  
                day = 0;  
            } else {  
                month = enddate.getFullYear() - startdate.getFullYear() * 12  
                        + enddate.getMonth() - startdate.getMonth() - 1;  
  
                var lastmonthday = getlastmonthDat(enddate);  
                day = lastmonthday - startdate.getDate() + enddate.getDate();  
  
            }  
        }  
    }  
    return {  
        "mounth" : month,  
        "day" : day  
    };  
}  
  
/** 
 * 得到上一个月有多少天 
 */  
function getlastmonthDat(date) {  
    date.setDate(1);  
    date.setDate(date.getDate() - 1);  
    return date.getDate();  
}  
/** 
 * 得到date 所在的月有多少天 
 *  
 * @param date 
 */  
function getlastDay(date) {  
    date.setMonth(date.getMonth() + 1);  
    date.setDate(1);  
    date.setDate(date.getDate() - 1);  
    return date.getDate();  
}   