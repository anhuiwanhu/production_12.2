<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>

<% 
String range = (String)request.getAttribute("range");
String orgId = session.getAttribute("orgId").toString();
String init = "first";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>  
<title>当前用户</title>  
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
<%
whir_custom_str="My97DatePicker,easyui";
%>
<%@ include file="/public/include/meta_base.jsp"%>  
<%@ include file="/public/include/meta_list.jsp"%>  
<!--这里可以追加导入模块内私有的js文件或css文件-->
<%@ include file="/public/include/tree_simple.jsp"%>
<link   href="<%=rootPath%>/scripts/plugins/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
 
<SCRIPT LANGUAGE="JavaScript">

function changeBdColor(obj, bgColor, color){
    $(obj).css('background-color',bgColor).css('color',color);
}
//-->
</SCRIPT>
<style type="text/css">
div#rMenu {position:absolute; visibility:hidden; top:0; background-color: #80AFD7;text-align: left; width:100px; border-left:1px solid #80AFD7; border-right:1px solid #666666; border-top:1px solid #80AFD7; border-bottom:1px solid #666666; z-index: 100}
div#rMenu ul{list-style:none; margin:2px; padding:0px;}
div#rMenu ul li{
    margin: 0px ;
    cursor: pointer;
    display:inline;
    float:left;
    width:96%; 
    border-bottom:1px solid #ddd;
    padding:3px;
}
</style>
</head> 
<body class="MainFrameBox">

