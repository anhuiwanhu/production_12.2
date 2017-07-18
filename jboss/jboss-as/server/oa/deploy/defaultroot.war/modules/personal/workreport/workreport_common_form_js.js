

/** 新增页 [BEGIN] */

// 
function changeReportType(option){
    var reportType = option.value;
    if(reportType == 'week' || reportType == 'month' || reportType == 'other'){
    
        var vUrl = whirRootPath + '/WorkReportAction!addWorkReport.action';
        vUrl += '?reportType=' + reportType;
        vUrl += '&isFromDesktop=1';
        
        //openWin({url:vUrl, width:810, height:640, winName:'addWorkReport'});
        location_href(vUrl);
    }
}

// 初始化“工作日志汇总”部分的展示--基础部分
function initAddForm(){
    var reportType = $('#reportType').val();
    if(reportType == '1' || reportType == '8'){
        if(initMyLogCollect()){
            // 
            if($('#reportPeriodJson').val()!=''){
                //alert($('#reportPeriodJson').val());
                var reportPeriodJson = eval("("+$('#reportPeriodJson').val()+")");
                _changeReportPeriodOfWeekReport(reportPeriodJson);
            }
            return true;
        }
    } else if (reportType == '3') {
        if(initMyWeekReportCollect()){
            if($('#reportPeriodJson').val()!=''){
                //alert($('#reportPeriodJson').val());
                var reportPeriodJson = eval("("+$('#reportPeriodJson').val()+")");
                if(_changeReportPeriodOfMonthReport(reportPeriodJson)){
                    //loadMyWeekReportCollect($('#logTag1'));
                    $('#logTag0').click();
                };
            }
            return true;
        }
    } else {
        return true;
    }
    return false;
}

function initMyWeekReportCollect(){
    // 绑定“周工作汇报汇总”部分页签的点击事件
    $('#whir_tab_ul li').bind('click', function(){
        loadMyWeekReportCollect(this);
        
        var _self = $(this);
        if(_self.attr("class") == "tag_aon")return;

        $('#whir_tab_ul li').each(function(){
            var _this = $(this);
            _this.removeAttr("class");
        });
        _self.attr("class", "tag_aon");
    });
    return true;
}

// 加载周报汇总的内容
function loadMyWeekReportCollect(obj){
    //alert($(obj).find('a').attr('reportCourse'));
    var reportCourse = $(obj).find('a').attr('reportCourse');
    //alert("reportCourse=[" + reportCourse + "]");
    if(reportCourse != undefined && reportCourse != ''){
        var vUrl = whirRootPath + "/WorkReportAction!loadMyWeekReportCollect.action";
        vUrl += "?reportCourse=" + reportCourse;
        
        //$.dialog.tips('正在加载周报汇总的内容...',1000,'loading.gif',function(){}); 
        jQuery.ajax({
            type : "POST",
            url  : vUrl,
            data : '&date='+Math.random(),
            success: function(responseText){
                //alert("responseText=[" + responseText + "]");
                //$.dialog({id:"Tips"}).close();
                
                $('#tab0').html(responseText);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                $.dialog.tips(comm.delremind8,1,'face-sad.png',function(){}); 
            }
        });
    }
}


function initMyLogCollect(){
    // 绑定“工作日志汇总”部分页签的点击事件
    $('#whir_tab_ul li').bind('click', function(event){
        var _self = $(this);
        if(_self.attr("class") == "tag_aon")return;

        var _currentTarget = event.currentTarget;
        var options = _self.attr("whir-options");
        $('#whir_tab_ul li').each(function(){
            var _this = $(this);
            _this.removeAttr("class");

            //隐藏其他tab
            if(_currentTarget !== this){
                var options = _this.attr("whir-options");
                var _json = (new Function('return ' + options))();
                $("#"+_json.target).css("display", "none");
            }
        });
        _self.attr("class", "tag_aon");

        //显示tab
        var _json = (new Function('return ' + options))();
        $("#"+_json.target).css("display", "");
    });
    return true;
}

