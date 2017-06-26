<%@ page contentType="text/html; charset=UTF-8"%>
<%
//打开表单js方法
String forminitJsFunName=""; 
//保存表单js方法
String formsaveJsFunName=""; 
//从哪地方打开
String openType=request.getAttribute("p_wf_openType")==null?"":request.getAttribute("p_wf_openType")+"";

 //发起时取流程的信息
if(openType.equals("startOpen")||openType.equals("reStart")||openType.equals("startAgain")||openType.equals("fromDraft")){
	forminitJsFunName=request.getAttribute("p_wf_forminitJsFunName")==null?"":request.getAttribute("p_wf_forminitJsFunName").toString();
	formsaveJsFunName=request.getAttribute("p_wf_formsaveJsFunName")==null?"":request.getAttribute("p_wf_formsaveJsFunName").toString();

}
//中间活动取活动信息
if(openType.equals("waitingDeal")){
	forminitJsFunName=request.getAttribute("p_wf_acti_forminitJsFunName")==null?"":request.getAttribute("p_wf_acti_forminitJsFunName").toString();
	formsaveJsFunName=request.getAttribute("p_wf_acti_formsaveJsFunName")==null?"":request.getAttribute("p_wf_acti_formsaveJsFunName").toString(); 
	if(forminitJsFunName.equals("")||forminitJsFunName.equals("null")){
		forminitJsFunName=request.getAttribute("p_wf_forminitJsFunName")==null?"":request.getAttribute("p_wf_forminitJsFunName").toString();
	} 
	if(formsaveJsFunName.equals("")||formsaveJsFunName.equals("null")){
		formsaveJsFunName=request.getAttribute("p_wf_formsaveJsFunName")==null?"":request.getAttribute("p_wf_formsaveJsFunName").toString();
	} 
}

//流程js检测函数
String ezFlowJsCheckFunName=request.getAttribute("ezFlowJsCheckFunName")==null?"initPara()":request.getAttribute("ezFlowJsCheckFunName").toString();

String  whir_stauts=request.getAttribute("p_wf_workStatus")==null?"0":request.getAttribute("p_wf_workStatus").toString();

//办理提示
String whir_dealTips=request.getAttribute("p_wf_dealTips")==null?"":request.getAttribute("p_wf_dealTips").toString();

//------------------批示意见信息  start---------------------------------------
//当前的批示意见对应字段    办件 阅件

//当前的批示意见
String cur_commentField=request.getAttribute("p_wf_curCommField")==null?"":request.getAttribute("p_wf_curCommField").toString();
 
//passNodeCommentField

//-------------------批示意见信息 end --------------------------------------------------------
%>

<!--标记大的模块-->
<s:hidden name="p_wf_msgFrom"                        id="p_wf_msgFrom" /> 
<!--任务id-->
<s:hidden name="p_wf_taskId"                         id="p_wf_taskId" />
<input type="hidden" name="p_wf_oldTaskId"           id="p_wf_oldTaskId"   value="<%=request.getAttribute("p_wf_taskId")+""%>">
<!--流程定义id-->
<s:hidden name="p_wf_processId"                      id="p_wf_processId"/>
<s:hidden name="p_wf_processType"                    id="p_wf_processType"/>
<s:hidden name="p_wf_tableId"                        id="p_wf_tableId" />

<!--流程key-->
<s:hidden name="p_wf_processDefinitionKey"           id="p_wf_processDefinitionKey" />
<!--流程名-->
<s:hidden name="p_wf_processName"                    id="p_wf_processName"/>
<input type="hidden" name="processDefinitionName"  id="processDefinitionName"  value="测试流程"/>
<!--流程实例id-->
<s:hidden name="p_wf_processInstanceId"              id="p_wf_processInstanceId" />
<!--父流程的流程实例id-->
<s:hidden name="p_wf_superProcessInstanceId"         id="p_wf_superProcessInstanceId" />
<s:hidden name="p_wf_superProcess_formKey"           id="p_wf_superProcess_formKey" />
<s:hidden name="p_wf_superProcess_recordId"          id="p_wf_superProcess_recordId" />
 
