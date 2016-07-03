<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>邀约详情</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
</head>
<body>
	<section class="mainer in">
		<section class="ma_shenghe">
			<p>
				<c:out value="${go.topic}" />
			</p>
		</section>
		<section class="shenhe_xinxi">
			<section class="info_fuwu">
				<section class="ip_info">
					<section class="info_img">
						<span><img src="<c:out value="${go.wxHeadimg}"/>"></span>
					</section>
					<section class="ip_text">
						<p>
							<span><c:out value="${go.enName}" /></span><label class="lbl2"><c:out
									value="${go.abroadCountryName}" /></label>
							<c:out value="${go.userStatusName}" />
						</p>
						<p>
							<c:out value="${go.industryName}" />
							/
							<c:out value="${go.title}" />
							/
							<c:out value="${go.atCityName}" />
						</p>
					</section>
					<div class="clear"></div>
				</section>
				<section class="info_time">
					<p>
						<span><c:out value="${go.expectedStartTime}" /></span><a href="#"><c:out value="${go.orgModeName}" /></a>
					</p>
				</section>
				<section class="info_time back1">
					<p>
						<span>Group邀请<c:out value="${go.inviteMembers}" />人</span><a href="#"><c:out value="${go.fixPriceYuan}" />元</a>
					</p>
				</section>
				<section class="info_time back2">
					<p>
						<span><c:out value="${go.location}" /></span>
					</p>
				</section>
				<section class="info_fangf pz">
					<p><c:out value="${go.contentSummary}" /></p>
				</section>
				<div class="clear"></div>
			</section>
			<section class="num_liulan">
				<p>
					<a href="#">浏览 126</a><a href="#">参加 126</a><a href="#">收藏 12</a>
				</p>
			</section>
		</section>
		<section class="yanbaoming">
			<section class="yaoy">
				<p>
					<span>我请客</span>
					<button>
						<img src="//static.tfeie.com/images/img58.png">我要报名
					</button>
				</p>
			</section>
		</section>
	</section>
</body>
</html>