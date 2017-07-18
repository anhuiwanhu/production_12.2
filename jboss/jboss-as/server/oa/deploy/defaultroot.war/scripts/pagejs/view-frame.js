$(function(){

    //点击门户下拉菜单 
    /*点击门户展开时延时出现滚动条0.2s*/
    $("#gway-switch-btn .fa-gateway").astatus({
        delay:300,
        adddom:'#gway-switch-con'
    },function(){
        var $thisparent = $('#gway-switch-btn')
        if($thisparent.hasClass("open")){
            $thisparent.removeClass("open");
            return false; 
        }
        $thisparent.addClass("open");
    });
    /*离开父容器后下拉消失*/
    $("#gway-switch-btn").mouseleave(function(){
        $(this).removeClass("open");
    })

    /*门户中的子项目选中状态事件*/
    $('#gway-switch-con').find("a").click(function () {
        $(this).addClass("current").siblings().removeClass("current");
        return false;
    });
    
    /* 点击自定义菜单按钮显示下拉菜单 */ 

    $("#c-nav-drop").click(function(){
        var dropparent = $("#c-nav-parent");
        if(dropparent.hasClass("open")){
            dropparent.removeClass("open");
            return false; 
        }
        dropparent.addClass("open");
    });

    /*点击显示自定义菜单编辑*/ 
    $("#cnav-edit-btn").click(function(){
        $('#cnav-show-con').removeClass('visible');
        $('#cnav-edit-con').addClass('visible');
        return false;
    });

    /*点击返回显示自定义菜单*/
    $("#cnav-back-btn").click(function(){        
        $('#cnav-show-con').addClass('visible');
         $('#cnav-edit-con').removeClass('visible');
        return false;
    });

    /* 离开整个容器后下拉消失 */
    $("#c-nav-parent").mouseleave(function(){
        $(this).removeClass("open");
    })

    /*编辑自定义菜单 hover 交互效果*/
    $('.wh-hd-menu-add li').hover(function(){
        $(this).addClass("active");
    },function(){
        $(this).removeClass("active");
    })
    
    //换肤操作
    // var returnColor = $('#switch-skin-list p.current').data("color");
    // $('#switch-skin-list p').on('click', function () {
    //     var $this = $(this);
    //     var index = $this.index();
    //     var skinColor = $this.data("color");
    //     $this.addClass('current').siblings().removeClass('current');           
    //     $("#switch-skin-img").removeClass().addClass("wh-skin-model-img wh-skin-"+skinColor);
    //     returnColor = $this.data("color");
    // });

    // //换肤弹框关闭后回调
    // $('#switch-skin').on('hidden.bs.modal', function (e) {
    //     $('body').removeClass (function (index, css) {
    //         return (css.match (/\btheme-\S+/g) || []).join(' ');
    //     }).addClass('theme-'+returnColor);
    // })

    //换肤hover效果
    $('.wh-sys-setting-skin-change').click(function(){
        var wh_hd_skin_dialog = $.dialog({
            title: '界面主题',
            content: "url:skin.html",
            width: 660,
            height: 260,
            min:false,
            max:false,
        })
    });

    //切换字体大小
    var sizeChange = $('#switch-font-size em');
    var sizeStatus = "";
    sizeChange.on('click', function(){
        sizeChange.addClass('noselect');
        $(this).removeClass('noselect');
        sizeStatus = $(this).data('fsize');
        $('html').removeClass (function (index, css) {
            return (css.match (/\bsize-\S+/g) || []).join(' ');
        }).addClass('size-'+sizeStatus);
    })

    //提醒事项内部切换
    // $('#notice-edit-btn').on('click',function () {
    //     $('#notice-set-con').hide();
    //     $("#notice-edit-con").toggle();
    // });
    // $('#notice-back-btn').on('click',function () {
    //     $("#notice-edit-con").hide();
    //     $('#notice-set-con').show();
    // });

    //提醒
    $(".wh-sys-sdc").click(function(){
        var wh_hd_tips_dialog =  $.dialog({
            title: '提醒事项',
            content: $(".wh-sys-setting-dialog").html(),
            width: 442,
            height: 270,
            max: false,
            min: false,
        });
        $(".edit-notice").click(function () {
            $('.wh-sys-notice-list-setting').hide();
            $(".wh-sys-notice-list-setting-edit").toggle();
        });
        $('.setting-tips-to-close').click(function () {
            $(".wh-sys-notice-list-setting-edit").hide();
            $('.wh-sys-notice-list-setting').show();
        })
    });

    //左侧菜单切换
    $('#switch-l-nav').astatus({delay:300},function(){
        $('.wh-content').toggleClass('close-l-nav');
    });

    //右侧菜单常规HOVER交互
    $(".wh-hd-r-nav li:has(.wh-hd-box-shadow)").hover(function(){
        $(this).children('.wh-hd-box-shadow').addClass('open');
    },function(){
        $(this).children('.wh-hd-box-shadow').removeClass('open');
    });

    //右侧菜单 搜索 展开搜索分类交互
    // var wh_hd_usl = $('.wh-hd-user-search-list');
    // $(".wh-hd-search-info").click(function(){
    //     $(this).children(".fa").toggleClass("fa-angle-down");
    //     wh_hd_usl.slideToggle(300);
    // });

    //个人资料交互
    var wh_hd_state = $(".wh-hd-state");
    var info2show = $('.wh-hd-user-info2show');
    info2show.click(function(){
        var index = info2show.index(this);
        info2show.not(this).find('i').removeClass("fa-angle-down");
        $(this).find("i").toggleClass("fa-angle-down");
        wh_hd_state.eq(index).slideToggle(300).siblings(".wh-hd-state").hide();
    });

    //点击个人中心出现的详细信息中的选项 添加样式
    $(".wh-hd-state").find("a").click(function () {
        $(this).addClass("current").siblings().removeClass("current");
        return false;
    });

    //个人中心切换
    var wh_hd_statecon = $(".wh-hd-statecontainer");
    var wh_clickshow= $('.wh-hd-user-faclick');
    wh_clickshow.click(function(){
        var $this = $(this);
        var index = wh_clickshow.index($this); 
        if($this.hasClass("active")){
            $this.removeClass("active"); 
            wh_hd_statecon.eq(index).removeClass("current");
        }else{
            $this.addClass("active").siblings().removeClass("active");
            wh_hd_statecon.removeClass("current");
            wh_hd_statecon.eq(index).addClass("current"); 
        } 
    });

    //信息搜索下拉菜单
    var searchbox = $(".wh-hd-search-box");
    $(".wh-hd-search-info .fa-angle-right").click(function() {
        if(searchbox.hasClass("open")){
            searchbox.removeClass("open"); 
        }else{
            searchbox.addClass("open");
        } 
    })
    //自定义popover显示的内容
    //颜色标识选择
    /*$('.c-chose-item').popover({ 
        html : true,
        title: function() {
         return $("#popover-head").html();
        },
        content: function() {
         return $("#pop-c-chose").html();
        }
    });*/
    //列表操作下拉
    /*$('.s-edit-item').popover({ 
        html : true,
        title: function() {
         return $("#popover-head").html();
        },
        content: function() {
         return $("#pop-s-edit").html();
        }
    });*/

    //组件类
    //选择多个人物
    /*$('[data-select="multiple-select"]').chosen({
      "width":"100%",
      "disable_search_threshold":10,
      "allow_single_deselect":true,
      "placeholder_text_multiple":"\u8bf7\u9009\u62e9\u51e0\u9879",
      "placeholder_text_single":"\u8bf7\u9009\u62e9\u4e00\u9879",
      "no_results_text":"\u6ca1\u6709\u543b\u5408\u7684\u7ed3\u679c"
    });*/

    //简单Select组件
    /*$('[data-select="simple-select"]').selectpicker({
      size: 4,
      actionsBox: true
    });*/



    //设置日期
    /*$('[data-type="datapicker"]').datetimepicker({
      format: 'yyyy-mm-dd hh:ii',
      autoclose: true,
      todayBtn: true,
      language: "zh-CN"
    });*/

    //弹出新建任务 设置日期
    /*$('[data-type="datepicker-modal"]').datetimepicker({
      container: '.modal',
      format: 'yyyy-mm-dd hh:ii',
      autoclose: true,
      todayBtn: true,
      language: "zh-CN"
    });*/

 
})

