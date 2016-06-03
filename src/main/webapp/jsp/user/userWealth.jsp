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
<title>我的财富</title>
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
				<span>可用海贝<i>170</i></span><input type="button" value="购贝">
			</p>
			<p class="on">
				<span>现金余额<i>2000.00</i></span><input type="button" value="充值"><input
					type="button" value="提现" class="on">
			</p>
		</section>
	</section>
	<footer class="footer">
		<ul>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f1.png" />
					</div>
					<div class="text">Be</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f2.png" />
					</div>
					<div class="text">Go</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f3.png" />
					</div>
					<div class="text">Frd</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f4.png" /><i>6</i>
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li class="on"><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>
</body>
</html>