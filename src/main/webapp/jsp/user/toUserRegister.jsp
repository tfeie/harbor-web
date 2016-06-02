<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
<!-- 预解析DNS，减少用户访问资源时候解析DNS带来的响应损失 -->
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title>用户注册</title>
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
		<div class="div_six">
			<span><i class="on"><img src="//static.tfeie.com/images/boy.png" /></i></span> <span><i><img
					src="//static.tfeie.com/images/girl.png" /></i></span> <span><i><img src="//static.tfeie.com/images/other.png" /></i></span>
		</div>
		<div class="div_input">
			<div class="item">
				<span><input type="text" name=""
					placeholder="请输入英文名ie.Martin" /></span>
			</div>
			<section class="sel_con zhuche">
				<p class="boss">
					<select><option>请选择留学国家</option>
						<option>UK-英国</option></select>
				</p>
			</section>
			<section class="sel_con zhuche">
				<p class="boss2">
					<select><option>请选择所在行业</option>
						<option>UK-英国</option></select>
				</p>
			</section>
			<div class="item">
				<span><input type="text" id="phoneNumber"
					placeholder="请输入手机号码/Email(国外)" /></span>
			</div>
			<div class="item">
				<span><input type="text" name="" placeholder="请输入验证码" /></span><a
					href="javascript:void(0)" class="send_yzm">发送验证码</a>
			</div>
			<div class="message-err">
				<!-- 
				<p>
					<span>X</span>验证码错误
				</p>
				 -->
			</div>
			<div class="item_btn">
				<a href="javascript:void(0)" id="HREF_CONFIRM">确认注册</a>
			</div>
		</div>

	</section>
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
				},
				
				bindEvents: function(){
					var _this = this;
					$("#HREF_CONFIRM").bind("click",function(){
						alert("注册");
					});
					$(".send_yzm").bind("click",function(){
						_this.sendRandomCode();
					})
				},
				
				sendRandomCode: function(){
					var _this = this;
					var phoneNumber = $.trim($("#phoneNumber").val());
					if(phoneNumber==""){
						_this.showError("请输入手机号码");
						return ;
					}
					ajaxController.ajax({
						url: "../user/getRandomCode",
						type: "post",
						data: {
							phoneNumber: phoneNumber
						},
						success: function(transport){
							alert("验证码获取成功");
							_this.hideError();
						},
						failure: function(transport){
							_this.showError(transport.statusInfo);
						}
						
					});
				},
				
				showError: function(message){
					$(".message-err").show().html("<p><span>X</span>"+message+"</p>");
				},
				
				hideError: function(){
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
