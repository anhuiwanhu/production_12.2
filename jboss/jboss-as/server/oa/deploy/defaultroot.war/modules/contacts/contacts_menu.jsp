<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<%@ include file="/public/include/init.jsp"%>
  
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.org.bd.usermanager.UserBD"%>

<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB" %>

<%@ page import="com.whir.ezoffice.personalwork.person.bd.PersonOwnBD" %>

<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.i18n.Resource" %>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader ("Expires", 0);   
%>
<%
String expNodeCode=request.getParameter("expNodeCode");
expNodeCode="innerPersonList";
String domainId = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
String userId   = session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
String orgId   = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
String userAccount   = session.getAttribute("userAccount")==null?"":session.getAttribute("userAccount").toString();
if(!"".equals(userId)){
 int menuIndex = 0;  
 ManagerBD mBD = new ManagerBD();
 ManagerBD managerBD = new ManagerBD();
 CustomerMenuDB cmBD = new CustomerMenuDB();
    String codes = ",workmanager_setup,workmanager_setup_password,workmanager_setup_personalinfo,workmanager_setup_commonprocess,"+
                   "workmanager_setup_option,workmanager_setup_workproxy,workmanager_setup_skin,"+
                   "workmanager_setup_workstatus,workmanager_setup_orgwrap,workmanager_setup_rmlogin,"+
                   "workmanager_linkman,workmanager_linkman_inner,workmanager_linkman_public,workmanager_linkman_private,"+
                   "workmanager_calendar,workmanager_worklog,workmanager_workreport,workmanager_task,workmanager_personaltools,"+
                   "workmanager_netdisk,workmanager_filedealwith,workmanager_netdisk,workmanager_pressdeal,Persononduty,";
    String canShowMenus = cmBD.getShowMenu(codes, domainId);
    boolean flag=CommonUtils.isADCheckByUserAccount(userAccount);
    boolean authFlag0=cmBD.hasMenuAuth("workmanager_task",userId,orgId);
	  /* 公共/个人联系人 [BEGIN] */
    PersonOwnBD obd = new PersonOwnBD();
    long userIdm = Long.parseLong(String.valueOf(session.getAttribute("userId")));
    Vector vec = obd.see(userIdm + "", "1", domainId);
    List tList = (List)vec.get(1);
    Vector vec2 = obd.see(userIdm + "", "0", domainId);
    List pList = (List)vec2.get(1);
    /* 公共/个人联系人 [END] */	
	/*电话会议权限*/
	boolean isright=managerBD.hasRight(userId, "CF*01*01");
	/*电话会议权限*/
	
	boolean isRightVideoView=managerBD.hasRight(userId, "vCf*01*03");//视频会议查看权限 
	boolean isRightVideoSet=managerBD.hasRight(userId, "vCf*01*04");//视频会议设置权限 
	
	boolean isRightPersonSetup = managerBD.hasRight(userId, "08*03*02");//视频会议设置权限 
%>

<script>	
		
	  var zNodes =[
	  	
			// <!-- 联系人 [BEGIN] -->
        <%  
            boolean authFlag1=cmBD.hasMenuAuth("workmanager_linkman",userId,orgId);
          //  if(canShowMenus.indexOf("workmanager_linkman")!=-1 && authFlag1==true){
        
			if(1==1){
		%>
               
			  <%
                            boolean authFlag3=cmBD.hasMenuAuth("workmanager_linkman_inner",userId,orgId);
                          // if(canShowMenus.indexOf("workmanager_linkman_inner")>=0 && authFlag3==true){
							if(1==1){
						%>
			 {id:100000, expNodeCode:"innerPersonList", pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.innercontact")%>", target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/PersonInnerAction!innerPersonList.action?rightNeedDiv=1')"}
																		
			  <%
                                OrganizationBD oBD = new OrganizationBD();
                                java.util.List lists = oBD.getSimpleOrg(userId, domainId);

                                Object[] objj = null;
                                for(int jj = 0; jj < lists.size(); jj ++){
                                    objj = (Object[]) lists.get(jj);
                                    
                                    String sNodeId   = objj[0]==null?"":objj[0].toString();
                                    String sNodeName = objj[1]==null?"":objj[1].toString();
                                    String sNodePId  = objj[4]==null?"":objj[4].toString();
                                    String sNodeUrl  = rootPath + "/PersonInnerAction!innerPersonList.action?queryOrgIdStr=" + sNodeId+"&rightNeedDiv=1";
									if(false){
                                    if ("0".equals(sNodePId)) {
                                    %>
                                       ,{id:"aa-<%=sNodeId%>", pId:100000, name:"<%=sNodeName%>", url:"<%=sNodeUrl%>", target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=sNodeUrl%>')"}
                                    <%}else{%>
                                    ,{id:"aa-<%=sNodeId%>", pId:"aa-<%=sNodePId%>", name:"<%=sNodeName%>", url:"<%=sNodeUrl%>", target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=sNodeUrl%>')"}
                                    <%}}%>
                            <%
                                }
                            %>
                        <%
                            }
                        %>
                        <%  
                            boolean authFlag4=cmBD.hasMenuAuth("workmanager_linkman_public",userId,orgId);
							
							authFlag4=false;//公共联系人去除
                           // if(canShowMenus.indexOf("workmanager_linkman_public")>=0 && authFlag4==true){
							if(1!=1){
						%>
                                ,{id:1000002, iconSkin:"fa fa-cog fa",pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.pubcontact")%>", url:"<%=rootPath%>/PersonOwnAction!personList.action?classType=public", target:"mainFrame"}
                            <%
                                if(tList!=null&&tList.size()!=0){
                            %>
                                <%
                                    Object[] objj = null;
                                    for(int jj = 0; jj < tList.size(); jj ++){
                                        objj = (Object[]) tList.get(jj);
                                        
                                        String sNodeId   = objj[0]==null?"":objj[0].toString();
                                        String sNodeName = objj[1]==null?"":objj[1].toString();
                                        String sNodePId  = objj[3]==null?"":objj[3].toString();
                                        String sNodeUrl  = rootPath + "/PersonOwnAction!personList.action?classType=public&queryPersonClassId=" + sNodeId;
                                        if ("0".equals(sNodePId)) {
                                        %>
                                            ,{id:"bb-<%=sNodeId%>", pId:1000002, name:"<%=sNodeName%>", url:"<%=sNodeUrl%>", target:"mainFrame",iconSkin:"fa fa"}
                                       <% }else{%>
                                        ,{id:"bb-<%=sNodeId%>", pId:"bb-<%=sNodePId%>", name:"<%=sNodeName%>", url:"<%=sNodeUrl%>", target:"mainFrame",iconSkin:"fa fa"}
                            			<%}%>
                            <%

                                    }
                                }
                            %>
                        <%
                            }
                        %>
                        <%  
                            boolean authFlag5=cmBD.hasMenuAuth("workmanager_linkman_private",userId,orgId);
                            //if(canShowMenus.indexOf("workmanager_linkman_private")>=0 && authFlag5==true){
							if(1==1){
						%>
                                ,{id:1000003,iconSkin:"fa fa-cog fa", pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.percontact")%>",  target:"mainFrame", click:"menuJump('<%=rootPath%>/PersonOwnAction!personList.action?classType=private&rightNeedDiv=1')"}
                            <%
                                if(pList!=null&&pList.size()!=0){
                            %>
                                <%
                                    Object[] objj = null;
                                    for(int jj = 0; jj < pList.size(); jj ++){
                                        objj = (Object[]) pList.get(jj);
                                        
                                        String sNodeId   = objj[0]==null?"":objj[0].toString();
                                        String sNodeName = objj[1]==null?"":objj[1].toString();
                                        String sNodePId  = objj[3]==null?"":objj[3].toString();
                                        String sNodeUrl  = rootPath + "/PersonOwnAction!personList.action?classType=private&queryPersonClassId=" + sNodeId+"&rightNeedDiv=1";
                                        if ("0".equals(sNodePId)) {
                                    %>
                                           ,{id:"cc-<%=sNodeId%>", pId:1000003, name:"<%=sNodeName%>",  target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=sNodeUrl%>')"}
                                       <% }else{%>
                                        ,{id:"cc-<%=sNodeId%>", pId:"cc-<%=sNodePId%>", name:"<%=sNodeName%>",target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=sNodeUrl%>')"}
                            		<%}%>
                            <%

                                    }
                                }
                            %>
                        <%
                            }
                        %>
						<%if (isright){ %>
						 ,{id:10000000, pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.telecontets")%>",  target:"mainFrame",iconSkin:"fa fa",
						 click:"menuJump('<%=rootPath%>/TeleConferenceAction!teleConference_list.action?rightNeedDiv=1')"}
						<%}%>
						<%if (isRightVideoView){ %>
						 ,{id:10000100, pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.videocontets")%>", url:"", target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/videoConf!videoConfList.action?rightNeedDiv=1')"}
						<%}%>
						 ,{id:10000200, pId:-1, name:"<%=Resource.getValue(whir_locale, "common", "comm.message")%>", url:"", target:"mainFrame",iconSkin:"fa fa"}
								,{ id:100002001, pId:10000200, name:'收发信',  target:'mainFrame',iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/message!inboxList.action?rightNeedDiv=1')"}
								<% if(managerBD.hasRightTypeName(userId,"短信", "发送")){%>
								,{ id:100002002, pId:10000200, name:'<%=Resource.getValue(whir_locale, "message", "message.newmessage")%>',target:'mainFrame',url:'', click:"writeMessage_layer('<%=rootPath%>/message!messageWrite.action');",iconSkin:"fa fa"}
								,{ id:100002003, pId:10000200, name:'<%=Resource.getValue(whir_locale, "message", "message.draftbox")%>',  target:'mainFrame',iconSkin:"fa fa", click:"menuJump('<%=rootPath%>/message!draftsList.action?rightNeedDiv=1')"}
								<% if(false){%>
								,{ id:100002004, pId:10000200, name:'<%=Resource.getValue(whir_locale, "message", "message.outbox")%>',  target:'mainFrame',url:"<%=rootPath%>/message!outboxList.action",iconSkin:"fa fa"}
								<%
									}
								%>
								 ,{ id:100002005, pId:10000200, name:'已删除',  target:'mainFrame',iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/message!wasteboxList.action?rightNeedDiv=1')"}
								<%
									}
								%>
								
						 ,{id:1000001123, pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.customgroup")%>", click:"menuJump('<%=rootPath%>/Group!initList.action?groupType=1&rightNeedDiv=1')", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                           // if(isForbiddenPad && mBD.hasRight(userId,"00*01*01")){
                                // "联系人设置"栏目在IPAD上不显示
                                // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-12 
                        %>
						<%if(isRightPersonSetup||isright||isRightVideoSet||(isForbiddenPad && managerBD.hasRightTypeName(userId,"短信", "设置"))||managerBD.hasRightTypeName(userId,"短信", "统计")){%>
                                ,{id:1000004, pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personal.setting")%>", target:"mainFrame",iconSkin:"fa fa"}
								<%}%>
								<%if(isRightPersonSetup){%>
									,{id:10000041, pId:1000004, name:"浏览范围",  target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/PersonSetupAction!setupList.action?rightNeedDiv=1')"}
									<%} %>
									<%if (isright){ %>
									,{id:10000042, pId:1000004, name:"电话会议设置",  target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/TeleConferenceAction!teleConferenceSet.action?rightNeedDiv=1')"}
									,{id:10000043, pId:1000004, name:"电话会议统计", target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/TeleConferenceAction!teleConference_list.action?rightNeedDiv=1&Statistics=yes')"}
									<%} %>
									<%if (isRightVideoSet){ %>
									,{id:10000044, pId:1000004, name:"视频会议设置", url:"", target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/videoConf!videoConfSet.action?rightNeedDiv=1')"}
									<%}%>
									<% if(isForbiddenPad && managerBD.hasRightTypeName(userId,"短信", "设置")){%>
									,{id:10000045, pId:1000004, name:'<%=Resource.getValue(whir_locale, "message", "message.setup")%>',target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/messageSetting!messageSettingList.action?rightNeedDiv=1')"}	
									<%}%>
									<% if(managerBD.hasRightTypeName(userId,"短信", "统计")){%>
									,{id:10000046, pId:1000004, name:"<%=Resource.getValue(whir_locale, "message", "message.statistics")%>",target:"mainFrame",iconSkin:"fa fa",click:"menuJump('<%=rootPath%>/message!countList.action?rightNeedDiv=1')"}
											<%if(false){%>
											,{ id:1000020081, pId:10000046, name:"按发送人统计",url:"<%=rootPath%>/message!countList.action",iconSkin:"fa fa",target:"mainFrame"}
											,{ id:1000020082, pId:10000046, name:"按组织统计",url:"<%=rootPath%>/message!countList1.action",iconSkin:"fa fa",target:"mainFrame"}
											<%}%>
									<%}%>			
                        <%
                            //}
                        %>
				 <%
            }
        %>
       // <!-- 联系人 [END] -->
			
					 
		   ];
		 
         function whir_initMenu(){
				 $.fn.zTree.init($("#treeDemo"), setting, zNodes);
				 $(function(){
					
					 if('<%=expNodeCode%>'=="innerPersonList"){
						OpenSubMenu('innerPersonList');
					}
					
				});
		 }
	</script>
	 <div class="wh-l-msg">
                                    <a  class="clearfix">
                                        <i class="fa fa-folder-open fa-color"></i>
                                        <span>
                                            <%=Resource.getValue(whir_locale, "common", "comm.contacts_menu")%>
                                           
                                        </span>
                                    </a>
                                </div>
                                <div class="wh-l-con">
                                    <ul id="treeDemo" class="ztree"></ul>
                                </div>
 <%}%> 
 <script>
	function writeMessage_layer(url){
		layer.open({
          type: 2,
          title: '写短信',
          shadeClose: false,
          //shade: 0.8,
          area: ['1020px', '600px'],
	      content:url
        }); 
	}
 </script>