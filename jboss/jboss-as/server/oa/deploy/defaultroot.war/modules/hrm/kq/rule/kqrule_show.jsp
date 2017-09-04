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
    <title>查看考勤策略</title>
    <%@ include file="/public/include/meta_base_2016.jsp"%>
	 <script src="<%=rootPath%>/scripts/main/whir.application_new.js" type="text/javascript"></script>
	  <style>
	   .details-container-e .col-wh-2{width:12.5%;}
		 .type-tab-contact .tab.ibeacon .form-control{width: 74%!important;}
		 </style>
</head>
<body>
   <div class="wh-wrapper">
    <div class="wh-view wh-detail wh-d-contact">
      <!--单位联系人明细-->
      <div class="container">
  
        <div class="details-container details-container-e">
              <div class="row">
				 <input name="kqrule.ruleId" value="${ruleId}" type="hidden" id="ruleId" />
                  <div class="form-group col-wh-12" style="margin-top:20px;">
                    <label class="col-wh-2 control-label" for=" ">策略名称：</label>
                    <div class="form-group col-wh-10">
                       <input type="text" class="form-control" name="kqrule.ruleName" id="ruleName" maxlength="20" value="${kqrule.ruleName}" readonly="readonly" style="background-color:white;">
                    </div>
                  </div>
                  <div class="form-group col-wh-12">
                    <label  class="col-wh-2 control-label" for=" ">考勤类别：</label>
                    <div class="form-group col-wh-10 type-tab-title">
					 <c:choose>
						<c:when test="${kqrule.ruleType == '1'}">
						  <label class="radio-inline">
							 <input type="radio" name="kqrule.ruleType" value="1" checked disabled > 地理位置
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleType" value="2" disabled > WIFI范围
						  </label>
						  <!--<label class="radio-inline">
							<input type="radio" name="kqrule.ruleType" value="3" disabled> 蓝牙范围（ibeacon）
						  </label>-->
					   </c:when>
					   <c:when test="${kqrule.ruleType == '2'}">
					      <label class="radio-inline">
							 <input type="radio" name="kqrule.ruleType" value="1"  disabled > 地理位置
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleType" value="2" checked disabled > WIFI范围
						  </label>
						  <!--<label class="radio-inline">
							<input type="radio" name="kqrule.ruleType" value="3" disabled > 蓝牙范围（ibeacon）
						  </label>-->
					   </c:when>
					   <c:when test="${kqrule.ruleType == '3'}">
					      <label class="radio-inline">
							 <input type="radio" name="kqrule.ruleType" value="1" disabled > 地理位置
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleType" value="2" disabled  > WIFI范围
						  </label>
						  <!--<label class="radio-inline">
							<input type="radio" name="kqrule.ruleType" value="3" checked disabled > 蓝牙范围（ibeacon）
						  </label>-->
					   </c:when>
				    </c:choose>		
                          
                      
                    </div>
                  </div>
                  
                 


                   <div class="form-group col-wh-12">
                    <label class="control-label col-wh-2" for=" ">允许例外：</label>
                    <div class="form-group col-wh-10">
					 <c:choose>
						<c:when test="${kqrule.ruleException == '1'}">
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleException" value="1" checked disabled >允许
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleException" value="2" disabled> 不允许
						  </label>
					   </c:when>
					   <c:when test="${kqrule.ruleException == '2'}">
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleException" value="1" disabled >允许
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleException" value="2" checked disabled > 不允许
						  </label>
					   </c:when>
					   </c:choose>
                     
                    </div>
                  </div>
                  <div class="form-group col-wh-12">
                    <label class="control-label col-wh-2" for=" ">提醒打卡：</label>
                    <div class="form-group col-wh-10">
					<c:choose>
					<c:when test="${kqrule.ruleAlert == '1'}">
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleAlert" value="1" onclick="show();" checked disabled >是
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleAlert" value="2"  onclick="hide();" disabled > 否
						  </label>
					   </c:when>
					   <c:when test="${kqrule.ruleAlert == '2'}">
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleAlert" value="1" onclick="show();"  disabled >是
						  </label>
						  <label class="radio-inline">
							<input type="radio" name="kqrule.ruleAlert" value="2" checked onclick="hide();" disabled > 否
						  </label>
					   </c:when>
					   </c:choose>
                     
                      <span id = "isShow">
                      <label class="radio-inline control-label-a" >提前  <input type="text" class="form-control" id="ruleAlertTime" name="kqrule.ruleAlertTime" value="${kqrule.ruleAlertTime}" readonly="readonly" style="background-color:white;">分钟提醒</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <%
						String rulealerttype  = 
								   (null == request.getAttribute("ruleAlertType")?"":request.getAttribute("ruleAlertType").toString());
						%>
					  <%if(rulealerttype.indexOf("1")>-1 && rulealerttype.indexOf("2")>-1 && rulealerttype.indexOf("3")>-1){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" checked>即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="2" checked>短信
					  </label>
					  <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" checked>移动端提醒 </label>
					  <%}%>
					  <%if(rulealerttype.indexOf("1")>-1 &&rulealerttype.indexOf("2") <= -1 && rulealerttype.indexOf("3") <= -1 ){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" checked>即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="2">短信
					  </label>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" >移动端提醒 </label>
					  <%}%>
					   <%if(rulealerttype.indexOf("1")<=-1 &&rulealerttype.indexOf("2")> -1 &&rulealerttype.indexOf("3")<= -1 ){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" >即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" checked value="2">短信
					  </label>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" >移动端提醒 </label>
					  <%}%>
					   <%if(rulealerttype.indexOf("1")<=-1 &&rulealerttype.indexOf("2")<= -1 &&rulealerttype.indexOf("3")>-1 ){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" >即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType"  value="2">短信
					  </label>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" checked>移动端提醒 </label>
					  <%}%>
					<%if(rulealerttype.indexOf("1")>-1 &&rulealerttype.indexOf("2")> -1 &&rulealerttype.indexOf("3")<= -1 ){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" checked>即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" checked value="2">短信
					  </label>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" >移动端提醒 </label>
					  <%}%>
					  <%if(rulealerttype.indexOf("1")>-1 &&rulealerttype.indexOf("2")<= -1 &&rulealerttype.indexOf("3")> -1 ){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" checked>即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType"  value="2">短信
					  </label>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" checked>移动端提醒 </label>
					  <%}%>
					   <%if(rulealerttype.indexOf("1")<=-1 &&rulealerttype.indexOf("2")> -1 &&rulealerttype.indexOf("3")> -1 ){%>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" >即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" checked value="2">短信
					  </label>
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" checked>移动端提醒 </label>
					  <%}%>
					  </span>
                    </div>
                  </div>         
                   <div class="form-group col-wh-12 syfw">
                   <label class="control-label col-wh-2" for=" ">适用范围：</label>
                    <div class="input-group form-group col-wh-10" style="padding-left:15px;">
					<input type="hidden" class="form-control form-control-wh-line" name = "kqrule.ruleRangeIds" id="ruleRangeIds" value="${kqrule.ruleRangeIds}">
                       <input type="text" class="form-control form-control-wh-line" name = "kqrule.ruleRange" id="ruleRange" value="${kqrule.ruleRange}" readonly="readonly" style="background-color:white;">
                       <div class="input-group-btn"><a href="javascript:void(0)" class="btn btn-wh-line" ><i>...</i></a></div>
                    </div>
                    </div>
                  </div>
                   <div class="type-tab-contact">
                      <div class="tab dlwz" style="display:block">
                         <div class="tab-ser">
                              <lable>搜索地址：</lable>
                              <input type="text" class="form-control" name="kqrule.ruleAddress" id="ruleAddress" value="${kqrule.ruleAddress}" readonly="readonly" style="background-color:white;">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <lable>范围：</lable>
                              <input type="text" class="form-control" name="kqrule.ruleScope" id="ruleScope" value="${kqrule.ruleScope}" readonly="readonly" style="background-color:white;">
							   <label style="font-weight:400;">&nbsp;米内有效</label>
                         </div>
                         <p class="tip0">注意：基于GSP定位，只有进入打卡点指定距离范围内才可进行打卡</p>
                         <div class="tab-map" id="allMap">
                             地图
                         </div>
                         <div class="tab-ser">
                              <lable>经度：</lable>
                              <input type="text" class="form-control" name="kqrule.ruleLongitude" id="ruleLongitude" value="${kqrule.ruleLongitude}" readonly="readonly" style="background-color:white;">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <lable>维度：</lable>
                              <input type="text" class="form-control" name="kqrule.ruleLatitude" id="ruleLatitude" value="${kqrule.ruleLatitude}" readonly="readonly" style="background-color:white;">
                         </div>
                      </div>
                      <div class="tab wifi">
                         <div class="tab-ser">
                              <lable>WIFI网段IP：</lable>
                              <input type="text" class="form-control" name="kqrule.ruleWifiIpStr" id="ruleWifiIpStr"  value="${kqrule.ruleWifiIpStr}" readonly="readonly" style="background-color:white;">
                         </div>
                         <p class="tip1">多个IP用英文逗号(,)分割</p>
                         <p class="tip2">注意：要求公司网络必须具有固定网络IP,只有连上公司wifi才能打卡。</p>
                      </div>
                       <div class="tab ibeacon">
                          <div class="tab-ser clearfix">
                            <div class="form-group col-wh-12">
                              <lable class="control-label">UUID（通用唯一识别码）：</lable>
                              <input type="text" class="form-control" name="kqrule.ruleUuid" id="ruleUuid"  value="${kqrule.ruleUuid}" readonly="readonly" style="background-color:white;">
                            </div>
                             <div class="form-group col-wh-12">
                                 <lable class="control-label">Major（主值）：</lable>
                                <input type="text" class="form-control" name="kqrule.ruleMajor" id="ruleMajor" value="${kqrule.ruleMajor}" readonly="readonly" style="background-color:white;">
                              </div>
                               <div class="form-group col-wh-12">
                                 <lable class="control-label">Minor（主值）：</lable>
                                 <input type="text" class="form-control" name="kqrule.ruleMinor" id="ruleMinor" value="${kqrule.ruleMinor}"  readonly="readonly" style="background-color:white;">
                               </div>
                                <div class="form-group col-wh-12">
                                    <lable class="control-label">识别距离：</lable>
                                    <input type="text" class="form-control" name="kqrule.ruleDistance" id="ruleDistance" value="${kqrule.ruleDistance}" readonly="readonly" style="background-color:white;">
                                  </div>
                         </div>
                      </div>
                  </div>
                <div class="detail-btn clearfix">
                    <a class="btn btn-wh-line" href="javascript:void(0);" role="button" onclick="closeTaskWindow();">退&nbsp;&nbsp;&nbsp;出</a>
                   
                </div>

              </div>
            </div>
          </div>
        </div>
        

      </div>
    </div>
  </div>
