<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

String userId = session.getAttribute("userId")==null?"null":session.getAttribute("userId").toString(); 

String channelName = request.getAttribute("channelName")!=null?request.getAttribute("channelName").toString():"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
        <title><%=channelName%></title>
        <%@ include file="/public/include/meta_base.jsp"%>
        <%@ include file="/public/include/meta_list.jsp"%>
        <link href="<%=rootPath%>/themes/portal/default/css/style.css" rel="stylesheet" type="text/css" />
        <script src="<%=rootPath%>//platform/portal/info/info_list_js.js" type="text/javascript"></script>

        <script language="javascript">
            var screenwidth;//分辨率宽度
            var screenheight;//分辨率高度
            screenwidth = screen.availWidth-5;
            screenheight = screen.availHeight-18;
        </script>
    </head>
<%
	//当前session页码
	int curPageSize = com.whir.common.util.CommonUtils.getSessionUserPageSize(request);  
	//页码集合
	String[] a = com.whir.common.util.CommonUtils.getSysPageSizeArray(request);  
%>
<body >
<div class="mainbox">
	<div class="main_nr">
		<div class="pos_bg">
			<dl>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="46%"><h1>您现在的位置：<a href="#"><%=channelName%> </a></h1></td>
					</tr>
				</table>
			</dl>
		</div>
		
		<s:form name="queryForm" id="queryForm" action="PortalInformation!getInformationList.action" method="post" theme="simple">
		
        <s:hidden name="channelId" id="channelId" value="%{channelId}" />  
		<input type="hidden" name="userId" id="userId" value="<%=userId %>" />    
		
		<%@ include file="/public/include/form_list.jsp"%>
		
		<div class="right_line">
			<div class="manu">
				<!-- PAGER START -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="" style="width:100%;">
					<tr>
						<td >
							<%@ include file="/platform/portal/info/pager_top.jsp"%>
						</td>
					</tr>
				</table>
				<!-- PAGER END -->
			</div>
			
			<div class="main_boder">   
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr valign="top">
						<td>
							<ul class="list_news" id="itemContainer">
							</ul>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="manu">
				<!-- PAGER START -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="" style="width:100%;">
					<tr>
						<td >
							<%@ include file="/platform/portal/info/pager_bottom.jsp"%>
						</td>
					</tr>
				</table>
				<!-- PAGER END -->
			</div>
		</div>
		</s:form>
		<div class="clear_1"></div>
	</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
    // 
    initPorteltInfoListFormToAjax({formId:"queryForm"});  
});
//-->
</script>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*$(parent.parent.document).find("#MainDesktop").load(function(){
    var main = $(parent.parent.document).find("#MainDesktop");
    var thisheight = $(document).height()+30;
    main.height(thisheight);
});*/

/**
$(parent.document).find("#divIfameId01").load(function(){
    var main = $(parent.document).find("#divIfameId01");
    var thisheight = $(document).find('.list_news').height()+210;
    main.height(thisheight);

    var main = $(parent.parent.document).find("#MainDesktop");
    //var thisheight = $(document).height()+50;
    if(main.height()<document.documentElement.scrollHeight){
        main.height(document.documentElement.scrollHeight);
    }
});
*/
//-->
</SCRIPT>