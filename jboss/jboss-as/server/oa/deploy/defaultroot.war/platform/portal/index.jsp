<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("userName")!=null){
    String layoutId = request.getParameter("layoutId");
    String portletSettingId = request.getParameter("portletSettingId");
    session.setAttribute("layoutId", layoutId);
    session.setAttribute("portletSettingId", portletSettingId);
%>
<script language="JavaScript">
<!--
window.location.href="<%=request.getContextPath()%>/desktop.jsp";
//-->
</script>
<%
}
%>