<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.ezoffice.subsidiarywork.po.QuesthemePO"%>
<%@ page import="com.whir.ezoffice.subsidiarywork.po.ThemeOptionPO"%>
<%@ page import="java.util.Iterator"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String title = "";
	if(request.getAttribute("title") !=null){
	title = request.getAttribute("title").toString();
	}
	float radioScore = 0;
	//String radioScoreSUM = "";
	float checkScore = 0;
	//String checkScoreSUM = "";
	float essayScore = 0;
	//String essayScoreSUM = "";
	
	String questionnaireId = request.getParameter("questionnaireId");
	String answerSheetId = request.getParameter("answerSheetId");
	String ballotName = "";
	if(request.getAttribute("ballotName") !=null){
	ballotName = request.getAttribute("ballotName").toString();
	}
	String ballotDate = "";
	if(request.getAttribute("ballotDate") !=null){
	ballotDate = request.getAttribute("ballotDate").toString().substring(0,16);
	}
	String themeOptionIds = "";
	if(request.getAttribute("themeOptionIds") !=null){
	themeOptionIds = request.getAttribute("themeOptionIds").toString();
	}
	 Map otherMap = (Map)request.getAttribute("otherMap");
	 
	    java.util.Map include_sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
	    int smartInUse_w = 0;
	    if(include_sysMap != null && include_sysMap.get("附件上传") != null){
	    	smartInUse_w = Integer.parseInt(include_sysMap.get("附件上传").toString());
	    }
	    String include_fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());//session.getAttribute("fileServer").toString();
	    String imgPath= smartInUse_w==1?rootPath:include_fileServer;
%>
<head>  
	<title>答卷预览</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%> 
	
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
</head>

