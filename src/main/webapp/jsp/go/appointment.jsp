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
<title>约见</title>
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
	<section class="hailiuqueren yuejian">
		<section class="haiuliu-top">
			<p class="bgcolor">
				<label></label>
			</p>
			<div class="clear"></div>
			<p class="back">
				<i><a></a></i><i><a></a></i><i><a></a></i><i><a class="on"></a></i><i></i>
			</p>
			<p>
				<span>预约</span><span>支付费用</span><span>海牛确认</span><span class="on">约见</span><span
					class="in">评价</span>
			</p>

		</section>
		<section class="tijiao on">
			<p>
				<c:if test="${setMeetLocalFlag==true}">
					<c:if test="${confirm==true}">您已经确认了约见时间地点，不可以修改</c:if>
					<c:if test="${confirm==false}">海牛已经设置了约见地点，请确认</c:if>
				</c:if>
				<c:if test="${setMeetLocalFlag==false}">海牛没有还没有设置约见地点，请耐心等候</c:if>
			</p>
		</section>

		<section class="sexy on">
			<p>
				<c:out value="${goOrder.topic}" escapeXml="false" />
			</p>
		</section>

		<section class="touxiang-info">
			<section class="touxiang-img">
				<p>
					<span><img
						src="<c:out value="${userInfo.wxHeadimg}" escapeXml="false"/>"></span>
				</p>
			</section>
			<section class="text-info">
				<p>
					<i><c:out value="${userInfo.enName}" escapeXml="false" /></i><span style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out
							value="${userInfo.abroadCountryName}" escapeXml="false" /></span><label>
						<font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>>	<c:out value="${userInfo.userStatusName}" escapeXml="false" /></font>
							
							</label>
				</p>
				<p class="on">
						<c:out value="${userInfo.employmentInfo}" escapeXml="false" />
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="wenti-jies">
			<section class="yuejian-bott">
				<c:if test="${setMeetLocalFlag==true}">
					<p name="P_CONFIRM" <c:if test="${on1==true}">class="on"</c:if>>
						<c:out value="${goOrder.expectedTime1}" escapeXml="false" />
						<c:out value="${goOrder.expectedLocation1}" escapeXml="false" />
						<input type="hidden" id="confirmTime" value="<c:out value="${goOrder.expectedTime1}" escapeXml="false" />"/>
						<input type="hidden" id="confirmLocation" value="<c:out value="${goOrder.expectedLocation1}" escapeXml="false" />"/>
					</p>
					<p name="P_CONFIRM" <c:if test="${on2==true}">class="on"</c:if>>
						<c:out value="${goOrder.expectedTime2}" escapeXml="false" />
						<c:out value="${goOrder.expectedLocation2}" escapeXml="false" />
						<input type="hidden" id="confirmTime" value="<c:out value="${goOrder.expectedTime2}" escapeXml="false" />"/>
						<input type="hidden" id="confirmLocation" value="<c:out value="${goOrder.expectedLocation2}" escapeXml="false" />"/>
					</p>
				</c:if>
			</section>
			<c:if test="${setMeetLocalFlag==false}">
				<p>海牛还没有设定约见地点，请耐心等待哦~</p>
				</c:if>
			<c:if test="${setMeetLocalFlag==true && confirm==false}">
			<section class="yuejian-but">
				<button id="BTN_CONFITM_MEET_LOCAL">确认时间地点</button>
			</section>
			</c:if>
		</section>
	</section>
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>

<script type="text/javascript">
	(function($) {
		$.GoXiaoBaiAppointmentPage = function(data) {
			this.settings = $.extend(true, {},
					$.GoXiaoBaiAppointmentPage.defaults);
			this.params = data ? data : {}
		}
		$.extend($.GoXiaoBaiAppointmentPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents();
				},

				bindEvents : function() {
					var _this = this;
					$("#BTN_CONFITM_MEET_LOCAL").on("click", function() {
						_this.confirmGoOrderMeetLocaltion();
					});
					
					$(".yuejian-bott").delegate("[name='P_CONFIRM']","click",function(){
						$("[name='P_CONFIRM']").removeClass("on");
						$(this).addClass("on");
					});

				},

				confirmGoOrderMeetLocaltion : function() {
					var _this = this;
					var confirmTime = $("[name='P_CONFIRM'].on").find("#confirmTime").val();
					var confirmLocation=$("[name='P_CONFIRM'].on").find("#confirmLocation").val();
					if($("[name='P_CONFIRM'].on").length==0){
						weUI.alert({content:"请选择活动约见时间地点"});
						return ;
					}
					weUI.showLoadingToast("确认中...");
					ajaxController.ajax({
						url : "../go/confirmGoOrderMeetLocaltion",
						type : "post",
						data : {
							goOrderId : _this.getPropertyValue("goOrderId"),
							confirmTime: confirmTime,
							confirmLocation: confirmLocation
						},
						success : function(transport) {
							weUI.hideLoadingToast();
							weUI.showXToast("确认成功");
							setTimeout(function () {
								weUI.hideXToast();
								window.location.href="../go/myjointgoes.html?goType=ono";
				            }, 1000);
						},
						failure : function(transport) {
							weUI.hideLoadingToast();
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
					});
				},

				getPropertyValue : function(propertyName) {
					if (!propertyName)
						return;
					return this.params[propertyName];
				}
			}
		});
	})(jQuery);

	$(document).ready(function() {
		var p = new $.GoXiaoBaiAppointmentPage({
			goId : "<c:out value="${goOrder.goId}"/>",
			goOrderId : "<c:out value="${goOrder.orderId}"/>"

		});
		p.init();
	});
</script>
</html>