/** 新增页 [END] */


/** 修改页 [BEGIN] */
function initModiForm(){
    // 选中“模板”的项
    var templateIdOld = $('#templateIdOld').val()==""?"0":$('#templateIdOld').val();
    //alert("templateIdOld=[" + templateIdOld + "]");
    whirCombobox.setValue('templateId', templateIdOld);
    
    // 选中“汇报类型”的项
    var reportTypeTmp = $('#reportTypeTmp').val()==""?"0":$('#reportTypeTmp').val();
    //alert("reportTypeTmp=[" + reportTypeTmp + "]");
    
    if(reportTypeTmp == '1' || reportTypeTmp == '8'){
        if(initMyLogCollect()){
            // 
            if($('#reportPeriodJson').val()!=''){
                //alert($('#reportPeriodJson').val());
                var reportPeriodJson = eval("("+$('#reportPeriodJson').val()+")");
                _changeReportPeriodOfWeekReport(reportPeriodJson);
            }
            return true;
        }
    } else if (reportTypeTmp == '3') {
        if(initMyWeekReportCollect()){
            if($('#reportPeriodJson').val()!=''){
                //alert($('#reportPeriodJson').val());
                var reportPeriodJson = eval("("+$('#reportPeriodJson').val()+")");
                if(_changeReportPeriodOfMonthReport(reportPeriodJson)){
                    //loadMyWeekReportCollect($('#logTag1'));
                    $('#logTag0').click();
                };
            }
            return true;
        }
    } else {
        whirCombobox.setValue('reportType', reportTypeTmp);
        return true;
    }
    
    return false;
}
/** 修改页 [END] */


/** 新增/修改页 [BEGIN] */

// 加载汇报模板的内容
function loadReportTemplateData(option){
    if(option.value == '0'){
		setWebeditorHTML(ewebeditorIFrame, "");
        // 不使用模板
        // alert("不使用模板");
    }else{
        // 使用模板
        var vUrl = whirRootPath + "/WorkReportTemplateAction!loadReportTemplateData.action";
        vUrl += "?workReportTemplateId=" + option.value;
        //$.dialog.tips('正在加载汇报模板的内容...',1000,'loading.gif',function(){}); 
        jQuery.ajax({
            type : "POST",
            url  : vUrl,
            data : '&date='+Math.random(),
            success: function(responseText){
                //alert("responseText=[" + responseText + "]");
                //$.dialog({id:"Tips"}).close();
                
                setWebeditorHTML(ewebeditorIFrame, responseText);
                /* var msg_json = eval("("+responseText+")");
                if(msg_json.result == "success"){
                    //$.dialog.tips('加载汇报模板的内容成功！',1,'success.gif',function(){
                        var json = eval("("+responseText+")").data;
                        //alert("json=[" + json + "]");
                        //alert("json.content=[" + json.content + "]")
                        
                        // 调用公共方法，对HTML编辑器赋值
                        setWebeditorHTML(ewebeditorIFrame, json.content);
                    //});
                }else{
                    $.dialog.alert('加载汇报模板的内容失败！',function(){}); 
                }  */
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                $.dialog.tips(comm.delremind8,1,'face-sad.png',function(){}); 
            }
        });
    }
}

// 
function initFormPara(){
    // 调用公共方法，获取HTML编辑器的内容，赋值给对应的隐藏域
    $("#previousReport").val(getWebeditorHTML(ewebeditorIFrame));
    return true;
}

// 提交表单前的验证
function checkForm(){
    // 
    if(initFormPara()){
        if(checkWebeditorContentIsEmpty(ewebeditorIFrame, 'ewebeditorIFrame', Personalwork.workreport_reportcontent)){
            return true;
        }
    }
    return false;
}

// 
function controlSubmitButton(flag){
    $(".Table_nobttomline").find("input[type='button']").prop("disabled",flag);
    //$('#sendClose').attr("disabled", flag);
    //$('#sendContinue').attr("disabled", flag);
    //$('#saveDraft').attr("disabled", flag);
}



