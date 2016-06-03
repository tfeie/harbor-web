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
<title>DEMO页面</title>
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
		<section class="shouji">
			<p class="title">
				<span>APP</span><label></label>
			</p>
			<p class="on1">
				<span>APP主页</span><label><a href="../be/index.html">Go</a></label>
			</p> 
		</section>
		<section class="shouji">
			<p class="title">
				<span>用户相关</span><label></label>
			</p>
			<p class="on1">
				<span>注册</span><label><a href="../user/toUserRegister.html">Go</a></label>
			</p>
			<p class="on1">
				<span>申请认证</span><label><a
					href="../user/toApplyCertficate.html">Go</a></label>
			</p>
			<p class="on1">
				<span>个人信息</span><label><a href="../user/userInfo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>会员中心</span><label><a href="../user/memberCenter.html">Go</a></label>
			</p>
			<p class="on1">
				<span>个人中心</span><label><a href="../user/userCenter.html">Go</a></label>
			</p>
			<p class="on1">
				<span>编辑个人信息</span><label><a
					href="../user/editUserInfo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>名片</span><label><a href="../user/getUserCard.html">Go</a></label>
			</p>
			<p class="on1">
				<span>我的财富</span><label><a href="../user/userWealth.html">Go</a></label>
			</p>
			<p class="on1">
				<span>兴趣技能</span><label><a href="../user/setUserSkills.html">Go</a></label>
			</p>
		</section>

		<section class="shouji">
			<p class="title">
				<span>G&O相关</span><label></label>
			</p>
			<p class="on1">
				<span>发布G&O</span><label><a href="../go/publishGo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>预约</span><label><a href="../go/toOrder.html">Go</a></label>
			</p>
			<p class="on1">
				<span>支付费用</span><label><a href="../go/toPay.html">Go</a></label>
			</p>
			<p class="on1">
				<span>海牛确认</span><label><a href="../go/toConfirm.html">Go</a></label>
			</p>
			<p class="on1">
				<span>约见</span><label><a href="../go/toAppointment.html">Go</a></label>
			</p>
			<p class="on1">
				<span>评价</span><label><a href="../go/toFeedback.html">Go</a></label>
			</p>
			<p class="on1">
				<span>审核信息</span><label><a href="../go/confirmlist.html">Go</a></label>
			</p>
			<p class="on1">
				<span>主题详情</span><label><a href="../go/godetail.html">Go</a></label>
			</p>
			<p class="on1">
				<span>GROUP首页</span><label><a href="../go/groupindex.html">Go</a></label>
			</p>
			<p class="on1">
				<span>One On One首页</span><label><a
					href="../go/oneononeindex.html">Go</a></label>
			</p>
			<p class="on1">
				<span>group评价</span><label><a href="../go/comments.html">Go</a></label>
			</p>
		</section>
	</section>
</body>
</html>