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
					<span><img src="<c:out value="${userInfo.wxHeadimg}" escapeXml="false"/>"></span>
				</p>
			</section>
			<section class="text-info">
				<p>
					<i><c:out value="${userInfo.enName}" escapeXml="false"/></i><span style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}" escapeXml="false"/></span><label><c:out value="${userInfo.userStatusName}" escapeXml="false"/></label>
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
			<span><a href="javascript:void(0)" id="BTN_CONFIRM">确认</a></span>
			<span><a href="javascript:void(0)" id="BTN_REJECT">拒绝</a></span>
			<span><a href="javascript:void(0)" id="BTN_SEND_MQ">给小白发消息</a></span>
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
					alert("发送消息");
				}); 
				$("#BTN_CONFIRM").on("click", function() {
					_this.submitConfirm("confirm");
				}); 
				$("#BTN_REJECT").on("click", function() {
					_this.submitConfirm("reject");
				}); 
			},
 			
			submitConfirm: function(ackFlag){
				var _this = this;
				var data = {
					goOrderId: _this.getPropertyValue("goOrderId"),
					ackFlag: ackFlag
				};
				
				ajaxController.ajax({
					url: "../go/confirmGoOrder",
					type: "post", 
					data: data ,
					success: function(transport){
						var goOrderId = transport.data;
						weUI.showXToast("已确认..");
						setTimeout(function () {
							weUI.hideXToast();
							window.location.href="../go/mycreateonodetail.html?goId="+_this.getPropertyValue("goId");
			            }, 500);
					},
					failure: function(transport){
						weUI.showXToast("系统繁忙，请稍候重试..");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 500);
					}
					
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
		goOrderId:  "<c:out value="${goOrder.orderId}"/>",
		goId:  "<c:out value="${goOrder.goId}"/>"
		
	});
	p.init();
});
</script>
</html>