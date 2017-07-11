;
function changePercent(obj,index){
    if(obj.checked){
        document.getElementsByName("fieldPercent")[index].value="1";
    }else{
        document.getElementsByName("fieldPercent")[index].value="";
    }
}

//设置日期默认是否为空
function changeDefSelected(obj,index){
    if(obj.checked){
        document.getElementsByName("defSelected")[index].value="1";
    }else{
        document.getElementsByName("defSelected")[index].value="";
    }
}

//设置附件
function changeAttachment(obj,index){
	if(obj.checked){
        document.getElementsByName("viewAttachment")[index].value="1";
    }else{
        document.getElementsByName("viewAttachment")[index].value="";
    }
}

//设置签名图片
//function setSignPic(obj,index){
//	if(obj.checked){
//        document.getElementsByName("signPic")[index].value="1";
//    }else{
//        document.getElementsByName("signPic")[index].value="";
//    }
//}

//日期时间计算
function changeShowDateWorkday(obj,index){
    if(obj.checked){
        document.getElementsByName("showDateWorkday")[index].value="1";
    }else{
        document.getElementsByName("showDateWorkday")[index].value="0";
    }
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(encodeURI(theURL),winName,features);
}

function openNew(url){
	MM_openBrWindow(url,"","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300") ;
}

function checkOnlyRelationObject(index){
	var relationObj = document.getElementsByName("fieldShow");
	if(relationObj&&relationObj.length>1){
		var cnt=0;
		for(var i=0,len=relationObj.length; i<len; i++){
			var relationVal = relationObj[i].value;
			if(relationVal == '501'){
				cnt++;
			}
			if(cnt>1){
				alert("已经设置了相关对象，请重新选择！");
				return false;
			}
		}
	}
	return true;
}

function checkID(obj, showVal, fieldType){
    if((showVal == '110' && fieldType == '1000003') || showVal == '113' || showVal == '401'){
        $(obj).prop("checked",false);
	    //$(obj).parent().removeClass("checked");
    }
}

