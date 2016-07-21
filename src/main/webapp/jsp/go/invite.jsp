<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>邀约详情</title>
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
	<section class="mainer in">
		<section class="ma_shenghe">
			<p>
				<c:out value="${go.topic}" />
			</p>
		</section>
		<section class="shenhe_xinxi">
			<section class="info_fuwu">
				<section class="ip_info">
					<section class="info_img">
						<span><a href="../user/userInfo.html?userId=<c:out value="${go.userId}" />"><img src="<c:out value="${go.wxHeadimg}"/>"></a></span>
					</section>
					<section class="ip_text">
						<p>
							<span><c:out value="${go.enName}" /></span><label class="lbl2"><c:out
									value="${go.abroadCountryName}" /></label>
							<c:out value="${go.userStatusName}" />
						</p>
						<p>
							<c:if test="${go.industryName!=null}">
								<c:out value="${go.industryName}" escapeXml="false" />
					/
					</c:if>
							<c:if test="${go.title!=null}">
								<c:out value="${go.title}" escapeXml="false" />
					/
					</c:if>
							<c:out value="${go.atCityName}" escapeXml="false" />
						</p>
					</section>
					<div class="clear"></div>
				</section>
				<section class="info_time">
					<p>
						<span><c:out value="${go.expectedStartTime}" /></span><a href="#"><c:out value="${go.orgModeName}" /></a>
					</p>
				</section>
				<section class="info_time back1">
					<p>
						<span>Group邀请<c:out value="${go.inviteMembers}" />人</span><a href="#"><c:out value="${go.fixPriceYuan}" />元</a>
					</p>
				</section>
				<section class="info_time back2">
					<p>
						<span><c:out value="${go.location}" /></span>
					</p>
				</section>
				<section class="info_fangf pz">
					<article>
					<c:forEach var="detail" items="${go.goDetails }">
						<c:if test="${detail.type=='text'}">
							<p>
								<c:out value="${detail.detail}" />
							</p>
						</c:if>
						<c:if test="${detail.type=='image'}">
							<p>
								<img src="<c:out value="${detail.imgThumbnailUrl}"/>" width="100%">
							</p>
						</c:if>
					</c:forEach>
					</article> 
				</section>
				<div class="clear"></div>
			</section>
			<section class="num_liulan">
				<p>
					<a href="#">浏览 <c:out value="${go.viewCount}" /></a><a href="#">参加 <c:out value="${go.joinCount}" /></a><a href="#">收藏 <c:out value="${go.favorCount}" /></a>
				</p>
			</section>
		</section>
		<section class="yanbaoming">
			<section class="sec_btn2 fabu" style="display:none" id="SEL_SHOW_RESULT">
				<input type="button" value="报名成功，等待审核">
			</section>
			<section class="yaoy">
				<p>
					<span>
					<c:if test="${go.payMode=='10' }">
						<c:out value="${go.fixPriceYuan}" />元
					</c:if>
					<c:if test="${go.payMode=='20' }">
						AA <c:out value="${go.fixPriceYuan}" />元/人
					</c:if>
					<c:if test="${go.payMode=='30' }">
						<c:out value="${go.payModeName}" />
					</c:if>
					</span>
					<c:if test="${joint==false}">
					<button id="BTN_BAOMING">
						<img src="//static.tfeie.com/images/img58.png">我要报名
					</button>
					</c:if>
					<label id="APPLY_SUCCESS" style="display:none">报名成功</label>
					<c:if test="${joint==true}">
					<label id="APPLY_SUCCESS"><a href="../go/comments.html?goId=<c:out value="${go.goId}" />">已参加,进入点评</a></label>
					</c:if>
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
	src="//static.tfeie.com/js/jquery.weui.js"></script>
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

(function($){
	$.GroupInvitePage = function(data){
		this.settings = $.extend(true,{},$.GroupInvitePage.defaults);
		this.params= data?data:{}
	}
	$.extend($.GroupInvitePage,{
		defaults: { 
		},
	
		prototype: {
			init: function(){
				this.bindEvents(); 
			},
			
			bindEvents: function(){
				var _this = this; 
				//提交事件
				$("#BTN_BAOMING").on("click",function(){
					_this.applyGroup();
				});
			},
			
			getPropertyValue: function(propertyName){
				if(!propertyName)return;
				return this.params[propertyName];
			},
			
			applyGroup: function(){
				var _this = this; 
				ajaxController.ajax({
					url: "../go/applyGroup",
					type: "post", 
					data:{
						nonceStr: _this.getPropertyValue("nonceStr"),	
						timeStamp: _this.getPropertyValue("timeStamp"), 
						goId: _this.getPropertyValue("goId")
					},
					success: function(transport){ 
						var d = transport.data;
						var orderId = d.orderId;
						var needPay = d.needPay;
						var payAmount=d.payAmount;
						var payOrderId=d.payOrderId;
						//调用支付接口
						if(needPay){
							wx.chooseWXPay({
							    timestamp: _this.getPropertyValue("timeStamp"), // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
							    nonceStr: _this.getPropertyValue("nonceStr"), // 支付签名随机串，不长于 32 位
							    package: d.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
							    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
							    paySign: d.paySign, // 支付签名
							    success: function (res) {
							    	_this.updateGoJoinPay(orderId,payOrderId,"SUCCESS");
							    },
							    fail: function(res){
							    	weUI.alert({
										content: "活动支付失败",
										ok: function(){
											_this.updateGoJoinPay(orderId,payOrderId,"FAIL");
											 weUI.closeAlert();
										}
									})
							    }, 
							    cancel: function(res){
							    	weUI.alert({
										content: "活动支付取消"
									})
							    }
							});
						} 
						
					},
					failure: function(transport){
						weUI.alert({
							content: transport.statusInfo
						})
					}
					
				});
			},
			updateGoJoinPay: function(goOrderId,payOrderId,payStatus){
				var _this = this; 
				ajaxController.ajax({
					url: "../go/updateGoJoinPay",
					type: "post", 
					data: {
						goOrderId: goOrderId,
						payOrderId: payOrderId,
						payStatus: payStatus
					} ,
					success: function(transport){
						$("#BTN_BAOMING").hide();
						$("#APPLY_SUCCESS").show();
						$("#SEL_SHOW_RESULT").show();
						
					},
					failure: function(transport){
						weUI.alert({
							content: transport.statusInfo
						})
					}
					
				});
			}
		}
	});
})(jQuery);

$(document).ready(function(){
	var p = new $.GroupInvitePage({ 
		nonceStr:  "<c:out value="${nonceStr}"/>",
		timeStamp:  "<c:out value="${timestamp}"/>",
		goId:  "<c:out value="${go.goId}"/>"
	});
	p.init();
});
</script>
</html>