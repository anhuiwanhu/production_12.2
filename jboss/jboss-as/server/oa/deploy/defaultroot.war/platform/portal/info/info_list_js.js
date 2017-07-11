/** 列表页 [BEGIN] */
//初始化表头、分页参数等html、公共js事件绑定
function initList_Forum(formId){

    //分页参数的渲染
    var pager_param = '<input type="hidden" id="start_page" name="startPage" value="1" /><input type="hidden" id="page_count" name="pageCount" value="1" /><input type="hidden" id="recordCount" name="recordCount" value="0" />';
    $('#'+formId).append(pager_param);
	
    $('#'+formId).find("#go_start_pager_t").bind('focus keyup blur mouseout',function(){
        //数字校验
        checkNumber($('#'+formId).find("#go_start_pager_t"));
        
        var go_start_pager = $('#'+formId).find("#go_start_pager_t").val();
        var page_count     = $('#'+formId).find("#page_count").val();
        if( (go_start_pager*1+0) > (page_count*1+0) ){
            $('#'+formId).find("#go_start_pager_t").val(page_count);
        }
        if( go_start_pager != "" && (go_start_pager*1+0) == 0 ){
            $('#'+formId).find("#go_start_pager_t").val(1);
        }
		$('#'+formId).find("#start_page").val($('#'+formId).find("#go_start_pager_t").val());
    });    
	
    $('#'+formId).find("#go_start_pager_b").bind('focus keyup blur mouseout',function(){
        //数字校验
        checkNumber($('#'+formId).find("#go_start_pager_b"));
        
        var go_start_pager = $('#'+formId).find("#go_start_pager_b").val();
        var page_count     = $('#'+formId).find("#page_count").val();
        if( (go_start_pager*1+0) > (page_count*1+0) ){
            $('#'+formId).find("#go_start_pager_b").val(page_count);
        }
        if( go_start_pager != "" && (go_start_pager*1+0) == 0 ){
            $('#'+formId).find("#go_start_pager_b").val(1);
        }
		$('#'+formId).find("#start_page").val($('#'+formId).find("#go_start_pager_b").val());
    });  
	
    $('#'+formId).find("#go_start_pager_t").bind('change',function(){
        $('#'+formId).find("#go_start_pager_b").val($('#'+formId).find("#go_start_pager_t").val());
        $('#'+formId).find("#start_page").val($('#'+formId).find("#go_start_pager_t").val());
    });
	
    $('#'+formId).find("#go_start_pager_b").bind('change',function(){
        $('#'+formId).find("#go_start_pager_t").val($('#'+formId).find("#go_start_pager_b").val());
        $('#'+formId).find("#start_page").val($('#'+formId).find("#go_start_pager_b").val());
    });
	
	//回车查询	
	$("body").on('keydown',function(event){
		if(event!=undefined && event.keyCode==13){
			/*
			if($("#go_start_pager").attr("class")=="clicked" && $.trim($("#go_start_pager").val())!=""){
				$('#'+formId).find("#start_page").val($("#go_start_pager").val());
			}else{
				$('#'+formId).find("#start_page").val("1");
			}
			*/
			$("#"+formId).submit();
		}
	});
    //alert("111");
}
//设置分页中的文字说明部分
function setPagerDesc_Forum(formId){ 
	$("#"+formId).find("#pager_desc_t").html(''+comm.currentpage+'&nbsp;<font color="red">'+$("#"+formId).find("#start_page").val()+"</font>/"+$("#"+formId).find("#page_count").val()+'&nbsp;'+comm.page+'&nbsp;&nbsp;&nbsp;'+comm.total+'&nbsp;'+$("#"+formId).find("#recordCount").val()+'&nbsp;'+comm.records+'&nbsp;' );
	$("#"+formId).find("#pager_desc_b").html(''+comm.currentpage+'&nbsp;<font color="red">'+$("#"+formId).find("#start_page").val()+"</font>/"+$("#"+formId).find("#page_count").val()+'&nbsp;'+comm.page+'&nbsp;&nbsp;&nbsp;'+comm.total+'&nbsp;'+$("#"+formId).find("#recordCount").val()+'&nbsp;'+comm.records+'&nbsp;' );
}

//设置分页
function setPager_Forum(formId){
	$("#"+formId).find(".page").show();
	var page_size = ($("#"+formId).find("#page_size_t").val())*1+0;
	var start_page = ($("#"+formId).find("#start_page").val())*1+0;
	//alert('page_size=[' + page_size + ']');
	//alert('start_page=[' + start_page + ']');
	$("#"+formId).find("#pager_t").jPages({
	  containerID : "itemContainer",
	  previous : comm.lastpage,
	  next : comm.nextpage,
	  perPage : page_size,
	  startPage: start_page,
	  delay : 20,
	  formId:formId
	});
	
	//$("#"+formId).find("#pager_b").html($("#"+formId).find("#pager_t").html());
	
	$("#"+formId).find("#pager_b").jPages({
	  containerID : "itemContainer",
	  previous : comm.lastpage,
	  next : comm.nextpage,
	  perPage : page_size,
	  startPage: start_page,
	  delay : 20,
	  formId:formId
	});
	
	setPagerDesc_Forum(formId);
	
	$("#"+formId).find("#pager_t a").click(function(event){ 
	     event.stopPropagation(); 
	     event.preventDefault();
	}) ;
	$("#"+formId).find("#pager_b a").click(function(event){ 
	     event.stopPropagation(); 
	     event.preventDefault();
	}) ;
}

