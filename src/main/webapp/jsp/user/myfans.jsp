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
<title>我的粉丝</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script src="//static.tfeie.com/v2/js/swiper.min.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>
<body class="bg-eeeeee">

	<section class="txl-main">

		<div id="bd">
			<div class="bd">
				<div class="new-main box-s mar-top-10 pad-0-10" id="DIV_USER_LIST">
					

				</div>
			</div>
		</div>
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
<script src="//static.tfeie.com/js/jquery.harborbuilder.js"></script>
<script type="text/javascript">
	(function($){
		$.MyFansPage = function(data){
			this.settings = $.extend(true,{},$.MyFansPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.MyFansPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this;  
				},
				
				initData: function(){
					this.getMyFans();
				}, 
				
				getMyFans: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../user/getMyFansUsers",
						type: "post", 
						success: function(transport){
							var data =transport.data; 
							_this.renderMyFansList(data); 
						},
						failure: function(transport){ 
							_this.renderMyFansList([]); 
						}
					});
				},
				 
				renderMyFansList: function(data){ 
					data= data?data:[];
					if(data.length==0){
						$("#DIV_USER_LIST").html("还没有任何粉丝哦~"); 
						return;
					}
					var opt=$("#UserListImpl").render(data);
					$("#DIV_USER_LIST").html(opt); 
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
		
		var p = new $.MyFansPage({
		});
		p.init(); 
	});
</script>


<script id="UserListImpl" type="text/x-jsrender"> 
					<div class="itms clearfix" name="DIV_FANS_PROFILE" id="DIV_FANS_PROFILE_{{:userId}}">
						<div class="btn-right">
							<span class="btn-js" name="SPAN_CANCEL_FANS" userId="{{:userId}}">取消</span>
						</div>
						<div class="c">
							<div class="img">
								 <a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}" width="40" height="40"></a>
							</div>
							<div class="name">
								<div class="name-xx">
									<div class="xx">{{:enName}}</div>
									 <div class="yrz"><span class="bg-cen" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font></div>
								</div>
								<div class="jj">{{:employmentInfo}}</div>
							</div>
						</div>
					</div>
</script>
</html>