<body class="Pupwin">
<div class="BodyMargin_10">
        <div class="docBoxNoPanel">  
    <s:form name="dataForm" id="dataForm" action="${ctx}/questionnaire!saveAnswerGraded.action" method="post" theme="simple" >  
    <%@ include file="/public/include/form_detail.jsp"%> 
    <table width="100%" height="100%" border="0" cellpadding="10" cellspacing="0" class="docBoxNoPanel">
  <tr>
    <td valign="top">
	<div id="docinfo0" style="display:;">
	<table width="100%" border="0" cellpadding="2" cellspacing="1">
                            <%
                            	int titleVlue = 0;
                                String titleVlueCN ="";
								int index = 0;
                            %>
                        <tr align="center">
                          <td valign="top" align="center"><h2><s:property value="questionnairePO.title"/></h2>
						  投票人：<s:property value="ballotName"/> &nbsp;&nbsp;&nbsp;投票时间：<s:property value="ballotDate.substring(0,16)"/> &nbsp;&nbsp;&nbsp;<span id="zongjiScore"></span>

						  </td>
                        </tr>

                        <% if(request.getAttribute("questhemeRadioList") !=null && !"NULL".equals(request.getAttribute("questhemeRadioList"))&&((List)request.getAttribute("questhemeRadioList")).size()>0){%>
                        <%
                        	titleVlue ++;
                                if(titleVlue ==1){
                                    titleVlueCN = "一.";
                                    }
                        %>
                        <tr>
                          <td valign="top"><strong><%=titleVlueCN%>&nbsp;单选题&nbsp;<span id="radioScoreSUM"></span></strong>&nbsp;&nbsp;<span id="xiaojiScore1"></span><br>

                              <table width="100%" border="0">
                              <%
                              int i = 0;
                              QuesthemePO questheme = null;
                              ThemeOptionPO themeOption= null;
                              List questhemeRadioList = (List)request.getAttribute("questhemeRadioList");
                              for(int radio=0;radio<questhemeRadioList.size();radio++){
                              %>
                                    <%
                                        questheme = (QuesthemePO) questhemeRadioList.get(radio);
                                        java.util.Set themeOptionSet = questheme.getThemeOption();
										List themeOptionList=new ArrayList();
										themeOptionList.addAll(themeOptionSet);
										int eachRowNum=questheme.getEachRowNum()!=null?Integer.parseInt(questheme.getEachRowNum().toString()):1;
                                        radioScore +=  Float.parseFloat(questheme.getScore()==null||"".equals(questheme.getScore())?"0":questheme.getScore().toString());
                                    	i++;
										index++;
                                    %>
                              <tr>
                                <td width="100%">
                                &nbsp;<%=i%>.<%=questheme.getTitle()%>
								<%
							if(questheme.getContents()!=null&&!"".equals(questheme.getContents())){
						%>
						<div class="docBoxNoPanel">
						<%
							out.print(questheme.getContents());
						%>
						</div>
						<%}%>

                               <input type="hidden" name="questhemeID" value="<%=questheme.getQuesthemeId()%>">
                              <table width="100%" border="0">
                              <%
									 int rows=0;
									 if(themeOptionList != null && themeOptionList.size()>0){
										int size=themeOptionList.size();
											
											rows=size/eachRowNum;
											int num=size%eachRowNum;
											float width=(100-eachRowNum*2)/eachRowNum;
											if(num >0){
												rows=rows+1;
											}
											for(int n0=0;n0<rows;n0++){
                                      %>
                                      <tr>
									  <%
												for(int m0=0;m0<eachRowNum;m0++){
													if((n0*eachRowNum+m0) >=size){
											%>
												<td width="2%">&nbsp;</td>
												<td width="<%=width%>%">&nbsp;</td>
											<%
													}else{
														themeOption = (ThemeOptionPO) themeOptionList.get((n0*eachRowNum+m0));
														if(themeOption.getOpImgSaveName()==null||"".equals(themeOption.getOpImgSaveName())){
											%>
		                                        <td width="2%"><input type="radio" nameArr="questhemeIdBoxRadio"  name="Box_<%=themeOption.getThemeOptionId()%>" value="<%=themeOption.getThemeOptionId()%>" disabled></td>
		                                        <td width="<%=width%>%"><%=themeOption.getTitle()%>&nbsp;<%if(themeOption.getOptionScore() !=null){%>（<%=themeOption.getOptionScore()%>分）<input type="hidden" id="s_<%=themeOption.getThemeOptionId()%>" name="s_<%=themeOption.getThemeOptionId()%>" value="<%=themeOption.getOptionScore()%>"/><%}%></td>
											<%			
														}else{
											%>
												<td width="2%">&nbsp;</td>
												<td width="<%=width%>%">
													<div style="text-align:center">
														<img onclick="imgShow(this)" src="<%=imgPath %>/upload/quesCustAnswer/<%=themeOption.getOpImgSaveName().substring(0,6)+"/"+themeOption.getOpImgSaveName().replace(".","_slt.")%>" alt="" />
													</div>
													<div style="text-align:center">
														<input type="radio" nameArr="questhemeIdBoxRadio"  name="Box_<%=themeOption.getThemeOptionId()%>" value="<%=themeOption.getThemeOptionId()%>" disabled><%=themeOption.getTitle()%>
														<%if(themeOption.getOptionScore() !=null){%>（<%=themeOption.getOptionScore()%>分）<input type="hidden" id="s_<%=themeOption.getThemeOptionId()%>" name="s_<%=themeOption.getThemeOptionId()%>" value="<%=themeOption.getOptionScore()%>"/><%}%>
													</div>
												</td>
										<%}}}%>
                                      </tr>
                                    <%}%>
									<%}%>
                                    <%
                                    if("1".equals(questheme.getIsOtherAnswer())){
												 boolean chkFlag = otherMap.get(questheme.getQuesthemeId()+"")!=null?true:false;
                                    %>
                                      <tr>
                                        <td width="2%"><input type="radio" name="Box_<%=questheme.getQuesthemeId()%>_other" onclick="chg('Box_<%=questheme.getQuesthemeId()%>',1);" value="other" <%=chkFlag?"checked":""%>  disabled="disabled"></td>
                                        <td  colspan="<%=eachRowNum*2-1%>" width="98%">其他：<input type="text" class="inputtext" name="Box_<%=questheme.getQuesthemeId()%>_otherAnswer" value="<%=otherMap.get(questheme.getQuesthemeId()+"")!=null?otherMap.get(questheme.getQuesthemeId()+"").toString():""%>" style="width:90%" maxlength="500" whir-options="vtype:[]" readonly="readonly"></td>
                                      </tr>
                                    <%}%>
                                </table>
                                </td>
                              </tr>
                              <%}%>

                            </table>

                          </td>
                        </tr>
                        <%}%>
                        <% if(request.getAttribute("questhemeCheckList") !=null && !"NULL".equals(request.getAttribute("questhemeCheckList"))&&((List)request.getAttribute("questhemeCheckList")).size()>0){%>
                        <%
                        	titleVlue ++;
                                if(titleVlue ==1){
                                    titleVlueCN = "一.";
                                    }
                                if(titleVlue ==2){
                                    titleVlueCN = "二.";
                                    }

                        %>
                        <tr>
                          <td valign="top"><strong><%=titleVlueCN%>&nbsp;多选题&nbsp;<span id="checkScoreSUM"></span></strong>&nbsp;&nbsp;<span id="xiaojiScore2"></span><br>

                                <table width="100%" border="0">
                              <% int i = 0;

                              QuesthemePO questheme = null;
                              ThemeOptionPO themeOption= null;
                              List questhemeCheckList = (List)request.getAttribute("questhemeCheckList");
                              //System.out.println(questhemeCheckList.size()+"====");
                              for(int check=0;check<questhemeCheckList.size();check++){
                              %>
                                    <%
                                        questheme = (QuesthemePO) questhemeCheckList.get(check);
                                        java.util.Set themeOptionSet = questheme.getThemeOption();
										List themeOptionList=new ArrayList();
										themeOptionList.addAll(themeOptionSet);
										int eachRowNum=questheme.getEachRowNum()!=null?Integer.parseInt(questheme.getEachRowNum().toString()):1;
                                        checkScore +=  Float.parseFloat(questheme.getScore()==null||"".equals(questheme.getScore())?"0":questheme.getScore().toString());
                                    	i++;
										index++;
                                    %>

                              <tr>
                                <td width="100%">
                                &nbsp;<%=i%>.<%=questheme.getTitle()%>&nbsp;<%if(questheme.getScore() !=null){%>（<%=questheme.getScore()%>分）<input type="hidden" name="m_<%=questheme.getQuesthemeId()%>" value="<%=questheme.getScore()%>"/><%}%>
									<%
							if(questheme.getContents()!=null&&!"".equals(questheme.getContents())){
						%>
						<div class="docBoxNoPanel">
						<%
							out.print(questheme.getContents());
						%>
						</div>
						<%}%>

                                <input type="hidden" id="questhemeID" name="questhemeID" value="<%=questheme.getQuesthemeId()%>">
								<input type="hidden" id="_questhemeID" name="_questhemeID" value="<%=questheme.getQuesthemeId()%>">
                              <table width="100%" border="0">
                              <%
                                    if(themeOptionList != null && themeOptionList.size()>0){
											int size=themeOptionList.size();
											
											int rows=size/eachRowNum;
											int num=size%eachRowNum;
											float width=(100-eachRowNum*2)/eachRowNum;
											if(num >0){
												rows=rows+1;
											}
											for(int n0=0;n0<rows;n0++){
                                      %>
                                    <tr>
										<%
												for(int m0=0;m0<eachRowNum;m0++){
													if((n0*eachRowNum+m0) >=size){
											%>
												<td width="2%">&nbsp;</td>
												<td width="<%=width%>%">&nbsp;</td>
											<%
													}else{
														themeOption = (ThemeOptionPO) themeOptionList.get((n0*eachRowNum+m0));
														if(themeOption.getOpImgSaveName()==null||"".equals(themeOption.getOpImgSaveName())){
											%>
												<td width="2%" name="td_<%=questheme.getQuesthemeId()%>"><input type="checkbox" id="td_checkbox_<%=questheme.getQuesthemeId()%>" name="questhemeIdBox" value="<%=themeOption.getThemeOptionId()%>" disabled></td>
												<td width="<%=width%>%"><%=themeOption.getTitle()%>&nbsp;<input type="hidden" name="pitchon_<%=questheme.getQuesthemeId()%>" value="<%=themeOption.getPitchon()%>"/><%if(themeOption.getPitchon()!=null && "1".equals(themeOption.getPitchon().toString())){%><!--<img style="cursor:hand" border="0" src="images/finsh.gif">--><%}%></td>
											<%			
														}else{
											%>
												<td width="2%">&nbsp;</td>
												<td width="<%=width%>%">
													<div style="text-align:center">
														<img onclick="imgShow(this)" src="<%=imgPath %>/upload/quesCustAnswer/<%=themeOption.getOpImgSaveName().substring(0,6)+"/"+themeOption.getOpImgSaveName().replace(".","_slt.")%>" alt="" />
													</div>
													<div style="text-align:center">
														<input type="checkbox" id="td_checkbox_<%=questheme.getQuesthemeId()%>" name="questhemeIdBox" value="<%=themeOption.getThemeOptionId()%>" disabled><%=themeOption.getTitle()%>
														<input type="hidden" name="pitchon_<%=questheme.getQuesthemeId()%>" value="<%=themeOption.getPitchon()%>"/>
													</div>
												</td>
											<%}}}%>
                                    </tr>
                                    <%}%>
									<%}%>
                                    <%
                                    if("1".equals(questheme.getIsOtherAnswer())){
												 boolean chkFlag = otherMap.get(questheme.getQuesthemeId()+"")!=null?true:false;
                                    %>
                                    <tr>
                                        <td width="2%"><input type="checkbox" name="Box_<%=questheme.getQuesthemeId()%>_other" value="other" <%=chkFlag?"checked":""%> disabled="disabled"></td>
                                        <td colspan="<%=eachRowNum*2-1%>" width="98%">其他：<input type="text" class="inputtext" name="Box_<%=questheme.getQuesthemeId()%>_otherAnswer" value="<%=otherMap.get(questheme.getQuesthemeId()+"")!=null?otherMap.get(questheme.getQuesthemeId()+"").toString():""%>" style="width:90%" maxlength="500" readonly="readonly"></td>
                                        </tr>
                                    <%}%>
                                </table>
                                </td>
                              </tr>
                               
                              <%}%>
                            </table>
                          </td>
                        </tr>
                        <%}%>
                        <% if(request.getAttribute("questhemeEssayList") !=null && !"NULL".equals(request.getAttribute("questhemeEssayList"))&&((List)request.getAttribute("questhemeEssayList")).size()>0){%>
                        <%
                        	titleVlue ++;
                                if(titleVlue ==1){
                                    titleVlueCN = "一.";
                                    }
                                if(titleVlue ==2){
                                    titleVlueCN = "二.";
                                    }
                                if(titleVlue ==3){
                                    titleVlueCN = "三.";
                                    }

                        %>
                        <tr>
                          <td valign="top"><strong><%=titleVlueCN%>&nbsp;问答题&nbsp;<span id="essayScoreSUM"></span></strong><br>
                          	<table width="100%" border="0">
                              <%
                                int i = 0;
                              List questhemeEssayList = (List)request.getAttribute("questhemeEssayList");
                              for(int essay=0;essay<questhemeEssayList.size();essay++){
                              %>
                                    <%
                                      Object[] obj = (Object[]) questhemeEssayList.get(essay);
                                      essayScore +=  Float.parseFloat(obj[2]==null||"".equals(obj[2]+"")?"0":obj[2].toString());
                                      i++;
                                    %>
                              <tr>
                                <td width="100%">
                                &nbsp;<%=i%>.<%=obj[1]%>&nbsp;<%if(obj[2] !=null){%>（<%=obj[2]%>分）<%}%>&nbsp;&nbsp;得分：<s:if test="userId==null"><input type="text" name="Text_<%=obj[3]%>" style="width: 50px;" class="inputText" whir-options="vtype:['notempty','p_decimal']" value="<%if(obj[5] !=null){%><%=obj[5]%><%}%>" maxlength="4" size="4"></s:if><s:else><%=obj[5]!=null?obj[5]:""%></s:else><input type="hidden" id="aaId" name="aa" value="<%=obj[5]!=null?obj[5].toString():"0"%>"/>
                                <input type="hidden" name="Point_<%=obj[3]%>" value="<%=obj[2]%>">
                                <input type="hidden" name="essayQuesthemeID" value="<%=obj[3]%>">
                              <table width="100%" border="0">
                                    <tr>
                                        <td width="100%"><textarea style="width:98%" rows="10" class="inputtextarea" name="<%=obj[3]%>_Textarea" readonly="ture"><%=obj[4]==null?"":obj[4]%></textarea></td>
                                    </tr>
                            </table>
                                </td>
                              </tr>
                              <%}%>
                            </table>
                          </td>
                        </tr>
                        <%}%>
                        <input type="hidden" id="radioScore" name="radioScore" value="<%=radioScore%>">
                        <input type="hidden" id="checkScore" name="checkScore" value="<%=checkScore%>">
                    	<input type="hidden" id="essayScore" name="essayScore" value="<%=essayScore%>">
						<input type="hidden" id="answerSheetId" name="answerSheetId" value="<%=answerSheetId%>">
                        <input type="hidden" id="questionnaireId" name="questionnaireId" value="<%=questionnaireId%>">
						<input type="hidden" id="themeOptionIds" name="themeOptionIds" value="<%=themeOptionIds%>">
						<input type="hidden" id="index" name="index" value="<%=index%>">

        </table>
        </div>
        <br/>
        <s:if test="userId==null">
        <table>
            <tr>
                <td height="40" colspan="2">  
                    <input type="button" class="btnButton4font" onclick="ok_exit(0,this);" value="提&nbsp;&nbsp;交" />  
                     <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                </td>
            </tr>
        </table>
        </s:if>
    </td>
  </tr>
