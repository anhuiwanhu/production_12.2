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
	String isRepeatName = "";
	if(request.getAttribute("isRepeatName") !=null){
		isRepeatName = request.getAttribute("isRepeatName").toString();
	}
	float radioScore = 0;
	float checkScore = 0;
	float essayScore = 0;
	String questionnaireId = request.getParameter("questionnaireId");
	int questionCount = 0 ;
    java.util.Map include_sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
    int smartInUse_w = 0;
    if(include_sysMap != null && include_sysMap.get("附件上传") != null){
    	smartInUse_w = Integer.parseInt(include_sysMap.get("附件上传").toString());
    }
    String include_fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());//session.getAttribute("fileServer").toString();
    String imgPath= smartInUse_w==1?rootPath:include_fileServer;
%>
<head>  
	<title>问卷</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%> 
	
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
</head>

<body class="Pupwin">
<div class="BodyMargin_10">    
        <div class="docBoxNoPanel">  
    <s:form name="dataForm" id="dataForm" action="${ctx}/questionnaire!addQuestionnaireAnswer.action" method="post" theme="simple" >  
    <%@ include file="/public/include/form_detail.jsp"%> 
    <table width="100%" height="100%" border="0" cellpadding="10" cellspacing="0" class="docBoxNoPanel">
  <tr>
    <td valign="top">
	<div id="docinfo0" style="display:;">
	<table width="100%" border="0" cellpadding="2" cellspacing="1">
                            <%
	                            int titleVlue = 0;
	                            String titleVlueCN ="";
                            %>
                        <tr align="center">
                          <td valign="top" align="center"><h2><%=title%></h2></td>
                        </tr>
                        <% if(request.getAttribute("questhemeRadioList") !=null && !"NULL".equals(request.getAttribute("questhemeRadioList"))&&((List)request.getAttribute("questhemeRadioList")).size()>0){%>
                        <%
                        	titleVlue ++;
                                if(titleVlue ==1){
                                    titleVlueCN = "一.";
                                }
                        %>
                        <tr>
                          <td valign="top"><strong><%=titleVlueCN%>&nbsp;单选题&nbsp;<span id="radioScoreSUM"></span></strong><br>

                              <table width="100%" border="0">
                              <%
                              int i = 0;
                              QuesthemePO questheme = null;
                              ThemeOptionPO themeOption= null;
                              List questhemeRadioList = (List)request.getAttribute("questhemeRadioList");
                              for(int radio=0;radio<questhemeRadioList.size();radio++){
                              %>
                                    <%
	                                    questionCount++;
	                                    questheme = (QuesthemePO) questhemeRadioList.get(radio);
	                                    java.util.Set themeOptionSet = questheme.getThemeOption();
										List themeOptionList=new ArrayList();
										themeOptionList.addAll(themeOptionSet);
										int eachRowNum=questheme.getEachRowNum()!=null?Integer.parseInt(questheme.getEachRowNum().toString()):1;
	                                    radioScore +=  questheme.getScore()!=null?Float.parseFloat(questheme.getScore().toString()):0;
	                                	i++;
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
                                        		<td width="2%"><input type="radio"  name="Box_<%=questheme.getQuesthemeId()%>" value="<%=themeOption.getThemeOptionId()%>"  onclick="chg('Box_<%=questheme.getQuesthemeId()%>',0);"></td>
                                        		<td width="<%=width%>%"><%=themeOption.getTitle()%></td>
                                        	<%			
														}else{
											%>
												<td width="2%">&nbsp;</td>
												<td width="<%=width%>%">
													<div style="text-align:center">
														<img onclick="imgShow(this)" src="<%=imgPath %>/upload/quesCustAnswer/<%=themeOption.getOpImgSaveName().substring(0,6)+"/"+themeOption.getOpImgSaveName().replace(".","_slt.")%>" alt="" />
													</div>
													<div style="text-align:center">
														<input type="radio"  name="Box_<%=questheme.getQuesthemeId()%>" value="<%=themeOption.getThemeOptionId()%>"  onclick="chg('Box_<%=questheme.getQuesthemeId()%>',0);"><%=themeOption.getTitle()%>
													</div>
												</td>
												<%}}}%>
                                      </tr>
                                    <%}%>
									<%}%>
                                    <%
                                    if("1".equals(questheme.getIsOtherAnswer())){
                                    %>
                                      <tr>
                                        <td width="2%"><input type="radio" name="Box_<%=questheme.getQuesthemeId()%>_other" onclick="chg('Box_<%=questheme.getQuesthemeId()%>',1);" value="other"></td>
                                        <td  colspan="<%=eachRowNum*2-1%>" width="98%">其他：<input type="text" class="inputtext" name="Box_<%=questheme.getQuesthemeId()%>_otherAnswer" value="" style="width:94%" maxlength="500" whir-options="vtype:[]"></td>
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
                          <td valign="top"><strong><%=titleVlueCN%>&nbsp;多选题&nbsp;<span id="checkScoreSUM"></span></strong><br>

                              <table width="100%" border="0">
                              <% int i = 0;

                              QuesthemePO questheme = null;
                              ThemeOptionPO themeOption= null;
                              List questhemeCheckList = (List)request.getAttribute("questhemeCheckList");
                              //System.out.println(questhemeCheckList.size()+"====");
                              for(int check=0;check<questhemeCheckList.size();check++){
                              %>
                                    <%
                                    	questionCount++;
                                        questheme = (QuesthemePO)questhemeCheckList.get(check);
                                        java.util.Set themeOptionSet = questheme.getThemeOption();
										List themeOptionList=new ArrayList();
										themeOptionList.addAll(themeOptionSet);
										int eachRowNum=questheme.getEachRowNum()!=null?Integer.parseInt(questheme.getEachRowNum().toString()):1;
                                        checkScore +=  questheme.getScore()!=null?Float.parseFloat(questheme.getScore().toString()):0;
                                    	i++;
                                    %>

                              <tr>
                                <td width="100%">
                                &nbsp;<%=i%>.<%=questheme.getTitle()%>
                                &nbsp;<span name="dbselect" id="dbselect" ind="<%=i%>" val="<%=questheme.getQuesthemeId()%>" property="<%=questheme.getSelanswernum()==null||questheme.getSelanswernum().intValue()==0?"":questheme.getSelanswernum().toString()%>" style="display:<%=questheme.getSelanswernum()==null||questheme.getSelanswernum().intValue()==0?"none":""%>">（只能选择少于 <%=questheme.getSelanswernum()%> 个答案）</span>
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
								<input type="hidden" name="_questhemeID" value="<%=questheme.getQuesthemeId()%>">
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
												<td width="2%" name="td_<%=questheme.getQuesthemeId()%>"><input type="checkbox" id="td_checkbox_<%=questheme.getQuesthemeId()%>" name="Box_<%=questheme.getQuesthemeId()%>" value="<%=themeOption.getThemeOptionId()%>"></td>
												<td width="<%=width%>%"><%=themeOption.getTitle()%>&nbsp;</td>
											<%			
														}else{
											%>
												<td width="2%">&nbsp;</td>
												<td width="<%=width%>%">
													<div style="text-align:center">
														<img onclick="imgShow(this)" src="<%=imgPath %>/upload/quesCustAnswer/<%=themeOption.getOpImgSaveName().substring(0,6)+"/"+themeOption.getOpImgSaveName().replace(".","_slt.")%>" alt="" />
													</div>
													<div style="text-align:center">
														<input type="checkbox" id="td_checkbox_<%=questheme.getQuesthemeId()%>" name="Box_<%=questheme.getQuesthemeId()%>" value="<%=themeOption.getThemeOptionId()%>"><%=themeOption.getTitle()%>
													</div>
												</td>
											<%}}}%>
                                    </tr>
                                    <%}%>
									<%}%>
                                    <%
                                    if("1".equals(questheme.getIsOtherAnswer())){
                                    %>
                                    <tr>
                                        <td width="2%"><input type="checkbox" name="Box_<%=questheme.getQuesthemeId()%>_other" value="other"></td>
                                        <td colspan="<%=eachRowNum*2-1%>" width="98%">其他：<input type="text" class="inputtext" name="Box_<%=questheme.getQuesthemeId()%>_otherAnswer" value="" style="width:94%" maxlength="500"></td>
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
                             	QuesthemePO questheme = null;
                              List questhemeEssayList = (List)request.getAttribute("questhemeEssayList");
                              for(int essay=0;essay<questhemeEssayList.size();essay++){
                              %>
                                    <%
                                      questionCount++;
                                      questheme = (QuesthemePO)questhemeEssayList.get(essay);
                                      essayScore +=  questheme.getScore()!=null?Float.parseFloat(questheme.getScore().toString()):0;
                                  	  i++;
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
									<input type="hidden" name="essayQuesthemeID" value="<%=questheme.getQuesthemeId()%>">
                              		<table width="100%" border="0">
                                    <tr>
                                        <td width="100%"><textarea style="width:98%;height:150px;" rows="10" class="inputTextarea" name="Textarea_<%=questheme.getQuesthemeId()%>"></textarea></td>
                                    </tr>
                            		</table>
                                </td>
                              </tr>
                              <%}%>
                            </table>
                          </td>
                        </tr>
                        <%}%>
                        
                        <tr>
                            <td height="20" colspan="2">
                                    <DIV id="tdDIV3" style="display:none">
                                            <font color="red">您好，此问卷您已经提交过。(每份问卷只允许提交一次) <font>
                                    </DIV>
                            </td>
                        </tr>
                        
                        <input type="hidden" id="radioScore" name="radioScore" value="<%=radioScore%>">
                        <input type="hidden" id="checkScore" name="checkScore" value="<%=checkScore%>">
                    	<input type="hidden" id="essayScore" name="essayScore" value="<%=essayScore%>">
                        <input type="hidden" id="questionnaireId" name="questionnaireId" value="<%=questionnaireId%>">
                        <input type="hidden" id="isRepeatName" name="isRepeatName" value="<%=isRepeatName%>"/>
                        <input type="hidden" id="titleVlue" name="titleVlue" value="<%=titleVlue%>">
                        
        </table>
        </div>
        <s:if test="userId==null">
        <table>
            <tr>
                <td height="40" colspan="2">
                	<span id="commAnSpan" style="display:"> 
	                    <input type="button" id="btnSubmit" class="btnButton4font" onclick="ok_exit(0,this);" value="提&nbsp;&nbsp;交" />  
	                    <input type="button" ud="btnReset" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />
                    </span>
	                <input type="button" id="btnClose" class="btnButton4font" onclick="window.close();" value='<s:text name="comm.exit"/>' />
                    <span id="myAnSpan" style="display:none"><input type="button" class="btnButton4font" onclick="javascript:myQuestionare();" value="我的答卷"/></span>  
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
	    
	    var isRepeatName = $('#isRepeatName').val();
	    var titleVlue = $('#titleVlue').val();
	    //alert("isRepeatName:"+isRepeatName+"-titleVlue:"+titleVlue);
	    if (isRepeatName == "isRepeatName"){
			if(titleVlue !=0){
				$('#tdDIV3').css('display','');
				$('#myAnSpan').css('display','');
				$('#commAnSpan').css('display','none');
			}
	
	    }
	
		//$("input:checkbox, input:radio").uniform();	
	});
	
	function ok_exit(type,obj){
		var result = 0;
		if($("input[name='questhemeID']").length>0){
			$("input[name='questhemeID']").each(function(){
				var questhemeID = $(this).val();
				var ff = true;
				var flag = true;
				var Box_questhemeID_other = $("input[name='"+"Box_"+questhemeID+"_other"+"']");
				var Box_questhemeID = $("input[name='"+"Box_"+questhemeID+"']");
	            if(Box_questhemeID_other.length>0){
	               if(checkRadioOrCheckBox(Box_questhemeID_other)){
		               ff = false;
	               }
				   if(checkOtherAnswer(Box_questhemeID_other,questhemeID)){
		               flag = false;
	               }
	            }
				if(!flag){
					result++;
		            return false;
				}
	            if(ff&&Box_questhemeID.length>0){
	            	if(!checkRadioOrCheckBox(Box_questhemeID)){
	            		$.dialog.alert("单选和多选题的答案不能为空，请认真检查再提交！");
	            		result++;
		                return false;
	            	}
	            }
			});
		}
		
		if($("span[name='dbselect']").length>0){
			$("span[name='dbselect']").each(function(){
				var p = $(this).attr('property');
			    if(p!=''&&p!='null'&&p!='0'){
			    	var val = $(this).attr('val');
			    	var answer = $("input[name='"+"Box_"+val+"']");
					var other = $("input[name='"+"Box_"+val+"_other']");
			    	var cnt = 0;
			    	answer.each(function(){
			    		if($(this).attr('checked')=='checked'){
			    			cnt++;
			    		}
			    	});
					other.each(function(){
			    		if($(this).attr('checked')=='checked'){
			    			cnt++;
			    		}
					});
			        if(parseInt(p)<cnt){
					   $.dialog.alert("多选题 "+$(this).attr('ind')+".只能选择少于"+p+"个答案！");
					   result++;
					   return;
				    }
			    }
			});
	   }
		
		if($("input[name='essayQuesthemeID']").length>0){
			$("input[name='essayQuesthemeID']").each(function(){
				var essayQuesthemeID = $(this).val();
				if(($("textarea[name='"+"Textarea_"+essayQuesthemeID+"']").val()).replace(/[^\x00-\xff]/g,"**").length> 2000){
					$.dialog.alert("回答问答题，答案不得多于1000个字。");
	                $("input[name='essayQuesthemeID']").focus();
	                result++;
	                return;
				}
			});
		}
		//alert(result);
		if(result==0){
			ok(type,obj);
			$("#btnSubmit").attr('disabled','true');
			$("#btnReset").attr('disabled','true');
			$("#btnClose").attr('disabled','true');
			//setTimeout("fobbidenBtn()",5000,"javascript");
		}
		
	}
	function checkOtherAnswer(obj,questhemeID){
		var j=0;
		obj.each(function(){
			if($(this).attr('checked')=='checked'){
					var nr=$("input[name='"+"Box_"+questhemeID+"_otherAnswer"+"']").val();
					if(nr == ''){
						 whir_poshytip($("input[name='"+"Box_"+questhemeID+"_otherAnswer"+"']"),"其他选项被选中后不能为空！");
						 j++;
	          			return false;
					}
	          		
	          	}
		});
		if(j==0){
	          	return false;
	          }else{
	          	return true;
	          }
	}
	function checkRadioOrCheckBox(obj){
		var j=0;
		obj.each(function(){
			if($(this).attr('checked')=='checked'||$(this).attr('disabled')=='disabled'){
	          		j++;
	          		return false;
	          	}
		});
		if(j==0){
	          	return false;
	          }else{
	          	return true;
	          }
	}
	
	function changeContent(){
		var divs = document.getElementsByTagName("div");
		for(var i=0;i<divs.length;i++){
			if(divs[i].className == "docBoxNoPanel"){
				var str = divs[i].innerHTML;
				str = str.replace(/<\/?.+?>/g,"");//去掉所有的html标记 
				if(str == "" || str == "&nbsp;"){
					divs[i].style.display = "none";
				}
			}
		}
	}
	
	function fobbidenBtn(){
		$("#btnSubmit").attr('disabled','false');
		$("#btnReset").attr('disabled','false');
		$("#btnClose").attr('disabled','false');
	}
	function myQuestionare() {
		var questionnaireId = $('#questionnaireId').val();
		openWin({url:'questionnaire!viewMyQuestionare.action?questionnaireId='+questionnaireId,isFull: true,width:800,height:500,winName:'viewMyQuestionare'});
	}
	
	function chg(id, type){
	    if(type==0){
			var a = document.getElementsByName(id+"_other");
	        for(var i=0; i<a.length; i++){
	            a[i].checked=false;
	        }
	    }else{
	        var a = document.getElementsByName(id);
	        for(var i=0; i<a.length; i++){
	            a[i].checked=false;
	        }
	    }
	}
	
	/*
	判断单选框(objCheckbox)是否被选中
	如果有被选中的则返回true，如果没有被选中的则返回false
	*/
	function checkboxIsChecked(objCheckbox){
		if(objCheckbox){
			if(objCheckbox.length){
	                    var j=0;
	                    for(var i=0;i<objCheckbox.length;i++){
	                    	if(objCheckbox[i].disabled || objCheckbox[i].checked){
	                        	j++;
	                                break;
	                        }
	                    }
	                    if(j==0){
	                    	return false;
	                    }else{
	                    	return true;
	                    }
	                }else{
	                	if(objCheckbox.disabled || objCheckbox.checked){
	                        	return true;
	                        }else{
	                        	return false;
	                        }
	                }
	        }else{
	        	return false;
	        }
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