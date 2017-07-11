<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
    String boardroomApplyType = "0";
	if(request.getAttribute("boardroomApplyType") !=null){
		boardroomApplyType = request.getAttribute("boardroomApplyType").toString();
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>会议使用记录列表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/boardRoom!useBoardroomView2.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
    <tr>
        <td class="whir_td_searchtitle">会议室名称：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchBoardRomeName" name="searchBoardRomeName" size="16" cssClass="inputText" maxlength="15"/>
        </td>
        <td class="whir_td_searchtitle">主持人：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchBoardRomeEmcee" name="searchBoardRomeEmcee" size="16" cssClass="inputText" maxlength="15"/>
        </td>
        <td class="whir_td_searchtitle">会议主题：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchBoardRomeMotif" name="searchBoardRomeMotif" size="16" cssClass="inputText" maxlength="15"/>
        </td>
    </tr>
     <tr>
        <td class="whir_td_searchtitle">申请人：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchApplyName" name="searchApplyName" size="16" cssClass="inputText" maxlength="15"/>
        </td>
        <td class="whir_td_searchtitle">管理部门：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="manageOrgName" name="manageOrgName" size="16" cssClass="inputText" maxlength="15"/>
        </td>
        <td class="whir_td_searchtitle">会议类型：</td>
        <td class="whir_td_searchinput">
            <select name="boardroomApplyType" id="boardroomApplyType"  class="easyui-combobox" style="width:150px"  data-options="panelHeight:200,forceSelection:true">
                 <option value="0">--请选择--</option>
                  <%
                        java.util.List boardroomApplyTypeList=(java.util.List)request.getAttribute("boardroomApplyTypeList");
                        if(boardroomApplyTypeList !=null){
                            for(int	j =	0; j < boardroomApplyTypeList.size(); j++){
                            Object[] obj = (Object[])boardroomApplyTypeList.get(j); 
                        %>
                        <option value="<%=obj[0]%>"><%=obj[1]%></option>
                        <%}
                        }%>       
            </select>
        </td>
    </tr>
    <tr>
        <td class="whir_td_searchtitle">申请人部门：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="applyOrgName" name="applyOrgName" size="16" cssClass="inputText" maxlength="15"/>
        </td>
        <td nowrap class="whir_td_searchtitle">预定日期：</td>
        <td class="whir_td_searchinput" colspan=3>
             <s:textfield id="searchStartDate" name="searchStartDate"  cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchEndDate\\',{d:0});}'})"/> 至 <s:textfield id="searchEndDate" name="searchEndDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchStartDate\\',{d:0});}'})"/>
               
        </td>
        </tr>
        <tr>
        <td class="SearchBar_toolbar" colspan="6">
           <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />      
        </td>
    </tr>
</table>
    
	<!-- SEARCH PART END -->
    <input type="hidden" name="export" id="export" value="">
	<!-- MIDDLE	BUTTONS	START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr>
            <td align="right">
            <input type="button" class="btnButton4font" onClick="export2Excel();" value='<s:text name="comm.export"/>' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'motif',width:'20%',renderer:showMotif">会议主题</td> 
			<td whir-options="field:'meetingDate', width:'17%',allowSort:true,renderer:showTime">会议时间</td> 
            <td whir-options="field:'name', width:'15%',allowSort:true">会议室名称</td>
            <td whir-options="field:'bdroomAppType', width:'8%'">类型</td>
            <td whir-options="field:'applyEmpName',width:'8%'">申请人</td> 
			<td whir-options="field:'applyOrgName', width:'18%'">申请人部门</td> 
            <td whir-options="field:'status', width:'5%',renderer:showStatus">状态</td>
            <td whir-options="field:'',width:'9%',renderer:myOperate">操作</td> 
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->
   
	</s:form>


