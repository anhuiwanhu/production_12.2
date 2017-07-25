<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.examination.bd.*,com.whir.ezoffice.examination.po.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>试卷评阅</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<%
Long id = new Long(0);
if(request.getAttribute("id") != null ){
       id = new Long(request.getAttribute("id").toString());
}else{
       id = new Long(request.getParameter("id").toString());
}

String curUserID = request.getParameter("empID")!=null?request.getParameter("empID"):"";
if(request.getAttribute("curUserID") != null ){
      curUserID = request.getAttribute("curUserID").toString();
}

String answerID = request.getParameter("answerID")!=null?request.getParameter("answerID"):"";
ExaminationManagePO  managePO = new ExaminationManageBD().load(id);

String examName = managePO.getExamName();

Long radioMark = managePO.getRadioMark();
String radioIds = managePO.getRadioIds();

Long checkMark = managePO.getCheckMark();
String checkIds = managePO.getCheckIds();

Long questionMark = managePO.getQuestionMark();
String questionIds = managePO.getQuestionIds();

String title[] = {"一","二","三","四"};
int  i = -1;
%>

<body class="Pupwin"  >
<form name="dataForm" id="dataForm" action="${ctx}/hrmexammanage!paper_list_answer_complete.action"  method="post"  >
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="answerID" value="<%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(answerID)%>">
    <input type="hidden" name="curUserID" value="<%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(curUserID)%>">

    <div class="">  
        <div class="">
            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                <tr>
                     <td colspan="2" align="center"><span style="font-size: 18px;font-weight: bold;"><%=com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(examName)%></span></td>
                </tr>
            <% 
                if(radioIds != null && !radioIds.replaceAll(",","").trim().equals("")){
                    i++;
            %>
                    <tr>         
                        <td colspan="2"><strong><%=title[i]%>、单选题（每题<%=radioMark%>分）&nbsp;&nbsp;&nbsp;该大题得分<input type="text" class="inputText" style="width:3%;" name="radiomark" size="3" readonly="true" value="<%=new ExaminationManageBD().getScore(id.toString(),curUserID,"1")%>">分</strong></td>
                    </tr>
                <%
                    if(!radioIds.equals("")){
                        if(radioIds.length() >0){
                            radioIds = radioIds.substring(1,radioIds.length()-1);
                        }
                        String stockSel[] = radioIds.split(",,");
                        for(int j = 0 ; j < stockSel.length ; j ++){
                            ExaminationStockPO po = new ExaminationStockPO();
                            po = new ExaminationStockBD().load(new Long(stockSel[j]));
                            ExaminationAnswerItemPO eaipo = new ExaminationManageBD().loadPaper(id,new Long(curUserID),stockSel[j]);
                            Set examinationItem = po.getExaminationItem();
                %>
                            <tr>
                                <td width="5%"><%if(eaipo.getIsRight().equals("1")){%><img src="<%=rootPath%>/images/right.gif" border="0"/><%}else{%><img src="<%=rootPath%>/images/wrong.gif" border="0"/><%}%><%=j+1%>. </td>
                                <td width="95%"><%=po.getSubject()%></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <%
                                Iterator iter = examinationItem.iterator();
                                ExaminationItemPO itempo = null;
                                while(iter.hasNext()){
                                    itempo = (ExaminationItemPO)iter.next();
                            %>
                                    <input type="radio" name="rd<%=po.getExaminationID()%>" value="<%=itempo.getItemID()%>" <%if(eaipo.getMyResult().indexOf(""+itempo.getItemID())>-1){%>checked<%}%>><%if(itempo.getIsResult().equals("1")){%><font color="red"><%=itempo.getOrderCode()%>、<%=itempo.getItemOption()%></font><%}else{%><%=itempo.getOrderCode()%>、<%=itempo.getItemOption()%><%}%> &nbsp;&nbsp;
                            <%
                                }
                            %>
                                </td>
                            </tr>
                <%
                        }
                    }
                %>
            <%
                }
            %>
            <% 
                if(checkIds != null && !checkIds.replaceAll(",","").trim().equals("")){
                    i++;
            %>
                    <tr>   
                        <td colspan="2"><strong><%=title[i]%>、多选题（每题<%=checkMark%>分）&nbsp;&nbsp;&nbsp;该大题得分<input class="inputText" style="width:3%;" type="text" name="checkmark" size="3" readonly="true" value="<%=new ExaminationManageBD().getScore(id.toString(),curUserID,"2")%>">分</strong></td>
                    </tr>
                <%
                    if(!checkIds.equals("")){
                        if(checkIds.length() >0){
                            checkIds = checkIds.substring(1,checkIds.length()-1);
                        }
                        String stockSel[] = checkIds.split(",,");
                        for(int j = 0 ; j < stockSel.length ; j ++){    
                            ExaminationStockPO po = new ExaminationStockPO();
                            po = new ExaminationStockBD().load(new Long(stockSel[j]));
                            Set examinationItem = po.getExaminationItem();    
                            ExaminationAnswerItemPO eaipo = new ExaminationManageBD().loadPaper(id,new Long(curUserID),stockSel[j]);
                %>
                            <tr>
                                <td width="5%"><%if(eaipo.getIsRight().equals("1")){%><img src="<%=rootPath%>/images/right.gif" border="0"/><%}else{%><img src="<%=rootPath%>/images/wrong.gif" border="0"/><%}%><%=j+1%>. </td>
                                <td width="95%"><%=po.getSubject()%></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <%
                                Iterator iter = examinationItem.iterator();
                                ExaminationItemPO itempo = null;
                                while(iter.hasNext()){
                                    itempo = (ExaminationItemPO)iter.next();
                            %>
                                    <input type="checkbox" name="cbx<%=po.getExaminationID()%>" value="<%=itempo.getItemID()%>" <%if(eaipo.getMyResult().indexOf(""+itempo.getItemID())>-1){%>checked<%}%>><%if(itempo.getIsResult().equals("1")){%><font color="red"><%=itempo.getOrderCode()%>、<%=itempo.getItemOption()%></font><%}else{%><%=itempo.getOrderCode()%>、<%=itempo.getItemOption()%><%}%>  &nbsp;&nbsp;
                            <%
                                }
                            %>
                                </td>
                            </tr>
                <%
                        }
                    }
                %>
            <%
                }
            %>
            <% 
                if(questionIds != null && !questionIds.replaceAll(",","").trim().equals("")){
                    i++;
            %>
                    <tr>         
                        <td colspan="2"><strong><%=title[i]%>、问答题（每题<%=questionMark%>分）<input type="hidden" name="questionMark" id="questionMark" value="<%=questionMark%>"></strong> </td>
                    </tr>
                <%
                    if(!questionIds.equals("")){
                        if(questionIds.length() >0){
                            questionIds = questionIds.substring(1,questionIds.length()-1);
                        }
                        String stockSel[] = questionIds.split(",,");
                        for(int j = 0 ; j < stockSel.length ; j ++){    
                            ExaminationStockPO po = new ExaminationStockPO();
                            po = new ExaminationStockBD().load(new Long(stockSel[j]));    
                            ExaminationAnswerItemPO eaipo = new ExaminationManageBD().loadPaper(id,new Long(curUserID),stockSel[j]);
                %>
                            <tr>
                                <td colspan="2"><%=j+1%>. 该题得分:<input type="text" class="inputText" style="width:3%;" name="score<%=po.getExaminationID()%>" value="<%=eaipo.getMark()%>" size="3" maxlength="2" onkeyup="check(this);" onblur="if(this.value==''){this.value=0;}" /></td>
                            </tr>
                            <tr>
                                <td colspan="2"><%=po.getSubject()%> </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <textarea rows="4" name="ask<%=po.getExaminationID()%>" id="ask<%=po.getExaminationID()%>"  class="inputTextarea" style="width:98%" readonly="true"><%=eaipo.getMyResult()==null?"":eaipo.getMyResult()%></textarea>
                                    <textarea rows="4" name="ask<%=po.getExaminationID()%>" id="aask<%=po.getExaminationID()%>"   class="inputTextarea" style="width:98%" >参考答案:<%=eaipo.getExaminationResult()%></textarea>
                                </td>
                            </tr>
                <%
                        }
                    }
                %>
            <%
                }
            %>
                <tr>
                    <td colspan="2" align="center">
                        <input type="button" class="btnButton4font" style="cursor:pointer" onClick="javascript:save(this);" value="阅卷完毕" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</form>
