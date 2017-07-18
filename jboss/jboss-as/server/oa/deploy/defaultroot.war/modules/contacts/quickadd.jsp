<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<html lang="zh-cn" class="<%=whir_2016_skin_color%> size-big" >
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
	<link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.detail.min.css" />
    <%@ include file="/public/include/meta_desktop_base.jsp"%>
	

	<%@ include file="/public/include/meta_detail.jsp"%>
	
	
</head>
<body>
  
			  <!-- 快捷加入 -->
			  <div id="detail-quickadd" class="modal-quickadd-set layui-iframe-set">
				<textarea class="form-control " id="Add_phoneNum">
				  
				</textarea>
				<div class="quickadd-info">
				  <p>备注：连续输入电话号码，号码之间使用；（分号）分隔且不能换 行，电话号码之前要加区号，请使用半角输入字符。</p>
				  <P>样例：010-65439823;18609658122;010-65439823-237</P>
				</div>
				
				<div class="detail-btn">
				  <a class="btn btn-wh-line" href="#" role="button" onclick="okAdd()">确&nbsp;&nbsp;&nbsp;定</a>
				  <a class="btn btn-wh-line" role="button" onClick="resetAdd_phoneNum(this);">重&nbsp;&nbsp;&nbsp;置</a>
				  <a class="btn btn-wh-line"  role="button" onClick="closeLayer();" >取&nbsp;&nbsp;&nbsp;消</a>
				</div>

			  </div> 
 <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/static/template.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/static/template.extend.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/static/template.custom.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/zTree_v3/jquery.ztree.core-3.5.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/pagejs/view-frame.js?v=20160307"></script>
 

</body>
  
<script>
function openDesktopNew(){};
$(document).ready(function(){
	var Add_phoneNum = $("#Add_phoneNum").val("");
})
function okAdd(){
	var par = window.parent;
	var docu = par.document;
	var Add_phoneNum = $("#Add_phoneNum").val();
	var waitAdd = docu.getElementById("waitAdd");
	var phoneNum = Add_phoneNum.split(";");
	//发送短信页面
	var receiveCode = docu.getElementById("receiveCode");

	var outmobile = "";
	var regBox = {
			regEmail : /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/,//邮箱
			regName : /^[a-z0-9_-]{3,16}$/,//用户名
			regMobile : /^0?1[3|4|5|8][0-9]\d{8}$/,//手机
			regTel : /^0[\d]{2,3}-[\d]{7,8}[-]{0,1}[\d]{0,8}$///电话
		}
	for(var i=0;i<phoneNum.length;i++){
		if(phoneNum[i]!=null&&phoneNum[i]!=""){
			//waitAdd.add(new Option(phoneNum[i],""));
		}else{
			layer.msg('输入有误，请重新输入！');
			$("#Add_phoneNum").focus();
			return;
		}
		var mflag = regBox.regMobile.test(phoneNum[i]);
		var tflag = regBox.regTel.test(phoneNum[i]);
		
		if((mflag||tflag)&&phoneNum[i].lastIndexOf('-')!=phoneNum[i].length-1){
		}else{
			layer.msg('号码格式有误，请重新输入！');
			return false;
		}
	}
        var str1 = Add_phoneNum.replace(new RegExp(';', 'g'), ',');
        //docu.getElementById("msgto").value= docu.getElementById("msgto").value+str1+",";
		//docu.getElementById("msgtophone").value=docu.getElementById("msgtophone").value+str1+",";
		docu.getElementById("quickaddName").value= docu.getElementById("quickaddName").value+str1+",";
		docu.getElementById("quickaddPhone").value=docu.getElementById("quickaddPhone").value+str1+",";

	for(var i=0;i<phoneNum.length;i++){
        /*
		var option = new Option(phoneNum[i],phoneNum[i]);
		var empName = "";
		option.setAttribute("data-name",empName);
		option.setAttribute("ondblclick","toEnjoinPeople(this);");
		waitAdd.add(option);
		outmobile =outmobile+phoneNum[i]+",";
		*/
     
	}
	
	if(receiveCode!=null&&receiveCode!="undefind"){
		if(receiveCode.value!=null&&receiveCode.value!=""){
			outmobile = outmobile+receiveCode.value
			
		}else{
			outmobile = outmobile.substring(0,outmobile.length-1);
		}
		
		receiveCode.value=outmobile;
	}

     var par = window.parent;
	par.reloadwaitAdd();	

	var df = DistinctSelectOption();
	if(df==1){
		layer.msg('已自动过滤重复号码!', function(){
				closeLayer();
			});
	}else{
		closeLayer();
	}
   
	
	

}
function resetAdd_phoneNum(){
	var Add_phoneNum = $("#Add_phoneNum").val("");
}	
function closeLayer(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
     parent.layer.close(index);//关闭
}

/*删除重复项*/ 
function DistinctSelectOption(){ 
var df=0;

  $("#waitAdd option",parent.document).each(function() {
            var val = $(this).val();
            if ( $("#waitAdd option[value='" + val + "']",parent.document).length > 1 ){
			//alert($("#waitAdd option[value='" + val + "']",parent.document).length);
                $("#waitAdd option[value='" + val + "']:gt(0)",parent.document).remove();
				//layer.msg(val+"号码重复，并去重！");
				//df="号码重复，并去重，";
				df=1;
				}
        });
return df;
} 

  </script>
</html>
