<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%
String localeCode=request.getParameter("localeCode");
if(localeCode==null){
   localeCode="zh_cn";
   Cookie[] cookies = request.getCookies();
   if(cookies!=null){
      for (int i = 0; i < cookies.length; i++){
          Cookie c = cookies[i];

          if(c.getName().equalsIgnoreCase("LocLan")){
              localeCode= c.getValue();
          }
       }
   }
}
String localpath = session.getServletContext().getRealPath("upload");
String skin = request.getParameter("skin")!=null?request.getParameter("skin"):"";
String domainId = "0";
int inputPwdErrorNum = Integer.parseInt(request.getAttribute("inputPwdErrorNum")!=null?(String)request.getAttribute("inputPwdErrorNum"):"0");
int inputPwdErrorNumMax = Integer.parseInt(request.getAttribute("inputPwdErrorNumMax")!=null?(String)request.getAttribute("inputPwdErrorNumMax"):"6");
String userAccount = (String)request.getAttribute("userAccount")!=null ? (String)request.getAttribute("userAccount") : "";
PortalLayoutBD bd = new PortalLayoutBD();
String[][] layoutPO = null;
String portalId = "";
String title = "";//标题

String _preview_ = request.getParameter("preview")!=null?com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("preview")):"";
if("1".equals(_preview_)){//预览用
    
    layoutPO = bd.loadLayout(request.getParameter("layoutId"));
    //title = "预览-";
}else{//登录前用
    
    if(request.getParameter("layoutId")!=null&&!"".equals(request.getParameter("layoutId"))&&!"null".equals(request.getParameter("layoutId"))){
        layoutPO = bd.loadLayout(request.getParameter("layoutId"));
    }else{
        layoutPO = bd.getEnabledPortalLayout(domainId);
    }
}