function update(index){
	//检查相关性选项-只能设置一个"相关对象"选项
	if(checkOnlyRelationObject()==false){
		document.getElementsByName("fieldShow")[index].value="101";
	}
    
    if(document.getElementsByName("fieldvalue").length==1)index=0;

    var showVal=document.getElementsByName("fieldShow")[index].value;

    //-------------------------------------------------------------------
    $('span[name=fieldvalueSpan]')[index].style.display="";
    document.getElementsByName("fieldvalue")[index].disabled=false;
    document.getElementsByName("fieldvalue")[index].readOnly=false;
    document.getElementsByName("fieldvalue")[index].value="";

    document.getElementsByName("selecttable")[index].style.display="none";
    document.getElementsByName("autoCode")[index].style.display="none";
    document.getElementsByName("setcount")[index].style.display="none";
    document.getElementsByName("expression")[index].style.display="none";
    document.getElementsByName("sigleSelect")[index].style.display="none";
    document.getElementsByName("moreSelect")[index].style.display="none";

    document.getElementsByName("selectSubTable")[index].style.display="none";
    document.getElementsByName("setDefaultValue")[index].style.display="none";
	//document.getElementsByName("setViewAttachment")[index].style.display="none";
	//document.getElementsByName("setSignPic")[index].style.display="none";

    $('span[name=percentSpan]')[index].style.display="none";
    $('span[name=defSelectedSpan]')[index].style.display="none";
    $('span[name=defaultCommentSpan]')[index].style.display="none";
    $('span[name=bugetSelectSpan]')[index].style.display="none";
    $('span[name=span207]')[index].style.display="none";
    $('span[name=objectSelect]')[index].style.display="none";
    $('span[name=showDateSpan]')[index].style.display="none";
    $('span[name=span401]')[index].style.display="none";
    $('span[name=defaultValueSet]')[index].style.display="none";
	$('span[name=setViewAttachment]')[index].style.display="none";
	//$('span[name=setSignPic]')[index].style.display="none";
    document.getElementsByName("bugetSelect")[index].value="";

    if(showVal!='401'){
        document.getElementsByName("defaultComment")[index].value="0";
    }
    //-------------------------------------------------------------------

    switch(showVal){
    case '101':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="";
        break;
    case '102':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '103':
        document.getElementsByName("selecttable")[index].style.display="";
        $('span[name=defaultValueSet]')[index].style.display="";
        break;
    case '104':
        document.getElementsByName("selecttable")[index].style.display="";
        $('span[name=defaultValueSet]')[index].style.display="";
        break;
    case '105':
        document.getElementsByName("selecttable")[index].style.display="";
        $('span[name=defaultValueSet]')[index].style.display="";
        break;
    case '107':
        document.getElementsByName("fieldvalue")[index].value="[yyyy-mm-dd]";
        $('span[name=defSelectedSpan]')[index].style.display="";
        break;
    case '108':
        document.getElementsByName("fieldvalue")[index].value="[hh:nn:ss]";
        $('span[name=defSelectedSpan]')[index].style.display="";
        break;
    case '109':
        document.getElementsByName("fieldvalue")[index].value="[yyyy-mm-dd hh:nn:ss]";
        $('span[name=defSelectedSpan]')[index].style.display="";
        break;
    case '110':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="";
        break;
    case '111':
        document.getElementsByName("fieldvalue")[index].readonly=true;
        document.getElementsByName("autoCode")[index].style.display="";
        break;
    case '112':
        document.getElementsByName("fieldvalue")[index].value="[FileName].[ControlID]";
        break;
    case '113':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="";
        break;
    case '114':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '115':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '116':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="";
		//document.getElementsByName("setViewAttachment")[index].style.display="";
        $('span[name=setViewAttachment]')[index].style.display="";
		break;
    case '117':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="";
		//document.getElementsByName("setViewAttachment")[index].style.display="";
		$('span[name=setViewAttachment]')[index].style.display="";
        break;
    case '118':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
		//document.getElementsByName("setViewAttachment")[index].style.display="";
        $('span[name=setViewAttachment]')[index].style.display="";
		break;
    case '201':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '202':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
		//document.getElementsByName("setSignPic")[index].style.display="";
        //$('span[name=setSignPic]')[index].style.display="";
		break;
    case '203':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setcount")[index].style.display="";
        $('span[name=percentSpan]')[index].style.display="";
        break;
    case '204':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '206':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("selecttable")[index].style.display="";
        break;
    case '207'://登录人部门
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        $('span[name=fieldvalueSpan]')[index].style.display="none";
        $('span[name=span207]')[index].style.display="";
        break;
    case '208':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '209':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '210':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '211':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '212':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '213':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '214':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '215':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
		//document.getElementsByName("setSignPic")[index].style.display="";
        //$('span[name=setSignPic]')[index].style.display="";
		break;
    case '301':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '302':
        $('div[name=amountTrans]')[index].style.display="";
        var ret = ajaxForSync(whirRootPath+'/Show!selectAmountField.action',"index="+index+"&tableId="+$('#tableId').val()+"&date="+new Date());
        $('div[name=amountTrans]')[index].innerHTML=ret;

        $('div[name=commentTrans]')[index].style.display="none";
        $('div[name=commentTrans]')[index].innerHTML='';
        $('div[name=outterTrans]')[index].style.display="none";
        $('div[name=outterTrans]')[index].innerHTML='';
        break;
    case '401':
        $('span[name=fieldvalueSpan]')[index].style.display="none";
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="none";
        $('span[name=defaultCommentSpan]')[index].style.display="";
        $('span[name=span401]')[index].style.display="";
        break;
    case '402':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("selecttable")[index].style.display="";
        break;
    case '403':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("expression")[index].style.display="";
        break;
    case '404':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("sigleSelect")[index].style.display="";
        break;
    case '405':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("moreSelect")[index].style.display="";
        break;
    case '406':
    	document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '501':
        $('span[name=fieldvalueSpan]')[index].style.display="none";
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="none";
        $('span[name=objectSelect]')[index].style.display="";
        break;

    //-------------------------------------------------------------------
    case '601':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '602':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '603':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '604':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '605':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '606':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("selectSubTable")[index].style.display="";
        break;
    case '607':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    //-------------------------------------------------------------------

    case '809':
    case '810':
    case '701':
        $('div[name=commentTrans]')[index].style.display="";
        var ret = ajaxForSync(whirRootPath+'/Show!selectCommentField.action',"index="+index+"&tableId="+$('#tableId').val()+"&date="+new Date());
        $('div[name=commentTrans]')[index].innerHTML=ret;

        $('div[name=amountTrans]')[index].style.display="none";
        $('div[name=amountTrans]')[index].innerHTML='';
        $('div[name=outterTrans]')[index].style.display="none";
        $('div[name=outterTrans]')[index].innerHTML='';
        break;
    case '702':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '703':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '704':
    case '705':
    case '708':
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '706':
        break;
    case '707':
        $('div[name=outterTrans]')[index].style.display="";
        var ret = ajaxForSync(whirRootPath+'/Show!selectOutterInterface.action',"index="+index+"&tableId="+$('#tableId').val()+"&date="+new Date());
        $('div[name=outterTrans]')[index].innerHTML=ret;

        $('div[name=amountTrans]')[index].style.display="none";
        $('div[name=amountTrans]')[index].innerHTML='';
        $('div[name=commentTrans]')[index].style.display="none";
        $('div[name=commentTrans]')[index].innerHTML='';
        break;
    case '801'://用于预算管理
    case '802':
    case '806'://用于项目管理
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '803':
        $('span[name=bugetSelectSpan]')[index].style.display="";
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '804'://用于预算管理
    case '805':
    case '807'://用于项目管理
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    case '808'://用于日期时间计算
        $('span[name=showDateSpan]')[index].style.display="";
        $('span[name=fieldvalueSpan]')[index].style.display="none";
        document.getElementsByName("fieldvalue")[index].value="";
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("setDefaultValue")[index].style.display="none";
        break;
    case '999':
        document.getElementsByName("fieldvalue")[index].readOnly=false;
        break;
    default:
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        break;
    }

    if(showVal!='203'){
        document.getElementsByName("fieldPercent")[index].value="";
    }

    setRemarkShow(index, showVal);
}

