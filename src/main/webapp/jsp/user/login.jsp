<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- 预解析DNS，减少用户访问资源时候解析DNS带来的响应损失 -->
<link rel="dns-prefetch" href="//static.tfeie.com" />
<link rel="dns-prefetch" href="//harbor.tfeie.com" />

<title>登录</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/json2.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<style>
.off_send_yzm {
	white-space: nowrap;
	display: block;
	text-align: center;
	line-height: 2.5em;
	background: #D1D1D1;
	color: #fff;
	border-radius: 5px;
	margin-left: 0.8em;
	width: 10em;
}
</style>
</head>
<body>

    <section  id="scroller">
        <section class="weblogin-main">
            <div class="logo"><img src="//static.tfeie.com/v2/images/logo.png" width="120"></div>
            <div class="itms-form">
            	<input type="text" class="In-text" placeholder="请输入您的手机号" id="mobilePhone">
            </div>
            <div class="itms-form">
            	<input type="text" class="In-text" placeholder="验证码" id="randomCode">
                <input type="button" value="获取验证码"  class="btn-yzm" id="btn-yzm">      
            </div>
            
              <input type="submit" class="In-btn-sub" value="登录" id="BTN_LOGIN">
        </section>
    </section>
 
	<script type="text/javascript">
	(function($){
		$.UserLoginPage = function(data){
			this.settings = $.extend(true,{},$.UserLoginPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.UserLoginPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindRules();
					this.bindEvents();  
				},
				
				bindRules: function(){
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "手机号码",
						fieldName: "mobilePhone",
						getValue: function(){
							return $("#mobilePhone").val();
						},
						fieldRules: {
							required: true,
							phonenumber:true
						},
						ruleMessages: {
							required: "请输入手机号码",
							phonenumber:"手机号码不正确"
						}
					}).addRule({
						labelName: "验证码",
						fieldName: "randomCode",
						getValue: function(){
							return $("#randomCode").val();
						},
						fieldRules: {
							required: true, 
							numberlength:4
						},
						ruleMessages: {
							required: "请输入验证码",
							numberlength:"验证码为4位数"
						}
					});
					this.valueValidator =valueValidator;
				},
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				},
				
				bindEvents: function(){
					var _this = this;
					$("#BTN_LOGIN").bind("click",function(){
						_this.login();
						
					});
					_this.bindYZMEvent();
				},
				
				bindYZMEvent: function(){
					var _this = this;
					$("#btn-yzm").addClass("send_yzm").unbind("click").bind("click",function(){
						_this.sendRandomCode();
					})
				},
				
				unBindYZMEvent: function(){
					$("#btn-yzm").addClass("off_send_yzm").unbind("click");
				},
				
				login: function(){
					var _this=this;
					
					var res=_this.valueValidator.fireRulesAndReturnFirstError();
					if(res){
						weUI.showXToast(res);
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return;
					}
					
					var mobilePhone= $.trim($("#mobilePhone").val());
					var randomCode= $.trim($("#randomCode").val());
					
					ajaxController.ajax({
						url: "../user/login",
						type: "post",
						data: {
							mobilePhone: mobilePhone,
							randomCode: randomCode
						},
						success: function(transport){
							weUI.showXToast("登录成功");
							var redirectURL = _this.getPropertyValue("redirectURL");
							setTimeout(function () {
								weUI.hideXToast();
								if(redirectURL!=""){
									window.location.href=redirectURL;
								}
								//window.location.href="../user/setUserSkills.html"
				            }, 1000);
						},
						failure: function(transport){
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
						
					});
				},
				
				sendRandomCode: function(){
					var _this = this; 
					var result = _this.valueValidator.fireFieldRule("mobilePhone");
					if(result){
						weUI.showXToast(result);
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return ;
					}
					this.waitSeconds=60; 
					
				     
				    var mobilePhone =  $.trim($("#mobilePhone").val());
					ajaxController.ajax({
						url: "../user/getLoginRandomCode",
						type: "post",
						data: {
							mobilePhone: mobilePhone
						},
						success: function(transport){
							weUI.showXToast("验证码发送成功");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
							_this.unBindYZMEvent();
						    $("#btn-yzm").val("重发(" + _this.waitSeconds + "秒)");
						    InterValObj = window.setInterval(function(){
						    	_this.randomCodeInterval(InterValObj);
						    }, 1000);
							
						},
						failure: function(transport){
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
						
					});
				},
				
				randomCodeInterval: function(InterValObj){
					console.log(this.waitSeconds);
			        if (this.waitSeconds == 0) {                
			            window.clearInterval(InterValObj);//停止计时器
			            $("#btn-yzm").val("发送验证码");
			            this.bindYZMEvent();
			        }
			        else {
			        	this.waitSeconds--;
			        	$("#btn-yzm").val("重发(" + this.waitSeconds + "秒)");
			        }
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var p = new $.UserLoginPage();
		p.init({
			redirectURL: "<c:out value="${redirectURL}"/>"
		});
	});
	</script>

</body>

</html>
