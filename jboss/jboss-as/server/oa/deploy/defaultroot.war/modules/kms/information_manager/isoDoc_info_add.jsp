<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="ISO.newiso"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">
	.x-boundlist-item{
		width:100%;
		<!--text-overflow: ellipsis;
		overflow: hidden;
		word-break: keep-all !important;
		word-wrap: normal;
		white-space: nowrap;
		
		//display:block;
		//padding-right:0 !important; -->
	}
	</style> 

</head>
<%
String orgId=session.getAttribute("orgId").toString();
String orgName=session.getAttribute("orgName").toString().toString();
%>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
				<tr>
					<td>
						<div class="Public_tag">
							<ul>
								<li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><s:text name="info.newinfobasic"/></span><span class="tag_right"></span></li>  
								<li id="Panle1" onClick="changePanle(1);"><span class="tag_center"><s:text name="info.newinfodetail"/></span><span class="tag_right"></span></li>  
						   </ul>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="docBoxNoPanel">
			<s:form name="form" id="form" action="Information!start.action?iso=1" method="post">
				<s:hidden id="p_wf_pool_processId" name="p_wf_pool_processId"/>
				<s:hidden id="channel" name="channel" value="%{#request.channel}"/>
				<s:hidden id="reader" name="reader" value="%{#request.reader}"/>
				<s:hidden id="readerName" name="readerName" value="%{#request.readerName}"/>
				<s:hidden id="tempContent" name="tempContent" value="%{#request.tempContent}"/>
				<s:hidden id="printer" name="printer" value="%{#request.printer}"/>
				<s:hidden id="printerName" name="printerName" value="%{#request.printerName}"/>
			</s:form>
			<s:form name="dataForm" id="dataForm" action="ISO!save.action" method="post">
			<%@ include file="/public/include/form_detail.jsp"%>
			<%@ include file="isoDoc_form.jsp"%>
			</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'',"tip":'<s:text name="info.newinfosave"/>'});
Ext.onReady(function() {
	var modelCombo = Ext.create('Ext.form.field.ComboBox', {
		id: 'channelId',
		typeAhead: true,
		transform: 'selectChannels',
		hiddenName: 'selectChannel',
		width: 1100,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				changeChannel(combo.getValue());
			}
		}
	});

	//初始化栏目
	var channel = $("#channel").val();
	if(channel!=''){
		whirExtCombobox.setValue('channelId',channel);
	}
});

$(document).ready(function(){
	$(":radio[name='information.informationType']").change(function(){
		changeInfoType(this.value);
	});
	
	$(":radio[name='information.informationValidType']").change(function(){
		if(this.value==1){
			$("#validBeginTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validEndTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validTime").show();
		}else{
			$("#validBeginTime").val('');
			$("#validEndTime").val('');
			$("#validTime").hide();
		}
	});
	
	//初始化可查看人
	var reader = $("#reader").val();
	var readerName = $("#readerName").val();
	if(reader!=''){
		$("#informationReaderId").val(reader);
		$("#informationReaderId_").val(reader);
		$("#informationReaderName").val(readerName);
	}
	//20170222 -by jqq 初始化可借阅人
	var printer = $("#printer").val();
	var printerName = $("#printerName").val();
	if(printer!=''){
		$("#informationPrinterId").val(printer);
		$("#informationPrinterId_").val(printer);
		$("#informationPrinterName").val(printerName);
	}
	//初始化内容
	setTimeout("setEditerContent()",500);
	
});

function setEditerContent(){
	if ($("#tempContent").val()!=""){
		document.getElementById("newedit").contentWindow.setHTML($("#tempContent").val());
	}
}

function changeInfoType(val){
	if(val==1){
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#edit").show();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==2){
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#edit").hide();
		$("#url").show();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==3){
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").show();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		whir_uploader_reset("uploadFile");
	}else if(val==4){
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").show();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==5){
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").show();
		$("#ppt").hide();
	}else if(val==6){
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").show();
	}
}

function changePanle(flag){
    if(flag==0){
		$("#docinfo1").hide();
		$("#Panle1").removeClass();
		$("#docinfo0").show();
		$("#Panle0").addClass("tag_aon");
	}else{
		$("#docinfo0").hide();
		$("#Panle0").removeClass();
		$("#docinfo1").show();
		$("#Panle1").addClass("tag_aon");
	}
}