var remarkArr = new Array(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,
                        201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,
                        301,302,
                        401,402,403,404,405,406,
                        501,
                        601,602,603,604,605,606,607,
                        701,702,703,704,705,706,707,708,
                        801,802,803,804,805,806,807,808,809,810,999);

function setRemarkShow(index, markIndex) {
    for (var i = 0, len=remarkArr.length; i < len; i++) {
        try {
            $('#remark' + remarkArr[i]).hide();
        } catch (E) {}
    }

    if (markIndex != '0' && markIndex != '') {
        $('#remark' + markIndex).show();
    }

    if (markIndex == '501') {
        $('span[name=objectSelect]')[index].style.display="";
        document.getElementsByName("selecttable")[index].style.display = "none";
        document.getElementsByName("autoCode")[index].style.display = "none";
        document.getElementsByName("setcount")[index].style.display = "none";
        document.getElementsByName("expression")[index].style.display = "none";
        document.getElementsByName("sigleSelect")[index].style.display = "none";
        document.getElementsByName("moreSelect")[index].style.display = "none";
        $('div[name=selectvalDIV]')[index].style.display="none";

        $('div[name=amountTrans]')[index].style.display="none";
        $('div[name=commentTrans]')[index].style.display="none";
        $('div[name=outterTrans]')[index].style.display="none";
    } else if (markIndex == 302) {
        $('span[name=objectSelect]')[index].style.display = "none";
        $('div[name=selectvalDIV]')[index].style.display="none";
    } else if (markIndex == 701 || markIndex == 707 || markIndex == 809 || markIndex == 810) {
        $('span[name=objectSelect]')[index].style.display = "none";
        $('div[name=selectvalDIV]')[index].style.display="none";
    } else {
        $('span[name=objectSelect]')[index].style.display = "none";
        $('div[name=selectvalDIV]')[index].style.display="";

        $('div[name=amountTrans]')[index].style.display="none";
        $('div[name=commentTrans]')[index].style.display="none";
        $('div[name=outterTrans]')[index].style.display="none";
    }
}

