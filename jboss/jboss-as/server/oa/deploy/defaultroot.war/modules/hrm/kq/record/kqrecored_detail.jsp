<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%
    String whir_custom_str_new="detail";
	
	
%>

<html lang="zh-cn" class="<%=whir_2016_skin_color%> size-big" >
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>移动考勤详情</title>
    <%@ include file="/public/include/meta_base_2016.jsp"%>
	
    <%
	  Object[] objs = (Object[])request.getAttribute("objs");
	  
	System.out.println("====================="+objs[0]);
	%>
<body>

   <div class="wh-view wh-detail">
      <div class="container" style="padding-top:25px;width:800px;min-width:800px;">
    <div class="details-container details-container1 ">
          <div class="form-group col-wh-12 syfw">
                   <label class="control-label col-wh-2" for="签到人"  style="padding-right:0;width:120px;">签到人：</label>
                    <div class="input-group form-group col-wh-8">
					       <span><%=objs[0]%></span>
                    </div>
                    </div>
			<div class="form-group col-wh-12 syfw">
                   <label class="control-label col-wh-2" for=" 签到时间"  style="padding-right:0;width:120px;">签到时间：</label>
                    <div class="input-group form-group col-wh-8">
                        <span><%=objs[1]%></span>
                    </div>
                    </div>
			
			 <div class="form-group col-wh-12 syfw" id="tr_yearDays">
               <label class="col-wh-2 control-label"  style="padding-right:0;width:120px;">ip：</label>
               <div class="input-group form-group  col-wh-8">
                    <span><%=objs[2]%></span>
               </div>
             </div>
			 <div class="form-group col-wh-12 syfw" id="tr_yearDays">
               <label class="col-wh-2 control-label"  style="padding-right:0;width:120px;">地址：</label>
               <div class="input-group form-group  col-wh-8">
                     <span><%=objs[3]%></span>
               </div>
             </div>
			
			 <div class="form-group col-wh-12 syfw" id="tr_yearDays">
               <label class="col-wh-2 control-label"  style="padding-right:0;width:120px;">签到来源：</label>
               <div class="input-group form-group  col-wh-8">
			       <% if (String.valueOf(objs[4]).equals("1")){%>
                     <span>微信</span>
					 <%}%>
					  <% if (String.valueOf(objs[4]).equals("2")){%>
                     <span>EVO</span>
					 <%}%>
					  <% if (String.valueOf(objs[4]).equals("3")){%>
                     <span>钉钉</span>
					 <%}%>
               </div>
             </div>
			 <%if(!String.valueOf(objs[6]).trim().equals("")){%>
			 <div class="form-group col-wh-12 syfw" id="tr_yearDays">
               <label class="col-wh-2 control-label"  style="padding-right:0;width:120px;">上传图片：</label>
               <div class="input-group form-group  col-wh-8">
						<input type="hidden"  tempname="相关附件"   id="taskfjbcmc"  value="<%=String.valueOf(objs[6])%>"/>
						<input type="hidden"   id="taskfjwlmc" value="<%=String.valueOf(objs[5])%>"/>
						<jsp:include page="/public/upload/uploadify/upload_include.jsp" >
							<jsp:param name="accessType" value="include" />
							<jsp:param name="makeYMdir"	value="yes" />
							<jsp:param name="onInit" value="init" />
							<jsp:param name="onSelect" value="onSelect" />
							<jsp:param name="onUploadProgress"	value="onUploadProgress" />
							<jsp:param name="onUploadSuccess" value="onUploadSuccess" />
							<jsp:param name="dir" value="phonekq" />
							<jsp:param name="uniqueId" value="phonekq" />
							<jsp:param name="realFileNameInputId"    value="taskfjwlmc" />
							<jsp:param name="saveFileNameInputId"    value="taskfjbcmc" />
							<jsp:param name="canModify" value="no" />
							<jsp:param name="width"	value="90" />
							<jsp:param name="height" value="20" />
							<jsp:param name="multi" value="true" />
							<jsp:param name="buttonClass" value="upload_btn" />
							<jsp:param name="buttonText" value="上传文件" />
							<jsp:param name="fileSizeLimit"	value="0" />
							<jsp:param name="uploadLimit" value="0" />
							<jsp:param name="isShowBatchDownButton" value="no" />
						</jsp:include>
               </div>
             </div>
			 <%}%>
			  <%if(!String.valueOf(objs[7]).trim().equals("")){%>
			  <div class="form-group col-wh-12 syfw" id="tr_yearDays">
               <label class="col-wh-2 control-label"  style="padding-right:0;width:120px;">备注：</label>
               <div class="input-group form-group  col-wh-8">
                     <span><%=objs[7]%></span>
               </div>
             </div>
			<%}%>
		
        <div class="detail-btn clearfix"  style="padding-left:30px;">
                    <a class="btn btn-wh-line" href="javascript:void(0);" role="button" onclick="closeTaskWindow();">退出</a>
        </div>
    </div>
      </div>
   </div>
   <script>
   function closeTaskWindow(){
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.layer.close(index);//关闭
    }
   
   </script>
</body>
</html>