<table width="100%" border=0 cellpadding=0 cellspacing=0>
    <tr>
	<s:if test="status != 'apply'">
        <td valign=top style="padding-right:5px;">
		
            <div id="orgTree" style="width:250px;height:100%;overflow:auto;border:1px solid #E7E7E7;">
                <ul id="treeOrg" class="ztree"></ul>
                <SCRIPT type="text/javascript">
                        <!--
                        var settingOrg = {
                            view: {
                                showIcon: false,
                                dblClickExpand: false,
                                fontCss : {color:"#0055ad"}
                            },
                            async: {
                                enable: true,
                                url:"<%=rootPath%>/Organization!orgTree.action",
                                autoParam:["orgParentOrgId"],
                                otherParam:{"range":"<s:property value="#request.range"/>"}
                            },
                            callback: {
                                onExpand: onExpandOrg,
                                onRightClick: OnRightClick,
                                onClick: zTreeOnClick
                              //  onAsyncSuccess: zTreeOnAsyncSuccess
                            }
                        };
                       
                        
                      /*  function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
							   var treeObj = $.fn.zTree.getZTreeObj("treeOrg");
							var orgId = document.getElementById("orgId").value;
							var node = treeObj.getNodeByParam("id",orgId,null);
							//alert(node);
							treeObj.selectNode(node);
							};
						*/
						function zTreeOnClick(event, treeId, treeNode) {
								//getOrgList(treeNode.id);
								//传递参数orgId用于后台查询
								//alert(treeNode.id);
								document.getElementById("orgId").value=treeNode.id;
								document.getElementById("orgName1").value=treeNode.name;
								document.getElementById("init").value="notfirst";
								
								refreshListForm('queryForm');
    							//alert(treeNode.tId + ", " + treeNode.id);
						};
						
                        function onExpandOrg(event, treeId, treeNode) {
                            if(treeNode.children.length==0){
                                treeNode.isParent = false;
                                zTree.updateNode(treeNode);
                            }
                        };
                       
                        function OnRightClick(event, treeId, treeNode) {
                            var eventX_ = event.clientX + 10;
                            var eventY_ = event.clientY;
                            var offset_ = eventY_ + $(document).scrollTop();
                            
                            if($(window).outerHeight() - eventY_ < $("#rMenu").outerHeight()){
                                offset_ = offset_ - $("#rMenu").outerHeight();
                                
                            }

                            if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
                                zTree.cancelSelectedNode();
                                showRMenu("root", eventX_, offset_);
                            } else if (treeNode && !treeNode.noR) {
                                zTree.selectNode(treeNode);
                                showRMenu("node", eventX_, offset_);
                            }
                        }

                        function showRMenu(type, x, y) {
                            $("#rMenu ul").show();
                            if (type=="root") {
                                $("#m_modify").hide();
                                $("#m_del").hide();
                                $("#m_addSub").hide();
                                <%if("0".equals(range) || "*0*".equals(range)){%>
                                $("#m_add").show();
                                rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
                                <%}else{%>
                                $("#rMenu ul").hide();
                                <%}%>
                            } else {
                                $("#m_modify").show();
                                $("#m_del").show();
                                $("#m_addSub").show();
                                $("#m_add").hide();

                                rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
                            }
                            
                            //rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

                            $("body").bind("mousedown", onBodyMouseDown);
                        }

                        function hideRMenu() {
                            if (rMenu) rMenu.css({"visibility": "hidden"});
                            $("body").unbind("mousedown", onBodyMouseDown);
                        }

                        function onBodyMouseDown(event){
                            if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
                                rMenu.css({"visibility" : "hidden"});
                            }
                        }

                        var addCount = 1;
                        function addTreeNode() {
                            hideRMenu();
                            var newNode = { name:"增加" + (addCount++)};
                            if (zTree.getSelectedNodes()[0]) {
                                newNode.checked = zTree.getSelectedNodes()[0].checked;
                                zTree.addNodes(zTree.getSelectedNodes()[0], newNode);
                            } else {
                                zTree.addNodes(null, newNode);
                            }
                        }

                        function removeTreeNode() {
                            hideRMenu();
                            var nodes = zTree.getSelectedNodes();
                            if (nodes && nodes.length>0) {
                                if (nodes[0].children && nodes[0].children.length > 0) {
                                    var msg = "要删除的节点是父节点，如果删除将连同子节点一起删掉。\n\n请确认！";
                                    if (confirm(msg)==true){
                                        zTree.removeNode(nodes[0]);
                                    }
                                } else {
                                    zTree.removeNode(nodes[0]);
                                }
                            }
                        }

                        function checkTreeNode(checked) {
                            var nodes = zTree.getSelectedNodes();
                            if (nodes && nodes.length>0) {
                                zTree.checkNode(nodes[0], checked, true);
                            }
                            hideRMenu();
                        }

                        function modifyOrg(){
                            hideRMenu();
                            var nodes = zTree.getSelectedNodes();
                            if (nodes && nodes.length>0) {
                                var $this = $(nodes[0]);
                                openWin({url:'<%=rootPath%>/Organization!loadOrg.action?range=<s:property value="#request.range"/>&orgParentOrgId='+$this.attr('pId')+'&orgId='+$this.attr('id')+'&verifyCode='+$this.attr('verifyCode'),width:800,height:670,winName:'modify',isFull:true});
                            }
                        }

                        function delOrg(){
                            hideRMenu();
                            var nodes = zTree.getSelectedNodes();
                            if (nodes && nodes.length>0) {
                                //$(nodes[0]).attr('isParent')
                                var msg = "该组织及单位主页、下属组织、组织下的用户将全部被删除，确定要删除吗？";
                                whir_confirm(msg, function(){
                                    var $this = $(nodes[0]);
                                    var json = ajaxForSync('<%=rootPath%>/Organization!deleteOrg.action', 'orgId='+$this.attr('id')+'&verifyCode='+$this.attr('verifyCode'));
                                    json = eval("("+json+")");
                                    if(json.result == 'success'){
                                        zTree.removeNode(nodes[0]);
                                    }                                    
                                },
                                function(){
                                });
                                /*if (confirm(msg)){
                                    zTree.removeNode(nodes[0]);
                                }*/
                            }
                        }

                        function addSubOrg(){
                            hideRMenu();
                            var nodes = zTree.getSelectedNodes();
                            if (nodes && nodes.length>0) {
                                var $this = $(nodes[0]);
                                openWin({url:'<%=rootPath%>/Organization!addOrg.action?range=<s:property value="#request.range"/>&orgParentOrgId='+$this.attr('id')+'&orgId='+$this.attr('id'),width:800,height:670,winName:'add',isFull:true});
                            }
                        }

                        function addOrg(flag){
                            var params = '';
                            if(flag){
                                hideRMenu();
                            }else{
                                params = '&addType=1';
                            }
                            openWin({url:'<%=rootPath%>/Organization!addOrg.action?range=<s:property value="#request.range"/>&orgParentOrgId=0&orgId=0'+params,width:820,height:670,winName:'add',isFull:true});
                        }

                        //增加组织节点
                        function addTreeOrg(json, flag){
                            if(flag){
                                var newNode = {id:json.data.orgId, pId:json.data.orgParentOrgId, name:json.data.orgName, orgParentOrgId:json.data.orgId, verifyCode:json.data.verifyCode};
                                var nodes = zTree.getSelectedNodes();
                                if (nodes.length>0) {                                    
                                    zTree.addNodes(nodes[0], newNode);
                                    if(nodes[0].children.length==0){
                                        nodes[0].isParent = true;
                                        zTree.updateNode(nodes[0]);
                                    }
                                } else {
                                    zTree.addNodes(null, newNode);
                                }
                            }else{
                                refreshTreeOrg(null);
                            }
                        }
                        //更新组织节点
                        function updateTreeOrg(json, flag){
                            if(flag){
                                var nodes = zTree.getSelectedNodes();
                                if (nodes.length>0) {
                                    var pId = nodes[0].pId;
                                    var orgParentOrgId = json.data.orgParentOrgId;
                                    if(pId == orgParentOrgId){
                                        nodes[0].name = json.data.orgName;
                                        nodes[0].pId = orgParentOrgId;
                                        zTree.updateNode(nodes[0]);
                                    }else{
                                        refreshTreeOrg(null);
                                    }
                                }
                            }else{
                                refreshTreeOrg(null);
                            }
                        }

                        function refreshTreeOrg(json){
                            $.fn.zTree.init($("#treeOrg"), settingOrg);
                            if(json){
                                //refreshListForm('queryForm');
                            }
                        }

                        function resizeOrgTreeHeight(){
                            $('#orgTree').height($(document).height()-3);
                        }
						
							
						
                        var zTree, rMenu;
                        $(document).ready(function(){
                            refreshTreeOrg(null);
                            zTree = $.fn.zTree.getZTreeObj("treeOrg");
			                rMenu = $("#rMenu");
                            
                            $(window).resize(function(){
                                resizeOrgTreeHeight();
                            });
                            resizeOrgTreeHeight();
                            
                        });
                        //-->
                    </SCRIPT>
            </div>
            <div id="rMenu">
                <ul>
                    <li id="m_modify" onclick="modifyOrg();" style="border-bottom:0;" onmouseover="changeBdColor(this, '#993300', '#CCFF00');" onmouseout="changeBdColor(this, '', '#000000');">修改组织</li>
                    <li id="m_del" onclick="delOrg();" onmouseover="changeBdColor(this, '#993300', '#CCFF00');" onmouseout="changeBdColor(this, '', '#000000');">删除组织</li>
                    <li id="m_addSub" onclick="addSubOrg();" style="border-bottom:0;" onmouseover="changeBdColor(this, '#993300', '#CCFF00');" onmouseout="changeBdColor(this, '', '#000000');">添加子组织</li>
                    <%if("0".equals(range) || "*0*".equals(range)){%><li id="m_add" onclick="addOrg(true);" style="border-bottom:0;" onmouseover="changeBdColor(this, '#993300', '#CCFF00');" onmouseout="changeBdColor(this, '', '#000000');">添加一级组织</li><%}%>
                </ul>
            </div>
			
        </td>
		</s:if>
        <td width="90%" valign=top>
        
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="queryForm" id="queryForm" action="/User!userList.action" method="post">
<s:hidden name="dogMaxUserNum" id="dogMaxUserNum" />
<s:hidden name="currentUserNum" id="currentUserNum" />
<s:hidden name="status" id="status" />
<!-- SEARCH PART START -->  
<%@ include file="/public/include/form_list.jsp"%>  
<s:hidden name="range" id="range"/>
<s:if test="status != 'apply'">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
   	<input type="hidden" name="orgId" id="orgId"  value="<%=orgId%>" class="inputText" style="width:98%;" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" />   
   	<input type="hidden" name="orgName1" id="orgName1"  value="" class="inputText" style="width:98%;" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" />   
	<input type="hidden" name="init" id="init"  value="<%=init%>" class="inputText" style="width:98%;" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" />    
  
    <tr>  
        <td class="whir_td_searchtitle">中文名：</td>  
        <td class="whir_td_searchinput">  
            <s:textfield id="cnName" name="cnName" size="16" cssClass="inputText" />  
        </td>  
        <td class="whir_td_searchtitle">英文名：</td>  
        <td class="whir_td_searchinput">  
            <s:textfield id="enName" name="enName" size="16" cssClass="inputText" />
        </td>  
        <td class="whir_td_searchtitle">账号：</td>  
        <td class="whir_td_searchinput">
            <s:textfield id="userAccount" name="userAccount" size="16" cssClass="inputText" />
        </td>  
    </tr>  
    <tr>  
        <td class="whir_td_searchtitle">组织：</td>  
        <td class="whir_td_searchinput">  
            <s:textfield id="orgName" name="orgName" size="16" cssClass="inputText" />  
        </td>  
        <td class="whir_td_searchtitle">职务：</td>  
        <td class="whir_td_searchinput">
            <select id="searchDuty" name="searchDuty"  class="selectlist">
                <option value="">--请选择--</option>
                <s:iterator value="#request.listDuty" status="status" id="duty">
                <option value="<s:property value="#request.listDuty[#status.index][1]"/>"><s:property value="#request.listDuty[#status.index][1]"/></option>
                </s:iterator>
            </select>
        </td>  
        <td class="whir_td_searchtitle">简码：</td>  
        <td class="whir_td_searchinput">
            
            <s:textfield id="searchSimpleName" name="searchSimpleName" size="16" cssClass="inputText" />
        </td>  
    </tr> 
    <tr>  
        <td class="whir_td_searchtitle">上级领导：</td>  
        <td class="whir_td_searchinput">
            <s:textfield id="searchLeaderName" name="searchLeaderName" size="16" cssClass="inputText" />
        </td>
        <td class="whir_td_searchtitle">evo+：</td>  
        <td class="whir_td_searchinput">
            <s:select name="enterprisenumber" list="#{0:'否',1:'是'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" cssStyle="width:150px;" data-options="editable:false,panelHeight:'auto'"/>
        </td> 
        <td class="whir_td_searchtitle">evo客户端：</td>  
        <td class="whir_td_searchinput">
            <s:select name="mobileUserFlag" list="#{0:'否',1:'是'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" cssClass="selectlist" cssStyle="width:150px;" data-options="editable:false,panelHeight:'auto'"/>
        </td>
    </tr>
    <tr>
        <td colspan=6 class="SearchBar_toolbar">  
            <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->  
            <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name="comm.searchnow"/>" />  
            <!--resetForm(obj)为公共方法-->  
            <input type="button" class="btnButton4font" value="<s:text name="comm.clear"/>" onclick="resetForm(this);" />
        </td>  
    </tr>
