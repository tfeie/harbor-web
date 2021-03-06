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
				<span>Beauty & Excellence</span><label>be/index.jsp-ok <a href="../be/index.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>Be详情</span><label>be/detail.jsp-ok <a href="../be/detail.html?beId=33BE0E40387F4FA4AB4982EFB1D26B57">Go</a></label>
			</p> 
			<p class="on1">
				<span>新建Be</span><label>be/publishbe.jsp-ok <a href="../be/publishbe.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>我创建的Be</span><label>be/mybe.jsp-ok <a href="../be/mybe.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>我的时间线</span><label>be/mytimeline.jsp-ok <a href="../be/mytimeline.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>测试滑动条</span><label>be/estscroll.jsp-ok <a href="../be/testscroll.html">Go</a></label>
			</p>
		</section>
		<section class="shouji">
			<p class="title">
				<span>中间页</span><label></label>
			</p>
			<p class="on1">
				<span>支付成功页</span><label>pay/success.jsp <a href="../payment/success.html">Go</a></label>
			</p> 
		</section>
		<section class="shouji">
			<p class="title">
				<span>用户相关user</span><label></label>
			</p>
			<p class="on1">
				<span>海友注册</span> <label>toUserRegister.jsp-ok <a
					href="../user/toUserRegister.html">Go</a></label>
			</p>
			<p class="on1">
				<span>申请认证</span> <label>toApplyCertficate.jsp-ok<a
					href="../user/toApplyCertficate.html">Go</a></label>
			</p>
			<p class="on1">
				<span>个人信息预览</span><label>userInfopreview.jsp-ok <a href="../user/previewUserInfo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>个人信息访客</span><label>userInfo.jsp-ok <a href="../user/userInfo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>会员中心</span><label>memberCenter.jsp-ok <a href="../user/memberCenter.html">Go</a></label>
			</p>
			<p class="on1">
				<span>个人中心2</span><label>userCenter.jsp <a href="../user/userCenter.html">Go</a></label>
			</p>
			<p class="on1">
				<span>编辑个人信息</span><label>editUserInfo.jsp -ok <a
					href="../user/editUserInfo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>名片</span><label>userCard.jsp-ok <a href="../user/getUserCard.html">Go</a></label>
			</p>
			<p class="on1">
				<span>我的财富</span><label>userWealth.jsp <a href="../user/userWealth.html">Go</a></label>
			</p>
			<p class="on1">
				<span>兴趣技能</span><label>setUserSkills.jsp-ok<a href="../user/setUserSkills.html">Go</a></label>
			</p>
			<p class="on1">
				<span>我的海友/推荐</span><label>myhaiyou.jsp-ok <a href="../user/myhaiyou.html">Go</a></label>
			</p>
			<p class="on1">
				<span>我关注的</span><label>myguanzhu.jsp-ok <a href="../user/myguanzhu.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>我的粉丝</span><label>myfans.jsp-ok <a href="../user/myfans.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>消息中心</span><label>messagecenter.jsp <a href="../user/messagecenter.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>消息内容</span><label>mymessagedetail.jsp <a href="../user/mymessagedetail.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>审核</span><label>unauthusers.jsp <a href="../user/unauthusers.html">Go</a></label>
			</p> 
			
		</section>

		<section class="shouji">
			<p class="title">
				<span>G&O相关</span><label></label>
			</p>
			<p class="on1">
				<span>发布G&O2-2</span><label>go/publishgo.jsp-ok <a href="../go/publishGo.html">Go</a></label>
			</p>
			<p class="on1">
				<span>预约</span><label>go/order.jsp-ok <a href="../go/toOrder.html?goId=DCAFD0E6D1FF4FCA906723B868CBCC95">Go</a></label>
			</p>
			<p class="on1">
				<span>支付费用</span><label>go/pay.jsp-ok <a href="../go/toPay.html">Go</a></label>
			</p>
			<p class="on1">
				<span>海牛确认</span><label>go/confirm.jsp-ok <a href="../go/toConfirm.html">Go</a></label>
			</p>
			<p class="on1">
				<span>约见</span><label>go/appointment.jsp <a href="../go/toAppointment.html">Go</a></label>
			</p>
			<p class="on1">
				<span>评价</span><label>go/feedback.jsp  <a href="../go/toFeedback.html">Go</a></label>
			</p>
			<p class="on1">
				<span>审核信息</span><label>go/confirmlist.jsp <a href="../go/confirmlist.html">Go</a></label>
			</p>
			<p class="on1">
				<span>主题详情</span><label>onodetail.jsp <a href="../go/onodetail.html">Go</a></label>
			</p>
			<p class="on1">
				<span>GO</span><label>go/goindex.jsp  <a href="../go/goindex.html">Go</a></label>
			</p>
			<p class="on1">
				<span>group评价</span><label>go/comments.jsp <a href="../go/comments.html">Go</a></label>
			</p>
			<p class="on1">
				<span>邀约详细</span><label>go/invite.jsp <a href="../go/invite.html">Go</a></label>
			</p>
			<p class="on1">
				<span>邀约详细2</span><label>go/invite2.jsp <a href="../go/invite2.html">Go</a></label>
			</p>
			<p class="on1">
				<span>我创建的group</span><label>mygroup.jsp-ok <a href="../go/mygroup.html">Go</a></label>
			</p> 
			<p class="on1">
				<span>我创建的ono</span><label>myono.jsp-ok <a href="../go/myono.html">Go</a></label>
			</p>
		</section>
	</section>
</body>
</html>