if(layoutPO==null||layoutPO.length<1){//登录页
    
    response.sendRedirect(rootPath+"/login.jsp");
}else{
    title += layoutPO[0][1];
    String layoutId = layoutPO[0][0];
    String templateId = layoutPO[0][4];
	String themeId = layoutPO[0][9]!=null&&!layoutPO[0][9].equals("")?layoutPO[0][9]:"0";
	String headerId = layoutPO[0][2];
    String footerId = layoutPO[0][3];

	PortalBD portalBD = new PortalBD();
	if(!skin.equals("")){//切换主题时
		
        themeId = portalBD.getThemeIdBySkin(skin);
	}
	
	if(themeId!=null && !"0".equals(themeId)){
		String hfId = portalBD.getHeaderFooterByThemeId(themeId);
		headerId = hfId.substring(0,hfId.indexOf(","));
		footerId = hfId.substring(hfId.indexOf(",")+1);
	}
    
    PortalTemplatePO templatePO = new PortalTemplateBD().load(new Long(templateId));
    String solutionId = layoutPO[0][7]!=null?layoutPO[0][7]:"";
    String screenWidth = layoutPO[0][5];
    String w1 = "";
    String w2 = "";
    if(screenWidth!=null){
        if(!"-1".equals(screenWidth)){
            try{
                w1 = screenWidth + "px";
                w2 = (Integer.parseInt(screenWidth) - 8) + "px";//23
            }catch(Exception e){
                w1 = "";
                w2 = "";
            }
        }
    }
	
	if(skin.equals("")){//默认主题
		
        PortalThemePO theme = portalBD.loadPortalThemePO(Long.valueOf(themeId));
		if(theme!=null){
			skin = "themes/login/"+theme.getSkinDir();
		}else{
			skin = "themes/login/blue";
		}
	}else{
		skin = "themes/login/"+skin;
	}
    //登录后门户预览
    String useMode = request.getParameter("useMode")!=null?request.getParameter("useMode"):"";
    //if(useMode.equals("1")){
    //   skin = "themes/login/blue";//whir_skin;
    //}
	String allSkinDir = portalBD.getAllThemeSkin();
	//20161012 -by jqq 新增扩展样式文件引入
	String cssFile = bd.getPortalCssFile(request.getParameter("layoutId"));
%>
<!--DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"-->  
<html lang="zh-cn" class="wh-gray-bg <%=whir_2016_skin_color%> <%=whir_2016_skin_styleColor%> <%=whir_pageFontSize_css%>">
<head>
    <title><%=title%></title>
    <%@ include file="/public/include/portal_base113.jsp"%>

    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/platform/portal/js/portlet.jsp?skin=<%=skin%>&layoutId=<%=layoutId%>&preview=<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(_preview_)%>&sec=<%=new com.whir.common.util.MD5().toMD5("net.whir"+layoutId)%>&rnd=<%=(new Date()).getTime()%>"></script>
    <script type="text/javascript" src="<%=rootPath%>/platform/portal/js/scriptloader.js"></script>
    <!--
	<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/common.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/colorpicker.js"></script>
	<script src="<%=rootPath%>/scripts/plugins/jquery/jquery.cookie.js" type="text/javascript"></script>
    -->
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.validation.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.application.js"></script>

<!--
<script type="text/javascript">
	var whirRootPath = "<%=rootPath%>";
	var preUrl = "<%=preUrl%>";
	var whir_browser = "<%=whir_browser%>"; 
	var whir_agent = "<%=whir_agent%>"; 
</script>
-->

<!--
<script src="<%=rootPath%>/scripts/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>


<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
-->
<link   href="<%=rootPath%>/themes/common/desktop.css" rel="stylesheet" type="text/css"/>
<!--link   href="<%=rootPath%>/<%=skin%>/portal/style.css" rel="stylesheet" type="text/css"/>
<link   href="<%=rootPath%>/<%=skin%>/portal/main.css" rel="stylesheet" type="text/css"/-->

<!--link   href="<%=rootPath%>/scripts/plugins/uniform/themes/default/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<script src="<%=rootPath%>/scripts/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script-->

<!--
<script src="<%=rootPath%>/scripts/main/whir.validation.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.application.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/main/whir.util.js" type="text/javascript"></script>
<script src="<%=rootPath%>/scripts/plugins/jquery/jquery.cookie.js" type="text/javascript"></script>
-->

<!--
<link href="<%=rootPath%>/<%=skin%>/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=rootPath%>/themes/login/style.css" rel="stylesheet" type="text/css" />
-->
<%if(whir_agent.indexOf("MSIE 7")>=0 || whir_agent.indexOf("MSIE 10")>=0 ){%>
<style >
    body{position:relative;}
</style>
<%}%>
<script language="JavaScript">
<!--
var _def_isDesignPage_ = false;
var _def_isPortalPage_ = true;
//-->
</script>

<!--
<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/jquery.jfeed.pack.js"></script>
<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/jquery.slideshow.lite-0.5.3.js"></script>
<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/portlet.jsp?skin=<%=skin%>&layoutId=<%=layoutId%>&preview=<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(_preview_)%>&sec=<%=new com.whir.common.util.MD5().toMD5("net.whir"+layoutId)%>&rnd=<%=(new Date()).getTime()%>"></script>
<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/scriptloader.js"></script>
<script type="text/javascript" src="<%=rootPath%>/platform/portal/js/common.js"></script>
-->

</head>
<body class="MainFrameBox">
<div align="center">
    <div style="width:<%=w1%>;height:100%;">
        <div style="width:<%=w2%>;" align="center">
            <jsp:include page="top.jsp" flush="true">
                <jsp:param name="id" value="<%=headerId%>"/>
				<jsp:param name="skins" value="<%=allSkinDir%>"/>
				<jsp:param name="skin" value="<%=skin%>"/>
                <jsp:param name="useMode" value="<%=useMode%>"/>
            </jsp:include>
        </div>
        
        <div style="background:;width:<%=w2%>;padding:0px 0 3px 0;" align="left">
            <jsp:include page="menu.jsp" flush="true">
                <jsp:param name="layoutId" value="<%=layoutId%>"/>
                <jsp:param name="solutionId" value="<%=solutionId%>"/>
                <jsp:param name="skin" value="<%=skin%>"/>
            </jsp:include>
        </div>
        
        <div id="mainLayout" style="height:100%;" class="wh-container wh-portaler">
            <%=templatePO.getContent()%>
        </div>

        <div style="width:<%=w2%>;" align="left">
            <jsp:include page="bottom.jsp" flush="true">
                <jsp:param name="id" value="<%=footerId%>"/>
            </jsp:include>
        </div>
    </div>
</div>
</body>
</html>
<script language="JavaScript">
<!--
$(function(){
<%
String errorType=(String)request.getAttribute("errorType");
if("noDog".equals(errorType)){%>
 //whir_alert("<%=Resource.getValue(localeCode,"common","comm.noDog")%>",null);
 setTimeout(function(){whir_confirm("<%=Resource.getValue(localeCode,"common","comm.noDog")%>",function after(){$("#userPassword").val("");$("#remember").attr("checked", false);window.location.href="#LogonForm";},null);},500);
<%}else if("active".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.active")%>",null);
<%}else if("sleep".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.userIsSleep")%>",null);
<%}else if("captchaWrong".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrong")%>",null);
	setTimeout(function(){whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrong")%>",function after(){$("#userPassword").val("");$("#remember").attr("checked", false);window.location.href="#LogonForm";},null);},500);