<s:hidden name="p_wf_openType"                       id="p_wf_openType"/>

<!--处理类名称-->
<s:hidden name="p_wf_classname"                      id="p_wf_classname"  />
<!--保存方法-->
<s:hidden name="p_wf_saveData"                       id="p_wf_saveData"  />
<!--完成方法-->
<s:hidden name="p_wf_completeData"                   id="p_wf_completeData" />
<!--修改方法-->
<s:hidden name="p_wf_updateData"                     id="p_wf_updateData" />
<!--退回方法-->
<s:hidden name="p_wf_backData"                       id="p_wf_backData" />

<!--审批意见范围-->
<s:hidden name="whir_commentRangeUsers"              id="whir_commentRangeUsers" />
<s:hidden name="whir_commentRangeOrgs"               id="whir_commentRangeOrgs" />
<s:hidden name="whir_commentRangeGroups"             id="whir_commentRangeGroups" /> 
 
<!--缓急-->
<input type="hidden" name="whir_priority"            id="whir_priority"   value="10" >
<!--流程标题（待办标题）-->
<s:hidden name="p_wf_remindTitle"                    id="p_wf_remindTitle" />
<!--业务主键id-->
<s:hidden name="p_wf_recordId"                       id="p_wf_recordId" />
<!--表单的key-->
<s:hidden name="p_wf_formKey"                        id="p_wf_formKey" />
<s:hidden name="p_wf_url"                            id="p_wf_url" />
<s:hidden name="p_wf_formKey_act"                    id="p_wf_formKey_act" />
<s:hidden name="p_wf_remindField"                    id="p_wf_remindField"/>
<s:hidden name="p_wf_moduleId"                       id="p_wf_moduleId"/>
<!--流程变量字段-->
<s:hidden name="p_wf_processallVariables"            id="p_wf_processallVariables"/>

<!--当前活动信息-->
<s:hidden name="p_wf_cur_activityId"                 id="p_wf_cur_activityId" />
<s:hidden name="p_wf_cur_activityName"               id="p_wf_cur_activityName" />
<!--批示意见排序方式-->
<s:hidden name="p_wf_commentSortType"                id="p_wf_commentSortType" />
<!--此活动的第几次办理-->
<s:hidden name="p_wf_activityStep"                   id="p_wf_activityStep" />

<!--当前可以修改的字段-->
<s:hidden name="p_wf_cur_ModifyField"                id="p_wf_cur_ModifyField" />

<!--打开流程时的地址-->
<s:hidden name="p_wf_mainLinkFile"                   id="p_wf_mainLinkFile" />
<s:hidden name="p_wf_titleFieldName"                 id="p_wf_titleFieldName" />

<!--流程定义信息-->
<!--在表单上保留退回意见-->
<s:hidden name="p_wf_processKeepBackComment"         id="p_wf_processKeepBackComment" />

<!--是否保留退回发起人前的批示意见-->
<s:hidden name="p_wf_processKeepReSubmitComment"     id="p_wf_processKeepReSubmitComment" />

<!--是否需要归档-->
<s:hidden name="p_wf_processNeedDossier"             id="p_wf_processNeedDossier" />
<!--流程办结后发起人可以打印-->
<s:hidden name="p_wf_processNeedPrint"               id="p_wf_processNeedPrint" />

<s:hidden name="p_wf_button_backRange"               id="p_wf_button_backRange" />

<%//--办理人设置审批意见查看范围  true/false%>
<s:hidden name="p_wf_commentRangeByDealUser"         id="p_wf_commentRangeByDealUser" />

<%
//String  otherTaskId=request.getParameter("otherTaskId")==null?"":request.getParameter("otherTaskId")+"";
String  otherTaskId=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"otherTaskId"); 
%>
<!--批量办理的其它任务id  疑问-->
<input type="hidden" name="otherTaskId"              id="otherTaskId"   value="<%=otherTaskId%>"   />
<!--发起信息--->
<!--发起人名 whir_startUserName-->
<s:hidden name="p_wf_submitPerson"                   id="p_wf_submitPerson" />

