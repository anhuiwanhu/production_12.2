<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<%
   String govFormType=request.getParameter("govFormType")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("govFormType").toString());
   if(null!= govFormType && !"".equals(govFormType) && !"null".equals(govFormType)){
		govFormType = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(govFormType);
   }
   
   String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=Resource.getValue(local,"Gov","gov.bdlb")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
 
<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="%{#ctx}/GovCustom!formListData.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
       
         <tr>
            <td class="whir_td_searchtitle2" nowrap><%=Resource.getValue(local,"Gov","gov.formname")%>：</td>
            <td class="whir_td_searchinput2">
            	  <s:textfield id="govFormName" name="govFormName" cssClass="inputText" />
	        </td>
            <td class="SearchBar_toolbar">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<%=Resource.getValue(local,"common","comm.searchnow")%>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="<%=Resource.getValue(local,"common","comm.clear")%>" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td align="right">
			   <!-- <input name="" type="button" value="设置字段" class="btnButton4font" onclick="updateField()"/>-->
			   <input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/GovCustom!addForm.action?govFormType=<%=govFormType%>',isFull:true,winName:'addForm'});" value="<%=Resource.getValue(local,"common","comm.add")%>" />
			   <input type="button" class="btnButton4font" onclick="copyform();" value="复制表单" />

			   <input  name="govFormType" type="hidden" value="<%=govFormType%>" />

	        </td>
	    </tr>
	</table>
	
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>
			<td whir-options="field:'govFormName',width:'40%'"><%=Resource.getValue(local,"Gov","gov.formname")%></td> 
			<td whir-options="field:'id',width:'25%',renderer:showTemplate"><%=Resource.getValue(local,"Gov","gov.xsmb")%></td> 
			<td whir-options="field:'id', width:'25%',renderer:printTemplate"><%=Resource.getValue(local,"Gov","gov.dymb")%></td> 
			<td whir-options="field:'transactStatus',width:'8%',renderer:myOperate"><%=Resource.getValue(local,"common","comm.opr")%></td> 
        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
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
	
	

	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
		var html ;
		if(po.sex==0){
			html = "男";
		}else{
			html = "女";
		}
		return html;
	}

	function downloadLink(po,i){
		return "<a href='alert(\""+po.gridId+"\")' ><%=Resource.getValue(local,"Gov","gov.xzzw")%></a>";
	}

	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd hh:mm:ss");
	}

	//自定义操作栏内容
	function myOperate(po,i){

		//alert('GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'/defaultroot/GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id+'\',width:820,height:550,isFull:true,winName:\'modifyUser\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" alt="<%=Resource.getValue(local,"common","comm.supdate")%>" title="<%=Resource.getValue(local,"common","comm.supdate")%>" ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'/defaultroot/GovCustom!delForm.action?govFormId='+ po.govFormId+'&id='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" alt="<%=Resource.getValue(local,"common","comm.sdel")%>" title="<%=Resource.getValue(local,"common","comm.sdel")%>" ></a>';
		return html;
	}

	//显示模版
	function showTemplate(po,i){
		//alert('GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'/defaultroot/GovCustom!loadForm.action?gffType=0&govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id+'\',isFull:true,width:820,height:550,winName:\'modifyUser\'});"><%=Resource.getValue(local,"Gov","gov.xsmb")%></a>';
		return html;
	}

	//打印模版
	function printTemplate(po,i){
		//alert('GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'/defaultroot/GovCustom!loadForm.action?gffType=1&govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id+'\',isFull:true,width:820,height:550,winName:\'modifyUser\'});"><%=Resource.getValue(local,"Gov","gov.dymb")%></a>';
		return html;
	}
	
	function updateField(){
		var hhref = "/defaultroot/GovCustom!loadAllowField.action?action=loadAllowField&govFormType=<%=govFormType%>";
		openWin({url:hhref,isFull:false,width:560,height:400,isScroll: 'yes', isResizable: 'yes',winName:'updateFieldWin'});
	}
	function copyform(){
        var  formIDStr = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'id'});
        if(formIDStr == ''){
            whir_alert('请选择要复制的表单！', null);
            return;
        }
        $.post("/defaultroot/GovCustom!saveCustomFormCopy.action",{
            formIDStr:formIDStr
        },function(data){
             var dataTemp=eval("("+data+")");
             if(dataTemp.result=="success"){
                 whir_alert("复制表单成功！",function(){
                     $('#queryForm').submit();
                 });

             }else{
                 whir_alert("复制表单失败！");
             }
        });
    }
	
   </script>

</html>


