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
<title></title>
<script type="text/javascript"
	src="${_base }/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${_base }/resources/js/main.js"></script>
<link rel="stylesheet" type="text/css"
	href="${_base }/resources/css/style.css">
<script type="text/javascript"
	src="${_base }/resources/js/owl.carousel.js"></script>
<link rel="stylesheet" type="text/css"
	href="${_base }/resources/css/owl.carousel.min.css">
</head>
<body css="body_css"
	style="background: url(${_base }/resources/img/banner2.png) no-repeat center center; background-size: cover">
	<div class="mask1"></div>
	<section class="sec_top">
		<div class="img">
			<img src="${_base }/resources/img/img3.png" />
		</div>
		<div class="text">
			<h2>海湾，我们的舞台</h2>
		</div>
	</section>



	<section class="zhuce">
		<div class="div_six">
			<span><a class="on"><img
					src="${_base }/resources/img/boy.png" /></a></span> <span><a><img
					src="${_base }/resources/img/girl.png" /></a></span>
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
			<div class="item_btn">
				<a href="">确认注册</a>
			</div>
		</div>

	</section>

</body>
</html>