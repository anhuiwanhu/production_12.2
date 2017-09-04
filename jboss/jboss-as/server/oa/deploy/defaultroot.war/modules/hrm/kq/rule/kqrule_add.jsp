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
    <title>新增考勤策略</title>
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
                <s:form class="form-horizontal clearfix" role="form" name="dataForm" id="dataForm"     action="kqrule!kqrule_save.action" method="post" theme="simple">
                  <div class="form-group col-wh-12" style="margin-top:20px;">
                    <label class="col-wh-2 control-label" for=" ">策略名称<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                    <div class="form-group col-wh-10">
                       <input type="text" class="form-control" name="kqrule.ruleName" id="ruleName" maxlength="20">
                    </div>
                  </div>
                  <div class="form-group col-wh-12">
                    <label  class="col-wh-2 control-label" for=" ">考勤类别：</label>
                    <div class="form-group col-wh-10 type-tab-title">
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleType" value="1" checked> 地理位置
                      </label>
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleType" value="2"> WIFI范围
                      </label>
                     <!--
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleType" value="3"> 蓝牙范围（ibeacon）
                      </label>-->
                    </div>
                  </div>
                   <div class="form-group col-wh-12">
                    <label class="control-label col-wh-2" for=" ">允许例外：</label>
                    <div class="form-group col-wh-10">
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleException" value="1">允许
                      </label>
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleException" value="2" checked> 不允许
                      </label>
                    </div>
                  </div>
                  <div class="form-group col-wh-12">
                    <label class="control-label col-wh-2" for=" ">提醒打卡：</label>
                    <div class="form-group col-wh-10">
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleAlert" value="1" onclick="show();">是
                      </label>
                      <label class="radio-inline">
                        <input type="radio" name="kqrule.ruleAlert" value="2" checked onclick="hide();"> 否
                      </label>
					  <span id = "isShow">
                      <label class="radio-inline control-label-a" >提前<em style="vertical-align: middle;padding-left: 8px;">*</em>  <input type="text" class="form-control" id="ruleAlertTime" value="${kqrule.ruleAlertTime}" name="kqrule.ruleAlertTime" onkeyup="value=this.value.replace(/\D/g,'')"  maxlength="5" >分钟提醒</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					   <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="1" checked>即时通讯 </label>
					    <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="2" checked>短信
					  </label>
					  <label class="checkbox-inline">
					  <input type="checkbox"   name="kqrule.ruleAlertType" value="3" checked>移动端提醒 </label>
					  </span>
                    </div>
                  </div>
                   <div class="form-group col-wh-12">
                   <label class="control-label col-wh-2" for=" ">适用范围<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                    <div class="input-group form-group col-wh-10" style="padding-left:15px;">
					<input type="hidden" class="form-control form-control-wh-line" name = "kqrule.ruleRangeIds" id="ruleRangeIds">
                       <!--<input type="text" class="form-control" name = "kqrule.ruleRange" id="ruleRange" readonly="readonly" style="background-color:white;">
                       <div class="input-group-btn"><a href="javascript:void(0)" class="btn btn-wh-line" onclick="openSelect_layer({allowId:'ruleRangeIds', allowName:'ruleRange', select:'orgusergroup', single:'no', show:'orgusergroup', range:'*0*'});"><i>...</i></a></div>-->
					   
					    <textarea name = "kqrule.ruleRange" id="ruleRange"   rows="3"  readonly="true"  class="form-control"  style="background-color:white;min-height:0;height:100px;" readonly="readonly"></textarea>
							<div class="input-group-btn db-icon02" style="margin-left:-25px;margin-top:72px;z-index:9999"><a href="javascript:void(0)" class="btn btn-wh-line" onclick="openSelect_layer({allowId:'ruleRangeIds', allowName:'ruleRange', select:'orgusergroup', single:'no', show:'orgusergroup', range:'*0*'});"><i>...</i></a></div>
                    </div>
                    </div>
                  </div>
                   <div class="type-tab-contact">
                      <div class="tab dlwz" style="display:block">
                         <div class="tab-ser">
						 <div class="form-group col-wh-12">
                              <label style="font-weight:400;">搜索地址：</label>
                              <input type="text" class="form-control" name="kqrule.ruleAddress" id="ruleAddress" maxlength="24">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <label style="font-weight:400;">范围<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                              <input type="text" class="form-control" name="kqrule.ruleScope" id="ruleScope" onkeyup="value=this.value.replace(/\D/g,'')"  maxlength="5" > <label style="font-weight:400;">&nbsp;米内有效</label>
                         </div>
						 <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
						 </div>
                         <p class="tip0">注意：基于GSP定位，只有进入打卡点指定距离范围内才可进行打卡</p>
                         <div class="tab-map" id="allMap">
                             地图
                         </div>
                         <div class="tab-ser">
						 <div class="form-group col-wh-12" >
                              <label style="font-weight:400;">经度<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                              <input type="text" class="form-control" name="kqrule.ruleLongitude" id="ruleLongitude"  onkeyup="value=value.replace(/[^\d.]/g,'')" maxlength="18">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <label style="font-weight:400;">维度<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                              <input type="text" class="form-control" name="kqrule.ruleLatitude" id="ruleLatitude" onkeyup="value=value.replace(/[^\d.]/g,'')" maxlength="18">
							  </div>
                         </div>
                      </div>
                      <div class="tab wifi">
                         <div class="tab-ser">
						 <div class="form-group col-wh-12">
                              <label style="font-weight:400;">WIFI网段IP<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                              <input type="text" class="form-control" name="kqrule.ruleWifiIpStr" id="ruleWifiIpStr" style="width:88%!important" maxlength="1000" onkeyup="value=value.replace(/[^\d.,]/g,'')">
							     </div>  
                         </div>
                         <p class="tip1" style="padding-left:25px;">多个IP用英文逗号(,)分割</p>
                         <p class="tip2">注意：要求公司网络必须具有固定网络IP,只有连上公司wifi才能打卡。</p>
                      </div>
                       <div class="tab ibeacon">
                          <div class="tab-ser clearfix">
                            <div class="form-group col-wh-12">
                              <label class="col-wh-3 control-label">UUID（通用唯一识别码）<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                              <input type="text" class="form-control" name="kqrule.ruleUuid" id="ruleUuid" maxlength="200">
                            </div>
                             <div class="form-group col-wh-12">
                                 <label class="col-wh-3 control-label">Major（主值）<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                                <input type="text" class="form-control" name="kqrule.ruleMajor" id="ruleMajor" maxlength="50">
                              </div>
                               <div class="form-group col-wh-12">
                                 <label class="col-wh-3 control-label">Minor（主值）<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                                 <input type="text" class="form-control" name="kqrule.Minor" id="ruleMinor" maxlength="50">
                               </div>
                                <div class="form-group col-wh-12">
                                    <label class="col-wh-3 control-label">识别距离（米）<em style="vertical-align: middle;padding-left: 8px;">*</em>：</label>
                                    <input type="text" class="form-control" name="kqrule.ruleDistance" id="ruleDistance" onkeyup="value=this.value.replace(/\D/g,'')" maxlength="5" >
                                  </div>
                         </div>
                      </div>
                  </div>
                </s:form>
                <div class="detail-btn clearfix">
                     <a class="btn btn-wh-line" href="javascript:void(0);" role="button" onclick="saveExit();">保存退出</a>
                    <a class="btn btn-wh-line"  href="javascript:void(0);" role="button" onclick="saveContinue();">保存继续</a>
                    
                    <a class="btn btn-wh-line" href="javascript:void(0);" role="button" onclick="resetForm();">重&nbsp;&nbsp;&nbsp;置</a>
                    <a class="btn btn-wh-line" href="javascript:void(0);" role="button" onclick="closeTaskWindow();">退&nbsp;&nbsp;&nbsp;出</a>
                   
                </div>

              </div>
            </div>
          </div>
        </div>
        