<s:hidden name="p_wf_startOrgId"                     id="p_wf_startOrgId" />
<s:hidden name="p_wf_startOrgName"                   id="p_wf_startOrgName" />
<s:hidden name="p_wf_submitTime"                     id="p_wf_submitTime" />
 
<!--发起人帐号 ezFlow_startUser -->
<s:hidden name="p_wf_submitUserAccount"              id="p_wf_submitUserAccount" />

<s:hidden name="p_wf_workStatus"                     id="p_wf_workStatus" />
<!--代理信息-->
<s:hidden name="p_wf_isProxy"                        id="p_wf_isProxy" />
<s:hidden name="p_wf_proxyAssignee"                  id="p_wf_proxyAssignee" />
<s:hidden name="p_wf_proxyAssigneeName"              id="p_wf_proxyAssigneeName" />
<s:hidden name="p_wf_proxyTaskId"                    id="p_wf_proxyTaskId" />

<!-- 转办信息--->
<s:hidden name="p_wf_isTransfer"                     id="p_wf_isTransfer" />
<s:hidden name="p_wf_transferFromId"                 id="p_wf_transferFromId" />
 

<!--自动返回活动信息-->
<s:hidden name="p_wf_isbacktrackAct"                 id="p_wf_isbacktrackAct" />
<s:hidden name="p_wf_backtrackFromTaskId"            id="p_wf_backtrackFromTaskId" />
 
<!--退回生成的活动信息-->
<!--退回后的活动是否需要 直接返回到退回点-->
<s:hidden name="p_wf_isneedSendtoBack"               id="p_wf_isneedSendtoBack" />
<s:hidden name="p_wf_backFromTaskId"                 id="p_wf_backFromTaskId" />

 
<s:hidden  name="p_wf_dataForm"                      id="p_wf_dataForm"/>
<s:hidden  name="p_wf_queryForm"                     id="p_wf_queryForm"/>
<s:hidden  name="p_wf_initPara"                      id="p_wf_initPara"/> 

<!--当前的批示意见-->
<s:hidden  name="p_wf_curCommField"                  id="p_wf_curCommField" />
<!--1： 批示意见不能为空--->
<s:hidden  name="p_wf_commentNotNull"  id="p_wf_commentNotNull" />

<s:hidden  name="p_wf_relationTrig"  id="p_wf_relationTrig" />

<!--从首页来的 portletId--> 
<s:hidden  name="portletSettingId"             id="portletSettingId" />
 
<!--表单类型   2：默认表单    0：  自定义表单 -->
<s:hidden  name="p_wf_pool_formType"             id="p_wf_pool_formType" />
<!--流程中间表id -->
<s:hidden  name="p_wf_pool_processId"             id="p_wf_pool_processId" />
<!--1：新流程  0：老流程 -->
<s:hidden  name="p_wf_pool_processType"             id="p_wf_pool_processType" />
 
<s:hidden  name="p_wf_mailviewUrl"             id="p_wf_mailviewUrl" />

<!-- 经过的网关节点 -->
<s:hidden  name="p_wf_whir_dealedActInfo"             id="p_wf_whir_dealedActInfo" />

<!-- 不允许退回给流程启动人 -->
<s:hidden  name="p_wf_processNoBackSubmitUser"         id="p_wf_processNoBackSubmitUser" />
 
<input type="hidden" name="callBackName"       id="callBackName"      value="" />
<input type="hidden" name="callBackTips"       id="callBackTips"      value="" />
<input type="hidden" name="callBackTitle"      id="callBackTitle"     value="" /> 

<!--弹出对话框标题-->
<input type="hidden" name="wf_dialog_title"  id="wf_dialog_title" value="" /> 
<!--发送继续-->
<input  type="hidden"  name="p_wf_saveType" id="p_wf_saveType" value="0" />
  

<!-- 批量办理的workIds -->
<s:hidden name="p_wf_batchWorkIds" id="p_wf_batchWorkIds" />

 

