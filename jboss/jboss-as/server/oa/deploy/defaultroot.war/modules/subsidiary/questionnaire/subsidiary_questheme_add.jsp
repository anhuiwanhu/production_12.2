<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String grade = "";
if(request.getAttribute("grade") !=null){
	grade = request.getAttribute("grade").toString();
}	
%>
<head>  
	<title>新增问卷设计</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%> 
	
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
     <style>
    .SubTable{ border:1px solid #d9d9d9; border-right:0; border-bottom:0;}
    .subTitle td{ text-align:center; font-weight:bold; color:#666; border-right:1px solid #d9d9d9;  border-bottom:1px solid #d9d9d9; padding:4px;}
    .subTitleList td{ border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;}
</style>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">
        <div class="docBoxNoPanel">
		    <s:form name="dataForm" id="dataForm" action="${ctx}/questionnaire!addQuestheme.action" method="post" theme="simple" >
            <%@ include file="/public/include/form_detail.jsp"%>  
		    	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="标题" width="60" class="td_lefttitle">  
                           	 标题<span class="MustFillColor">*</span>：  
                        </td>  
                        <td> 
						     <s:textfield onblur="validTitle()" name="questhemePO.title" id="title" whir-options="vtype:['notempty',{'maxLength':100},'spechar3']" cssClass="inputText" cssStyle="width:95%;"/>
						     <div id="titleValidDiv" style="color: red"></div>
                        </td>  
                    </tr>
                    <tr>
                    	<td  colspan="1" for="内容" width="100" class="td_lefttitle">  
                           	 内容：  
                        </td>
                        <td colspan="1"> 
						     <s:hidden name="questhemePO.contents" id="contents"/>
						     <iframe id="ewebeditorIFrame" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=questhemePO.contents&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="95.9999999999%" height="350"></iframe>
                        </td>  
                    </tr>  
                    <%if("0".equals(grade)){%>  
                     <tr style="display:none;">  
                        <td for="分值" width="60" class="td_lefttitle">  
                           	 分值<span class="MustFillColor">*</span>：  
                        </td>  
                        <td> 
						     <s:textfield maxlength="9" size="10" name="questhemePO.score" id="score" cssClass="inputText" cssStyle="width:100px;"/>
                        </td>  
                    </tr>
                    <%}else if("1".equals(grade)){%>
                     <tr>  
                        <td for="分值" width="60" class="td_lefttitle">  
                           	 分值<span class="MustFillColor">*</span>：  
                        </td>  
                        <td> 
						     <s:textfield maxlength="9" size="10" name="questhemePO.score" id="score" whir-options="vtype:['notempty','digit']" cssClass="inputText" cssStyle="width:100px;"/>
                        </td>  
                    </tr>
                    
                    <%} %> 
                     <tr>  
                        <td for="排序" width="60" class="td_lefttitle">  
                           	 排序：  
                        </td>  
                        <td> 
						     <s:textfield maxlength="9" size="10" name="questhemePO.orderCode" id="orderCode" whir-options="vtype:['digit']" cssClass="inputText" cssStyle="width:100px;"/>
                        </td>  
                    </tr> 
                     <tr>  
                        <td for="类型" width="60" class="td_lefttitle">  
                           	 类型<span class="MustFillColor">*</span>：  
                        </td>  
                        <td> 
						    <s:select onchange="onChange(this);" cssStyle="width:100px;" name="questhemePO.type" whir-options="vtype:['notempty']" list="#{'':'--请选择--','0':'单选','1':'多选','2':'问答'}" listKey="key"  listValue="value" headerKey=""  cssClass="selectlist" />
						    <span id="dbselect" style="display:none">
								只能选择少于<s:textfield cssStyle="width:50px;" name="questhemePO.selanswernum" id="selanswernum" cssClass="inputText" size="3" maxlength="3" whir-options="vtype:['p_integer_e',{'maxLength':3}]"/>个答案
							</span>
	                    	<span id="__otherAnswer" style="display:none">
								<input type="checkbox" name="questhemePO.isOtherAnswer" value="1"/>可输入其他答案
							</span>
							<span id="_eachRowNum" style="display:none">
								每行显示<s:textfield cssStyle="width:50px;" name="questhemePO.eachRowNum" cssClass="inputText" size="3" maxlength="2" whir-options="vtype:['p_integer_e',{'maxLength':2},{'range':'1-4'}]" />个选项
							</span>
                        </td>  
                    </tr>
                    <tr id="choose" style="display:none">
					  <td height="25" class="td_lefttitle">选项：</td>
					  	<td >
							<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tableSource"   bordercolordark="#E1E1E1" class="SubTable" >
								<tr align="center" class="subTitle">
									<td width="23%" for="答案">&nbsp;</td>
									<td width="17%" for="分值">&nbsp;</td>
									<td width="35%" for="图片">&nbsp;</td>
									<td width="25%" align="center" class="Table_nobttomline">
                                        <span id="radioYouFenSpan" style="display:none;width:100%;"><input type="button" onclick="javascript:addRadioYouFen();" class="btnButton4font" value='<s:text name="comm.add"/>'/></span><span id="radioWuFenSpan" style="display:none;"><input type="button" onclick="javascript:addRadioWuFen();" class="btnButton4font" value='<s:text name="comm.add"/>'/></span>
                                    </td>
								</tr>
							</table>

							<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="tableSource2" style="display:none;" bordercolordark="#E1E1E1" class="SubTable">
								<tr align="center" class="subTitle">
									<td width="23%" for="答案">&nbsp;</td>
									<td width="17%" for="分值">&nbsp;</td>
									<td width="35%" for="图片">&nbsp;</td>
									<td width="25%"><span id="addCheckSpan" style="display:none"><input type="button" onclick="javascript:addCheck();" class="btnButton4font" value='<s:text name="comm.add"/>'/></span></td>
								</tr>
							</table>
						</td>
					</tr>

                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap="nowrap">  
                            <input type="button" class="btnButton4font" onclick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />  
							<input type="button" class="btnButton4font" onclick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' />
                            <input type="button" class="btnButton4font" onclick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                            <input type="button" class="btnButton4font" onclick="window.close();" value='<s:text name="comm.exit"/>' />  
                        </td>  
                    </tr>  
                </table>
                <s:hidden name="questionnaireId" id="questionnaireId"/>
				<input type="hidden" name="gradeHidden" id="gradeHidden" value="<%=grade%>"/>
				<input type="hidden" name="uploadImgCount" id="uploadImgCount" value="0"/>
		    </s:form>
        </div>
    </div>
</body>
<script type="text/javascript">
//*************************************下面的函数属于公共的或半自定义的*************************************************//  
	//设置表单为异步提交 
        initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
		function ok(n,obj){ 
			var formId = $(obj).parents("form").attr("id");
			var validation = validateForm(formId);
			$(obj).parents("form").find("#saveType").val(n);
			
			if(validation){
				var rs=checkFormElement();
				 if(rs){
					$('#'+formId).submit();
				}else{
					return false;
				}
				
			}
		}
	function checkFormElement(){
		var selanswernum=$("#selanswernum").val();
		if(document.getElementsByName("pitchon").length>0){
			var _temp = parseInt(selanswernum);
			if(_temp>document.getElementsByName("pitchon").length){
				whir_poshytip($("#selanswernum"),"不能大于选项答案个数！");
				return false;
			}
		}
		if($("#contents").length>0){
			var o_Editor = document.getElementById("ewebeditorIFrame").contentWindow;
			$("#contents").val(o_Editor.getHTML());
		}
		//alert($("select[name='questhemePO.type']").find('option:selected').val());
		var selectedValue = $("select[name='questhemePO.type']").val();
		var score = $('#score').val();
		var title = $('#title');
		if(legalCharacters(title)){
			whir_poshytip(title,"标题不能包含以下字符 \\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/",backFun);
			return false;
		}
		if(title.val().substring(0,1) ==" "){
			whir_poshytip(title,'标题不得为空格开头，请去空格。');
			$('#title').focus();
         	return false;
         }
		if(score>1000||score<0){
			whir_poshytip($('#score'),'分值必须大于0并且小于1000！');
			return false;
		}
        var titleValidDiv=$('#titleValidDiv').html();
        if(titleValidDiv=='您填写的内容已存在，请重新填写'){
            whir_poshytip($('#title'),'您填写的内容已存在，请重新填写！');
			return false;
        }
		if(selectedValue==''){
			//whir_alert('请选择类型',backFun);
			//return;
			
		}else if(selectedValue=='0'){
			var radioVal = 0;
			if(document.getElementsByName("solutionTitle").length<=0){
				whir_alert('请新增单选选项',backFun);
				return false;
			}else{
				$("input[name='optionScore']").each(function(){
					radioVal += parseFloat($(this).val());
					//alert("radioVal:"+radioVal);
				});
				 
				//alert(score==radioVal);
				if(radioVal>score||radioVal<score){
					whir_alert('此题目的选项分与设置分值不一样，请检查',backFun);
					return false;
				}
				$("input[name='solutionTitle']").each(function(){
					if($(this).val().substring(0,1) ==" "){
						whir_poshytip($(this),'答案不能空格开头，请去空格。');
						$(this).focus();
			         	return false;
			         }
				});
				//return;
			}
			
			
		}else if(selectedValue=='1'){
			var solutionTitle2Len = document.getElementsByName("solutionTitle2").length;
			if(solutionTitle2Len<=0){
				whir_alert('请新增多选选项',backFun);
				return false;
			}else{
				
				var selanswernum = $("input[name='questhemePO.selanswernum']").val();
				 if(selanswernum>solutionTitle2Len){
					whir_alert('不能大于选项答案个数！',backFun);
					return false;
				 }
				 $("input[name='solutionTitle2']").each(function(){
					if($(this).val().substring(0,1) ==" "){
						whir_poshytip($(this),'答案不能空格开头，请去空格。');
						$(this).focus();
			         	return false;
			         }
				});
			}
		}else if(selectedValue=='2'){
			
		}
		return true;
		
	}
	
	function setEditerContent(){
		if ($("#contents").val()!=""){
			var o_Editor = document.getElementById("ewebeditorIFrame").contentWindow;
			alert(o_Editor.getHTML());
			$("#contents").val(o_Editor.getHTML());
		}
	}
	//提交前校验
	function backFun(data){}
	
	//增加有分值单选
	function addRadioYouFen_old()
	{
		var trStr = "<tr class=\"subTitleList\"><td>&nbsp;答案&nbsp;<span class=\"MustFillColor\">*</span>：&nbsp;<input type=\"text\" whir-options=\"vtype:['notempty']\" style=\"width:200px;\" name=\"solutionTitle\" maxlength=\"30\" class=\"inputText\"></td>";
		trStr +="<td for=\"分值\">&nbsp;分值&nbsp;<span class=\"MustFillColor\">*</span>：&nbsp;<input type=\"text\" whir-options=\"vtype:['notempty','p_decimal']\" style=\"width:200px;\" name=\"optionScore\" class=\"inputText\" size=\"10\"></td>";
		trStr +="<td>&nbsp;&nbsp;<a href=\"javascript:void(0)\"  onclick=\"del(this);\"><img  style=\"cursor:hand\" border=\"0\" src=\"images/del.gif\" alt=\"删除\"></a></td></tr>";
		var tableSource = $('#tableSource tr');
		
		$('#tableSource').append(trStr);
		
		digitCheck();
	}
	
	//增加有分值单选
	function addRadioYouFen(){
	
	    var upImgCount=$("#uploadImgCount").val();
		var trStr = "<tr class=\"subTitleList\"><td>&nbsp;答案&nbsp;<span class=\"MustFillColor\">*</span>：&nbsp;<input type=\"text\" whir-options=\"vtype:['notempty']\" style=\"width:200px;\" name=\"solutionTitle\" maxlength=\"30\" class=\"inputText\" /></td>";
		trStr +="<td for=\"分值\">&nbsp;分值&nbsp;<span class=\"MustFillColor\">*</span>：&nbsp;<input type=\"text\" whir-options=\"vtype:['notempty','p_decimal']\" style=\"width:125px;\" name=\"optionScore\" class=\"inputText\" size=\"10\" /></td>";
		
		trStr +="<td for=\"其它答案\"><div style='float:left;margin:5px;'>图片&nbsp;:&nbsp; <input type='hidden' name='opImgRealName"+upImgCount+"'  id='opImgRealName"+upImgCount+"' />";
		trStr +="<input type='hidden' name='opImgSaveName"+upImgCount+"' id='opImgSaveName"+upImgCount+"' /></div>";
		trStr +="<iframe name='accessoryIframe"+upImgCount+"' id='accessoryIframe"+upImgCount+"' src='<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=quesCustAnswer&uniqueId=accessoryIframe"+upImgCount+"&realFileNameInputId=opImgRealName"+upImgCount+"&saveFileNameInputId=opImgSaveName"+upImgCount+"&canModify=yes&uploadLimit=1&buttonText=上传图片&fileTypeExts=*.jpg;*.jpeg;*.gif;*.png;&thumbnail=120x120_slt' scrolling=''  border='1' frameborder='0' width='380' height='90' style='float:left'></iframe> </td>";
		
		trStr +="<td for=\"其它答案\"><span  for=\"其它答案\" id='openOther"+upImgCount+"'><img onclick='openOther("+upImgCount+");' style=\"cursor:hand\" border=\"0\" src=\"images/modi.gif\" alt=\"自定义答案\" /><input type=\"hidden\" style='width:50px;' name='customAnswer' maxlength='30' class='inputText'/></span>";
		trStr +="&nbsp;&nbsp;<a href=\"javascript:void(0)\"  onclick=\"del(this);\"><img  style=\"cursor:hand\" border=\"0\" src=\"images/del.gif\" alt=\"删除\" /></a></td></tr>";
		var tableSource = $('#tableSource tr');		
		$('#tableSource').append(trStr);
        $("#uploadImgCount").val(parseInt(upImgCount)+parseInt(1));		
		digitCheck();
	}
	
	function openOther(upImgCount){
	    //var upImgCount=$("#uploadImgCount").val();
		var trStr = "其它答案<input type='radio' name='otherA"+upImgCount+"' id='otherA"+upImgCount+"' checked='true' onclick='changeToImg("+upImgCount+")'/><input type=\"text\" whir-options=\"vtype:['notempty']\" style='width:200px;' name='customAnswer' maxlength='30' class='inputText'/>";
		$('#openOther'+upImgCount).html(trStr);
	}
	
	function changeToImg(upImgCount){
	    //var upImgCount=$("#uploadImgCount").val();
		var trStr ="<img onclick='openOther("+upImgCount+");' style=\"cursor:hand\" border=\"0\" src=\"images/modi.gif\" alt=\"自定义答案\" /><input type=\"hidden\" style='width:50px;' name='customAnswer' maxlength='30' class='inputText'/>";
		$('#openOther'+upImgCount).html(trStr);
	}
	
	//增加无分值单选
	function addRadioWuFen()
	{
	    var upImgCount=$("#uploadImgCount").val();
		var trStr = "<tr class=\"subTitleList\"><td>&nbsp;答案&nbsp;<span class=\"MustFillColor\">*</span>：&nbsp;<input type=\"text\" whir-options=\"vtype:['notempty']\" style=\"width:200px;\" name=\"solutionTitle\" maxlength=\"30\" class=\"inputText\" /></td>";
		trStr +="<td>&nbsp;</td>";		
		trStr +="<td for=\"其它答案\"><div style='float:left;margin:5px;'>图片&nbsp;:&nbsp; <input type='hidden' name='opImgRealName"+upImgCount+"'  id='opImgRealName"+upImgCount+"' />";
		trStr +="<input type='hidden' name='opImgSaveName"+upImgCount+"' id='opImgSaveName"+upImgCount+"' /></div>";
		trStr +="<iframe name='accessoryIframe"+upImgCount+"' id='accessoryIframe"+upImgCount+"' src='<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=quesCustAnswer&uniqueId=accessoryIframe"+upImgCount+"&realFileNameInputId=opImgRealName"+upImgCount+"&saveFileNameInputId=opImgSaveName"+upImgCount+"&canModify=yes&uploadLimit=1&buttonText=上传图片&fileTypeExts=*.jpg;*.jpeg;*.gif;*.png;&thumbnail=120x120_slt' scrolling=''  border='1' frameborder='0' width='380' height='90' style='float:left'></iframe> </td>";		
		trStr +="<td for=\"其它答案\"><span id='openOther"+upImgCount+"'><img onclick='openOther("+upImgCount+");' style=\"cursor:hand\" border=\"0\" src=\"images/modi.gif\" alt=\"自定义答案\" /><input type=\"hidden\" style='width:50px;' name='customAnswer' maxlength='30' class='inputText'/></span>";
		trStr +="&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"del(this);\"><img  style=\"cursor:hand\" border=\"0\" src=\"images/del.gif\" alt=\"删除\" /></a></td></tr>";
		var tableSource = $('#tableSource tr');
		$("#uploadImgCount").val(parseInt(upImgCount)+parseInt(1));
		$('#tableSource').append(trStr);
	}

	//增加多选
	function addCheck()
	{
		var upImgCount=$("#uploadImgCount").val();
		var trStr = "<tr class=\"subTitleList\"><td>&nbsp;答案&nbsp;<span class=\"MustFillColor\">*</span>：&nbsp;<input type=\"text\" whir-options=\"vtype:['notempty']\" style=\"width:200px;\" name=\"solutionTitle2\" maxlength=\"30\" class=\"inputText\" /></td>";
		trStr +="<td>&nbsp;<select class=\"easyui-combobox\" style=\"width:185px;height:29px;\" name=\"pitchon\"><option value=\"0\">不选中</option><option value=\"1\"\>选中</option></select></td>";		
		trStr +="<td for=\"其它答案\"><div style='float:left;margin:5px;'>图片&nbsp;:&nbsp; <input type='hidden' name='opImgRealName"+upImgCount+"'  id='opImgRealName"+upImgCount+"' />";
		trStr +="<input type='hidden' name='opImgSaveName"+upImgCount+"' id='opImgSaveName"+upImgCount+"' /></div>";
		trStr +="<iframe name='accessoryIframe"+upImgCount+"' id='accessoryIframe"+upImgCount+"' src='<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=quesCustAnswer&uniqueId=accessoryIframe"+upImgCount+"&realFileNameInputId=opImgRealName"+upImgCount+"&saveFileNameInputId=opImgSaveName"+upImgCount+"&canModify=yes&uploadLimit=1&buttonText=上传图片&fileTypeExts=*.jpg;*.jpeg;*.gif;*.png;&thumbnail=120x120_slt' scrolling=''  border='1' frameborder='0' width='380' height='90' style='float:left'></iframe> </td>";
		trStr +="<td for=\"其它答案\"><span id='openOther"+upImgCount+"'><img onclick='openOther("+upImgCount+");' style=\"cursor:hand\" border=\"0\" src=\"images/modi.gif\" alt=\"自定义答案\" /><input type=\"hidden\" style='width:50px;' name='customAnswer' maxlength='30' class='inputText'/></span>";
		trStr +="&nbsp&nbsp;<a href=\"javascript:void(0)\" onclick=\"del(this);\"><img  style=\"cursor:hand\" border=\"0\" src=\"images/del.gif\" alt=\"删除\" /></a></td></tr>";
		var tableSource = $('#tableSource tr');
		$("#uploadImgCount").val(parseInt(upImgCount)+parseInt(1));
		$('#tableSource2').append(trStr);
		
	}
	function del(obj){
		$(obj).parent().parent().remove();
		$("#uploadImgCount").val(parseInt(upImgCount)-parseInt(1));
	}
	function del2(obj){
		$(obj).parent().parent().remove();
	}
	
	
	function onChange(value){
	    var grade = $('#gradeHidden').val();
	    var selectedValue = $("select[name='questhemePO.type']").val();
	    var grade = $('#gradeHidden').val();
	    $("#uploadImgCount").val(0);
		
	    if(selectedValue =="0"){
	    	$("input[name='solutionTitle2']").parent().parent().remove();
			$('#dbselect').css('display','none');
			$('#_eachRowNum').css('display','');
			$("input[name='questhemePO.selanswernum']").val();
	        $('#tableSource').css('display','');
	        $('#tableSource2').css('display','none');
	        var state = $('#choose').css('display');
			if(state = "none"){
	            $('#choose').css('display','');
	        }
	        if(grade =="1"){
	            $('#radioWuFenSpan').css('display','none');
	            $('#radioYouFenSpan').css('display','');
	        }else if(grade =="0"){
	            $('#radioWuFenSpan').css('display','');
	            $('#radioYouFenSpan').css('display','none');
	
	        }
        }
	    if(selectedValue =="1"){
	    	
	    	$("input[name='solutionTitle']").parent().parent().remove();
			$('#dbselect').css('display','');
			$('#_eachRowNum').css('display','');
			$("input[name='questhemePO.selanswernum']").val();
	
	        var state = $('#choose').css('display');
	        $('#tableSource').css('display','none');
	        $('#tableSource2').css('display','');
			if(state = "none"){
	            $('#choose').css('display','');
	        }
	        
	        $('#addCheckSpan').css('display','');
	
	
	    }
	    if(selectedValue =="2"){
	    	$("input[name='solutionTitle']").parent().parent().remove();
	    	$("input[name='solutionTitle2']").parent().parent().remove();
			$('#dbselect').css('display','none');
			$('#_eachRowNum').css('display','none');
			$("input[name='questhemePO.selanswernum']").val();
	
	        $('#choose').css('display','none');
	    }
	    if(selectedValue ==""){
			$('#dbselect').css('display','none');
			$("input[name='questhemePO.selanswernum']").val();
	
	        $('#choose').css('display','none');
	    }
		if(grade=="0"){
			if(selectedValue =="0"||selectedValue =="1"){
		        $('#__otherAnswer').css('display','');
			}else{
				$('#__otherAnswer').css('display','none');
			}
		}
	}
	
	function checkObj(obj){
		var val = obj.value;
		
		if(document.getElementsByName("pitchon").length>0){
			var _temp = parseInt(val);
			if(_temp>document.getElementsByName("pitchon").length){
				whir_poshytip(obj,"不能大于选项答案个数！");
				//obj.focus();
				//obj.select();
				//obj.value="";
				return;
			}
		}
	}
	function legalCharacters(o) {
		//参数'o'是页面上的一个对象，如'document.forms[0].code'
		//var cnst ="!\"#$%&'()=`|~{+*}<>?_-^\\@[;:],./";
		var cnst ="\\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/";
	    for (i=0;i<o.val().length;i++){
	       	if (cnst.indexOf(o.val().charAt(i))>-1){
				return true;
	        }
	    }
	    return false;
	}
	
	//校验标题
	function validTitle(){
		var title = $('#title').val();
		var questionnaireId = $('#questionnaireId').val();
		if(title==''){
			$('#titleValidDiv').html('');
		}else{
			var result = spechar(title,"\\\,/,?,#,&,\'");
			if(result != ''){
				return;
			}else{
				var data =ajaxForSync('questionnaire!validTitle.action','validTarg=10&title='+title+'&questionnaireId='+questionnaireId);
                backValidTitle(data);
			}
		}
	}
	function backValidTitle(data){
		var title = $('#title').val();
		var json='';
        eval('json=' + data + ';');  
		//alert(json.result);
		var result = json.result;
		if(result!=''){
			$('#titleValidDiv').html(json.result);
		}
	}
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
</script>
</html>