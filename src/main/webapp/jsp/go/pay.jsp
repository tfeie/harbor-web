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
<title>Go预约</title>
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
<body>
	<section class="hailiuqueren">
		<section class="haiuliu-top monry">
			<p class="bgcolor">
				<label></label>
			</p>
			<div class="clear"></div>
			<p class="back">
				<i><a></a></i><i><a class="on"></a></i><i></i><i></i><i></i>
			</p>
			<p>
				<span>预约</span><span class="on">支付费用</span><span class="in">海牛确认</span><span
					class="in">约见</span><span class="in">评价</span>
			</p>
		</section>

		<section class="feiyong">
			<p>
				<img src="${_base }/resources/img/img23.png">
			</p>
			<section class="monry-info">
				<p>
					<label>海外市场如此sexy</label>
				</p>
				<p>待支付</p>
				<p>
					<span>36.00</span>元
				</p>

				<section class="sec_btn2">
					<a href="">立即支付</a>
				</section>

				<p class="tishi">
					<img src="${_base }/resources/img/img24.png">海牛3个工作日没有确认，自动退款
				</p>
			</section>
		</section>
	</section>
</body>
</html>