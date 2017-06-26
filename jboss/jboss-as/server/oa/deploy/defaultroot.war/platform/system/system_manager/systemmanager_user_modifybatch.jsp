<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
String managerScope = (String)request.getAttribute("managerScope");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>批量修改用户</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/platform/system/system_manager/systemmanager_user.js" type="text/javascript"></script>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">
        <div class="_docBoxNoPanel">
        <s:form name="dataForm" id="dataForm" action="/User!updateBatchUser.action" method="post">
        <%@ include file="/public/include/form_detail.jsp"%>
        <s:hidden name="userIdStr" id="userIdStr"/>

        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>
                <td for="用户" width="80" class="td_lefttitle" valign=top>用&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
                <td><s:textarea name="userNameStr" id="userNameStr" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:92%;" maxlength="30" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td for="职务" class="td_lefttitle">职&nbsp;&nbsp;&nbsp;&nbsp;务：</td>
                <td>
                    <select id="empDuty" name="userPO.empDuty" class="easyui-combobox" data-options="width:300">
                        <option value="" selected>--请选择--</option>
                        <s:iterator value="#request.listDuty" status="status" id="duty">
                        <option value="<s:property value="#request.listDuty[#status.index][1]"/>"><s:property value="#request.listDuty[#status.index][1]"/></option>
                        </s:iterator>
                    </select>
                </td>
            </tr>
            <tr>
                <td for="所属组织" class="td_lefttitle">所属组织：</td>
                <td>
                    <s:hidden name="orgIds" id="orgIds"/>
                    <s:textfield name="orgName" id="orgName" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="#" class="selectIco" onclick="openSelect({allowId:'orgIds', allowName:'orgName', select:'org', single:'yes', show:'org', range:'<%=managerScope%>', limited:'1', callbackOK:'getFillLeader2'});"></a>
                </td>
            </tr>
            <tr>
                <td for="上级领导" class="td_lefttitle">上级领导：</td>
                <td>
                    <s:hidden name="userPO.empLeaderId" id="empLeaderId"/>
                    <s:textfield name="userPO.empLeaderName" id="empLeaderName" cssClass="inputText" cssStyle="width:92%;" readonly="true" whir-options="vtype:[{'rangeLength':'0-200'}]"></s:textfield><a href="#" class="selectIco" onclick="openSelect({allowId:'empLeaderId', allowName:'empLeaderName', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
                </td>
            </tr>
            <tr>
                <td for="移动办公" class="td_lefttitle">移动办公：</td>
                <td>
                    <input onclick="checkMobile(this);$('#securitypolicy0').attr('checked',true);" type="checkbox" name="userPO.mobileUserFlag" id="mobileUserFlag" value="1">evo客户端&nbsp;&nbsp;</input>
                    <span id="mobileSpan" style="display:none">
                        <s:radio id="securitypolicy" name="userPO.securitypolicy" list="#{'0':'低安全策略','1':'高安全策略'}"></s:radio>&nbsp;<img src="images/helpuser.gif" width=14 height=16 title="安全策略目前仅对于Android、iPhone手机版有效，如果对该用户设置的是“高安全策略”，则首次登录时系统记录该用户登录时使用的手机设备ID、手机号码等但不允许其登录，直到该设备ID开通，由系统管理员通过用户管理列表中“绑定”操作为该用户的该手机设备ID开通访问权限，授权该用户使用已绑定的手机能够访问移动办公系统。"/>
                    </span>
                    <input  type="checkbox" name="userPO.enterprisenumber"  id="enterprisenumber" value="1">evo+</input>
                </td>
            </tr>
          
            <tr>
                <td for="邮箱容量" class="td_lefttitle">邮箱容量：</td>
                <td>
                    <s:textfield name="userPO.mailboxSize" id="mailboxSize" cssClass="inputText" whir-options="vtype:['p_integer_e']" cssStyle="width:80px;" maxlength="6"/>&nbsp;M
                </td>
            </tr>
            <tr>
                <td for="我的文档" class="td_lefttitle">我的文档：</td>
                <td>
                    <s:textfield name="userPO.netDiskSize" id="netDiskSize" cssClass="inputText" whir-options="vtype:['p_integer_e']" cssStyle="width:80px;" maxlength="6"/>&nbsp;M
                </td>
            </tr>
            <tr class="Table_nobttomline">
                <td></td>
                <td nowrap>
                    <input type="button" class="btnButton4font" onClick="saveTheForm(0,this);" value="<s:text name="comm.saveclose"/>" />
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
                </td>
            </tr>
        </table>

        </s:form>
        </div>
    </div>
</body>

<script type="text/javascript">  
//*************************************下面的函数属于公共的或半自定义的*************************************************//

//设置表单为异步提交  
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<s:text name="comm.save1"/>'});

//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

function saveTheForm(type, obj){
	//2016-01-11 判断app和企业号用户是否超出数量
	var userIdStr=$('#userIdStr').val();
	var mobileUserFlag  = $('#mobileUserFlag');
    if(mobileUserFlag.is(':checked')){ 
    	var appflag = batchjudgmentAppNum(userIdStr);
    	if(appflag=="0"){
    		return false;
    	}
    }
    
    var enterprisenumber  = $('#enterprisenumber');
    if(enterprisenumber.is(':checked')){
    	 var weixinflag = batchjudgmentWeixinNum(userIdStr);
    	 if(weixinflag=="0"){
     		return false;
     	}
    }
    
	
    var netDiskSize = $('#netDiskSize').val();
    if(parseInt(netDiskSize)>2048){
        whir_alert("我的文档大小不得大于2048M！", function(){
            $('#netDiskSize').focus();
            return false;
        });
        return false;
    }
    
    

    ok(type, obj);
}


</script>

</html>