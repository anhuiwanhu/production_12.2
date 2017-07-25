<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.subsidiarywork.po.QuesthemePO"%>
<%@ page import="com.whir.ezoffice.subsidiarywork.po.ThemeOptionPO"%>
<%@ page import="java.util.Iterator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String title = "";
    if(request.getAttribute("title") !=null){
    	title = request.getAttribute("title").toString();
    }
    float radioScore = 0;
    float checkScore = 0;
    float essayScore = 0;
    java.util.Map include_sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
    int smartInUse_w = 0;
    if(include_sysMap != null && include_sysMap.get("附件上传") != null){
    	smartInUse_w = Integer.parseInt(include_sysMap.get("附件上传").toString());
    }
    String include_fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());//session.getAttribute("fileServer").toString();
    String imgPath= smartInUse_w==1?rootPath:include_fileServer;
%>
<head>  
	<title>问卷预览</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%> 
	
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
</head>
<body class="Pupwin">
<div class="BodyMargin_10">
<div class="docBoxNoPanel">
    <table width="100%" height="100%" border="0" cellpadding="10" cellspacing="0" class="docBoxNoPanel">
	  <tr>
	    <td valign="top">
		<div id="docinfo0" style="display:;">
		    	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <%
						int titleVlue = 0;
						String titleVlueCN ="";
					%>
					<tr>
					  <td valign="top" align="center"><h2><%=title%></h2></td>
					</tr>
					<% if(request.getAttribute("questhemeRadioList") !=null && !"NULL".equals(request.getAttribute("questhemeRadioList"))){%>
						<%
							List questhemeRadioList = (List)request.getAttribute("questhemeRadioList");	
							titleVlue ++;
							if(titleVlue ==1){
								titleVlueCN = "一.";
							}
						%>
						<tr>
						  <td valign="top"><strong><%=titleVlueCN%>单选题;<span id="radioScoreSUM"></span></strong><br>
		
							  <table width="100%" border="0">
							  <%
							  int i = 0;
		
							  QuesthemePO questheme = null;
							  ThemeOptionPO themeOption= null;
							  %>
							  <%for(int radio =0;radio<questhemeRadioList.size();radio++){%>
									<%
										questheme = (QuesthemePO)questhemeRadioList.get(radio);
										java.util.Set themeOptionSet = questheme.getThemeOption();
										List themeOptionList=new ArrayList();
										themeOptionList.addAll(themeOptionSet);
										radioScore +=  questheme.getScore()!=null?Float.parseFloat(questheme.getScore().toString()):0;
										int eachRowNum=questheme.getEachRowNum()!=null?Integer.parseInt(questheme.getEachRowNum().toString()):1;
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
								 <%
								 if(themeOptionList != null && themeOptionList.size()>0){
								%>
									<table width="100%" border="0">
										<%
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
												<td width="2%"><input type="radio" name="radio" value="1" disabled="true"></td>
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
														<input type="radio" name="radio" value="1" disabled="true"><%=themeOption.getTitle()%>
													</div>
												</td>
											<%}}} %>
										</tr>
										<%}%>
									</table>
								<%}%>
								</td>
							  </tr>
							  <%} %>
							  </table>
							  </td>
							  </tr>
							  <%}%>
							  <% if(request.getAttribute("questhemeCheckList") !=null && !"NULL".equals(request.getAttribute("questhemeCheckList"))){%>
							  <%
							  	List questhemeCheckList = (List)request.getAttribute("questhemeCheckList");
							  	
								titleVlue ++;
								if(titleVlue ==1){
									titleVlueCN = "一.";
								}
								if(titleVlue ==2){
									titleVlueCN = "二.";
								}
			
							  %>
							<tr>
							  <td valign="top"><strong><%=titleVlueCN%>多选题<span id="checkScoreSUM"></span></strong><br>
			
									<table width="100%" border="0">
								  <% int i = 0;
			
								  QuesthemePO questheme = null;
								  ThemeOptionPO themeOption= null;
								  %>
								  <%for(int checkbox =0;checkbox<questhemeCheckList.size();checkbox++){%>
										<%
										questheme = (QuesthemePO) questhemeCheckList.get(checkbox);
											java.util.Set themeOptionSet = questheme.getThemeOption();
											List themeOptionList=new ArrayList();
											themeOptionList.addAll(themeOptionSet);
											checkScore +=  questheme.getScore()!=null?Float.parseFloat(questheme.getScore().toString()):0;
											int eachRowNum=questheme.getEachRowNum()!=null?Integer.parseInt(questheme.getEachRowNum().toString()):1;
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
									 <%
								 if(themeOptionList != null && themeOptionList.size()>0){
								%>
								  <table width="100%" border="0">
										<%
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
												<td width="2%"><input type="checkbox" disabled="true"></td>
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
														<input type="checkbox" disabled="true"><%=themeOption.getTitle()%>
													</div>
												</td>
											<%}}}%>
											
											</tr>
										<%}%>
									</table>
									<%}%>
									</td>
								  </tr>
								</table>
								<%}%>
							  </td>
							</tr>
							<%}%>
							<% if(request.getAttribute("questhemeEssayList") !=null && !"NULL".equals(request.getAttribute("questhemeEssayList"))){%>
							<%
							List questhemeEssayList = (List)request.getAttribute("questhemeEssayList");	
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
								  <% int i = 0;
			
								  QuesthemePO questheme = null;
							//                              ThemeOptionPO themeOption= null;
								  %>
								  <%for(int essay =0;essay<questhemeEssayList.size();essay++){%>
										<%
										questheme = (QuesthemePO) questhemeEssayList.get(essay);
										essayScore +=  questheme.getScore()!=null?Float.parseFloat(questheme.getScore().toString()):0;
							//                                        java.util.Set themeOptionSet = questheme.getThemeOption();
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
			
								  <table width="100%" border="0">
										<tr>
											<td width="100%"><textarea style="width:98%" rows="10" class="inputtextarea" disabled="true"></textarea></td>
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
		
						</table>
					</div>
				</td>
			</tr>
			<tr class="Table_nobttomline">  
	                    
                        <td nowrap>                        
                            <input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
                        </td>  
           </tr>  
      </table>
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
		changeContent();
	});
	
	function changeContent(){
		//var divs = $("div[class='newsletter']");
		$("div[class='docBoxNoPanel']").each(function () {              
			var str = $(this).text();
			str = str.replace(/<\/?.+?>/g,"");//去掉所有的html标记 
			if(str == "" || str == "&nbsp;"){
				$(this).style.display = "none";
			}
		});
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
	        $("#bigimg").attr("src", src);//设置#bigimg元素的src属性
	        $("#innerdiv").css({"top":h, "left":w});//设置#innerdiv的top和left属性
	    	$("#outerdiv").fadeIn("fast");//淡入显示#outerdiv及.pimg
	    });	
	    	
	    $("#outerdiv").click(function(){//再次点击淡出消失弹出层
	        $(this).fadeOut("fast");
	    });
	}
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
</script>
</html>