</body>
 <script type="text/javascript">
//百度地图API功能
	function loadJScript() {
		var script = document.createElement("script");
		script.type = "text/javascript";
		script.src = "http://api.map.baidu.com/api?v=2.0&ak=yoZdpnAKiODFzBZ2DzGS5NsqolXfZxT4&callback=init";
		document.body.appendChild(script);
	}
	function init() {
         var myCity = new BMap.LocalCity();		
		 var map = new BMap.Map("allMap",{enableMapClick:false}); 
         myCity.get( function(result){
		    // 初始化地图,设置中心点坐标和地图级别 
		    map.centerAndZoom(new BMap.Point(result.center.lng, result.center.lat), result.level); 
		    //添加地图类型控件
		    map.addControl(new BMap.MapTypeControl());
		    //开启鼠标滚轮缩放
		    map.enableScrollWheelZoom(true);
		}); 		 	
		map.addEventListener("click",function(e){
		    var ss = e.$a;
		    if(ss != null){
		    	document.getElementById("ruleLongitude").value=e.point.lng;
				document.getElementById("ruleLatitude").value=e.point.lat;
		    	var ss = document.getElementsByClassName("BMap_bubble_title")[0];
		    	ss= ss.getElementsByTagName("p")[0];
		    	document.getElementById("ruleAddress").value=ss.title;
			    }					
	     });
		var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "ruleAddress"
		,"location" : map
	    });
		
		ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
			var str = "";
				var _value = e.fromitem.value;
				var value = "";
				if (e.fromitem.index > -1) {
					value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
				}    
				str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
				
				value = "";
				if (e.toitem.index > -1) {
					_value = e.toitem.value;
					value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
				}    
				str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
				G("searchResultPanel").innerHTML = str;
			});

			var myValue;
			ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
			var _value = e.item.value;
				myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
				G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
				
				setPlace(map,myValue);
			});
	}
	window.onload = loadJScript;  //异步加载地图
	// 百度地图API功能
	function G(id) {
		return document.getElementById(id);
	}
	function setPlace(map,myValue){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			document.getElementById("ruleLongitude").value=pp.lng;
		    document.getElementById("ruleLatitude").value=pp.lat;
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
			renderOptions:{map: map},
		    onSearchComplete: myFun
		});
		local.search(myValue);	
	}