//Ztree相关演示代码
function setFontCss(treeId, treeNode) {
    return treeNode.level == 0 ? {
        color: "#ff6600"
    } : {};
};

var setting = {
    view: {
        selectedMulti: false,
        fontCss: setFontCss,            
        dblClickExpand: false
    },
    check: {
        enable: false
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    edit: {
        enable: false
    },
    callback: {
        onClick: onClick
    }
};

var setting2 = {
    view: {
        selectedMulti: false,
        fontCss: setFontCss,            
        dblClickExpand: false
    },
    check: {
        enable: false
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    edit: {
        enable: false
    },
    callback: {
        onClick: onClick2
    }
};


var zNodes = [{
    id: 1,
    pId: 0,
    name: "所有信息",
    open: true,
    iconSkin: "fa fa"
}, {
    id: 11,
    pId: 1,
    name: "系统设置系",
    iconSkin: "fa fa"
}, {
    id: 111,
    pId: 11,
    name: "终极节",
    iconSkin: "fa fa"
}, {
    id: 3,
    pId: 0,
    name: "我的发布",
    iconSkin: "fa fa"
}, {
    id: 12,
    pId: 1,
    name: "界面设置",
    iconSkin: "fa fa"
}, {
    id: 122,
    pId: 12,
    name: "基本设置",
    iconSkin: "fa fa"
}, {
    id: 122,
    pId: 12,
    name: "登陆页登陆页设置登陆页设置登陆页设置设置置设置置设置",
    iconSkin: "fa fa"
}, {
    id: 12221,
    pId: 12222,
    name: "我的发布ww",
    iconSkin: "fa fa"
}, {
    id: 12222,
    pId: 122,
    name: "我的发布",
    iconSkin: "fa fa"
}, {
    id: 12223,
    pId: 122,
    name: "子基本设",
    iconSkin: "fa fa"
}, {
    id: 123,
    pId: 12,
    name: "弹窗设置",
    iconSkin: "fa fa"
}, {
    id: 13,
    pId: 1,
    name: "基础数据置",
    iconSkin: "fa fa"
}, {
    id: 2,
    pId: 0,
    name: "精华信息",
    iconSkin: "fa fa"
}, {
    id: 3,
    pId: 0,
    name: "我的发布",
    iconSkin: "fa fa"
}, {
    id: 2,
    pId: 0,
    name: "所有信息",
    iconSkin: "fa fa"
}];

$(document).ready(function() {
    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
});

$(document).ready(function() {
    $.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
});

 
var newCount = 1;

function onClick(e,treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    zTree.expandNode(treeNode);
}

function onClick2(e,treeId, treeNode) {
    var zTree2 = $.fn.zTree.getZTreeObj("treeDemo2");
    zTree2.expandNode(treeNode);
}

function addHoverDom(treeId, treeNode) {
    var sObj = $("#" + treeNode.tId + "_span");
    if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
    var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='add node' onfocus='this.blur();'></span>";
    sObj.after(addStr);
    var btn = $("#addBtn_" + treeNode.tId);
    if (btn) btn.bind("click", function() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.addNodes(treeNode, {
            id: (100 + newCount),
            pId: treeNode.id,
            name: "new node" + (newCount++)
        });
        return false;
    });
};

function addHoverDom(treeId, treeNode) {
    var sObj = $("#" + treeNode.tId + "_span");
    if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
    var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='add node' onfocus='this.blur();'></span>";
    sObj.after(addStr);
    var btn = $("#addBtn_" + treeNode.tId);
    if (btn) btn.bind("click", function() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        zTree.addNodes(treeNode, {
            id: (100 + newCount),
            pId: treeNode.id,
            name: "new node" + (newCount++)
        });
        return false;
    });
};

function removeHoverDom(treeId, treeNode) {
    $("#addBtn_" + treeNode.tId).unbind().remove();
};


     
     

          if($(".ztree>li").children().hasClass(".curSelectedNode")){
          $(this).addClass("ss");
       }