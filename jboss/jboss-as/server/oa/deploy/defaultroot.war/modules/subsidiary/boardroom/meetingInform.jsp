<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
	String type = request.getParameter("type");
	type=EncryptUtil.htmlcode(type);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>会议通知-今日或列表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/boardRoom!meetingInformView2.action" method="post" theme="simple">
    <input type="hidden" name="type" value="<%=type%>">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
<%if("list".equals(type)){%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
    <tr>
        <td class="whir_td_searchtitle">会议主题：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchMotif" name="searchMotif" size="16" cssClass="inputText" />
        </td>
        <td class="whir_td_searchtitle">会议室：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchBoardName" name="searchBoardName" size="16" cssClass="inputText" />
        </td>
        <td class="whir_td_searchtitle">位置：</td>
        <td class="whir_td_searchinput">
            <s:textfield id="searchBoardRomeLocation" name="searchBoardRomeLocation" size="16" cssClass="inputText" />
        </td>
    </tr>
    <tr>
        <td nowrap class="whir_td_searchtitle">时间范围：</td>
        <td class="whir_td_searchinput" colspan=4>
             <s:textfield id="searchStartDate" name="searchStartDate"  cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchEndDate\\',{d:0});}'})"/> 至 <s:textfield id="searchEndDate" name="searchEndDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchStartDate\\',{d:1});}'})"/>
                 
        </td>
        <td class="SearchBar_toolbar">
           <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />      
        </td>
    </tr>
</table>
<%}%>
	<!-- SEARCH PART END -->
    

    <div class="whir_public_movebg">
        <div class="Public_tag">
            <ul id="whir_tab_ul">
            <li id="li0" onClick="list0();" class="<%if("day".equals(type)){%>tag_aon<%}%>"  whir-options="{target:'tab0'}"><span class="tag_center">今日</span><span class="tag_right"></span></li>
            <li id="li1" onClick="list1();"class="<%if("week".equals(type)){%>tag_aon<%}%>"  whir-options="{target:'tab1'}"><span class="tag_center">本周</span><span class="tag_right"></span></li>
            <li id="li2" onClick="list2();" class="<%if("list".equals(type)){%>tag_aon<%}%>" whir-options="{target:'tab2'}"><span class="tag_center">列表</span><span class="tag_right"></span></li>
            </ul>
        </div>
    </div>

    <div class="whir_clear"></div>
    <div id="tab0" class="grayline">
        <!-- LIST TITLE PART START -->	
        <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
            <thead id="headerContainer">
            <tr class="listTableHead">
                <td whir-options="field:'motif',width:'35%',renderer:showMotif">会议主题</td> 
                <td whir-options="field:'name', width:'15%'">会议室</td> 
                <td whir-options="field:'location',width:'15%'">位置</td> 
                <td whir-options="field:'emceeName', width:'12%'">主持人</td>
                <td whir-options="field:'meetingDate', width:'15%',allowSort:true">时间</td>
				<td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
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
    </div>
	</s:form>
</body>
	<script type="text/javascript">

	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});
	});
	function myOperate(po,i){
		 var html =  '';
		 var isNewOrOld=po.isNewOrOld;
		 var isSwPerson=po.isSwPerson;
		 if(isSwPerson == 'yes'){
                html+='<img title="转批" style="cursor:hand" border="0" src="<%=rootPath%>/images/hyzp.png" onClick="openWin({url:\'<%=rootPath%>/modules/subsidiary/boardroom/selectWorkFlowSW.jsp?boardroomApplyId='+po.boardroomApplyId+'&boardroomName='+po.name+'&boardroomId='+po.boardroomId+'&moduleId=16&isNewOrOld='+isNewOrOld+'\',width:'+(560)+',height:'+(300)+',winName:\'zfWrokflow\'});">';
            }
		return html;
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
			var url='<%=rootPath%>/bpmopen!updateProcess.action?p_wf_recordId='+po.boardroomApplyId+'&p_wf_openType=modifyView&p_wf_moduleId=15';
			html='<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/bpmopen!updateProcess.action?p_wf_recordId='+po.boardroomApplyId+'&p_wf_openType=modifyView&p_wf_moduleId=15'+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'viewMotif\'});addBoardroomPersons('+po.boardroomApplyId+');">关于召开'+po.motif+'的通知</a>';
		}else{
			html='<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/boardRoom!selectBoardroomApplyView.action?boardroomApplyId='+po.boardroomApplyId+'&p_wf_recordId='+po.boardroomApplyId+'&p_wf_moduleId=15&type=view&p_wf_openType=modifyView&meetingId='+po.meetingTimeId+'&boardroomName='+po.name+'\',width:'+(screen.width)+',height:'+(screen.height)+',winName:\'wiewMeeting\'});">关于召开'+po.motif+'的通知</a>';;
		}
		return html;
	}
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	function addBoardroomPersons(boardroomApplyId){
		var data =ajaxForSync('boardRoom!addBoardroomPersons.action','boardroomApplyId='+boardroomApplyId);
	}
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
    function list0(){ 
		var url="<%=rootPath%>/boardRoom!meetingInformView.action?type=day";
        location_href(url);
	}
    function list1(){ 
		var url="<%=rootPath%>/boardRoom!meetingInformWeekView.action?type=week";
        location_href(url);
	}
    function list2(){ 
		var url="<%=rootPath%>/boardRoom!meetingInformView.action?type=list";
        location_href(url);
	}
	
   </script>

</html>