function setSelectObj(obj, index){
    document.getElementsByName("fieldvalue")[index].value=obj.value;
}

function initAmount(){
    var len = document.getElementsByName("fieldvalue").length;
    for(var i=0;i<len;i++){
        var showVal=document.getElementsByName("fieldShow")[i].value;
        if(showVal=='302'){
            document.getElementsByName("fieldvalue")[i].disabled=false;
            var val=document.getElementsByName("fieldvalue")[i].value;
            document.getElementsByName("fieldvalue")[i].readOnly=false;
            $('div[name=amountTrans]')[i].style.display="";
            document.getElementsByName("selecttable")[i].style.display="none";
            document.getElementsByName("autoCode")[i].style.display="none";
            document.getElementsByName("setcount")[i].style.display="none";
            document.getElementsByName("expression")[i].style.display="none";
            document.getElementsByName("sigleSelect")[i].style.display="none";
            document.getElementsByName("moreSelect")[i].style.display="none";

            var ret = ajaxForSync(whirRootPath+'/Show!selectAmountField.action',"index="+i+"&tableId="+$('#tableId').val()+"&val="+val+"&date="+new Date());
            $('div[name=amountTrans]')[i].innerHTML=ret;
        }
    }
}

function initComment(){
    var len = document.getElementsByName("fieldvalue").length;
    for(var i=0;i<len;i++){
        var showVal=document.getElementsByName("fieldShow")[i].value;
        if(showVal=='701'){
            document.getElementsByName("fieldvalue")[i].disabled=false;
            var val=document.getElementsByName("fieldvalue")[i].value;
            document.getElementsByName("fieldvalue")[i].readOnly=false;
            $('div[name=commentTrans]')[i].style.display="";
            document.getElementsByName("selecttable")[i].style.display="none";
            document.getElementsByName("autoCode")[i].style.display="none";
            document.getElementsByName("setcount")[i].style.display="none";
            document.getElementsByName("expression")[i].style.display="none";
            document.getElementsByName("sigleSelect")[i].style.display="none";
            document.getElementsByName("moreSelect")[i].style.display="none";

            var ret = ajaxForSync(whirRootPath+'/Show!selectCommentField.action',"index="+i+"&tableId="+$('#tableId').val()+"&val="+val+"&date="+new Date());
            $('div[name=commentTrans]')[i].innerHTML=ret;
        }
    }
}

function initCommentPerson(){
    var len = document.getElementsByName("fieldvalue").length;
    for(var i=0;i<len;i++){
        var showVal=document.getElementsByName("fieldShow")[i].value;
        if(showVal=='809'){
            document.getElementsByName("fieldvalue")[i].disabled=false;
            var val=document.getElementsByName("fieldvalue")[i].value;
            document.getElementsByName("fieldvalue")[i].readOnly=false;
            $('div[name=commentTrans]')[i].style.display="";
            document.getElementsByName("selecttable")[i].style.display="none";
            document.getElementsByName("autoCode")[i].style.display="none";
            document.getElementsByName("setcount")[i].style.display="none";
            document.getElementsByName("expression")[i].style.display="none";
            document.getElementsByName("sigleSelect")[i].style.display="none";
            document.getElementsByName("moreSelect")[i].style.display="none";

            var ret = ajaxForSync(whirRootPath+'/Show!selectCommentField.action',"index="+i+"&tableId="+$('#tableId').val()+"&val="+val+"&date="+new Date());
            $('div[name=commentTrans]')[i].innerHTML=ret;
        }
    }
}

