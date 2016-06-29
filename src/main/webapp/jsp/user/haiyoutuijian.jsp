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
<title>海友推荐</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script> 
<script type="text/javascript" src="//static.tfeie.com/js/json2.js"></script>
<script src="//static.tfeie.com/v2/js/swiper.min.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>
<body class="bg-eeeeee">

	<section class="txl-main">
		<div class="swiper-container" id="banner-img">
			<div class="swiper-wrapper" id="INDEX_SILDER"> 
			</div> 
		</div>

		<div class="top-tap box-s">
			<div class="hd" id="hd">
				<div class="itms on"><a href="../user/tuijian.html">新海友&推荐</a></div>
				<div class="itms"><a href="../user/myhaiyou.html">我的海友</a></div>
			</div>
		</div>


		<div id="bd">
			<!--新海友-->
			<div class="bd">
				<div class="new-main box-s mar-top-10 pad-0-10" id="DIV_HAIYOU_APPLY">
					<div class="top-tie">
						<span>新海友请求</span>
					</div> 
				</div>

				<div class="tj-main box-s mar-top-10 pad-0-10">
					<div class="top-tie">
						<span>推荐的海友</span>
						<div class="btn-search"></div>
						<div class="search-main">
							<div class="m">
								<input type="text" placeholder="国家/行业/学校/职业" class="In-text">
							</div>
						</div>
					</div> 
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div> 

				</div>
			</div>
			<!--新海友-->
		</div>


	</section>
	<script>
		//轮播
		var mySwiper = new Swiper('.swiper-container', {
			grabCursor : true,
			loop : true,
			paginationClickable : true,
			pagination : '.ppage',
			autoplay : 5000,

		})
	</script>
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
		$.HYTuijianPage = function(data){
			this.settings = $.extend(true,{},$.HYTuijianPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.HYTuijianPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this; 
					
					//添加图片按钮事件
					$("#SPAN_ADD_IMAGE").on("click",function(){
						 
						
					}); 
					
					//海友请求忽略
					$("#DIV_HAIYOU_APPLY").delegate("[name='BTN_IGNORE']","click",function(){
						var userId =$(this).attr("userId");
						_this.ignoreFriendApply(userId,this);
					});
					//海友请求接收
					$("#DIV_HAIYOU_APPLY").delegate("[name='BTN_ACCEPT']","click",function(){
						var userId =$(this).attr("userId");
						_this.acceptFriendApply(userId,this);
					});
					
				},
				
				initData: function(){
					this.getIndexPageSilders();
					this.getMyFriendsApplies();
				}, 
				
				acceptFriendApply: function(userId,_t){
					var _this = this;
					ajaxController.ajax({
						url: "../user/agreeApplyFriend",
						type: "post",  
						data: {
							friendUserId: userId
						},
						success: function(transport){
							var dom	=	$(_t).parents('.itms');
							dom.fadeOut("200",function(){dom.detach();});
							var len = $(".items").length;
							if(len==0){
								var opt="<div class=\"itms clearfix\">没有新的海友申请哦~</div>";
								$("#DIV_HAIYOU_APPLY").append(opt); 
							}
						},
						failure: function(transport){ 
							weUI.alert({content:transport.statusInfo})
						}
					});
				},
				
				ignoreFriendApply: function(userId,_t){
					var _this = this;
					ajaxController.ajax({
						url: "../user/ignorApplyFriend",
						type: "post",  
						data: {
							friendUserId: userId
						},
						success: function(transport){
							var dom	=	$(_t).parents('.itms');
							dom.fadeOut("200",function(){dom.detach();});
							var len = $(".items").length;
							if(len==0){
								var opt="<div class=\"itms clearfix\">没有新的海友申请哦~</div>";
								$("#DIV_HAIYOU_APPLY").append(opt); 
							}
						},
						failure: function(transport){ 
							weUI.alert({content:transport.statusInfo})
						}
					});
				},
				
				getIndexPageSilders: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getIndexPageSilders",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							_this.renderBannerSider(data); 
						},
						failure: function(transport){ 
							_this.renderBannerSider([]); 
						}
					});
				},
				
				getMyFriendsApplies: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../user/getMyFriendsApplies",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							_this.renderFriendApplies(data); 
						},
						failure: function(transport){ 
							_this.renderFriendApplies([]); 
						}
					});
				},
				
				renderFriendApplies: function(data){
					data= data?data:[];
					var opt= "";
					if(data.length>0){
						opt=$("#HaiyouApplyImpl").render(data);
					}else{
						opt="<div class=\"itms clearfix\">没有新海友申请哦~</div>"
					}
					
					$("#DIV_HAIYOU_APPLY").append(opt); 
					
				},
				 
				renderBannerSider: function(data){ 
					data= data?data:[];
					var opt=$("#BannerSiderImpl").render(data);
					$("#INDEX_SILDER").html(opt); 
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
		
		var p = new $.HYTuijianPage({ 
		});
		p.init();
		
		
	});
</script>

<script id="BannerSiderImpl" type="text/x-jsrender"> 
		<div class="swiper-slide">
					<a href="{{:linkURL}}"><img src="{{:imgURL}}"
						width="100%"></a>
				</div>
</script>

<script id="HaiyouApplyImpl" type="text/x-jsrender"> 	
<div class="itms clearfix">
						<div class="btn-right">
							<span class="btn-hl" name="BTN_IGNORE" userId="{{:userId}}">忽略</span> <span class="btn-js" name="BTN_ACCEPT" userId="{{:userId}}">接受</span>
						</div>
						<div class="c">
							<div class="img">
								<img src="{{:wxHeadimg}}" width="40"
									height="40">
							</div>
							<div class="name">
								<div class="name-xx">
									<div class="xx">{{:enName}}</div>
									<div class="yrz">
										<span class="bg-lan">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font>
									</div>
								</div>
								<div class="jj">{{:industryName}}/{{:title}}/{{:atCityName}}</div>
								<div class="hyy">Hi，Nice to meet you.</div>
							</div>
						</div>
					</div>
</script>
	
</body>
</html>