<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.ezoffice.ezform.po.*"%>
<%@ page import="com.whir.ezoffice.ezform.bd.*"%>
<%@ page import="com.whir.ezoffice.ezform.ui.*"%>
<%@ page import="com.whir.ezoffice.ezform.util.*"%>
<%@ page import="com.whir.ezoffice.customdb.customdb.po.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String settingId = request.getParameter("settingId");
String formId = request.getParameter("formId");
EzFormSettingBD sbd = new EzFormSettingBD();
SettingPO settingPO = null;
if(FormHelper.isNotEmpty(settingId)){
    settingPO = sbd.loadSettingPO(new Long(settingId), true);
}
%>
function _getFieldNameSuffix(showId){
    if("210"  == showId ||//单选人
        "211" == showId ||//多选人
        "212" == showId ||//单选组织
        "214" == showId ||//多选组织
        "704" == showId ||//单选人（本组织）
        "705" == showId //多选人（本组织）
    ){
        return "_Name";
    }
    return "";
}

//-------------------------------------------------------------
//字段联动-start-
//-------------------------------------------------------------
function trigEvents(obj, name, code, evt){
<%
if(settingPO!=null){
	Set trigSet = settingPO.getTrigSet();
	if(trigSet!=null && trigSet.size()>0){
		Iterator itor = trigSet.iterator();
		while(itor.hasNext()){
			TrigPO tpo = (TrigPO)itor.next();
			FieldPO fieldPO = sbd.getFieldPOByFieldId(tpo.getTrigFieldId());
			ShowPO showPO = fieldPO.getShowPO();
			TypePO typePO = fieldPO.getTypePO();
			String oldFieldName = fieldPO.getFieldName();
			String newFieldName = StringUtil.replaceSpecial(fieldPO.getFieldName(), '$');
			String showId = showPO.getShowId().toString();
%>
    if(name == '<%=oldFieldName%>'){
        var regObjName = name;
        var new_component_ = document.getElementsByName("new_component_"+name);
        if(new_component_.length>0){
            regObjName += new_component_[0].value;
        }
        regObjName += _getFieldNameSuffix('<%=showId%>');//"_Name";
<%
        String selectSql = " select ";
        String fromSql = " from ";
        String whereSql = " where 1=1 ";
        String orderBySql = "";
        String paramField = "";
        String getField = "";
        String showTypes = "";
        Map tableMap = new HashMap();
		Set sourceSet = tpo.getSourceSet();//数据源集合
		if(sourceSet!=null && sourceSet.size()>0){
			Iterator itors = sourceSet.iterator();
            while(itors.hasNext()){
            	DataSourcePO sourcepo = (DataSourcePO)itors.next();
            	if("localSys".equals(sourcepo.getDataSource_type())){
					Set tableSet = tpo.getTableSet();
					if(tableSet!=null && tableSet.size()>0){
						Iterator itor1 = tableSet.iterator();
						while(itor1.hasNext()){
							TrigTablePO ttpo = (TrigTablePO)itor1.next();
							fromSql += ttpo.getRefTableName() + " " + ttpo.getRefTableAlias() + ",";
							tableMap.put(ttpo.getRefTableName(), ttpo.getRefTableAlias());
						}
					}
					if(fromSql.endsWith(",")){
						fromSql = fromSql.substring(0, fromSql.length()-1);
					}

					String conditionSql = tpo.getTrigTableCon();
					if(FormHelper.isNotEmpty(conditionSql)){
						conditionSql = " " + conditionSql;
						int pos = conditionSql.toLowerCase().indexOf(" order by ");
						if(pos != -1){
							orderBySql = " " + conditionSql.substring(pos);
							conditionSql = conditionSql.substring(0, pos);
						}
						if(conditionSql.trim().length()>0){
							whereSql += " and (" + conditionSql + ") ";
						}
					}

					Set fieldSet = tpo.getFieldSet();
					if(fieldSet!=null && fieldSet.size()>0){
						Iterator itor1 = fieldSet.iterator();
						while(itor1.hasNext()){
							TrigFieldPO fpo = (TrigFieldPO)itor1.next();
							String tableName = fpo.getTableName();
							if("0".equals(fpo.getParamSetFlag())){
								whereSql += " and " + (String)tableMap.get(tableName) + "." + fpo.getFieldName() + "=? ";
								paramField += fpo.getFormField() + ",";
							}
						}
					}

					if(fieldSet!=null && fieldSet.size()>0){
						Iterator itor1 = fieldSet.iterator();
						int jj=0;
						while(itor1.hasNext()){
							TrigFieldPO fpo = (TrigFieldPO)itor1.next();
							String tableName = fpo.getTableName();
							if("1".equals(fpo.getParamSetFlag())){
								String[][] showType = new UIBD().getShowTypeByFieldName(formId, fpo.getFormField());
								String _st = showType[0][0];
								String _fv = showType[0][1];
								if("105".equals(_st)){
									if(_fv != null){
										if(_fv.indexOf("][")==-1){
											_st = "101";//非来自数据表
										}
									}
								}
								showTypes += _st + ",";

								selectSql += (String)tableMap.get(tableName) + "." + fpo.getFieldName() + "," + ("105".equals(_st)?(String)tableMap.get(tableName) + "." + tableName + "_id as "+tableName+"_id_"+(jj++)+",":"");
								getField += fpo.getFormField() + ",";
							}
						}
					}
					if(paramField.endsWith(",")){
						paramField = paramField.substring(0, paramField.length()-1);
					}
					if(getField.endsWith(",")){
						getField = getField.substring(0, getField.length()-1);
					}
					if(showTypes.endsWith(",")){
						showTypes = showTypes.substring(0, showTypes.length()-1);
					}
					if(selectSql.endsWith(",")){
						selectSql = selectSql.substring(0, selectSql.length()-1);
					}
%>
        var indexNO = 0;
        try{
            var _old_field = document.getElementsByName('<%=oldFieldName%>');
            var target = window.event?window.event.srcElement:evt.target;
            if(_old_field.length>1){
                for(var i=0;i< _old_field.length;i++){
                    if(target.parentNode == _old_field[i].parentElement){//修改三级联动数据显示错误问题
                    //if(target.offsetParent == _old_field[i].parentElement){
                        indexNO = i;
                        break;
                    } 
                }
            }
        }catch(e){}

        //alert(indexNO);

        var select_sql  = "<%=selectSql%>";
        var from_sql    = "<%=fromSql%>";
        var where_sql   = "<%=whereSql%><%=orderBySql%>";
        var param_field = "<%=paramField%>";
        var get_field   = "<%=getField%>";
        var showTypes   = "<%=showTypes%>";

        var params_url = 'select_sql='+encodeURIComponent(select_sql);
        params_url    += '&from_sql='+encodeURIComponent(from_sql);
        params_url    += '&where_sql='+encodeURIComponent(where_sql);
        params_url    += '&get_field_num='+get_field.split(",").length;
        params_url    += '&showTypes='+showTypes;

        if(param_field!=''){
            var pArr = param_field.split(",");
            for(var i=0; i< pArr.length; i++){
                var pName = pArr[i];
                var _showtype_ = document.getElementsByName(pName+"_showtype")[indexNO].value;
                var pVal = "";
                if(_showtype_){
                    if(_showtype_=='210'||//单选人
                        _showtype_=='211'||//多选人
                        _showtype_=='212'||//单选组织
                        _showtype_=='214'||//多选组织
                        _showtype_=='704'||//单选人（本组织）
                        _showtype_=='705'//多选人（本组织）
                    ){
                        pName += document.getElementsByName("new_component_"+pName)[indexNO].value;
                        pName += "_Id";
                    }else if(_showtype_=='103'){
                        pVal = "";
                        pName += document.getElementsByName("new_component_"+pName)[indexNO].value;
                        var pObj = document.getElementsByName(pName);
                        var klen = pObj.length;
                        for(var k=0; k< klen; k++){
                            if(pObj[k].checked){
                                pVal = pObj[k].value;
                                break;
                            }
                        }
                    }else if(_showtype_=='104'){
                        pVal = "";
                        pName += document.getElementsByName("new_component_"+pName)[indexNO].value;
                        var pObj = document.getElementsByName(pName);
                        var klen = pObj.length;
                        for(var k=0; k< klen; k++){
                            if(pObj[k].checked){
                                pVal += pObj[k].value + ",";
                            }
                        }
                    }
                }
                if(_showtype_ && (_showtype_=='103'|| _showtype_=='104')){
                    params_url += '&param_field='+encodeURIComponent(pVal);
                }else{
                	//params_url += '&param_field='+encodeURIComponent(document.getElementsByName(pName)[indexNO].options[document.getElementsByName(pName)[indexNO].selectedIndex].text);
                    params_url += '&param_field='+encodeURIComponent(document.getElementsByName(pName)[indexNO].value);
                }
            }
        }
        //alert(params_url);

        $.ajax({
            type: "POST",
            url: whirRootPath + "/platform/custom/ezform/run/relaTrigAjax.jsp?rnd="+(new Date()).getTime(),
            cache: false,
            async: false,
            dataType: 'json',
            data: params_url,
            success: function(ret){
                if(get_field!=''){
                    var dd = ret.data;
                    var gArr = get_field.split(",");
                    for(var i=0; i< gArr.length; i++){    
                        var showType = document.getElementsByName(gArr[i]+'_showtype')[indexNO].value;
                        //mutil
                        if(showType=='105'){//下拉name-name
                            var objSelect = $('select[name='+replaceDollar(gArr[i])+']:eq('+indexNO+')');
                            var styleVal = $(objSelect).attr('class');//.attr('style');
                            objSelect.html('');
                            $("<option value='' selected><%=Resource.getValue(local, "common", "comm.select2")%></option>").appendTo(objSelect);
                            for(var j=0; j< dd.length; j++){
                                var destVal = dd[j][i].value;
                                var _id = dd[j][i].id;
                                if(_id==''){
                                    _id = destVal;
                                }
                                if(destVal!=''){
                                    $("<option value='"+_id+"' >"+destVal+"</option>").appendTo(objSelect);
                                }
                            }
                            $(objSelect).css(styleVal);
                        }else{//single
	                        var destVal ='';
	                        if(code=='404' && dd.length>1){
								for(var j=0; j< dd.length; j++){
									if(document.getElementById(param_field).getAttribute("data-val").indexOf(dd[j][i].value)!=-1){
								    	destVal = dd[j][i].value;
								    }
								}
							}else{
								//单选探出选择字段联动带出了组织id
								if(code=='404'){
									destVal = dd[0][i].value.split(";")[0];
								}else{
									destVal = dd[0][i].value;
								}
							}
                        
                            if(destVal=='null'||destVal=='NULL'){
                                destVal = '';
                            }else{
                                destVal = destVal.replace(/ 00:00:00.0$/, '');
                            }

                            if(showType=='103'){
								var temp_new_component_ = document.getElementsByName('new_component_'+gArr[i])[indexNO].value;
								var temp_field = document.getElementsByName(gArr[i] + temp_new_component_);
                                for(var k=0; k< temp_field.length; k++){
								    temp_field[k].checked = false;
								}
								for(var k=0; k< temp_field.length; k++){
									var chk_val = temp_field[k].value;
									if(chk_val == destVal){
										temp_field[k].checked = true;
										break;
									}
								}
							}else if(showType=='104'){
								var temp_new_component_ = document.getElementsByName('new_component_'+gArr[i])[indexNO].value;
								var temp_field = document.getElementsByName(gArr[i] + temp_new_component_);
								for(var k=0; k< temp_field.length; k++){
								    temp_field[k].checked = false;
								}
								for(var k=0; k< temp_field.length; k++){
									var chk_val = temp_field[k].value;
									if(chk_val == destVal){
										temp_field[k].checked = true;
									}
								}
							}else{
								document.getElementsByName(gArr[i])[indexNO].value = destVal;
							}
                        }
                    }   
                }
            }
        });
		<%
				}else{
					String conditionSql = tpo.getTrigTableCon();//查询语句
            		String dataSource = sourcepo.getDataSource();//数据源
            		String paramValue = "";//条件参数
            		Set fieldSet = tpo.getFieldSet();
                    if(fieldSet!=null && fieldSet.size()>0){
                        Iterator itor1 = fieldSet.iterator();
                        while(itor1.hasNext()){
                            TrigFieldPO fpo = (TrigFieldPO)itor1.next();
                            if("0".equals(fpo.getParamSetFlag())){
                            	String conditionParam = fpo.getFullName();
                            	String formField = fpo.getFormField();
                            	paramValue += formField+",";
                            }
                        }
                    }
                    if(paramValue!=""){
                    	paramValue = paramValue.substring(0,paramValue.length()-1);
                    }
                    int m=0;
                    String param_field = "";//赋值参数
                    if(fieldSet!=null && fieldSet.size()>0){
                        Iterator itor1 = fieldSet.iterator();
                        while(itor1.hasNext()){
                            TrigFieldPO fpo = (TrigFieldPO)itor1.next();
                            if("1".equals(fpo.getParamSetFlag())){
                            	String fullName = fpo.getFullName();
                            	String formField = fpo.getFormField();
                            	param_field += formField+",";
                            	m++;
                            }
                        }
                    }
                    if(param_field!=""){
                    	param_field = param_field.substring(0,param_field.length()-1);
                    }
					%>
					
					  var indexNO = 0;
					  try{
						  var _old_field = document.getElementsByName('<%=oldFieldName%>');
						  var target = window.event?window.event.srcElement:evt.target;
						  if(_old_field.length>1){
							  for(var i=0;i< _old_field.length;i++){
								  if(target.parentNode == _old_field[i].parentElement){//修改三级联动数据显示错误问题
								  //if(target.offsetParent == _old_field[i].parentElement){
									  indexNO = i;
									  break;
								  } 
							  }
						  }
					  }catch(e){}
					  
					  //alert('<%= conditionSql%>');
					  var paramValue = '<%=paramValue %>';
					  //alert(paramValue)
					  var params = paramValue.split(",");
					  var values="";
					  for(var i=0;i< params.length;i++){
					  	  values+=document.getElementsByName(params[i])[indexNO].value+",";
					  }
					  if(values!=""){
					  	  values = values.substring(0,values.length-1);
					  }
					  var cSql = '<%= conditionSql%>';
					  cSql = cSql.replace(/\?/g,"%3F");
					  var sql = "sql="+cSql+"&dataSource="+'<%=dataSource %>'+"&paramValue="+values+"&paramNum="+'<%=m %>';
					  var param_field = '<%=param_field %>';
					  $.ajax({
						 type: "POST",
						 url: whirRootPath + "/platform/custom/ezform/run/relaTrigAjaxOut.jsp?rnd="+(new Date()).getTime(),
						 cache: false,
						 async: false,
						 dataType: 'json',
						 data: sql,
						 success: function(ret){
							 if(param_field!=''){
								 var dd = ret.data;
								 var gArr = param_field.split(",");
								 for(var i=0; i< gArr.length; i++){    
									 var showType = document.getElementsByName(gArr[i]+'_showtype')[indexNO].value;
									 //mutil
									 if(showType=='105'){//下拉name-name
										 var objSelect = $('select[name='+replaceDollar(gArr[i])+']:eq('+indexNO+')');
										 var styleVal = $(objSelect).attr('class');//.attr('style');
										 objSelect.html('');
										 $("<option value='' selected><%=Resource.getValue(local, "common", "comm.select2")%></option>").appendTo(objSelect);
										 for(var j=0; j< dd.length; j++){
											 var destVal = dd[j][i].value;
											 var _id = dd[j][i].id;
											 if(_id==''){
												 _id = destVal;
											 }
											 if(destVal!=''){
												 $("<option value='"+_id+"' >"+destVal+"</option>").appendTo(objSelect);
											 }
										 }
										 $(objSelect).css(styleVal);
									 }else{//single
										var destVal ='';
										if(code=='404' && dd.length>1){
											for(var j=0; j< dd.length; j++){
												if(document.getElementById(param_field).getAttribute("data-val").indexOf(dd[j][i].value)!=-1){
													destVal = dd[j][i].value;
												}
											}
										}else{
											//单选探出选择字段联动带出了组织id
											if(code=='404'){
												destVal = dd[0][i].value.split(";")[0];
											}else{
												destVal = dd[0][i].value;
											}
										}
									 
										 if(destVal=='null'||destVal=='NULL'){
											 destVal = '';
										 }else{
											 destVal = destVal.replace(/ 00:00:00.0$/, '');
										 }

										 if(showType=='103'){
											var temp_new_component_ = document.getElementsByName('new_component_'+gArr[i])[indexNO].value;
											var temp_field = document.getElementsByName(gArr[i] + temp_new_component_);
											 for(var k=0; k< temp_field.length; k++){
												temp_field[k].checked = false;
											}
											for(var k=0; k< temp_field.length; k++){
												var chk_val = temp_field[k].value;
												if(chk_val == destVal){
													temp_field[k].checked = true;
													break;
												}
											}
										}else if(showType=='104'){
											var temp_new_component_ = document.getElementsByName('new_component_'+gArr[i])[indexNO].value;
											var temp_field = document.getElementsByName(gArr[i] + temp_new_component_);
											for(var k=0; k< temp_field.length; k++){
												temp_field[k].checked = false;
											}
											for(var k=0; k< temp_field.length; k++){
												var chk_val = temp_field[k].value;
												if(chk_val == destVal){
													temp_field[k].checked = true;
												}
											}
										}else{
											document.getElementsByName(gArr[i])[indexNO].value = destVal;
										}
									 }
								 }   
							 }
						 }
					   });
					<%
				}
			}
		}
		%>
    }
<%
		}
	}
}
%>
}
//-------------------------------------------------------------
//字段联动-end-
//-------------------------------------------------------------

