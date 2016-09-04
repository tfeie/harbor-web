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
<title>海牛确认</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">	
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
</head>
<body>
	<section class="hailiuqueren">
		<section class="haiuliu-top">
			<p class="bgcolor">
				<label></label>
			</p>
			<div class="clear"></div>
			<p class="back">
				<i><a></a></i><i><a></a></i><i><a class="on"></a></i><i></i><i></i>
			</p>
			<p>
				<span>预约</span><span>支付费用</span><span class="on">海牛确认</span><span
					class="in">约见</span><span class="in">评价</span>
			</p>

		</section>
		<section class="tijiao">
			<p><c:out value="${tips}" escapeXml="false"/></p>
		</section>
		<section class="sexy">
			<p><c:out value="${goOrder.topic}" escapeXml="false"/></p>
		</section>
		<section class="touxiang-info">
			<section class="touxiang-img">
				<p>
					<span><a href="../user/userInfo.html?userId=<c:out value="${userInfo.userId}" escapeXml="false"/>"><img src="<c:out value="${userInfo.wxHeadimg}" escapeXml="false"/>" width="40" height="40"></a></span>
				</p>
			</section>
			<section class="text-info">
				<p>
					<i><c:out value="${userInfo.enName}" escapeXml="false"/></i><span style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}" escapeXml="false"/></span><label><font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>><c:out value="${userInfo.userStatusName}" escapeXml="false"/></font></label>
				</p>
				<p class="on"><c:out value="${userInfo.employmentInfo}" escapeXml="false"/></p>
			</section>
			<div class="clear"></div>
		</section>
		<section class="wenti-jies">
			<section class="wenti">
				<p class="on">想请教的问题</p>
				<p><c:out value="${goOrder.questions}" escapeXml="false"/></p>
			</section>
			<section class="wenti">
				<p class="on">自我介绍</p>
				<p><c:out value="${goOrder.selfIntro}" escapeXml="false"/></p>
			</section>
		</section>

		<section class="sec_btn2">
			<a href="javascript:void(0)" id="BTN_SEND_MQ">给海牛发消息</a>
		</section>
	</section>
</body>

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script> 
	
<script type="text/javascript">
(function($){
	$.GoWaitConfirmPage = function(data){
		this.settings = $.extend(true,{},$.GoWaitConfirmPage.defaults);
		this.params= data?data:{}
	}
	$.extend($.GoWaitConfirmPage,{
		defaults: { 
		},
	
		prototype: {
			init: function(){
				this.bindEvents(); 
			},
			
			bindEvents: function(){
				var _this = this;
				$("#BTN_SEND_MQ").on("click", function() {
					var userId=_this.getPropertyValue("userId");
					window.location.href="../user/im.html?touchId="+userId;
				}); 
			},
 
			
			getPropertyValue: function(propertyName){
				if(!propertyName)return;
				return this.params[propertyName];
			}
		}
	});
})(jQuery);

$(document).ready(function(){
	var p = new $.GoWaitConfirmPage({
		userId: "<c:out value="${userInfo.userId}"/>", 
		goId:  "<c:out value="${goOrder.goId}"/>",
		goOrderId:  "<c:out value="${goOrder.orderId}"/>"
		
	});
	p.init();
});
</script>
</html>