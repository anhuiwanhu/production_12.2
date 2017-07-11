<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String localeCode=request.getParameter("localeCode")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("localeCode"));
if(localeCode!=null){
    com.whir.component.util.LocaleUtils.setLocale(localeCode, request);
}
%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.whir.org.basedata.bd.UnitSetBD" %>
<%@ page import="com.whir.org.basedata.po.UnitInfoPO" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.component.util.LocaleUtils" %>
<%@ page import="com.whir.component.util.CookieParser" %>
<%@ page import="com.whir.ezoffice.personalwork.setup.bd.MyInfoBD" %>
<%@ page import="com.whir.ezoffice.personalwork.setup.po.MyInfoPO" %>
<%@ page import="com.whir.org.basedata.bd.UnitSetBD" %>
<%@ page import="com.whir.org.basedata.po.UnitInfoPO" %>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.org.common.util.SysSetupReader" %>
<%@ page import="com.whir.ezoffice.logon.bd.ResetPasswordBD" %>
<%@ page import="java.security.SecureRandom" %>


<%


response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
session = request.getSession(true); 
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
//log图片默认不显示
//String logopicacc = rootPath+"/images/logo.png";
String logopicacc  = "";
String ewmpicacc = rootPath+"/images/ewm.jpg";
String logobroadpicacc = rootPath+"/images/bg1.jpg";
String userPhoto = rootPath+"/images/ver113/login/user.jpg";
String preview = request.getParameter("preview")!=null?com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("preview")):"";
String[] ewmArr = null;
String[] ewmNameArr = null;
String logobgSaveNameArr[] = new String[3];
String logobgpath = "";
String bqxx = "";
String qrcodeStatus = "0";//是否开启二维码，默认不开启
if(!preview.equals("") && preview.equals("true")){
    String logo = request.getParameter("logopicacc")!=null?com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("logopicacc")):"";
    if(!logo.equals("")){
	    logopicacc = fileServer+"/upload/loginpage/"+logo.substring(0,6)+"/"+logo;
    }
    String ewm = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("logoindexpicacc"));
    String ewmName = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("logoindexpicaccName"));
    ewmArr = !"".equals(ewm)?ewm.split("\\|"):null;
    ewmNameArr = !"".equals(ewmName)?ewmName.split("\\|"):null;
	String broad = request.getParameter("logobroadpicacc")!=null?com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("logobroadpicacc")):"";
    //logobgSaveNameArr = !broad.equals("")?broad.split("\\|"):null; 
    if(!broad.equals("")){
        logobroadpicacc = fileServer+"/upload/loginpage/"+broad.substring(0,6)+"/"+broad;
        logobgpath = fileServer+"/upload/loginpage/"+broad.substring(0,6)+"/";
        logobgSaveNameArr = broad.split("\\|");
    }else{
    	logobgpath = rootPath+"/images/";
    	logobgSaveNameArr[0] = "bg1.jpg";
    }
    qrcodeStatus = request.getParameter("isOpenewm")!= null ?com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("isOpenewm")):"0";
}else{
	com.whir.org.basedata.bd.LoginPageSetBD loginPageSetBD = new com.whir.org.basedata.bd.LoginPageSetBD();
	String[][] pageset = loginPageSetBD.getLoginPageSet((String)request.getAttribute("previewId"));
	if(pageset!=null && pageset.length>0){
		 if(pageset[0][0]!=null&&!"null".equals(pageset[0][0])&&!"".equals(pageset[0][0])){
			 //String saveName = pageset[0][0];
			 logobgSaveNameArr = !pageset[0][0].equals("")?pageset[0][0].split("\\|"):null; 
			logopicacc = fileServer+"/upload/loginpage/"+pageset[0][0].substring(0,6)+"/"+pageset[0][0];
			logobgpath = fileServer+"/upload/loginpage/"+pageset[0][0].substring(0,6)+"/";
		 }
		 if(pageset[0][2]!=null&&!"null".equals(pageset[0][2])&&!"".equals(pageset[0][2])){
			//ewmpicacc = fileServer+"/upload/loginpage/"+pageset[0][2].substring(0,6)+"/"+pageset[0][2];
            ewmArr = pageset[0][2].split("\\|");
            ewmNameArr = pageset[0][3].split("\\|");
		 }
		 if(pageset[0][4]!=null&&!"null".equals(pageset[0][4])&&!"".equals(pageset[0][4])){
			logobgSaveNameArr = !pageset[0][4].equals("")?pageset[0][4].split("\\|"):null; 
			logobroadpicacc = fileServer+"/upload/loginpage/"+pageset[0][4].substring(0,6)+"/"+pageset[0][4];
			logobgpath = fileServer+"/upload/loginpage/"+pageset[0][4].substring(0,6)+"/";
		 }
		 if(pageset[0][6]!=null&&!"null".equals(pageset[0][6])&&!"".equals(pageset[0][6])){
			 qrcodeStatus = pageset[0][6]; 
		 }
	}
}
//获取版权信息
    UnitSetBD unitSetBD = new UnitSetBD();
//域标识 默认 为0    
	UnitInfoPO unitInfoPO = unitSetBD.getUnitInfo("0");
	if(unitInfoPO != null){
		if(StringUtils.isNotBlank(unitInfoPO.getCopyRights())){
			bqxx = unitInfoPO.getCopyRights();
		}
	}
//输入错误次数,用于显示验证码（>=2）
int inputErrorNum = Integer.parseInt(session!=null&&session.getAttribute("inputErrorNum")!=null?session.getAttribute("inputErrorNum").toString():"0");
String isDiglossia = "1" ; //是否双语,0:非双语,1：双语
if(localeCode==null){
   localeCode="zh_CN";
}
//以下语句防止日文系统ja或者zh_CN
localeCode = LocaleUtils.getLocale(localeCode);
String validate=request.getParameter("validate")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("validate"));

//此处进行个人图片的验证
String userId = session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
MyInfoBD bd = new MyInfoBD();

if(StringUtils.isNotBlank(userId)){
	MyInfoPO  myInfo = bd.load(userId);
	
	if(myInfo != null&&myInfo.getEmpLivingPhoto()!=null){
		
		java.io.File file = new java.io.File(myInfo.getEmpLivingPhoto());
		if(file.exists()){userPhoto = myInfo.getEmpLivingPhoto();}
	}
}
if("no".equals(validate)){
	if(session.getAttribute("org.apache.struts.action.LOCALE")!=null && !"".equals(session.getAttribute("org.apache.struts.action.LOCALE"))){
        localeCode = session.getAttribute("org.apache.struts.action.LOCALE").toString();
  		//以下语句防止日文系统ja或者zh_CN
        localeCode = LocaleUtils.getLocale(localeCode);
	}
	//注销时，清除工作流当前用户的锁
	String userAccount = session.getAttribute("userAccount")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(session.getAttribute("userAccount").toString());
	if(!"".equals(userAccount)){
		com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD wfbd = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD();
		wfbd.logoutWFOnlineUser(userAccount);
	}
	
    session.invalidate();
    if("1".equals(isDiglossia)){
        response.sendRedirect("login.jsp?localeCode="+localeCode+"&ccstatus=0");
    }else{
        response.sendRedirect("login.jsp");
    }
}else{
    //以下语句防止日文系统ja或者zh_CN
    localeCode = LocaleUtils.getLocale(localeCode);
    LocaleUtils.setLocale(localeCode, request);
}
CookieParser cookieparser = new CookieParser();
cookieparser.addCookie(response, "LocLan", localeCode, 365*24*60*60, null, "/", false);
String domainAccount=com.whir.org.common.util.SysSetupReader.getInstance().isMultiDomain();
String logoFile = rootPath+"/images/"+localeCode+"/bg.jpg";
int inputPwdErrorNum = Integer.parseInt(request.getAttribute("inputPwdErrorNum")!=null?(String)request.getAttribute("inputPwdErrorNum"):"0");
int inputPwdErrorNumMax = Integer.parseInt(request.getAttribute("inputPwdErrorNumMax")!=null?(String)request.getAttribute("inputPwdErrorNumMax"):"6");
String useCaptcha = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("captcha", "0");
String userAccount = request.getAttribute("userAccount")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getAttribute("userAccount").toString());
String userPassword = request.getAttribute("userPassword")==null?"":request.getAttribute("userPassword").toString();

