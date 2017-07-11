<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.whir.ezoffice.customdb.customdb.bd.CustomDatabaseBD" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>设置自动编号</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/public/include/meta_base.jsp"%>
<%@ include file="/public/include/meta_detail.jsp"%>
<script language="JavaScript">
var api = frameElement.api, W = api.opener;

function openNew(theURL) { //v2.0
  window.open(theURL,"","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
}
</script>
<%
request.setCharacterEncoding("UTF-8");
String fieldId= request.getParameter("fieldId");
String index= request.getParameter("index");

String fieldname = request.getParameter("fieldname");
String value = request.getParameter("value");

String[] initValue = {"[N]","","","","",""};
if(value!=null && value.split("=").length>=5){
    initValue[0] = value.split("=")[0];
    initValue[1] = value.split("=")[1];
    initValue[2] = value.split("=")[2];
    initValue[3] = value.split("=")[3];
    initValue[4] = value.split("=")[4];
    if(value.split("=").length>=7){
        initValue[5] = value.split("=")[6];
    }
}
%>
</head>
<body class="MainFrameBox">
    <div class="BodyMargin_10">
        <div class="_docBoxNoPanel">

<form name="dataForm" id="dataForm" action="" method="post">

<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
		<tr>
            <td width="140" nowrap="nowrap">编号头是否有部门简称：</td>
            <td>
				<input type="radio" name="hasOrgName" value="[OrgName]" onclick="hasOrgNameFunc(this);" <%=initValue[0].indexOf("[OrgName]")!=-1?"checked='checked'":""%> />有&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="hasOrgName" value="" <%=initValue[0].indexOf("[OrgName]")<0?"checked='checked'":""%> onclick="hasOrgNameFunc(this);"/>无
                &nbsp;&nbsp;
                <label class="MustFillColor">注：部门简称指的是流程发起人的部门简称。</label>
            </td>
        </tr>
		<tr>
            <td nowrap="nowrap">编号头是否有年月日：</td>
            <td>
				<input type="radio" name="hasYear" value="[年度]" onclick="hasYearFunc(this);" <%=initValue[0].indexOf("[年度]")!=-1?"checked='checked'":""%>/>年度&nbsp;&nbsp;
				<input type="radio" name="hasYear" value="[年月]" onclick="hasYearFunc(this);" <%=initValue[0].indexOf("[年月]")!=-1?"checked='checked'":""%>/>年月&nbsp;&nbsp;
				<input type="radio" name="hasYear" value="[年月日]" onclick="hasYearFunc(this);" <%=initValue[0].indexOf("[年月日]")!=-1?"checked='checked'":""%>/>年月日&nbsp;&nbsp;
				<input type="radio" name="hasYear" value="" <%=initValue[0].indexOf("[年度]")<0&&initValue[0].indexOf("[年月]")<0&&initValue[0].indexOf("[年月日]")<0?"checked='checked'":""%> onclick="hasYearFunc(this);"/>无
            </td>
        </tr>
		<tr>
            <td width="140" nowrap="nowrap">跨年度是否重排流水号：</td>
            <td>
				<input type="radio" name="isResort" value="[Y]" onclick="isResortFunc(this);" <%=initValue[0].indexOf("[Y]")!=-1?"checked='checked'":""%> />是&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="isResort" value="[N]" <%=initValue[0].indexOf("[Y]")<0?"checked='checked'":""%> onclick="isResortFunc(this);"/>否
            </td>
        </tr>

    	<tr>
            <td nowrap="nowrap" for="编号头">编号头<label class="MustFillColor">*</label>：</td>
            <td>
				<input type="text" id="codeHead" name="codeHead" class="inputText" style="width:350px;" value="<%=initValue[0]%>" whir-options="vtype:['notempty']"/>
                <input type="button" class="btnButton4font" onclick="setCodeHead();" value="设置">
            </td>
        </tr>
		<tr>
            <td nowrap="nowrap"></td>
            <td>
				<label class="MustFillColor">中括号[]不可删除。</label>
            </td>
        </tr>
		<tr>
        	<td for="起始值">起始值<label class="MustFillColor">*</label>：</td>
            <td>
				<input type="text" id="intialCode" name="intialCode" class="inputText" style="width:400;" value="<%=initValue[1]%>" whir-options="vtype:['notempty']" maxlength="10"/>
            </td>
        </tr>
		<tr>
        	<td>填充值：</td>
            <td>
				<input type="text" id="codeInsert" name="codeInsert" class="inputText" maxlength="1" style="width:400;" value="<%=initValue[2]%>" onKeypress="fillCodeInsert(event);"/>
            </td>
        </tr>
		<tr>
        	<td for="填充长度">填充长度：</td>
            <td>
				<input type="text" id="codeLen" name="codeLen" class="inputText" style="width:400;" value="<%=initValue[3]%>" maxlength="10"/>
            </td>
        </tr>
		<tr>
        	<td for="增长步长">增长步长<label class="MustFillColor">*</label>：</td>
            <td>
				<input type="text" id="codeAdd" name="codeAdd" class="inputText" style="width:400;" value="<%=initValue[4]%>" whir-options="vtype:['notempty']" maxlength="5"/>
            </td>
        </tr>
		<tr>
		<tr>
            <td nowrap="nowrap">编号尾：</td>
            <td>
				<input type="text" id="codeTail" name="codeTail" class="inputText" style="width:400;" value="<%=initValue[5]%>"/>
            </td>
        </tr>

        <tr>                       
			<td colspan=3>
				<input type="button" class="btnButton4font" onclick="javascript:save();" value="保存退出">
                <input type="button" class="btnButton4font" onclick="resetThisForm(this);" value="重&nbsp;&nbsp;&nbsp;置">
                <input type="button" class="btnButton4font" onclick="closeWin();" value="退&nbsp;&nbsp;&nbsp;出">
		  	</td>
    	</tr>
</table>
</form>
</div>
    </div>
</body>
<script language="javascript">
function fillCodeInsert(evt) {
    var event = window.event ? window.event:evt;
    var keyCode = window.event ? window.event.keyCode:evt.which;

    if (keyCode == 48 || (keyCode > 64 && keyCode < 91) || (keyCode > 96 && keyCode < 123)) {
        event.returnValue = true;
    } else {
        event.returnValue = false;
    }
}

function save() {
    var validation = validateForm('dataForm');

    if(validation == false) return ;

    var intialCode = $('#intialCode').val();
    if (!isValidNum(intialCode)) {
        whir_alert("数据不正确，起始值只允许为数字！", null);
        $('#intialCode').val('');
        $('#intialCode').focus();
        return false;
    }

    var codeInsert = $('#codeInsert').val();
    var codeLen = $('#codeLen').val();
    if (codeInsert != "") {
        var checkNum = '123456789';
        for (var i = 0; i < 9; i++) {
            var codeInsert_ = codeInsert;
            if (codeInsert_.indexOf(checkNum.charAt(i)) != -1) {
                whir_alert("填充值不允许为数字1-9！", null);
                return false;
            }
        }

        if(codeLen == ''){
            whir_poshytip($('#codeLen'), '填充长度不能为空！');
            return false;
        }
    }
    
    if (!isValidNum(codeLen)) {
        whir_alert("数据不正确，填充长度只允许为数字！", null);
        $('#codeLen').val('');
        $('#codeLen').focus();
        return false;
    }

    var codeAdd = $('#codeAdd').val();
    if (!isValidNum(codeAdd)) {
        whir_alert("数据不正确，增长步长只允许为数字！", null);
        $('#codeAdd').val("1");        
        $('#codeAdd').focus();
        codeAdd = "1";
        return false;
    }

    var codeHead = $('#codeHead').val();
    if (!(codeHead.indexOf("[年度]") != -1 ||
        codeHead.indexOf("[年月]") != -1 ||
        codeHead.indexOf("[年月日]") != -1 ||
        codeHead.indexOf("[Y]") != -1 ||
        codeHead.indexOf("[N]") != -1)) {
        whir_alert("编号头格式不正确，请重新更正！", null);
        $('#codeHead').focus();
        return false;
    }

    var codeTail = $('#codeTail').val();
    if (codeTail != "") {
        var codeTail_ = codeTail;
        if (/^([\d]{1})([\w]*)$/g.test(codeTail_)) {
            whir_alert("编号尾不能以数字开头！", null);
            $('#codeTail').focus();
            return false;
        }

        if (codeTail_.indexOf("'") != -1 || codeTail_.indexOf('"') != -1 || codeTail_.indexOf('\\') != -1 || codeTail_.indexOf('/') != -1 || codeTail_.indexOf('?') != -1) {
            whir_alert("编号尾不能含有特殊字符 ' \" \\ / ? ！", null);
            $('#codeTail').focus();
            return false;
        }
        
        if(codeTail.length>10){
         	whir_alert("编号尾长度不能超过10个字符 ！", null);
            $('#codeTail').focus();
            return false;
        }
    }

    if (W.document.getElementsByName("fieldvalue").length>1) {
        W.document.getElementsByName("fieldvalue")[<%=index%>].value = codeHead + "=" + intialCode + "=" + codeInsert + "=" + codeLen + "=" + codeAdd + "=" + intialCode + "=" + codeTail;
    } else {
        W.document.getElementsByName("fieldvalue")[0].value = codeHead + "=" + intialCode + "=" + codeInsert + "=" + codeLen + "=" + codeAdd + "=" + intialCode + "=" + codeTail;
    }

    var validation = validateForm('dataForm');
	if(validation){
		api.close();
	}
}

function isValidNum(strExp) {
    var i = 0,
        len = 0;
    var strTemp = strExp.toString();
    len = strTemp.length;
    for (i = 0; i < len; i++) {
        var ch = strTemp.charAt(i); //得到指定下标的字符
        if (!(ch >= '0' && ch <= '9')) {
            //alert("年龄必须为整数,请填写正确数据! ");
            return false;
        }
    }
    return true;
}

function isValidFloat(strExp) {
    var i = 0,
        len = 0;
    var strTemp = strExp.toString();
    len = strTemp.length;
    for (i = 0; i < len; i++) {
        var ch = strTemp.charAt(i); //得到指定下标的字符
        if (!((ch >= '0' && ch <= '9') || ch == '.')) {
            //alert("年龄必须为整数,请填写正确数据! ");
            return false;
        }
    }
    return true;
}

function hasYearFunc(obj) {
    var val = $('#codeHead').val();

    if (obj.value == '[年度]') {
        if (val.indexOf("[年月日]") != -1) {
            $('#codeHead').val(val.replace(/\[年月日\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月]") != -1) {
            $('#codeHead').val(val.replace(/\[年月\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年度]") < 0) {
            if (val.substring(0, 9) == '[OrgName]') {
                $('#codeHead').val(val.substring(0, 9) + "[年度]" + val.substring(9));
            } else {
                $('#codeHead').val("[年度]" + val);
            }
        }
    } else if (obj.value == '[年月]') {
        if (val.indexOf("[年度]") != -1) {
            $('#codeHead').val(val.replace(/\[年度\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月日]") != -1) {
            $('#codeHead').val(val.replace(/\[年月日\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月]") < 0) {
            if (val.substring(0, 9) == '[OrgName]') {
                $('#codeHead').val(val.substring(0, 9) + "[年月]" + val.substring(9));
            } else {
                $('#codeHead').val("[年月]" + val);
            }
        }
    } else if (obj.value == '[年月日]') {
        if (val.indexOf("[年度]") != -1) {
            $('#codeHead').val(val.replace(/\[年度\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月]") != -1) {
            $('#codeHead').val(val.replace(/\[年月\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月日]") < 0) {
            if (val.substring(0, 9) == '[OrgName]') {
                $('#codeHead').val(val.substring(0, 9) + "[年月日]" + val.substring(9));
            } else {
                $('#codeHead').val("[年月日]" + val);
            }
        }
    } else {
        if (val.indexOf("[年度]") != -1) {
            $('#codeHead').val(val.replace(/\[年度\]/, '')); //.substring(4);
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月日]") != -1) {
            $('#codeHead').val(val.replace(/\[年月日\]/, ''));
        }
        val = $('#codeHead').val();
        if (val.indexOf("[年月]") != -1) {
            $('#codeHead').val(val.replace(/\[年月\]/, ''));
        }
    }
    $('#codeHead').focus();
}

function isResortFunc(obj) {
    var val = $('#codeHead').val();
    if (val.indexOf("[Y]") != -1) {
        val = val.replace(/\[Y\]/, obj.value);

    } else if (val.indexOf("[N]") != -1) {
        val = val.replace(/\[N\]/, obj.value);

    } else if (val.indexOf("[Y]") < 0 || val.indexOf("[N]") < 0) {
        if (val.indexOf("[年度]") != -1) {
            val = "[年度]" + obj.value + val.replace(/\[年度\]/, ''); //val.substring(4);
        } else if (val.indexOf("[年月日]") != -1) {
            val = "[年月日]" + obj.value + val.replace(/\[年月日\]/, '');
        }
        if (val.indexOf("[年月]") != -1) {
            val = "[年月]" + obj.value + val.replace(/\[年月\]/, '');
        } else {
            val = obj.value + val;
        }
    }

    $('#codeHead').val(val);
    $('#codeHead').focus();
}

function hasOrgNameFunc(obj) {
    var codeHead = $('#codeHead').val();
    if (obj.value == '[OrgName]') {
        if (codeHead.substring(0, 9) != '[OrgName]') {
            $('#codeHead').val('[OrgName]' + codeHead);
        }
    } else {
        if (codeHead.substring(0, 9) == '[OrgName]') {
            $('#codeHead').val(codeHead.substring(9));
        }
    }
}

function check(o) {
    var v = o.value;

    if (v == "") {
        return;
    }

    var reg = /^[A-Za-z0]+$/;
    var v_ = reg.test(v);
    if (!v_) {
        alert("填充值只允许输入0或字母！");
        o.value = "";
    }
}

function resetThisForm(obj){
    resetDataForm(obj);
    
    /*document.getElementsByName("hasOrgName")[1].checked = true;
    document.getElementsByName("hasYear")[1].checked = true;
    document.getElementsByName("isResort")[1].checked = true;

    $('#codeHead').val('');
    $('#intialCode').val('');
    $('#codeInsert').val('');
    $('#codeLen').val('');
    $('#codeAdd').val('1');
    $('#codeTail').val('');*/
}

function closeWin(){
    api.close();
}

function setCodeHead(){
    popup({id:'CodeHeadWin', content:'url:'+whirRootPath+'/Show!setCodeHead.action?fieldId=<%=request.getParameter("fieldId")%>&codeHead='+$('#codeHead').val(), title:'设置编号头', width:350, height:250, lock:true, parent:api, opener:W});//, parent:api, opener:W});
}
</script>
</html>