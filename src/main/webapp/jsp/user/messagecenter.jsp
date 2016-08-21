<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta content="telephone=no" name="format-detection" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="#035c9b">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title>消息中心</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
</head>
<body style="background:#ffffff">

	<section class="wdgz-main" id="DIV_MY_NOTIFY">

	</section>


</body>

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
<script type="text/javascript">
	(function($){
		$.MessageCenterPage = function(data){
			this.settings = $.extend(true,{},$.MessageCenterPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.MessageCenterPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this; 
					//删除消息按钮事件
					$("#DIV_MY_NOTIFY").delegate("[name='DEL_NOTIFY']","click",function(){
						 var notifyId = $(this).attr("notifyId");
						 _this.delNotify(notifyId);
					}); 
					
				},
				
				initData: function(){
					this.getMessages();
				}, 
				
				delNotify: function(notifyId){
					var _this = this;
					ajaxController.ajax({
						url: "../notify/deleteUserNotify",
						type: "post",
						data: {
							notifyId:notifyId
						},
						success: function(transport){
							var dom=$("#DIV_NOTIFY_"+notifyId);
							dom.fadeOut("200",function(){
								dom.detach();
								var len = $("[name='DIV_NOTIFY']").length;
								if(len==0){
									var opt="<div class=\"itms clearfix\" style=\"text-align:center;\">没有任何消息哦~</div>";
									$("#DIV_MY_NOTIFY").append(opt); 
								}
							});
						},
						failure: function(transport){ 
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 500);
						}
					});
				},
				
				getMessages: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../notify/getUnreadNotifies",
						type: "post",  
						success: function(transport){
							var data =transport.data; 
							_this.renderNotifyList(data); 
						},
						failure: function(transport){ 
							_this.renderNotifyList([]); 
						}
					});
				},
				 
				renderNotifyList: function(data){ 
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#MyNotifyListImpl").render(data);
					}else{
						opt="<div class=\"itms clearfix\" style=\"text-align:center;\">没有任何消息哦~</div>";
					}
					$("#DIV_MY_NOTIFY").html(opt); 
				},
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var b = new $.HarborBuilder();
		b.buildFooter();
		
		var p = new $.MessageCenterPage({ 
		});
		p.init();
		
		
	});
</script>


<script id="MyNotifyListImpl" type="text/x-jsrender"> 
		<div class="itms clearfix" name="DIV_NOTIFY" id="DIV_NOTIFY_{{:notifyId}}">
			<div class="img">
				{{if senderId=='hy00000000'}}
				<a href="javascript:void(0)"><img src="//static.tfeie.com/v2/images/tx.png"
					width="50" height="50"></a>
				{{else}}
				<a href="../user/userInfo.html?userId={{:senderId}}"><img src="{{:wxHeadimg}}"
					width="50" height="50"></a>
				{{/if}}
			</div>
			<div class="r">
				<div class="time"><a href="{{if haslink==true}}{{:link}}{{else}}javascript:void(0){{/if}}">{{:timeInterval}}</a></div>
				<div class="c">
					<a href="{{if haslink==true}}{{:link}}{{else}}javascript:void(0){{/if}}">
						{{if accepterType=='system'}}
							<div class="name">{{:title}}</div>
						{{else}}
							<div class="name">{{:enName}}<span class="bg-lv" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</span><font {{if userStatus=='20'}}color="#FFB90F"{{/if}}   
>{{:userStatusName}}</font></div>
						{{/if}}
						
						<div class="xx"><a href="{{if haslink==true}}{{:link}}{{else}}javascript:void(0){{/if}}">{{:content}}</a> </div>
					</a>
				</div>
			</div>
			<div class="icon-gb" name="DEL_NOTIFY" notifyId="{{:notifyId}}"></div>
		</div>
</script>
</html>