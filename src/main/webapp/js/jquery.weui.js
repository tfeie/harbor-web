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
			
			showXToast: function(title){
				var t= _getWXXToast();
				t.show();
			},
			
			hideXToast: function(){
				$("#weui_x_toast").hide();
			},
			
			showLoadingToast: function(title){
				var t= _getWXLoadingToast(title);
				t.show();
			},
			
			hideLoadingToast: function(){
				$("#weui_loading_toast").hide();
			}
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
	
	var _getWXXToast= function(title){
		var html="<div id=\"weui_x_toast\" style=\"display: none;\">";
		html+="<div class=\"weui_mask_transparent\"></div>";
		html+="<div class=\"weui_toast\">";
		html+="<i class=\"weui_icon_toast\"></i>";
		html+="<p class=\"weui_toast_content\">"+title+"</p>";
		html+="</div>";
		html+="</div>";
		var toast = $("#weui_x_toast");
		if(toast.length==0){
			$(document.body).append(html);
		}else{
			toast.find(".weui_toast_content").html(title);
		}
		return $("#weui_x_toast");
	}
	
	var _getWXLoadingToast= function(title){
		title="加载中";
		var html="<div id=\"weui_loading_toast\" class=\"weui_loading_toast\" style=\"display: none;\">";
		html+="<div class=\"weui_mask_transparent\"></div>";
		html+="<div class=\"weui_toast\">";
		html+="<div class=\"weui_loading\">";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_0\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_1\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_2\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_3\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_4\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_5\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_6\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_7\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_8\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_9\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_10\"></div>";
		html+="<div class=\"weui_loading_leaf weui_loading_leaf_11\"></div>";
		html+="</div>";
		html+="<p class=\"weui_toast_content\">"+title+"</p>";
		html+="</div>";
		html+="</div>";
		var toast = $("#weui_loading_toast");
		if(toast.length==0){
			$(document.body).append(html);
		}else{
			toast.find(".weui_toast_content").html(title);
		}
		return $("#weui_loading_toast");
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