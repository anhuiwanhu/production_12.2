<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/public/include/init.jsp" %>
<%@ page isELIgnored="false" %>
<%
    String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=Resource.getValue(local, "Gov", "gov.bzymxxjg")%>
    </title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp" %>
    <%@ include file="/public/include/meta_detail.jsp" %>
    <%
        request.setCharacterEncoding("UTF-8");

        String fileTitle = request.getParameter("fileTitle") == null ? "" : request.getParameter("fileTitle").toString();
        fileTitle = com.whir.component.security.crypto.EncryptUtil.htmlcode(fileTitle);
        String byteNum = request.getParameter("receiveFileFileNumber") == null ? "" : request.getParameter("receiveFileFileNumber").toString();
        byteNum = com.whir.component.security.crypto.EncryptUtil.htmlcode(byteNum);
        String seqNum = request.getParameter("seqNum") == null ? "" : request.getParameter("seqNum").toString();
        seqNum = com.whir.component.security.crypto.EncryptUtil.htmlcode(seqNum);
        String sendRecordId = request.getParameter("sendRecordId") == null ? "" : request.getParameter("sendRecordId").toString();
        sendRecordId = com.whir.component.security.crypto.EncryptUtil.htmlcode(sendRecordId);
        String isMyReceiveDoc = request.getParameter("isMyReceiveDoc") == null ? "" : request.getParameter("isMyReceiveDoc").toString();
        isMyReceiveDoc = com.whir.component.security.crypto.EncryptUtil.htmlcode(isMyReceiveDoc);

        // 附件
        String accessoryName = request.getParameter("accessoryName") == null ? "" : request.getParameter("accessoryName").toString();
        String accessorySaveName = request.getParameter("accessorySaveName") == null ? "" : request.getParameter("accessorySaveName").toString();
        String accessorySaveNameNew = "";
        if (!accessorySaveName.equals("")) {
            String[] accefjNameArr = accessorySaveName.split("\\|");
            for (int i = 0; i < accefjNameArr.length; i++) {
                String accessorySaveNameNewTep = com.whir.integration.goldgrid.GoldGridUtil.copyAttachmentToMoudel(accefjNameArr[i], null, "govdocumentmanager", "govdocumentmanager", request);
                accessorySaveNameNew = accessorySaveNameNew + accessorySaveNameNewTep + "|";
            }
            accessorySaveNameNew = accessorySaveNameNew.substring(0, accessorySaveNameNew.length() - 1);
            accessorySaveName = accessorySaveNameNew;
        }
        accessoryName = com.whir.component.security.crypto.EncryptUtil.htmlcode(accessoryName);
        accessorySaveName = com.whir.component.security.crypto.EncryptUtil.htmlcode(accessorySaveName);
        // 正文
        String accessoryName1 = request.getParameter("accessoryName1") == null ? "" : request.getParameter("accessoryName1").toString();
        String accessorySaveName1 = request.getParameter("accessorySaveName1") == null ? "" : request.getParameter("accessorySaveName1").toString();
        accessoryName1 = com.whir.component.security.crypto.EncryptUtil.htmlcode(accessoryName1);
        accessorySaveName1 = com.whir.component.security.crypto.EncryptUtil.htmlcode(accessorySaveName1);

        String transSendFileId = request.getParameter("transSendFileId") == null ? "" : request.getParameter("transSendFileId").toString();

        String receiveFileSendFileUnitId = request.getParameter("receiveFileSendFileUnitId") == null ? "" : request.getParameter("receiveFileSendFileUnitId").toString();


        String receiveFileSendFileUnit = request.getParameter("receiveFileSendFileUnit") == null ? "" : request.getParameter("receiveFileSendFileUnit").toString();

        if (receiveFileSendFileUnit == null || "".equals(receiveFileSendFileUnit)) {
            receiveFileSendFileUnit = request.getParameter("sendFileWriteOrg") == null ? "" : request.getParameter("sendFileWriteOrg").toString();
        }
        receiveFileSendFileUnit = com.whir.component.security.crypto.EncryptUtil.htmlcode(receiveFileSendFileUnit);
        String receiveFileSafetyGrade = request.getParameter("receiveFileSafetyGrade") == null ? "" : request.getParameter("receiveFileSafetyGrade").toString();
        receiveFileSafetyGrade = com.whir.component.security.crypto.EncryptUtil.htmlcode(receiveFileSafetyGrade);
        String receiveFileQuantity = request.getParameter("receiveFileQuantity") == null ? "" : request.getParameter("receiveFileQuantity").toString();

        String field4 = request.getParameter("field4") == null ? "" : request.getParameter("field4").toString();
        field4 = com.whir.component.security.crypto.EncryptUtil.htmlcode(field4);
        String receiveFileType = request.getParameter("receiveFileType") == null ? "" : request.getParameter("receiveFileType").toString();

        String zjkyType = request.getParameter("zjkyType") == null ? "" : request.getParameter("zjkyType").toString();

        String zjkykeepTerm = request.getParameter("zjkykeepTerm") == null ? "" : request.getParameter("zjkykeepTerm").toString();

        String receiveFileDoComment = request.getParameter("receiveFileDoComment") == null ? "" : request.getParameter("receiveFileDoComment").toString();


        String tableId = request.getParameter("tableId") == null ? "" : request.getParameter("tableId").toString();
        tableId = com.whir.component.security.crypto.EncryptUtil.htmlcode(tableId);
        String slink = "GovDocSendProcess!viewfile.action?p_wf_recordId=" + sendRecordId + "&editType=0&canEdit=0&viewType=1&tableId=" + tableId;
        //String  slink="GovSendFileAction.do?action=listLoad&editId="+sendRecordId+"&editType=0&canEdit=0&viewType=1&tableId="+tableId;

        if (sendRecordId.equals("") || sendRecordId.equals("null")) {
            slink = "";
        }
        if (accessorySaveName1.endsWith(".doc")) {
            accessorySaveName1 = accessorySaveName1.replace(".doc", "");
            com.whir.govezoffice.documentmanager.bd.SenddocumentBD senddocumentBD = new com.whir.govezoffice.documentmanager.bd.SenddocumentBD();
            java.util.Map docMap = senddocumentBD.getGovDocumentExt(accessorySaveName1);
            if (null != docMap && null != docMap.get(accessorySaveName1)) {
                accessoryName1= accessoryName1.replace(".doc", "");
                accessoryName1= accessoryName1+".pdf";
                accessorySaveName1 = com.whir.integration.goldgrid.GoldGridUtil.coryGovDocToAttachmentBytype(accessorySaveName1, null, "govdocumentmanager",".pdf",request);
            } else {
                accessorySaveName1 = com.whir.integration.goldgrid.GoldGridUtil.coryGovDocToAttachment(accessorySaveName1, null, "govdocumentmanager", request);
            }
        }
        //将正文 拷贝成附件

        System.out.println("receiveFileSafetyGradereceiveFileSafetyGradereceiveFileSafetyGrade:::::::::::" + receiveFileSafetyGrade);
    %>
    <title><%=Resource.getValue(local, "Gov", "gov.zhuanshouwen")%>
    </title>

    <script>
        function addFile() {
            document.getElementById("uploadFrame").style.display = "inline";
        }
    </script>