//获取找回密码配置----开始
 String domainId1 = request.getAttribute("domainId")==null?"0":request.getAttribute("domainId").toString();
 com.whir.ezoffice.logon.bd.ResetPasswordBD rpbd = new com.whir.ezoffice.logon.bd.ResetPasswordBD();
 String resetPassword = rpbd.getResetPassword(domainId1);

 //获取找回密码配置----结束
 
 //登陆设置预览
 String previewId = request.getAttribute("previewId")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getAttribute("previewId")+"");
 
SecureRandom random1=SecureRandom.getInstance("SHA1PRNG");
long seq=random1.nextLong();
String random=""+seq;
//session.setAttribute("random_session",random);

//判断是否是安全退出
 String ccstatus =null;
 ccstatus=request.getParameter("ccstatus");
 //获取配置文件的misid----开始
	com.whir.component.config.ConfigXMLReader reader = new com.whir.component.config.ConfigXMLReader();
    String cmisId   =reader.getAttribute("SSOCOCALL", "misId");
	
	
 //获取配置文件的misid----结束
 
String errorType=(String)request.getAttribute("errorType"); 
if(errorType==null || "".equals(errorType)){
		errorType =request.getParameter("errorType");
}
/**
if(!"".equals(userId)  && !"0".equals(ccstatus)){
	//重定向desktop.jsp
	 if(!"no".equals(validate)){
	    response.sendRedirect("desktop.jsp");
	 }	 
}
**/
String fromcc = request.getParameter("fromcc")==null?"0":"1";
if("1".equals(fromcc)){
	session.invalidate();
}
%>
<html>

<head>
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.reset.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_default/template.logins_12oa.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/template/css/template_system/template.fa.min.css" />
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>万户ezOFFICE协同管理平台</title>
    <!--<link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.login.css" />
    <!-- <link type="text/css" rel="stylesheet" href="<%=rootPath%>/themes/login/login.css" /> -->
    <%@ include file="/public/include/login_base.jsp"%>
    <script type="text/javascript" src="<%=rootPath%>/scripts/util/cookie.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/security/security.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/util/login.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/flexslide/jquery.flexslider.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/scripts/main/whir.application.js"></script>
	<!--<script type="text/javascript" src="http://pv.sohu.com/cityjson"></script>-->
</head>

