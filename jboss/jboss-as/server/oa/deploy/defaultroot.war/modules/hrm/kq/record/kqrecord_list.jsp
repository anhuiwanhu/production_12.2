<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ include file="/public/include/meta_list.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.hrm.kq.*"%>
<%@ page import="com.whir.ezoffice.hrm.kq.bd.*"%>
<%
		String empId = request.getParameter("empId")!=null?request.getParameter("empId"):"";
	%>
<script type="text/javascript">
    var startTempValue = {
        elem: '#beginDate',
        format: 'YYYY-MM-DD',
        istime: false,
        festival: true,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endDate',
        format: 'YYYY-MM-DD',
        istime: false,
        festival: true,
        choose: function(datas){
            startTempValue.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
</script>
	<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
	<s:form name="queryForm" id="queryForm" action="kqrecord!kqrecord_list_data.action" method="post" theme="simple">
        <input type="hidden" value="" id="run" name="run" /> 
	    <input type="hidden" value="<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(empId)%>" id="empId" name="empId" /> 
	    <!-- SEARCH PART START -->
	    <%@ include file="/public/include/form_list.jsp"%>
		<div class="view-container" >
			<div class="view-hdpanel panel panel-whlist">
				<div class="panel-heading clearfix">
					<div class="panel-hd-search has-feedback">
							<div class="input-group input-group-sm">
							 <div class="input-group-btn senior-seachbtn"><a href="javascript:void(0)"  class="btn btn-wh-line">高级搜索</a></div>
							 <label id="searchInpTip"  onclick="hidesearchInpTip('empName')" class="searchInpTip_class"  >
								  &nbsp;请输入用户名称</label>
								<input onblur="showsearchInpTip('empName')" type="text" class="form-control form-control-wh-line" placeholder=""  name="empName" id="empName"  />	   
								<div class="input-group-btn"><a onclick="refreshListForm('queryForm');" class="btn btn-wh-line"><i class="fa fa-search"></i></a></div>
						  </div>
							<!-- 高级搜索下拉框 -->
                       <div class="list-senior-search clearfix" id="search_div">
                        <p class="search-title" style="margin-bottom:10px">
                            <span>搜索项</span>
                            <i class="fa fa-angle-right close-search"></i>
                        </p>
                        <div class="form-horizontal"> 
						     <div class="form-group">
                                <label for="" class="col-wh-3 control-label">员工编号：</label>
                                <div class="form-group col-wh-9 nopright">					   
									   <input type="text" class="form-control" id="employeeNumberPara" name="employeeNumberPara" />
                                </div>
                            </div>
							<div class="form-group">
                                <label for="" class="col-wh-3 control-label">考勤状态：</label>
                                <div class="form-group col-wh-9 nopright">					   
									   <select name="kqStatus" id="kqStatus" class="form-control">
											<option value="">--请选择--</option>
											<option value="<%=KQ_STATUS.NORMAL%>" ><%=KQ_STATUS.getStatusName(KQ_STATUS.NORMAL)%></option>
											<option value="<%=KQ_STATUS.LATE%>"><%=KQ_STATUS.getStatusName(KQ_STATUS.LATE)%></option>
											<option value="<%=KQ_STATUS.ABSENTEEISM_HALF%>"><%=KQ_STATUS.getStatusName(KQ_STATUS.ABSENTEEISM_HALF)%></option>
											<option value="<%=KQ_STATUS.ABSENTEEISM%>"><%=KQ_STATUS.getStatusName(KQ_STATUS.ABSENTEEISM)%></option>
											<option value="<%=KQ_STATUS.LEAVE%>" ><%=KQ_STATUS.getStatusName(KQ_STATUS.LEAVE)%></option>
											<option value="<%=KQ_STATUS.LEAVE_EARLY%>"><%=KQ_STATUS.getStatusName(KQ_STATUS.LEAVE_EARLY)%></option>
											<option value="<%=KQ_STATUS.OVERTIME%>"><%=KQ_STATUS.getStatusName(KQ_STATUS.OVERTIME)%></option>
											<option value="<%=KQ_STATUS.TRAVEL%>" ><%=KQ_STATUS.getStatusName(KQ_STATUS.TRAVEL)%></option>
											<option value="<%=KQ_STATUS.REST%>" ><%=KQ_STATUS.getStatusName(KQ_STATUS.REST)%></option>
											<option value="<%=KQ_STATUS.OTHER%>"><%=KQ_STATUS.getStatusName(KQ_STATUS.OTHER)%></option>
				                        </select>   
                                </div>
                            </div>
							<div class="form-group">
                                <label for="" class="col-wh-3 control-label">请假类别：</label>
                                <div class="form-group col-wh-9 nopright">					   
									  <select name="leaveType" id="leaveType" class="form-control" >
										<option value="">--请选择--</option>
										<option value="<%=KQ_LEAVE_TYPE.LEAVE%>" ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.SICK_LEAVE%>"><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.SICK_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.REST%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.REST)%></option>
										<option value="<%=KQ_LEAVE_TYPE.ANNUAL_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.ANNUAL_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.MARRIAGE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.MARRIAGE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.MATERNITY_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.MATERNITY_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.HOME_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.HOME_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.INJURY_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.INJURY_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.BEREAVEMENT_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.BEREAVEMENT_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.FAMILYPLANNING_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.FAMILYPLANNING_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.BREASTFEED_LEAVE%>"  ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.BREASTFEED_LEAVE)%></option>
										<option value="<%=KQ_LEAVE_TYPE.OTHER%>" ><%=KQ_LEAVE_TYPE.getLeaveTypeName(KQ_LEAVE_TYPE.OTHER)%></option>
									</select> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-wh-3 control-label">日期：</label>
                                <div class="col-wh-9">
                                    <div class="has-feedback">
                                        <input type="text" class="form-control" id="beginDate" name="beginDate" readonly style="background-color:white;" onclick="laydate(startTempValue);" >
                                        <i class="fa fa-calendar form-control-feedback"></i>
                                    </div>
                                    <label>至</label>
                                    <div class="has-feedback">
                                        <input type="text" class="form-control" id="endDate" name="endDate" onclick="laydate(end);" readonly style="background-color:white;" >
                                        <i class="fa fa-calendar form-control-feedback"></i>
                                    </div>
                               </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="" class="col-wh-3 control-label">移动考勤：</label>
                                <div class="form-group col-wh-9 nopright">					   
									  <select name="moveKqType"  id="moveKqType" class="form-control" >
									  	<option value="">--请选择--</option>
										<option value="1" >正常</option>
										<option value="-1">异常</option>
										<option value="-2"  >无</option>
									</select> 
                                </div>
                            </div>
                            
                            
                        </div>
						<div class="detail-btn clearfix">
							<a class="btn btn-wh-line" href="javascript:void(0)" role="button" onclick="resetForm()">重&nbsp;&nbsp;&nbsp;置</a>
							<a class="btn btn-wh-line" href="javascript:void(0)" role="button" onclick="refreshListForm('queryForm');">搜&nbsp;&nbsp;&nbsp;索</a>
						</div>
					</div>
				</div>
				 <div class="panel-hd-btns">
						<%if(empId.equals("")){%>
						         <div class="btn-group btn-group-sm">
									 <a  class="btn btn-wh-line meeting-handle" onclick="generateKQRecord();">生成考勤记录</a>
								 </div>
								 <div class="btn-group btn-group-sm">
									<a  class="btn btn-wh-line meeting-handle" onclick="batchDel();">批量删除</a>
								</div>
								<div class="btn-group btn-group-sm">
									<a  class="btn btn-wh-line meeting-handle" onclick="exportData();">导&nbsp;&nbsp;&nbsp;出</a>
								</div>
                       <%}%>
				  </div>
				
			</div>
			<div class="org-tablist" style="display: block;">
					<div class="table-over table-contact" >
							<table class="table" id="taskTJByfzrid">
								<thead id="headerContainer">
									<tr class="listTableHead" style="font-weight: bold;vertical-align:middle;">
										  <td whir-options="field:'id',width:'5%',checkbox:true " align="center" >
												<div class="tb-container">
													<label>
														<input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" >
													</label>
												</div>
										   </td>
										<td whir-options="field:'kqDate',width:'8%',renderer:common_DateFormat">日期</td> 
										<td whir-options="field:'empNumber',width:'7%'">员工编号</td> 
										<td whir-options="field:'orgNameString',width:'14%'">组织</td> 
										<td whir-options="field:'empName',width:'6%'">姓名</td> 
										<td whir-options="field:'beginTime',width:'7%',renderer:getDetail1">上班时间</td> 
										<td whir-options="field:'endTime',width:'6%',renderer:getDetail2">下班时间</td> 
										<td whir-options="field:'moveKq',width:'7%',renderer:movekq">移动考勤</td> 
										<td whir-options="field:'kqStatus',width:'6%'">考勤状态</td> 
										<td whir-options="field:'leaveType',width:'7%'">请假类别</td> 
										<%if(empId.equals("")){%>
										<td whir-options="field:'leaveOvertimeHours',width:'6%'">加时时间</td> 
										<td whir-options="field:'leaveHours',width:'6%'">请假时间</td> 
										<td whir-options="field:'travelHours',width:'6%'">出差时间</td> 
										<td whir-options="field:'',width:'12%',renderer:myOperate">操作</td> 
										<%}%>
									</tr>
								</thead>
								<tbody  id="itemContainer" >

								</tbody>
							</table>
					</div>
					<div class="panel-footer">
							<%@ include file="/public/page/pager_2016.jsp"%>
					</div>
				</div>

		 </div>
</div>
</s:form>
<s:form name="exportForm" id="exportForm" action="" method="post" theme="simple">
       
 </s:form>
	
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	  function initList_new(){
         initListFormToAjax_2016({formId:"queryForm"});
     }
	function movekq(po,i){
	var html ="";
	  var movekqvalue = po.moveKq;
	  if(movekqvalue==''||movekqvalue==null){
	      html="无";
	  
	  }else if(movekqvalue=='1'){
	   html="正常";
	  
	  }else{
	  html="异常";
	  
	  }
	  return html;
	  
	
	}
	
	function getDetail1(po,i){
	   var html = "";
	   var isCanShowDetail = po.isCanShowDetail;
	   if(isCanShowDetail ==''){
	         html=po.beginTime;
	   }else if(isCanShowDetail=='1' || isCanShowDetail=='2'){
			 var empId= po.empId;
			 var kqDate = po.kqDate;
			 html  =  '<a  href="javascript:void(0)"  onclick="getDetailInfo(1,\''+empId+'\',\''+kqDate+'\');">'+po.beginTime+'</a>'; 
	   } 
		 return html;
	}
	function getDetail2(po,i){
	   var html = "";
	   var isCanShowDetail = po.isCanShowDetail;
	   if(isCanShowDetail ==''){
	         html=po.endTime;
	   }else if(isCanShowDetail=='1' || isCanShowDetail=='3'){
			 var empId= po.empId;
			 var kqDate = po.kqDate;
			 html  =  '<a  href="javascript:void(0)"  onclick="getDetailInfo(2,\''+empId+'\',\''+kqDate+'\');">'+po.endTime+'</a>'; 
	   } 
		 return html;
	
	}
	
	function getDetailInfo(num,empid,kqdate){
	    var titile="移动考勤详情";
	    var tempurl='<%=rootPath%>/kqrecord!showDetailInfo.action?num='+num+'&moveKqEmpId='+empid+'&moveKqDate='+kqdate;
	    layer.open({
			  type: 2,
			  title: titile,
			  shadeClose: false,
			  //shade: 0.8,
			  zIndex:1100,
			  // offset:['60px','200px'],
			  area: ['850px', '600px'],
			  content:tempurl
			});
	
	}
	//自定义操作栏内容
	function myOperate(po,i){
		var html = "&nbsp;";
		//var verifyCode = po.verifyCode;
		html  =  '<a  href="javascript:void(0)" title="修改" onclick="updateRecord('+po.id+',\''+po.verifyCode+'\');"><i class="fa fa-pencil-square-o"></i></a>&nbsp;';
		html +=  '<a  href="javascript:void(0)" title="删除" onclick="singleDel('+po.id+',this);" ><i class="fa fa-times"></i></a>&nbsp;';
		html +=  '<a href="javascript:void(0)" title="查看申请单" onclick="viewApply('+po.id+',\''+po.verifyCode+'\');" style="cursor:pointer"><i class="fa fa-short-mes"></i></a>';
		
		if(po.parentId!=""){
			html +=  '&nbsp;<a  href="javascript:void(0)" title="查看修改记录" onclick="viewRecords('+po.parentId+',\''+po.verifyCode+'\');" style="cursor:pointer"><i class="fa fa-random"></i></a>';
		}
		return html;
	}
	
//高级搜索
	var flag=0;
    $(".senior-seachbtn").on("click",function(){
		flag=1;
		
		if($(".panel-hd-search").hasClass("open")){
			$(".panel-hd-search").removeClass("open");
		}else{
			$(".panel-hd-search").addClass("open");
		} 
    });

    $(".close-search").on("click",function(){
		$(".panel-hd-search").removeClass("open");
    })

	//先解绑定，防止绑定多次
    $(document).unbind("click").click(function() {
		
		// 点击某些元素不隐藏高级搜索
		$('#search_div,#taskname,#searchInpTip,#laydate_box').on("click", function(e) {
		
			flag=1;
			
		});
		
		if(flag!=1){     
			//$("#search_div").hide();
			if($(".panel-hd-search").hasClass("open")){
			
				$(".panel-hd-search").removeClass("open");	
			}
		}
		flag=0;
    });
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	
	//批量删除
	function batchDel(){
	    var ids="";
        ids= getCheckBoxData('id', 'id');
	    var url = '<%=rootPath%>/kqrecord!kqrecord_batch_delete.action?id='+ids;
	    if(ids==null||ids==""){
            layer.msg('请选中需要删除的记录！',{ time: 2000 });
            return false;
        }else{
	       ajaxOperate_2016({urlWithData:url,tip:'删除数据',isconfirm:true, formId:'queryForm', callbackfunction:null});   
	    } 
	}
	//删除
	function singleDel(id,o){
	 ajaxDelete_2016('<%=rootPath%>/kqrecord!kqrecord_delete.action?id='+id,o);
	}
	function generateKQRecord(){
	 layer.confirm('确认生成考勤记录吗？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			$.post('<%=rootPath%>/modules/hrm/kq/record/ajax_generateKQRecord.jsp',{"formId":'queryForm'},function(data){
				data = eval("("+data+")");
				if(data.result=="success"){
					 layer.msg("生成考勤记录成功！");
					  document.getElementById("run").value = "run";
					  $("#queryForm").submit();
	                  document.getElementById("run").value = "";
				}else{
					layer.msg("没有生成考勤记录的数据！");
				}
			});}, function(){}); 
		//ajaxOperate({urlWithData:'<%=rootPath%>/modules/hrm/kq/record/ajax_generateKQRecord.jsp',tip:'生成考勤记录',formId:'queryForm',callbackfunction:frashMyList});
	}
	
	function frashMyList(opeJson,msg_json){
		document.getElementById("run").value = "run";
	    $("#queryForm").submit();
	    document.getElementById("run").value = "";
	}

	function setRunEmpty(){
		document.getElementById("run").value = "";
	}
    
	function viewApply(id,verifyCode){
	    var titile="查看申请单";
	    var tempurl='<%=rootPath%>/kqworkflow!apply_list.action?id='+id+'&verifyCode='+verifyCode
	    layer.open({
			  type: 2,
			  title: titile,
			  shadeClose: false,
			  //shade: 0.8,
			  zIndex:1100,
			  // offset:['60px','200px'],
			  area: ['1000px', '500px'],
			  content:tempurl
			});
	}
		
	function viewRecords(id,verifyCode){
	  // var ss =  document.getElementsByTagName("html")[0].className;
	   var titile="查看修改记录";
	   var tempurl='<%=rootPath%>/kqrecord!kqrecord_list_modify.action?id='+id+'&verifyCode='+verifyCode;
	  //var tempurl='<%=rootPath%>/modules/hrm/kq/record/kqrecord_list_modify.jsp?id='+id+'&verifyCode='+ve1rifyCode;
	 // modules\hrm\kq\record
	   layer.open({
			  type: 2,
			  title: titile,
			  shadeClose: false,
			  //shade: 0.8,
			  zIndex:1100,
			  // offset:['60px','200px'],
			  area: ['1000px', '500px'],
			  content:tempurl
			});
//openWin({url:'<%=rootPath%>/kqrecord!kqrecord_list_modify.action?id='+id+'&verify//Code='+verifyCode,width:920,height:550,winName:'kqrecord_modify'});
	}
	//导出excel
	function exportData(){
          var url = "<%=rootPath%>/kqrecord!kqrecord_list_export.action";
          commonExportExcel({formId:'queryForm',action:url});
      
		/*var empName =$('#empName').val();
		var kqStatus =$('#kqStatus').val();
		var leaveType =$('#leaveType').val();
		var beginDate =$('#beginDate').val();
		var endDate =$('#endDate').val();
		var param = 'empName='+empName+'&kqStatus='+kqStatus+'&leaveType='+leaveType+'&beginDate='+beginDate+'&endDate='+endDate+'';
	    $('#exportForm').attr('action','kqrecord!kqrecord_list_export.action?'+param);
	    $('#exportForm').submit();*/
	}
	
	//新增或修改任务
	function updateRecord(id,verifyCode){
	
	   var titile="修改考勤记录";
	   var tempurl='<%=rootPath%>/kqrecord!kqrecord_modify.action?id='+id+'&verifyCode='+verifyCode;
	   layer.open({
			  type: 2,
			  title: titile,
			  shadeClose: false,
			  //shade: 0.8,
			  zIndex:1100,
			  // offset:['60px','200px'],
			  area: ['700px', '500px'],
			  content:tempurl
			});
	}
</script>