/**
 * 新增或修改页面点击保存退出或保存继续按钮触发的事件.
 * @param n   0:保存退出；1:保存继续；2:保存草稿；3:自动保存
 * @param obj 保存按钮的dom对象.
 */
function saveReport(n, obj){ 
    if(checkForm()){
        // 
        controlSubmitButton(true);
        
        if(n == 3){
            // 自动保存
            $('#sendType').val(0);
            initDataFormToAjax({"dataForm":'dataForm', "queryForm":'queryForm', "tip":Personalwork.autoSave, "reset":'no', "successtip":false, "tip_lock":false, "callbackfunction":returnUpdate});
        } else {
            initDataFormToAjax({"dataForm":'dataForm', "queryForm":'queryForm', "tip":Personalwork.save});
            if(n == 2){
                // 
                $('#sendType').val(0);
            } else {
                // 
                $('#sendType').val(1);
            }
        }
        
        var sendType = $('#sendType').val();
        if(sendType == '0'){
            // 草稿
            submitReport(n, obj);
        } else {
            // 发送
            var formReportPeriodBegin = $('#formReportPeriodBegin').val();
            var formReportPeriodEnd = $('#formReportPeriodEnd').val();
            
            var formReportPeriodBeginOld = $('#formReportPeriodBeginOld').val();
            var formReportPeriodEndOld = $('#formReportPeriodEndOld').val();
            
            var sendTypeOld = $('#sendTypeOld').val();
            
            if(sendTypeOld == '1' && formReportPeriodBegin == formReportPeriodBeginOld){
                // 已发送的汇报，不改变汇报区间，无需判断已提交几份汇报
                //alert("111");
                submitReport(n, obj);
            } else {
                //alert("222");
                var reportType = $('#reportType').val();
                var workReportId = $('#workReportId').val();
                //alert('workReportId=[' + workReportId + ']');
                //alert('reportType=[' + reportType + ']');
                var vUrl = whirRootPath + "/WorkReportAction!hasSameReportCourseRecords.action";
                vUrl += "?reportType=" + reportType;
                vUrl += "&workReportId=" + workReportId;
                vUrl += "&formReportPeriodBegin=" + formReportPeriodBegin;
                vUrl += "&formReportPeriodEnd=" + formReportPeriodEnd;
                //$.dialog.tips('正在判断汇报区间的记录数...',1000,'loading.gif',function(){}); 
                jQuery.ajax({
                    type : "POST",
                    url  : vUrl,
                    data : '&date='+Math.random(),
                    success: function(responseText){
                        //$.dialog({id:"Tips"}).close();
                        var msg_json = eval("("+responseText+")");
                        if(msg_json.result == "success"){
                            var json = eval("("+responseText+")").data;
                            //alert("json.recordCount=[" + json.recordCount + "]");
                            if(json.recordCount == '0'){
                                $('#formReportCourseFlag').val('');
                                submitReport(n,obj);
                            }else{
                                var content = Personalwork.workreport_alertReportCourseRepeatPart1+json.recordCount+Personalwork.workreport_alertReportCourseRepeatPart2;
                                $('#formReportCourseFlag').val(json.newReportCourseFlag);
                                $.dialog.confirm(content, 
									function(){ 
										submitReport(n,obj);
									}, 
									function(){ 
										controlSubmitButton(false);
									}
								); 
                            }
                        }else{
                            $.dialog.alert('判断是否能提交汇报区间失败！',function(){}); 
                        } 
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        $.dialog.tips('判断是否能提交汇报区间失败！',1,'face-sad.png',function(){}); 
                    }
                });
            }
        }
    }
}

function submitReport(n,obj){
    var formId = $(obj).parents("form").attr("id");
    var validation = validateForm(formId);
    //$(obj).parents("form").find("#saveType").val(n!=0?1:n);
    $(obj).parents("form").find("#saveType").val(n%2);
    if(validation){
		//alert($('body input:focus').attr('id'));
		controlSubmitButton(false);
        $('#'+formId).submit();
    } else {
		controlSubmitButton(false);
	}
}

