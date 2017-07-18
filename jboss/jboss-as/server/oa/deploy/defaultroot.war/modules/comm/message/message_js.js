	function selectExternalUser(json_obj) {
    	var index = 0;
	    //弹窗大小
	    var dialogWidth = 800;
	    var dialogHeight = 525;
		var whir_select_user_url = whirRootPath + "/selectExternalUser!init.action";
		var _type = json_obj.type;
		var _title = Message.selectpubliccontacts;
		if(_type == "private") {
			_title = Message.selectpersonalcontacts;
		}
	    $.dialog({
	        id: 'selectExternalUser', 
	        title: _title, 
	        parent: null,
	        lock: true, 
	        max: false,
	        min: false,
	        resize: false,
	        drag: false,
	        width: dialogWidth+'px', //'850px',
	        height: dialogHeight, //670,
	        content: "url:"+whir_select_user_url+"?type=" + json_obj.type + "&allowId=" + json_obj.allowId + "&allowName=" + json_obj.allowName + "&allowPhone=" + json_obj.allowPhone,
	        init: function(){
	            if(this.content.document.body){
	            }
	        }
	    });
    }
    
	function selectInternalUser(json_obj) {
    	var index = 0;
	    //弹窗大小
	    var dialogWidth = 800;
	    var dialogHeight = 525;
		var whir_select_user_url = whirRootPath + "/selectInternalUser!init.action";
	    $.dialog({
	        id: 'selectInternalUser', 
	        title: Message.selectinternalcontacts, 
	        parent: null,
	        lock: true, 
	        max: false,
	        min: false,
	        resize: false,
	        drag: false,
	        width: dialogWidth+'px', //'850px',
	        height: dialogHeight, //670,
	        content: "url:"+whir_select_user_url+"?type=" + json_obj.type + "&allowId=" + json_obj.allowId + "&allowName=" + json_obj.allowName + "&allowPhone=" + json_obj.allowPhone,
	        init: function(){
	            if(this.content.document.body){
	            }
	        }
	    });
    }
    
    function checkContent() {
    	var obj = $("#msContent");
    	if(eval(300-$.trim(obj.val()).length) < 0){
            $("#cdtx").html("300/300");
			var val=$.trim(obj.val()).substring(0,300);
            obj.val(val);
			layer.msg(Message.infolong);
        }else{
            $("#cdtx").html($.trim(obj.val()).length+"/300");
        }
    }
    
    function checkAppend(type, obj) {
    	var msContent = $("#msContent").val();
    	var orgName = $("#orgName").val();
    	var userName = $("#userName").val();
    	if(type == "org") {
    		if(obj.checked) {
    			if($("#hasUserName").prop("checked") == true){
					//附带个人姓名选中
					var tmpValue = msContent.substring(("来自" + userName + ":").length, msContent.length);
					$("#msContent").val("来自" + orgName + "." + userName + ":" + tmpValue);
				}else{
					$("#msContent").val("来自" + orgName + ":" + msContent);
				}
    		} else {
    			if($("#hasUserName").prop("checked") == true){
					//附带个人姓名选中
					var tmpValue = msContent.substring(("来自" + orgName + "." + userName + ":").length, msContent.length);
					$("#msContent").val("来自" + userName + ":" + tmpValue);
				}else{
					$("#msContent").val(msContent.substring(("来自" + orgName + ":").length, msContent.length));
				}
    		}
    	} else {
    		if(obj.checked) {
    			if($("#hasOrgName").prop("checked") == true){
					//附带个人姓名选中
					var tmpValue = msContent.substring(("来自" + orgName + ":").length, msContent.length);
					$("#msContent").val("来自" + orgName + "." + userName + ":" + tmpValue);
				}else{
					$("#msContent").val("来自" + userName + ":" + msContent);
				}
    		} else {
    			if($("#hasOrgName").prop("checked") == true){
					//附带个人姓名选中
					var tmpValue = msContent.substring(("来自" + orgName + "." + userName + ":").length, msContent.length);
					$("#msContent").val("来自" + orgName + ":" + tmpValue);
				}else{
					$("#msContent").val(msContent.substring(("来自" + userName + ":").length, msContent.length));
				}
    		}
    	}
    	checkContent();
    }
    
    //验证外部手机号格式
    function checkOutPhone() {
    	var receiveCode = $("#receiveCode").val();
    	if(receiveCode != "") {
    		var phone = new Array();
        	phone = receiveCode.split(",");
        	for(var i = 0; i < phone.length; i++){
            	var regExp = new RegExp(/^(\+86)?\d{11}$/); //限制数字位数
            	if(phone[i]!=null && phone[i]!=''){
					if(!regExp.test(phone[i])){
                		layer.msg(Message.outphonetips);
                		return false;
            		}
				}
        	}
    	}
    	return true;
    }
    
    //验证联系人手机号格式
    function checkLinkPhone() {
    	var snmsgtophone = $("#snmsgtophone").val();
    	var msgtophone = $("#msgtophone").val();
    	var msgprivatephone = $("#msgprivatephone").val();
    	var msgpublicphone = $("#msgpublicphone").val();
    	if(!validateMobilephone(snmsgtophone)) {
    		layer.msg(Message.simplephonetips);
    		//clearLinkMan({id:'snmsgtoid',name:'toId',phone:'snmsgtophone'});
    		//clearLinkMan({id:'snmsgto',name:'snmsgtoname',phone:''});
    		return false;
    	}
    	if(!validateMobilephone(msgtophone)) {
    		layer.msg(Message.innerphonetips);
    		//clearLinkMan({id:'msgtoid',name:'msgto',phone:'msgtophone'});
    		return false;
    	}
    	if(!validateMobilephone(msgprivatephone)) {
    		layer.msg(Message.privatephonetips);
    		//clearLinkMan({id:'msgtoidprivate',name:'msgtoprivate',phone:'msgprivatephone'});
    		return false;
    	}
    	if(!validateMobilephone(msgpublicphone)) {
    		layer.msg(Message.publicphonetips);
    		//clearLinkMan({id:'msgtoidpublic',name:'msgtopublic',phone:'msgpublicphone'});
    		return false;
    	}
    	return true;
    }
    
    function validateMobilephone(mobile) {
    	if(mobile != "") {
    		var arr = new Array();
			var vtype='mobile';
        	arr = mobile.split(",");
        	for(var i = 0; i < arr.length - 1; i++){
            	var regExp = myValidate(arr[i],vtype); 
            	if(regExp != "" && regExp != true ){
                	return false;
            	}
        	}
		}
			return true;
    	}
    
    function clearLinkMan(json_obj) {
    	if(json_obj.id != "") {
    	//alert(document.getElementById(json_obj.id));
    	//document.getElementById(json_obj.id).value = "";
    		$("#" + json_obj.id).val("");
    	}
    	if(json_obj.name != "") {
    		$("#" + json_obj.name).val("");
    	}
    	if(json_obj.phone != "") {
    		$("#" + json_obj.phone).val("");
    	}
    }
    
    function checkSendCount(msgCount, sendResult) {
    	if('c' == sendResult){
			layer.msg(Message.totalmsgcounttips,function() {window.close();},null);
        	return;
		}else if('m' == sendResult){
	    	layer.msg(Message.monthmsgcounttips,function() {window.close();},null);
        	return;
		}else if('d' == sendResult){
	    	layer.msg(Message.daymsgcounttips,function() {window.close();},null);
        	return;
		}
		
		if(msgCount !="" && msgCount=="0" ){
		    layer.msg(Message.exceed,function() {window.close();},null);
	        return;
    	}
    	if(msgCount=="1"){
    		$("#msgmobile").css("display", "");
    	}
    }
    
	function checkSaveSendCount(msgCount, sendResult1) {
		var sendResultArr=sendResult1.split(",");
		var ccount = parseInt(sendResultArr[0]);
		var count = parseInt(sendResultArr[1]);
		var mmcount = parseInt(sendResultArr[2]);
		var  mcount= parseInt(sendResultArr[3]);
		var ddcount = parseInt(sendResultArr[4]);
		var dcount = parseInt(sendResultArr[5]);
		var snmsgto=$('#snmsgto').val();
		var msgtoid=$('#msgtoid').val();
		var msgtoidprivate=$('#msgtoidprivate').val();
		var msgtoidpublic=$('#msgtoidpublic').val();
		var receiveCode=$('#receiveCode').val();

		var snmsgtoNum=0;
		var msgtoidNum=0;
		var msgtoidprivateNum=0;
		var msgtoidpublicNum=0;
		var receiveCodeNum=0;
		if(snmsgto==""){
			snmsgtoNum=0;
		}
		else{
			var nsnmsgto=snmsgto.split(",");
            snmsgtoNum=nsnmsgto.length-1;
		}
		if(msgtoid==""){
			msgtoidNum=0;
		}
		else{
			var nmsgtoid=msgtoid.split(",");
            msgtoidNum=nmsgtoid.length-1;
		}
		if(msgtoidprivate==""){
			msgtoidprivateNum=0;
		}
		else{
			var nmsgtoidprivate=msgtoidprivate.split(",");
            msgtoidprivateNum=nmsgtoidprivate.length-1;
		}
		if(msgtoidpublic==""){
			msgtoidpublicNum=0;
		}
		else{
			var nmsgtoidpublic=msgtoidpublic.split(",");
            msgtoidpublicNum=nmsgtoidpublic.length-1;
		}
		if(receiveCode==""){
			receiveCodeNum=0;
		}
		else{
			var nreceiveCode=receiveCode.split(",");
            receiveCodeNum=nreceiveCode.length-1;
		}
		var sumNum=snmsgtoNum+msgtoidNum+msgtoidprivateNum+msgtoidpublicNum+receiveCodeNum;
    	if(ccount+sumNum>count){
			layer.msg(Message.totalmsgcounttips,function() {window.close();},null);
        	return;			
		}else if(mmcount+sumNum>mcount){			
	    	layer.msg(Message.monthmsgcounttips,function() {window.close();},null);
        	return;
		}else if(ddcount+sumNum>dcount){
	    	layer.msg(Message.daymsgcounttips,function() {window.close();},null);
        	return;		
		}
		
		if(msgCount !="" && msgCount=="0" ){
		    layer.msg(Message.exceed,function() {window.close();},null);
	        return;
    	}
    	if(msgCount=="1"){
    		$("#msgmobile").css("display", "");
    	}
		return true;
    }
	function checkForm(saveFlag) {
		if ($("#msgto").val() == "" &&  //内部联系人
			$("#msgtoprivate").val() == "" && //个人联系人
			$("#msgtopublic").val() == "" && //公共联系人
			$("#receiveCode").val() == "" && //外部号码
			($("#toId").val() == "" || $("#toId").val() == "请输入用户简码")&&$("#waitAdd option").size()==0) { //简码
			layer.msg(Message.selectsender);
          	return false;
    	}
		
		if(document.getElementById("msContent").value==''||document.getElementById("msContent").value==null||$.trim($("#msContent").val())=='') {
			layer.msg("内容不能为空！");
          	return false;
		}
		//$("msContent").val($.trim($("msContent").val())); 
    	if(document.getElementById("toId").value=='请输入用户简码') document.getElementById("toId").value='';
    	if(!checkSimpleName(document.getElementById("toId"))) {
    		return false;
    	}
    	addInnerFromSimp();
    	if(!checkLinkPhone() || !checkOutPhone()) {
    		return false;
    	}
    	$("#saveFlag").val(saveFlag);
    	return true;
	}
	
	function initData() {
		document.getElementById("toId").value="请输入用户简码";
	   	$("#toId").focus(function(){
	   		if(this.value=='请输入用户简码') {
		     	this.value=''; 
		   	}
		   	this.style.color='';
		});
	   	$("#toId").addClass("inputText");
	   	$("#toId").css({ color:"#CCCCCC",width: "94%"}); 
	   	
    }
    
    function checkSimpleName(obj){
		var checkValue=obj.value;
		if(checkValue.charAt(checkValue.length-1)==",") checkValue=checkValue.substring(0,checkValue.length-1);
		var valueArr;
		if(checkValue!=""){
			valueArr=checkValue.split(",");
			for(var i=0;i<valueArr.length;i++){
				checkValue=valueArr[i];
				if(checkValue!=" "){
					if(checkValue.indexOf("<")<0 || checkValue.indexOf(">")<0){
						//alert(tag+Mail.formaterror);
						layer.msg(Message.simpleformaterror);
						obj.select();
						obj.focus();
						return false;
						break;
					}
				}
			}
		}
		return true;
	}
	
	function addInnerFromSimp(){
		var snmsgtoValue = $("#snmsgto").val();
		var toIdValue = $("#toId").val();
		if(snmsgtoValue != ""){
			var sn = snmsgtoValue.split(",");
			var snLength = sn.length - 1;
			var snId = "";
			var snName = "";
			var snPhone = "";
			for(var i=0; i<snLength; i++){
				var tempSn = sn[i].split("$");
				var tempSnId = tempSn[0];
				var tempSnName = tempSn[1];
				var tempSnPhone = tempSn[2];
				var tempSimple = tempSn[3];
				if(toIdValue.indexOf(tempSimple) != -1) {
					snName = snName + tempSnName + ",";
					snId = snId + tempSnId + ",";
					snPhone = snPhone + tempSnPhone + ",";
				}
			}
			$("#snmsgtoid").val(snId);
			$("#snmsgtoname").val(snName);
			$("#snmsgtophone").val(snPhone);
		}
	}
	
	function messageLimitOK(n,obj) {
    	var formId = $(obj).parents("form").attr("id");
		var validation = validateForm(formId);
		$(obj).parents("form").find("#saveType").val(n);
		if(validation && checkCount()){
			$('#'+formId).submit();
		}	
    }
	function save_ok_setting(obj){
	
				var formId = $(obj).parents("form").attr("id");
				var validation = validateForm(formId);
				//$(obj).parents("form").find("#saveType").val(n);
				if(validation && checkCount()){
					ok_submitForm({queryForm:'queryForm',formId:'dataForm',reset:'no',tip:'保存成功！'});
				}
			}
	function save_ok_continue_setting(obj){
			var formId = $(obj).parents("form").attr("id");
			var validation = validateForm(formId);
			//$(obj).parents("form").find("#saveType").val(n);
			if(validation && checkCount()){
				ok_submitForm({queryForm:'queryForm',formId:'dataForm',reset:'yes',tip:'保存成功！'});
		}
	}
    function closeLayer(){
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);//关闭
	}