<body>
  <div class="wh-lg-main">
    <div class="wh-lg-header">
      <h1><img id="loginPic" src="<%=logopicacc%>" data-pich="80"/></h1>
      
    </div>
    <div class="wh-lg-form">
     
    	<span class="mobile-tip mobile-tip1" id="mobile-tip" onclick="openOrCloseMobile()"></span>
      
      <!--   <span class="mobile-tip mobile-tip1" id="mobile-tip" onclick="openOrCloseMobile()"></span> -->
      <form id="LogonForm" name="LogonForm" action="Logon!logon.action" method="post">
	  <input type="hidden" name="random_form" value=<%=random%>></input>
	  <input type="hidden" id="isRemember" name="isRemember"  class="pass-check">
			<div <%if(domainAccount!=null){%>style="display:none"<%}%>>
				 <input type="text" id="domainAccount" name="domainAccount" <%if(domainAccount!=null){%>value="<%=domainAccount%>"<%}%> class="acc textOn" />
				 <div class="inputText"><%=Resource.getValue(localeCode,"common","comm.unitaccount")%></div>
	        </div>
        <div id="box1" class="lg-nomal-form" style="display: block;">
          <!-- <div class="lg-form-tip">
            <img src="" class="user" id ="empLivingPhoto" onclick ="submitByPhoto()" />
            <div>
              <p id ="weather"></p>
              <strong>Resource.getValue(localeCode,"common","comm.loginWelcome")%></strong>
            </div>
          </div>-->
          <div class="lg-form-con" id="box5">
          	<div class="check-tips formdiv-container">
          		<p><span><span id ="errorTypeRemind"></span><em class="tips-close"></em></span></p>
				
	            <div class="form-div">
	              <label></label>
	              <input type="text" class="username"  value="" id="userAccount" name="userAccount" placeholder="<%=Resource.getValue(localeCode,"common","comm.entryOAAccount")%>" />
	            </div>
            </div>
            <div class="formdiv-container formdiv-container2">
	            <div class="form-div">
	              <label ></label>
	              <input type="password" class="password" name="userPassword" value="" id="userPassword" autocomplete="off" placeholder="<%=Resource.getValue(localeCode,"common","comm.entryOAPassword")%>" />
				  <input type="hidden" id="userPasswordTemp" name="userPasswordTemp"/>
				  <input type="hidden" id="time" name="time"/>
	            </div>
          	</div> 
			 <%if("1".equals(useCaptcha)||(inputPwdErrorNum>=2 && "2".equals(useCaptcha))){
				 //if("1".equals(useCaptcha)|| inputPwdErrorNum>=2 ){
			 %>
				<div class="form-check-code clearfix">
				  <div class="form-div">
					<input type="text" name="captchaAnswer" id="captchaAnswer" class="image"  value="" placeholder="<%=Resource.getValue(localeCode,"common","comm.entryYZM")%>" />
				  </div>
				  <img id="yzm" src="<%=rootPath%>/captcha.png" onclick="document.getElementById('yzm').src='<%=rootPath%>/captcha.png?'+new Date().getTime();" />
				</div>
			<%}%>
            <div class="form-pass-div clearfix">
              <div class="rm-password" onclick="rember(this)" id="passswordcron"><em></em></div>
			  <!-- 
			  <input type="hidden" id="isRemember" name="isRemember"  class="pass-check">
              <input type="checkbox" name="isRemember" onclick="mychecked(this)" class="checkpass" id = "rememberCheckbox">
              -->
              <span><%=Resource.getValue(localeCode,"common","comm.RememberPassword")%></span>			  
              <a id="resetPasswordSPAN" style="display:none;" href="javascript:void(0)"  ><%=Resource.getValue(localeCode,"common","comm.getbackpassword")%></a>
            </div>
            <div class="denglu">
              <input type="button" id="mysubmit" value="<%=Resource.getValue(localeCode,"common","comm.logon")%>" class="lg-submit-btn" id="mysubmit" onClick="javascript:submitForm();" />
            </div>
			<input type = "hidden" id = "localeCode" name="localeCode" />
			<input type="hidden" id="uid" name="uid" />
			<input type="hidden" id="token" name="token" />
          </div>
          <div id="box4" class="lg-nomal-form" style="display: none;">
          <div class="lg-form-con">
            <div class="lg-form-tip">
              <img src="" class="user" id ="empLivingPhoto" onclick ="submitByPhoto()" />
              <p class="user-name" id="empName"></p>
            </div>
            <div class="form-pass-div form-pass-div2 clearfix">
              <div class="rm-password rm-password2" onclick="rember(this)"><em></em></div>
              <span><%=Resource.getValue(localeCode,"common","comm.RememberPassword")%></span>	
            </div>
            <div class="denglu">
               <input style="width:120px" type="button" id="mysubmit" value="<%=Resource.getValue(localeCode,"common","comm.logon")%>" class="lg-submit-btn" id="mysubmit" onClick="javascript:submitForm();" />
            
            </div>
          </div>
        </div>
        </div>
		</form>

		<!--找回密码页面----start---->
		<form id="sendMassageForm" name="sendMassageForm" action="/defaultroot/ResetPasswordAction!sendMessage.action" method="post">
		
        <div id="box2" class="lg-nomal-form" style="display: none;">
          <!--  <div class="lg-form-tip">
            <div>
              <p>如需要找回密码，则您在OA内需要正确填写手机号码，否则请联系管理员</p>
            </div>
          </div>-->
          <div class="lg-form-con">
            <div class="check-tips formdiv-container">
             	<p><span><span id ="errorTypeRemind2"></span><em class="tips-close"></em></span></p>
              <div class="form-div form-div2">
                <input type="text" class="username"  placeholder="请输入手机号码"  id="phoneNum" name="phoneNum" value="" maxlength="11"  
				 whir-options="vtype:['notempty',{'maxLength':11},'spechar3']"/>
                <a href="javascript:void(0)" id="resetPasswordButton" onclick="sendMessageAction()">发送</a>
			   
              </div>
            </div>
            <div class="formdiv-container">
              <div class="form-div">
                <input type="text" name="checkCode" id="checkCode"  value="" whir-options="vtype:['notempty',{'maxLength':6},'spechar3']" placeholder="请输入验证码"   style="width:260px"/>
              </div>
            </div>
           <div class="formqued clearfix">
              <a onclick="check();" href="javascript:void(0)" >确定</a>
            </div>
            <div class="denglu">
             
			  <input id="back-login1" type="" name="" value="返回登录页" class="lg-submit-btn" onclick="backToLogin();" />
            </div>
          </div>
        </div>
      </form>
	 
	 <form id="resetPasswordForm" name="resetPasswordForm" action="/defaultroot/ResetPasswordAction!resetPassword.action" method="post">
	 <input type = "hidden" id = "name" name="name" />
	 <input type = "hidden" id = "isPasswordRule" name="isPasswordRule" />
	 <input type = "hidden" id = "empId" name="empId" />
	 <input type = "hidden" id = "checkcodeTemp" name="checkcodeTemp" />
	 <input type = "hidden" id = "phoneTemp" name="phoneTemp" />
	
        <div id="box3" class="lg-nomal-form" style="display: none;">
		<script>
			var isPasswordRule = document.getElementById("isPasswordRule").value;
			var pass_role = ""
			if(isPasswordRule==1){
				pass_role = "密码规则：数字+字母+特殊字符（大于等于7位）7位），要求每三个月至少更新一次，且两年内不能和以前的密码重复。系统提前两周提醒。如果没有修改，则每次登录时都会提示剩余天数。如果到期仍不修改，则系统自动休眠此用户。";
			}else{
				pass_role = "密码长度不能少于6位";
			}
			$('#pass_role').val(pass_role);
		</script>
        
		  <div class="lg-form-tip" style="display: none;">
            <div>
              <p id = "pass_role"></p>
            </div>
          </div>
		
          <div class="lg-form-con">
            <div class="check-tips formdiv-container">
             	<p><span><span id ="errorTypeRemind3"></span><em class="tips-close"></em></span></p>
              <div class="form-div">
                <input  placeholder="新密码"  type="password" name="newpassword" id="newpassword"  value=""
				whir-options="vtype:['notempty','spechar3']"  style="width:260px" />
               
			   
              </div>
            </div>
            <div class="formdiv-container">
              <div class="form-div">
                <input type="password" name="confimpassword" id="confimpassword"  value="" whir-options="vtype:['notempty','spechar3']"  placeholder="密码确认" style="width:260px" />
              </div>
            </div>
			<div class="formqued clearfix" style="width: 290px;margin: 0 auto;">
              <a onclick="save();" href="javascript:void(0)" style="width: 120px;float: left;">保存</a>
			  <a onclick="cancle();" href="javascript:void(0)" style="width: 120px;float: left;margin-left:50px;" >清除</a>
            </div>
            <div class="denglu">
             
			  <input id="back-login2" type="" name="" value="返回登录页" class="lg-submit-btn" onclick="backToLogin();"/>
            </div>
          </div>
        </div>
      </form>
	   <!--找回密码页面----end ---->
	   
	   
      <div class="lg-mobile-slide" >
        <span class="left-line"></span>
        <div class="wh-lg-setting">
        <!-- <a href="<%=rootPath%>/help/help_set.html" target="help_window"   class="help"><i class="fa fa-cog2"></i><span title="<%=Resource.getValue(localeCode,"common","comm.setupHelp")%>"><%=Resource.getValue(localeCode,"common","comm.setupHelp")%></span></a> -->
        <a href="/defaultroot/public/edit/logindownload/Logindownload.jsp?fileName=activex.msi" class="widget"><i class="fa fa-plus-circle"></i><span title="<%=Resource.getValue(localeCode,"common","comm.Controlinstallation")%>"><%=Resource.getValue(localeCode,"common","comm.Controlinstallation")%></span></a>
		
        <div href="javascript:void(0)" class="wh-lg-select" >
         
			<%if("zh_CN".equals(localeCode)){%>
			 <span class="lg-select-span sl1 " id = "localeCode1" onClick="openOrCloselang()">
	             <span>简体中文</span>
            <%}else if("zh_TW".equals(localeCode)){%>
			 <span class="lg-select-span sl2 " id = "localeCode1" onClick="openOrCloselang()">
                 <span>繁體中文</span>
            <%}else if("en_US".equals(localeCode)){%>
			 <span class="lg-select-span sl3 " id = "localeCode1" onClick="openOrCloselang()">
                 <span>English</span>
            <%}else if("ko_KR".equals(localeCode)){%>
			 <span class="lg-select-span sl4 " id = "localeCode1" onClick="openOrCloselang()">
                 <span>한국의</span>	
            <%}else if("ja_JP".equals(localeCode)){%>
			 <span class="lg-select-span sl5 " id = "localeCode1" onClick="openOrCloselang()">
                 <span>日本語</span>
            <%}%>
		  </span>
		  
          <ul class="sele-list-lang clearfix"  id="sele-list-ul" >
            <li <%if("zh_CN".equals(localeCode)){%> class="current"<% }%> id = "jtzw"><span class="sl1"  value="zh_CN" onclick="selectLauguale(this)">简体中文</span><i class="fa fa-check-circle-o"></i></li>
            <li <%if("zh_TW".equals(localeCode)){%> class="current"<% }%> id = "ftzw"><span value="zh_TW" class="sl2" onclick="selectLauguale(this)">繁體中文</span><i class="fa fa-check-circle-o"></i></li>
            <li <%if("en_US".equals(localeCode)){%> class="current"<% }%> id = "yw"><span value="en_US" class="sl3" onclick="selectLauguale(this)">English</span><i class="fa fa-check-circle-o"></i></li>
            <li <%if("ko_KR".equals(localeCode)){%> class="current"<% }%> id = "hw"><span value="ko_KR" class="sl4" onclick="selectLauguale(this)">한국의</span><i class="fa fa-check-circle-o"></i></li>
            <li <%if("ja_JP".equals(localeCode)){%> class="current"<% }%> id = "rw"><span value="ja_JP" class="sl5" onclick="selectLauguale(this)">日本語</span><i class="fa fa-check-circle-o"></i></li>
          </ul>
        </div>
      </div>
        
        <div class="flexslider">
		  
          <ul class="slides" id="ewmStyle">
                 <!-- 遍历二维码 -->
                 <%
				    if(ewmArr!=null && ewmNameArr != null){
				       int ewmSize = ewmArr.length;
				        int ewmNameSize = ewmNameArr.length;
				        int picsize = 0;
				        if(ewmSize >= ewmNameSize){
				            picsize = ewmNameSize;
				        }else{
				             picsize = ewmSize;
				            }
				        for(int i=0;i< picsize ;i++){
						 %>
						  <li>
              <p><%=ewmNameArr[i] %></p>
              <img src="<%=fileServer+"/upload/loginpage/"+ewmArr[i].substring(0,6)+"/"+ewmArr[i]%>" />
							
						  </li>			                    
						  <% }
				     }else{
				   %>
	              <li>
	                <p></p>
	              </li>
				 <%}%>             	
            </ul>
        </div>
        <div class="wh-lg-logoIn-top-title"><span><%=Resource.getValue(localeCode,"common","comm.openQRcode")%></span></div>
       
      </div>
    </div>
  </div>
  <div class="wh-lg-footer">
    <p><%=bqxx %></p>
  </div>
  <div id="fullpage">
	<%                      boolean f=false;
			                if(logobgSaveNameArr!=null){
                               
			                    for(int i=0;i<logobgSaveNameArr.length;i++){
			                    	if(StringUtils.isNotBlank(logobgSaveNameArr[i])){
                                        f=true;
			                    	%> 		
					                   <div class="section " name="backgroudimage" style="background-image:url('<%=logobgpath+logobgSaveNameArr[i]%>'); background-size: cover;display:block"> </div>
					                <% 
			                    	}
					                }
                               }%>

                           <% if(!f){ %>
                                    <div class="section " name="backgroudimage" style="background-image:url('/defaultroot/images/ver113/login/bg_login_sd.jpg'); background-size: cover;"> </div>
                                <%}%>
    
  </div>
   <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/jquery/jquery.easing.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/fullpage/jquery.fullPage.min.js"></script>
 <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/flexslide/jquery.flexslider.js"></script>
 <!--  cocall的账号、uid、misid以及token、server -->

 </body>

