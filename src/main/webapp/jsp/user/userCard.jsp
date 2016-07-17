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
	position: absolute;
	right: 10%;
	top: 5%;
}

#share-text {
	margin-top: 400px;
}
</style>

</head>
<body class="barn">
	<section class="mingpian">
		<section class="uk">
			<p><c:out value="${userInfo.hyId}"/></p>
		</section>
		<section class="touxing_logo">
			<p>
				<span><img src="<c:out value="${userInfo.wxHeadimg}"/>"></span>
			</p>
		</section>
		<section class="per_info">
			<p class="name">
				<span><c:out value="${userInfo.enName}"/></span><label class="lbl2"><c:out value="${userInfo.abroadCountryName}"/></label><i><c:out value="${userInfo.userStatusName}"/></i>
			</p>
			<p class="pengyou">
				<a href="#">益友 10</a><a href="#" class="on">助人 10</a><a href="#">公益贝
					100</a>
			</p>
			<p class="aihao" id="SELECTED_INTEREST_TAGS"></p>
			<section class="jinrong">
				<p><c:out value="${userInfo.industryName}"/></p>
				<p><c:out value="${userInfo.atCity}"/></p>
				<p class="aihao" id="SELECTED_SKILL_TAGS"></p>
			</section>
			<p class="but">
				<input type="button" value="分 享" id="BTN_SHARE"><input type="button"
					value="应 邀" class="on">
			</p>

			<div class="clear"></div>
			<p>（<c:out value="${userInfo.enName}"/>还剩 3 个邀请名额）</p>
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
				},
				
				initData: function(){ 
					this.getAllTags(); 
				},
				
				bindEvents: function(){
					var _this=this;
					$("#BTN_SHARE").on("click",function(){
						wx.onMenuShareTimeline({
						    title: _this.getPropertyValue("enName")+"在海归海湾的名片",
						    link:  _this.getPropertyValue("url"), 
						    imgUrl: _this.getPropertyValue("shareImg"), 
						    success: function () {  
						    	weUI.alert({content:"分享成功",ok: function(){
						    		$("#shareit").hide(); 
						    	}});
						    },
						    cancel: function () {  
						    	$("#shareit").hide(); 
						    }
						});	
						wx.onMenuShareAppMessage({
						    title: _this.getPropertyValue("enName")+"在海归海湾的名片",
						    link:  _this.getPropertyValue("url"), 
						    imgUrl: _this.getPropertyValue("shareImg"), 
						    success: function () {  
						    	weUI.alert({content:"分享成功",ok: function(){
						    		$("#shareit").hide(); 
						    	}});
						    },
						    cancel: function () {  
						    	$("#shareit").hide(); 
						    }
						});	
						
						$("#shareit").show();
					});
					
					$("#shareit").on("click", function(){
					    $("#shareit").hide(); 
					 })
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
			url: "<c:out value="${url}"/>"
		});
		p.init();
	});	
	
	</script>
	
	<script id="SelectedTagImpl" type="text/x-jsrender"> 
		{{:tagName}} / 
	</script>
</html>