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
<title>购买海贝</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>
</head>
<section class="mycenter">
	<section class="sec_item">
		<div class="item">
			<span>请选择购买数量</span>
		</div>
		<div class="item">
			<label id="LABEL_BUY_HAIBEI"></label>
		</div>
		<div class="item">
			<span>应付金额</span><label><em  id="EM_BUY_PRICE"></em>元</label>
		</div>
		<div class="item">
			<span>支付方式</span><label><i class="i_weixin"></i>微信支付</label>
		</div>
	</section>
	<section class="but_baoc">
		<p>
			<input type="button" value="立即购买" id="BTN_BUY"/>
		</p>
	</section>

</section>


</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder.js"></script>
<script type="text/javascript">
wx.config({
	debug : false,
	appId : '<c:out value="${appId}"/>',
	timestamp : <c:out value="${timestamp}"/>,
	nonceStr : '<c:out value="${nonceStr}"/>',
	signature : '<c:out value="${signature}"/>',
	jsApiList : [ 'checkJsApi', 'chooseWXPay' ]
});

	(function($) {
		$.BuyHaibeiPage = function(data) {
			this.settings = $.extend(true, {}, $.BuyHaibeiPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.BuyHaibeiPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents(); 
					this.getHaibeiCanBuy();
				},

				bindEvents : function() {
					var _this = this;
					$("#BTN_BUY").on("click", function() {
						_this.gotoPay();
					});
				},
				
				gotoPay: function(){
					var _this = this;
					var jq=$("[name='RADIO_HAIBEI'].on");
					if(!jq){
						weUI.alert({content:"请选择购买月份"});
						return ;
					}
					var count = jq.attr("count");
					var price = jq.attr("prices"); 
					ajaxController.ajax({
						url : "../user/createHaibeiPayOrder",
						type : "post",
						data: {
							count: count,
							price: price,
							nonceStr: _this.getPropertyValue("nonceStr"),
							timeStamp: _this.getPropertyValue("timestamp")
						},
						success : function(transport) {
							var d = transport.data; 
							wx.chooseWXPay({
							    timestamp: _this.getPropertyValue("timestamp"), // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
							    nonceStr: _this.getPropertyValue("nonceStr"), // 支付签名随机串，不长于 32 位
							    package: d.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
							    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
							    paySign: d.paySign, // 支付签名
							    success: function (res) {
							        _this.rechargeHaibei(count,d.payOrderId);
							    },
							    fail: function(res){
							    	weUI.alert({content:"支付失败"});
							    }, 
							    cancel: function(res){
							    	weUI.alert({content:"您取消支付"});
							    }
							});
						},
						failure : function(transport) {
							weUI.alert({content:transport.statusInfo});
						}
					});
				},
				
				rechargeHaibei : function(count,payOrderId) {
					var _this = this;
					ajaxController.ajax({
						url : "../user/rechargeHaibei",
						type : "post",
						data: {
							count: count,
							payOrderId: payOrderId
						},
						success : function(transport) {
							var d = transport.data;  
							weUI.alert({content:"您成功购买"+count+"个海贝",ok: function(){
								window.location.href="../user/userWealth.html";
								weUI.closeAlert();
							}});
						},
						failure : function(transport) {
							weUI.alert({content:transport.statusInfo});
						}

					});

				},
				
				getHaibeiCanBuy : function() {
					var _this = this;
					ajaxController.ajax({
						url : "../sys/getHaibeiCanBuy",
						type : "post",
						success : function(transport) {
							var d = transport.data; 
							_this.haibeiprices =d?d:[]; 
							_this.renderHaibeiPrices(); 
						}
					});

				},
				
				renderHaibeiPrices: function(){
					var _this = this;
					var template = $.templates("#BuyHaibeiImpl");
                    var htmlOutput = template.render(this.haibeiprices?this.haibeiprices:[]);
                    $("#LABEL_BUY_HAIBEI").html(htmlOutput);
                    
                    //初始化第一条
                    if(this.haibeiprices && this.haibeiprices.length>0){
                    	var count =this.haibeiprices[0].count; 
                    	var p = this.getHaibeiPrice(count);
                    	$("#EM_BUY_PRICE").text(p?p.priceYuan:"");
                    }
                    
                    $("[name='RADIO_HAIBEI']").bind("click",function(){
                    	var count = $(this).attr("count");
                    	var p = _this.getHaibeiPrice(count);
                    	$("[name='RADIO_HAIBEI']").removeClass("on");
                    	$(this).addClass("on");
                    	//切换需要支付的金额
                    	$("#EM_BUY_PRICE").text(p?p.priceYuan:"");
                    });
				},
				
				getHaibeiPrice: function(count){
					var pa=$.grep(this.haibeiprices,function(d,i){
						return d.count==count;
					});
					if(!pa || pa.length==0){
						weUI.alert({content:"海贝折扣定价信息出错，请刷新页面重试"});
						return ;
					}
					return pa[0];
				},
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);

	$(document).ready(function() {
		var b = new $.HarborBuilder();
		b.buildFooter();
		
		var p = new $.BuyHaibeiPage({
			timestamp : <c:out value="${timestamp}"/>,
			nonceStr : '<c:out value="${nonceStr}"/>',
		});
		p.init();
	});
</script>

<script id="BuyHaibeiImpl" type="text/x-jsrender">
<a {{if #index==0}} class="on" {{/if}} name="RADIO_HAIBEI" prices="{{:prices}}" count="{{:count}}">{{:count}}个</a>
</script>
</html>