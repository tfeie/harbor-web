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
<title>兴趣技能</title>
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
	<section class="skill_top">
		<p>请告诉Calypso，该怎样取悦你呢…</p>
	</section>
	<section class="tab">
		<section class="tab_title">
			<p>
				兴趣标签<span>(1/6)</span>
			</p>
		</section>
		<section class="tab_con">
			<section class="tab_location1">
				<a href="#">水上运动</a>
			</section>
			<section class="tab_location2">
				<a href="#">健身</a>
			</section>
			<section class="tab_location3">
				<a href="#">艺术</a>
			</section>
			<section class="tab_location4">
				<a href="#">旅游</a>
			</section>
			<section class="tab_location5">
				<a href="#">公益</a>
			</section>
			<section class="tab_location6">
				<a href="#">新媒体</a>
			</section>
		</section>
	</section>
	<section class="tab in">
		<section class="tab_title">
			<p>
				兴趣标签<span>(4/6)</span>
			</p>
		</section>
		<section class="tab_con">
			<section class="tab_location1">
				<a href="#">水上运动</a>
			</section>
			<section class="tab_location2">
				<a href="#">健身</a>
			</section>
			<section class="tab_location3">
				<a href="#">艺术</a>
			</section>
			<section class="tab_location4">
				<a href="#">旅游</a>
			</section>
			<section class="tab_location5">
				<a href="#">公益</a>
			</section>
			<section class="tab_location6">
				<a href="#">新媒体</a>
			</section>
		</section>
	</section>
	<section class="but_baoc on in">
		<p>
			<a href="#">确认</a>
		</p>
	</section>
</body>
</html>