</table>
</s:if>
<!-- SEARCH PART END -->  
  
<!-- MIDDLE  BUTTONS START -->  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
    <tr> 
        <td align="right">
        <s:if test="status == 'active'">
            <input type="button" class="btnButton4font" onclick="addUser();" value="<s:text name="comm.add"/>" />
            <input type="button" class="btnButton4font" onclick="copyUser();" value="<s:text name="comm.copy"/>" />
            <input type="button" class="btnButton4font" onclick="addBatch();" value="<s:text name="comm.batchadd"/>" />
            <input type="button" class="btnButton4font" onclick="modiBatch();" value="<s:text name="comm.batchmodi"/>" />
            <input type="button" class="btnButton4font" onclick="deleteBatch();" value="<s:text name="comm.delselect"/>" />
            <input type="button" class="btnButton4font" onclick="disableBatch();" value="<s:text name="comm.disabled"/>" />
            <input type="button" class="btnButton4font" onclick="sleepBatch();" value="<s:text name="comm.sleep0"/>" />
            <input type="button" class="btnButton4font" onclick="exportOutUser();" value="<s:text name="comm.export"/>" />
            <input type="button" class="btnButton4font" onclick="exportOutUserSelected();" value="<s:text name="comm.selectedExport"/>" />
        </s:if>
        <s:elseif test="status == 'disabled'">
            <input type="button" class="btnButton4font" onclick="recoverDisableBatch();" value="<s:text name="comm.recover"/>" />
            <input type="button" class="btnButton4font" onclick="deleteBatch();" value="<s:text name="comm.delselect"/>" />
            <input type="button" class="btnButton4font" onclick="exportOutUser();" value="<s:text name="comm.export"/>" />
            <input type="button" class="btnButton4font" onclick="exportOutUserSelected();" value="<s:text name="comm.selectedExport"/>" />
        </s:elseif>
        <s:elseif test="status == 'sleep'">
            <input type="button" class="btnButton4font" onclick="recoverSleepBatch();" value="<s:text name="comm.recover"/>" />
        </s:elseif>
        <s:elseif test="status == 'apply'">
        </s:elseif>
        <s:else>
            &nbsp;
        </s:else>
        </td>  
    </tr>  