function save_ok(obj){
		removeRepeat();
		ok_submitForm({queryForm:'queryForm',formId:'dataForm',reset:'no',tip:'保存成功！'});	
		
	}

	function save_ok_continue(obj){
			removeRepeat();	
			ok_submitForm({queryForm:'queryForm',formId:'dataForm',reset:'yes',tip:'保存成功！'});
			cleanwaitAdd();
			$("#cdtx").html("0/300");
			
			
	}
	
					
    function checkCount() {
    	var limitCount = $("#limitCount").val();
    	var monthCount = $("#monthCount").val();
    	var dayCount = $("#dayCount").val();
    	if(eval(monthCount) > eval(limitCount)) {
    		layer.msg(Message.monthmsgallow);
		 	return false;
    	}
    	if(eval(dayCount) > eval(monthCount)) {
    		layer.msg(Message.daymsgallow);
		 	return false;
    	}
    	return true;
    }
	
	// 批量删除 
function batchDeleteMessage(){
    var ids = getCheckBoxData('id', 'id');
    //alert('ids=[' + ids+ ']');
    if (ids == '') {
        layer.msg("请选中需要删除的记录！");
    } else {
       
            var vUrl = whirRootPath + '/message!outboxDel.action';
          
            vUrl += '?ids=' + ids;
           
            ajaxOperate_2016({urlWithData:vUrl, tip:comm.delselect, isconfirm:true, formId:'queryForm', callbackfunction:null })
       
    }

}

