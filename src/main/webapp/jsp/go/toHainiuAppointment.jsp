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
				<c:if test="${confirm==true}">小白已经确认了时间地点，您不能再修改</c:if>
				<c:if test="${confirm==false}">请您输入2个活动举办的时间地点</c:if>
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
					<i><c:out value="${userInfo.enName}" escapeXml="false" /></i><span><c:out
							value="${userInfo.abroadCountryName}" escapeXml="false" /></span><label><c:out
							value="${userInfo.userStatusName}" escapeXml="false" /></label>
				</p>
				<p class="on">
					<c:if test="${userInfo.industryName!=null}">
						<c:out value="${userInfo.industryName}" escapeXml="false" />
					/
					</c:if>
					<c:if test="${userInfo.title!=null}">
						<c:out value="${userInfo.title}" escapeXml="false" />
					/
					</c:if>
					<c:out value="${userInfo.atCityName}" escapeXml="false" />
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="wenti-jies">
			<section class="inp_time">
				<p>
					<span><input type="text" placeholder="2016-5-25 10:00 "
						id="expectedTime1" class="datepicker" value="<c:out value="${goOrder.expectedTime2}" escapeXml="false" />"/></span><label><input
						type="text" placeholder="请输入地点1" id="expectedLocation1" value="<c:out value="${goOrder.expectedLocation1}" escapeXml="false" />"/></label>
				</p>
				<p>
					<span><input type="text" placeholder="2016-5-25 10:00 "
						id="expectedTime2" class="datepicker" value="<c:out value="${goOrder.expectedTime2}" escapeXml="false" />"/></span><label><input
						type="text" placeholder="请输入地点2" id="expectedLocation2" value="<c:out value="${goOrder.expectedLocation2}" escapeXml="false" />"/></label>
				</p>
			</section>
			<c:if test="${confirm==false}">
			<section class="yuejian-but">
				<button id="BTN_CONFITM_MEET_LOCAL">设置约见地点</button>
			</section>
			</c:if>
		</section>

		<section class="sec_btn2 yuejian">
			<input type="button" value="确认服务结束" id="BTN_CONFIRM_MEET_END">
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
(function($){
	$.GoHainiuAppointmentPage = function(data){
		this.settings = $.extend(true,{},$.GoHainiuAppointmentPage.defaults);
		this.params= data?data:{}
	}
	$.extend($.GoHainiuAppointmentPage,{
		defaults: { 
		},
	
		prototype: {
			init: function(){
				this.bindEvents(); 
			},
			
			bindEvents: function(){
				var _this = this;
				$("#BTN_CONFITM_MEET_LOCAL").on("click", function() {
					_this.setGoOrderMeetLocaltion();
				}); 
				
				$("#BTN_CONFIRM_MEET_END").on("click", function() {
					_this.confirmMeetEnd();
				});
				
				
			},
			
			confirmMeetEnd: function(){
				var _this = this;
				ajaxController.ajax({
					url: "../go/finishGoOrder",
					type: "post", 
					data: { 
						goOrderId: _this.getPropertyValue("goOrderId")
					},
					success: function(transport){
						weUI.alert({
							content:"活动已结束"
						});
					},
					failure: function(transport){ 
						weUI.alert({content: transport.statusInfo});
					}
				});
			},
			
			setGoOrderMeetLocaltion: function(){
				var _this = this;
				var expectedTime1 = $.trim($("#expectedTime1").val());
				var expectedTime2 = $.trim($("#expectedTime2").val());
				var expectedLocation1 = $.trim($("#expectedLocation1").val());
				var expectedLocation2 = $.trim($("#expectedLocation2").val());
				var valueValidator = new $.ValueValidator();
				valueValidator.addRule({
					labelName: "预计开始时间1",
					fieldName: "expectedTime1",
					getValue: function(){
						return expectedTime1;
					},
					fieldRules: {
						required: true, 
						datetime: true
					},
					ruleMessages: {
						required: "请填写第一个预期开始时间",
						datetime:"预期开始时间格式必须是yyyy-MM-dd hh:mm:ss"
					}
				}).addRule({
					labelName: "见面地点1",
					fieldName: "expectedLocation1",
					getValue: function(){
						return expectedLocation1;
					},
					fieldRules: {
						required: true,
						cnlength: 100
					},
					ruleMessages: {
						required: "请填写第一个见面地点",
						cnlength: "第一个见面地点不超过100个字"
					}
				}).addRule({
					labelName: "预计开始时间2",
					fieldName: "expectedTime2",
					getValue: function(){
						return expectedTime2;
					},
					fieldRules: {
						required: true, 
						datetime: true
					},
					ruleMessages: {
						required: "请填写第二个预期开始时间",
						datetime:"预期开始时间格式必须是yyyy-MM-dd hh:mm:ss"
					}
				}).addRule({
					labelName: "见面地点2",
					fieldName: "expectedLocation2",
					getValue: function(){
						return expectedLocation2;
					},
					fieldRules: {
						required: true,
						cnlength: 100
					},
					ruleMessages: {
						required: "请填写第二个见面地点",
						cnlength: "第二个见面地点不超过100个字"
					}
				});
				var res=valueValidator.fireRulesAndReturnFirstError();
				if(res){
					weUI.alert({content:res});
					return;
				}
				ajaxController.ajax({
					url: "../go/setGoOrderMeetLocaltion",
					type: "post", 
					data: { 
						goOrderId: _this.getPropertyValue("goOrderId"),
						expectedTime1: expectedTime1,
						expectedTime2: expectedTime2,
						expectedLocation1: expectedLocation1,
						expectedLocation2: expectedLocation2
					},
					success: function(transport){
						weUI.alert({content:"约见地点设置成功"});
					},
					failure: function(transport){ 
						weUI.alert({content: transport.statusInfo});
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
	var p = new $.GoHainiuAppointmentPage({ 
		goId:  "<c:out value="${goOrder.goId}"/>",
		goOrderId:  "<c:out value="${goOrder.orderId}"/>"
		
	});
	p.init();
});
</script>
</html>