//-------------------------------------------------------------
//字段关联-start-
//-------------------------------------------------------------
function _setFieldReadonly(fieldName, readonly){
    if(document.getElementById(fieldName)){
        document.getElementById(fieldName).readOnly=readonly;
    }
}

function _getMustFillSpan(fieldName){
    return "<span class='mustFillSpan'><input type=hidden name=mustWrite value='"+fieldName+"'><label class=MustFillColor>*</label></span>";
}

var g_d_oldFieldName = "";
<%
if(settingPO!=null){
Set relaSet = settingPO.getRelaSet();
if(relaSet!=null && relaSet.size()>0){
    Iterator itor = relaSet.iterator();
    while(itor.hasNext()){
        RelaPO rpo = (RelaPO)itor.next();
        Long destFieldId = rpo.getDestFieldId();
        FieldPO dfieldPO = sbd.getFieldPOByFieldId(destFieldId);

        ShowPO d_showPO = dfieldPO.getShowPO();
        String d_showId = d_showPO.getShowId().toString();
        String d_oldFieldName = dfieldPO.getFieldName();
%>
g_d_oldFieldName = '<%=d_oldFieldName%>';
if(document.getElementsByName('new_component_<%=d_oldFieldName%>').length>0){
	g_d_oldFieldName = '<%=d_oldFieldName%>' + document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value + _getFieldNameSuffix('<%=d_showId%>');
}
var mustWrite_old_<%=d_oldFieldName%> = $("input[name='mustWrite'][value='"+g_d_oldFieldName+"']");
<%
    }
}}
%>
//必填字段
var form_field_must_fill = "";
//只读字段
var form_field_readonly = "";