// 实时保存 - 新增
function realTimeSave_add(){
	//alert('In realTimeSave_add()');
	//alert($('body input:focus').attr('id'));
    if(checkForm()){
        initDataFormToAjax({"dataForm":'dataForm', "queryForm":'queryForm', "tip":Personalwork.autoSave, "reset":'no', "successtip":false, "tip_lock":false, "callbackfunction":returnSave}); 
        
        // 发送状态：草稿
        $('#sendType').val(0);
        
        ok(1, $('#saveDraft'));
    }
}

// 新增时，第一次"自动保存"后，跳转到修改页面
function returnSave(json){ 
	$('#id').val(json.data.workReportId);
	$('#workReportId').val(json.data.workReportId);
	$('#verifyCode').val(json.data.verifyCode);
	$('#dataForm').attr("action", whirRootPath + '/WorkReportAction!updateWorkReport.action');
	
    window.clearInterval(vRealTimeSave_add);
	
    window.setInterval(realTimeSave_modi, 60000);
	
	focusInWebeditor();
	
	/*
    var vUrl = whirRootPath + '/WorkReportAction!modiWorkReport.action?workReportId=' + json.data.workReportId;
    vUrl += '&verifyCode=' + json.data.verifyCode;
    //alert('vUrl=[' + vUrl + ']');
    location_href(vUrl);
	*/
}

// 实时保存 - 修改
function realTimeSave_modi(){
	//alert('In realTimeSave_modi()');
    saveReport(3, $('#sendClose'));
}

function returnUpdate(){
	focusInWebeditor();
}

function focusInWebeditor(){
	if($.browser.mozilla){
		ewebeditorIFrame.contentWindow.EWEB.Focus();
	}else{
		ewebeditorIFrame.EWEB.Focus();
	}
}

function changeReportPeriod(offset){
    var reportType = $('#reportType').val();
    if(reportType == '' || reportType == undefined){
        //whir_tips("获取汇报区间参考值失败，不可改变汇报区间。", 2, "", null);
    }else{
        if(reportType == '1' || reportType == '8'){
            // 周报
            changeReportPeriodOfWeekReport(offset);
        }else if(reportType == '3'){
            // 月报
            changeReportPeriodOfMonthReport(offset);
        }
    }
}

function changeReportPeriodOfWeekReport(offset){
    var referDate = $('#formReportPeriodEnd').val();
    var referWeek = $('#formReportPeriodReferWeek').val();
    if(referDate == '' || referWeek == ''){
        //whir_tips("获取汇报区间参考值失败，不可改变汇报区间。", 2, "", null);
    }else{
        var vUrl = whirRootPath + "/WorkReportAction!changeReportPeriodOfWeekReport.action";
        vUrl += "?referDate=" + referDate;
        vUrl += "&referWeek=" + referWeek;
        vUrl += "&offset=" + offset;
        //$.dialog.tips('正在改变汇报区间...',1000,'loading.gif',function(){}); 
        jQuery.ajax({
            type : "POST",
            url  : vUrl,
            data : '&date='+Math.random(),
            success: function(responseText){
                //alert("msg=[" + msg + "]");
                //$.dialog({id:"Tips"}).close();
                //alert(responseText);
                var msg_json = eval("("+responseText+")");
                if(msg_json.result == "success"){
                    //$.dialog.tips('加载汇报区间成功！',1,'success.gif',function(){
                        var json = eval("("+responseText+")").data;
                        _changeReportPeriodOfWeekReport(json);
                    //});
                }else{
                    $.dialog.alert('加载汇报区间失败！',function(){}); 
                } 
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                $.dialog.tips(comm.delremind8,1,'face-sad.png',function(){}); 
            }
        });
    }
}

