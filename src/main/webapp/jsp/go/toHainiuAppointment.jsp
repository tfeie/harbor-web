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
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script type="text/javascript" src="<%=_base%>/js/jedate/jedate.js"></script>
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
				<c:if test="${confirm==true}">用户已经确认了时间地点，您不能再修改</c:if>
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
					<i><c:out value="${userInfo.enName}" escapeXml="false" /></i><span style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out
							value="${userInfo.abroadCountryName}" escapeXml="false" /></span><label><c:out
							value="${userInfo.userStatusName}" escapeXml="false" /></label>
				</p>
				<p class="on">
					<c:out value="${userInfo.employmentInfo}" escapeXml="false" />
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="wenti-jies">
			<section class="inp_time" <c:if test="${confirm==true}">style="display:none" </c:if>>
				
				<p>
					<span><input type="text"  class="datainp" readonly
						id="expectedTime1" class="datepicker" value="<c:out value="${goOrder.expectedTime2}" escapeXml="false" />"/></span><label><input
						type="text" placeholder="请输入地点1" id="expectedLocation1" value="<c:out value="${goOrder.expectedLocation1}" escapeXml="false" />"/></label>
				</p>
				<p>
					<span><input type="text" class="datainp" readonly
						id="expectedTime2" class="datepicker" value="<c:out value="${goOrder.expectedTime2}" escapeXml="false" />"/></span><label><input
						type="text" placeholder="请输入地点2" id="expectedLocation2" value="<c:out value="${goOrder.expectedLocation2}" escapeXml="false" />"/></label>
				</p>
			</section>	
			<section class="yuejian-bott" <c:if test="${confirm==false}">style="display:none" </c:if>>
			
					<p name="P_CONFIRM" <c:if test="${on1==true}">class="on"</c:if>>
						<c:out value="${goOrder.expectedTime1}" escapeXml="false" />
						<c:out value="${goOrder.expectedLocation1}" escapeXml="false" />
					</p>
					<p name="P_CONFIRM" <c:if test="${on2==true}">class="on"</c:if>>
						<c:out value="${goOrder.expectedTime2}" escapeXml="false" />
						<c:out value="${goOrder.expectedLocation2}" escapeXml="false" />
					</p>
				
			</section>
			
			
			<c:if test="${confirm==false}">
			<section class="yuejian-but">
				<button id="BTN_CONFITM_MEET_LOCAL">设置约见地点</button>
			</section>
			</c:if>
		</section>

		<section class="sec_btn2 <c:if test="${goOrder.orderStatus=='40'}">yuejian</c:if>">
			<input type="button" <c:if test="${goOrder.orderStatus!='40'}">value="确认服务结束" id="BTN_CONFIRM_MEET_END"</c:if><c:if test="${goOrder.orderStatus=='40'}">value="活动已结束" </c:if>>
		</section>
	</section>
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script> 
<script type="text/javascript"
		src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script> 
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
	
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
					weUI.confirm({
						content : "您确认服务已经结束了吗?",
						ok: function(){
							_this.confirmMeetEnd();
							weUI.closeConfirm();
						}
					});
					
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
							content : "活动已结束，等待用户评价~",
							ok: function(){
								window.location.href="../go/myono.html?type=mycreate";
								weUI.closeAlert();
							}
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
						required: true
					},
					ruleMessages: {
						required: "请填写第一个预期开始时间"
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
						required: true
					},
					ruleMessages: {
						required: "请填写第二个预期开始时间"
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
						weUI.alert({content:"约见地点设置成功,等待用户确认",
							ok: function(){
								window.location.href="../go/mycreateonodetail.html?goId="+_this.getPropertyValue("goId");
								weUI.closeAlert();
							}
						});
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
	jeDate({
		dateCell:"#expectedTime1",
		format:"YYYY-MM-DD hh:mm",
		isTime:true, 
		minDate:jeDate.now(0)
	});
	
	jeDate({
		dateCell:"#expectedTime2",
		format:"YYYY-MM-DD hh:mm",
		isTime:true,
		minDate:jeDate.now(0)
	});
	
	var b = new $.HarborBuilder();
	b.buildFooter();

	var p = new $.GoHainiuAppointmentPage({ 
		goId:  "<c:out value="${goOrder.goId}"/>",
		goOrderId:  "<c:out value="${goOrder.orderId}"/>"
	});
	p.init();
});
</script>
</html>