function initCommentPersonSignImg(){
    var len = document.getElementsByName("fieldvalue").length;
    for(var i=0;i<len;i++){
        var showVal=document.getElementsByName("fieldShow")[i].value;
        if(showVal=='810'){
            document.getElementsByName("fieldvalue")[i].disabled=false;
            var val=document.getElementsByName("fieldvalue")[i].value;
            document.getElementsByName("fieldvalue")[i].readOnly=false;
            $('div[name=commentTrans]')[i].style.display="";
            document.getElementsByName("selecttable")[i].style.display="none";
            document.getElementsByName("autoCode")[i].style.display="none";
            document.getElementsByName("setcount")[i].style.display="none";
            document.getElementsByName("expression")[i].style.display="none";
            document.getElementsByName("sigleSelect")[i].style.display="none";
            document.getElementsByName("moreSelect")[i].style.display="none";

            var ret = ajaxForSync(whirRootPath+'/Show!selectCommentField.action',"index="+i+"&tableId="+$('#tableId').val()+"&val="+val+"&date="+new Date());
            $('div[name=commentTrans]')[i].innerHTML=ret;
        }
    }
}

function initOutterDataInterface(){
    var len = document.getElementsByName("fieldvalue").length;
    for(var i=0;i<len;i++){
        var showVal=document.getElementsByName("fieldShow")[i].value;
        if(showVal=='707'){
            document.getElementsByName("fieldvalue")[i].disabled=false;
            var val=document.getElementsByName("fieldvalue")[i].value;
            document.getElementsByName("fieldvalue")[i].readOnly=false;
            $('div[name=outterTrans]')[i].style.display="";
            document.getElementsByName("selecttable")[i].style.display="none";
            document.getElementsByName("autoCode")[i].style.display="none";
            document.getElementsByName("setcount")[i].style.display="none";
            document.getElementsByName("expression")[i].style.display="none";
            document.getElementsByName("sigleSelect")[i].style.display="none";
            document.getElementsByName("moreSelect")[i].style.display="none";

            var ret = ajaxForSync(whirRootPath+'/Show!selectOutterInterface.action',"index="+i+"&tableId="+$('#tableId').val()+"&val="+val+"&date="+new Date());
            $('div[name=outterTrans]')[i].innerHTML=ret;
        }
    }
}

function selectBugetType(obj, index){
    var val = obj.value;
    if(val == '1'){
        document.getElementsByName("setcount")[index].style.display="";
        document.getElementsByName("selectSubTable")[index].style.display="none";
        document.getElementsByName("fieldvalue")[index].disabled=false;
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("fieldvalue")[index].value="";
    }else if(val == '2'){
        document.getElementsByName("setcount")[index].style.display="none";
        document.getElementsByName("selectSubTable")[index].style.display="";
        document.getElementsByName("fieldvalue")[index].disabled=false;
        document.getElementsByName("fieldvalue")[index].readOnly=true;
        document.getElementsByName("fieldvalue")[index].value="";
    }else{
        document.getElementsByName("setcount")[index].style.display="none";
        document.getElementsByName("selectSubTable")[index].style.display="none";
        document.getElementsByName("fieldvalue")[index].disabled=false;
        document.getElementsByName("fieldvalue")[index].readOnly=false;
        document.getElementsByName("fieldvalue")[index].value="";
    }
}

function setInputDefaultValue(fieldId, index){
    popup({id:'DefaultValueWin', content:'url:'+whirRootPath+'/Show!setDefaultValue.action?fieldId='+fieldId+'&index='+index, title:'设置默认值', width:680, height:410, lock:true});
}