function _changeReportPeriodOfWeekReport(json){
    // "汇报区间"部分
    $('#formReportPeriodReferWeek').val(json.referWeek);
    $('#formReportPeriodBegin').val(json.Mon.logDate);
    $('#formReportPeriodEnd').val(json.Sun.logDate);
    
    // "周工作日志汇总"部分
    $('#logDate0').html(json.Mon.logDateShow);
    $('#logContent00').html(json.Mon.logContent0);
    $('#logContent01').html(json.Mon.logContent1);
    
    $('#logDate1').html(json.Tues.logDateShow);
    $('#logContent10').html(json.Tues.logContent0);
    $('#logContent11').html(json.Tues.logContent1);
    
    $('#logDate2').html(json.Wed.logDateShow);
    $('#logContent20').html(json.Wed.logContent0);
    $('#logContent21').html(json.Wed.logContent1);
    
    $('#logDate3').html(json.Thurs.logDateShow);
    $('#logContent30').html(json.Thurs.logContent0);
    $('#logContent31').html(json.Thurs.logContent1);
    
    $('#logDate4').html(json.Fri.logDateShow);
    $('#logContent40').html(json.Fri.logContent0);
    $('#logContent41').html(json.Fri.logContent1);
    
    $('#logDate5').html(json.Sat.logDateShow);
    $('#logContent50').html(json.Sat.logContent0);
    $('#logContent51').html(json.Sat.logContent1);
    
    $('#logDate6').html(json.Sun.logDateShow);
    $('#logContent60').html(json.Sun.logContent0);
    $('#logContent61').html(json.Sun.logContent1);
}

function changeReportPeriodOfMonthReport(offset){
    var referDate = $('#formReportPeriodBegin').val();
    if(referDate == '' ){
        //whir_tips("获取汇报区间参考值失败，不可改变汇报区间。", 2, "", null);
    }else{
        var vUrl = whirRootPath + "/WorkReportAction!changeReportPeriodOfMonthReport.action";
        vUrl += "?referDate=" + referDate;
        vUrl += "&offset=" + offset;
        //$.dialog.tips('正在改变汇报区间...',1000,'loading.gif',function(){}); 
        jQuery.ajax({
            type : "POST",
            url  : vUrl,
            data : '&date='+Math.random(),
            success: function(responseText){
                //alert("msg=[" + msg + "]");
                //$.dialog({id:"Tips"}).close();
                var msg_json = eval("("+responseText+")");
                if(msg_json.result == "success"){
                    //$.dialog.tips('加载汇报区间成功！',1,'success.gif',function(){
                        var json = eval("("+responseText+")").data;
                        if(_changeReportPeriodOfMonthReport(json)){
                            //loadMyWeekReportCollect($('#logTag1'));
                            $('#logTag0').click();
                        };
                    //});
                }else{
                    $.dialog.alert('加载汇报区间失败！',function(){}); 
                } 
            },
            error: function(XMLHttpRequest, textStatus, errorThrown){
                $.dialog.tips(comm.delremind8,1,'face-sad.png',function(){}); 
            }
        });
    }
}

function _changeReportPeriodOfMonthReport(json){

    for (var i=0; i<6; i++) {
        $('#li_log'+i).show();
    }
    
    // "汇报区间"部分
    //$('#formReportPeriodReferMonth').val(json.referMonth);
    $('#formReportPeriodBegin').val(json.beginDate);
    $('#formReportPeriodEnd').val(json.endDate);
    
    //循环数据信息
    var data = json.data;
    //alert(data.length);
    var dataLen = data.length;
    //alert(dataLen);
    for (var i=0; i<dataLen; i++) {
        var weeksData = data[i];    
        //alert(weeksData.logTagShow);
        $('#logTag'+i).html(weeksData.logTagShow);
        $('#logTag'+i).attr('reportCourse', weeksData.logTagReportCourse);
        //$('#logContent'+i+'0').html(weeksData.logContent0);
        //$('#logContent'+i+'1').html(weeksData.logContent1);
    }
    
    // 隐藏多余的标签
    for (var i=dataLen; i<6; i++) {
        $('#li_log'+i).hide();
    }
    
    return true;
}
/** 新增/修改页 [END] */
