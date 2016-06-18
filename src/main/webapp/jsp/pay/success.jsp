<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta content="telephone=no" name="format-detection" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="#035c9b">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>支付成功</title>
<link rel="dns-prefetch" href="//static.tfeie.com" />
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
</head>
<body class="bg-eeeeee">
	<section class="zfcg_main pad-10">

		<div class="te-cen mar-top-50">
			<img src="//static.tfeie.com/v2/images/btn-qr.png" width="100"
				height="100">
		</div>
		<p class="te-cen fs-15 fc-fe6847 mar-top-10">支付成功</p>
		<p class="te-cen fs-30 line-30 pad-10-0">￥3200</p>
		<a href="#"><img src="//static.tfeie.com/v2/images/zf-img.jpg"
			width="100%" class="br-5 mar-top-20"></a>
		<div class="btn-main">
			<a href="#" class="btn">完成</a>
		</div>

	</section>
</body>
</html>