<!--选择的办理活动--->
<input type="hidden" name="p_wf_choosedActivityId"   id="p_wf_choosedActivityId" />
<!-- 是否需要短信提醒-->
<input type="hidden" name="sendNeedNoteType"         id="sendNeedNoteType" value="0">
<!-- 是否需要邮件提醒  退回也用了这个设置项(2016-6-15)-->
<input type="hidden" name="sendNeedMailType"         id="sendNeedMailType" value="0">
<input type="hidden" name="whir_noteContent"         id="whir_noteContent" >

<input type="hidden" name="sendNeedRTXType"         id="sendNeedRTXType" value="0">
<!--办理提示-->
<input type="hidden" name="whir_dealTips"            id="whir_dealTips" >

<!------需要赋值的信息-------------->
<!-- 发送时 网关类型 以及 动作类型-->
<input type="hidden" name="gate_dealType"            id="gate_dealType"              value="">
<!---此次发送需要经过几个网关--->
<input type="hidden" name="gateNum"                  id="gateNum"                    value="0">

<!--退回信息-->
<input type="hidden" name="back_activityId"          id="back_activityId"     />
<input type="hidden" name="back_userAccounts"        id="back_userAccounts"  />
<input type="hidden" name="back_userNames"           id="back_userNames"    />
<input type="hidden" name="back_userIds"             id="back_userIds"      />
<input type="hidden" name="backEmailRemindType"      id="backEmailRemindType"  />
<input type="hidden" name="backNeedNoteRemind"       id="backNeedNoteRemind"     />
<input type="hidden" name="backReason"               id="backReason"     />
<!-- 1：需要直接返回到当前退的节点    0: 不需要 返回 -->
<input type="hidden" name="backNeedBackType"         id="backNeedBackType"     />
 
<input type="hidden" name="cancelReason"             id="cancelReason"     />
 
<!--加签等选择的办理人-->
<input type="hidden" name="deal_userAccounts"        id="deal_userAccounts"     />
<input type="hidden" name="deal_userNames"           id="deal_userNames"     />
<input type="hidden" name="deal_userIds"             id="deal_userIds"     />
<input type="hidden" name="addSignNeedNote"          id="addSignNeedNote"     />


<!--阅件与转阅-->
<input type="hidden" name="sendReadType"             id="sendReadType"    value="add"  />
<input type="hidden" name="readNeedNote"             id="readNeedNote"     />
<!--转办    // 2转办 3：转办后自动返回 -->
<input type="hidden" name="tranStatus"              id="tranStatus"   value="2" />
<input type="hidden" name="p_wf_keepTranRecord"     id="p_wf_keepTranRecord"   value="" />
<input type="hidden" name="tranNeedEmail"           id="tranNeedEmail"  />
<input type="hidden" name="tranNeedNote"            id="tranNeedNote"  />
<input type="hidden" name="tranNeedRtx"             id="tranNeedRtx"  />

<input type="hidden" name="pressUserId"            id="pressUserId"  />
<input type="hidden" name="pressUserName"          id="pressUserName"  />
<input type="hidden" name="pressTitle"             id="pressTitle"  />
<input type="hidden" name="pressContent"           id="pressContent"  />
<input type="hidden" name="pressSMS"               id="pressSMS"  />
<input type="hidden" name="pressOutEmail"          id="pressOutEmail"  />
 

<input type="hidden" name="feedUserId"             id="feedUserId"  />
<input type="hidden" name="feedUserName"           id="feedUserName"  />
<input type="hidden" name="feedTitle"              id="feedTitle"  />
<input type="hidden" name="feedContent"            id="feedContent"  />


<input type="hidden" name="tranMailtoId"           id="tranMailtoId"  />
<input type="hidden" name="tranMailtoName"         id="tranMailtoName"  />
<input type="hidden" name="tranMailtoContent"      id="tranMailtoContent"  />
 

<!--相关流程的序号 initRealtionNum 会为之赋值-->
<input type="hidden" name="relationLiId"           id="relationLiId"/>
 

<!--收回-->
<input type="hidden" name="drawBacktoActivityId"   id="drawBacktoActivityId"  />