</html> 
  <script type="text/javascript" >
  /*
   function loadWeather(){
        var elementScript1 =document.createElement("script");//创建一个script元素
		elementScript1.type="text/javascript";
		//添加src属性 引入跨域访问的url
		elementScript1.src="http://pv.sohu.com/cityjson";
        elementScript1.onload=elementScript1.onreadystatechange=function(){
        if(!this.readyState||this.readyState==="loaded"||this.readyState==="complete"){
            if(returnCitySN){
                //获取天气接口
                var ip =returnCitySN.cip;
                var elementScript =document.createElement("script");//创建一个script元素
                elementScript.type="text/javascript";
                //添加src属性 引入跨域访问的url
                elementScript.src="http://api.k780.com:88/?app=weather.future&weaid="+ip+"&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json&jsoncallback=getWeather";
                document.getElementsByTagName("HEAD")[0].appendChild(elementScript);//在页面中添加新创建的script元素
            } 
        }
      }
	document.getElementsByTagName("HEAD")[0].appendChild(elementScript1);//在页面中添加新创建的script元素	
   }
    */    
	window.onresize = function(){
    //改变div的高度
      $(".wh-lg-form").height($(window).height());
      $(".lg-mobile-slide").height($(window).height());
      $(".left-line").height($(window).height()*0.7);
 
}
 
  $(document).ready(function() { 
	// 自动滚动
     setInterval(function(){
        $.fn.fullpage.moveSectionDown();
    }, 3000);
	 
	    //改变div的高度
      $(".wh-lg-form").height($(window).height());
      $(".lg-mobile-slide").height($(window).height());
      $(".left-line").height($(window).height()*0.7);       
	 

		
    var userAccount = $('#userAccount');
	userAccount.focus();
	var html="<img class='ui_icon_bg' src='<%=rootPath%>/scripts/plugins/lhgdialog/skins/icons/alert.gif'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size:15px'>正在自动登陆中...</span>";
				//popup({content:html, width:'470px', height:'80px', lock:true, resize: false, min: false, max: false});
				//whir_alert("dddddddddd",null,null);
				//layer.msg('已自动过滤重复号码!');
	//cocall的整合
	var ccstatus='<%=ccstatus%>';
	var fromcc = '<%=fromcc%>';
	var token ="";
	if(0!=ccstatus&&fromcc==1){
			<%if(errorType==null||"".equals(errorType)){%>
				 var portArr=new Array();
                    portArr[0]="12700";
                    portArr[1]="12702";
                    portArr[2]="12704";
                    portArr[3]="12706";
                    portArr[4]="12708";
                    for(var i=0;i<portArr.length;i++){
                         var port1 = portArr[i];
                        btn_get_account_Click(port1);
                    }
				
			<%}%>
		
		}	
	
	
	//语言选择下拉
	
    $(".sele-list li").click(function(){
      $(this).addClass("open").siblings().removeClass("open");
      $(".lg-select-span").html($(this).text());
      $(".lg-select-span").removeClass("sl1 sl2 sl3 sl4 sl5");
      var index =  $(".sele-list li").index(this)+1;
      $(".lg-select-span").addClass("sl"+index);
    })

    
/*
    //form数据验证
    $(".username").blur(function(){
    	clearInterval(checktips);
		$(".check-tips").addClass("error"); 
		checktips = setInterval(function(){
			$(".check-tips").removeClass("error");
		},3000);
		});
		
		
		var checktips = setInterval(function(){
			$(".check-tips").removeClass("error");
		},3000);
*/
		$(".tips-close").click(function(){
			$(".check-tips").removeClass("error");
		})
      getdata();//加载日期 
		
  });
    function backToLogin(){
	  $("#box2").css("display","none");
	  $("#box3").css("display","none");
      $("#box1").css("display","block");
	  $('#phoneNum').val('');
	   $('#checkCode').val('');
	   $(".check-tips").removeClass("error");
	}
   
	$("#resetPasswordSPAN").click(function () {
      $("#box2").css("display","block");
      $("#box1").css("display","none");
	  $(".check-tips").removeClass("error");
    })
	//fullPage
   $('#fullpage').fullpage({
      loopBottom: true,
      navigation: true,
      navigationPosition: 'right'
    });
	
function showError(i){
		
			if(i==1){
				$(".check-tips").addClass("error"); 
				var timer1 =setInterval(function(){
					$(".check-tips").removeClass("error");
					
				},5000);
				//clearInterval(timer1);				
				//$(".check-tips").addClass("error"); 
			}else{
				$(".check-tips").removeClass("error");
			}
			
		}
		
//关闭div层
function closeIewarning(){
	$("#iewarning").hide();
}

