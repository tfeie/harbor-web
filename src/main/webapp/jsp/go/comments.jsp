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
<title>Go评论</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script>
	<script>
	$(function() {
		$(".yes_no p span").click(function() {
			$(this).parents("p").find("span").removeClass("on")
			$(this).addClass("on")
		})
	})
</script>
</head>
<body class="body">
	<section class="mainer on">
		<section class="group_pingjia">
			<p>户外健身</p>
		</section>
		<section class="ip_info group">
			<section class="info_img">
				<span><img src="//static.tfeie.com/images/img29.png"></span>
			</section>
			<section class="ip_text">
				<p>
					<span>Martin</span><label class="lbl2">英国</label><i>已认证</i>
				</p>
				<p>金融/合伙人/北京</p>
			</section>
			<div class="clear"></div>
		</section>
		<section class="good_friend">
			<section class="friend_num">
				<p>
					<span><img src="//static.tfeie.com/images/img35.png"></span><label>3</label>
				</p>
				<p>
					<span>益友总计</span>
				</p>
			</section>
			<section class="yes_no">
				<p>TA 是益友吗？</p>
				<p>
					<span class="on">是益友</span><span>不知道</span>
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="good_friend">
			<section class="friend_num">
				<p>
					<span><img src="//static.tfeie.com/images/img36.png"></span>
				</p>
				<p>
					<span>赏海贝</span>
				</p>
			</section>
			<section class="yes_no num">
				<p>
					<span>10</span><span>50</span><span>100</span><span class="on">0</span>
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="group_pinglun">
			<p>评论</p>
		</section>
		<section class="pinglun_textarea">
			<p>
				<textarea>评，组织者或活动...</textarea>
			</p>
			<p>
				<input type="button" value="发射" />
			</p>
		</section>
		<section class="liulan">
			<section class="look_pinglun">
				<p>评论浏览</p>
			</section>
			<section class="duihua">
				<section class="duihua_1">
					<section class="left_img">
						<span> </span>
					</section>
					<section class="duihua_text">
						<p>对方很热情的接待了我，并提供了很大的帮助，我的问题也得到了圆满的解决!</p>
						<p class="time">5-6 16:40</p>
						<section class="zhixiang">
							<img src="//static.tfeie.com/images/img42.png" />
						</section>
					</section>
					<section class="right_img">
						<span><img src="//static.tfeie.com/images/img41.png" /></span>
					</section>
				</section>
				<section class="duihua_1">
					<section class="left_img">
						<span><img src="//static.tfeie.com/images/img41.png" /></span>
					</section>
					<section class="duihua_text left">
						<p>很高兴能帮到您，谢谢!</p>
						<p class="time">5-6 16:40</p>
						<section class="zhixiang left">
							<img src="//static.tfeie.com/images/img42_1.png" />
						</section>
					</section>
					<section class="right_img">
						<span> </span>
					</section>
				</section>
				<div class="clear"></div>
			</section>
		</section>
	</section>
</html>