</head>
<body scroll="no">


<div class="BodyMargin_10">
    <div class="docBoxNoPanel">

        <form name="webform" id="webform" method="post"
              action="/defaultroot/GovDocReceiveProcess!see.action?fromSendFile=1" target="_parent">
            <input type="hidden" name="noNeedfsjx" value="1">
            <input type="hidden" name="sendFileTitle" value="<%=fileTitle%>">
            <input type="hidden" name="byteNum" value="<%=byteNum%>">
            <input type="hidden" name="seqNum" value="<%=seqNum%>">
            <input type="hidden" name="p_wf_pool_processId">
            <input type="hidden" name="processName">
            <input type="hidden" name="p_wf_processType">
            <input type="hidden" name="p_wf_tableId">
            <input type="hidden" name="remindField">
            <input type="hidden" name="sendFileId" value="<%=sendRecordId%>">
            <input type="hidden" name="editId" value="<%=sendRecordId%>">
            <input type="hidden" name="accessoryName" value="<%=accessoryName%>">
            <input type="hidden" name="accessorySaveName" value="<%=accessorySaveName%>">
            <input type="hidden" name="accessoryName1" value="<%=accessoryName1%>"><!-- 正文 -->
            <input type="hidden" name="accessorySaveName1" value="<%=accessorySaveName1%>">

            <input type="hidden" name="sendFileLink" value="<%=slink%>">
            <input type="hidden" name="sendToReceive" value="1">
            <input type="hidden" name="transSendFileId" value="<%=transSendFileId%>">

            <input type="hidden" name="receiveFileSendFileUnitId" value="<%=receiveFileSendFileUnitId%>">
            <%
                if (receiveFileSendFileUnit != null && !receiveFileSendFileUnit.startsWith("怀远县电子政务办公系统")) {
                    // receiveFileSendFileUnit = receiveFileSendFileUnit.replaceAll("\\..*", "");
                } else if (receiveFileSendFileUnit != null) {
                    //receiveFileSendFileUnit = receiveFileSendFileUnit.replaceAll("[^.]*\\.[^.]*\\.([^.]*).*", "$1");
                }
            %>
            <input type="hidden" name="receiveFileSendFileUnit" value="<%=receiveFileSendFileUnit%>"><!-- 来文单位 -->
            <input type="hidden" name="receiveFileSafetyGrade" value="<%=receiveFileSafetyGrade%>"><!-- 秘密级别： -->
            <input type="hidden" name="receiveFileQuantity" value="<%=receiveFileQuantity%>"><!-- 份数： -->
            <input type="hidden" name="field4" value="<%=field4%>"><!-- 紧急程度： -->
            <input type="hidden" name="receiveFileType" value="<%=receiveFileType%>"><!-- 文件归类： -->
            <input type="hidden" name="zjkyType" value="<%=zjkyType%>"><!--文种：-->
            <input type="hidden" name="zjkykeepTerm" value="<%=zjkykeepTerm%>"><!-- 保管期限： -->
            <input type="hidden" name="receiveFileDoComment" value="<%=receiveFileDoComment%>"><!-- 批示内容 -->
            <input type="hidden" name="p_wf_processType">
            <input type="hidden" name="isMyReceiveDoc" value="<%=isMyReceiveDoc%>"><!-- 转收文标识 -->

            <%//=request.getAttribute("javax.servlet.forward.query_string")%>
            <%

                //java.util.List receivefilelist = new com.whir.ezoffice.workflow.newBD.ProcessBD().getUserProcess(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), "3");
                com.whir.ezoffice.bpm.bd.BPMProcessBD procbd = new com.whir.ezoffice.bpm.bd.BPMProcessBD();
                java.util.List receivefilelist = procbd.getUserProcessListWithNoPackage(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), null, "3", null);


            %>
            <script language="javascript">
                var receiveFileProcArr = new Array(<%=receivefilelist.size()%>);
            </script>

            <table class="Table_bottomline" border="0" cellpadding="0" cellspacing="0">

                <tr>
                    <td></td>
                    <td><%=Resource.getValue(local, "Gov", "gov.qxzswlc")%>：</td>
                    <td>
                        <div class="whir_radiolist">
                            <label class="whir_label">
                                <select id="dept" class="selectlist" name="docReceiveFileProc"
                                        onchange="chReceiveFileProc(this);" style="width:200px;">
                                    <option value="0">---------<%=Resource.getValue(local, "common", "comm.select1")%>
                                        ------
                                    </option>
                                    <%
                                        Object[] rfObj = null;
                                        String receiveFileProcessId, receiveFileProcessName, receiveFileProcessType, receiveFileTableId, receiveFileRemindField;
                                        for (int i = 0; i < receivefilelist.size(); i++) {
                                            rfObj = (Object[]) receivefilelist.get(i);
                                            receiveFileProcessId = rfObj[0] + "";
                                            receiveFileProcessName = rfObj[1] + "";
                                            receiveFileProcessType = rfObj[2] + "";
                                            receiveFileTableId = rfObj[4] + "";
                                            receiveFileRemindField = rfObj[6] == null ? "" : rfObj[6] + "";
/* receiveFileProcessId = rfObj[2] + "" ;
receiveFileProcessName = rfObj[3] + "";
receiveFileProcessType = rfObj[5] + "";
receiveFileTableId = rfObj[4] + "";
receiveFileRemindField = rfObj[6]==null?"":rfObj[6] + "";*/
                                    %>
                                    <script language="javascript">
                                        receiveFileProcArr[<%=i%>] = new Array("<%=receiveFileProcessId%>", "<%=receiveFileProcessName%>", "<%=receiveFileProcessType%>", "<%=receiveFileTableId%>", "<%=receiveFileRemindField%>");
                                    </script>
                                    <option <%if(receivefilelist.size()==1){%>selected="selected"<%}%>
                                            value="<%=receiveFileProcessId%>"><%=receiveFileProcessName%>
                                    </option>
                                    <%}%>
                                </select>
                            </label>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input name="" type="button" value="<%=Resource.getValue(local,"common","comm.create")%>"
                               class="btnButton4font" onClick="newDocReceiveFile()"/>
                        <input name="" type="button" value="<%=Resource.getValue(local,"common","comm.exit")%>"
                               class="btnButton4font" onClick="closeit()"/>
                    </td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
