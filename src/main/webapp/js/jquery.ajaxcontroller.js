(function($){
	$.AjaxController = function(){
		this.settings = $.extend(true,{},$.AjaxController.defaults);
	}
	$.extend($.AjaxController,{
		defaults: {
			AJAX_STATUS_SUCCESS: "1",
			AJAX_STATUS_FAILURE: "0",
			STATUS_CODE: "statusCode",
			STATUS_INFO: "statusInfo"
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
			}
		}
		
	});
		
})(jQuery);

var ajaxController = new $.AjaxController();