</script>
<script>
  $(function() {
       var $tab_li = $('.type-tab-title label');

           $tab_li.click(function(){  
               var index = $tab_li.index(this);
			  
               $('.type-tab-contact .tab').eq(index).show().siblings().hide();
			   $('.type-tab-contact .tab').eq(index).siblings().find("input").val("");
           });
		   
		$("#isShow").hide();
    })
	
           
	function saveContinue(){
		var rulename = $("#ruleName").val();
		rulename = rulename.replace(new RegExp(" ","g"),"");
		
		
		if(rulename==''){
		   layer.alert("考勤策略名称不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleName").focus();
				 });
		   return false;
		}else{
		   var regx = /^([\u4e00-\u9fa5a-zA-Z0-9]+)$/;
		   if(!regx.test(rulename)){
		   layer.alert("考勤策略名称不得包含非法字符",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleName").val("");
					$("#ruleName").focus();
				 });
		     return false;
		   }else{//
		     
		       $.post('<%=rootPath%>/kqrule!isRepeat.action',{'ruleId':'','ruleName':rulename},function(data){
						  data=eval("("+data+")");
						  if(data.result=="1"){
						       layer.alert('考勤策略名称已经存在!',{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
								  layer.close(index);
								$("#ruleName").focus();
							 });
							 return false;  
						   }else{
						      jxyz();
						   }
						}
				   );
		   
		   
		   
		   
		   
		   }//
		
		}
		
    }
	
	function jxyz(){
	
	var ruleatype = $('input:radio[name="kqrule.ruleType"]:checked').val();
		
		var rulealert=$('input:radio[name="kqrule.ruleAlert"]:checked').val();
		if(rulealert=='1'){
		    var ruleAlertTime = $("#ruleAlertTime").val();
			if(ruleAlertTime ==''){
			 layer.alert("提前提醒时间不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleAlertTime").focus();
				 });
		     return false;
			}
		}
		var ruleRange = $("#ruleRange").val();
		
		if(ruleRange ==''){
			 layer.alert("适用范围不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleRange").focus();
				 });
		     return false;
			}
		if(ruleatype=='1'){
		    var rulescope = $("#ruleScope").val();
			if(rulescope == ''){
			   layer.alert("有效范围不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleScope").focus();
				 });
		     return false;
			}
		    var longitude = $("#ruleLongitude").val();
			if(longitude==''){
			   layer.alert("经度不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleLongitude").focus();
				 });
		     return false;
			}else{
			    var first = longitude.indexOf(".");//判断第一个小数点所在位置
                var temp_length = longitude.split(".").length - 1;//含有.的个数
				if(first=='0' ||temp_length>1){
				    layer.alert("经度格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
							layer.close(index);
							$("#ruleLongitude").focus();
						 });
					 return false;
				}
			
			}
			var ruleLatitude = $("#ruleLatitude").val();
			if(ruleLatitude==''){
			   layer.alert("纬度不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleLatitude").focus();
				 });
		     return false;
			}else{
			    var first = ruleLatitude.indexOf(".");//判断第一个小数点所在位置
                var temp_length = ruleLatitude.split(".").length - 1;//含有.的个数
				if(first=='0' ||temp_length>1){
				    layer.alert("纬度格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
							layer.close(index);
							$("#ruleLatitude").focus();
						 });
					 return false;
				}
			
			}
		}else if(ruleatype=='2'){
			
		   var match =/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
                   var ipstr = $("#ruleWifiIpStr").val();
			if(ipstr==''){
			 layer.alert("ip不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleWifiIpStr").focus();
				 });
		     return false;
			
			}else{
				var add = ipstr.split(",");
				var length = add.length-1;
				for(var i = 0;i<add.length;i++){
					 if(match.test(add[i])==false ){
					    if(i!=length){
						    layer.alert("ip格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
								layer.close(index);
								$("#ruleWifiIpStr").focus();
							 });
						 return false;
						}else{
						   if(add[i] != ''){
						       layer.alert("ip格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
									layer.close(index);
									$("#ruleWifiIpStr").focus();
								 });
						       return false;
						   }
						}
					   
					 }
				}
			}
		
		}else{
		     var uuid = $("#ruleUuid").val();
			if(uuid==''){
			   layer.alert("蓝牙uuid不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleUuid").focus();
				 });
		     return false;
			}
		    var major = $("#ruleMajor").val();
			if(major==''){
			   layer.alert("蓝牙Major不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleMajor").focus();
				 });
		     return false;
			}
			var minor = $("#ruleMinor").val();
			if(minor==''){
			   layer.alert("蓝牙Minor不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleMinor").focus();
				 });
		     return false;
			}
			var distance = $("#ruleDistance").val();
			if(distance==''){
			   layer.alert("识别距离不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleDistance").focus();
				 });
		     return false;
			}
	
		}
        var message="新增考勤策略成功!";
		var message2="新增考勤策略失败!";
    	ok_submitForm({formId:'dataForm',reset:'yes',tip:message,tip2:message2,queryForm:'queryForm',callbackfunction:hide});	
	
	
	
	}
	function saveExit(){
	var rulename = $("#ruleName").val();
		rulename = rulename.replace(new RegExp(" ","g"),"");
		
		if(rulename==''){
		   layer.alert("考勤策略名称不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleName").focus();
				 });
		   return false;
		}else{
		   var regx = /^([\u4e00-\u9fa5a-zA-Z0-9]+)$/;
		   if(!regx.test(rulename)){
		   layer.alert("考勤策略名称不得包含非法字符",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleName").val("");
					$("#ruleName").focus();
				 });
		   return false;
		   }else{//
		     
		       $.post('<%=rootPath%>/kqrule!isRepeat.action',{'ruleId':'','ruleName':rulename},function(data){
						  data=eval("("+data+")");
						  if(data.result=="1"){
						       layer.alert('考勤策略名称已经存在!',{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
								  layer.close(index);
								$("#ruleName").focus();
							 });
							 return false;  
						   }else{
						      jxyz2();
						   }
						}
				   );
		   
		   
		   
		   
		   
		   }//
		
		}
			
	}
	function  jxyz2(){
	    var ruleatype = $('input:radio[name="kqrule.ruleType"]:checked').val();
		
		var rulealert=$('input:radio[name="kqrule.ruleAlert"]:checked').val();
		if(rulealert=='1'){
		    var ruleAlertTime = $("#ruleAlertTime").val();
			if(ruleAlertTime ==''){
			 layer.alert("提前提醒时间不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleAlertTime").focus();
				 });
		     return false;
			}
		}
		var ruleRange = $("#ruleRange").val();
		
		if(ruleRange ==''){
			 layer.alert("适用范围不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleRange").focus();
				 });
		     return false;
			}
		if(ruleatype=='1'){
		    var rulescope = $("#ruleScope").val();
			if(rulescope == ''){
			   layer.alert("有效范围不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleScope").focus();
				 });
		     return false;
			}
		    var longitude = $("#ruleLongitude").val();
			if(longitude==''){
			   layer.alert("经度不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleLongitude").focus();
				 });
		     return false;
			}else{
			    var first = longitude.indexOf(".");//判断第一个小数点所在位置
                var temp_length = longitude.split(".").length - 1;//含有.的个数
				if(first=='0' ||temp_length>1){
				    layer.alert("经度格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
							layer.close(index);
							$("#ruleLongitude").focus();
						 });
					 return false;
				}
			
			}
			var ruleLatitude = $("#ruleLatitude").val();
			if(ruleLatitude==''){
			   layer.alert("纬度不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleLatitude").focus();
				 });
		     return false;
			}else{
			    var first = ruleLatitude.indexOf(".");//判断第一个小数点所在位置
                var temp_length = ruleLatitude.split(".").length - 1;//含有.的个数
				if(first=='0' ||temp_length>1){
				    layer.alert("纬度格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
							layer.close(index);
							$("#ruleLatitude").focus();
						 });
					 return false;
				}
			
			}
		}else if(ruleatype=='2'){
		
		var match =/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
		    var ipstr = $("#ruleWifiIpStr").val();
			if(ipstr==''){
			 layer.alert("ip不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleWifiIpStr").focus();
				 });
		     return false;
			
			}else{
				var add = ipstr.split(",");
				var length = add.length-1;
				for(var i = 0;i<add.length;i++){
					 if(match.test(add[i])==false ){
					    if(i!=length){
						    layer.alert("ip格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
								layer.close(index);
								$("#ruleWifiIpStr").focus();
							 });
						 return false;
						}else{
						   if(add[i] != ''){
						       layer.alert("ip格式不合法！",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
									layer.close(index);
									$("#ruleWifiIpStr").focus();
								 });
						       return false;
						   }
						}
					   
					 }
				}
			}
		
		}else{
		     var uuid = $("#ruleUuid").val();
			if(uuid==''){
			   layer.alert("蓝牙uuid不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleUuid").focus();
				 });
		     return false;
			}
		    var major = $("#ruleMajor").val();
			if(major==''){
			   layer.alert("蓝牙Major不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleMajor").focus();
				 });
		     return false;
			}
			var minor = $("#ruleMinor").val();
			if(minor==''){
			   layer.alert("蓝牙Minor不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleMinor").focus();
				 });
		     return false;
			}
			var distance = $("#ruleDistance").val();
			if(distance==''){
			   layer.alert("识别距离不得为空",{icon: 0,skin: 'layer-ext-moon',title:'警告'},function(index){
					layer.close(index);
					$("#ruleDistance").focus();
				 });
		     return false;
			}
	
		}
	        var message="新增考勤策略成功!";
		var message2="新增考勤策略失败!";
    	ok_submitForm({formId:'dataForm',reset:'no',tip:message,tip2:message2,queryForm:'queryForm'});
	
	
	
	
	
	
	}
	function show(){
	    $("#isShow").show();
	}
	
	function hide(){
	    $("#isShow").hide(); 
$('.type-tab-contact .tab').eq(0).show().siblings().hide();	
	}
	function resetForm(){
            document.getElementById('dataForm').reset();
            hide();
           $('.type-tab-contact .tab').eq(0).show().siblings().hide();	
           
        }
		
		
	function closeTaskWindow(){
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.layer.close(index);//关闭
    }


  </script>
</html>