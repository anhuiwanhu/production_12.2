<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.whir.i18n.Resource"%>
<%@ include file="/public/include/init.jsp"%> 
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=Resource.getValue(local,"workflow","workflow.setTransitionname")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	      <form name="dataForm" id="dataForm" action="ezflowbutton!saveButton.action" method="post" theme="simple" >  
			<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
				<tr>  
					<td for='名字' width="100" class="td_lefttitle">  
						名字<span class="MustFillColor">*</span>：  
					</td>  
					<td>  
						 <input type="text" name="name"  id="name"  class="inputText" style="width:98%" value="" 
					   whir-options="vtype:[{'maxLength':20}]" > 
					</td>  
				</tr> 
				<tr>  
					<td for='排序码' width="100" class="td_lefttitle">  
						排序码<span class="MustFillColor">*</span>：  
					</td>  
					<td>  
						 <input type="text" name="sortNum"  id="sortNum"  class="inputText" style="width:98%" value="" 
					   whir-options="vtype:[{'maxLength':4},'p_integer']" >   
					</td>  
				</tr> 
				<tr class="Table_nobttomline">  
					<td > </td> 
					<td nowrap>  
						<input type="button" class="btnButton4font" onClick="save(0,this);" value='<%=Resource.getValue(local,"common","comm.saveclose")%>' />   
						<input type="button" class="btnButton4font" onClick="window.close();" value='<%=Resource.getValue(local,"common","comm.exit")%>' />  
					</td>  
				</tr>  
			</table>   
	      </form>
		</div>
	</div>
</body>
<script type="text/javascript">

//当前属性页面编辑的元素对象
		var model;
		//初始化属性
		function initData() {
            
			//初始化显示
			var id = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"id")%>";
			if(opener == null || opener.xiorkFlow == null || opener.xiorkFlow.xiorkFlowWrapper == null || opener.xiorkFlow.xiorkFlowWrapper.getModel() == null) {
				whir_alert("父页面或者流程已经不存在！",function(){});
				return;
			}
			var nms = opener.xiorkFlow.xiorkFlowWrapper.getModel().transitionModels;
			for( i = 0; i < nms.length; i++) {
				if(nms[i].getID() == id) {
					model = nms[i];
					break;
				}
			}
			if(model == null) {
				whir_alert("编辑的连接线已经不存在！",function(){});
				return;
			}

			//名称
			$("#name").attr("value", model.getText());

		    $("#sortNum").attr("defaultValue",model.getSortNum());
			$("#sortNum").val(model.getSortNum());
		} 

		initData();

		function save(type,obj){
			saveClose();
		}
		function saveClose(){ 
			 model.setSortNum($("#sortNum").val());  
			 model.setText($("#name").attr("value")); 
			 window.close();
		}
	 
</script>
</html>