/**
//获取图片高度，宽度
function getNatural (DOMelement) {
    var img = new Image();
    img.src = DOMelement.src;
    return {width: img.width, height: img.height};
  }
*/

function initLang(localeCode){
	var language = "zh-cn";
	if(localeCode == 'zh_TW'){
		language = "zh-tw";
	}else if(localeCode == 'en_US'){
		language = "en-us";
	}else if(localeCode == 'ko_KR'){
		language = "ko-kr";
	}else if(localeCode == 'ja_JP'){
		language = "ja-jp";
	}
	$("#loginHtml").attr("lang",language);
}
$(function(){
	 var ver=navigator.appVersion.substring(navigator.appVersion.indexOf("MSIE ")+5, navigator.appVersion.indexOf("MSIE ")+8);
	//对log图片赋值，暂时去掉
	 /**
	 var  loginPicheight = 0;
	 if(navigator.appVersion.indexOf("MSIE") >0 && ver < 9){
		var loginPic = getNatural(document.getElementById('loginPic'));
		loginPicheight = loginPic.height;
	}else{
	    loginPicheight = $('img#loginPic')[0].naturalHeight;
	}
	if(loginPicheight > 0){
		$("#loginPic").attr("data-pich",loginPicheight);
	}

	var picHeight = parseInt($("#loginPic").data('pich')+"px");
	var picMarginTop = "-"+parseInt($("#loginPic").data('pich'))/2+"px";
	$("#loginPic").height(picHeight);
	$("#loginPic").css({"height":picHeight, "margin-top":picMarginTop});
	*/
	//对语言赋值
	var localeCode = '<%=localeCode%>';
	initLang(localeCode);
	
	//不同浏览器时需要隐藏
	var srcName = '<%=logopicacc%>';
	if(srcName == "" || srcName == "undefined" || srcName == null){
		$("#loginPic").hide();
	}
	//通过二维码状态判断是否显示二维码
	var qrcodeStatus = '<%=qrcodeStatus%>';
	if(qrcodeStatus == "0" || qrcodeStatus == null || qrcodeStatus == ""){
		$("#submitTyle").addClass("wh-login-cons wh-lg-no-button");
		$("#ewmStyle").hide();
	}
    //动态赋高
    function scrh(obj){
        var scrHeight=document.body.scrollHeight;
        obj.css({'height':scrHeight});
    }
    $(function(){
   	    var scrH=$(".wh-pg-login,.wh-lg-slider");
          scrh(scrH);

          var resizeTimer;
          function resizeFunction() {
              scrh(scrH);
          };

          $(window).resize(function() {
              clearTimeout(resizeTimer);
              resizeTimer = setTimeout(resizeFunction, 300);
          });            
          resizeFunction();
           
        $(".flex-next").text('');
        $(".flex-prev").text('');
        //click language selection
        var sele_bd = $(".sele-list-div");
        var sele_list = $(".sele-list");
        var wh_llnav = $(".wh-lg-logoIn-nav li");
        var wh_lltop = $(".wh-lg-logoIn-top");

        $(".sele-show").click(function () {
            sele_bd.show();
            sele_list.show(200);
            return false;
        });

        sele_list.find("li").click(function(){
            sele_list.hide();
            sele_bd.hide();
            return false;
        });

        $("body").click(function () {
            sele_bd.hide();
            sele_list.hide();
           /* return false;*/
        });

        $(".info").focus(function(){
            $(this).parent().css("border-color","#0c89e1");
        });
        $(".info").blur(function(){
            $(this).parent().css("border-color","#666");
        });
        $(".info").hover(function(){
            $(this).parent().css("border-color","#0c89e1");
        },function(){
            $(this).parent().css("border-color","#666");
        });
        $(".image").hover(function(){
            $(this).css("border-color","#0c89e1");
        },function(){
            $(this).css("border-color","#666");
        });
       	 wh_llnav.on("click",function(){
                var $this = $(this);
                var index = $this.index();
                $this.addClass("current").siblings().removeClass("current");
                wh_lltop.hide().eq(index).show();
                if(index == 1){
                    $('.flexslider').flexslider({
                        animation: "slide",
                        directionNav: true,
                        controlNav: false,
                        slideshowSpeed: 700000
                    });
					
                }
            });
    });

   
	//判断找回密码功能
	 var resetPassword = '<%=resetPassword%>';
	 if(resetPassword==1){
	 	document.getElementById("resetPasswordSPAN").style.display="inline-block";
	 }
	 
});


function mychecked(obj){
	if(obj.checked){
		document.getElementById("isRemember").value= "1";
		//document.LogonForm.isRemember.value="1";
	}else{
		document.getElementById("isRemember").value= "0";
		//document.LogonForm.isRemember.value="0";
	}
}



function submitByPhoto(){
	var empLivingPhoto = document.getElementById("empLivingPhoto").src;
	
	if(empLivingPhoto != "" && empLivingPhoto !="/defaultroot/images/noliving.gif"){
	
		submitForm();
	}
}
//选择语言
function selectLauguale(obj){
	if(obj.innerText != ""){
	 var localcode  = obj.getAttribute('value');
	 $("#localeCode1").val(obj.innerText);
	 $("#jtzw").removeClass("current");
	
     location.href = "login.jsp?localeCode="+localcode;
	}
}

document.onkeydown=function(e){ 
	var theEvent = window.event || e; 
	var code = theEvent.keyCode || theEvent.which; 
	if (code == 13) { 
		submitForm();
	} 
} 

function load(){
	//去除原来下拉框的设置
	
    loadCookie();
	var isRemember=$("#isRemember").val();
	<% if(errorType==null || "".equals(errorType)){%>
	if(isRemember=='1'){
	   	<% if("0".equals(useCaptcha)){%>
	   $("#box5").css("display","none");
	   $("#box4").css("display","block");
	   <%}%>
	}
	<%}else{%>
			 $("#box5").css("display","block");
			 $("#box4").css("display","none");

			 document.getElementById("isRemember").value= "0";
	       //document.getElementById("rememberCheckbox").checked= "true";
		     $("#passswordcron").removeClass("rm-password2");
	<%}%>
	<%if("user".equals((String)request.getAttribute("errorType"))){%>
		document.LogonForm.userAccount.select();
	<%}else{%>
	//	document.LogonForm.userPassword.focus();
	<%}%>
}

function checkForm(){
	  //需要对隐藏域重新赋值
	  $("#localeCode").val("<%=localeCode%>");	
     if(document.LogonForm.userAccount.value==""||document.LogonForm.userAccount.value=="请输入账户"){
		/*	
        whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind4")%>", function(){
            document.LogonForm.userAccount.focus();
		
            return false;
        });*/
		//var errorTypeRemind = $('#errorTypeRemind');
		
		var remindText = '<%=Resource.getValue(localeCode,"common","comm.loginremind4")%>';
		errorTypeRemind.html(remindText);
		showError(1);	
        document.LogonForm.userAccount.focus();       
        return false;
    }else if( document.LogonForm.userPassword.value==""){
	/*
        whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind5")%>", function(){
            document.LogonForm.userPassword.focus();
            return false;
        });
		//var errorTypeRemind = $('#errorTypeRemind');
		*/
		
		
		var remindText = '<%=Resource.getValue(localeCode,"common","comm.loginremind5")%>';
		
		errorTypeRemind.html(remindText);
		showError(1);
        document.LogonForm.userPassword.focus();
        
        return false;
    }
     var captchaAnswer = $('#captchaAnswer').val();
	 if(captchaAnswer==""){
	 /*
		 whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>", function(){
            document.LogonForm.captchaAnswer.focus();
            return false;
        });*/
		//var errorTypeRemind = $('#errorTypeRemind');
		

		var remindText = '<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>';
		errorTypeRemind.html(remindText);
		showError(1);
		  document.LogonForm.captchaAnswer.focus();
            return false;
	 }
	
    return true;
}

