(function($){
	'use strict';
	$.WeUI = function(){
		this.settings = $.extend(true,{},$.WeUI.defaults);
	}
	
	$.extend($.WeUI,{
		defaults: {
			
		},
	
		prototype: {
			
			confirm: function(options){
				options = options?options:{};
				var dialog =_getWXConfirmDialog(options);
				dialog.show();
			},
			
			closeConfirm: function(){
				$("#_weui_dialog_confirm_").hide();
			},
			
			alert: function(options){ 
				var dialog =_getWXAlertDialog(options);
				dialog.show();
			},
			
			closeAlert: function(){
				$("#_weui_dialog_alert_").hide();
			},
		}
		
	});
	
	var _getWXConfirmDialog=function(options){
		var title = options && options.title?options.title:"提示";
		var content = options && options.content?options.content:"";
		var html = "<div class=\"weui_dialog_confirm\" id=\"_weui_dialog_confirm_\" style=\"display:none\">";
		html+="<div class=\"weui_mask\"></div>";
		html+="<div class=\"weui_dialog\">";
		html+="<div class=\"weui_dialog_hd\"><strong class=\"weui_dialog_title\">"+title+"</strong></div>";
		html+=" <div class=\"weui_dialog_bd\">"+content+"</div>";
		html+="<div class=\"weui_dialog_ft\">";
		html+=" <a href=\"javascript:void(0)\" id=\"_weui_confirm_dialog_cancel\" class=\"weui_btn_dialog default\">取消</a>";
		html+=" <a href=\"javascript:void(0)\" id=\"_weui_confirm_dialog_ok\" class=\"weui_btn_dialog primary\">确定</a>";
		html+="</div>";
		html+="</div>";
		html+="</div>";
		
		var dialog = $("#_weui_dialog_confirm_");
		if(dialog.length==0){
			$(document.body).append(html);
		}else {
			dialog.find(".weui_dialog_title").text(title);
			dialog.find(".weui_dialog_bd").html(content);
		}
		$("#_weui_confirm_dialog_ok").off("click").on("click",function(){
			options.ok && options.ok.call(this);
		});
		$("#_weui_confirm_dialog_cancel").on("click",function(){
			$("#_weui_dialog_confirm_").hide();
			options.cancel && options.cancel.call(this);
		});
		return $("#_weui_dialog_confirm_");
	}
	
	var _getWXAlertDialog=function(options){
		var title = options && options.title?options.title:"提示";
		var content = options && options.content?options.content:"";
		var html = "<div class=\"weui_dialog_alert\" id=\"_weui_dialog_alert_\" style=\"display:none\">";
		html+="<div class=\"weui_mask\"></div>";
		html+="<div class=\"weui_dialog\">";
		html+="<div class=\"weui_dialog_hd\"><strong class=\"weui_dialog_title\">"+title+"</strong></div>";
		html+=" <div class=\"weui_dialog_bd\">"+content+"</div>";
		html+="<div class=\"weui_dialog_ft\">";
		html+=" <a href=\"javascript:void(0)\" id=\"_weui_alert_dialog_ok\" class=\"weui_btn_dialog primary\">确定</a>";
		html+="</div>";
		html+="</div>";
		html+="</div>";
		
		var dialog = $("#_weui_dialog_alert_");
		if(dialog.length==0){
			$(document.body).append(html);
		}else {
			dialog.find(".weui_dialog_title").text(title);
			dialog.find(".weui_dialog_bd").html(content);
		}
		$("#_weui_alert_dialog_ok").off("click").on("click",function(){
			if(options && options.ok){
				options.ok.call(this);
			}else{
				$("#_weui_dialog_alert_").hide();
			}
		}); 
		return $("#_weui_dialog_alert_");
	}
	
})(jQuery);

var weUI = new $.WeUI();