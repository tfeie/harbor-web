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

</head>
<script type="text/javascript">
var Manager;
$(document).ready(function() {
	Manager = new $.Manager();
});
(function() {
	$.Manager = function() {
		this.settings = $.extend(true, {}, $.Manager.defaults);
		this.init();
	};
	$.extend($.Manager, {
		defaults : {
		},
		prototype : {
			init : function() {
				var ss = ${userInfo};
				var wxInfo = jQuery.parseJSON(${userInfo});
				alert(wxInfo);
				
			}
		}
	});
})(jQuery);
</script>

<body css="body_css"
	style="background: url(//static.tfeie.com/images/aimg1.png) no-repeat center center; background-size: cover; background-attachment: fixed;">
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
			<span><i class="on"><img
					src="//static.tfeie.com/images/boy.png" /></i></span> <span><i><img
					src="//static.tfeie.com/images/girl.png" /></i></span>
		</div>
		<div class="div_input">
			<div class="item">
				<span><input type="text" name=""
					placeholder="请输入英文名ie.Martin" /></span>
			</div>
			<div class="item">
				<span><select><option>UK-英国</option></select></span>
			</div>
			<div class="item">
				<span><input type="text" name="" placeholder="请输入留学学校英文名称" /></span>
			</div>
			<div class="item">
				<span><input type="text" name=""
					placeholder="请输入手机号码/Email(国外)" /></span>
			</div>
			<div class="item">
				<span><input type="text" name="" placeholder="请输入验证码" /></span><a
					href="" class="send_yzm">发送验证码</a>
			</div>
			<div class="message-err">
				<p>
					<span>X</span>验证码错误
				</p>
			</div>
			<div class="item_btn">
				<a href="">确认注册</a>
			</div>
		</div>

	</section>
</body>
</html>