$(function(){
	$("input[type='text']").not(".no").each(function(){
		$(this).placeholder();
	});
	$(".tabs").each(function(){
		$(this).tabs();
	});
	resize();
	$(window).resize(function(event) {
		resize();
	});




$(".footer ul li").hover(function () {
if($(this).hasClass("on")){}
                            else{
        var src = $(this).find("img").attr("src");
        if(src!=null)
        $(this).find("img").attr("src", src.split(".png")[0] + "-1.png");
}
    }, function () {
if($(this).hasClass("on")){}
                            else{
        var src = $(this).find("img").attr("src");
        if(src!=null)
        $(this).find("img").attr("src", src.split("-1.png")[0] + ".png");
}
    })
    var src_on = $(".footer ul li.on a img").attr("src");
    if (src_on != null)
        $(".footer ul li.on a img").attr("src", src_on.split(".png")[0] + "-1.png")



$(".sec_menu").click(function(){
$(".mask").fadeToggle();
$(this).toggleClass("on")

})


$(".div_six span i").click(function(){
	$(this).parents(".div_six").find("i").removeClass("on")
	$(this).addClass("on")
})

//会员中心
$(".sec_item .item label a").click(function(){
    $(this).parent("label").find("a").removeClass("on");
    $(this).addClass("on")
})


//编辑个人中心


$(".det p img").click(function(){
	$(this).parents("li").find(".xinqi_1").hide()
})

$(".info_sex p span").click(function(){
	$(this).parents("p").find("span").removeClass("on")
	$(this).addClass("on")
})










$(".yuejian-bott p").click(function(){
	$(this).parents(".yuejian-bott").find("p").removeClass("on")
	$(this).addClass("on")
})






});

/*main*/
//

/*call*/
//
function resize(){
	var ht=$(window).height();
	$("body").height(ht);
}
$.fn.placeholder = function () {
    var $obj = this;
    var v = $(this).val();
    $obj.focus(function (event) {
        if ($obj.val() == v) {
            $obj.val("");
        }
    });
    $obj.blur(function (event) {
        if ($obj.val() == "") {
            $obj.val(v);
        }
    });
}
$.fn.tabs = function () {
    var $obj = this;
    var $tabs = $obj.find(".ts >.t");
    var $cnts = $obj.find(".cs >.c");

    $tabs.click(function (event) {
        var i = $tabs.index(this);
        $cnts.hide();
        $cnts.eq(i).show();

        $tabs.removeClass('on');
        $(this).addClass('on');

        return false;
    });
    $tabs.first().click();
}