</html>

<script>
    <%
    if(receivefilelist.size() == 1){
    %>
    chReceiveFileProc(document.getElementById("dept"));
    newDocReceiveFile();
    <%
    }
    %>
    function newDocReceiveFile() {
        //alert(document.getElementsByName("sendFileTitle")[0].value);
        if (document.getElementsByName("docReceiveFileProc")[0].value == 0) {
            whir_alert("<%=Resource.getValue(local,"Gov","gov.qxzswlc")%>");
        } else {

            var myDatestr = "" + new Date().getTime();

        <%
          String userAgent = request.getHeader("User-Agent");
          if( userAgent != null && userAgent.indexOf("OPR") >= 0){
          %>
            openWin({url:"", isFull:true, winName:'ec' + myDatestr});
            // window.open("", "ec"+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
            document.webform.target = "ec" + myDatestr;
            document.webform.submit();
            //var api = frameElement.api, W = api.opener; api.close();
            window.close();
        <%}else{%>
            document.webform.submit();
        <%}%>
        }
    }

    function chReceiveFileProc(obj) {
        for (var i = 0; i < receiveFileProcArr.length; i++) {
            if (receiveFileProcArr[i][0] == obj.value) {
                document.webform.p_wf_pool_processId.value = receiveFileProcArr[i][0];
                document.webform.processName.value = receiveFileProcArr[i][1];
                document.webform.p_wf_processType.value = receiveFileProcArr[i][2];
                document.webform.p_wf_tableId.value = receiveFileProcArr[i][3];
                document.webform.remindField.value = receiveFileProcArr[i][4];
                break;
            }
        }

    }

</script>

<SCRIPT LANGUAGE="JavaScript">
    //保存
    //$:userId
    //*:orgId
    //@:groupId
    function include_save() {
        window.close();
    }
    function closeit() {

        if (frameElement == undefined) {
            window.close();
        } else {
            var api = frameElement.api; //, W = api.opener
            api.close();
        }
    }
    //-->
</SCRIPT>
