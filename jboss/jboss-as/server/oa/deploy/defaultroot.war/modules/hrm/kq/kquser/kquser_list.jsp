<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ include file="/public/include/meta_list.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
		EncryptUtil util = new EncryptUtil();
		String dlcode = util.getSysEncoderKeyVlaue("FileName","kq_user_import_template.xls","dir");
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
	<s:form name="queryForm" id="queryForm" action="kquser!kquser_list_data.action" method="post" theme="simple"> 
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
                                <label for="" class="col-wh-3 control-label">考勤类别：</label>
                                <div class="form-group col-wh-9 nopright">					   
									   <select name="kqType"  class="form-control">
											<option value="">--请选择--</option>
											<option value="0">有考勤</option>
											<option value="1">无考勤</option>
											<option value="2">手工汇总</option>
											<option value="-1">其它</option>
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
						         <div class="btn-group btn-group-sm">
									 <a  class="btn btn-wh-line meeting-handle" onclick="downloadTemplate1();">下载导入模板</a>
								 </div>
								 <div class="btn-group btn-group-sm">
								    <a  class="btn btn-wh-line meeting-handle" onclick="excelImport2();">导  入</a>
								</div>
				  </div>
			</div>
			<div class="org-tablist" style="display: block;">
					<div class="table-over table-contact" >
							<table class="table" id="taskTJByfzrid">
								<thead id="headerContainer">
									<tr class="listTableHead" style="font-weight: bold;vertical-align:middle;">
										<td whir-options="field:'kqCode',width:'15%'">考勤编号</td> 
										<td whir-options="field:'orgNameString',width:'45%'">部门</td> 
										<td whir-options="field:'empName',width:'15%'">姓名</td> 
										<td whir-options="field:'kqType',width:'17%'">考勤类别</td> 
										<td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
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

</s:form>
	
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	  function initList_new(){
         initListFormToAjax_2016({formId:"queryForm"});
     }
	
	
	//自定义操作栏内容
	function myOperate(po,i){
		var html = "&nbsp;";
		html =  '<a  href="javascript:void(0)" title="修改"  onclick="xiugai('+po.empId+',\''+po.verifyCode+'\');" ><i class="fa fa-pencil-square-o"></i></a>';
		return html;
	}
//openWin({url:\'<%=rootPath%>/kquser!kquser_modify.action?empId='+po.empId+'&verifyCode='+po.verifyCode+'\',width:920,height:300,winName:\'kquser_modify\'});


function xiugai(id,code){
   // var url ='<%=rootPath%>/kquser!kquser_modify.action?empId='+id+'&verifyCode='+code';
	   var titile="修改考勤人员";
	   var tempurl='<%=rootPath%>/kquser!kquser_modify.action?empId='+id+'&verifyCode='+code;
	   layer.open({
			  type: 2,
			  title: titile,
			  shadeClose: false,
			  //shade: 0.8,
			  zIndex:1100,
			  // offset:['60px','200px'],
			  area: ['1050px', '620px'],
			  content:tempurl
			}); 


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
		$('#search_div,#taskname,#searchInpTip').on("click", function(e) {		
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

    //下载考勤模板
    function downloadTemplate1(){
		var params = '?exportTitle=考勤-考勤人员模板';
	 
		commonExportExcel({formId:'queryForm', action:'/defaultroot/kquser!exportKqUser.action'+params});
		//location.href="<%=rootPath%>/public/download/download.jsp?verifyCode=<%=dlcode%>&FileName=kq_user_import_template.xls&name=考勤人员导入模板.xls&path=kq";
		
	}

  //导出
	function exportExcel(flag) {

		
		var params = '?exportTitle=考勤-考勤人员导出';
	 
		commonExportExcel({formId:'queryForm', action:'/defaultroot/kquser!exportKqUser.action'+params});
	}
	
	function excelImport2(){
		excelImport({importer:"<%=rootPath%>/modules/hrm/kq/kquser/kq_user_import_save.jsp"});
	}
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	
	
</script>
