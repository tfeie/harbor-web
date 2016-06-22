(function($){
	'use strict';
	$.HarborBuilder = function(){
		this.settings = $.extend(true,{},$.HarborBuilder.defaults);
	}
	
	$.extend($.HarborBuilder,{
		defaults: {
			
		},
	
		prototype: { 
			
			buildFooter: function(){
				var html = _getFooterHTML();
				$(document.body).append(html);
				_addEvents();
			}
		}
		
	});
	
	var _getFooterHTML= function(){
		var html = "<div class=\"tc-main\">";
		html+="<span class=\"btn-show po-f\"></span>";
		html+="<span class=\"btn-be po-f\"></span>";
		html+="<span class=\"btn-go po-f\"></span>";
		html+="<div class=\"bg-main po-f\"></div>";
		html+="</div>";
		html+="<footer class=\"footer po-f\">";
		html+="<a href=\"javascript:void(0)\"><i class=\"icon-f1\"></i><span>Be</span></a>";
		html+="<a href=\"javascript:void(0)\"><i class=\"icon-f2\"></i><span>Go</span></a>";
		html+="<a href=\"javascript:void(0)\"><i class=\"icon-f3\"></i><span>Frd</span></a>";
		html+="<a href=\"javascript:void(0)\"><i class=\"icon-f4\"><font>6</font></i><span>Msg</span></a>";
		html+="<a href=\"javascript:void(0)\"><i class=\"icon-f5\"></i><span>Me</span></a>";
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
	}
})(jQuery); 
