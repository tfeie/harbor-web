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
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title>名片</title>
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
<body class="barn">
	<section class="mingpian">
		<section class="uk">
			<p>UK-000001</p>
		</section>
		<section class="touxing_logo">
			<p>
				<span><img src="${_base }/resources/img/img6.png"></span>
			</p>
		</section>
		<section class="per_info">
			<p class="name">
				<span>Candy</span><label>英国</label><i>已认证</i>
			</p>
			<p class="pengyou">
				<a href="#">益友 10</a><a href="#" class="on">助人 10</a><a href="#">公益贝
					100</a>
			</p>
			<p class="aihao">健身 / 游泳 / 水上运动 / 旅游 / 摄影 / 马术</p>
			<p>金融</p>
			<p>北京</p>
			<p class="aihao">金融 / 设计 / 新媒体 / 人才管理</p>
			<p class="but">
				<a href="#">分享</a><a href="#">应邀</a>
			</p>
			<div class="clear"></div>
			<p>（Cindy还剩 3 个邀请名额）</p>
			<p>海湾，我们的舞台...</p>
		</section>
	</section>
</body>
</html>