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
<title>支付费用</title>
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
				<img src="//static.tfeie.com/images/img23.png">
			</p>
			<section class="monry-info">
				<p>
					<label>海外市场如此sexy</label>
				</p>
				<p>待支付</p>
				<p>
					<span>0.01</span>元
				</p>

				<section class="sec_btn2">
					<a href="javascript:void(0)" id="HREF_GO_PAY">立即支付</a>
				</section>

				<p class="tishi">
					<img src="//static.tfeie.com/images/img24.png">海牛3个工作日没有确认，自动退款
				</p>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$("#HREF_GO_PAY").bind("click",function(){
		var orderId = "1123411231212121";
		var orderAmount = "0.01";
		location.href="../payment/getAuthorizeCode?orderId=" + orderId + "&orderAmount=" + orderAmount;
	})
})
	
</script>
</html>