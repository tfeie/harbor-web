(function($){
	'use strict';
	$.HarborBuilder = function(){
		this.settings = $.extend(true,{},$.HarborBuilder.defaults);
	}
	
	$.extend($.HarborBuilder,{
		defaults: {
			
		},
	
		prototype: { 
			
			buildFooter: function(options){
				options = options?options:{};
				var html = _getFooterHTML(options.showBeGoQuick?options.showBeGoQuick:"show");
					//alert(html);
				$(document.body).append(html);
				_addEvents();
			}
		}
		
	});
	
	var _getFooterHTML= function(showBeGoQuick){
		var html="";
		html+="<footer class=\"footer po-f\">";
		html+="<a href=\"../be/index.html\"><i class=\"icon-f1\"></i><span>Be</span></a>";
		html+="<a href=\"../go/goindex.html\"><i class=\"icon-f2\"></i><span>Go</span></a>";
		html+="<a href=\"../user/myhaiyou.html\" id=\"_btn_goto_frd_\"><i class=\"icon-f3\"></i><span>Frd</span></a>";
		html+="<a href=\"../user/messagecenter.html\"><i class=\"icon-f4\" id=\"_FOOTER_MSG_COUNT\"></i><span id=\"_FOOTER_MSG\">Msg</span></a>";
		html+="<a href=\"../user/userCenter.html\"><i class=\"icon-f5\"></i><span>Me</span></a>";
		html+="</footer>";
		if(showBeGoQuick=="show"){
			html+= "<div class=\"mask\"></div>";
			html+="<section class=\"sec_menu\">";
			html+="<div class=\"wrap\">";
			html+="<span class=\"span1\"><a><img src=\"//static.tfeie.com/images/circle.png\" /></a></span>";
			html+="<span class=\"span2\"><a href=\"../be/publishbe.html\"><img src=\"//static.tfeie.com/images/be.png\" /></a></span>";
			html+="<span class=\"span3\"><a href=\"../go/publishGo.html\"><img src=\"//static.tfeie.com/images/go.png\" /></a></span>";
			html+="</div>";
			html+="</section>";
		}
		return html;
	} 
	
	var _addEvents = function(){		
		if (!!window.EventSource) {
			var source = new EventSource("../user/listenerUserNotify");
			source.addEventListener('message', function(e) {
				var count = e.data;
				if(count>0){
					$("#_FOOTER_MSG_COUNT").html("<font>"+count+"</font>");
				}else{
					$("#_FOOTER_MSG_COUNT").html("");
				}
				
			});
		}
		
		$(".sec_menu").off("click").on("click",function(){
			$(".mask").fadeToggle();
			$(this).toggleClass("on")

		});
	}
})(jQuery); 