<!--相关流程-->
<!--发起流程时 关联的别的流程的id-->
<input type="hidden" name="relationRProcessInstanceId"   id="relationRProcessInstanceId"  />
<!--从relationProcessInstanceId发起的 新流程-->
<input type="hidden" name="relationProcessInstanceId"    id="relationProcessInstanceId"  value="<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"relationProcessInstanceId")%>" />

<input type="hidden" name="rrecordId"   id="rrecordId"  value="<%=request.getParameter("rrecordId")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"rrecordId")%>"/>
<input type="hidden" name="rmoduleId"   id="rmoduleId"  value="<%=request.getParameter("rmoduleId")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"rmoduleId")%>" />
 
<!-----------批示意见区域---------->
<input type="hidden" name="ezFlow_commentDealContent"  id="ezFlow_commentDealContent">
<input type="hidden" name="ezFlow_commentType"         id="ezFlow_commentType"         value="0">
<input type="hidden" name="openuserId"                 id="openuserId"         value="<%=""+session.getAttribute("userId")%>">
 

<!--定时发送-->
<input type="hidden" name="p_wf_dealWithJob"         id="p_wf_dealWithJob"     value="0">
<input type="hidden" name="jobStartTime_str"         id="jobStartTime_str"         >
<!--是否是随机流程发送-->
<input type="hidden" name="ezflow_randomSend"        id="ezflow_randomSend"      value="0">

<input type="hidden" name="commentAttitudeType"      id="commentAttitudeType"      value="0">
<s:hidden  name="p_wf_commentAttitudeTypeSet"        id="p_wf_commentAttitudeTypeSet"/> 


<div id="ezFlow_includeHiddenDivInfo" style="display:none"></div>
<div style="display:none" id="whir_dealTips_now"><%=com.whir.ezflow.util.EzFlowUtil.escapeHTMLTags(whir_dealTips)%></div>


<SCRIPT LANGUAGE="JavaScript">
<!--
 
 /*
  弹出发送框之前 封装批示意见 手写签批, 批示意见附件
*/
function  initCommentAndAccessory(){ 
//function  checkEzFlowStart(){ 
	var result=true;
	setAccessoryIframe();
	if(!setComment(1)){
		result=false;
		return false;
	}
	//设置手写签批
	if(!include_saveSignature()){
		return false;
	}
    var  ezFlow_commentDealContent_value=$("#ezFlow_commentDealContent").val(); 
	if(ezFlow_commentDealContent_value.indexOf("'")>=0){
		 whir_alert("批示意见 不能包含'",function(){});
		 return false;
    }
	if(ezFlow_commentDealContent_value.indexOf("\"")>=0){
		 whir_alert("批示意见 不能包含\"", function(){});
		 return false;
    } 
	return result;
}
 
 

//退回检测批示意见等
function  checkEzFlowBack(){
	if(!setComment("-1")){
		result=false;
	}
	//设置手写签批
	if(!include_saveSignature()){
		return false;
	}
    return true;
}



//保存手写意见
function include_saveSignature(){
    var result=false; 
	<%if(cur_commentField!=null&&!cur_commentField.equals("")&&!cur_commentField.equals("null")&&!cur_commentField.equals("nullCommentField")){%>
	//自动追加批示意见
	<%if(cur_commentField.equals("autoCommentField")){%>	
		 if(true){ 
           if($("#SendOut").length>0){
			    var saveResult=true;
				try{
					if($("#SendOut")[0].SaveSignature()){ 
						saveResult=true;
					}else{
						saveResult=false;
					}
				}catch(e){
				} 

				try{
					if ($("#SendOut")[0].SaveAsGifEx('iWebSignature_abcd.gif','All', 'Remote')) { }
				}catch(e){
				}
				return saveResult;
			}else{
				return true;
			}

        }else{
            return true;
        }	
	<%}else{%>
		var  cur_commentField_js="<%=cur_commentField%>_SendOut";
		if(cur_commentField_js.indexOf('$')!=-1){
			 //cur_commentField_js = cur_commentField_js.replace(/\$/m, '\\$');
			 cur_commentField_js = cur_commentField_js.replace(/[$]/g, "\\\$");  
		}
	    if($("#"+cur_commentField_js).length>0){
			  try{
				if($("#"+cur_commentField_js)[0].SaveSignature()){
					result= true;
				}else{
					result= false;
				}
			  }catch(e){
				  result=true;
			  }

			  try{
				 if ($("#"+cur_commentField_js)[0].SaveAsGifEx("null",'All', 'Remote')) { }
			  }catch(e){
			  }
			  return result;
		 }else{
			return true;
		 }
	<%}}%>	
	return true;
}