</table>
</s:form>  
        </div>  
    </div> 
	<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
     	<div id="innerdiv"style="position:absolute;">
     		<img id="bigimg" style="border:5px solid #fff;" src="" />
     	</div>
     </div>
</body>
<script type="text/javascript">
//*************************************下面的函数属于公共的或半自定义的*************************************************//  
	//设置表单为异步提交 
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

	$(document).ready(function(){
		
		var radioScore = $('#radioScore').val();
		
	    if(radioScore != 0.0){
	        $('#radioScoreSUM').html("（"+radioScore+"分）");
	    }
	    var checkScore = $('#checkScore').val();
	    if(checkScore != 0.0){
	        $('#checkScoreSUM').html("（"+checkScore+"分）");
	    }
	    var essayScore = $('#essayScore').val();
	    if(essayScore != 0.0){
	        $('#essayScoreSUM').html("（"+essayScore+"分）");
	     }
	
	
		var themeOptionIds = $('#themeOptionIds').val();
		var index = $('#index').val();
		var sigle = 0;
		var mutil = 0;
	    if(index >=1){//questhemeIdBoxRadio
		    //if(themeOptionIds.indexOf($("#questhemeIdBox").val()) !=-1){
				//$("#questhemeIdBox").attr('checked',true);
				//if($("#questhemeIdBox").attr("type")=='radio'){
					//if(!isNaN($('#s_'+$("#questhemeIdBox").val()).val())){
					//	sigle += eval($('#s_'+$("#questhemeIdBox").val()).val());
					//}
				//}
			//}
		     $("input[nameArr='questhemeIdBoxRadio']").each(function(){
				var ss=$(this).val();
				if(themeOptionIds.indexOf($(this).val()) !=-1){
					$(this).attr('checked',true);
					if($(this).attr("type")=='radio'){
						if(!isNaN($('#s_'+$(this).val()).val())){
							sigle += eval($('#s_'+$(this).val()).val());
						}
					}
				}
			});
		    $("input[name='questhemeIdBox']").each(function(){
				if(themeOptionIds.indexOf($(this).val()) !=-1){
					$(this).attr('checked',true);
				}
			});
		}
	<%if(!"1".equals(request.getParameter("showuserId"))){%>
	    //alert($('#_questhemeID').length);
		if($('#_questhemeID').length>0){
			var questhemeIDs = document.getElementsByName("_questhemeID");
			$("input[name='_questhemeID']").each(function(){
				var m1="";
				var m2="";
				//alert("1:"+$(this).val());
				$("input[name='"+'pitchon_'+$(this).val()+"']").each(function(){
					//alert("pitchon:"+$(this).val());
					m1+=$(this).val()+",";
				});
				
				$("td[name='"+'td_'+$(this).val()+"']").each(function(){
					//$("input[name=questhemeIdBox][checked]").val(); 
					//alert($(this).find('input').attr('checked'));
					if($(this).find('input').attr('type')=='checkbox'&&$(this).find('input').attr('checked')=='checked'){
						m2 += "1,";
					} else {
						m2 += "0,";
					}			
				});
				//m2 = '0,0,1,';
				//alert(m1+'-----------'+m2)
				if(m2.indexOf('1')!=-1 && m1 == m2){
					//alert($("input[name=m_"+$(this).val()+"]"));
					mutil += eval($($("input[name=m_"+$(this).val()+"]")).val());
				}
			});
			/*for(var i=0; i<questhemeIDs.length; i++){
				alert("a:"+questhemeIDs[i].value);
				var pitchon_ = document.getElementsByName("pitchon_"+questhemeIDs[i].value);
				var m1="";
				var m2="";
				for(var j=0; j<pitchon_.length; j++){
					alert("pitchon:"+pitchon_[j].value);
					m1+=pitchon_[j].value+",";
				}
				var td_ = document.getElementsByName("td_"+questhemeIDs[i].value);
				for(var k=0; k<td_.length; k++){
					alert("===="+td_[k].firstChild.checked);
					if(td_[k].firstChild.checked){
						m2 += "1,";
					} else {
						m2 += "0,";
					}
				}
				alert(m1+'-----------'+m2)
				if(m2.indexOf('1')!=-1 && m1 == m2){
					mutil += eval(document.getElementById("m_"+questhemeIDs[i].value).value);
				}
			}*/
		}
		
		if($('#xiaojiScore1').length>0)
			$('#xiaojiScore1').html("小计："+sigle+" 分");
		if($('#xiaojiScore2').length>0)
			$('#xiaojiScore2').html("小计："+mutil+" 分");
		
		var zongji = 0;
		var aa0 = 0;
	
		//var aa = document.getElementsByName("aa");
		//alert($('#aaId').length);
		$("input[name='aa']").each(function(){
			if($(this).length>0){
				aa0 += eval($(this).val());
			}
		});
		/*if($('#aaId').length>0){
			for(var i=0; i<aa.length; i++){
				if(aa[i] != undefined){
					aa0 += eval(aa[i].value);
				}
			}
		}*/
		zongji = sigle + mutil + aa0;
		//document.getElementById("zongjiScore").outerHTML = "总计："+zongji+" 分";
		//alert("2:"+zongji);
		$('#zongjiScore').html("总计："+zongji+" 分");
		<%}%>
		//$("input:checkbox, input:radio").uniform();	
	});
	
	function ok_exit(type,obj){
		if($("input[name='essayQuesthemeID']").length>0){
			$("input[name='essayQuesthemeID']").each(function(){
				var essayQuesthemeID = $(this).val();
				var essayObj = $("input[name='Text_"+essayQuesthemeID+"']");
				if(essayObj.length>0){
					if(essayObj.val()==''){
					   whir_poshytip(essayObj,'评分不能为空！');
			           eval(essayObj.focus());
			           return;
					}
					if(essayObj.val().substring(0,1) ==" "){
					   whir_poshytip(essayObj,'评分不能为空格开头！');
			           eval(essayObj.focus());
			           return;
					}
					
					if(parseFloat(eval(essayObj.val())) > parseFloat(eval($("input[name='Point_"+essayQuesthemeID+"']").val()))){
					   whir_poshytip(essayObj,'你的评分大于本题的分数，请重新评分！');
			           eval(essayObj.focus());
			           return;
					}
					
				}
			});
		}
		ok(type,obj);
	}

	function imgShow(_this){
	    var src = $(_this).attr("src");//获取当前点击的缩略图路径
	    src = src.replace("_slt","");//原图路径
	    $("<img/>").attr("src", src).load(function(){
	    	var windowW = $(window).width();//获取当前窗口宽度
	        var windowH = $(window).height();//获取当前窗口高度
	        var realWidth = this.width;//获取图片真实宽度
	        var realHeight = this.height;//获取图片真实高度
	        var imgWidth, imgHeight;
	        var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放
	        if(realHeight>windowH*scale) {//判断图片高度
	            imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
	            imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
	            if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
	                imgWidth = windowW*scale;//再对宽度进行缩放
	            }
	        } else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
	            imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
	                        imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
	        } else {//如果图片真实高度和宽度都符合要求，高宽不变
	            imgWidth = realWidth;
	            imgHeight = realHeight;
	        }
	        $("#bigimg").css("width",imgWidth);//以最终的宽度对图片缩放
	        var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
	        var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
	        $("#innerdiv").css({"top":h, "left":w});//设置#innerdiv的top和left属性
	    	$("#bigimg").attr("src", src);//设置#bigimg元素的src属性
	    	$("#outerdiv").fadeIn("fast");//淡入显示#outerdiv及.pimg
	    });	
	    	
	    $("#outerdiv").click(function(){//再次点击淡出消失弹出层
	        $(this).fadeOut("fast");
	    });
	}

//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
</script>
</html>