</table>  
<!-- MIDDLE  BUTTONS END -->  

<!-- LIST TITLE PART START -->      
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
    <!-- thead必须存在且id必须为headerContainer -->  
    <thead id="headerContainer">  
    <tr class="listTableHead">  
        <td whir-options="field:'empId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('empId',this.checked);" ></td>
        <s:if test="status != 'apply'">
        <td whir-options="field:'userAccounts',width:'8%'">账号</td>
        </s:if>
        <td whir-options="field:'empName',width:'10%',renderer:renderName">中文名</td>
        <s:if test="status != 'apply'">
        <td whir-options="field:'userSimpleName', width:'8%'">简码</td>
        </s:if>
        <td whir-options="field:'empSex', width:'4%',renderer:renderSex">性别</td>
        <s:if test="status != 'apply'">
        <td whir-options="field:'orgNameString',width:'21%'">组织</td>
        </s:if>
        <s:else>
        <td whir-options="field:'orgNameString',width:'57%'">组织</td>
        </s:else>
        <td whir-options="field:'empDuty',width:'8%'">职务</td>   
        <td whir-options="field:'empLeaderName',width:'9%'">上级领导</td>
        <s:if test="status != 'apply'">
        <td whir-options="field:'enterprisenumber',width:'3%',renderer:renderEnterprisenumber">evo+</td>
        <td whir-options="field:'mobileUserFlag',width:'5%',renderer:renderMobileUserFlag">evo客户端</td>
        <s:if test="status == 'sleep'">
        <td whir-options="field:'userSleepReasons',width:'12%'">休眠原因</td>
        </s:if>
        <s:else>
        <td whir-options="field:'latestLogonTime',width:'12%',renderer:renderLatestLogonTime,allowSort:true" title="排序">最后登录时间</td>
        </s:else>
        </s:if>
        <td whir-options="field:'',width:'10%',renderer:renderOperate">操作</td>
    </tr>  
    </thead>  
    <!-- tbody必须存在且id必须为itemContainer -->  
    <tbody id="itemContainer" >
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
        </td>
    </tr>
