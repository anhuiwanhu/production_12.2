<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.common.CustomerCenterConfig" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.po.*" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.bd.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
	<title>业务处理列表</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_list.jsp"%>  
	<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>

<style type="text/css">
.toolbarAlign .btnButton4font, .btnButton6font {
    vertical-align: middle;
}

.toolbarAlign .combo {
    +margin:3px 0 3px 0;
}
</style>
</head>  
<%
String searchPart = (String)request.getAttribute("searchPart");
String headerContainer = (String)request.getAttribute("headerContainer");

String TableId =  request.getParameter("TableId")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("TableId"));
 
String CENTERID = request.getParameter("CENTERID")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("CENTERID"));
 
String ModClassId = request.getParameter("ModClassId")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("ModClassId"));
 
String rightscope = request.getParameter("rightscope")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("rightscope"));

String rightcode = request.getParameter("rightcode")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("rightcode"));

String rightcodemanage = request.getParameter("rightcodemanage")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("rightcodemanage"));
 
//选择合并列表
String selectInfo = request.getParameter("selectInfo")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("selectInfo"));
 
String InfoId = request.getParameter("InfoId")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("InfoId"));
 
List queryFieldList = (List) request.getAttribute("queryFieldList");
%>
<body class="MainFrameBox">  
  <%if(queryFieldList!=null&&queryFieldList.size()!=0){%>
	<s:form name="queryForm" id="queryForm" action="custinfo!getCustRightDataList.action" method="post" theme="simple">
    <input name="TableId" id ="TableId" type="hidden" value="<%=TableId%>">
	<input name="CENTERID" id ="CENTERID" type="hidden" value="<%=CENTERID%>">
	<input name="ModClassId" id ="ModClassId" type="hidden" value="<%=ModClassId%>">
	<input name="rightscope" id ="rightscope" type="hidden" value="<%=rightscope%>">
	<input name="rightcode" id ="rightcode" type="hidden" value="<%=rightcode%>">
	<input name="rightcodemanage" id ="rightcodemanage" type="hidden" value="<%=rightcodemanage%>">

	<input name="selectInfo" id ="selectInfo" type="hidden" value="<%=selectInfo%>">
	<input name="InfoId" id ="InfoId" type="hidden" value="<%=InfoId%>">
    
	
    <!-- SEARCH PART START -->  
    <%@ include file="/public/include/form_list.jsp"%>  
    <%if(searchPart!=null&&!"".equals(searchPart)){%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
       <%=searchPart%>  
    </table>  
	<%}%>
    <!-- SEARCH PART END -->      
  
    <!-- MIDDLE  BUTTONS START -->  
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
        <tr>  
            <td align="right" class="toolbarAlign">
					<select id="DateSearch"  name="DateSearch" class="easyui-combobox" data-options="width:202,panelHeight:100,onSelect: function(record){  
                         searchform();  
                        }">    
						<option value="<%=CustomerCenterConfig.SEARCH_ALL%>"><%=CustomerCenterConfig.SEARCH_ALLNAME%></option>
						<option value="<%=CustomerCenterConfig.SEARCH_DAY%>"><%=CustomerCenterConfig.SEARCH_DAYNAME%></option>
						<option value="<%=CustomerCenterConfig.SEARCH_WEEK%>"><%=CustomerCenterConfig.SEARCH_WEEKNAME%></option>
						<option value="<%=CustomerCenterConfig.SEARCH_MONTH%>"><%=CustomerCenterConfig.SEARCH_MONTHNAME%></option>
					</select> 
					<%if(!"1".equals(selectInfo)){%>
					<input type="button" class="btnButton4font" onclick="add()" value="新  增" />
					<input type="button" class="btnButton4font" onclick="exportInfo()" value="导  出" />
					<%
				          if("2".equals(ModClassId) || "3".equals(ModClassId)){
				    %>
					<input type="button" class="btnButton4font" onclick="setAuth('<%=CustomerCenterConfig.GIVEAUTH%>','分配');" value="选中分配" />
					<input type="button" class="btnButton4font" onclick="setAuth('<%=CustomerCenterConfig.GIVEALLAUTH%>','分配');" value="全部分配" />
					<input type="button" class="btnButton4font" onclick="setAuth('<%=CustomerCenterConfig.BACKAUTH%>','回收');" value="选中回收" />
					<input type="button" class="btnButton4font" onclick="setAuth('<%=CustomerCenterConfig.BACKALLAUTH%>','回收');" value="全部回收" />
				   <%     }
					}%>
            </td>  
        </tr>  
    </table>  
    <!-- MIDDLE  BUTTONS END -->  

	<!-- LIST TITLE PART START -->	
	<%if(headerContainer!=null&&!"".equals(headerContainer)){%>
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
          <%=headerContainer%>
		</thead>
		<tbody  id="itemContainer" >
          

		</tbody>
    </table>
	<%}%>
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

	<%if("1".equals(selectInfo)){%>
        <input type="button" class="btnButton4font" onclick="selectInfo();" value="选  择" />
        <input type="button" class="btnButton4font" onclick="closeWindow(null);" value="退  出" />
	<%}%>

  <%}%>
</body>  
<script type="text/javascript">

