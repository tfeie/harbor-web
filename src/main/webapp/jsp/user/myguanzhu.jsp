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
<title>我关注的海友</title>
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
					//取消关注事件代理
					$("#DIV_USER_LIST").delegate("[name='SPAN_CANCEL_FANS']","click",function(){
						var fansUserId = $(this).attr("userId");
						_this.cancelFans(fansUserId);
					});
				},
				
				initData: function(){
					this.getMyFans();
				}, 
				
				cancelFans: function(fansUserId){
					var _this = this;
					ajaxController.ajax({
						url: "../user/cancelFans",
						type: "post", 
						data: {
							fansUserId: fansUserId
						},
						success: function(transport){
							$("#DIV_FANS_PROFILE_"+fansUserId).remove();
							if($("name=['DIV_FANS_PROFILE']").length==0){
								$("#DIV_USER_LIST").html("还没有任何关注的海友哦~"); 
							}
						},
						failure: function(transport){ 
							weUI.alert({content:transport.statusInfo})
						}
					});
				},
				
				getMyFans: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../user/getMyGuanzhuUsers",
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
						$("#DIV_USER_LIST").html("还没有任何关注的海友哦~"); 
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
								<img src="{{:wxHeadimg}}" width="40"
									height="40">
							</div>
							<div class="name">
								<div class="name-xx">
									<div class="xx">{{:enName}}</div>
									 <div class="yrz"><span class="bg-cen">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font></div>
								</div>
								<div class="jj">{{:industryName}}/{{:title}}/{{:atCityName}}</div>
							</div>
						</div>
					</div>
</script>
</html>