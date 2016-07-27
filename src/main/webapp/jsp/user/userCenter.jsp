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
<title>个人中心</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>

</head>
<body>
	<section class="ip2_zhongxin">
		<section class="ip2_top">
			<p>
				<img src="<c:out value="${userInfo.homePageBg}"/>">
			</p>
			<section class="ip_logo ip2">
				<p>
					<span><a
						href="../user/editUserInfo.html?userId=<c:out value="${userInfo.userId}"/>"><img
							src="<c:out value="${userInfo.wxHeadimg}"/>"> </a></span>
				</p>
			</section>
		</section>

		<section class="ip_name ip2">
			<p>
				<span><c:out value="${userInfo.enName}" /></span><label class="lbl2" style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out
						value="${userInfo.abroadCountryName}" /></label>
				<c:out value="${userInfo.userStatusName}" />
			</p>
		</section>
		<section class="ip_shengf ip2">
			<p>
				<c:out value="${userInfo.employmentInfo}" />

			</p>
			<p>
				<span style="display:none"><a href="#"><img
						src="//static.tfeie.com/images/icon19_1.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_2.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_3.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_4.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_5.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_6.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_7.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_8.png"></a><a href="#"><img
						src="//static.tfeie.com/images/icon19_9.png"></a></span>
			</p>
		</section>

		<section class="ip2_pengyou">
			<ul>
				<li><a href="#"><span>0</span><label>升级中</label></a></li>
				<li><a href="#"><span>0</span><label>升级中</label></a></li>
				<li><a href="../user/myguanzhu.html"><span><c:out
								value="${guanzhuCount}" /></span><label>关注</label></a></li>
				<li><a href="../user/myfans.html"><span><c:out
								value="${fansCount}" /></span><label>粉丝</label></a></li>
			</ul>
			<div class="clear"></div>
		</section>

		<section class="ip2_my">
			<section class="ip2_wid">
				<p class="ip2_1">
					<a href="../go/myjointgoes.html?goType=group">我参加的</a>
				</p>
				<p class="ip2_2">
					<a href="../be/mybe.html?type=mycreate">我发起的</a>
				</p>
				<p class="ip2_3">
					<a href="../be/mybe.html?type=myfavor">我的收藏</a>
				</p>
			</section>
		</section>

		<section class="ip2_my">
			<section class="ip2_wid">
				<p class="ip2_4">
					<a href="../be/mytimeline.html">我的时间线</a>
				</p>
				<p class="ip2_5">
					<a href="../user/getUserCard.html">我的名片</a>
				</p>
				<p class="ip2_5">
					<a href="javascript:void(0)">新功能ing</a>
				</p>
				<p class="ip2_6">
					<a href="../user/userWealth.html">财富</a>
				</p>
			</section>
		</section>

		<section class="ip2_my">
			<section class="ip2_wid">
				<p class="ip2_7" style="display:none">
					<a href="../user/memberCenter.html">会员中心</a>
				</p>
				<p class="ip2_7">
					<a href="javascript:void(0)">新功能ing</a>
				</p>
				<p class="ip2_8" style="display:none">
					<a href="#">设置</a>
				</p>
				<p class="ip2_8">
					<a href="javascript:void(0)">新功能ing</a>
				</p>
			</section>
		</section>

	</section>

</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var b = new $.HarborBuilder();
		b.buildFooter({
			showBeGoQuick : "hide"
		});
	});
</script>
</html>