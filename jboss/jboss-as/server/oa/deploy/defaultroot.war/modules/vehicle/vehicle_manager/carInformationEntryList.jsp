<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
	com.whir.org.manager.bd.ManagerBD  managerBD = new com.whir.org.manager.bd.ManagerBD ();
	//当前人的userId 
	String userId = session.getAttribute("userId").toString();
	//当前人orgId
	String orgId = session.getAttribute("orgId").toString();
	//修改权限
	//boolean isModifyRight = managerBD.hasRight(userId, "vehicle*99*11") ; 
	//录入权限
	//boolean isAddRight = managerBD.hasRight(userId, "vehicle*99*19") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>用车登记</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/vehicle!carInformationEntryList.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
		<tr>
			<td class="whir_td_searchtitle">车型：</td>
			<td class="whir_td_searchinput">
				<s:textfield id="carType" name="carType" size="16" cssClass="inputText" />
			</td>
			<td class="whir_td_searchtitle">车牌号：</td>
			<td class="whir_td_searchinput">
				<s:textfield id="plateNumber" name="plateNumber" size="16" cssClass="inputText" />
			</td>
			<td class="whir_td_searchtitle"></td>
			<td class="whir_td_searchinput">
			</td>
		</tr>
		<tr>
			<td  class="whir_td_searchtitle">用车时间：</td>
			<td class="whir_td_searchinput" colspan=4>
               <input type="text" name="sqStartDate" id="sqStartDate" class="Wdate whir_datebox"        
					value='<s:date name="sqStartDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'sqEndDate\',{d:0});}'})" />
					
			 至 
            <input type="text" name="sqEndDate" id="sqEndDate" class="Wdate whir_datebox"        
					value='<s:date name="sqEndDate" format="yyyy-MM-dd"/>' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'sqStartDate\',{d:0});}'})" />
					  
			</td>
			<td class="SearchBar_toolbar" >
				<input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
				<!--resetForm(obj)为公共方法-->
				<input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />      
			</td>
		</tr>
