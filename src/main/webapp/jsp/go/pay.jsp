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
<title>支付费用</title>
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
		<section class="haiuliu-top monry">
			<p class="bgcolor">
				<label></label>
			</p>
			<div class="clear"></div>
			<p class="back">
				<i><a></a></i><i><a class="on"></a></i><i></i><i></i><i></i>
			</p>
			<p>
				<span>预约</span><span class="on">支付费用</span><span class="in">海牛确认</span><span
					class="in">约见</span><span class="in">评价</span>
			</p>
		</section>

		<section class="feiyong">
			<p>
				<img src="//static.tfeie.com/images/img23.png">
			</p>
			<section class="monry-info">
				<p>
					<label><c:out value="${topic }"/></label>
				</p>
				<p>待支付</p>
				<p>
					<span><c:out value="${price }"/></span>元
				</p>

				<section class="but_baoc on">
					<p>
						<a href="javascript:void(0)" id="HREF_GO_PAY">立即支付</a>
					</p>
				</section> 
				<p class="tishi">
				<img src="//static.tfeie.com/images/img24.png">海牛3个工作日没有确认，自动退款
				</p>
			</section>
		</section>
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
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	
<script type="text/javascript">
wx.config({
	debug : true,
	appId : '<c:out value="${appId}"/>',
	timestamp : <c:out value="${timestamp}"/>,
	nonceStr : '<c:out value="${nonceStr}"/>',
	signature : '<c:out value="${signature}"/>',
	jsApiList : [ 'checkJsApi', 'chooseWXPay' ]
});

(function($){
	$.GoPayPage = function(data){
		this.settings = $.extend(true,{},$.GoPayPage.defaults);
		this.params= data?data:{}
	}
	$.extend($.GoPayPage,{
		defaults: { 
		},
	
		prototype: {
			init: function(){
				this.bindEvents(); 
			},
			
			bindEvents: function(){
				var _this = this;
				$("#HREF_GO_PAY").on("click", function() {
					_this.gotoPay();
				}); 
			},
			
			gotoPay: function(){
				var _this = this; 
				var data = {
					price: _this.getPropertyValue("price"),	
					nonceStr: _this.getPropertyValue("nonceStr"),	
					timeStamp: _this.getPropertyValue("timeStamp"),	
					openId: _this.getPropertyValue("openId"),	
					userId: _this.getPropertyValue("userId"),	
					goId: _this.getPropertyValue("goId"),	
					goOrderId: _this.getPropertyValue("goOrderId")
				};
				
				ajaxController.ajax({
					url : "../go/createGoPayOrder",
					type : "post",
					data: data,
					success : function(transport) {
						var d = transport.data; 
						
						wx.chooseWXPay({
						    timestamp: _this.getPropertyValue("timeStamp"), // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
						    nonceStr: _this.getPropertyValue("nonceStr"), // 支付签名随机串，不长于 32 位
						    package: d.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
						    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
						    paySign: d.paySign, // 支付签名
						    success: function (res) {
						        _this.updateGoOrderStatus(d.payOrderId,"SUCCESS");
						    },
						    fail: function(res){
						    	weUI.alert({
									content: "活动支付失败",
									ok: function(){
										 _this.updateGoOrderStatus(d.payOrderId,"FAIL");
									}
								})
						    }, 
						    cancel: function(res){
						    	weUI.alert({
									content: "活动支付取消"
								})
						    }
						});
					},
					failure : function(transport) {
						weUI.alert({
							content: transport.statusInfo
						})
					}

				});
			},
			
			updateGoOrderStatus: function(payOrderId,payStatus){
				var _this = this;
				ajaxController.ajax({
					url: "../go/updateGoOrderPay",
					type: "post", 
					data: {
						goOrderId: _this.getPropertyValue("goOrderId"),
						payOrderId: payOrderId,
						payStatus: payStatus
					},
					success: function(transport){
						
					},
					failure: function(transport){
						weUI.alert({
							content: "更新活动预约支付状态失败"+transport.statusInfo
						})
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
	var p = new $.GoPayPage({
		userId: "<c:out value="${userInfo.userId}"/>",
		price:  "<c:out value="${price}"/>",
		nonceStr:  "<c:out value="${nonceStr}"/>",
		timeStamp:  "<c:out value="${timestamp}"/>",
		openId:  "<c:out value="${openId}"/>",
		goId:  "<c:out value="${goId}"/>",
		goOrderId:  "<c:out value="${goOrderId}"/>"
		
	});
	p.init();
});
</script>
</html>