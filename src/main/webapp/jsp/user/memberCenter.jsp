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
<title>会员中心</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
</head>
<section class="mycenter">

	<section class="sec_item">
		<div class="div_title2">
			<h3>
				<span>会员福利介绍</span>
			</h3>
		</div>
		<div class="div_cont">
			<div class="img">
				<img src="//static.tfeie.com/images/pic1.png" alt="" />
			</div>
		</div>
	</section>
	<section class="sec_item">
		<div class="item">
			<span>会员到期时间</span><label><c:out value="${userMember.desc}"/></label>
		</div>
		<div class="item">
			<span>购买月份</span><label id="LABEL_BUY_MONTHS"></label>
		</div>
		<div class="item">
			<span>应付金额</span><label><em  id="EM_BUY_PRICE"></em>元</label>
		</div>
		<div class="item">
			<span>支付方式</span><label><i class="i_weixin"></i>微信支付</label>
		</div>
	</section>
	<div class="message-err" id="DIV_TIPS"></div>
	<section class="but_baoc">
		<p>
			<input type="button" value="立即购买" id="BTN_BUY"/>
		</p>
	</section>

</section>

<footer class="footer">
	<ul>
		<li><a href="">
				<div class="img">
					<img src="//static.tfeie.com/images/f1.png" />
				</div>
				<div class="text">Be</div>
		</a></li>
		<li><a href="">
				<div class="img">
					<img src="//static.tfeie.com/images/f2.png" />
				</div>
				<div class="text">Go</div>
		</a></li>
		<li><a href="">
				<div class="img">
					<img src="//static.tfeie.com/images/f3.png" />
				</div>
				<div class="text">Frd</div>
		</a></li>
		<li><a href="">
				<div class="img">
					<img src="//static.tfeie.com/images/f4.png" /><i>6</i>
				</div>
				<div class="text">Msg</div>
		</a></li>
		<li class="on"><a href="">
				<div class="img">
					<img src="//static.tfeie.com/images/f5.png" />
				</div>
				<div class="text">Me</div>
		</a></li>
	</ul>
</footer>

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
		$.MemberCenterPage = function() {
			this.settings = $.extend(true, {}, $.MemberCenterPage.defaults);
		}
		$.extend($.MemberCenterPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents(); 
					this.getMemberCanByMonths();
				},

				bindEvents : function() {
					var _this = this;
					$("#BTN_BUY").on("click", function() {
						_this.gotoPay();
					});
				},
				
				gotoPay: function(){
					var _this = this;
					var jq=$("[name='RADIO_MONTH'].on");
					if(!jq){
						this.showError("请选择购买月份");
						return ;
					}else{
						this.hideMessage();
					}
					var payMonth = jq.attr("months");
					var price = jq.attr("prices"); 
					ajaxController.ajax({
						url : "../user/createMemberPayOrder",
						type : "post",
						data: {
							payMonth: payMonth,
							price: price,
							userId:"<c:out value="${userMember.userId}"/>",
							openId:"<c:out value="${openId}"/>",
							nonceStr: "<c:out value="${nonceStr}"/>",
							timeStamp: <c:out value="${timestamp}"/>
						},
						success : function(transport) {
							var d = transport.data; 
							
							wx.chooseWXPay({
							    timestamp: <c:out value="${timestamp}"/>, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
							    nonceStr: '<c:out value="${nonceStr}"/>', // 支付签名随机串，不长于 32 位
							    package: d.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
							    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
							    paySign: d.paySign, // 支付签名
							    success: function (res) {
							        _this.userMemberRenewal(payMonth,d.payOrderId);
							    },
							    fail: function(res){
							    	 _this.showError("支付失败")
							    }, 
							    cancel: function(res){
							    	 _this.showError("支付取消")
							    }
							});
						},
						failure : function(transport) {
							_this.showError(transport.statusInfo);
						}

					});
				},
				
				userMemberRenewal : function(payMonth,payOrderId) {
					var _this = this;
					ajaxController.ajax({
						url : "../user/userMemberRenewal",
						type : "post",
						data: {
							userId:"<c:out value="${userMember.userId}"/>",
							openId:"<c:out value="${openId}"/>",
							payMonth: payMonth,
							payOrderId: payOrderId
						},
						success : function(transport) {
							var d = transport.data; 
							alert(d.enName+",您成功购买"+payMonth+"个月会员,有效期["+d.expDate+"]")
						},
						failure : function(transport) {
							_this.showError("会员支付成功，但是处理失败");
						}

					});

				},
				
				getMemberCanByMonths : function() {
					var _this = this;
					ajaxController.ajax({
						url : "../sys/getMemberCanByMonths",
						type : "post",
						success : function(transport) {
							var d = transport.data; 
							_this.memberprices =d?d:[]; 
							_this.renderMemberPrices(); 
						},
						failure : function(transport) {
						}

					});

				},
				
				renderMemberPrices: function(){
					var _this = this;
					var template = $.templates("#BuyMonthsImpl");
                    var htmlOutput = template.render(this.memberprices?this.memberprices:[]);
                    $("#LABEL_BUY_MONTHS").html(htmlOutput);
                    
                    //初始化第一条月份费用显示 
                    if(this.memberprices && this.memberprices.length>0){
                    	var firstmonth =this.memberprices[0].months; 
                    	var p = this.getMonthsPrice(firstmonth);
                    	$("#EM_BUY_PRICE").text(p?p.priceYuan:"");
                    }
                    
                    $("[name='RADIO_MONTH']").bind("click",function(){
                    	var months = $(this).attr("months");
                    	var p = _this.getMonthsPrice(months);
                    	$("[name='RADIO_MONTH']").removeClass("on");
                    	$(this).addClass("on");
                    	//切换需要支付的金额
                    	$("#EM_BUY_PRICE").text(p?p.priceYuan:"");
                    });
				},
				
				getMonthsPrice: function(months){
					var pa=$.grep(this.memberprices,function(d,i){
						return d.months==months;
					});
					if(!pa || pa.length==0){
						alert("会员定价信息出错，请刷新页面重试");
						return ;
					}
					return pa[0];
				},
				
				showError : function(message) {
					$(".message-err").show().html(
							"<p><span>X</span>" + message + "</p>");
				},

				showSuccess : function(message) {
					$(".message-err").show().html(
							"<p><span></span>" + message + "</p>");
				},

				hideMessage : function() {
					$(".message-err").html("").hide();
				}
			}
		})
	})(jQuery);

	$(document).ready(function() {
		var p = new $.MemberCenterPage();
		p.init();
	});
</script>

<script id="BuyMonthsImpl" type="text/x-jsrender">
<a {{if #index==0}} class="on" {{/if}} name="RADIO_MONTH" prices="{{:prices}}" months="{{:months}}">{{:months}}个月</a>
</script>
</html>