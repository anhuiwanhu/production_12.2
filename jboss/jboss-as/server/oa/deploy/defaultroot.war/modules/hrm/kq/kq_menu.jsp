<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.booksmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.workflow.vo.*" %>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD" %>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD" %>
<%@ page import="com.whir.ezoffice.officemanager.bd.EmployeeBD" %>
<%   
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    com.whir.org.manager.bd.ManagerBD mbd = new com.whir.org.manager.bd.ManagerBD();
    String portletSettingId = request.getParameter("portletSettingId");
    String expNodeCode = request.getParameter("expNodeCode");
String userId = session.getAttribute("userId").toString();
String domainId = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
CustomerMenuDB cmdb=new CustomerMenuDB();
String codes=",personnelManagement_humanresouce,personnelManagement_cardmanager,personnelManagement_examination,personnelManagement_wageManager,personnelManagement_sbgjj,personnelManagement_performanceManager,personnelManagement_kqgl,newKq";
String canShowMenus=cmdb.getShowMenu(codes,domainId);
System.out.print("======================"+canShowMenus);
ManagerBD managerBD = new ManagerBD();
int menuIndex=0;
%>  

<SCRIPT type="text/javascript">     
                var zNodes =[   
				<%menuIndex++;%>
                    <%
						//考勤管理-维护
						boolean hr_kq_right1 = managerBD.hasRight(userId, "KQ*01*01");
						//考勤管理-设置
						boolean hr_kq_right2 = managerBD.hasRight(userId, "KQ*01*02");
						if( hr_kq_right1 || hr_kq_right2){
						
					%>
						
						<%if(hr_kq_right1){%>	
	                    { id:1900000000, pId:-1, name:"考勤数据导入", click:"menuJump('<%=rootPath%>/kqrecordimp!kqrecordimp_list.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2100000000, pId:-1, name:"考勤记录", click:"menuJump('<%=rootPath%>/kqrecord!kqrecord_list.action?rightNeedDiv=1')",target:'mainFrame',iconSkin:"fa fa"}   
	                    ,{ id:2200000000, pId:-1, name:"考勤统计", target:'mainFrame',iconSkin:"fa fa"}  
	                    	,{ id:2210000000, pId:2200000000, name:"查看", click:"menuJump('<%=rootPath%>/kqrecord!kqrecord_statistics_query.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"} 
	                    	,{ id:2220000000, pId:2200000000, name:"导入", click:"menuJump('<%=rootPath%>/kqimp!kqrecordimp_list.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"}  
	                    <%}%>
       					<%if(hr_kq_right2){%>
	                    ,{ id:2300000000, pId:-1, name:"设置", target:'mainFrame',iconSkin:"fa fa"} 
	                    	,{ id:2310000000, pId:2300000000, name:"考勤人员", click:"menuJump('<%=rootPath%>/kquser!kquser_list.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:2320000000, pId:2300000000, name:"特殊考勤", click:"menuJump('<%=rootPath%>/kqspeuser!kqspeuser_list.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"}
	                    	,{ id:4330000000, pId:2300000000, name:"请假类别", click:"menuJump('<%=rootPath%>/kqleavetype!kqleavetype_list.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"}
							,{ id:2340000000, pId:2300000000, name:"冲销时限", click:"menuJump('<%=rootPath%>/kqrecordimp!setpaidleave.action')", target:'mainFrame',iconSkin:"fa fa"}
							,{ id:2350000000, pId:2300000000, name:"移动考勤策略", click:"menuJump('<%=rootPath%>/kqrule!kqrule_list.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"}
	                    <%}%>
                   	<%}%>   
			<%menuIndex++;%>		
          <%
            String menutype = "newKq";
         %>
        <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
        
                ];   
            
 function whir_initMenu(){
    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
}     
</SCRIPT>   
<div class="wh-l-msg">
    <a href="javascript:void(0)" class="clearfix" style="cursor:default">
        <i class="fa fa-cog fa-color fa-user"></i>
	        <span>
	            	考勤
	        </span>
    </a>
</div>
<div class="wh-l-con">
    <ul id="treeDemo" class="ztree"></ul>
</div>  