//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){     
	var TableId = $('#TableId').val();
	if(TableId!='0'&&TableId!='null'){
	   initListFormToAjax({formId:"queryForm"});   
	}
});  
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  
function selectInfo(){

	var radioId = $("input[name='radioId']:checked").val();
    if(radioId){
       //alert(radioId);
       whir_confirm("确定要合并？",function(){
	     ajaxOperate({urlWithData:'<%=rootPath%>/custinfo!saveCon.action?selID='+radioId+'&InfoId=<%=InfoId%>&TableId=<%=TableId%>&CENTERID=<%=CENTERID%>',tip:'合并',isconfirm:false,formId:'queryForm','callbackfunction':returnreflashparent});
       });
	}else{
	  whir_alert('请选择要合并的信息！',null);
	  return;
	}
}
function returnreflashparent() {
       window.opener.opener.refreshListForm('queryForm');
       window.opener.close();
	   window.close();
}
function add(){
   openWin({url:"<%=rootPath%>/custinfo!addCustInfo.action?CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>",isFull:'true',winName:"addCustInfo"});
}
function loadDetails(id){
  openWin({url:"<%=rootPath%>/custinfo!seeDetailsCustInfo.action?InfoId="+id+"&CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>",isFull:'true',winName:"seeDetailsCustInfo"+id});
}

<%
  List showJSData = (List)request.getAttribute("showJSData");
  //有链接
  if(showJSData!=null){
	String _jsName = "";
	String fieldId="";
	String fieldname="";
	String fieldshow="";
	String fieldvalue="";
	String fieldtype="";
	String[] pama1 = null;
	Object[] _obj = null;
    for (int i = 0; i < showJSData.size(); i++) {
		_obj = (Object[])showJSData.get(i);
		_jsName = _obj[0]+"";
		fieldId=_obj[5]+"";
		fieldname=_obj[1]+"";
		fieldshow = _obj[2]+"";
		fieldvalue = _obj[3]+"";
		fieldtype = _obj[4]+"";
%>

	   function <%=_jsName%>(po,i){
			var html='';
			var json = ajaxForSync("<%=rootPath%>/custinfo!getShowHTML.action","id="+po.id+"&value="+po.<%=fieldname%>+"&fieldId=<%=fieldId%>&fieldname=<%=fieldname%>&fieldshow=<%=fieldshow%>&fieldvalue=<%=fieldvalue%>&fieldtype=<%=fieldtype%>");
			html = json;
			return html;

        }
<%     
	}
  }
%>
  function show_radio(po,i){
     var html='<input type=\'radio\' name=\'radioId\' value=\''+po.id+'\' >';

	 return html;
  }
  function showoperate(po,i){
       var html='';
       <%if("1".equals(ModClassId)){%>
          html += '<img  style="cursor:pointer" border="0" src="<%=rootPath%>/images/xsxg.gif" title="查看" onclick="loadDetails(\''+po.id+'\')">';
	      html += '<img  style="cursor:pointer" border="0" src="<%=rootPath%>/images/del.gif" title="删除" onclick="del(\''+po.id+'\')">';
	   <%}else{%>
	     var json = ajaxForSync("<%=rootPath%>/custinfo!getShowOperateHTML.action","id="+po.id+"&tableId=<%=TableId%>&modClassId=<%=ModClassId%>");
		  html = "<a href=\"javascript:void(0)\" onclick=\"loadDetails('"+po.id+"');\">"+json+"</a>";
	   <%}%>
	   return html;

  }
  function del(id){

     var json = ajaxForSync("custinfo!checkHasLink.action","tabId=<%=TableId%>&InfoId="+id);
	 if(json=="1"){
        whir_confirm("您确定要删除吗？",function(){
	         ajaxOperate({urlWithData:'<%=rootPath%>/custinfo!delCustInfo.action?delid='+id+'&TableId=<%=TableId%>',tip:'删除',isconfirm:false,formId:'queryForm'});
        });
	 }else{
	    whir_confirm("该信息有关联信息，删除该信息将删除所有的关联信息，确定删除吗？",function(){
	         ajaxOperate({urlWithData:'<%=rootPath%>/custinfo!delCustInfo.action?delid='+id+'&TableId=<%=TableId%>',tip:'删除',isconfirm:false,formId:'queryForm'});
        });
	 }
   
 }
 function searchform() {
	  refreshListForm('queryForm');
 }

 function setAuth(type,setname){
   
   var CheckBoxIDs = getCheckBoxData("id","id");
   var ids="";
   if(type=="<%=CustomerCenterConfig.GIVEALLAUTH%>"|| 
	   type=="<%=CustomerCenterConfig.BACKALLAUTH%>"){
	     var json = ajaxForSync("<%=rootPath%>/custinfo!getAllDataIds.action","TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&CENTERID=<%=CENTERID%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>");

         ids = json;
   }else{   
        ids = CheckBoxIDs;
   }

   if(ids == ""){
      whir_alert('请选择要'+setname+'的信息！',null);
	  return;
   }else {
	   openWin({url:'<%=rootPath%>/custinfo!setAuth.action?infoIds='+ids+'&CENTERID=<%=CENTERID%>&ModClassId=<%=ModClassId%>&TableId=<%=TableId%>&AuthType='+type,isFull:'true',winName:"setAuth"});
   }
}

//导出
function exportInfo() {
	var url = '<%=rootPath%>/custinfo!exportInfo.action';
	commonExportExcel({formId:'queryForm', action:url});
}

</SCRIPT>
</html>  