</body>

	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){
		initListFormToAjax({formId:'queryForm'});
	});
	//自定义操作栏内容
	function myOperate(po,i){
		 var html =  '';
         var hasAuth=po.hasAuth;
         var meetingTimeStatus=po.meetingTimeStatus;
         var status=po.status;
		 var isSwPerson=po.isSwPerson;
         var meetingTimeType=po.meetingTimeType;
         if(meetingTimeType==null || meetingTimeType=='null'){
             meetingTimeType='';
         }
         var compareToStime=Number(po.compareToStime);
         var compareToEtime=Number(po.compareToEtime);
         var date=(po.meetingDate).substring(0,10);
		 var isNewOrOld=po.isNewOrOld;
         if(hasAuth == 'true'){
            if(meetingTimeType !='1' && meetingTimeStatus !='1' && status !='-1' 
                && status != '3' && status != '-2'){
                html+='<img title="修改" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/boardRoom!selectBoardroomApplyView.action?boardroomApplyId='+po.boardroomApplyId+'&boardroomName='+po.name+'&type=view&action=selectBoardroomApplyModify&p_wf_openType=waitingDeal&p_wf_moduleId=15&p_wf_recordId='+po.boardroomApplyId+'&isNewOrOld='+isNewOrOld+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'modifyBoardroomApply\'});">';
            }
            html+='<img title="删除" style="cursor:hand" border="0" src="<%=rootPath%>/images/del.gif" onClick="ajaxDelete(\'${ctx}/boardRoom!cancelBoardroomApply.action?boardroomApplyId='+po.boardroomApplyId+'&meetingTimeId='+po.meetingTimeId+'\',this);">';
            if(meetingTimeType !='1' && meetingTimeStatus !='1' && status !='-1' 
                && status != '3' && status != '-2' && compareToEtime >= 0){
                 html+='<img title="提前结束" style="cursor:hand" border="0" src="<%=rootPath%>/images/cxtj.gif" onClick="finish(\''+po.boardroomApplyId+'\',\''+po.meetingTimeId
                     +'\',\''+po.motif+'\',\''+date+'\',\''+po.btime+'\',\''+po.etime+'\');">';
            }
            if( meetingTimeType ==''){//处理老数据
                if(meetingTimeStatus !='1' && status !='-1' 
                    && status != '3' && status != '-2'){
                   
                     html+='<img title="取消" style="cursor:hand" border="0" src="<%=rootPath%>/images/resume.gif" onClick="delBoardRoomApply(\''+po.boardroomApplyId+'\',\''+po.boardroomId
                         +'\',\''+po.startTime+'\',\''+po.endTime+'\',\''+po.name+'\',\''+date
                          +'\',\''+po.motif+'\',\''+po.emcee+'\',\''+po.attendeeEmpId
                         +'\',\''+po.attendeeLeaderId+'\',\''+po.nonvotingEmpId+'\',\''+po.meetingTimeId+
                         '\');">';
                }
            }else{//新数据
                 if(meetingTimeType =='0' && meetingTimeStatus !='1' && status !='-1' 
                    && status != '3' && status != '-2' ){
                   
                     html+='<img title="取消" style="cursor:hand" border="0" src="<%=rootPath%>/images/resume.gif" onClick="delBoardRoomApply(\''+po.boardroomApplyId+'\',\''+po.boardroomId
                         +'\',\''+po.startTime+'\',\''+po.endTime+'\',\''+po.name+'\',\''+date
                          +'\',\''+po.motif+'\',\''+po.emcee+'\',\''+po.attendeeEmpId
                         +'\',\''+po.attendeeLeaderId+'\',\''+po.nonvotingEmpId+'\',\''+po.meetingTimeId+
                         '\');">';
                }
            }
         }
		  if(isSwPerson == 'yes'){
                html+='<img title="转批" style="cursor:hand" border="0" src="<%=rootPath%>/images/hyzp.png" onClick="openWin({url:\'<%=rootPath%>/modules/subsidiary/boardroom/selectWorkFlowSW.jsp?boardroomApplyId='+po.boardroomApplyId+'&boardroomName='+po.name+'&boardroomId='+po.boardroomId+'&moduleId=16&isNewOrOld='+isNewOrOld+'\',width:'+(560)+',height:'+(300)+',winName:\'zfWrokflow\'});">';
            }
         //alert("html:"+html);
		return html;
	}
     function finish(id, id2, name, meetingDate, startTime, endTime){
          $.dialog.confirm("确实要提前结束这次会议吗？", function(){finish1(id, id2, name, meetingDate, startTime, endTime)});
    }
     function finish1(id, id2, name, meetingDate, startTime, endTime){
         var url='<%=rootPath%>/modules/subsidiary/boardroom/boardRoomApply_finish.jsp?boardroomApplyId='+id+'&meetingId='+id2+'&name='+name+'&meetingDate='+meetingDate+'&startTime='+startTime+'&endTime='+endTime;
         openWin({url:url,width:560,height:250,winName:'finishboardRoomApply'});
    }
     function delBoardRoomApply(boardroomApplyId,boardroomId,beginTime,endTime,boardRoomName,destineDate,motif,emcee,attendeeEmpId,nonvotingEmpId,attendeeLeaderId,meetingTimeId){
          $.dialog.confirm("确实要取消这次申请吗？", function(){delBoardRoomApply1(boardroomApplyId,boardroomId,beginTime,endTime,boardRoomName,destineDate,motif,emcee,attendeeEmpId,nonvotingEmpId,attendeeLeaderId,meetingTimeId)});
    }
    function delBoardRoomApply1(boardroomApplyId,boardroomId,beginTime,endTime,boardRoomName,destineDate,motif,emcee,attendeeEmpId,nonvotingEmpId,attendeeLeaderId,meetingTimeId){
        var urlWithData='${ctx}/boardRoom!delMyBoardroomApply.action?boardroomApplyId='+boardroomApplyId+'&boardroomId='+boardroomId+'&beginTime='+beginTime+'&endTime='+endTime
            +'&boardRoomName='+encodeURIComponent(boardRoomName)+'&destineDate='+destineDate+'&motif='+encodeURIComponent(motif)+'&emcee='+emcee
            +'&attendeeEmpId='+attendeeEmpId+'&nonvotingEmpId='+nonvotingEmpId+'&attendeeLeaderId='+attendeeLeaderId+'&meetingTimeId='+meetingTimeId;
        var paramers={urlWithData:urlWithData,tip:'',isconfirm:false,formId:'queryForm',callbackfunction:null};
        ajaxOperate(paramers);
    }
	//自定义查看栏内容
	function showMotif(po,i){ 
		var html = '';
		var isNewOrOld=po.isNewOrOld;
		var directlyPublish = po.directlyPublish;
		var formCode = po.formCode; 
		 
		if(directlyPublish=="1"){//直接发布    
			if(formCode==""){
			    html='<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/boardRoom!selectBoardroomApplyView.action?boardroomApplyId='+po.boardroomApplyId+'&p_wf_recordId='+po.boardroomApplyId+'&p_wf_moduleId=15&type=view&p_wf_openType=modifyView&meetingId='+po.meetingTimeId+'&boardroomName='+po.name+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'wiewMeeting\'});">关于召开'+po.motif+'的通知</a>';;
		    }else if(formCode!='meeting'){
				html='<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/newBoardRoom!readOldMeeting.action?directlyPublish=1&p_wf_recordId='+po.boardroomApplyId+'&title='+encodeURIComponent(po.motif)+'&p_wf_openType=modifyView&p_wf_moduleId=15'+'&isView=true&executeStatus=true&fromAdr=userList&meetingId='+po.meetingTimeId+'\',width:'+(screen.width)+',height:'+(screen.height)+',isFull:true,winName:\'viewOldMotif\'});">'+po.motif+'</a>';
			}else{
				html='<a href="javascript:void(0)" style="cursor:text;">'+po.motif+'</a>';
			}
		}else if(isNewOrOld == '15'){
			html='<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/bpmopen!updateProcess.action?p_wf_recordId='+po.boardroomApplyId+'&p_wf_openType=modifyView&p_wf_moduleId=15'+'&isView=true&executeStatus=true&fromAdr=userList&meetingId='+po.meetingTimeId+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'viewMotif\'});">'+po.motif+'</a>';
		}else{
			html='<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/boardRoom!selectBoardroomApplyView.action?boardroomApplyId='+po.boardroomApplyId+'&boardroomName='+po.name+'&meetingId='+po.meetingTimeId+'&p_wf_recordId='+po.boardroomApplyId+'&p_wf_moduleId=15&p_wf_openType=modifyView&type=view&isView=true&executeStatus=true&fromAdr=userList'+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'viewMotif\'});">'+po.motif+'</a>';
		}
		return html;
	}
	 function showTime(po,i){
        var html="";
        var meetingDate=po.meetingDate;
		html=meetingDate.substring(0,10)+meetingDate.substring(10,meetingDate.length);
		return html;
	 }
    function showStatus(po,i){
        var html="";
         var meetingTimeStatus=po.meetingTimeStatus;
         var status=po.status;
         var meetingTimeType=po.meetingTimeType;
         if(meetingTimeType==null || meetingTimeType=='null'){
             meetingTimeType='';
         }
         var compareToStime=Number(po.compareToStime);
         var compareToEtime=Number(po.compareToEtime);
        if(status =="-2" || status =="3"){
            html="退回";
        }else if(status =="-1" || meetingTimeType =="1"){
            html="取消";
        }else if(meetingTimeStatus =="1"){
            html="结束";
        }else{
            if(compareToStime >= 0 && compareToEtime >=0){
                html="进行中";
            }else if(compareToEtime <0){
                html="结束";
            }else{
                html="已预订";
            }
            
        }
		return html;
	}

	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sh(){
        var val='';
        if($("#searchDatecheckbox").attr("checked")=="checked"){
			var beginDate=$("#searchStartDate").val();
			var endDate=$("#searchEndDate").val();
			if(compareTwoDate(beginDate, endDate) == '>'){
                val='1';
                whir_alert("结束日期必须在开始日期之后！",null,null);
                return;
            }
	    }
        if(val ==''){
		    refreshListForm('queryForm');
        }
	}
    function export2Excel(){
	    var url = "${ctx}/boardRoom!exportExcel.action?searchBoardRomeName="+$("#searchBoardRomeName").val()+"&searchBoardRomeEmcee="+$("#searchBoardRomeEmcee").val()+"&searchBoardRomeMotif="+$("#searchBoardRomeMotif").val()+"&searchApplyName="+$("#searchApplyName").val()+"&boardroomApplyType="+$("#boardroomApplyType").val()+"&searchStartDate="+$("#searchStartDate").val()+"&searchEndDate="+$("#searchEndDate").val()+"&manageOrgName="+$("#manageOrgName").val()+"&applyOrgName="+$("#applyOrgName").val();
        if($("#searchFBRQ").attr("checked")=="checked"){
            url += "&searchDatecheckbox=1";
        }
	    commonExportExcel({formId:'queryForm',action:url});
}
   </script>

</html>

