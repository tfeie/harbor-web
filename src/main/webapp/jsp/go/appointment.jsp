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
<title>约见</title>
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
			<p>海牛已确认！请选择时间地点</p>
		</section>

		<section class="sexy on">
			<p>海外市场如此Sexy</p>
		</section>

		<section class="touxiang-info">
			<section class="touxiang-img">
				<p>
					<span><img src="${_base }/resources/img/img21.png"></span>
				</p>
			</section>
			<section class="text-info">
				<p>
					<i>Martin</i><span>英国</span><label>已认证</label>
				</p>
				<p class="on">金融/合伙人/北京</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="wenti-jies">
			<section class="yuejian-bott">
				<p>2016-5-16 18:00 海淀区附近</p>
				<p class="on">2016-5-16 18:00 海淀区附近</p>
			</section>
			<section class="yuejian-but">
				<p>
					<a href="#">确认时间地点</a>
				</p>
			</section>
		</section>

		<section class="sec_btn2">
			<a href="#">确认服务结束</a>
		</section>
	</section>
</body>
</html>