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
					<textarea>希望海牛分享的经验或解答的疑惑...
1. 
2. 
3. 
</textarea>
				</p>
			</section>

			<section class="qingjiao">
				<p>自我介绍（至少20字）</p>
			</section>

			<section class="yuyue-textarea">
				<p>
					<textarea>说说你自己吧，让海牛了解你，更好为你服务</textarea>
				</p>
			</section>

			<section class="sec_btn2">
				<a href="#">预约, 去支付</a>
			</section>
		</section>
	</section>
</body>
</html>