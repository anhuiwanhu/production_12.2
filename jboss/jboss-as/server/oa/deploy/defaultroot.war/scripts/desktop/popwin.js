$(document).ready(function (){
    setTimeout(function(){popwin();}, 1000);

    

});

//浮动层的初始位置，分别对应层的初始X坐标和Y坐标
var pX = 0, pY = 0;
//判断层的X坐标和Y坐标是否在在控制范围之内，xin为真是层向右移动，否则向左；yin为真是层向下移动，否则向上
var p_xin = true, p_yin = true;
var p_step = 1; //层移动的步长，值越大移动速度越快
var p_delay = 10; //层移动的时间间隔,单位为毫秒，值越小移动速度越快
var p_itl;
function floatPopwin(){
    var obj = document.getElementById("scrollFollowDiv"); //捕获id为ad的层作为漂浮目标

    //层移动范围的左边界(L)和上边界(T)坐标
    var L = 10;
    var T = 10;
    //层移动的右边界
    var R = document.body.clientWidth - obj.offsetWidth - 10;
    //层移动的下边界
    //20170705 -by jqq 解决部分浏览器下body.clientHeight值为0的问题
	//var B = document.body.clientHeight - obj.offsetHeight;
	var B = document.documentElement.clientHeight - obj.offsetHeight;

    //更新层的X坐标，实现X轴方向上的运动；document.body.scrollLeft为文档区域的滚动条向右拉的距离，以保证在滚动条右拉时层仍在可见范围内 
    obj.style.left = (pX + document.body.scrollLeft) + 'px';
    //更新层的Y坐标，实现Y轴方向上的运动；document.body.scrollTop为文档区域的滚动条向下拉的距离，以保证在滚动条下拉时层仍在可见范围内

    obj.style.top = (pY + document.body.scrollTop) + 'px';

    //通过判断层的范围决定层在X轴上的运动方向
    pX = pX + p_step * (p_xin ? 1 : -1);

    //层超出左边界时的处理
    if (pX < L) {
        p_xin = true;
        pX = L;
    }

    //层超出右边界时的处理
    if (pX > R) {
        p_xin = false;
        pX = R;
    }

    //通过判断层的范围决定层在Y轴上的运动方向
    pY = pY + p_step * (p_yin ? 1 : -1);
    //层超出上边界时的处理
    if (pY < T) {
        p_yin = true;
        pY = T;
    }

    //层超出下边界时的处理
    if (pY > B) {
        p_yin = false;
        pY = B;
    }
}

function closeScrollFollowDiv(){
    $('#scrollFollowDiv').hide();
    try{
        clearInterval(p_itl);
    }catch(e){}
}

function popwin(){
    var _top = 240;
    $.ajax({
        type:"post",
        url: whirRootPath+"/Popwin!popwinJson.action?rnd="+Math.random(),
        cache: false,
        async: true,
        dataType: 'html',
        success: function(response) {
            var json = eval("("+response+")");
            if(json.success == 'true'){
                var vWidth = parseInt(json.winWidth, 10);
                var vHeight = parseInt(json.winHeight, 10);
                var winAlign = json.winAlign;
                if(json.winStyle=='0'){//弹出窗口
                    openWin({url:whirRootPath+'/Popwin!popwin.action',isFull:false,width:vWidth,height:vHeight,winName:'popwin'});
                }else{//浮动窗口
                    var popwinHtml = '<div id="scrollFollowDiv" style="top:'+_top+'px;width:'+vWidth+'px;height:'+vHeight+'px;float:'+winAlign+';'+(winAlign=='right'?'position:absolute;right:0px;margin-right:22px;':'')+'">';
                    popwinHtml += '    <div class="content" style="height:'+(vHeight-32)+'px;">';

                    popwinHtml +=      json.winContent;

                    popwinHtml += '    </div>';

                    popwinHtml += '    <div class="tn-close" onclick="closeScrollFollowDiv();">关闭<a href="javascript:void(0);"><i></i></a></div>';

                    popwinHtml += '</div>';
                    $("body").prepend(popwinHtml);

                    if(json.winAutoCloseTime > 0){
                        setTimeout(function(){$('#scrollFollowDiv').hide();}, json.winAutoCloseTime * 1000);
                    }

                    if(json.winStyle!='0'){//浮动窗口
                        if(winAlign == 'random'){//随机飘动
                            var delay = 10; //层移动的时间间隔,单位为毫秒，值越小移动速度越快
                            //每delay秒执行一次floatAD函数
                            p_itl = setInterval("floatPopwin()", p_delay);

                            //层在鼠标移上时清除上面的间隔事件，实现层在的鼠标移上时停止运动的效果 
                            $('#scrollFollowDiv').mousemove(function(e){
                                clearInterval(p_itl);
                            });

                            //层在鼠标移开时开始间隔事件，实现层在的鼠标移开时继续运动的效果
                            $('#scrollFollowDiv').mouseout(function(e){
                                p_itl = setInterval("floatPopwin()", p_delay);
                            });
                        }
                    }
                }
            }
        }
    });
}

