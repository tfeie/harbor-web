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
<title>浏览个人信息</title>
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
	<section class="ip_info">
		<section class="top_info">
			<p>
				<img src="${_base }/resources/img/banner3.png">
			</p>
			<section class="ip_logo">
				<p>
					<span><img src="${_base }/resources/img/icon18.png" /></span>
				</p>
			</section>
		</section>

		<section class="ip_name">
			<p>
				<span>Martin</span><label>英国</label>已认证
			</p>
		</section>
		<section class="ip_shengf">
			<p>金融/合伙人/北京</p>
		</section>

		<section class="ip_eng">
			<p>If you can't explain it simply, you don't understand it well
				enough.</p>
		</section>

		<section class="ip_aihao">
			<p>
				<span>健身</span><span>游泳</span><span>高尔夫</span><span>健身</span><span>游泳</span><span>高尔夫</span>
			</p>
		</section>
		<section class="ip_smone">
			<p>Cambridge College</p>
			<p>Single</p>
			<p>双子</p>
		</section>

		<section class="ip_jineng">
			<p>
				<span>绘画</span><span>摄影</span><span>统计学</span><span>股票</span><span>法律</span>
			</p>
		</section>

		<section class="ip_zhiwei">
			<p>132*****251</p>
			<p>金融业</p>
			<p>北京搜狐金融有限公司</p>
			<p>业务经理</p>
		</section>

		<section class="but_baoc on">
			<p>
				<a href="#">申请认证</a>
			</p>
		</section>
		<section class="zhangdemei">
			<p>(据说长得美的都认证了....)</p>
		</section>

		<section class="ip_bianji">
			<p>
				<a href="#">编辑信息</a>
			</p>
		</section>
	</section>
</body>
</html>