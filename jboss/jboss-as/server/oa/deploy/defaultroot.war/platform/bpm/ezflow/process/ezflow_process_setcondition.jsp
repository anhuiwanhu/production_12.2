<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %><%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %><%@ taglib uri="/WEB-INF/tag-lib/struts-logic.tld" prefix="logic" %><%@ taglib uri="/WEB-INF/tag-lib/struts-bean.tld" prefix="bean" %><%@ taglib uri="/WEB-INF/tag-lib/struts-html.tld" prefix="html" %><%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/tag-lib/c.tld" prefix="c" %>
<%@ include file="/public/include/init_base.jsp"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();

String formCode=request.getParameter("formCode")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("formCode").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><bean:message bundle="workflow" key="workflow.ConditionalExpression"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<script src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/Map.js" type="text/javascript"></script> 
	<script src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/List.js" language="javascript"></script>
	<script src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js" language="javascript"></script>
    <style type="text/css">
	<!--
	#noteDiv {
		position:absolute; 
		height:200px; 
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
		background-color:#ffffff;
	} 
	-->
	</style>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
 
	 $(function() {
		/*  在textarea处插入文本--Start */
		(function($) {
			$.fn.extend({
				insertContent : function(myValue, t) {
					var $t = $(this)[0];
					if (document.selection) { // ie
						this.focus();
						var sel = document.selection.createRange();
						sel.text = myValue;
						this.focus();
						sel.moveStart('character', -l);
						var wee = sel.text.length;
						if (arguments.length == 2) {
							var l = $t.value.length;
							sel.moveEnd("character", wee + t);
							t <= 0 ? sel.moveStart("character", wee - 2 * t
									- myValue.length) : sel.moveStart("character", wee - t - myValue.length);
							sel.select();
						}
					} else if ($t.selectionStart
							|| $t.selectionStart == '0') {
						var startPos = $t.selectionStart;
						var endPos = $t.selectionEnd;
						var scrollTop = $t.scrollTop;
						$t.value = $t.value.substring(0, startPos)
								+ myValue
								+ $t.value.substring(endPos, $t.value.length);
						this.focus();
						$t.selectionStart = startPos + myValue.length;
						$t.selectionEnd = startPos + myValue.length;
						$t.scrollTop = scrollTop;
						if (arguments.length == 2) {
							$t.setSelectionRange(startPos - t, $t.selectionEnd + t);
							this.focus();
						}
					} else {
						this.value += myValue;
						this.focus();
					}
				}
			})
		})(jQuery);
		/* 在textarea处插入文本--Ending */
	});

	 
	String.prototype.replaceAllString = function(s1,s2){ 
		this.str=this; 
		if(s1.length==0)return this.str; 
		var idx=this.str.indexOf(s1); 
		while(idx>=0){ 
		this.str=this.str.substring(0, idx)+s2+this.str.substr(idx+s1.length); 
		idx=this.str.indexOf(s1); 
		} 
		return this.str; 
	};
	 

	var  field_text_Map=new Map();  
	var  text_field_Map=new Map();  
	var  fieldList=new List();

	var  rm_start="{";
	var  rm_end="}"; 
    
	//
	var needJudge=true;  
	text_field_Map.clear();   
	field_text_Map.clear();
 
	<c:forEach items="${fieldList}" var="field">
		<c:choose><c:when test="${field[3] == '1'&&field[2]!= '401'}"> 
			fieldList.add(new Array("${field[0]}","${field[1]}"));
			</c:when>
		</c:choose>
	</c:forEach>
 
	fieldList.add(new Array("condi_initiatorDuty","<bean:message bundle="workflow" key="workflow.StartOnePost"/>"));
	fieldList.add(new Array("condi_initiatorDutyLevel","<bean:message bundle="workflow" key="workflow.StartOneJobLevel"/>"));
	fieldList.add(new Array("condi_preTransactorDutyLevel","<bean:message bundle="workflow" key="workflow.JobLevelofLastActivityReviewer"/>"));
	fieldList.add(new Array("condi_initiatorLeaderDutyLevel","<bean:message bundle="workflow" key="workflow.LeaderJobLevelOfStarter"/>"));
	fieldList.add(new Array("condi_preTransactorLeaderDutyLevel","<bean:message bundle="workflow" key="workflow.LeaderJobLevelofLastActivityReviewer"/>")); 
    fieldList.add(new Array("condi_initiatorOrgName","<bean:message bundle="workflow" key="workflow.OrganizationOfStartPeople"/>"));
    fieldList.add(new Array("condi_initiatorLeaderUserAccount","<bean:message bundle="workflow" key="workflow.initiatorLeaderUserAccount"/>"));
    fieldList.add(new Array("condi_initiatorDepartLeaderUserAccount","<bean:message bundle="workflow" key="workflow.initiatorDepartLeaderUserAccount"/>"));
	fieldList.add(new Array("condi_initiatorChargeLeaderUserAccount","<bean:message bundle="workflow" key="workflow.initiatorChargeLeaderUserAccount"/>"));
	fieldList.add(new Array("condi_initiatorApprovalLevel","启动人审批级别"));
	fieldList.add(new Array("condi_initiatorOneLevel","一级审批人"));
	fieldList.add(new Array("condi_initiatorTwoLevel","二级审批人"));
	fieldList.add(new Array("condi_initiatorThreeLevel","三级审批人"));
	fieldList.add(new Array("condi_initiatorFourLevel","四级审批人"));
	fieldList.add(new Array("condi_initiatorFiveLevel","五级审批人"));
	fieldList.add(new Array("condi_initiatorSixLevel","六级审批人"));


    var fsize=fieldList.size();
	var fileArr=null;
    for (var index = 0;index<fsize; index++) {
		fileArr=fieldList.get(index);
		field_text_Map.put(fileArr[0],rm_start+fileArr[1]+rm_end+" "); 
		text_field_Map.put(rm_start+fileArr[1]+rm_end,fileArr[0]);
	} 
     
    function editTypeModer(){ 
		 var conditionExpression_value=$("#conditionExpression").val();
		 var contents=conditionExpression_value;

		 var fsize=fieldList.size();
		 var fileArr=null;
		 for (var index = 0;index<fsize; index++) {
			fileArr=fieldList.get(index);  
			contents=contents.replaceAllString(fileArr[0]+" ",rm_start+fileArr[1]+rm_end+" " );
		 } 
		 //实际 转为  显示值
		 contents=contents.replaceAllString(" && "," And "); 
		 contents=contents.replaceAllString(" isnull '' "," =null "); 
		 contents=contents.replaceAllString(" notnull '' "," !=null "); 
		 contents=contents.replaceAllString(" notlike "," not like "); 
		 contents=contents.replaceAllString(" == "," = ");
		 contents=contents.replaceAllString(" || "," Or "); 

         $("textarea[name='expressname']").attr("value", contents);
		 setNotNeedJudge();
	}


	function textToFileId(){  
		 var condition_text=$("textarea[name='expressname']").attr("value"); 
		 var fsize=fieldList.size();
		 var fileArr=null;
		 for (var index = 0;index<fsize; index++) {
			fileArr=fieldList.get(index);  
			//condition_text=condition_text.replaceAllString(rm_start+fileArr[1]+rm_end+" ",fileArr[0]+" " );
			//改为下面的防止 因为 变量>1  没有空不能替换
			condition_text=condition_text.replaceAllString(rm_start+fileArr[1]+rm_end,fileArr[0] );
		 }   

		 condition_text=condition_text.replaceAllString(" And "," && "); 
		 condition_text=condition_text.replaceAllString(" =null "," isnull '' "); 
		 condition_text=condition_text.replaceAllString(" !=null "," notnull '' "); 
		 condition_text=condition_text.replaceAllString(" not like "," notlike "); 
		 condition_text=condition_text.replaceAllString(" = "," == ");
		 condition_text=condition_text.replaceAllString(" Or "," || "); 
		 $("#conditionExpression").val(condition_text);
	}

	function  setNotNeedJudge(){
		needJudge=false;
		$("textarea[name='expressname']").removeAttr("readonly");  
		$('#editTypeCheckbox').attr("checked",'checked');  
		document.getElementById("editTypeCheckbox").disabled=true; 
		document.getElementById("cancelbutton").disabled=true;  
		$("#cancelbutton").removeClass("btnButton4font"); 
		$("#cancelbutton").hide();
	}
	 
		//显示历史
		var displayList = new List();
		//值历史
		var valueList = new List();
		//新元素历史
		var newList = new List();

		//当前属性页面编辑的元素对象
		var model;
		//初始化属性
		function initData() {
            //初始化
			//显示历史
			displayList = new List();
			//值历史
			valueList = new List();
			//新元素历史
			newList = new List();

			//初始化显示
			var id = "<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"id")%>";
			if(opener == null || opener.xiorkFlow == null || opener.xiorkFlow.xiorkFlowWrapper == null || opener.xiorkFlow.xiorkFlowWrapper.getModel() == null) {
				whir_alert("父页面或者流程已经不存在！",function(){});
				return;
			}
			var nms = opener.xiorkFlow.xiorkFlowWrapper.getModel().transitionModels;
			for( i = 0; i < nms.length; i++) {
				if(nms[i].getID() == id) {
					model = nms[i];
					break;
				}
			}
			if(model == null) {
				whir_alert("编辑的连接线已经不存在！",function(){});
				return;
			}
            var old_conditionExpressionDisplay= model.getConditionExpressionDisplay(); 
			if(old_conditionExpressionDisplay!=null&&old_conditionExpressionDisplay.indexOf("{")>=0&&old_conditionExpressionDisplay.indexOf("}")>=0){
				needJudge=false;
			} 
			if(!needJudge){
				setNotNeedJudge();
			}
			//名称
			$("#name").attr("value", model.getText());
			$("#name").attr("defaultValue", model.getText());



			$("#sortNum").attr("defaultValue",model.getSortNum());
			$("#sortNum").val(model.getSortNum());
			//条件表达式
			// document.all.conditionExpression.value+=" "+stext+" " ;
			// document.all.expressname.value+=" "+ svalue+" " ;

			$("textarea[name='expressname']").attr("value", old_conditionExpressionDisplay);
			displayList.add(model.getConditionExpressionDisplay());
			var condition = model.getConditionExpression();
			if(condition != null && condition.length > 2){
				condition = condition.substring(2,condition.length-1);
			}
			$("input[name='conditionExpression']").attr("value", condition);
			valueList.add(model.getConditionExpression());
			$("input[name='conditionExpression']").attr("defaultValue", model.getConditionExpression());
            
			hideselectaId();
		}

		//输入参数
		function  setNum(){	 
		  var svalue=$("#svalue").val();
		   if(svalue!=""){
				svalue=checkNum(svalue);	
				var stextLen=svalue.length;
				var svalueLen=svalue.length;
				var expressname_value=$("#expressname").val();
				var conditionExpression_value=$("#conditionExpression").val();
				displayList.add($("#expressname").val());
				valueList.add($("#conditionExpression").val());
				
				var svalue1 = svalue.replace("\\","\\\\");

				if(conditionExpression_value.endWith(" \${math:notlike( ")){
					$("#conditionExpression").val(replaceP2Function("\${math:notlike(",conditionExpression_value,svalue1));  
					newList.add("");
				}else if(conditionExpression_value.endWith(" \${math:like( ")){
					$("#conditionExpression").val(replaceP2Function("\${math:like(",conditionExpression_value,svalue1)); 	 
					newList.add("");
				}else{
                    $("#conditionExpression").val(conditionExpression_value+svalue1+" ");
					newList.add(svalue1);
				}
				//document.all.conditionExpression.value+=svalue;
				var ttvvvv=$("#expressname").val()+svalue+" ";
                $("#expressname").val("").focus().val(ttvvvv); 
				$("#svalue").val("");
		   }    
      
		}

		//撤销
		function  clearLast(){
			if(displayList.size() > 1){
				var displaytext = displayList.get(displayList.size()-1);
				var valuetext = valueList.get(valueList.size()-1);
				$("textarea[name='expressname']").attr("value", displaytext);
				$("input[name='conditionExpression']").attr("value",valuetext);
				displayList.removeByIndex(displayList.size()-1);
				valueList.removeByIndex(valueList.size()-1);
				newList.removeByIndex(newList.size()-1);
			}
			return;
		}

		function checkNum(svalue){
			/* var txt=document.getElementById(id).value;
			 var re = /^[-]?[0-9]+[\.]?[0-9]*$/;//或者/^[0-9]+\.?[0-9]*$/或者/^[0-9]+.?[0-9]*$/判断是否为整数或浮点数
			 if(re.test(txt)){
			  alert('数字');
			  }else{
			   alert("不合法的数字");
			   document.getElementById(id).value='';
			   }*/         
			 /*var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/   
			 if (!re.test(svalue)){    
				 svalue="'"+svalue+"'";	
			 } 
			 return svalue;*/

			  if(isNaN(svalue)){
				 svalue="'"+svalue+"'";	
			 } 
			 return svalue;
		 }

		//以什么结束
		String.prototype.endWith=function(str){
			if(str==null||str==""||this.length==0||str.length>this.length)
			  return false;
			if(this.substring(this.length-str.length)==str)
			  return true;
			else
			  return false;
			return true;
		}
		//以什么开始
		String.prototype.startWith=function(str){
			if(str==null||str==""||this.length==0||str.length>this.length)
			  return false;
			if(this.substr(0,str.length)==str)
			  return true;
			else
			  return false;
			return true;
		}

		 //选择操作符号
		function  selectValue(obj,type){
			//取选中的值 与显示名
			var  nLen =obj.length;
			var svalue="";
			var stext="";
			var showType="101";
            var fieldId="0";
			var fieldSetValue="0"; 
			try{
				if($("#"+obj+" option").length>0){
			　　　  $("#"+obj+" option").each(function(){
					   if($(this).attr("selected")=='selected'){ 
						  svalue=$(this).val();
						  stext=$(this).text();
						  showType=$(this).attr("st");
                          fieldId=$(this).attr("fid");
						  fieldSetValue=$(this).attr("fsv");  
					   }   
			　　　  });
				} 
			}catch(e){
			}	

			if(svalue==""){
			   return;
			}
			
			 // 现在输入的是运算符
			 if(type=='1'){
				  //使条件下拉框不选中
				  clearSeleted("field1");//$("#field1").val("");  
				  //不能以运算符开头
				  if($("#conditionExpression").val()==""&&needJudge){
					  if(svalue=='('){//当都为空时 只能是'('		      
					  }else{
						 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						 return;
					  }		  
				 }else{  
					 
					 //正常操作  每一步骤需要检查
					 if(needJudge){
						 //当输入 ')' 判断前面可还有'('
						if(svalue==')'){
							  //判断左右括号数量 大小
							 var zkh=$("#conditionExpression").val().split("(");
							 var ykh=$("#conditionExpression").val().split(")");
							 if(zkh<=ykh){
								whir_alert('<s:text name="workflow.Illogical"/>',function(){});
								return;
							 }	   
						 } 

						  //疑问
						  //取最后一个字符
						  ///var lastStr=document.all.conditionExpression.value.substr(document.all.expressname.value.length-2);	
						  var lastStr=$("#conditionExpression").val().substr($("#expressname").val().length-2);	
						  var expressnamevalue =$("#conditionExpression").val();// document.all.conditionExpression.value;
						   //分两种情况判断  
							//if(lastStr=='= '||lastStr=='> '||lastStr=='< '||lastStr=='r '||lastStr=='d '||lastStr=='( '||lastStr=='l '||lastStr=='e '||lastStr=="''" || document.all.expressname.value.endWith(' && ') || document.all.expressname.value.endWith(' || ') ){
							 if(  lastStr=='= '||lastStr=='> '||lastStr=='< ' ||lastStr=='( '||lastStr=='l '||lastStr=='e '||lastStr=="''" || expressnamevalue.endWith(' && ') || expressnamevalue.endWith(' || ') ){

								//当原来是'=','>=','<=','>','<','or','and' 等运算符时  可以是  值 或者 是'('
								if(svalue=='('){					   
								}else{
									// 当前面是 is null 可以接 ')'
									if(svalue==")"&&(lastStr=='l '||lastStr=="''")){
									}else{
										 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
										 return;
									}
								}
								 
							} else if(lastStr==') '){//不能出现  ')(' 的情形
							   if(svalue=='('){
									 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
									 return;
								}//else if(svalue.indexOf('\${math:') != -1){//)不能接函数
								  //alert('不合逻辑6');return;
								//}
							//}else if(lastStr=='( '){//运算符不能接函数
							   //if(svalue.indexOf('\${math:') != -1){//)不能接函数
								//  alert('不合逻辑6');return;
								//}
							}else{
								 //以值结尾
								 if(svalue=='('){//不能出现 ' 123（ ' 等情形				   
									  whir_alert('<s:text name="workflow.Illogical"/>',function(){});
									  return;
								 }	
							}
							//上次输入的是符号
							
							if(	 newList.get(newList.size()-1) == "&&" 
								|| newList.get(newList.size()-1) == "||" 
								|| newList.get(newList.size()-1) == "("
								|| newList.get(newList.size()-1) == ")"
								|| newList.get(newList.size()-1) == "!="
								|| newList.get(newList.size()-1) == ">"
								|| newList.get(newList.size()-1) == ">="
								|| newList.get(newList.size()-1) == "=="
								|| newList.get(newList.size()-1) == "<"
								|| newList.get(newList.size()-1) == "<="
								||( newList.get(newList.size()-1)+"")== "" 
							){
								if(svalue.indexOf('\${math:') != -1){//运算符后不能接函数
									  whir_alert('<s:text name="workflow.Illogical"/>',function(){});
									  return;
								}
							}
					 }
				}
 
				
			 }else{//现在输入的是值   
				  clearSeleted("queryField");
				  if($("#conditionExpression").val()==""){//当为空 可以输入任何字符
				  
				  }else{

					 //正常操作  每一步骤需要检查
					 if(needJudge){
							    //取最后一个字符
							    var lastStr=$("#conditionExpression").val().substr($("#conditionExpression").val().length-2);
							    var expressnamevalue = $("#conditionExpression").val();
								  
								if(lastStr=='= '||lastStr=='> '||lastStr=='< '||lastStr=='r '||lastStr=='d '||lastStr=='( '||lastStr=='l '||lastStr=='e '|| expressnamevalue.endWith(' && ') || expressnamevalue.endWith(' || ') ){
									//当原来是'=','>=','<=','>','<','or','and' 等运算符时  可以是任何字符
								}else if(lastStr==') '){//不能出现  ')值' 的情形
									 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
									 return;
								}else{//以值结尾时 不能出现'值值'的情况
									 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
									 return;
								}
					  }
				  } 
				  showChooseType(svalue,stext,showType,fieldId,fieldSetValue);
			 }    
              

			   //调整函数的位置
				displayList.add($("#expressname").val());
				valueList.add($("#conditionExpression").val()); 

				if(needJudge){
					$("#expressname").val($("#expressname").val()+stext+" ");  

					var conditionExpression = $("#conditionExpression").val(); 
					 //如果前面一个是like结束，则将参数加上
					if($("#conditionExpression").val().endWith(" \${math:notlike( ")){
						conditionExpression= replaceP2Function("\${math:notlike(",$("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
						newList.add("");
					}else if($("#conditionExpression").val().endWith(" \${math:like( ")){
						conditionExpression= replaceP2Function("\${math:like(",$("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
						newList.add("");
					}else if(svalue == "\${math:notnull("){
						conditionExpression= replaceP1Function("\${math:notnull(",$("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
						newList.add("");
					}else if(svalue == "\${math:isnull("){
						conditionExpression= replaceP1Function("\${math:isnull(",$("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
						newList.add("");
					}else{
						conditionExpression += svalue+ ' ';
						newList.add(svalue);
					}

					$("#conditionExpression").val(conditionExpression); 
					//alert("1:"+document.all.conditionExpression.value);
					//alert("2:"+document.all.expressname.value);
				}else{ 
					 //$("#expressname").val($("#expressname").val()+stext+" ");

					// 现在输入的是运算符
			        if(type=='1'){
                        $("#expressname").insertContent(stext+" ");
					}else{
					    $("#expressname").insertContent(field_text_Map.get(svalue)==null?(rm_start+""+stext+""+rm_end+" "):field_text_Map.get(svalue)); 
					}

					/* if(stext=="And"||stext=="("||stext==")"||stext=="!="||stext==">"||stext==">="||stext=="=="||stext==" < "||stext=="<="||stext=="like"||stext=="not like"||stext=="null"||stext=="!=null"){
					     $("#expressname").insertContent(stext+" ");
					 }else{
						 $("#expressname").insertContent(rm_start+""+stext+""+rm_end+" ");
					 }*/
				} 

				clearSeleted("field1");
				clearSeleted("queryField");
		}



		 //选择函数
		function  selectOp(obj,type){
			//取选中的值 与显示名
			  var  nLen =obj.length;
			  var svalue="";
			  var stext="";
			  for(i=0;i<nLen;i++){
				var optObj = obj.options(i);
				if(optObj.selected){
					svalue=optObj.value;
					stext=optObj.text;
					break;
				}	 
			 }   
			
			 // 现在输入的是运算符
			 if(type=='1'){
				  //使条件下拉框不选中
				   clearSeleted("field1");//$("#field1").val("");				 
				  //不能以运算符开头
				  if($("#conditionExpression").val()==""){
					  if(svalue=='('){//当都为空时 只能是'('		      
					  }else{
						  whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						  return;
					  }		  
				 }else{    
					 //当输入 ')' 判断前面可还有'('
					if(svalue==')'){
						  //判断左右括号数量 大小
						 var zkh=$("#conditionExpression").val().split("(");
						 var ykh=$("#conditionExpression").val().split(")");
						 if(zkh<=ykh){
							 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						     return;
						 }	   
					 } 
					 //取最后一个字符
					 var lastStr=$("#conditionExpression").val().substr($("#expressname").val().length-2);	
					 var expressnamevalue = $("#conditionExpression").val();
					   //分两种情况判断  
						//if(lastStr=='= '||lastStr=='> '||lastStr=='< '||lastStr=='r '||lastStr=='d '||lastStr=='( '||lastStr=='l '||lastStr=='e '||lastStr=="''" || document.all.expressname.value.endWith(' && ') || document.all.expressname.value.endWith(' || ') ){
						 if(  lastStr=='= '||lastStr=='> '||lastStr=='< ' ||lastStr=='( '||lastStr=='l '||lastStr=='e '||lastStr=="''" || expressnamevalue.endWith(' && ') || expressnamevalue.endWith(' || ') ){

							//当原来是'=','>=','<=','>','<','or','and' 等运算符时  可以是  值 或者 是'('
							if(svalue=='('){					   
							}else{
								// 当前面是 is null 可以接 ')'
								if(svalue==")"&&(lastStr=='l '||lastStr=="''")){
								}else{
									whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						            return;
								}
							}
							 
						} else if(lastStr==') '){//不能出现  ')(' 的情形
						   if(svalue=='('){
							    whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						        return;
							}//else if(svalue.indexOf('\${math:') != -1){//)不能接函数
							  //alert('不合逻辑6');return;
							//}
						//}else if(lastStr=='( '){//运算符不能接函数
						   //if(svalue.indexOf('\${math:') != -1){//)不能接函数
							//  alert('不合逻辑6');return;
							//}
						}else{
							 //以值结尾
							 if(svalue=='('){//不能出现 ' 123（ ' 等情形				   
								 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						         return;
							 }	
						}
						//上次输入的是符号
						
						if(	   newList.get(newList.size()-1) == "&&" 
							|| newList.get(newList.size()-1) == "||" 
							|| newList.get(newList.size()-1) == "("
							|| newList.get(newList.size()-1) == ")"
							|| newList.get(newList.size()-1) == "!="
							|| newList.get(newList.size()-1) == ">"
							|| newList.get(newList.size()-1) == ">="
							|| newList.get(newList.size()-1) == "=="
							|| newList.get(newList.size()-1) == "<"
							|| newList.get(newList.size()-1) == "<="
							||( newList.get(newList.size()-1)+"")== "" 
						){
							if(svalue.indexOf('whir:') != -1){//运算符后不能接函数
								 whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						         return;
							}
						}
				}
			 }else{//现在输入的是值   
				  clearSeleted("queryField");//document.all.queryField.value="";document.all.queryField.value="";
				  if($("#conditionExpression").val()==""){//当为空 可以输入任何字符
				  
				  }else{
					  //取最后一个字符
					 var lastStr=$("#conditionExpression").val().substr($("#conditionExpression").val().length-2);
					 var expressnamevalue = $("#conditionExpression").val();
						  
						if(lastStr=='= '||lastStr=='> '||lastStr=='< '||lastStr=='r '||lastStr=='d '||lastStr=='( '||lastStr=='l '||lastStr=='e '|| expressnamevalue.endWith(' && ') || expressnamevalue.endWith(' || ') ){
							//当原来是'=','>=','<=','>','<','or','and' 等运算符时  可以是任何字符
						}else if(lastStr==') '){//不能出现  ')值' 的情形
							whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						    return;
						}else{//以值结尾时 不能出现'值值'的情况
						    whir_alert('<s:text name="workflow.Illogical"/>',function(){});
						    return;	
						}
				  }
			 }    

			   //调整函数的位置
				displayList.add($("#expressname").val());
				valueList.add($("#conditionExpression").val());

				$("#expressname").val($("#expressname").val()+stext +" ");
				
				var conditionExpression = $("#conditionExpression").val();
				 //如果前面一个是like结束，则将参数加上
				if(svalue == "whir:toint("){
					conditionExpression= replaceP1Function("whir:toint(", $("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
					newList.add("");
				}else if(svalue == "whir:tostring("){
					conditionExpression= replaceP1Function("whir:tostring(", $("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
					newList.add("");
				}else if(svalue == "whir:tobool("){
					conditionExpression= replaceP1Function("whir:tobool(", $("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
					newList.add("");
				}else if(svalue == "whir:todate("){
					conditionExpression= replaceP1Function("whir:todate(", $("#conditionExpression").val(),svalue) ;//" "+stext+" " ;
					newList.add("");
				}else{
					conditionExpression += svalue+ ' ';
					newList.add(svalue);
				}

				$("#conditionExpression").val(conditionExpression);
			   
				//alert("1:"+document.all.conditionExpression.value);
				//alert("2:"+document.all.expressname.value);

				clearSeleted("field1");
				clearSeleted("queryField");
		}


		//调整2个参数的函数
		function replaceP2Function(funname,conditionExpression,svalue){
				if( conditionExpression.endWith(" "+funname+" ") ){
					//将前面一个值和后面一个值变成参数
					var param1 ;
					var param2 = svalue;
					var temp = conditionExpression.substr(0,conditionExpression.length - (funname.length+2));

					var pos1;
					//寻找第一个参数
					var lastvalue = "";
					if(newList.size() >= 2){
						lastvalue = newList.get(newList.size()-2);//-1是函数名，-2才是参数
					}
					//如果没有记录第一个参数，就自动解析
					if(lastvalue == ""){

						pos1 =  temp.lastIndexOf(" ");
						if( pos1 <0 ){
							pos1 = 0;
						}
						if(pos1>-1){
							param1 = temp.substr(pos1);
						}
					}else{
						pos1 = temp.length - lastvalue.length - 2;
						param1 = lastvalue;
					}
					param1 = param1.replace(/\s/g,   '');
					//如果param1是变量，替换掉\${和}
					if(param1.startWith("\${") && param1.endWith("}") ){
						param1 = param1.substr(2,param1.length-3);
					}
					if(param2.startWith("\${") && param2.endWith("}") ){
							param2 = param2.substr(2,param2.length-3);
					}
					//return  temp.substr(0,pos1) + " "+funname+param1+","+param2+")} ";
					return  temp.substr(0,pos1) + " "+funname+param1+","+param2+") ";
					//return  temp.substr(0,pos1) + " \${math:"+funname+"("+param1+","+param2+")} ";
				}else{
					return conditionExpression+svalue+" " ;//" "+stext+" " ;
				}
		}


		//调整1个参数的函数
		function replaceP1Function(funname,conditionExpression,svalue){
				if(svalue != funname){
					return conditionExpression+svalue+" " ;//" "+stext+" " ;
				}else 
				if( svalue == funname ){
					//将前面一个值和后面一个值变成参数
					var param1 ;
					var param2 = "";
					var temp = conditionExpression.substr(0,conditionExpression.length - 1);
					var pos1;
					//寻找第一个参数
					var lastvalue = "";
					if(newList.size() >= 1){
						 lastvalue = newList.get(newList.size()-1);//-1是参数
					}
					if(lastvalue == ""){

						pos1 =  temp.lastIndexOf(" ");
						if( pos1 <0 ){
							pos1 = 0;
						}
						if(pos1>-1){
							param1 = temp.substr(pos1);
						}
					}else{
						pos1 = temp.length - lastvalue.length - 2;
						param1 = lastvalue;
					}
					param1 = param1.replace(/\s/g,   '');
					//如果param1是变量，替换掉\${和}
					if(param1.startWith("\${") && param1.endWith("}") ){
						param1 = param1.substr(2,param1.length-3);
					}
					//return  temp.substr(0,pos1) + " \${math:"+funname+"("+param1+")} ";
					//return  temp.substr(0,pos1) + " "+funname+param1+")} ";
					return  temp.substr(0,pos1) + " "+funname+param1+") ";
				}else{
					return conditionExpression+svalue+" ";//" "+stext+" " ;
				}
		}

		//
		function clearText(){
			displayList.add($("#expressname").val());
			valueList.add($("#conditionExpression").val());

			$("#conditionExpression").val("");
			$("#expressname").val("");
			//document.all.field1.value="";
			clearSeleted("field1");
			// document.all.queryField.value=" ";
			clearSeleted("queryField");
			$("#svalue").val("");
			stextLen=0;
			svalueLen=0;
		   //取选中的值 与显示名
		}

		function  setDefault(){
			 //window.location.reload();
			 //$("#dataForm")[0].reset();
			 initData();
		}

        
		/**
		检测表达式 是否合法
		*/
		function  judgeExpress(){
			var url="<%=rootPath%>/ezflowprocess!judgeJuelExpress.action?formType="+$("#formType").val()+"&moduleId="+$("#moduleId").val()+"&formCode="+encodeURIComponent("<%=formCode%>")+"&expressstr=" + encodeURIComponent($("#conditionExpression").val());
			var result = $.ajax({url: url,async: false}).responseText;
 
            var xmlDoc = $.parseXML(result);  
 
			var succ = jQuery(xmlDoc).find("success").text();
			var message = jQuery(xmlDoc).find("message").text();
			if(succ == -1){
				whir_alert('<s:text name="workflow.Expressionisnotvalid"/>',function(){});
				return false;
			} 
			return true;
		}
 
		/**
		清除选中
		*/
		function  clearSeleted(desObj){
			try{
				if($("#"+desObj+" option").length>0){
			　　　  $("#"+desObj+" option").each(function(){ 
			　　　　　  $(this).attr("selected", false); 　　  
			　　　  })
				} 
			}catch(e){
			}	
		}

		//保存属性
		function saveText(){ 
			if($("#expressname").val()==""){
			}else{
				var _expressname =$("#expressname").val();
				if(_expressname.length >600){
					whir_poshytip(document.getElementById('td_expressname'), '表达式不能超过最大输入长度600');
					return false;
				}
				if(!needJudge){
					textToFileId();
				}
				if(!judgeExpress()){   
				   return;
				}
			}
			//名称
			//model.setText($("input[name='name']").attr("value")); 
			model.setText($("#name").attr("value"));
 

			model.setSortNum($("#sortNum").val());
			//条件表达式
			var condition = $("input[name='conditionExpression']").attr("value");
			if(condition != null && condition.length > 0){
				condition = "\${"+condition+"}";
			}
			model.setConditionExpression( condition );
			model.setConditionExpressionType("tFormalExpression");
			model.setConditionExpressionDisplay( $("textarea[name='expressname']").attr("value") );
			thisClose();
		}

        

		var  t_fieldName="";
		var  t_showType="";
		var  t_fieldId="";
		var  t_fieldSetValue="";
		/**
		根据
		**/
		function  showChooseType(svalue,stext,showType,fieldId,fieldSetValue){
            t_fieldName=svalue;
            t_showType=showType;
            t_fieldId=fieldId;
            t_fieldSetValue=fieldSetValue;
			//alert("svalue:"+svalue+"showType:"+showType+"fieldId:"+fieldId+"fieldSetValue:"+fieldSetValue); 
			var moduleId=$("#moduleId").val();
			//单选     多选    下拉框
            if(moduleId=="1"&&(showType=="103"||showType=="104"||showType=="105")){
                 $("#selectaId").show(); 
				 $("#selectaId").attr("rel","noteDiv");
				 initpop();
				 showComboxValue(fieldId);
			}else  if(moduleId=="1"&&(showType=="404"||showType=="405")){
				//单选/多选  弹出选择
				 $("#selectaId").show(); 
				 $("#selectaId").attr("rel","");
			}else{
                hideselectaId();
			}
		}

        function  showpopFirst(){
			var svfieldid="selectname";
		    if(t_showType=="404"||t_showType=="405"){
				var type="0";
				if(t_showType=="405"){
					type="1";
				}
                choice2(type,t_fieldId,t_fieldSetValue,svfieldid,null);
			}
		}
		function  initpop(){  
		    $("#selectaId").powerFloat({offsets :{x:-115, y:0} });
		} 
        
        function  selectnameFun(){
		    var v=$("#selectname").val();
            if(v==null||v==""){
			}else{
			  // $("#svalue").val($("#svalue").val()+v); 
			   $("#svalue").val(v);
			   $("#selectname").val("");
			}
		} 

		function  showComboxValue(fieldId){ 
			

			var result = $.ajax({
			   url: "<%=rootPath%>/ezflowprocess!getSelectDataByFieldId.action?fieldId="+fieldId+"&moduleId="+$("#moduleId").val(),
			   async: false
			}).responseXML;  
            $('#noteDiv_ul li').remove();

		    //$("#noteDiv_ul").find("li").remove();  
		    $(result).find("field").each(function(i){    
				var hidenValue=$(this).children("hidenValue").text();   
				var showValue=$(this).children("showValue").text();  
                var row = $("<li><input type=\"radio\" name=\"fielddataRadio\"  displaytext=\"\"  value=\""+showValue+"\"  onclick=\"chooseFieldData(this)\">"+showValue+"</li>"); 
				$('#noteDiv_ul').append(row); 
			});
		}

		function  hideselectaId(){
			$("#selectaId").hide();
		}
		function chooseFieldData(obj){
			 $("#selectname").val(obj.value);
			 wfchooseData();
		}
 
		
        //单选弹出选择404|多选弹出选择405
        function choice2(type, fieldId, str, field, evt) {
         if (str.length > 0) {
			//str = str.substring(1);
			var field_obj = document.getElementsByName(field);
			var popIndex= "0";

			if (str.indexOf('人事管理.') != -1 && str.indexOf('hrm.') != -1) {
				openWin({url:whirRootPath + '/PopSelect!intSelectHRMData.action?selectType=' + type + '&fieldId='+fieldId+'&fieldValue=' + str + '&fieldName=' + field + '&popIndex=' + popIndex,width:800,height:600,winName:'pop'+fieldId,isFull:false});
			} else {
				openWin({url:whirRootPath + '/PopSelect!initPopSelectList.action?selectType=' + type + '&fieldId='+fieldId+'&fieldValue=' + str + '&fieldName=' + field + '&popIndex=' + popIndex,width:800,height:600,winName:'pop'+fieldId,isFull:false});
			}
         }
       }

	   function  wfchooseData(){
		  selectnameFun();
	   }
	//-->
	</SCRIPT>
</head>
<body class="Pupwin" onload="initData();">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	      <s:form name="dataForm" id="dataForm" action="ezflowprocess!save.action" method="post" theme="simple" >
            <%@ include file="/public/include/form_detail.jsp"%>
			<s:hidden  name="formType"  id="formType" />
			<s:hidden  name="moduleId"  id="moduleId" /> 
			<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
			    <tr>
				    <td for='<bean:message bundle="workflow" key="workflow.transitionName"/>' width="75px" class="td_lefttitle"><bean:message bundle="workflow" key="workflow.transitionName"/><!-- 关系名 -->：</td>
					<td>
					  <!-- <textArea  name="name" id="name" style="width:98%;height:100px"  class="inputTextarea"  whir-options="vtype:[{'maxLength':600}]" ></textArea> --> 
					  <input type="text" name="name"  id="name"  class="inputText" style="width:98%" value="" 
					   whir-options="vtype:[{'maxLength':100}]" ><input type="hidden" name="selectname"  id="selectname"    ><!-- onpropertychange="selectnameFun();"  -->
					</td>
					<td nowrap>&nbsp;</td>
				</tr>

				<tr>
				    <td for='排序' width="75px" class="td_lefttitle">排序<!-- 排序 -->：</td>
					<td> 
					  <input type="text" name="sortNum"  id="sortNum"  class="inputText" style="width:98%" value="" 
					   whir-options="vtype:[{'maxLength':4},'p_integer']" > 
					</td>
					<td nowrap>&nbsp;</td>
				</tr>
				
				<tr>
				    <td for='<bean:message bundle="workflow" key="workflow.expressdisplayname"/>' class="td_lefttitle" valign="top" id="td_expressname"><bean:message bundle="workflow" key="workflow.expressdisplayname"/><!-- 表达式 -->：</td>
					<td>
					    <textArea  name="expressname" id="expressname" readonly="true" style="width:98%;height:100px"  class="inputTextarea"  whir-options="vtype:[{'maxLength':600}]" ></textArea>
					    <input type="hidden" name="conditionExpression" id="conditionExpression" value="" />
						<span class="MustFillColor"><br />1、在编辑模式下允许直接输入条件表达式，表达式的“条件”字段需要以{}符号标记</span>
						<span class="MustFillColor"><br />2、在编辑模式下输入“运算符”时，需要在“运算符”的前后添加空格，否则会导致表达式失效，如：{条件}空格!=null空格</span>
					</td>
					<td align="left" nowrap valign="top">
					   <input type="checkbox"  id="editTypeCheckbox" onClick="editTypeModer();"><bean:message bundle="workflow" key="workflow.editMode"/><!--撰写模式--><br/>
					   <input type="button" name="Submit" value='<s:text name="workflow.d_cancel_comm"/>' class="btnButton4font" onClick="clearLast();"  id="cancelbutton">
					   <input type="button" name="Submit" value='<s:text name="comm.clear"/>' class="btnButton4font" onClick="clearText();" > 
					</td>
				</tr> 
			    <tr>
				<td   class="td_lefttitle" valign="top"></td>
				<td>
					  <table  border="0"  align="left" cellspacing="0" cellpadding="0"    style="border:1px solid #d9d9d9;width:98%">
					   <tr class="subTitle">
						   <td align="center"><bean:message bundle="workflow" key="workflow.Conditional"/><!--条件--></td>
						   <td align="center"><bean:message bundle="workflow" key="workflow.Operator"/><!--运算符--></td>
						   <td align="center"  style=" border-right:0px"><bean:message bundle="workflow" key="workflow.Conditionalvalue"/><!--值--></td>	 
						</tr>
						 <tr>
						   <td align="left"  >
						      <select size="14" name="field1"  id="field1" multiple="false"  onchange="selectValue('field1',0);"   style="width:100%" >
								<option value="condi_initiatorDuty"  st="101"   fid="0"  fsv="0" ><bean:message bundle="workflow" key="workflow.StartOnePost"/><!--启动人职务--></option>
								<option value="condi_initiatorDutyLevel"   st="101"   fid="0"  fsv="0"  ><bean:message bundle="workflow" key="workflow.StartOneJobLevel"/><!--启动人职务级别--></option>
								<option value="condi_preTransactorDutyLevel"   st="101"   fid="0"  fsv="0"  ><bean:message bundle="workflow" key="workflow.JobLevelofLastActivityReviewer"/><!--上一活动办理人职务级别--></option>
								<option value="condi_initiatorLeaderDutyLevel"  st="101"   fid="0"  fsv="0"   ><bean:message bundle="workflow" key="workflow.LeaderJobLevelOfStarter"/><!--启动人上级领导职务级别--></option>
								<option value="condi_preTransactorLeaderDutyLevel"   st="101"  fid="0"  fsv="0"   ><bean:message bundle="workflow" key="workflow.LeaderJobLevelofLastActivityReviewer"/><!--上一活动办理人上级领导职务级别--></option> 
								<option value="condi_initiatorOrgName"   st="101"   fid="0"  fsv="0"   ><bean:message bundle="workflow" key="workflow.OrganizationOfStartPeople"/><!--启动人组织--></option> 
								<option value="condi_initiatorLeaderUserAccount"   st="101"   fid="0"  fsv="0"   ><bean:message bundle="workflow" key="workflow.initiatorLeaderUserAccount"/><!--启动人上级领导账号--></option> 
								<option value="condi_initiatorDepartLeaderUserAccount"   st="101"   fid="0"  fsv="0"   ><bean:message bundle="workflow" key="workflow.initiatorDepartLeaderUserAccount"/><!--启动人部门领导账号--></option> 
								<option value="condi_initiatorChargeLeaderUserAccount"   st="101"   fid="0"  fsv="0"   ><bean:message bundle="workflow" key="workflow.initiatorChargeLeaderUserAccount"/><!--启动人分管领导账号--></option>
								<option value="condi_initiatorApprovalLevel"   st="101"   fid="0"  fsv="0">启动人审批级别<!--启动人审批级别--></option>
								<option value="condi_initiatorOneLevel"   st="101"   fid="0"  fsv="0">一级审批人<!--一级审批人--></option>
								<option value="condi_initiatorTwoLevel"   st="101"   fid="0"  fsv="0">二级审批人<!--二级审批人--></option>
								<option value="condi_initiatorThreeLevel"   st="101"   fid="0"  fsv="0">三级审批人<!--三级审批人--></option>
								<option value="condi_initiatorFourLevel"   st="101"   fid="0"  fsv="0">四级审批人<!--四级审批人--></option>
								<option value="condi_initiatorFiveLevel"   st="101"   fid="0"  fsv="0">五级审批人<!--五级审批人--></option>
								<option value="condi_initiatorSixLevel"   st="101"   fid="0"  fsv="0">六级审批人<!--六级审批人--></option>
								<c:forEach items="${fieldList}" var="field">
									<c:choose><c:when test="${field[3] == '1'&&field[2]!= '401'}">
										<option value="${field[0]}" st="${field[2]}"  fid="${field[5]}"   fsv="${field[6]}" >${field[1]}</option>
										</c:when>
									</c:choose>
								</c:forEach>
							</select>
						   </td>
						   <td align="center"   >
						     <select size="14" name="queryField" id="queryField" multiple="false" onChange="selectValue('queryField',1);"  style="width:98%"  >
								<option value="&&" >And</option>
								<option value="||"  >Or</option>
								<option value="("   >(</option>
								<option value=")"   >)</option>
								<option value="!="  >!=</option>
								<option value=">"   >></option>
								<option value=">="  >>=</option>
								<option value="=="   >=</option>
								<option value="<"> < </option>
								<option value="<="  ><=</option> 
								<option value="like"  >like</option>
								<option value="notlike"  >not like </option>
								<option value="isnull ''"  >=null</option>
								<option value="notnull ''"   >!=null</option> 
								<!--<option value="\${math:like("  >like</option>
								<option value="\${math:notlike("  >not like </option>
								<option value="\${math:isnull("  >=null</option>
								<option value="\${math:notnull("   >!=null</option>-->
							  </select>
						   </td>
						   <td width="235" valign="top" nowrap   > 
						      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
							     <tr>
								     <td width="100%"><div style="width:226px;margin-top:2px;"><input type="text" name="svalue" id="svalue"     class="inputText" style="width:60%;float:left;margin-right:6px;" onBlur="setNum();"><a href="#" style="margin-left:-29px;margin-top:0px;"  class="selectIco" onclick="showpopFirst();"  id="selectaId"   name="selectaId"   rel="noteDiv" ></a>&nbsp;<input type="button" name="Submit" value='<%=Resource.getValue(local,"workflow","workflow.button_ok")%>' class="btnButton4font" onClick="setNum();" style="margin-top:3px;*float:none;*margin-top:2px;" ></div> 
									  <div id="noteDiv"     style="width:136px;min-width:136px;">  
                                            <ul id="noteDiv_ul">
											    <li><input type="radio" name="fielddataRadio"  displaytext=""  value=""  onchange="chooseFieldData('0000')">加载中,请稍后</li>  
									       </ul>
									  </div>
								    </td>
								 </tr>
							  </table> 
						   </td>					   
						</tr>
					  </table>
				   </td>
				   <td valign="top">	</td>
				</tr>			
				<tr>
				    <td  class="td_lefttitle">&nbsp;</td>
					<td>
					    <input type="button" name="Submit" value='<s:text name="comm.saveclose"/>' class="btnButton4font" onClick="saveText();" >
						<input type="button" name="Submit" value='<s:text name="comm.reset"/>' class="btnButton4font" onClick="setDefault();" >
						<input type="button" name="Submit" value='<s:text name="comm.exit"/>' class="btnButton4font" onClick="thisClose();" >
					</td>
					<td width="10" align="right" nowrap>&nbsp;</td>
				</tr> 
			</table> 
	      </s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
 /**
关闭当前的对话框
*/
function  thisClose(){
     window.close();
     ///$.dialog({id:'setExpressionDialog'}).close(); 
}
</script>
</html>