</table>
	<!-- SEARCH PART END -->
    

	<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="right" width="55%">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">             
                <input type="button" class="btnButton4font" onClick="excelExport();" value='<s:text name="comm.export" />' />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
          <!--  <td whir-options="field:'illegalId',width:'2%',checkbox:true"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('illegalId',this.checked);" ></td>
			
			--><td whir-options="field:'startDate', width:'28%',renderer:yjdate">用车时间</td> 
			<td whir-options="field:'carType', width:'11%'">车型</td> 
            <td whir-options="field:'plateNumber', width:'15%'">车牌号</td>
            <td whir-options="field:'driverName',width:'11%'">司机</td> 
			<td whir-options="field:'carCategory', width:'10%'">类别</td>
            <td whir-options="field:'userName', width:'10%'">使用人</td>
            <td whir-options="field:'passengersNum', width:'5%'">跟车人数</td>
			<td whir-options="field:'endAddress',width:'10%'">目的地</td>
			<td whir-options="field:'weihu',width:'3%',renderer:myOperate">操作</td>
            
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
        var html ='';
		var inputStatus = po.inputStatus; 
		var carId = po.carId;
		var weihu = po.weihu;
		//录入数据权限判断
		switch(po.luRu){
			case "0":
					html += luRuStyle(po,html);
					
					break;//全部组织
			case "2":
					if (po.higherOrg.indexOf("$"+"<%=orgId%>"+"$")>-1){
						html += luRuStyle(po,html);
					}
					
					break;//本组织及下属组织
			case "3":
					if (po.foundOrgId == "<%=orgId%>"){
						html += luRuStyle(po,html);
					}
					
					break;//本组织
			case "1":
					if (po.founderId == "<%=userId%>"){
						html += luRuStyle(po,html);
					}
					
					break;//本人
		}
		//修改数据权限判断
		switch(po.xiuGai){
			case "0":
					html = xiuGaiStyle(po,html);
					
					break;//全部组织
			case "2":
					if (po.higherOrg.indexOf("$"+"<%=orgId%>"+"$")>-1){
						html = xiuGaiStyle(po,html);
					}
					
					break;//本组织及下属组织
			case "3":
					if (po.foundOrgId == "<%=orgId%>"){
						html = xiuGaiStyle(po,html);
					}
					
					break;//本组织
			case "1":
					if (po.founderId == "<%=userId%>"){
						html = xiuGaiStyle(po,html);
					}
					
					break;//本人
		}
		
		
		return html;
	}
	function luRuStyle(po,html){
		if(po.inputStatus==0 ){//没有录入,进入录入页面
			html+= '<img title="录入" style="cursor:hand" border="0" src="<%=rootPath%>/images/sq.gif" onClick="openWin({url:\'${ctx}/vehicle!addCarInformationEntry.action?applyId='+po.applyId+'&verifyCode='+po.verifyCode+'\',width:850,height:700,winName:\'addInformation\'});">';
		}else{
			html+= '<img title="录入" style="cursor:hand" border="0" src="<%=rootPath%>/images/sq.gif" onClick="openWin({url:\'${ctx}/vehicle!modifyCarInformationEntryAndTime.action?carScheduleId='+po.carSchedulingId+'&verifyCode='+po.verifyCode+'\',width:850,height:700,winName:\'addInformation\'});">';
		}
		return html;
		
	}
	
	function xiuGaiStyle(po,html){
		if(po.inputStatus==0 ){//没有录入,进入录入页面
				html+= '<img title="修改" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/vehicle!addCarInformationEntry.action?applyId='+po.applyId+'&verifyCode='+po.verifyCode+'\',width:850,height:700,winName:\'addInformation\'});">';
		}else{//已经录入,进入修改页面
				html+= '<img title="修改" style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" onClick="openWin({url:\'${ctx}/vehicle!modifyCarInformationEntryAndTime.action?carScheduleId='+po.carSchedulingId+'&verifyCode='+po.verifyCode+'\',width:850,height:700,winName:\'addInformation\'});">';
		}
		return html;
	}

	
	 

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	
	
	function yjdate(po,i){
		html = '';
		var startDate = po.startDate.substring(0,11);
		var startHour = parseInt(po.startTime/3600);
		if(startHour < 10){
			startHour = "0"+startHour;
		}
		var startMinute = parseInt((Number(po.startTime) - startHour*3600)/60);
		if(startMinute <10){
			startMinute = "0"+startMinute;
		}
		
		var endDate = po.endDate.substring(0,11);
		var endHour =  parseInt(po.endTime/3600);
		if(endHour < 10){
			endHour = "0"+endHour;
		}
		var endMinute =  parseInt((Number(po.endTime) - endHour*3600)/60);
		if(endMinute < 10){
			endMinute = "0"+endMinute;
		}
		var date = startDate +" "+ startHour +":"+startMinute +"至"+ endDate +" "+ endHour +":"+endMinute;
		
		
		var carScheduleId = po.carSchedulingId;
    	html ='<a href="javascript:void(0)" onclick="checkInformation('+carScheduleId+');">'+date+'</a>';
		return html;
	}
	
	function checkInformation(id){
	
		$.ajax({
		type: "POST",
		url:"<%=rootPath%>/vehicle!checkInformation.action",
		async: false,
		data:{ "carScheduleId":id},
		dataType: "text",
		success:function(responseText){
			//alert(responseText)
			var param = eval("("+responseText+")");
			var result = param.result;
			if(result=='fail'){
				whir_alert(param.data.rst);
			}else{
				
				openWin({url:'<%=rootPath%>/vehicle!viewCarInformationEntryAndTime.action?carScheduleId='+id,width:850,height:700,winName:'viewCarInformation'});
			}
		},
		error:function(XMLHttpRequest,textStatus,errorThrown){
			whir_alert('网络出错');
			return false;
		}
	});
	}
    //导出
	function excelExport() {
	    commonExportExcel({formId:'queryForm', action:'vehicle!informationExport.action'});
	}
	
   </script>

</html>