function removeRepeat(){

		//解决IE8 indexOf 不兼容
		if (!Array.prototype.indexOf){
				  Array.prototype.indexOf = function(elt /*, from*/)
				  {
					var len = this.length >>> 0;
					var from = Number(arguments[1]) || 0;
					from = (from < 0)
						 ? Math.ceil(from)
						 : Math.floor(from);
					if (from < 0)
					  from += len;
					for (; from < len; from++)
					{
					  if (from in this &&
						  this[from] === elt)
						return from;
					}
					return -1;
				  };
				}
		//去重复
		//receiveCode
		var receiveCode = $('#receiveCode').val();
		if(receiveCode!=null&&receiveCode!=''){
			var receiveCodeArr = receiveCode.split(',');
			var n1 = []; //一个新的临时数组
			for(var i=0;i<receiveCodeArr.length;i++){
				//如果当前数组的第i已经保存进了临时数组，那么跳过，
				//否则把当前项push到临时数组里面
				if (n1.indexOf(receiveCodeArr[i]) == -1) {
					n1.push(receiveCodeArr[i]);
				}
				
			}
			var receiveCodeTemp ="";
			for(var i=0;i<n1.length;i++){
				receiveCodeTemp =receiveCodeTemp+ n1[i]+",";
			}
			receiveCode = receiveCodeTemp.substring(0,receiveCodeTemp.length-1);
			$('#receiveCode').val(receiveCode);
		}
		
		//msgtophone
		var msgtophone = $('#msgtophone').val();
		
		if(msgtophone!=null&&msgtophone!=''){
			var msgtophoneArr = msgtophone.split(',');
			var n2 = []; //一个新的临时数组
			for(var i=0;i<msgtophoneArr.length;i++){
				//如果当前数组的第i已经保存进了临时数组，那么跳过，
				//否则把当前项push到临时数组里面
				if (n2.indexOf(msgtophoneArr[i]) == -1) {
					n2.push(msgtophoneArr[i]);
				}
				
			}
			var msgtophoneTemp ="";
			for(var i=0;i<n2.length;i++){
				msgtophoneTemp =msgtophoneTemp+ n2[i]+",";
			}
			msgtophone = msgtophoneTemp.substring(0,msgtophoneTemp.length-1);
			
			$('#msgtophone').val(msgtophone);
		}
		//msgprivatephone
	
	}