</table>
</body>  

<script type="text/javascript">  
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){         
    initListFormToAjax({formId:"queryForm"});         
});



function del(orgId, verifyCode){
    var msg = "该组织及单位主页、下属组织、组织下的用户将全部被删除，确定要删除吗？";
    whir_confirm(msg, function(){
        ajaxOperate({urlWithData:'<%=rootPath%>/Organization!deleteOrg.action?orgId='+orgId+'&verifyCode='+verifyCode,tip:'<s:text name="comm.sdel"/>',isconfirm:false,formId:'queryForm',callbackfunction:refreshTreeOrg});
    },
    function(){
    });
}

//自定义操作栏内容  
function renderOperate(po,i){  
    var html = '';
    <s:if test="status == 'active'">
        html += '<img src="<%=rootPath%>/images/modi.gif" title="修改" onClick="javascript:openWin({url:\'<%=rootPath%>/User!loadUser.action?empId='+po.empId+'&verifyCode='+po.verifyCode+'\',width:620,height:350,winName:\'modifyUser\',isFull:true,isPost:false});"><img src="<%=rootPath%>/images/del.gif" title="删除" onClick="javascript:deleteMe(\''+po.empId+'\',\''+po.verifyCode+'\');"><img src="<%=rootPath%>/images/stop.gif" title="禁用" style="cursor:hand" onClick="javascript:disableMe('+po.empId+');">';
        if(po.securitypolicy=='1'){
            html += '<img src="<%=rootPath%>/images/lc.gif" title="绑定" onClick="javascript:bindMobile('+po.empId+');">';
        }
    </s:if>
    <s:elseif test="status == 'disabled'">
        html += '<img src="<%=rootPath%>/images/quash.gif" title="恢复" onClick="javascript:recoverDisable('+po.empId+','+(po.mobileUserFlag!=null && po.mobileUserFlag!="" ? po.mobileUserFlag : "0") +','+(po.enterprisenumber!=null && po.enterprisenumber!="" ? po.enterprisenumber : "0")+');" >';
    </s:elseif>
    <s:elseif test="status == 'sleep'">
        html += '<img src="<%=rootPath%>/images/quash.gif" title="恢复" onClick="javascript:recoverSleep('+po.empId+');">';
    </s:elseif>
    <s:elseif test="status == 'apply'">
        html += '<img src="<%=rootPath%>/images/apply.gif" title="申请账号" onClick="javascript:openWin({url:\'<%=rootPath%>/User!loadUser.action?status=apply&empId='+po.empId+'&verifyCode='+po.verifyCode+'\',width:620,height:350,winName:\'modifyUser\',isFull:true});">';
    </s:elseif>
    
    return html;  
}

//自定义查看栏内容  
function renderName(po,i){
    var html = '';
  
   var status = '<%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("status"))%>';
    <s:if test="status != 'apply'">
        html =  '<a href="javascript:void(0)" onclick="javascript:openWin({url:\'<%=rootPath%>/User!loadUser.action?status='+status+'&empId='+po.empId+'&verifyCode='+po.verifyCode+'\',width:620,height:350,winName:\'modifyUser\',isFull:true});">'+po.empName+'</a>';
    </s:if>
    <s:else>
        html = po.empName;
    </s:else>
    return html;  
}

