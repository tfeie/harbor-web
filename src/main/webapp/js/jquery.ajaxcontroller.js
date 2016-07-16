(function($){
	$.AjaxController = function(){
		this.settings = $.extend(true,{},$.AjaxController.defaults);
	}
	$.extend($.AjaxController,{
		defaults: {
			AJAX_STATUS_SUCCESS: "1",
			AJAX_STATUS_FAILURE: "0",
			STATUS_CODE: "statusCode",
			STATUS_INFO: "statusInfo",
			BusiErrorURLs: [{
				errorCode: "haibei_not_enough",
				url: "../user/buyhaibei.html"
			},{
				errorCode: "user_unregister",
				url: "../user/toUserRegister.html"
			},{
				errorCode: "user_unauthoried",
				url: "../user/toApplyCertficate.html"
			},{
				errorCode: "user_not_member",
				url: "../user/memberCenter.html"
			}]
		},
	
		prototype: {
			ajax: function(options){
				var _this = this; 
				var callbacks = {}; 
				if(typeof options.success=='function'){
					callbacks["success"] = options.success;
					delete options.success;
				}
				if(typeof options.failure=='function'){
					callbacks["failure"] = options.failure;
					delete options.failure;
				}
				if(typeof options.error=='function'){
					callbacks["error"] = options.error;
					delete options.error;
				}
				var settings = {}; $.extend(settings,options); 
				settings["success"] = function(transport){  
					var status = transport[_this.settings.STATUS_CODE];
					var statusInfo = transport[_this.settings.STATUS_INFO];
					if(status && status == _this.settings.AJAX_STATUS_FAILURE){
						callbacks["failure"] && callbacks["failure"].call(this,transport);   
					} else{ 
						callbacks["success"] && callbacks["success"].call(this,transport);
					} 
				};
				var q="ajax_req_random="+new Date().getTime();
				settings.url += (settings.url.indexOf('?') >= 0 ? '&' : '?') + q;
				$.ajax(settings); 
			},
			
			getErrorURL: function(errorCode){
				var _this = this;
				var arr=$.grep(_this.settings.BusiErrorURLs,function(o,indx){
					return o.errorCode==errorCode;
				});
				return arr.length>0?arr[0]:false;
			},
			doCommonFail: function(transport){
				var _this = this;
				var statusCode = transport.statusCode;
				var o =_this.getErrorURL(statusCode);
				
				weUI.alert({content:transport.statusInfo,ok:function(){
					if(statusCode=="haibei_not_enough"){
						window.location.href="../user/buyhaibei.html";
					}
					if(statusCode=="user_unregister"){
						window.location.href="../user/toUserRegister.html";
					}
					if(statusCode=="user_unauthoried"){
						window.location.href="../user/toApplyCertficate.html";
					}
					if(statusCode=="user_not_member"){
						window.location.href="../user/memberCenter.html";
					}
					weUI.closeAlert();
				}});
				return ;
			}
		}
		
	});
		
})(jQuery);

var ajaxController = new $.AjaxController();