/**
  发起前 取批示意见
  dealtype   -1：退回
*/
function  setComment(dealtype){
    var js_cur_commentField="";
    <%if(cur_commentField!=null&&!cur_commentField.equals("")&&!cur_commentField.equals("null")){%>
       js_cur_commentField="<%=cur_commentField%>";
    <%}%> 
    //没有批示意见
    if(js_cur_commentField==""||js_cur_commentField=="nullCommentField"){
       return true;
    }
    
	//退回
	if(dealtype=="-1"){
	
	}else{
		if($("[name='radio_commentAttitudeType']").length>0){ 
			var radio_commentAttitudeType_f = $("input[name='radio_commentAttitudeType']:checked");
			if(radio_commentAttitudeType_f.length<=0){
				  whir_alert('请选择意见态度。',function(){});
				  return false;
			}
			var radio_commentAttitudeType_v= radio_commentAttitudeType_f[0].value;  
			$("#commentAttitudeType").val(radio_commentAttitudeType_v); 
		}
	}

    //自动追加批示意见
    if(js_cur_commentField=="autoCommentField"){	
		if($("[name='comment']").length>0){
			var commentSignIndex_value =$("#commentSignIndex").val();
			$("#ezFlow_commentType").val(commentSignIndex_value);
			if($("[name='comment']").length>1){
                $("#ezFlow_commentDealContent").val($("[name='comment']")[commentSignIndex_value].value);
			} else{
                $("#ezFlow_commentDealContent").val($("[name='comment']").val());
			}
			//判断批示意见是否为空
			if($("#p_wf_commentNotNull").val()=="true"){
			  if($("#ezFlow_commentDealContent").val()==""&&dealtype!="-1"){
				    whir_alert('<s:text name="workflow.commentcannotnull"/>',function(){});
				    return false;
			  }  
			}
		}
    }else{//批示意见对应字段
    //批示意见字段名
	   if(js_cur_commentField.indexOf('$')!=-1){
	 	  js_cur_commentField = js_cur_commentField.replace(/[$]/g, "\\\$"); 
       } 
	   //if($("#"+js_cur_commentField).length>0){
	   if($("[name='"+js_cur_commentField+"']").length>0){
		   var commentSignIndex_value =$("#commentSignIndex").val();  
		   $("#ezFlow_commentType").val(commentSignIndex_value);	


		   /*if($("#commentSignIndex").length>0 && $("#"+js_cur_commentField).length>1){
               $("#ezFlow_commentDealContent").val($("#"+js_cur_commentField)[commentSignIndex_value].value ); 
		   } else{
				//document.all.ezFlow_commentDealContent.value = document.all.<%=cur_commentField%>.value;
                $("#ezFlow_commentDealContent").val($("#"+js_cur_commentField).val());
		   }*/

		   
		   //多个
		   if($("#commentSignIndex").length>0&&$("[name='"+js_cur_commentField+"']").length>1){ 
			   $("#ezFlow_commentDealContent").val($("[name='"+js_cur_commentField+"']")[commentSignIndex_value].value);				
		   }else{
			   $("#ezFlow_commentDealContent").val($("[name='"+js_cur_commentField+"']").val());
		   }
			
		   //判断批示意见是否为空
		   if($("#p_wf_commentNotNull").val()=="true"){
			    if($("#ezFlow_commentDealContent").val()==""&&dealtype!="-1"){
				    whir_alert('<s:text name="workflow.commentcannotnull"/>',function(){});
				    return false;
			    }  
		   }
	   }		
   }	
   return true;
}
 
//处理批示意见附件
//为什么用iframe  是因为如果批示意见是 对应字段 需要用js赋值过去 ，现在附件写法比较难实现
function   setAccessoryIframe(){
 
}