function renderLatestLogonTime(po,i){
    var html = '';
    if(po.latestLogonTime != '' && po.latestLogonTime != 'null'  && po.latestLogonTime != '&nbsp;'){
        html += po.latestLogonTime.substr(0,19);//getFormatDateByLong(po.latestLogonTime,'yyyy-MM-dd hh:mm:ss');
    }
    return html;
}

function renderSex(po, i) {
    if (po.empSex == 0) {
        return "男";
    } else if (po.empSex == 1){
        return "女";
    } else {
        return "&nbsp;";
    }
}

function renderUserIsSuper(po, i) {
    if (po.userIsSuper == '1') {
        return "是";
    } else {
        return "否";
    }
}
function renderEnterprisenumber(po, i) {
    if (po.enterprisenumber == '1') {
        return "是";
    } else  {
        return "否";
    }
}

function renderMobileUserFlag(po, i) {
    if (po.mobileUserFlag == '1') {
        return "是";
    } else {
        return "否";
    }
}

//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  

var dogMaxUserNum = 0;
var currentUserNum = 0;
var canAddUserNum = 0;

function setVarValue(){
    dogMaxUserNum = $('#dogMaxUserNum').val();
    currentUserNum = $('#currentUserNum').val();
    canAddUserNum = parseInt(dogMaxUserNum, 10)-parseInt(currentUserNum, 10);
}

<s:if test="status == 'active'">
//当前用户
function addUser() {
    setVarValue();
	var orgId = $('#orgId').val();
	var orgName = $('#orgName1').val();
    if(canAddUserNum>0){
    	if(orgId!=null&&orgId!=""&&orgName!=null&&orgName!=""){
    		//选中组织时新增
        	openWin({url:'<%=rootPath%>/User!addUser.action?orgId='+orgId+'&orgName='+orgName+'&type=add',width:620,height:350,winName:'addUser',isFull:true});
    		}else{
    		//没选中组织时新增
    		openWin({url:'<%=rootPath%>/User!addUser.action',width:620,height:350,winName:'addUser',isFull:true});
    		}
    }else{
       // whir_alert("当前用户数"+currentUserNum+"，授权用户数"+dogMaxUserNum+"，不能再添加用户！", null);
          whir_alert("用户数超过最大限制，保存失败！", null);
        return;
    }
}

