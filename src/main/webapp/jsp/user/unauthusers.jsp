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
<title>未认证用户列表</title>
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
<body>
	<section class="wdgz-main" id="DIV_USER">

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
<script type="text/javascript">

	(function() {
		$.PreAuthPage = function(data) {
			this.settings = $.extend(true,{},$.PreAuthPage.defaults);
			this.params= data?data:{};
		};
		
		$.extend($.PreAuthPage,{
			defaults:{
				
			},
			prototype:{
				init:function(){
					this.bindEvents();
					this.initData();
				},
				
				bindEvents:function(){
					$(".wdgz-main").delegate("[name='DIV_USERID']","click",function(){
						var userId = $(this).attr("userId");
						location.href="../user/toCertficate.html?userId=" + userId;
					});
				},
				initData: function(){
					this.queryUnAuthUsers();
				},
				
				queryUnAuthUsers(){
					var _this = this;
					ajaxController.ajax({
						url: "../user/queryUnAuthUsers",
						type: "post",
						success: function(transport){
							var data =transport.data; 
							_this.renderUserInfo(data); 
						},
						failure: function(transport){ 
							_this.renderUserInfo([]); 
						}
					});
				},
				
				renderUserInfo:function(data){
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#userListImpl").render(data);
					}else{
						opt="<div class=\"itms clearfix\">没有待审核认证的用户哦~</div>";
					}
					$("#DIV_USER").html(opt);
				}
			}
		});
	})(jQuery);
	
	 $(document).ready(function(){
		var p = new $.PreAuthPage({});
		p.init();
	});
</script>

<script id="userListImpl" type="text/x-jsrender"> 
<div class="itms clearfix" name="DIV_USERID" userId={{:userId}}>
			<div class="img">
				<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"></a>
			</div>
			<div class="r">
				<div class="time">{{:submitCertDate}}</div>
				<div class="c">
					<a href="#">
						<div class="name">{{:enName}}<span class="bg-lv" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font></div>
						<div class="xx"><a href="javascript:void(0)">{{:signature}}</a> </div>
					</a>
				</div>
			</div>
</div>
</script>
</html>