function killerrors() { 
    return true; 
} 
window.onerror = killerrors; 

window.onload = function (e) {
    /*bodyclick = document.getElementsByTagName('body').item(0);
    rSelects();
    bodyclick.onclick = function () {
        for (i = 0; i < selects.length; i++) {
            _$('select_info_' + selects[i].name).className = 'tag_select';
            _$('options_' + selects[i].name).style.display = 'none';
        }
    }*/
    load();

    checkBrowser();
										
					
}
 function getdata(){
	var myDate = new Date();
	var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
	var mon = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
	var day = myDate.getDate();        //获取当前日(1-31)
	
	$("#weather").html("今天是"+year+"年"+mon+"月"+day+"日");
 }

 /*
  //获取天气
  function getWeather(data){
  
		var weather =data.result[0].weather;
		var temp =data.result[0].temperature;
		var days =data.result[0].days;
		var daysArr = days.split("-");
		var year =daysArr[0];
		var mon =daysArr[1];
		var day=daysArr[2];
		var city =data.result[0].citynm;
		$("#weather").html("今天是"+year+"年"+mon+"月"+day+"日,"+city+","+temp);
		
	}
	*/
var errorTypeRemind = $('#errorTypeRemind');	


<%
if("noDog".equals(errorType)){%>
	
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.noDog")%>",null);
	
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.noDog")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("active".equals(errorType)){%>
	
   // whir_alert("<%=Resource.getValue(localeCode,"common","comm.active")%>",null);
	
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.active")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("sleep".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.userIsSleep")%>",null);
	
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.userIsSleep")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("captchaWrong".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrong")%>",null);

	var remindText = '<%=Resource.getValue(localeCode,"common","comm.captchawrong")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("captchaWrongNull".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>",null);
	showError(1);
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>';
	errorTypeRemind.html(remindText);
<%}else if("resetpassword".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.resetpassword")%>",null);

	var remindText = '<%=Resource.getValue(localeCode,"common","comm.resetpassword")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("ip".equals(errorType)){
    String addr=request.getRemoteAddr();
    addr=addr==null?"":"("+addr+")";
%>
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind1")%>",null);
	
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.loginremind1")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("password".equals(errorType)){%>   
		
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.loginremind31")%><%=inputPwdErrorNumMax-inputPwdErrorNum%><%=Resource.getValue(localeCode,"common","comm.loginremind32")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("password".equals(errorType)&&("admin".equals(userAccount)||"security".equals(userAccount))){%>
   /* whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind3")%>",function(){
		document.LogonForm.userPassword.select();
        document.LogonForm.userPassword.value="";
		var userAccount =userAccount.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","")
		document.LogonForm.userAccount.value='<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(userAccount)%>';
    });*/	
	
	
	
	var remindText = '<%=Resource.getValue(localeCode,"common","comm.loginremind3")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("user".equals(errorType)){%>
  /*whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind2")%>",function(){
        document.LogonForm.userAccount.select();
        document.LogonForm.userAccount.value'<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(userAccount.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)",""))%>';
        document.LogonForm.userPassword.value="";
        
    });*/
	
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.loginremind2")%>';
	
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("online".equals(errorType)){%>
	showError(1);
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.online")%>';
	errorTypeRemind.html(remindText);
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.online")%>",null);
<%}else if("domainError".equals(errorType)){%>
	showError(1);
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.domainerror")%>';
	errorTypeRemind.html(remindText);
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainerror")%>",null);
<%}else if("userNumError".equals(errorType)){%>
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.usernumerror")%>",null);

	var remindText ='<%=Resource.getValue(localeCode,"common","comm.usernumerror")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("forbidUser".equals(errorType)){%>
	//whir_alert("<%=Resource.getValue(localeCode,"common","comm.active")%>",null);
	showError(1);
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.active")%>';
	errorTypeRemind.html(remindText);
<%}
errorType=request.getParameter("errorType")==null?"":com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(request.getParameter("errorType"));
if("overtime".equals(errorType)){%>
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.overtime")%>",null);
	
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.overtime")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("nokey".equals(errorType)){
	session.invalidate();
%>
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.nokey")%>",null);
	
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.nokey")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("keyErr".equals(errorType)){
	session.invalidate();
%>
    //whir_alert("<%=Resource.getValue(localeCode,"common","comm.keyerror")%>",null);
	
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.keyerror")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("domainError".equals(errorType)){%>
   // whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainiderror")%>",null);

	var remindText ='<%=Resource.getValue(localeCode,"common","comm.domainiderror")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("userNumError".equals(errorType)){%>
   
	var remindText ='<%=Resource.getValue(localeCode,"common","comm.domainerror")%>';
	errorTypeRemind.html(remindText);
	showError(1);
<%}else if("kickout".equals(errorType)){
   
%>
    //whir_alert("您的账号正在另一客户端登录！");
	
	var remindText ='您的账号正在另一客户端登录！';
	errorTypeRemind.html(remindText);	
	showError(1);
	
<%}%>

function openOrCloseMobile(){
	//移动版本  
   //$(".mobile-tip").click(function(){
	   var mobile_form = $(".wh-lg-form"); 
        $(".mobile-tip").addClass("mobile-tip1");
    	if(mobile_form.hasClass("move-left")){
     		mobile_form.removeClass("move-left");
        $(".lg-mobile-slide").removeClass("lg-mobile-slide1");
    	}
      else{ 
     		  $('.flexslider').flexslider({
		      animation: "slide",
		      directionNav: true,
		      controlNav: false,
		      slideshowSpeed: 3000
		    });
    		mobile_form.addClass("move-left");
        	$(".mobile-tip").removeClass("mobile-tip1");
          $(".lg-mobile-slide").addClass("lg-mobile-slide1");
    	}
    setTimeout(function(){
         $('.flex-prev').click();
      }, 200);
    //});
    
}

function openOrCloselang(){
       
	 var selectlist = $("#sele-list-ul");
      if (selectlist.hasClass("open")) {
        selectlist.removeClass("open");
      } else {

        selectlist.addClass("open");
      }
}