//复制用户
function copyUser() {
    setVarValue();

    var ids = getCheckBoxData('empId', 'empId');
    if(ids!=''){
        var len = ids.split(',').length;
        if((parseInt(canAddUserNum, 10)-parseInt(len, 10))>=0){
            ajaxBatchOperate({url:"<%=rootPath%>/User!copyUser.action",checkbox_name:"empId",attr_name:"empId",tip:"<s:text name="comm.copy1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
        }else{
           // whir_alert("当前用户数"+currentUserNum+"，授权用户数"+dogMaxUserNum+"，不能再复制用户！", null);
             whir_alert("用户数超过最大限制，保存失败！", null);
            return;
        }
    }else{
        whir_alert("请选择要复制的用户！");
        return;
    }
}

//批量增加
function addBatch() {
    setVarValue();
	var orgId = $('#orgId').val();
	var orgName = $('#orgName1').val();
    if(canAddUserNum>0){
    	if(orgId!=null&&orgId!=""&&orgName!=null&&orgName!=""){
    		//选中组织时新增
        	openWin({url:'<%=rootPath%>/User!addBatchUser.action?orgId='+orgId+'&orgName='+orgName+'&type=add',width:800,height:600,winName:'addBatchUser',isFull:true});
        }else{
        	//没选中组织时新增
        	openWin({url:'<%=rootPath%>/User!addBatchUser.action',width:800,height:600,winName:'addBatchUser',isFull:true});
        }
    }else{
        //whir_alert("当前用户数"+currentUserNum+"，授权用户数"+dogMaxUserNum+"，不能再添加用户！", null);
        whir_alert("用户数超过最大限制，保存失败！", null);
        return;
    }
}

function modiBatch() {
    var ids = getCheckBoxData('empId', 'empId');
    if(ids!=''){
        openWin({url:'<%=rootPath%>/User!modiBatchUser.action?empId='+ids,width:820,height:670,winName:'addBatchUser',isFull:false});
    }else{
        whir_alert("请选择要批量修改的用户！");
        return;
    }
}

//批量禁用用户
function disableBatch() {
    ajaxBatchOperate({url:"<%=rootPath%>/User!disableUser.action",checkbox_name:"empId",attr_name:"empId",tip:"<s:text name="comm.disabled2"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}

//休眠用户
function sleepBatch() {
    ajaxBatchOperate({url:"<%=rootPath%>/User!sleepUser.action",checkbox_name:"empId",attr_name:"empId",tip:"<s:text name="comm.sleep"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}

//禁用用户
function disableMe(id){
    ajaxOperate({urlWithData:"<%=rootPath%>/User!disableUser.action?empId="+id,tip:"<s:text name="comm.disabled2"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}

function deleteMe(id, verifyCode){
    if(id!=''){
        //验证是否有直接下属
        var res = ajaxForSync(whirRootPath + "/User!checkUserHasLeader.action", "checkType=0&empId="+id);
        res = eval("("+res+")");
        var ret = res.result;
        if(ret != ''){
            var tempArr = ret.split('、');
            var len = tempArr.length;
            if(len>10){
                ret = '';
                for(var i=0; i<tempArr.length && i<10; i++){
                    ret += tempArr[i] + '、';
                }
                ret += '...';
            }
            whir_confirm(ret+'的上级领导为该用户，确定要删除吗？',function(){
                ajaxOperate({urlWithData:"<%=rootPath%>/User!deleteUser.action?empId="+id+"&verifyCode="+verifyCode,tip:"<s:text name="comm.sdel"/>",isconfirm:false,formId:"queryForm",callbackfunction:null});
            }, null);            
        }else{//没有直接下属
            ajaxOperate({urlWithData:"<%=rootPath%>/User!deleteUser.action?empId="+id+"&verifyCode="+verifyCode,tip:"<s:text name="comm.sdel"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
        }
    }else{
        whir_alert("请选择要删除的用户！");
        return;
    }
}

function bindMobile(id){
    openWin({url:'<%=rootPath%>/MobileUser!initBindMobileInfoList.action?empId='+id,width:800,height:600,winName:'addUser',isFull:false});
}
</s:if>

function deleteBatch() {
    var ids = getCheckBoxData('empId', 'empId');
    if(ids!=''){
        //验证是否有直接下属
        var res = ajaxForSync(whirRootPath + "/User!checkUserHasLeader.action", "checkType=1&empId="+ids);
        res = eval("("+res+")");
        var ret = res.result;
        if(ret != ''){
            whir_confirm(ret+'有直接下属，确定要删除吗？',function(){
                ajaxOperate({urlWithData:"<%=rootPath%>/User!deleteUser.action?single=no&empId="+ids,tip:"<s:text name="comm.sdel"/>",isconfirm:false,formId:"queryForm",callbackfunction:null});
            }, null);            
        }else{//没有直接下属
            ajaxOperate({urlWithData:"<%=rootPath%>/User!deleteUser.action?single=no&empId="+ids,tip:"<s:text name="comm.sdel"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
        }
    }else{
        whir_alert("请选择要删除的用户！");
        return;
    }
}

<s:if test="status == 'disabled'">
//恢复禁用用户
function recoverDisableBatch() {
	var id = getCheckBoxData('empId', 'empId');
	if(id.length>0){
	var mobileUserFlag=0;
	var mobileUserFlags="";
	var enterprisenumber = 0;
	var enterprisenumbers = "";
		//判断选中的用户中是否包含APP用户
		$.ajax({
			url: "/defaultroot/User!batchgetAPP.action?ids="+id,
			cache: false,
			async: false,
			success: function(dataForm) {
				var data = eval('('+dataForm+')');
				if(data.result=="true"){
					mobileUserFlag = 1;
					mobileUserFlags=data.data.res;
					//whir_alert(data.data.res);
					//whir_alert("选中的用户中包含APP用户！");
				}else{
					//whir_alert("选中的用户中不包含APP用户！");
				}
			}
		});
		$.ajax({
			url: "/defaultroot/User!batchgetEnterprisenumber.action?ids="+id,
			cache: false,
			async: false,
			success: function(dataForm) {
				var data = eval('('+dataForm+')');
				if(data.result=="true"){
					enterprisenumber = 1;
					enterprisenumbers=data.data.res;
					//whir_alert("选中的用户中包含企业号用户！");
				}else{
					//whir_alert("选中的用户中不包含企业号用户！");
				}
			}
		});
		
		var idsARR = id.split(",");
		//获取APP用户的ids 
		var mobileUserFlagIDS="";	
		var mobileUserFlagARR = mobileUserFlags.split(",");
		for(var i=0;i<mobileUserFlagARR.length;i++){
			if(mobileUserFlagARR[i]==1){
				mobileUserFlagIDS=mobileUserFlagIDS+idsARR[i]+",";
			}
		}
		mobileUserFlagIDS = mobileUserFlagIDS.substring(0, mobileUserFlagIDS.length-1);
		//判断APP用户数量
		if(mobileUserFlag==1&&mobileUserFlagIDS!=""){
			var f = batchjudgmentAppNum(mobileUserFlagIDS);
			if(f==0){return false;}
		}
		//获取企业号用户的ids 
		var enterprisenumberIDS="";	
		var enterprisenumberARR = enterprisenumbers.split(",");
		for(var i=0;i<enterprisenumberARR.length;i++){
			if(enterprisenumberARR[i]==1){
				enterprisenumberIDS=enterprisenumberIDS+idsARR[i]+",";
			}
		}
		enterprisenumberIDS = enterprisenumberIDS.substring(0, enterprisenumberIDS.length-1);
		//判断企业号用户数量	
		if(enterprisenumber==1&&enterprisenumberIDS!=""){
			var f = batchjudgmentWeixinNum(enterprisenumberIDS);
			if(f==0){return false;}
		}
	}
    ajaxBatchOperate({url:"<%=rootPath%>/User!recoverUser.action",checkbox_name:"empId",attr_name:"empId",tip:"<s:text name="comm.recover1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}

function recoverDisable(id,mobileUserFlag,enterprisenumber){

	if(mobileUserFlag==1){
		var f = batchjudgmentAppNum(id);
		if(f==0){return false;}
	}
	if(enterprisenumber==1){
		var f = batchjudgmentWeixinNum(id);
		if(f==0){return false;}
	}
    ajaxOperate({urlWithData:"<%=rootPath%>/User!recoverUser.action?empId="+id,tip:"<s:text name="comm.recover1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}


</s:if>

<s:if test="status == 'sleep'">
//恢复休眠用户
function recoverSleepBatch() {
    ajaxBatchOperate({url:"<%=rootPath%>/User!recoverSleepUser.action",checkbox_name:"empId",attr_name:"empId",tip:"<s:text name="comm.recover1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}

function recoverSleep(id){

    ajaxOperate({urlWithData:"<%=rootPath%>/User!recoverSleepUser.action?empId="+id,tip:"<s:text name="comm.recover1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
}
</s:if>

<s:if test="status == 'active' || status == 'disabled'">
//导出用户
function exportOutUser() {
    commonExportExcel({formId:'queryForm', action:'<%=rootPath%>/User!exportUser.action'});
}

function exportOutUserSelected(){
    var ids = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'empId', attr_name:'empId'});
    if(ids == ''){
        whir_alert('<s:text name="comm.selectedExportConfirm"/>', null);
        return;
    }

    var params = '';//'?selectIds='+ids+'&exportData=1&exportTitle='+$('#processSpanName').html();

    commonExportExcel({formId:'queryForm', action:'<%=rootPath%>/User!exportUser.action'+params, selectedId:'empId'});
}
</s:if>


function batchjudgmentAppNum(userIdStr){
	var flag = "0";
	$.ajax({
		url: "/defaultroot/User!batchjudgmentAPPNum.action?userIdStr="+userIdStr,
		cache: false,
		async: false,
		success: function(dataForm) {
			var data = eval('('+dataForm+')');
			if(data.result=="true"){
				flag = "1";
			}else{
				whir_alert("evo客户端用户数量超过最大限制，保存失败！");
			}
		}
	});
	return flag;
}

function batchjudgmentWeixinNum(userIdStr){
	var flag = "0";
	$.ajax({
		url: "/defaultroot/User!batchjudgmentWeixinNum.action?userIdStr="+userIdStr,
		cache: false,
		async: false,
		success: function(dataForm) {
		
			var data = eval('('+dataForm+')');
			if(data.result=="true"){
				flag = "1";
			}else{
				whir_alert("evo+用户数超出最大限制，保存失败！");
			}
		}
	});
	return flag;
}

</script>
<style type="text/css">
.ztree li span.button.root_open{background-position:center 5px;}
.ztree li span.button.root_close{background-position:center 5px;}
.ztree li span.button.roots_open{background-position:center 5px;}
.ztree li span.button.roots_close{background-position:center 5px;}
.ztree li span.button.bottom_open{background-position:center 5px;}
.ztree li span.button.bottom_close{background-position:center 5px}
.ztree li span.button.center_close{background-position:center 5px}
.ztree li span.button.center_open{background-position:center 5px}
.ztree li span.button.switch{float:left;}




</style>
</html>
