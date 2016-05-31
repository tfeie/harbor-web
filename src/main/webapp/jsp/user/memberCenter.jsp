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
<title>会员中心</title>
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
<section class="mycenter">

	<section class="sec_item">
		<div class="div_title2">
			<h3>
				<span>会员福利介绍</span>
			</h3>
		</div>
		<div class="div_cont">
			<div class="img">
				<img src="${_base }/resources/img/pic1.png" alt="" />
			</div>
		</div>
	</section>
	<section class="sec_item">
		<div class="item">
			<span>会员到期时间</span><label>2016-05-29</label>
		</div>
		<div class="item">
			<span>购买月份</span><label><a class="on">1个月</a><a>3个月</a><a>12个月</a></label>
		</div>
		<div class="item">
			<span>应付金额</span><label><em>30</em>元</label>
		</div>
		<div class="item">
			<span>支付方式</span><label><i class="i_weixin"></i></label>
		</div>
	</section>

	<section class="sec_btn2">
		<a href="">立即购买</a>
	</section>

</section>

<footer class="footer">
	<ul>
		<li><a href="">
				<div class="img">
					<img src="${_base }/resources/img/f1.png" />
				</div>
				<div class="text">Be</div>
		</a></li>
		<li><a href="">
				<div class="img">
					<img src="${_base }/resources/img/f2.png" />
				</div>
				<div class="text">Go</div>
		</a></li>
		<li><a href="">
				<div class="img">
					<img src="${_base }/resources/img/f3.png" />
				</div>
				<div class="text">Frd</div>
		</a></li>
		<li><a href="">
				<div class="img">
					<img src="${_base }/resources/img/f4.png" /><i>6</i>
				</div>
				<div class="text">Msg</div>
		</a></li>
		<li class="on"><a href="">
				<div class="img">
					<img src="${_base }/resources/img/f5.png" />
				</div>
				<div class="text">Me</div>
		</a></li>
	</ul>
</footer>

</body>
</html>