</body>

<script language="javascript">

//设置表单为异步提交
$(document).ready(function(){
    initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'提交'});
    $("input[type='radio'],input[type='checkbox'],textarea").attr("disabled",true);
	autoTextarea($("input[type='radio'],input[type='checkbox'],textarea"));
});

function check(obj){
    var reg = new RegExp(/^\d+$/);
    if(!reg.test(obj.value)){
        obj.value = "";
    }
    
    if( eval(obj.value) > eval($("#questionMark").val())){
        obj.value = $("#questionMark").val() ;
    }
}

function save(obj){
    whir_confirm("阅卷完毕，确认提交吗？",function(){
        $(obj).parents("form").find("#saveType").val(0);
        $("#dataForm").submit();
    });
}
//多文本框自适应高度
var autoTextarea = function (elem, extra, maxHeight) {  
        //判断elem是否为数组  
       if(elem.length > 0){  
            for(var i = 0; i < elem.length; i++ ){  
               e(elem[i]);  
            }  
        }  
        else{  
            e(elem);  
        }  
  
        function e(elem){  
        extra = extra || 0;  
        var isFirefox = !!document.getBoxObjectFor || 'mozInnerScreenX' in window,  
        isOpera = !!window.opera && !!window.opera.toString().indexOf('Opera'),  
                addEvent = function (type, callback) {  
                        elem.addEventListener ?  
                                elem.addEventListener(type, callback, false) :  
                                elem.attachEvent('on' + type, callback);  
                },  
                getStyle = elem.currentStyle ? function (name) {  
                        var val = elem.currentStyle[name];  
  
                        if (name === 'height' && val.search(/px/i) !== 1) {  
                                var rect = elem.getBoundingClientRect();  
                                return rect.bottom - rect.top -  
                                        parseFloat(getStyle('paddingTop')) -  
                                        parseFloat(getStyle('paddingBottom')) + 'px';          
                        };  
   
                        return val;  
                } : function (name) {  
                                return getComputedStyle(elem, null)[name];  
                },  
                minHeight = parseFloat(getStyle('height'));  
   
        elem.style.resize = 'none';  
   
        var change = function () {  
                var scrollTop, height,  
                        padding = 0,  
                        style = elem.style;  
   
                if (elem._length === elem.value.length) return;  
                elem._length = elem.value.length;  
   
                if (!isFirefox && !isOpera) {  
                        padding = parseInt(getStyle('paddingTop')) + parseInt(getStyle('paddingBottom'));  
                };  
                scrollTop = document.body.scrollTop || document.documentElement.scrollTop;  
   
                elem.style.height = minHeight + 'px';  
                if (elem.scrollHeight > minHeight) {  
                        if (maxHeight && elem.scrollHeight > maxHeight) {  
                                height = maxHeight - padding;  
                                style.overflowY = 'auto';  
                        } else {  
                                height = elem.scrollHeight - padding;  
                                style.overflowY = 'hidden';  
                        };  
                        style.height = height + extra + 'px';  
                        scrollTop += parseInt(style.height) - elem.currHeight;  
                        document.body.scrollTop = scrollTop;  
                        document.documentElement.scrollTop = scrollTop;  
                        elem.currHeight = parseInt(style.height);  
                };  
        };     
        addEvent('propertychange', change);  
        addEvent('input', change);  
        addEvent('focus', change);  
        change();  
		}  
};  

</script>
</html>