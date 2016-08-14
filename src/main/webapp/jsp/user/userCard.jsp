<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title>名片</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>
<style>
#shareit {
	-webkit-user-select: none;
	display: none;
	position: absolute;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.85);
	text-align: center;
	top: 0;
	left: 0;
	z-index: 105;
}

#shareit img {
	max-width: 100%;
}

.arrow {
	position:absolute;
	top:1%;
	right: 1%;
}

#share-text {
	margin-top: 400px;
}
</style>

</head>
<body class="barn">
	<section class="mingpian">
		<section class="uk" style="display:none">
			<p><c:out value="${userInfo.hyId}"/></p>
		</section>
		<section class="touxing_logo">
			<p>
				<span><img src="<c:out value="${userInfo.wxHeadimg}"/>"></span>
			</p>
		</section>
		<section class="per_info">
			<p class="name">
				<span><c:out value="${userInfo.enName}"/></span><label class="lbl2" style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}"/></label><i><font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>><c:out value="${userInfo.userStatusName}"/></font></i>
			</p>
			<p class="pengyou">
				<a href="#">益友 <c:out value="${yiyou}"/></a><a href="#" class="on">助人 <c:out value="${zhuren}"/></a><a href="#">公益贝
					0</a>
			</p>
			<p class="aihao" id="SELECTED_INTEREST_TAGS"></p>
			<section class="jinrong">
				<p><c:out value="${userInfo.employmentInfo}"/></p>
				<p class="aihao" id="SELECTED_SKILL_TAGS"></p>
			</section>
			<p class="but">
				<input type="button" value="分 享" id="BTN_SHARE"><input type="button"
					value="应 邀"  id="BTN_ACCEPT">
			</p>

			<div class="clear"></div>
			<c:if test="${initcode!=null}">
			<p >请记住邀请码 <font size="5"><c:out value="${initcode}"/></font>，在下一步输入注册</p>
			<p>（<c:out value="${userInfo.enName}"/>还剩 ${ncount}个邀请名额）</p>
			</c:if>
			<c:if test="${initcode==null}">
			<p >邀请码已经用完</p>
			</c:if>
			<p>海湾，我们的舞台...</p>
		</section>
	</section>
	
	<div id="shareit">
	  <a href="#" id="follow">
	     <img class="arrow" src="//static.tfeie.com/images/share.jpg">
	  </a>
	</div>
	
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript"> 
	
	//微信API配置
	wx.config({
		debug : false,
		appId : '<c:out value="${appId}"/>',
		timestamp : <c:out value="${timestamp}"/>,
		nonceStr : '<c:out value="${nonceStr}"/>',
		signature : '<c:out value="${signature}"/>',
		jsApiList : [ 'checkJsApi', 'onMenuShareTimeline','onMenuShareAppMessage']
	});
	
	(function($){
		$.UserCardPage = function(data){
			this.settings = $.extend(true,{},$.UserCardPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.UserCardPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.initData(); 
					this.bindEvents();
					
					wx.ready(function () {
						var code = "${initcode}"?"${initcode}":"邀请码已用完";
						 var shareData = {
								   title: '${userInfo.enName}在海归海湾创业' ,
								   desc: "海归海湾，海归创业第一站，限量邀请码：" + code,
								   imgUrl:'${userInfo.wxHeadimg}',
								   link: '${url}'
							};
						 
						wx.onMenuShareTimeline(shareData);	
						wx.onMenuShareAppMessage(shareData);	
					});
				},
				
				initData: function(){
					this.getAllTags(); 
				},
				
				bindEvents: function(){
					var _this=this;
					$("#BTN_SHARE").on("click",function(){
						wx.onMenuShareTimeline({
						    title: _this.getPropertyValue("enName")+"在海归海湾创业",
						    desc: "海归海湾，海归创业第一站，限量邀请码：" + _this.getPropertyValue("initcode"),
						    link:  _this.getPropertyValue("url"), 
						    imgUrl: _this.getPropertyValue("shareImg"), 
						    success: function () {
						    	weUI.showXToast("分享成功");
								setTimeout(function () {
									weUI.hideXToast();
									$("#shareit").hide(); 
					            }, 500);
								return ;
						    },
						    cancel: function () {  
						    	$("#shareit").hide(); 
						    }
						});	
						wx.onMenuShareAppMessage({
						    title: _this.getPropertyValue("enName")+"在海归海湾创业",
						    desc: "海归海湾，海归创业第一站，限量邀请码：" + _this.getPropertyValue("initcode"),
						    link:  _this.getPropertyValue("url"), 
						    imgUrl: _this.getPropertyValue("shareImg"), 
						    success: function () {  
						    	weUI.showXToast("分享成功");
								setTimeout(function () {
									weUI.hideXToast();
									$("#shareit").hide(); 
					            }, 500);
						    },
						    cancel: function () {  
						    	$("#shareit").hide(); 
						    }
						});	
						
						$("#shareit").show();
					});
					
					$("#shareit").on("click", function(){
					    $("#shareit").hide(); 
					 });
					 
					 $("#BTN_ACCEPT").bind("click",function(){
						 window.location.href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzAxMjg3NDQ0Ng==&scene=110#wechat_redirect";
						// window.location.href="../user/toUserRegister.html?flag=share&inviteCode=" + _this.getPropertyValue("inviteCode");
					 });
				},
				
				getAllTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../user/getUserTags",
						type: "post", 
						data: {
							userId: this.getPropertyValue("userId")
						},
						success: function(transport){
							var data =transport.data;
							_this.selectedSkillTags=data["selectedSkillTags"]?data["selectedSkillTags"]:[];
							_this.selectedInterestTags=data["selectedInterestTags"]?data["selectedInterestTags"]:[];

							_this.renderSelectedSkillTags(data["selectedSkillTags"]);
							_this.renderSelectedInterestTags(data["selectedInterestTags"]);
						},
						failure: function(transport){  
							_this.renderSelectedSkillTags([]);
							_this.renderSelectedInterestTags([]);
						}
					});
				},
				
				renderSelectedSkillTags: function(tags){ 
					var opt=$("#SelectedTagImpl").render(tags);
					$("#SELECTED_SKILL_TAGS").html(opt);
				},
				
				renderSelectedInterestTags: function(tags){
					var opt=$("#SelectedTagImpl").render(tags);
					$("#SELECTED_INTEREST_TAGS").html(opt);
				},
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var p = new $.UserCardPage({
			userId: "<c:out value="${userInfo.userId}"/>",
			enName: "<c:out value="${userInfo.enName}"/>",
			shareImg: "<c:out value="${userInfo.wxHeadimg}"/>",
			url: "<c:out value="${url}"/>",
			initcode:"<c:out value="${initcode}"/>"?"${initcode}":"邀请码已用完",
			inviteCode:"<c:out value="${inviteCode}"/>"
		});
		p.init();
	});	
	
	</script>
	
	<script id="SelectedTagImpl" type="text/x-jsrender"> 
		{{:tagName}} / 
	</script>
</html>