//字段关联触发事件
function relaTrigChange(obj, evt){
	var p_wf_cur_ModifyField = $("#p_wf_cur_ModifyField").val();
	var p_wf_openType = $("#p_wf_openType").val();
	//如果下拉框绑定了计算字段，则先计算
	compute_filed_auto();//主表
	setComputeForeignField();//子表
	//如果下拉框绑定了计算字段，则先计算
    var obj_id = $(obj).attr("id");
    var obj_val = $(obj).val();
    var indexNO = 0;//下标索引
    try{
        var _old_field = document.getElementsByName(obj_id);
        var target = window.event?window.event.srcElement:evt.target;
        if(_old_field.length > 1){
            for(var i=0; i< _old_field.length; i++){
            	if(target.parentNode == _old_field[i].parentElement){
                //if(target.offsetParent == _old_field[i].parentElement){
                    indexNO = i;
                    break;
                }
            }
        }
    }catch(e){}
    //-------------------------------------------------------------
<%
//-------------------------------------------------------------
//字段关联
//-------------------------------------------------------------
if(settingPO!=null){
Set relaSet = settingPO.getRelaSet();
if(relaSet!=null && relaSet.size()>0){
    Iterator itor = relaSet.iterator();
    while(itor.hasNext()){
        RelaPO rpo = (RelaPO)itor.next();
        Long srcFieldId = rpo.getSrcFieldId();
        Long destFieldId = rpo.getDestFieldId();
        String srcFieldVal = rpo.getSrcFieldVal();
        String destFieldOpt = rpo.getDestFieldOpt();
        FieldPO sfieldPO = sbd.getFieldPOByFieldId(srcFieldId);
        FieldPO dfieldPO = sbd.getFieldPOByFieldId(destFieldId);

        String s_oldFieldName = sfieldPO.getFieldName();
        String s_newFieldName = StringUtil.replaceSpecial(sfieldPO.getFieldName(), '$');

        ShowPO d_showPO = dfieldPO.getShowPO();
        String d_showId = d_showPO.getShowId().toString();
        String d_oldFieldName = dfieldPO.getFieldName();
        String d_newFieldName = StringUtil.replaceSpecial(dfieldPO.getFieldName(), '$');
%>
    if(obj_id=='<%=s_oldFieldName%>'){//<%=dfieldPO.getFieldDesName()%>
        var isSubTable = false;
        var subTableTR = null;        
        if($(obj).parent().parent().parent()){
            if($(obj).parent().parent().parent().attr("id")){
                var tr_id = $(obj).parent().parent().parent().attr("id");
                if(tr_id!=null && tr_id.substring(tr_id.length-2)=='TR'){
                    subTableTR = $(obj).parent().parent().parent();
                    isSubTable = true;
                }
            }
        }

        var mustWrite_len = 0;
        var d_showId = '<%=d_showId%>';
        var _d_oldFieldName = '<%=d_oldFieldName%>';
        if(isSubTable){
            $(subTableTR).find("input[name='new_component_<%=d_oldFieldName%>']").each(function(i){
                var _new_component_ = $(this).val();
                _d_oldFieldName = '<%=d_oldFieldName%>' + _new_component_ + _getFieldNameSuffix(d_showId);
                return false;
            });
            mustWrite_len = $(subTableTR).find("input[name='mustWrite'][value='"+_d_oldFieldName+"']").length;
        }else{
            if(document.getElementsByName('new_component_<%=d_oldFieldName%>').length>0){
                _d_oldFieldName = '<%=d_oldFieldName%>' + document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value + _getFieldNameSuffix(d_showId);
            }
            if("115"==d_showId){//附件
				mustWrite_len = $("input[name='mustWrite'][value='"+_d_oldFieldName+"_fileName']").length;
			}else{
				mustWrite_len = $("input[name='mustWrite'][value='"+_d_oldFieldName+"']").length;
			}
        }

        if(form_field_readonly.indexOf(","+_d_oldFieldName+",") == -1){
            if(document.getElementById(_d_oldFieldName) && (document.getElementById(_d_oldFieldName).readOnly || document.getElementById(_d_oldFieldName).disabled)){
                form_field_readonly += "," + _d_oldFieldName + ",";
            }
        }

        var mustWrite_old_len = mustWrite_old_<%=d_oldFieldName%>.length;
        if(mustWrite_old_len==0){
            if(mustWrite_len>0){
                $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO).find("span[class='mustFillSpan']").each(function(){
                    $(this).remove();
                });
            }
        }else{
            if(mustWrite_len==0){
                $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO).append(_getMustFillSpan(_d_oldFieldName));
            }
        }

        if(form_field_readonly.indexOf(","+_d_oldFieldName+",") != -1){
            _setFieldReadonly(_d_oldFieldName, true);
            if( "214"==d_showId || "405"==d_showId){ //20170323  去掉"404"==d_showId  20170510去掉 "212"==d_showId 
                $("div[id$='-<%=d_oldFieldName%>'] > a.openSelectIco").css('display', 'none');
            }else if("103"==d_showId){//单选
                var checkedval = '';
                var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
                divObj.find("input:radio").each(function(){
                    $(this).attr('disabled', true);
                    if($(this).attr('checked') == 'checked'){
                        checkedval += $(this).val();
                    }
                });
                //赋值-》隐藏域
                divObj.find("input[type=hidden][name^='<%=d_oldFieldName%>_rnd_']").val(checkedval);
            }else if("104"==d_showId){//多选
                var checkedval = '';
                var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
                divObj.find("input:checkbox").each(function(){
                    $(this).attr('disabled', true);
                    if($(this).attr('checked') == 'checked'){
                        checkedval += (checkedval==''?'':',') + $(this).val();
                    }
                });
                //赋值-》隐藏域
                divObj.find("input[type=hidden][name^='<%=d_oldFieldName%>_rnd_']").val(checkedval);
            }else if("105"==d_showId){//下拉
                var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
                divObj.find("select[name='<%=d_oldFieldName%>']").attr('disabled', true);
                //赋值-》隐藏域
                divObj.find("input[type=hidden][name='<%=d_oldFieldName%>']").val(divObj.find("select option:selected").val());
            }
        }
    }
<%
    }
}}
%>
    //-------------------------------------------------------------
    //处理
    //-------------------------------------------------------------
