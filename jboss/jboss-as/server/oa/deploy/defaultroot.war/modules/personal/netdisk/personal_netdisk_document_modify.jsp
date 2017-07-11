<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.ezoffice.netdisk.po.NetDiskPO" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
NetDiskPO netdiskPO=request.getAttribute("netdiskPO")!=null?(NetDiskPO)request.getAttribute("netdiskPO"):null;
com.whir.component.security.crypto.EncryptUtil encryptUtil = new com.whir.component.security.crypto.EncryptUtil() ;
String currenid = encryptUtil.htmlcode(request.getParameter("currenid"));
String userName = session.getAttribute("userName")==null?"":session.getAttribute("userName").toString();

%>
<head>  
	<title><s:text name="webdisk.modifydocument"/></title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%> 
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">
        <div class="docBoxNoPanel">
		    <s:form name="dataForm" id="dataForm" action="netdisk!modiDocument.action" method="post" theme="simple" >  
                <%@ include file="/public/include/form_detail.jsp"%>
        		<input type="hidden" id="content" name="content" value="<%=netdiskPO.getFileName()!=null?netdiskPO.getFileName():""%>">
            	<input type="hidden" name="editType" value="<%=netdiskPO.getFileType()!=null?netdiskPO.getFileType().toString():""%>">
            	<input id="fileIdtemp" type="hidden" name="fileId" value="<%=netdiskPO.getFileId()!=null?netdiskPO.getFileId().toString():""%>">
            	<input type="hidden" name="currenid" value="<%=currenid%>">
            	
		    	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="<s:text name="webdisk.filename"/>" width="100" class="td_lefttitle" nowrap="nowrap">  
                           	 <s:text name="webdisk.filename"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td> 
						     <input type="text" name="title" id="title" value="<%=netdiskPO.getFileSaveName()!=null?netdiskPO.getFileSaveName():""%>" maxlength="50" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']" class="inputText" style="width:96%;"/>
                        </td>
                    </tr>  
                    <tr id="tr_HTML">  
                        <td></td>
                        <td> 
						     <textarea name="htmlContent" id="htmlContent" style="display:none"><%if(netdiskPO.getFileType().toString().equals("2")){%><%=netdiskPO.getFileContent()!=null?netdiskPO.getFileContent():""%><%}%></textarea>
						     <iframe id="ewebeditorIFrame" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=htmlContent&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="97%" height="350"></iframe>
                        </td>  
                    </tr>
				    <tr id="tr_TEXT" style="display:none">
				        <td></td>
				        <td>
				        	<textarea style="width:95%" rows="20" Class="inputtextarea" name="textContent"><%if(netdiskPO.getFileType().toString().equals("3")){%><%=netdiskPO.getFileContent()!=null?netdiskPO.getFileContent():""%><%}%></textarea>
				        </td>
					</tr>
				
				    <tr id="tr_WORD" style="display:none">
		                <td></td>
		                <td>
		                   <div onclick="openWin({url:'<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID=<%=netdiskPO.getFileName()!=null?netdiskPO.getFileName():""%>&EditType=1&UserName=<%=userName%>&ShowSign=0&CanSave=1&moduleType=netdisk&saveHtmlImage=0&saveDocFile=1&FileType=.doc&showSignButton=1&showEditButton=1&saveHtml=0&showTempSign=-1&showTempHead=-1',isfull:'yes'});" style="margin-bottom:10px;padding-top:3px;height:19px;width:94px;background:#fff;border:1px solid #808080;text-align:center;cursor:pointer;" onclick="deleteUploadedFile_hrm();"><s:text name="webdisk.WORDEditor"/><span class="MustFillColor">*</span></div>
		                </td>
					</tr>
				    <tr id="tr_EXCEL" style="display:none">
		                <td></td>
		                <td>
		                    <div onclick="openWin({url:'<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID=<%=netdiskPO.getFileName()!=null?netdiskPO.getFileName():""%>&EditType=1&UserName=<%=userName%>&ShowSign=0&CanSave=1&moduleType=netdisk&saveHtmlImage=0&saveDocFile=1&FileType=.xls&showSignButton=1&showEditButton=1&saveHtml=0&showTempSign=-1&showTempHead=-1',isfull:'yes'});" style="margin-bottom:10px;padding-top:3px;height:19px;width:94px;background:#fff;border:1px solid #808080;text-align:center;cursor:pointer;" onclick="deleteUploadedFile_hrm();"><s:text name="webdisk.EXCELEditor"/><span class="MustFillColor">*</span></div>
		                </td>
					</tr>

                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap>  
							<input type="button" id="savebutton"  class="btnButton4font" onClick="ok_extend(0,this);" value="<s:text name="comm.saveclose"/>" />
                            <input type="button" id="resetbutton" class="btnButton4font" onClick="resetDataForm(this);"     value="<s:text name="comm.reset"/>" />
                            <input type="button" class="btnButton4font" onClick="window.close();" value="<s:text name="comm.exit"/>" />  
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
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":comm.savetips});
	
	$(document).ready(function(){
		initPage();
        getcurrentUser() ;
	});

	function ok_extend(type,obj){
		var vType = '<%=netdiskPO.getFileType().toString()%>';
		//alert('vType=[' + vType + ']');
		if(vType=="2"){
	        var o_Editor = document.getElementById("ewebeditorIFrame").contentWindow;
		    $("#htmlContent").val(o_Editor.getHTML());
		    $("#content").val(o_Editor.getHTML());
	  	}else if(vType=="4"){
	        if($("#content").val()==''){
	            $.dialog.alert("<%=Resource.getValue(whir_locale,"personalwork","webdisk.Pleaseeditewordthebody")%>");
	            return;
	        }
	  	}else if(vType=="5"){
	        if($("#content").val()==''){
	            $.dialog.alert("<%=Resource.getValue(whir_locale,"personalwork","webdisk.Pleaseeditexcelthebody")%>");
	            return;
	        }
	  	}
			
		ok(type,obj);
	}
	
	function initPage(){
		var editType = '<%=netdiskPO.getFileType().toString()%>';
	    if(editType=="2"){//html编辑
	    	$('#tr_HTML').css('display','');
	    	$('#tr_TEXT').css('display','none');
	    	$('#tr_WORD').css('display','none');
	    	$('#tr_EXCEL').css('display','none');
	    	$('#content').val('');
	    }else if(editType=="3"){//文本编辑
	    	$('#tr_HTML').css('display','none');
	    	$('#tr_TEXT').css('display','');
	    	$('#tr_WORD').css('display','none');
	    	$('#tr_EXCEL').css('display','none');
	    	$('#content').val('');
	    }else if(editType=="4"){//word编辑
	    	$('#tr_HTML').css('display','none');
	    	$('#tr_TEXT').css('display','none');
	    	$('#tr_WORD').css('display','');
	    	$('#tr_EXCEL').css('display','none');
	    }else if(editType=="5"){//excel编辑
	    	$('#tr_HTML').css('display','none');
	    	$('#tr_TEXT').css('display','none');
	    	$('#tr_WORD').css('display','none');
	    	$('#tr_EXCEL').css('display','');
	    }
	}
	function locktable(){
        var jlid=$("#fileIdtemp").val();
        $.post("/defaultroot/netdisk!oalockSave.action",
                {
                    jlid:jlid
                },function(){});
    }
    function getcurrentUser(){
        var jlid=$("#fileIdtemp").val();
        $.post("/defaultroot/netdisk!getcurrentUser.action",
                {
                    jlid:jlid
                },function(data){
                   var result=eval("("+data+")");
                    if(result.data.tempflag=="true"){
                        if(result.data.currentusername!="<%=userName%>") {
                        whir_alert(result.data.currentusername+"正在编辑此文档!",function(){
                            $("#resetbutton").attr("disabled","disabled");
                            $("#savebutton").attr("disabled","disabled");
                        });
                        }
                    } else{
                        locktable();
                        setInterval("locktable()",15000);//1000为1秒钟
                    }
                });
    }
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
</script>
</html>