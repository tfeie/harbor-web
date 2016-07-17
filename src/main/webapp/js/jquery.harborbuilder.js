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
				$(document.body).append(html);
				_addEvents();
			}
		}
		
	});
	
	var _getFooterHTML= function(showBeGoQuick){
		var html="";
		if(showBeGoQuick=="show"){
			html+= "<div class=\"tc-main\">";
			html+="<span class=\"btn-show po-f\"></span>";
			html+="<span class=\"btn-be po-f\" id=\"_btn_goto_be\"></span>";
			html+="<span class=\"btn-go po-f\" id=\"_btn_goto_go\"></span>";
			html+="<div class=\"bg-main po-f\"></div>";
			html+="</div>";
		}
		html+="<footer class=\"footer po-f\">";
		html+="<a href=\"../be/index.html\"><i class=\"icon-f1\"></i><span>Be</span></a>";
		html+="<a href=\"../go/goindex.html\"><i class=\"icon-f2\"></i><span>Go</span></a>";
		html+="<a href=\"../user/myhaiyou.html\"><i class=\"icon-f3\"></i><span>Frd</span></a>";
		html+="<a href=\"../user/messagecenter.html\"><i class=\"icon-f4\" id=\"_FOOTER_MSG_COUNT\"></i><span id=\"_FOOTER_MSG\">Msg</span></a>";
		html+="<a href=\"../user/userCenter.html\"><i class=\"icon-f5\"></i><span>Me</span></a>";
		html+="</footer>";
		return html;
	} 
	
	var _addEvents = function(){
		$('.btn-show').tap(function() {
			if ($(this).parent('.tc-main').attr('class') == 'tc-main'
					|| $(this).parent('.tc-main').attr('class') == 'tc-main on1') {
				$(this).parent('.tc-main').removeClass('on1');
				$(this).parent('.tc-main').addClass('on');
				$(this).parent('.tc-main').children('.bg-main').fadeIn();

			} else {
				$(this).parent('.tc-main').removeClass('on');
				$(this).parent('.tc-main').addClass('on1');
				$(this).parent('.tc-main').children('.bg-main').fadeOut();
			}
		});
		
		$("#_btn_goto_go").off("click").on("click",function(){
			window.location.href="../go/publishGo.html";
		});
		
		$("#_btn_goto_be").off("click").on("click",function(){
			window.location.href="../be/publishbe.html";
		});
		
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
	}
})(jQuery); 