//显示 tips
function  showDealtipsContent(){
 
   <%  
		String p_wf_activityTip=request.getAttribute("p_wf_activityTip")==null?"0":request.getAttribute("p_wf_activityTip").toString();
		String p_wf_activityTipTitle=request.getAttribute("p_wf_activityTipTitle")==null?"0":com.whir.ezflow.util.EzFlowUtil.escapeHTMLTags(request.getAttribute("p_wf_activityTipTitle").toString());
		String p_wf_activityTipCotent=request.getAttribute("p_wf_activityTipCotent")==null?"0":com.whir.ezflow.util.EzFlowUtil.escapeHTMLTags(request.getAttribute("p_wf_activityTipCotent").toString());
   %>
   <% if(p_wf_activityTip!=null&&p_wf_activityTip.equals("1")){%>  
		 //whir_alertWithTitle("<%=p_wf_activityTipTitle%>","<%=p_wf_activityTipCotent%>",function(){});   
		  $.dialog.alertWithTitle("<%=p_wf_activityTipTitle%>","<%=p_wf_activityTipCotent%>",function(){showDealtipsContent2();}); 
   <%}else{%>
        showDealtipsContent2();
   <%} %>
}

 function  showDealtipsContent2(){
     <%
	 if(whir_dealTips!=null&&!whir_dealTips.equals("")&&!whir_dealTips.equals("null")){%>
       // alert("<%=com.whir.ezflow.util.EzFlowUtil.escapeJSTags(whir_dealTips)%>"); 
       /*var dia2=$.dialog({ padding: 0,drag: true, resize: true,lock: true, id: 'testID',content:'url:<%=rootPath%>/platform/bpm/ezflow/operation/ezFlow_show_dealtips.jsp',title:'办理提示' });*/
	   // alert($("#whir_dealTips_now").html());
	    // whir_alert_eh($("#whir_dealTips_now").html(),function(){},null,"500px","400px"); 
		 whir_alert($("#whir_dealTips_now").html(),function(){}); 
   <%
	   }
   %> 
 }

 

//打开表单js方法
function ezForminitATezFLOW(){  
	<%if(forminitJsFunName!=null&&!forminitJsFunName.equals("")&&!forminitJsFunName.equals("null")){%>
     if(typeof <%=forminitJsFunName%> == 'function'){
        <%=forminitJsFunName%>();
     }
	<%}%> 
}

//保存表单js方法
function  ezFormSaveATezFLOW(){ 
	var result=true;
	<%if(formsaveJsFunName!=null&&!formsaveJsFunName.equals("")&&!formsaveJsFunName.equals("null")){%> 	 
	 if(typeof <%=formsaveJsFunName%> == 'function'){ 
        result=<%=formsaveJsFunName%>();
     }
     <%}%>
	 return result;
}
	



//判断是否被别人加锁了
$(document).ready(function(){
    <s:if test="#request.onlineUserName!=null">
	  whir_alert('<s:property value="#request.onlineUserName" /><s:text name="workflow.includeediting"/>',function(){});
    </s:if> 
});

 
 
//onbeforeunload  事件
$(window).bind("beforeunload",function(){
    //电子签章销毁
    if($("#SignatureControl_w").length>0){
		try{
	        $("#SignatureControl_w")[0].DeleteSignature();
		}catch(e){
		}
    }
	//删除锁
	$.ajax({
	  url: '/defaultroot/platform/bpm/ezflow/operation/ezflow_myflow_close.jsp?p_wf_recordId='+$("#p_wf_recordId").val()+'&p_wf_formKey='+$("#p_wf_formKey").val()+'&p_wf_processInstanceId='+$("#p_wf_processInstanceId").val()+'&p_wf_taskId='+$("#p_wf_taskId").val(),
	  async: false,cache: false
	});
});


/**
 此方法必须放在此页面 可能是因为包含页加载完相对与主页面 有延迟， 主要是IE10发现此问题
*/
$(document).ready(function(){
     readyFun();
});
 
	
//-->
</SCRIPT>