</body>
 <script type="text/javascript">
 var weidu = "${kqrule.ruleLatitude}";
 var jingdu = "${kqrule.ruleLongitude}";
//百度地图API功能
	function loadJScript() {
		var script = document.createElement("script");
		script.type = "text/javascript";
		script.src = "http://api.map.baidu.com/api?v=2.0&ak=yoZdpnAKiODFzBZ2DzGS5NsqolXfZxT4&callback=init";
		document.body.appendChild(script);
	}
	function init() {       	
		 var map = new BMap.Map("allMap",{enableMapClick:false}); 
        
		 // 初始化地图,设置中心点坐标和地图级别 
		 map.centerAndZoom(new BMap.Point(jingdu,weidu), 12); 
		 //添加地图类型控件
	     map.addControl(new BMap.MapTypeControl());
		//开启鼠标滚轮缩放
		map.enableScrollWheelZoom(true); 		
        var marker = new BMap.Marker(new BMap.Point(jingdu,weidu));        // 创建标注     
	    map.addOverlay(marker);	
	}
	  window.onload = loadJScript;  //异步加载地图
	// 百度地图API功能
	
</script>
<script>
  $(function() {
		 <c:if test="${kqrule.ruleAlert == '2'}">   
				$("#isShow").hide();
		</c:if>
		    var index2 = "${kqrule.ruleType}";
		    $('.type-tab-contact .tab').eq(index2-1).show().siblings().hide();	
    })
	function closeTaskWindow(){
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.layer.close(index);//关闭	
    }
  </script>
</html>