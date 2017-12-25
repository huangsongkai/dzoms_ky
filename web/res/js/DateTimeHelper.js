//默认的class (不推荐)
$('.datetimepick').datetimepicker(
{
      lang:"ch",           //语言选择中文
      datepicker:true,
      timepicker:true,    //关闭时间选项
      format:"Y/m/d H:i"
});

//
$('.datepick').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
});

/*$('.datepick2').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
});*/
$('.datepick2').simpleCanleder();
//
$('.timepick').datetimepicker({
	lang:"ch",           //语言选择中文
	datepicker:false,
	format:'H:i'
});

$(".setTimeToday").val(function(){
	var date = new Date();
	var str = date.getFullYear()+"/" +(date.getMonth()+1)+"/"+date.getDate();
	return str;
});

$(".setTimeNow").val(function(){
	var date = new Date();
	var str = date.getFullYear()+"/" +(date.getMonth()+1)+"/"+date.getDate()+" "+date.getHours()+":"+date.getMinutes();
	return str;
});