<%
//-------------------------------------------------------------
//字段关联
//-------------------------------------------------------------
if(settingPO!=null){
Set relaSet = settingPO.getRelaSet();
if(relaSet!=null && relaSet.size()>0){
    Iterator itor = relaSet.iterator();
    while(itor.hasNext()){
        RelaPO rpo = (RelaPO)itor.next();
        Long srcFieldId = rpo.getSrcFieldId();
        Long destFieldId = rpo.getDestFieldId();
        String srcFieldVal = rpo.getSrcFieldVal();
        String destFieldOpt = rpo.getDestFieldOpt();
        FieldPO sfieldPO = sbd.getFieldPOByFieldId(srcFieldId);
        FieldPO dfieldPO = sbd.getFieldPOByFieldId(destFieldId);

        String s_oldFieldName = sfieldPO.getFieldName();
        String s_newFieldName = StringUtil.replaceSpecial(sfieldPO.getFieldName(), '$');

        ShowPO d_showPO = dfieldPO.getShowPO();
        String d_showId = d_showPO.getShowId().toString();
        String d_oldFieldName = dfieldPO.getFieldName();
        String d_newFieldName = StringUtil.replaceSpecial(dfieldPO.getFieldName(), '$');
%>        
    if(obj_id=='<%=s_oldFieldName%>' && obj_val=='<%=srcFieldVal%>'){//<%=dfieldPO.getFieldDesName()%>
        var isSubTable = false;
        var subTableTR = null;        
        if($(obj).parent().parent().parent()){
            if($(obj).parent().parent().parent().attr("id")){
                var tr_id = $(obj).parent().parent().parent().attr("id");
                if(tr_id!=null && tr_id.substring(tr_id.length-2)=='TR'){
                    subTableTR = $(obj).parent().parent().parent();
                    isSubTable = true;
                }
            }
        }

        var mustWrite_len = 0;
        var d_showId = '<%=d_showId%>';
        var _d_oldFieldName = '<%=d_oldFieldName%>';
        if(isSubTable){            
            $(subTableTR).find("input[name='new_component_<%=d_oldFieldName%>']").each(function(i){
                var _new_component_ = $(this).val();
                _d_oldFieldName = '<%=d_oldFieldName%>' + _new_component_ + _getFieldNameSuffix(d_showId);
                return false;
            });
            mustWrite_len = $(subTableTR).find("input[name='mustWrite'][value='"+_d_oldFieldName+"']").length;
        }else{
            if(document.getElementsByName('new_component_<%=d_oldFieldName%>').length>0){
                _d_oldFieldName = '<%=d_oldFieldName%>' + document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value + _getFieldNameSuffix(d_showId);
            }
            mustWrite_len = $("input[name='mustWrite'][value='"+_d_oldFieldName+"']").length;
        }

        if(document.getElementById(_d_oldFieldName)){
			//20170220 被加上必填项的字段复选框会独享一行，导致表单中字段换行，显示不正常 
            //document.getElementById(_d_oldFieldName).style.width="98%";
        }

        if('0'=='<%=destFieldOpt%>'){//编辑
            if(mustWrite_len>0){
                $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO).find("span[class='mustFillSpan']").each(function(){
                    $(this).remove();
                });
            }
            
        }else if('1'=='<%=destFieldOpt%>'){//必填
            if(mustWrite_len==0){
				$("#p_wf_cur_ModifyField").val(p_wf_cur_ModifyField+"$"+_d_oldFieldName+"$");
				p_wf_cur_ModifyField = $("#p_wf_cur_ModifyField").val();

				if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')>0 || p_wf_openType=="startOpen"){
					if("115"==d_showId){
						$("div[id$='-<%=d_oldFieldName%>']").eq(indexNO).append(_getMustFillSpan(_d_oldFieldName+'_fileName'));
					}else{
						$("div[id$='-<%=d_oldFieldName%>']").eq(indexNO).append(_getMustFillSpan(_d_oldFieldName));
					}
				}
                if(document.getElementById(_d_oldFieldName)){
					//20170220 被加上必填项的字段复选框会独享一行，导致表单中字段换行，显示不正常 
                    //document.getElementById(_d_oldFieldName).style.width="94%";
                }
            }
        }else if('2'=='<%=destFieldOpt%>'){//隐藏
            if(mustWrite_len==0){
                if(document.getElementById(_d_oldFieldName)){
					if("404"!=d_showId && "210"!=d_showId  && "705"!=d_showId && "214"!=d_showId && "211"!=d_showId && "704"!=d_showId){
						document.getElementById(_d_oldFieldName).innerHTML=document.getElementById(_d_oldFieldName).value;
					}
					document.getElementById(_d_oldFieldName).setAttribute("control_display","none");
                    document.getElementById(_d_oldFieldName).style.visibility="hidden";
                }

				if(document.getElementsByName('new_component_<%=d_oldFieldName%>').length>0){
					var rdm = document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value;
					document.getElementById(rdm).setAttribute("control_display","none");
                    document.getElementById(rdm).style.visibility="hidden";
				}

				//20170323添加控制
				if("404"==d_showId){
					 $("div[id$='-<%=d_oldFieldName%>'] > a.openSelectIco").css('display', 'none');
				}

				if("210"==d_showId || "705"==d_showId || "214"==d_showId || "211"==d_showId || "704"==d_showId){
					 $("div[id$='-<%=d_oldFieldName%>'] a").css('display', 'none');
					 $("div[id$='-<%=d_oldFieldName%>'] ul.tagit").css('display', 'none');
					 $("div[id$='-<%=d_oldFieldName%>'] div").css('display', 'none');
				}
				
				if("212"==d_showId){
					 $("div[id$='-<%=d_oldFieldName%>'] > a.openSelectIco").css('display', 'none');
				}
            }
        }

        if("103"==d_showId){
            var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
            divObj.find("input:radio").each(function(){
				if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')!=-1 || p_wf_openType=='startOpen'){
					$(this).removeAttr('disabled');
				}
            });
            //清除隐藏域值
            divObj.find("input[type=hidden][name^='<%=d_oldFieldName%>_rnd_']").val('');
        }else if("104"==d_showId){
            var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
            divObj.find("input:checkbox").each(function(){
				if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')!=-1 || p_wf_openType=='startOpen'){
					$(this).removeAttr('disabled');
				}
            });
            //清除隐藏域值
            divObj.find("input[type=hidden][name^='<%=d_oldFieldName%>_rnd_']").val('');
        }else if("105"==d_showId){//下拉
            var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
			if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')!=-1 || p_wf_openType=='startOpen'){
				divObj.find("select[name='<%=d_oldFieldName%>']").removeAttr('disabled');
			}
            //清除隐藏域值
            divObj.find("input[type=hidden][name='<%=d_oldFieldName%>']").val('');
        }else if( "214"==d_showId || "405"==d_showId){//20170323 去掉 "404"==d_showId 201703510 去掉 "212"==d_showId 
			if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')!=-1 || p_wf_openType=='startOpen'){
				$("div[id$='-<%=d_oldFieldName%>'] > a.openSelectIco").css('display', '');
			}
        }else if("210"==d_showId  || "705"==d_showId || "214"==d_showId || "211"==d_showId || "704"==d_showId){
			var divObj = $("div[id$='-<%=d_oldFieldName%>']").eq(indexNO);
			var _name = '<%=d_oldFieldName%>' + document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value + "_Name";
			var _id = '<%=d_oldFieldName%>' + document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value + "_Id";
			//清除隐藏域值
            divObj.find("input[type=hidden][name='"+_name+"']").val('');
			divObj.find("input[type=hidden][name='"+_id+"']").val('');
		}else if("212"!=d_showId && "214"!=d_showId && "404"!=d_showId && "405"!=d_showId){
        	//var modifyField = $("#p_wf_cur_ModifyField").val();
        	if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')!=-1 || p_wf_openType=='startOpen'){
        		//$("#p_wf_cur_ModifyField").val(modifyField+"$"+_d_oldFieldName+"$");
	            _setFieldReadonly(_d_oldFieldName, false);
        	} 
        }
    }else if(obj_id=='<%=s_oldFieldName%>' && obj_val!='<%=srcFieldVal%>'){
	    var id=$(obj).attr("id");
		var showType = document.getElementsByName(id+'_showtype')[0].value;
		var d_showId = '<%=d_showId%>';
	    var _d_oldFieldName = '<%=d_oldFieldName%>';
		if(document.getElementsByName('new_component_<%=d_oldFieldName%>').length>0){
			_d_oldFieldName = '<%=d_oldFieldName%>' + document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value + _getFieldNameSuffix(d_showId);
		}
		//101 单行文本   102  密码输入   110 多行文本  301金额    406 账号
		if("101"==d_showId||"102"==d_showId||"110"==d_showId||"301"==d_showId||"406"==d_showId){
			//字段关联隐藏需求
			if(!"105"==showType){
				document.getElementById(_d_oldFieldName).value="";
			}
		}
		if(document.getElementById(_d_oldFieldName)){
			if(document.getElementById(_d_oldFieldName).getAttribute("control_display")){
				if("404"!=d_showId && "210"!=d_showId  && "705"!=d_showId && "214"!=d_showId && "211"!=d_showId && "704"!=d_showId){
					if(document.getElementById(_d_oldFieldName).innerHTML!=""){
						document.getElementById(_d_oldFieldName).value=document.getElementById(_d_oldFieldName).innerHTML;
					}else{
						document.getElementById(_d_oldFieldName).value=document.getElementById(_d_oldFieldName).value;
					}
				}
				document.getElementById(_d_oldFieldName).style.visibility="visible";
			}
		}

		if(document.getElementsByName('new_component_<%=d_oldFieldName%>').length>0){
			var rdm = document.getElementsByName('new_component_<%=d_oldFieldName%>')[0].value;
			if(document.getElementById(rdm).getAttribute("control_display")){
				document.getElementById(rdm).style.visibility="visible";
			}
		}

		//20170323添加控制
		if("404"==d_showId){
			 $("div[id$='-<%=d_oldFieldName%>'] > a.openSelectIco").css('display', '');
		}

		if("210"==d_showId  || "705"==d_showId || "214"==d_showId || "211"==d_showId || "704"==d_showId){
			 $("div[id$='-<%=d_oldFieldName%>'] a").css('display', '');
			 $("div[id$='-<%=d_oldFieldName%>'] ul.tagit").css('display', '');
			 $("div[id$='-<%=d_oldFieldName%>'] div").css('display', '');
		}

		if("212"==d_showId){
			if(p_wf_cur_ModifyField.indexOf('<%=d_oldFieldName%>')!=-1 || p_wf_openType=='startOpen'){
				$("div[id$='-<%=d_oldFieldName%>'] > a.openSelectIco").css('display', '');
			}
		}

		//将动态添加的可写字段去除
		var modifyField = $("#p_wf_cur_ModifyField").val().replace("$"+_d_oldFieldName+"$",'');
		$("#p_wf_cur_ModifyField").val(modifyField);
	}
<%
    }
}}
%>
}
//-------------------------------------------------------------
//字段关联-end-
//-------------------------------------------------------------