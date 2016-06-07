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
<title>审核信息</title>
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
	$(function() {

		$(".but_queren input.inpbut").click(function() {
			var item = $(this).parents(".daique_info").clone(true);
			$(this).parents(".daique_info").remove();
			$(".queren_back.in").append(item);

		})

	})
</script>
</head>
<body>
	<section class="mainer in">
		<section class="ma_shenghe">
			<p>52小时精益创业</p>
		</section>
		<section class="shenhe_xinxi">
			<section class="info_fuwu">
				<section class="ip_info">
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
				<section class="info_time">
					<p>
						<span>2016-5-5 星期四 15:00</span><a href="#" class="on">在线服务</a>
					</p>
				</section>
				<section class="info_time back1">
					<p>
						<span>Group邀请2-3人</span><a href="#">180元</a>
					</p>
				</section>
				<section class="info_time back2">
					<p>
						<span>北京，国贸附近</span>
					</p>
				</section>
				<section class="info_fangf pz">
					<p>怎样提高你的身体效率，怎样有效的改善体型。怎样提高你的身体效率，怎样有效的改善体型…</p>
				</section>
				<div class="clear"></div>
			</section>
			<section class="num_liulan">
				<p>
					<a href="#">浏览 126</a><a href="#">参加 126</a><a href="#">收藏 12</a>
				</p>
			</section>
		</section>

		<section class="daiqueren">
			<p>待确认</p>
		</section>
		<section class="queren_back">
			<section class="daique_info">
				<section class="info_img">
					<span><img src="//static.tfeie.com/images/img29.png"></span>
				</section>
				<section class="ip_text oz">
					<p>
						<span>Martin</span><label class="lbl2">英国</label><i>已认证</i>
					</p>
					<p>金融/合伙人/北京</p>
				</section>
				<section class="but_queren">
					<input type="button" value="拒绝" /><input type="button" value="通过"
						class="inpbut" />
				</section>
				<div class="clear"></div>

			</section>
			<section class="daique_info">
				<section class="info_img">
					<span><img src="//static.tfeie.com/images/img29.png"></span>
				</section>
				<section class="ip_text oz">
					<p>
						<span>Martin</span><label class="lbl1">美国</label><i>已认证</i>
					</p>
					<p>金融/合伙人/北京</p>
				</section>
				<section class="but_queren">
					<input type="button" value="拒绝" /><input type="button" value="通过"
						class="inpbut" />
				</section>
				<div class="clear"></div>

			</section>
		</section>
		<section class="heiwu"></section>
		<section class="daiqueren">
			<p>已确认</p>
		</section>
		<section class="queren_back in">
			<section class="daique_info">
				<section class="info_img">
					<span><img src="//static.tfeie.com/images/img29.png"></span>
				</section>
				<section class="ip_text oz">
					<p>
						<span>Martin</span><label class="lbl5">香港</label><i>已认证</i>
					</p>
					<p>金融/合伙人/北京</p>
				</section>

				<div class="clear"></div>

			</section>
			<section class="daique_info">
				<section class="info_img">
					<span><img src="//static.tfeie.com/images/img29.png"></span>
				</section>
				<section class="ip_text oz">
					<p>
						<span>Martin</span><label class="lbl6">日本</label><i>已认证</i>
					</p>
					<p>金融/合伙人/北京</p>
				</section>

				<div class="clear"></div>
			</section>
		</section>
	</section>
</body>



</html>