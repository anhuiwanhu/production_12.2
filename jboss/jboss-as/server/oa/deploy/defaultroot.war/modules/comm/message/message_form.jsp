<s:set name="TITLE_WIDTH" value="'8%'"/>
<s:set name="CONTENT_WIDTH" value="'92%'"/>
<s:set name="saveTitle"><s:text name="message.savedraft"/></s:set>
<s:if test="%{#readType == 1}"> 
	<s:set name="saveTitle"><s:text name="message.savetobesent"/></s:set>
</s:if>
<s:hidden name="describeId" id="describeId" />
<s:hidden name="saveFlag" id="saveFlag" />
<s:hidden name="orgName" id="orgName" value="%{#session.orgName}"/>
<s:hidden name="userName" id="userName" value="%{#session.userName}"/>
<!--<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">-->
  <script type="text/javascript" src="scripts/static/template.js"></script>
  <script type="text/javascript" src="scripts/static/template.extend.js"></script>
  <script type="text/javascript" src="scripts/static/template.custom.js"></script>
  <script type="text/javascript" src="scripts/plugins/zTree_v3/jquery.ztree.core-3.5.js"></script>
  <script type="text/javascript" src="scripts/pagejs/view-frame.js?v=20160307"></script>
  
 
<table>
 	<tr style="display:none">  
      	<td for="" width="<s:property value="%{#TITLE_WIDTH}"/>" class="td_lefttitle" nowrap>  
          	&nbsp; 
      	</td>
        
      	<td  width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>
      		<div class="ui-widget">
				<input id="toId" name="toId" type="hidden">
			</div>
			<s:hidden name="snmsgto" id="snmsgto" />
				<s:hidden name="snmsgtoname" id="snmsgtoname" />
				<s:hidden name="snmsgtoid" id="snmsgtoid" />
				<s:hidden name="snmsgtophone" id="snmsgtophone" />
		</td>  
  	</tr>
 	<tr style="display:none">  
      	<td for="<s:text name="message.innercontact"/>" width="<s:property value="%{#TITLE_WIDTH}"/>" class="td_lefttitle" nowrap><s:text name="message.innercontact"/>：</td>  
      	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>
      		<s:textarea name="msgto" id="msgto" rows="3" cssClass="inputTextarea" whir-options="vtype:[{'maxLength':3500}]" cssStyle="width:94%;" readonly="true"/>  
			<s:textarea id="msgtoid" name="msgtoid"/>
			<s:textarea id="msgtophone" name="msgtophone"/>
			<a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectInternalUser({type:'userOrgGroup',allowId:'msgtoid',allowName:'msgto',allowPhone:'msgtophone'});">
				<img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/>
			</a>  
		</td>  
  	</tr>  
  	<tr style="display:none">  
      	<td for="<s:text name="message.owncontact"/>" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap>  
          	<s:text name="message.owncontact"/>：   
      	</td>  
      	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>  
       		<s:textarea name="msgtoprivate" id="msgtoprivate" rows="3" cssClass="inputTextarea" whir-options="vtype:[{'maxLength':3500}]" cssStyle="width:94%;" readonly="true"/> 
			<s:hidden id="msgtoidprivate" name="msgtoidprivate"/>
			<s:hidden id="msgprivatephone" name="msgprivatephone"/>
			<a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectExternalUser({type:'private',allowId:'msgtoidprivate',allowName:'msgtoprivate',allowPhone:'msgprivatephone'});">
				<img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/>
			</a>  
		</td>  
	</tr>
	<tr style="display:none">  
       	<td for="<s:text name="message.pubcontact"/>" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap>  
           	<s:text name="message.pubcontact"/>：   
       	</td>  
       	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>  
        	<s:textarea name="msgtopublic" id="msgtopublic" rows="3" cssClass="inputTextarea" whir-options="vtype:[{'maxLength':3500}]" cssStyle="width:94%;" readonly="true"/> 
			<s:hidden id="msgtoidpublic" name="msgtoidpublic"/>
			<s:hidden id="msgpublicphone" name="msgpublicphone"/>
			<a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectExternalUser({type:'public',allowId:'msgtoidpublic',allowName:'msgtopublic',allowPhone:'msgpublicphone'});">
				<img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/>
			</a>  
		</td>  
	</tr>
	<tr style="display:none">  
       	<td for="<s:text name="message.outmobile"/>" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap>  
           	<s:text name="message.outmobile"/>：   
       	</td>  
       	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>  
        	<s:textfield name="receiveCode" id="receiveCode" cssClass="inputText" whir-options="vtype:[{'maxLength':700}]" cssStyle="width:94%;"/> 
		</td>  
	</tr>
	<tr style="display:none">  
       	<td for="" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap>  
           	&nbsp; 
       	</td>  
       	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap><s:text name="message.sendremind"/>13866666666,13125252525</td>  
	</tr>
	<tr style="display:none">  
       	<td for="<s:text name="message.content"/>" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap><s:text name="message.content"/><span class="MustFillColor">*</span>：</td>  
       	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>  
        	<!--<s:textarea name="msContent" id="msContent" onkeyup="checkContent()"  onchange="checkContent()" rows="10" cssClass="inputTextarea" whir-options="vtype:['notempty',{'maxLength':300},'spechar3']" cssStyle="width:94%;"/> -->
		</td>  
	</tr>
	<tr style="display:none">  
       	<td for="" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap>  
           	&nbsp; 
       	</td>  
       	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>
       		<!--<s:text name="message.also"/><span id="cdtx" class="MustFillColor">300</span><s:text name="message.characterremind"/>-->
       	</td>  
	</tr>
	<tr style="display:none">  
       	<td for="" class="td_lefttitle" width="<s:property value="%{#TITLE_WIDTH}"/>" nowrap>&nbsp;</td>  
       	<td width="<s:property value="%{#CONTENT_WIDTH}"/>" nowrap>
       		<!--<s:checkbox name="hasOrgName" id="hasOrgName" fieldValue="1" onclick="checkAppend('org',this)"/><s:text name="message.unitname"/>
       		<s:checkbox name="hasUserName" id="hasUserName" fieldValue="1" onclick="checkAppend('user',this)"/><s:text name="message.name"/>-->
       	</td>  
	</tr>
	<tr class="Table_nobttomline" style="display:none">  
		<td class="td_lefttitle"></td> 
       	<td nowrap>  
           	<input type="button" class="btnButton4font" onClick="if(checkForm('send')) {if(checkSaveSendCount('<s:property value="#request.msgCount"/>','<s:property value="#request.sendSaveResult"/>')){ok(0,this);}}" value="<s:text name="message.sendquit"/>" />
           	<s:if test="%{#readType == 0 && #parameters.isForward == null}">
           		<input type="button" class="btnButton4font" onClick="if(checkForm('send')) {if(checkSaveSendCount('<s:property value="#request.msgCount"/>','<s:property value="#request.sendSaveResult"/>')){ok(1,this);}}" value="<s:text name="message.sendcontinue"/>" />
           	</s:if>
           	<input type="button" class="btnButton4font" onClick="if(checkForm('save')) {ok(0,this);}" value="<s:property value="#saveTitle"/>" />
           	<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />  
           	<input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />  
       	</td>  
   </tr>
   
   <div class="wh-wrapper">
    <div class="wh-view wh-detail wh-d-con-call"> 
      <div class="container" style="min-width:800px;width:700px;margin-top:30px; margin-left:101.5px;"> 
          <div class="details-container con-call-container clearfix">
            <strong>写短信</strong>
			  <div class="clearfix">
              <div class="form-group col-wh-6">
			  <div class="clearfix">
                <span style="display:block;float:left;">发送人(<em id="enjoinNUM">0</em>)</span>
				 <div class="detail-btn"  style="float:right;padding:0;padding-bottom:5px;">
					<a class="btn btn-wh-line" onclick="delOption()" role="button">删&nbsp;&nbsp;&nbsp;除</a>
					<a class="btn btn-wh-line"onclick="cleanwaitAdd()" role="button">清&nbsp;&nbsp;&nbsp;空</a>
				  </div>
				  <div class="clear"></div>
			 </div>
                <div class="pre-calllist">
				<%
				List nameList = (List) request.getAttribute("namelist");
				List phoneNumList = (List) request.getAttribute("phoneNumlist");
			
			%>
                  <select name="call"  multiple="multiple" id="waitAdd" size="6" style="height:185px;">
                  <%
					if(nameList!=null&&phoneNumList!=null){
						for(int i=0;i<nameList.size();i++){
							String name = (String)nameList.get(i);
							String phoneNum =(String) phoneNumList.get(i);
						
					%>	
				
                    <option value='<%=phoneNum%>' ondblclick="toEnjoinPeople(this);" data-name='<%=name%>' title='<%=name%><%=phoneNum%>'><span><%=name%>&nbsp;&nbsp;</span><span><%=phoneNum%></span></option>
                    
				<%
						}
					}
				  %>
					
                  </select> 
                </div>

                <div class="calllist-btn">
				
                  <a id="btn-InternalUser" class="btn btn-wh-line" href="javascript:void(0)" role="button">单位联系人</a>
                  <!--<a id="btn-mycontact" class="btn btn-wh-line"  role="button" onclick="selectInternalUser({type:'userOrgGroup',allowId:'msgtoid',allowName:'msgto',allowPhone:'msgtophone'})" >单位联系人</a>-->
				  
				
				<a id="btn-mycontact" class="btn btn-wh-line"  role="button"  >我的联系人</a>
                <a id="btn-selectGroup"  class="btn btn-wh-line" href="javascript:void(0)" role="button">群&nbsp;&nbsp;&nbsp;组</a>
                <a id="btn-quickadd" class="btn btn-wh-line" href="javascript:void(0)" role="button">快捷加人</a> 
				<s:hidden id="quickaddName" name="quickaddName"/>
				<s:hidden id="quickaddPhone" name="quickaddPhone"/>
				<s:hidden id="quickaddId" name="quickaddId"/>
                </div>
                 
              </div>

				<div class="mess-r form-group col-wh-6">
						<div class="mess-rtitle">
						  <label class="checkbox-inline">
								 <s:checkbox name="hasOrgName" id="hasOrgName" fieldValue="1" onclick="checkAppend('org',this)"/> 发送单位
								</label>
								<label class="checkbox-inline">
								 <s:checkbox  name="hasUserName" id="hasUserName" fieldValue="1" onclick="checkAppend('user',this)"/> 发送人
								</label> 
						</div>
						<div class="mess-con" style="margin-top: 13px;" for="<s:text name="message.content"/>" >
							<s:textarea style="min-height:13.2em;width:100%;" name="msContent" id="msContent" onkeyup="checkContent()"  onchange="checkContent()" cssClass="inputTextarea" whir-options="vtype:['notempty',{'maxLength':300},'spechar3'],tiptext:['内容']"
							/>	

							
							<span id="cdtx">0/300</span>
						</div>
						<p>提示：单个短信按70个字为一条计费</p>
				</div>
				</div>
			<div class="detail-btn">
				<a class="btn btn-wh-line"  role="button" onClick="if(checkForm('send')) {if(checkSaveSendCount('<s:property value="#request.msgCount"/>','<s:property value="#request.sendSaveResult"/>')){save_ok();}}" ><s:text name="message.sendquit"/></a>
				<s:if test="%{#readType == 0 && #parameters.isForward == null}">
				<a class="btn btn-wh-line"  role="button" onClick="if(checkForm('send')) {if(checkSaveSendCount('<s:property value="#request.msgCount"/>','<s:property value="#request.sendSaveResult"/>')){save_ok_continue();}}" ><s:text name="message.sendcontinue"/></a>
				</s:if>
				<a class="btn btn-wh-line" onClick="if(checkForm('save')) {save_ok();}"  role="button"><s:property value="#saveTitle"/></a>
				
				<a class="btn btn-wh-line" onClick="resetDataForm(this);"  role="button"><s:text name="comm.reset"/></a>
				<a class="btn btn-wh-line" onClick="closeLayer()"  role="button"><s:text name="comm.exit"/></a>
			
			</div> 
			
            </div>
          </div>
        
      </div>
    </div>
  </div>
  
 <!--<script type="text/javascript" src="scripts/plugins/jquery/jquery.min.js"></script>-->
  <script type="text/javascript" src="scripts/static/template.js"></script>
  <script type="text/javascript" src="scripts/static/template.extend.js"></script>
  <script type="text/javascript" src="scripts/static/template.custom.js"></script>
  <script type="text/javascript" src="scripts/plugins/zTree_v3/jquery.ztree.core-3.5.js"></script>
  <script type="text/javascript" src="scripts/pagejs/view-frame.js?v=20160307"></script>
  <script> 

    $(document).ready(function(){ 
	reloadwaitAdd();
 

      //单位联系人
	  
      $("#btn-InternalUser").on("click", function(argument) {
	  var whir_select_user_url = whirRootPath + "/selectInternalUser!init.action";
	  var json_obj={type:'userOrgGroup',allowId:'msgtoid',allowName:'msgto',allowPhone:'msgtophone',callbackOK:'reloadwaitAdd'};
	  
         layer.open({
          type: 2,
          title: '单位联系人',
          shadeClose: false,
          //shade: 0.8,
          area: ['850px', '500px'],
          //content: '/defaultroot/modules/contacts/selectuser/select_internaluser_main(2).jsp'
		  //content: whirRootPath + "/selectInternalUser!init.action"
		  content:whir_select_user_url+"?type=" + json_obj.type + "&allowId=" + json_obj.allowId + "&allowName=" + json_obj.allowName + "&allowPhone=" + json_obj.allowPhone+"&callbackOK="+json_obj.callbackOK+"&layer=yes",
        }); 
      })
	
	 //我的联系人
	  
      $("#btn-mycontact").on("click", function(argument) {
	  var whir_select_user_url = whirRootPath + "/selectExternalUser!init.action";
	  var json_obj={type:'private',allowId:'msgtoidprivate',allowName:'msgtoprivate',allowPhone:'msgprivatephone',callbackOK:'reloadwaitAdd'};
         layer.open({
          type: 2,
          title: '我的联系人',
          shadeClose: false,
          //shade: 0.8,
          area: ['850px', '500px'],
          //content: '/defaultroot/modules/contacts/selectuser/select_internaluser_main(2).jsp'
		  //content: whirRootPath + "/selectInternalUser!init.action"
		  content:whir_select_user_url+"?type=" + json_obj.type + "&allowId=" + json_obj.allowId + "&allowName=" + json_obj.allowName + "&allowPhone=" + json_obj.allowPhone+"&callbackOK="+json_obj.callbackOK+"&layer=yes",
        }); 
      })
	  
		 //群组
      $("#btn-selectGroup").on("click", function(argument) {
          var index =layer.open({
          type: 2,
          title: '选择群组',
          shadeClose: false,
          //shade: 0.8,
          area: ['400px','350px', 'auto'],
		  //content: '/defaultroot/modules/contacts/joinGroup.jsp'
		 content:  whirRootPath +'/Group!selectGroupList.action?groupType=1&type=selectGroup',
		//  maxmin: true,
		 end: function () {
				//获取数量
				var waitAdd = $("#waitAdd option").size();
				$('#enjoinNUM').text(waitAdd);
				}
        });
		//layer.full(index);		
      })
	  
      //弹出快捷加入
      $("#btn-quickadd").on('click', function(argument){
        layer.open({
          type: 2,
          title: '收信人号码',
          shadeClose: false,
          //shade: 0.8,
          area: ['480px', '420px'],
         // content: $('#detail-quickadd')
		 content:'/defaultroot/modules/contacts/quickadd.jsp',
		 end: function () {
				//获取数量
				var waitAdd = $("#waitAdd option").size();
				$('#enjoinNUM').text(waitAdd);
				}
        }); 
      })

      //我的联系人，点击高级搜索弹出搜索框
      $(".basic-sea-btn").click(function(){
        if($(this).hasClass("open")){
          $(this).removeClass("open");
          $(".senior-search").removeClass("open");
        }else{
          $(this).addClass("open");
          $(".senior-search").addClass("open");
        } 
      })
	  
	  
	 //获取数量
	var waitAdd = $("#waitAdd option").size();
	$('#enjoinNUM').text(waitAdd);
	
	
	
		
    })
	
	function closeLayer(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
     parent.layer.close(index);//关闭
}




	function reloadwaitAdd(){
	
		var msgto = $('#msgto').val();
		var msgtophone =  $('#msgtophone').val();
		var msgtoprivate  = $('#msgtoprivate').val();
		var msgprivatephone = $('#msgprivatephone').val();
		var receiveCode = $('#receiveCode').val();
		var quickaddName =  $('#quickaddName').val();
		var quickaddPhone =  $('#quickaddPhone').val();
		
		var phoneStr="";
		var nameStr="";
		var waitAdd = document.getElementById("waitAdd");//待选区
		if(msgtophone!=""&&msgtophone!=null){
			phoneStr =phoneStr+msgtophone;
			nameStr =nameStr+msgto;
		}
		if(msgprivatephone!=""&&msgprivatephone!=null){
			phoneStr =phoneStr+msgprivatephone;
			nameStr =nameStr+msgtoprivate;
		}
		if(receiveCode!=""&&receiveCode!=null){
			phoneStr =phoneStr+receiveCode;
			//20170712 -by jqq 快捷录入外部电话号,保存后再加载，name为空，展示时候用录入的电话号作为name
			nameStr =nameStr+receiveCode;
		}
		
		if(quickaddPhone!=""&&quickaddPhone!=null){
			phoneStr =phoneStr+quickaddPhone;
			nameStr =nameStr+quickaddName;
		}
		
		if(phoneStr!=""&&phoneStr!=null){
			var  phoneArr = phoneStr.split(",");
			var  nameArr = nameStr.split(",");
			
			for(var i=0;i<phoneArr.length;i++){
				var empName = nameArr[i];
				var phoneNum = phoneArr[i];
				
				if(phoneNum!=""&&phoneNum!=null){
					if(empName.length>15){
						empName=empName.substring(0,15)+"...";
					}
					var option = new Option(empName+" "+phoneNum,phoneNum);
					if(!isExistOption("waitAdd",phoneNum)){
						option.setAttribute("data-name",nameArr[i]);
						option.setAttribute("title",nameArr[i]+" "+phoneNum);
						waitAdd.add(option);//加入待选区
					}
					
				}
			
			}
			DistinctSelectOption("waitAdd");
		
		}
	
		
	}

//判断select中是否存在值为value的项
function isExistOption(id,value) {
	var isExist = false;
	var count = $('#'+id).find('option').length;
	for(var i=0;i<count;i++){
		if($('#'+id).get(0).options[i].value == value){
				//alert("存在");
				//layer.msg("号码重复，并去重！");
				isExist = true;break;
			}
		}
		return isExist;
}
	
/*删除重复项*/ 
function DistinctSelectOption(id){ 

  $("#waitAdd option").each(function() {
            var val = $(this).val();
			
            if ( $("#waitAdd option[value='" + val + "']").length > 1 ){
				layer.msg("号码重复，并去重！");
				$("#waitAdd option[value='" + val + "']:gt(0)").remove();
				
			}
            //dt=true;    
        });
		//获取数量
		var waitAdd = $("#waitAdd option").size();
		$('#enjoinNUM').text(waitAdd);

} 


function cleanwaitAdd(){
    
	//$("#waitAdd").empty();
    var obj = document.getElementById("waitAdd"); 
    var count = obj.options.length; 
    for(var i = 0;i<count;i++){ 
        obj.options.remove(0);//每次删除下标都是0 
    } 
	$('#msgto').val("");
	$('#msgtoid').val("");
	$('#msgtophone').val("");
	$('#msgtoprivate').val("");
	$('#msgtoidprivate').val("");
	$('#msgprivatephone').val("");
	$('#receiveCode').val("");
	$('#quickaddName').val("");
	$('#quickaddPhone').val("");
	$('#enjoinNUM').text("0");
}

function deletewaitAdd(){
		var sel=false; 
        var obj = document.getElementById("waitAdd"); 
        var count = obj.options.length; 
		
        for(var i = 0;i<count;i++){
            if(obj.options[i].selected){
                obj.options[i].remove(0);//每次删除下标都是0 
            }
        } 
		/*obj.options.each(function() {
				if(this.selected){
					 sel=true;
					}
				});
			if(!sel){
				layer.msg('未选中记录!');
				return;
			}
		obj.options.each(function() {
				if(this.selected){
					this.remove(); 
				};
				
			
		})*/
		//获取数量
		var waitAdd = $("#waitAdd option").size();
		$('#enjoinNUM').text(waitAdd);
	}
	

//删除发送人选项
function delOption() 
{  
    var oSel =  document.getElementById("waitAdd"); 
	var options=$("#waitAdd option:selected");  
	
    options.each(function() {
				if(this.selected){
					$(this).remove();
					//删除隐藏域中的值
						var t =$(this).text();
						var name = t.split(" ")[0];
						var phone = t.split(" ")[1];
					    delateByElementText(name,phone); 
					} else{   
						 layer.msg('未选中记录!');  
					} 
				
				
			
		})

	//获取数量
		var waitAdd = $("#waitAdd option").size();		
		$('#enjoinNUM').text(waitAdd);	
}   

function openDesktopNew(){};

function delateByElementText(name,phone){
		var phoneTmep = phone;
		var nameTemp = name;
        name = name+",";
		phone = phone+",";
		var msgto = $('#msgto').val();
		var msgtoid =  $('#msgtoid').val();
		var msgtophone =  $('#msgtophone').val();
		var msgtoprivate  = $('#msgtoprivate').val();
		var msgtoidprivate =  $('#msgtoidprivate').val();
		var msgprivatephone = $('#msgprivatephone').val();
		var receiveCode = $('#receiveCode').val();
		//20170713 -by jqq 隐藏字段 快捷加入的电话号 quickaddName quickaddPhone ，即外发号
		var quickaddName = $('#quickaddName').val();
		var quickaddPhone = $('#quickaddPhone').val();
		
		//删除隐藏域id --start
		if(msgtophone.indexOf(phone)>-1){
			var msgtophoneArr = msgtophone.split(",");
			
			var msgtoidArr = msgtoid.split(",");
			for(var i=0;i<msgtophoneArr.length;i++){
				if(msgtophoneArr[i]!='' && msgtophoneArr[i]==phoneTmep){
					msgtoidArr.remove(i);
				}
			}
			var msgtoidTemp = "";
			for(var j=0;j<msgtoidArr.length;j++){
				if(msgtoidArr[i]!=''){
					msgtoidTemp = msgtoidTemp+msgtoidArr[i]+",";
				}
				
			}
			$('#msgtoid').val(msgtoidTemp);
		}
		
		if(msgprivatephone.indexOf(phone)>-1){
	
			var msgprivatephoneArr = msgprivatephone.split(",");
			
			var msgtoidprivateArr = msgtoidprivate.split(",");
			for(var i=0;i<msgprivatephoneArr.length;i++){
				if(msgprivatephoneArr[i]!='' && msgprivatephoneArr[i]==phoneTmep){
				
					msgtoidprivateArr.remove(i);
					
				}
			}
			var msgtoidprivateTemp = "";
			for(var j=0;j<msgtoidprivateArr.length;j++){
				if(msgtoidprivateArr[j]!=''){
					msgtoidprivateTemp = msgtoidprivateTemp+msgtoidprivateArr[j]+",";
				}
				
			}
				
			$('#msgtoidprivate').val(msgtoidprivateTemp);
		}
		//20170713 -by jqq 隐藏字段 快捷加入的电话号 quickaddName quickaddPhone ，即外发号
		if(quickaddName.indexOf(name)>-1){
			quickaddName = quickaddName.replace(name,"");
			$('#quickaddName').val(quickaddName);
		}
		if(quickaddPhone.indexOf(phone)>-1){
			quickaddPhone = quickaddPhone.replace(phone,"");
			$('#quickaddPhone').val(quickaddPhone);
		}
		//删除隐藏域id --end
		
		if(msgto.indexOf(name)>-1){
			msgto = msgto.replace(name,"");
			$('#msgto').val(msgto);
		}
		if(msgtophone.indexOf(phone)>-1){
			msgtophone = msgtophone.replace(phone,"");
			$('#msgtophone').val(msgtophone);
		}
		if(msgtoprivate.indexOf(name)>-1){
			msgtoprivate = msgtoprivate.replace(name,"");
			$('#msgtoprivate').val(msgtoprivate);
		}
		if(msgprivatephone.indexOf(phone)>-1){
			msgprivatephone = msgprivatephone.replace(phone,"");
			$('#msgprivatephone').val(msgprivatephone);
		}
		if(receiveCode.indexOf(phone)>-1){
			receiveCode = receiveCode.replace(phone,"");
			$('#receiveCode').val(receiveCode);
		}
		
		
		
		
		
		
}


Array.prototype.remove=function(dx) 
{ 
    if(isNaN(dx)||dx>this.length){return false;} 
    for(var i=0,n=0;i<this.length;i++) 
    { 
        if(this[i]!=this[dx]) 
        { 
            this[n++]=this[i] 
        } 
    } 
    this.length-=1;
} 
  </script>
</table>