function changeChannel(val){
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				if(data.processId=="0"){
					$("#informationReaderId").val(data.canReader);
					$("#informationReaderName").val(data.canReaderName);
					//20170216 -by jqq 可借阅人回填
					$("#informationReaderId_").val(data.canReader);
					$("#informationPrinterId").val(data.printer);
					$("#informationPrinterId_").val(data.printer);
					$("#informationPrinterName").val(data.printerName);
				}else{
					if(data.processId=="-1"){
						whir_alert('<s:text name="info.noprocess"/>');
						whirExtCombobox.setValue('channelId','');
					}else{
						$("#p_wf_pool_processId").val(data.processId);
						$("#channel").val(val);
						$("#reader").val(data.canReader);
						$("#readerName").val(data.canReaderName);
						//20170216 -by jqq 借阅人回填
						$("#printer").val(data.printer);
						$("#printerName").val(data.printerName);
						if($(':radio[name="information.informationType"]:checked').val()=='1'){
							$("#tempContent").val(document.getElementById("newedit").contentWindow.getHTML());
						}
						$("#form").submit();
					}
				}
				
			}
		}
	});
}

//20130907-----start
function checkVersion(obj){
	if($(obj).val()!='' && $(obj).val().indexOf('.') <0){
		whir_alert('<s:text name="info.initialversion"/>');
		$(obj).val('');
	}
}
//20130907-----end

function save(flag,obj){
	var informationType = $(':radio[name="information.informationType"]:checked').val();
	if(informationType == 1){
		var o_Editor = document.getElementById("newedit").contentWindow;
		$("#informationContent").val(o_Editor.getHTML());
	}else if(informationType == 0){
		$("#informationContent").val($("#textContent").val());
	}else if(informationType == 2){
		var url = $("#URLContent").val();
		if(url==""){
			whir_alert('<s:text name="info.Addressnotempty"/>');
			return;
		}else{
			url = $.trim(url);
			if(url.substring(0,7)!="http://"){
				whir_alert('<s:text name="info.Addresserrors"/>');
				return;
			}else{
				$("#informationContent").val(url);
			}
		}
	}else if(informationType == 3){
		if($("#fileLinkContent").val()==""){
			whir_alert('<s:text name="info.notselectedfiles"/>');
			return;
		}else{
			$("#informationContent").val($("#fileLinkContent").val()+":"+$("#fileLinkContentHidd").val());
		}
	}else if(informationType == 4){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}else if(informationType == 5){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}else if(informationType == 6){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}
	
	//20130907-----start
	if($('#informationVersion').val()!='' && $('#informationVersion').val().indexOf('.') <0){
		whir_alert('<s:text name="info.initialversion"/>');
		$('#informationVersion').val('');
		return;
	}
	//20130907-----end
	
	//20130913-----验证文档编号-----start
	var wd_flag=false;
	var documentNo=$('#documentNo').val();
	var data =$.ajax({url:"/defaultroot/modules/kms/information_manager/iso_judgeDocument.jsp?documentNo="+documentNo+"",async: false}).responseText;
	data =$.trim(data);
	if(data == 0){
  		wd_flag=false;
    }else{
  		wd_flag= true;
  	}
	if(!wd_flag){
		whir_alert('<s:text name="ISO.documentNOTwo"/>');
		return;
	}
	//20130913-----验证文档编号-----end
	
	var selectChannel = whirExtCombobox.getValue('channelId');//whirCombobox.getValue("selectChannel");
	if(selectChannel==""||selectChannel=="0"){
		whir_alert('<s:text name="info.haveNotSelectDirectory"/>');
		return;
	}else if($("#validEndTime").val()!='' && $("#validBeginTime").val()==''){
		whir_alert('<s:text name="info.selectValidityStartTime"/>');
		return;
	}else if($("#validEndTime").val()=='' && $("#validBeginTime").val()!=''){
		whir_alert('<s:text name="info.selectValidityEndTime"/>');
		return;
	}else{
		ok(flag,obj);
	}
}

function wordEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=isoDoc&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.doc&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&initRecordId=1259293647344',isFull:true,winName:'editContent'});
}

function excelEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=isoDoc&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.xls&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1',isFull:true,winName:'editContent'});
}

function pptEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=isoDoc&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.ppt&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1',isFull:true,winName:'editContent'});
}

function setAsso(){
	popup({content:'url:ISOList!list.action?type=0&setAsso=1&channelType='+$("#channelType").val()+'&userDefine='+$("#userDefine").val(),title:'<s:text name="info.SelectRelevantDocuments"/>',lock:true,width:900,height:600});
}

function delAsso(obj){
	whir_confirm("您确定要删除该相关文档吗？",function(){
		$(obj).parent().remove();
	});
}

function viewInfo(infoId,intoType,channelId){
	openWin({url:'Information!view.action?informationId='+infoId+'&informationType='+intoType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&iso=1',isFull:true,winName:"info"+infoId});
}

function selectReader(){
	var channelReader_ = $("#informationReaderId_").val();
	if(channelReader_!=""){
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelReader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectPrinter(){
	var channelPrinter_ = $("#informationPrinterId_").val();
	if(channelPrinter_!=""){
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelPrinter_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}
</script>
</html>