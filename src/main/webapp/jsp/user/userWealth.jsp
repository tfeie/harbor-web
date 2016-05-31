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
<title>我的财富</title>
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
	<section class="my_price">
		<section class="price_top">
			<p>
				<span>积分</span><label>19200</label>
			</p>
			<p class="on">
				<span>被赞</span><i>还差<a>12</a>个可获得奖励海贝
				</i><label>3000</label>
			</p>

		</section>

		<section class="shouji">
			<p class="title">
				<span>海贝收支</span><label></label>
			</p>
			<p class="on1">
				<span>被赏海贝</span><label>100</label>
			</p>
			<p class="on2">
				<span>奖励海贝</span><label>1000</label>
			</p>
			<p class="on3">
				<span>打赏海贝</span><label>200</label>
			</p>
			<p class="on4">
				<span>公益支出</span><label>888</label>
			</p>
		</section>

		<section class="keyong">
			<p>
				<span>可用海贝<i>170</i></span><a href="#">购贝</a>
			</p>
			<p class="on">
				<span>现金余额<i>2000.00</i></span><a href="#">充值</a><a href="#"
					class="on">提现</a>
			</p>
		</section>
	</section>
</body>
</html>