function setSelectTable(fieldId, index, val){
    val = document.getElementsByName("fieldvalue")[index].value;
    popup({id:'SelectTableWin', content:'url:'+whirRootPath+'/Show!selectTable.action?fieldId='+fieldId+'&index='+index+'&value='+encodeURIComponent(val), title:'选择表', width:720, height:480, lock:true});
}

function setCountField(fieldName, tableId, index, val){
    val = document.getElementsByName("fieldvalue")[index].value;
    popup({id:'CountFieldWin', content:'url:'+whirRootPath+'/Show!setCountField.action?fieldName='+fieldName+'&tableId='+tableId+'&index='+index+'&value='+encodeURIComponent(val), title:'设置计算字段', width:600, height:400, lock:true});
}

function setAutoCode(fieldId, index, val){
    val = document.getElementsByName("fieldvalue")[index].value;
    popup({id:'AutoCodeWin', content:'url:'+whirRootPath+'/Show!setAutoCode.action?fieldId='+fieldId+'&index='+index+'&value='+encodeURIComponent(val), title:'设置自动编号', width:600, height:410, lock:true});
}

function setExpression(fieldName, tableId, index, val){
    //popup(whirRootPath+'/platform/custom/custom_database/dropdownselect/expression.jsp?fieldname='+fieldName+'&tableid='+tableId+'&index='+index+'&value='+val);
}

function setSelectPopTable(fieldId, index, val, type){
    val = document.getElementsByName("fieldvalue")[index].value;
    popup({id:'SelectPopTableWin', content:'url:'+whirRootPath+'/Show!selectPopTable.action?fieldId='+fieldId+'&index='+index+'&value='+encodeURIComponent(val)+'&selectType='+type, title:'选择表', width:720, height:480, lock:true});
}

function setSelectSubTable(fieldId, index, val, tableId){
    popup({id:'SelectSubTableWin', content:'url:'+whirRootPath+'/Show!selectSubTable.action?fieldId='+fieldId+'&index='+index+'&value='+encodeURIComponent(val)+'&tableId='+tableId, title:'选择合计字段', width:720, height:280, lock:true});
}

function setSelectobject(tableId){
    popup(whirRootPath+'/platform/custom/custom_database/dropdownselect/selectobject.jsp?index='+index+'&tableId='+tableId);
}

var changed = false;
/*$(document).ready(function(){
	setTimeout(initChangeEvent,100);
});*/

function isFormChanged() {
    var isChanged = false;
    var form = document.forms[0];
    for (var i = 0; i < form.elements.length; i++) {
        var element = form.elements[i];
        var type = element.type;
        if (type == "text" || type == "hidden") {
            if (element.value != element.defaultValue) {
                isChanged = true;
                break;
            }
        } else if (type == "radio" || type == "checkbox") {
            if (element.checked != element.defaultChecked) {
                isChanged = true;
                break;
            }
        }
        if (element.tagName == "SELECT") {
            for (var j = 0; j < element.options.length; j++) {
                if (element.options[j].selected != element.options[j].defaultSelected) {
                    isChanged = true;
                    break;
                }
            }
        }

    }
    return isChanged;
}

function initChangeEvent() {
    $("input[type=radio]").each(function () {
        $(this).change(function () {
            this.defaultValue = this.value;
        });
    });
    $("input[type=checkbox]").each(function () {
        $(this).change(function () {
            this.defaultValue = this.value;
        });
    });
    $("select").each(function () {
        for (var j = 0; j < this.options.length; j++) {
            if (this.options[j].selected != this.options[j].defaultSelected) {
                this.options[j].defaultSelected = this.options[j].selected;
            }
        }
    });
}

function isValidNum(obj) {
    var i = 0;
    var len = 0;
    var strTemp = obj.value;
    len = strTemp.length;
    for (i = 0; i < len; i++) {
        var ch = strTemp.charAt(i); //得到指定下标的字符
        if (!(ch >= '0' && ch <= '9')) {
            whir_alert("必须为整数！", null);
            obj.select();
            obj.focus();
            return false;
        }
    }
    return true;
}