<%}else if("captchaWrongNull".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>",null);
	setTimeout(function(){whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>",function after(){$("#userPassword").val("");$("#remember").attr("checked", false);window.location.href="#LogonForm";},null);},500);
<%}else if("ip".equals(errorType)){
    String addr=request.getRemoteAddr();
    addr=addr==null?"":"("+addr+")";
%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind1")%>",null);
<%}else if("password".equals(errorType) && !("admin".equals(userAccount) || "security".equals(userAccount))){%>
	setTimeout(function(){whir_confirm("<%=Resource.getValue(localeCode,"common","comm.loginremind31")%><%=inputPwdErrorNumMax-inputPwdErrorNum%><%=Resource.getValue(localeCode,"common","comm.loginremind32")%>",function after(){window.location.href="#LogonForm";},null);},500);
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind3")%>",null);
    //document.LogonForm.userPassword.select();
<%}else if("password".equals(errorType) && ("admin".equals(userAccount) || "security".equals(userAccount))){%>
	setTimeout(function(){whir_confirm("<%=Resource.getValue(localeCode,"common","comm.loginremind3")%>",function after(){window.location.href="#LogonForm";},null);},500);
<%}else if("user".equals(errorType)){%>
    setTimeout(function(){whir_confirm("<%=Resource.getValue(localeCode,"common","comm.loginremind2")%>",function after(){$("#userPassword").val("");$("#remember").attr("checked", false);window.location.href="#LogonForm";},null);},500);
    //document.LogonForm.userName.select();
<%}else if("online".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.online")%>",null);
<%}else if("domainError".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainerror")%>",null);
<%}else if("userNumError".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.usernumerror")%>",null);
<%}else if("forbidUser".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.active")%>",null);
<%}
errorType=request.getParameter("errorType");
if("overtime".equals(errorType)){%>
    alert("<%=Resource.getValue(localeCode,"common","comm.overtime")%>",null);
<%}else if("nokey".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.nokey")%>",null);
<%}else if("keyErr".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.keyerror")%>",null);
<%}else if("domainError".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainiderror")%>",null);
<%}else if("userNumError".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainerror")%>",null);
<%}else if("kickout".equals(errorType)){
    session.invalidate();
%>
    whir_alert("您的账号正在另一客户端登录！",null);
<%}%>

});

function changeTheme(skin){
	location_href('<%=rootPath%>/portal.jsp?skin='+skin);
}
//-------------------------------自定义模块 portal所需函数方法  start---------------------------//
//链接字段查看表单数据方法
function view(recordId,portletSettingId,hasNewForm,formId,menuId) {
	if(hasNewForm=="true"){
       viewnewform(recordId,portletSettingId,formId,menuId);
	}else{
		var flag = '1';
		var url = whirRootPath+"/CustomMantence!loadCustomMantenceV.action?flag=" + flag + "&formId=" + formId + "&recordId=" + recordId + "&menuId="+menuId+"&moduleType=customizeModi";
		//console.log('oldForm'+portletSettingId+'_'+recordId);
		openWin({url:url,isFull:'true',winName: 'oldForm'+portletSettingId+'_'+recordId });
	}
}
//新表单
function viewnewform(recordId,portletSettingId,formId,menuId) {
    var flag = '0';
	if(formId.indexOf("new$")!=-1)
        formId = formId.replace("new$","");

	var url = whirRootPath+"/EzFormMantence!loadCustomMantenceV.action?flag=" + flag + "&menuId="+menuId+"&formId="+formId+"&recordId="+recordId+"&moduleType=customizeModi";
	//console.log('oldForm'+portletSettingId+'_'+recordId);
	openWin({url:url,isFull:'true',winName: 'newForm'+portletSettingId+'_'+recordId });
}
//-------------------------------自定义模块 portal所需函数方法   end---------------------------//
//-->
</script>
<%}%>