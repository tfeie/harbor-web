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
<link rel="dns-prefetch" href="http://static.tfeie.com" />
<title>预约</title>
<link rel="stylesheet" type="text/css"
	href="http://static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="http://static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>


</head>
<body class="body">
	<section class="hailiuqueren yuejian">
		<section class="haiuliu-top">
			<p class="bgcolor">
				<label class="on1"></label>
			</p>
			<div class="clear"></div>
			<p class="back">
				<i><a class="on"></a></i><i></i><i></i><i></i><i></i>
			</p>
			<p>
				<span class="on">预约</span><span class="in">支付费用</span><span
					class="in">海牛确认</span><span class="in">约见</span><span class="in">评价</span>
			</p>
		</section>

		<section class="mar-juli"></section>

		<section class="yuejian-think">
			<section class="qingjiao">
				<p>想请教的问题（至少20字）</p>
			</section>

			<section class="jingyan-text">
				<p>
					<textarea id="questions" placeholder="希望海牛分享的经验或解答的疑惑..."></textarea>
				</p>
			</section>

			<section class="qingjiao">
				<p>自我介绍（至少20字）</p>
			</section>

			<section class="yuyue-textarea">
				<p>
					<textarea id="selfIntro" placeholder="说说你自己吧，让海牛了解你，更好为你服务"></textarea>
				</p>
			</section>

			<section class="but_baoc">
				<p>
					<input type="button" id="BTN_SUBMIT" value="预约, 去支付" />
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
<script type="text/javascript">
(function($){
	$.OrderGoPage = function(data){
		this.settings = $.extend(true,{},$.OrderGoPage.defaults);
		this.params= data?data:{}
	}
	$.extend($.OrderGoPage,{
		defaults: { 
		},
	
		prototype: {
			init: function(){
				this.bindEvents(); 
			},
			
			bindEvents: function(){
				var _this = this; 
				//提交事件
				$("#BTN_SUBMIT").on("click",function(){
					_this.submit();
				});
			},
			
			getPropertyValue: function(propertyName){
				if(!propertyName)return;
				return this.params[propertyName];
			},
			
			submit: function(){
				var _this = this;
				var questions = $.trim($("#questions").val());
				var selfIntro = $.trim($("#selfIntro").val());
				var valueValidator = new $.ValueValidator();
				valueValidator.addRule({
					labelName: "想请教的问题",
					fieldName: "questions",
					getValue: function(){
						return questions;
					},
					fieldRules: {
						required: true, 
						cnlength: 200
					},
					ruleMessages: {
						required: "请填写想请教的问题",
						cnlength:"想请教的问题不能超过100个汉字"
					}
				}).addRule({
					labelName: "自我介绍",
					fieldName: "selfIntro",
					getValue: function(){
						return selfIntro;
					},
					fieldRules: {
						required: true, 
						cnlength: 200
					},
					ruleMessages: {
						required: "请填写自我介绍",
						min: "自我介绍不少于20个汉字",
						cnlength:"自我介绍不能超过100个汉字"
					}
				});
				
				var res=valueValidator.fireRulesAndReturnFirstError();
				if(res){
					weUI.showXToast(res);
					setTimeout(function () {
						weUI.hideXToast();
		            }, 1000);
					return;
				}
				
				var data = {
					goId: _this.getPropertyValue("goId"),
					selfIntro: selfIntro, 
					questions: questions
				} 
				ajaxController.ajax({
					url: "../go/orderOneOnOne",
					type: "post", 
					data: data ,
					success: function(transport){
						var goOrderId = transport.data;
						weUI.showXToast("活动预约成功，进入支付");
						setTimeout(function () {
							weUI.hideXToast();
							window.location.href="../go/toPay.html?goOrderId="+goOrderId;
			            }, 1000);
						//禁止提交
						$("#BTN_SUBMIT").attr({"disabled":"disabled"});
					},
					failure: function(transport){
						weUI.showXToast(transport.statusInfo);
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
					}
					
				});
				
			}
		}
	});
})(jQuery);

$(document).ready(function(){
	var p = new $.OrderGoPage({
		goId:  "<c:out value="${goId}"/>"
	});
	p.init();
});
</script>
</html>