//--------------------------找回密码script----------------------------------start
  var errorTypeRemind2 = $('#errorTypeRemind2');
  var errorTypeRemind3 = $('#errorTypeRemind3'); 
    var sleep = 60, interval = null;
   // window.onload = function (){
   function sendMessageAction(){
        var btn = document.getElementById('resetPasswordButton');
		
        //btn.onclick = function (){	
		
	        //校验手机号码
	        var mobile = $('#phoneNum').val();
	        var re =  CheckMobile(mobile);
	       	if(re){
	       		
			 	var phoneNum = document.getElementById("phoneNum").value;
				
				//根据电话号码匹配用户 
				$.ajax({
					url: "/defaultroot/ResetPasswordAction!getEmployeeByPhone.action?phoneNum="+phoneNum,
					cache: false,
					async: true,
					success: function(dataForm) {
					
					var data = eval('('+dataForm+')');
					
						if(data.result=="false"){
							var res = data.data.res;
							 //whir_alert(res);
							
							var remindText =res;
							errorTypeRemind2.html(remindText);
							 showError(1);
							
						}
						if(data.result=="true"){
							// whir_alert("短信发送成功，请查看手机！");
							
							var remindText ='短信发送成功，请查看手机！';
							errorTypeRemind2.html(remindText);
							 showError(1);
							 if (!interval){
							 // var btn = document.getElementById ('resetPasswordButton');
				                //btn.style.backgroundColor = 'rgb(180,180,180)';
				                btn.disabled = "disabled";
								btn.removeAttribute ('onclick');
				                btn.style.cursor = "wait";
				                btn.innerText="(" + sleep-- + ")";
				                interval = setInterval (function ()
				                {
				                    if (sleep == 0)
				                    {
								
				                        if (!!interval)
				                        {
				                            clearInterval (interval);
				                            interval = null;
				                            sleep = 60;
											
				                            btn.style.cursor = "pointer";
				                            btn.removeAttribute ('disabled');
				                            btn.innerHTML = "发送";
											btn.setAttribute('onclick','sendMessageAction()');
				                           // btn.style.backgroundColor = '';
				                        }
				                        return false;
				                    }
				                    btn.innerText = "(" + sleep-- + ")";
				                }, 1000);
			            	}
						}
					}
				});
	       	}
        //}
    }
   
	function CheckMobile(mobile){
	
        var reg =/^0{0,1}(13[0-9]|15[0-9]|17[0-9]|18[0-9])[0-9]{8}$/; 
		
        if(!reg.test(mobile)) 
        { 
			
			var remindText ='您的手机号码不正确，请重新输入！';
			errorTypeRemind2.html(remindText);
			showError(1);
            //whir_alert("您的手机号码不正确，请重新输入！");
		
            document.sendMassageForm.phoneNum.focus();
			
            return false; 
        }else{
        	return true;
        } 
	}
  function check(){
  
	var phoneNum = $.trim(document.getElementById("phoneNum").value);
	var checkValue = $.trim(document.getElementById("checkCode").value);
	if(phoneNum==null||phoneNum==""){
		//whir_alert("手机号码不能为空！");
		
		var remindText ='手机号码不能为空！';
		errorTypeRemind2.html(remindText);
		showError(1);
	}
	if(checkValue==null||checkValue==""){
		//whir_alert("验证码不能为空！");
		
		var remindText ='验证码不能为空！';
		errorTypeRemind2.html(remindText);
		showError(1);
	}
	if(phoneNum!=null&&checkValue!=null&&phoneNum!=""&&checkValue!=""){
		$.ajax({
				url: "/defaultroot/ResetPasswordAction!getSMSCheckcodePOByPhone.action?phoneNum="+phoneNum+"&checkcode="+checkValue,
				cache: false,
				async: true,
				success: function(dataForm) {
					//alert(dataForm);
					var data = eval('('+dataForm+')');
					if(data.result=="true"){
						var str  = JSON.stringify(data.data);
						//whir_alert("验证码正确！");
					    //openWin({url:'/defaultroot/ResetPasswordAction!resetPassword.action?phoneNum='+phoneNum+"&checkcode="+checkValue,winName:'findPassword',height:280,width:600});
						ajaxgetAttribute(phoneNum,checkValue);
						openBox3();
			
					}else{
						//whir_alert("验证码错误！");
						
						var remindText ='验证码错误！';
						errorTypeRemind2.html(remindText);
						showError(1);
					}

				
				}
			});
	}
  }
  
  function  ajaxgetAttribute(phoneNum,checkValue){
	$.ajax({
				url: "/defaultroot/ResetPasswordAction!ajaxgetAttribute.action?phoneNum="+phoneNum+"&checkcode="+checkValue,
				cache: false,
				async: true,
				success: function(dataForm) {
					
					var data = eval('('+dataForm+')');
					if(data.result=="true"){
						
						var empId = data.data.empId;
						$('#empId').val(empId);
						var name = data.data.name;
						$('#name').val(name);
						var isPasswordRule = data.data.isPasswordRule;
						$('#isPasswordRule').val(isPasswordRule);
						var checkcode = data.data.checkcode;
						$('#checkcodeTemp').val(checkcode);
						var phone = data.data.phone;
						$('#phoneTemp').val(phone);
					
					}else{
						
					}

				
				}
			});
  }
  
  function openBox3(){
	
      $("#box2").hide();
      $("#box3").show();
	  $("#newpassword").val("");
	  $(".check-tips").removeClass("error");
  }
  
   function ConfimPassword(){
	 
	  var isPasswordRule = $('#isPasswordRule').val();
	   var re =false;
	   if(isPasswordRule=="0"){
		   var password = document.getElementById("newpassword").value;
			var confimpassword =  document.getElementById("confimpassword").value;
			if(password.length<6){
				//whir_alert("密码长度不能少于6位,请重新输入！");
				
				var remindText ='密码长度不能少于6位,请重新输入！';
				errorTypeRemind3.html(remindText);
				showError(1);
				return re;
			}else{
				if(password!=confimpassword){
					
					var remindText ='两次输入密码不一致,请重新输入！';
					errorTypeRemind3.html(remindText);
					 showError(1);
					//whir_alert("两次输入密码不一致,请重新输入！");
					document.getElementById("password").focus();
					document.getElementById("password").value="";
					return re;
				}
			}
			re=true;
			return re;
	   }else{
	   		var r = checkPasswordByRule();
	   		return r;
	   }
  }
   function save(){
	    var r = ConfimPassword();
	   
	    if(r){
	    	var password = document.getElementById("newpassword").value;
			var confimpassword =  document.getElementById("confimpassword").value;
			var checkcode=document.getElementById("checkcodeTemp").value;
			var phone=document.getElementById("phoneTemp").value;
			if(password!=confimpassword){
				//whir_alert("两次输入密码不一致,请重新输入！");
				 
				var remindText ='两次输入密码不一致,请重新输入！';
				errorTypeRemind3.html(remindText);
				showError(1);
				document.getElementById("password").focus();
				//document.getElementById("password").value="";
			}else{
				var datastr={"newpassword":password,"phoneNum":phone,"checkcode":checkcode};
				$.ajax({
						url: "/defaultroot/ResetPasswordAction!modifyPassword.action",
						cache: false,
						async: true,
						data:datastr,
						success: function(dataForm) {
						
							var data = eval('('+dataForm+')');
							if(data.result=="true"){
							 // whir_alert("密码修改成功 ！",function(){ window.close();});
							    
								var remindText ='密码修改成功 ！';
								errorTypeRemind3.html(remindText);
								showError(1);
								var t1 = setInterval(function(){
									backToLogin();
									clearInterval(t1);
								},3000);
								
							}else{
								//whir_alert("密码修改失败 ,请稍后再试 ！",function(){ window.close();});
								
								var remindText ='密码修改失败 ,请稍后再试 ！';
								errorTypeRemind3.html(remindText);
								showError(1);
								var t1 =  setInterval(function(){
									backToLogin();
									clearInterval(t1);
								},3000);
								
							}
		
						}
					});
			}
	    }
	   
   }
   function cancle(){
		document.getElementById("newpassword").value="";
		document.getElementById("confimpassword").value="";
   }
   //密码规则验证
   function checkPasswordByRule(){
   
    var vpassword = $('#newpassword').val();
    var reChars = /[a-zA-Z]+/i;
    var reNums = /[0-9]+/i;
    var reSpecialChars = /[\!\@\#\$\%|^\&\*\(\)\+\|\\|?\/\>\<\.\,]+/i;//验证是否包含了特殊字符
    if(vpassword.length<7){
        /*whir_alert("密码长度必须大于等于7位！", function(){
            $('#userPassword').focus();
            return false;
        });*/
       // whir_poshytip($('#password'), "密码长度必须大于等于7位！");
		
		var remindText ='密码长度必须大于等于7位！';
		errorTypeRemind3.html(remindText);
		showError(1);
        $('#newpassword').focus();
    	return false;
    }else if(!reChars.test(vpassword)){
        /*whir_alert("密码必须包含字母！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        //whir_poshytip($('#password'), "密码必须包含字母！");
		
		var remindText ='密码必须包含字母！';
		errorTypeRemind3.html(remindText);
		 showError(1);
        $('#newpassword').focus();
    	return false;
    }else if(!reNums.test(vpassword)){
        /*whir_alert("密码必须包含数字！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        //whir_poshytip($('#password'), "密码必须包含数字！");
		
		var remindText ='密码必须包含数字！';
		errorTypeRemind3.html(remindText);
		showError(1);
        $('#newpassword').focus();
    	return false;
    }else if(!reSpecialChars.test(vpassword)){
        /*whir_alert("密码必须包含特殊字符！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        //whir_poshytip($('#password'), "密码必须包含特殊字符！");
		
		var remindText ='密码必须包含特殊字符！';
		errorTypeRemind3.html(remindText);
		showError(1);
        $('#password').focus();
    	return false;
    }
    //判断是否在2年内的密码重复
        var vuserId = document.getElementById("empId").value;
        //var vpassword = userPassword;
        vpassword = vpassword.replace(/\&/g, '￥'); //由于&为参数地址连接符，用"￥"替换"&",然后在还原
        var returnValue = getPasswordIsRepeat(vuserId, vpassword).replace(/\n|\r/g, ""); //判断该用户密码在2年内是否重复，重复返回"1",不重复返回"0
       
        returnValue = eval("("+returnValue+")");
        if (returnValue.result == 1) { //密码在2年内重复
            //changePanel('base');

			var remindText ='密码在2年内不能重复！';
			errorTypeRemind3.html(remindText);
			showError(1);
			/*
            whir_alert("密码在2年内不能重复！", function(){
                $('#userPassword').focus();
                return false;
            });*/
            return false;
        }
    return true;
}

//根据用户id和密码，判断该密码是否在2年内重复
function getPasswordIsRepeat(vuserId, vpassword){
    return ajaxForSync(whirRootPath + '/ResetPasswordAction!checkPasswordIsRepeat.action', 'userId='+vuserId+'&password='+vpassword);
}
 //---------------------------找回密码script----------------------------------end
 
 //---------------------------cocall的整合方法----------------------------------start
 // 获取当前登录用户信息
		function btn_get_account_Click(port) {
            
            // 端口可以是12700/12702/12704...以此类推
            // 本机IP 127.0.0.1有可能以后会用某个域名来代替
            var getAccountURL = 'http://127.0.0.1:'+port+'/sso_get_account?callback=get_login_account';
            var el = document.createElement('script');
            el.async = false;
            el.src = getAccountURL;
            el.type = 'text/javascript';

            (document.getElementsByTagName('HEAD')[0] || document.body).appendChild(el);
        }
		// 获取当前登录用户的callback
        function get_login_account(accountList) {
           //var container = document.getElementById("login_account_list_container");
           var jid="";
           var cserver="";
		   var uid = "";
		   var username="";
            // 写入已登录用户的信息的表
           var misid="<%=cmisId%>";
           // for (var i = 0; i < accountList.length; i++) {
                    jid = accountList[0].jid;
					uid=jid.substring(0,jid.indexOf("@"));
                    cserver = accountList[0].server;		
					cusername=accountList[0].username;
					//隐藏域赋值
				
					$("#uid").val(uid);
					$("#userAccount").val(cusername);
					$("#userPassword").val("111111");
            //} 
		
			if(uid!=null && uid!="" && cserver!=null &&  cserver!="" && misid!=null &&  misid!=""){
				 var portArr2=new Array();
                    portArr2[0]="12700";
                    portArr2[1]="12702";
                    portArr2[2]="12704";
                    portArr2[3]="12706";
                    portArr2[4]="12708";
                    for(var i=0;i<portArr2.length;i++){
                         var port2 = portArr2[i];
                        btn_get_token_Click(uid,cserver,misid,port2);
                    }
				
			}
        
        }
		//获取token
		function btn_get_token_Click(uid,server,misid,port) {
           
            // http://127.0.0.1:12700/sso_get_token?userid=10018&server=172.16.11.126&misid=1234567899999999&callback=get_token
            var getTokenURL = "http://127.0.0.1:"+port+"/sso_get_token?userid="+uid+"&server="+server+"&misid="+misid+"&callback=get_login_token&random="+Math.random(new Date());
            var el = document.createElement('script');
            el.async = false;
            el.src = getTokenURL;
            el.type = 'text/javascript';
            (document.getElementsByTagName('HEAD')[0] || document.body).appendChild(el);
        }
		
		// 获取指定用户的token的callback
        function get_login_token(tokenObject) { 
			
             var token = tokenObject.token;			
            // 显示cocall客户端内置服务器返回的token						
            //token 隐藏域赋值  提交
		 	tokenflag=1;
			
			$("#token").val(token);
			if(token!=null && token!=""){
				var html="<img class='ui_icon_bg' src='<%=rootPath%>/scripts/plugins/lhgdialog/skins/icons/alert.gif'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size:15px'>正在自动登陆中...</span>";
				//popup({content:html, width:'470px', height:'80px', lock:true, resize: false, min: false, max: false});
				submitForm();
			}
			
        }
	 //---------------------------cocall的整合方法----------------------------------end
	 // 记住密码
        function rember(aaaa) {
	          if($(aaaa).hasClass("rm-password2")){
			  var isRemembertemp=$("#isRemember").val();
				if(isRemembertemp=='1'){
				<% if("0".equals(useCaptcha)){%>
				   $("#box5").css("display","block");
				   $("#box4").css("display","none"); 
				<%}%>
				   
				    $("#passswordcron").removeClass("rm-password2");
				}
	            $(aaaa).removeClass("rm-password2");
	            document.getElementById("isRemember").value= "0";
	          }
	          else{
	            $(aaaa).addClass("rm-password2");
	            document.getElementById("isRemember").value= "1";
	          }
        }
	

</script>

<%
//安全性，会话标识未更新
/*
if("".equals(previewId)){
    //System.out.println("++++++++++++++++++++++++++++session:"+session.getId());
	if(session!=null){
		session.invalidate();//清空session
	}
	Cookie[] cookies = request.getCookies();//获取cookie
	if(null != cookies && cookies.length> 0){
		for(Cookie cookie : cookies){
			//System.out.println("++++++++++++++++++++++++++++userAccount:"+cookie.getValue().toString());    //获取值 
			cookie.setMaxAge(0);//让cookie过期
		}
	}
	//Cookie cookie = request.getCookies()[0];//获取cookie
	//cookie.setMaxAge(0);//让cookie过期

}
*/

 %>
 