//跳转至某页，页码.
function pageClick(pagenumber, obj, sysnPagerId){
    var pform = $(obj).parents("form");
    pform.find("#start_page").val(pagenumber);
    pform.find("#go_start_pager_t").val("");
    pform.find("#go_start_pager_b").val("");
    pform.find("#" + sysnPagerId).val($(obj).val());
    pform.submit();
    //refreshListForm($(obj).parents("form").attr("id"));
}

function initPorteltInfoListFormToAjax(formJson){
    var formJson_ = eval(formJson);
    var formId = formJson_.formId;
    var userId = document.getElementById("userId").value ; 
    //初始化表头、分页参数等html、公共js事件绑定
    initList_Forum(formId);
    var jq_form = $('#'+formId);
    jq_form.ajaxForm({
        beforeSend:function(){
            //$.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
        },
        success:function(responseText){
            $.dialog({id:"Tips"}).close();
			jq_form.find("#itemContainer").html('');
			
            //解析服务器返回的json字符串
            var json = eval("("+responseText+")").data;
            var pager = json.pager;
            var data = json.data;
            //分页信息
            if(eval(pager.pageCount)!=0 && eval(pager.pageCount) < eval(jq_form.find("#start_page").val()) ){
                jq_form.find("#start_page").val(jq_form.find("#start_page").val()-1);
            }
            jq_form.find("#page_count").val(pager.pageCount);
            jq_form.find("#recordCount").val(pager.recordCount);
			
			// 
			setPager_Forum(formId);
			
            //循环数据信息
            var page_tr = "";
            for (var i=0; i<data.length; i++) {
                var po = data[i];  
				var li = '<li>';
				li += '<span class="date">(' + po.informationIssueTime + ')&nbsp;&nbsp;&nbsp;&nbsp;</span>';
				//li += '<a href="javascript:void(0);" onclick="viewInfo(' + po.id + ', \''+po.informationTitle+'\', \''+po.channelName+'\')">'
				li += '<a href="javascript:void(0);" onclick="viewInfo(' + po.id + ', \''+po.informationTitle+'\', \''+po.channelName+'\', \''+po.channelId+'\', \''+po.channelType+'\',\''+po.informationType+'\',\''+po.userDefine+'\','+ userId + ')">'   
				li += po.informationTitle;
				li += '</a>';				
				li += '</li>';
                page_tr += li ;
            }
            jq_form.find("#itemContainer").html(page_tr);
			
            //调用回调事件
            if(formJson_.onLoadSuccessAfter){
                formJson_.onLoadSuccessAfter.call(this);
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            $.dialog({id:"Tips"}).close();
            $.dialog.alert(comm.loadfailure,function(){});
        }
    }); 
    //初次提交表单获得数据
    $("#"+formId).submit();
}
/** 列表页 [END] */

//function viewInfo(id, title, channelName){
function viewInfo(id, title, channelName,channelId,channelType,informationType,userDefine,userId,rootPath){ 
	//var main = $(parent.document).find("#divIfameId01");
	//main.attr("src",encodeURI('PortalInformation!getInformation.action?title='+title+'&id='+id+'&categoryName='+channelName));
	//window.parent.reSetIframe();
	//var thisheight = $(document).height()+30;
    //main.height(document.documentElement.scrollHeight);
//    window.open(encodeURI('PortalInformation!getInformation.action?title='+title+'&id='+id+'&categoryName='+channelName), '', 'menubar=0,scrollbars=yes,locations=0,width='+screenwidth+',height='+screenheight+',resizable=yes');

   var thisU1 = window.location.protocol; // http:
   var thisU2 = window.location.host;
   var baseURL = thisU1+"//"+thisU2+"/defaultroot" 

	//未登录,进入这个页面
	//alert(userId);
	if(userId==null || userId==""||userId=="null" || userId=="undefined"){
		  window.open(encodeURI('PortalInformation!getInformation.action?title='+title+'&id='+id+'&categoryName='+channelName), '', 'menubar=0,scrollbars=yes,locations=0,width='+screenwidth+',height='+screenheight+',resizable=yes');
	}else{
		imageNewsTitleLink = baseURL+"/Information!view.action?" +
					"informationId=" + id +
					"&userDefine=" + userDefine + "&informationType=" +
					informationType + "&channelId=" + channelId + 
					"&channelType=" + channelType +
					"&userChannelName=" +
					"信息管理";
		window.open(encodeURI(imageNewsTitleLink), '', 'menubar=0,scrollbars=yes,locations=0,width='+screenwidth+',height='+screenheight+',resizable=yes');
	}
}
