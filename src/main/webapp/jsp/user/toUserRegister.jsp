<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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

<title>海友注册</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>
<style>
.off_send_yzm{ white-space: nowrap; display: block; text-align: center; line-height: 2.5em;background: #D1D1D1; color:#fff; border-radius: 5px; margin-left:0.8em; width:10em;}
</style>
</head>

<body css="body_css"
	style="background: url(//static.tfeie.com/images/aimg1.png) no-repeat center center; background-size: cover; padding-bottom: 2em;">
	<div class="mask1"></div>
	<section class="sec_top">
		<div class="img">
			<img src="//static.tfeie.com/images/img3.png" />
		</div>
		<div class="text">
			<h2>海湾，我们的舞台</h2>
		</div>
	</section>



	<section class="zhuce">
		<div class="div_six" id="DIV_SEX">
			<span><i class="on"><input type="hidden" value="1"/><img src="//static.tfeie.com/images/boy.png" /></i></span> <span><i><input type="hidden" value="2"/><img
					src="//static.tfeie.com/images/girl.png" /></i></span> <span><i><input type="hidden" value="0"/><img src="//static.tfeie.com/images/other.png" /></i></span>
		</div>
		<div class="div_input">
			<div class="item">
				<span><input type="text" id="enName"
					placeholder="请输入英文名ie.Martin" /></span>
			</div>
			<section class="sel_con zhuche">
				<p class="boss">
					<select id="countryCode"><option value="">请选择留学国家</option>
					</select>
				</p>
			</section>
			<section class="sel_con zhuche">
				<p class="boss2">
					<select id="industryCode"><option value="">请选择所在行业</option>
					</select>
				</p>
			</section>
			<div class="item">
				<span><input type="text" id="phoneNumber"
					placeholder="请输入手机号码" /></span>
			</div>
			<div class="item">
				<span><input type="text" id="randomCode" placeholder="请输入6位数字验证码" /></span><a
					href="javascript:void(0)" class="send_yzm" id="HREF_SEND_CODE">发送验证码</a>
			</div>
			<div class="message-err"> 
			</div>
			<section class="but_baoc on zhuc">
				<p>
					<a href="javascript:void(0)" id="HREF_CONFIRM">确认注册</a>
				</p>
			</section>
		</div>

	</section>
	

	<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
	<script type="text/javascript">
	(function($){
		$.UserRegisterPage = function(){
			this.settings = $.extend(true,{},$.UserRegisterPage.defaults);
		}
		$.extend($.UserRegisterPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents();
					this.getAllHyCountries();
					this.getAllHyIndustries();
					this.bindRules();
				},
				
				bindRules: function(){
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "性别",
						fieldName: "sex",
						getValue: function(){
							var sex = $("#DIV_SEX").find(".on").find("input:hidden").val();
							return sex;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择性别"
						}
					}).addRule({
						labelName: "英文名",
						fieldName: "enName",
						getValue: function(){
							return $("#enName").val();
						},
						fieldRules: {
							required: true,
							notContainCN:true,
							cnlength:10
						},
						ruleMessages: {
							required: "请输入英文名",
							notContainCN:"英文名不能包含中文",
							cnlength:"英文名长度不能超过10个字符"
						}
					}).addRule({
						labelName: "留学国家",
						fieldName: "countryCode",
						getValue: function(){
							return $("#countryCode").val();
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择留学国家"
						}
					}).addRule({
						labelName: "所在行业",
						fieldName: "industryCode",
						getValue: function(){
							return $("#industryCode").val();
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择所在行业"
						}
					}).addRule({
						labelName: "手机号码",
						fieldName: "phoneNumber",
						getValue: function(){
							return $("#phoneNumber").val();
						},
						fieldRules: {
							required: true,
							phonenumber:true
						},
						ruleMessages: {
							required: "请输入手机号码",
							phonenumber:"手机号码格式不正确"
						}
					}).addRule({
						labelName: "验证码",
						fieldName: "randomCode",
						getValue: function(){
							return $("#randomCode").val();
						},
						fieldRules: {
							required: true, 
							numberlength:6
						},
						ruleMessages: {
							required: "请输入验证码",
							numberlength:"验证码必须是六位数字"
						}
					});
					this.valueValidator =valueValidator;
				},
				
				bindEvents: function(){
					var _this = this;
					$("#HREF_CONFIRM").bind("click",function(){
						var res=_this.valueValidator.fireRulesAndReturnFirstError();
						if(res){
							_this.showError(res);
							return;
						}
						_this.hideMessage();
						_this.submit();
						
					});
					_this.bindYZMEvent();
				},
				
				bindYZMEvent: function(){
					var _this = this;
					$("#HREF_SEND_CODE").removeClass("off_send_yzm").addClass("send_yzm").unbind("click").bind("click",function(){
						_this.sendRandomCode();
					})
				},
				
				unBindYZMEvent: function(){
					$("#HREF_SEND_CODE").removeClass("send_yzm").addClass("off_send_yzm").unbind("click");
				},
				
				submit: function(){
					var sex = $("#DIV_SEX").find(".on").find("input:hidden").val();
					alert(sex);
				},
				
				
				getAllHyCountries: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../sys/getAllHyCountries",
						type: "post", 
						success: function(transport){
							var data =transport.data;
							_this.fillCountriesSelelct(data);
						},
						failure: function(transport){
							_this.fillCountriesSelelct([]);
						}
						
					});
				},
				
				fillCountriesSelelct: function(data){
					$.each(data,function(i,d){
						$("#countryCode").append("<option value='"+ d.countryCode+"'>"+d.countryCode+"-"+d.countryName+"</option>");
					}) 
				},
				
				getAllHyIndustries: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../sys/getAllHyIndustries",
						type: "post", 
						success: function(transport){
							var data =transport.data;
							_this.fillIndustriesSelelct(data);
						},
						failure: function(transport){
							_this.fillIndustriesSelelct([]);
						}
						
					});
				},
				
				fillIndustriesSelelct: function(data){
					$.each(data,function(i,d){
						$("#industryCode").append("<option value='"+ d.industryCode+"'>"+d.industryName+"</option>");
					}) 
				},
				
				sendRandomCode: function(){
					var _this = this; 
					var result = _this.valueValidator.fireFieldRule("phoneNumber");
					if(result){
						_this.showError(result);
						return ;
					}else{
						_this.hideMessage();
					} 
					this.waitSeconds=60; 
					this.unBindYZMEvent();
				    $("#HREF_SEND_CODE").text("重发(" + this.waitSeconds + "秒)");
				    InterValObj = window.setInterval(function(){
				    	_this.randomCodeInterval(InterValObj);
				    }, 1000);
				     
				    var phoneNumber =  $.trim($("#phoneNumber").val());
					ajaxController.ajax({
						url: "../user/getRandomCode",
						type: "post",
						data: {
							phoneNumber: phoneNumber
						},
						success: function(transport){
							_this.showSuccess("验证码获取成功");
							_this.unBindYZMEvent();
							
						},
						failure: function(transport){
							_this.showError(transport.statusInfo);
						}
						
					});
				},
				
				randomCodeInterval: function(InterValObj){
					console.log(this.waitSeconds);
			        if (this.waitSeconds == 0) {                
			            window.clearInterval(InterValObj);//停止计时器
			            $("#HREF_SEND_CODE").text("发送验证码");
			            this.bindYZMEvent();
			        }
			        else {
			        	this.waitSeconds--;
			        	$("#HREF_SEND_CODE").text("重发(" + this.waitSeconds + "秒)");
			        }
				},
				
				showError: function(message){
					$(".message-err").show().html("<p><span>X</span>"+message+"</p>");
				},
				
				showSuccess: function(message){
					$(".message-err").show().html("<p><span></span>"+message+"</p>");
				},
				
				hideMessage: function(){
					$(".message-err").html("").hide();
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var p = new $.UserRegisterPage();
		p.init();
	});
	</script>

</body>

</html>
