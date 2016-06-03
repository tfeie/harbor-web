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
<title>Group首页</title>
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
		$(".banner").owlCarousel({
			items : 1
		})
		$(".title_owl").owlCarousel({
			items : 5,
			dots : false
		})

		$(".bor_wid p span").click(
				function() {
					$(this).parents("p").find("span").removeClass("on")
					$(this).addClass("on")
					$(this).parents(".mainer").find(".lat_group").removeClass(
							"on")
					$(this).parents(".mainer").find(".lat_group").eq(
							$(this).index()).addClass("on")
				})

	})
</script>
</head>
<body>

	<header class="header"></header>

	<section class="banner">
		<section class="item">
			<a href=""><img src="//static.tfeie.com/images/aimg.jpg" /></a>
		</section>
		<section class="item">
			<a href=""><img src="//static.tfeie.com/images/aimg.jpg" /></a>
		</section>
		<section class="item">
			<a href=""><img src="//static.tfeie.com/images/aimg.jpg" /></a>
		</section>
		<section class="item">
			<a href=""><img src="//static.tfeie.com/images/aimg.jpg" /></a>
		</section>
	</section>
	<div class="clear"></div>
	<section class="mainer">
		<section class="choose_go">
			<div class="bor_wid">
				<p>
					<span class="on">Group</span><span>One on One</span>
				</p>
			</div>
		</section>
		<section class="title">
			<div class="tit_nav">
				<div class="title_owl">
					<div class="item">
						<a href="" class="on">风景</a>
					</div>
					<div class="item">
						<a href="">人物</a>
					</div>
					<div class="item">
						<a href="">萌宠</a>
					</div>
					<div class="item">
						<a href="">美女</a>
					</div>
					<div class="item">
						<a href="">校园</a>
					</div>
					<div class="item">
						<a href="">美女</a>
					</div>
					<div class="item">
						<a href="">校园</a>
					</div>
				</div>
			</div>
			<div class="more"></div>
			<div class="search"></div>
		</section>

		<section class="group_oneon">
			<section class="lat_group on">
				<section class="wuwai_jiansheng">
					<section class="title_jiansheng">
						<p>户外健身</p>
						<section class="pos_yuan">
							<span></span><span class="on"></span>
							<div class="clear"></div>
						</section>
					</section>
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
								<span>2016-5-5 星期四 15:00</span><a href="#">线下服务</a>
							</p>
						</section>
						<section class="info_time back1">
							<p>
								<span>Group邀请2-3人</span><a href="#">我请客</a>
							</p>
						</section>
						<section class="info_time back2">
							<p>
								<span>北京，国贸附近</span>
							</p>
						</section>
						<section class="info_fangf">
							<p>怎样提高你的身体效率，怎样有效的改善体型。怎样提高你的身体效率，怎样有效的改善体型…</p>
						</section>
						<div class="clear"></div>
					</section>
					<section class="num_per">
						<p>
							<a href="#">浏览 126</a><a href="#">参加 126</a><a href="#">收藏 12</a>
						</p>
					</section>
				</section>
				<section class="wuwai_jiansheng">
					<section class="title_jiansheng">
						<p>52小时精益创业</p>
						<section class="pos_yuan">
							<span></span><span class="on"></span>
							<div class="clear"></div>
						</section>
					</section>
					<section class="info_fuwu">
						<section class="ip_info">
							<section class="info_img">
								<span><img src="//static.tfeie.com/images/img34.png"></span>
							</section>
							<section class="ip_text">
								<p>
									<span>Martin</span><label class="lbl1 on">美国</label><i>已认证</i>
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
						<section class="info_fangf">
							<p>怎样提高你的身体效率，怎样有效的改善体型。怎样提高你的身体效率，怎样有效的改善体型…</p>
						</section>
						<div class="clear"></div>
					</section>
					<section class="num_per">
						<p>
							<a href="#">浏览 126</a><a href="#">参加 126</a><a href="#">收藏 12</a>
						</p>
					</section>
				</section>
			</section>
			<section class="lat_group">
				<section class="wuwai_jiansheng">
					<section class="title_jiansheng">
						<p>海外市场如此Sexy</p>
						<section class="pos_yuan">
							<span></span><span class="on"></span>
							<div class="clear"></div>
						</section>
					</section>
					<section class="info_fuwu">
						<section class="ip_info">
							<section class="info_img">
								<span><img src="//static.tfeie.com/images/img29.png"></span>
							</section>
							<section class="ip_text">
								<p>
									<span>Martin</span><label class="lbl1 on">美国</label><i>已认证</i><em
										class="online"><a href="#">线下服务</a></em>
								</p>
								<p>
									金融/合伙人/北京<em>21人见过</em>
								</p>
							</section>
							<div class="clear"></div>
						</section>
						<section class="oneon_text">
							<p>如果你无法简洁的表达你的想法，那只能说明你还不够了解它。—阿尔伯特·爱因斯坦.如果你无法简洁的表达你的想法，那只能说明你还…</p>
						</section>
					</section>
					<section class="oneon_span">
						<a href="#">浏览 12</a><a href="#">收藏 10</a>
						<div class="clear"></div>
					</section>
				</section>
				<section class="wuwai_jiansheng">
					<section class="title_jiansheng">
						<p>海外市场如此Sexy</p>
						<section class="pos_yuan">
							<span></span><span class="on"></span>
							<div class="clear"></div>
						</section>
					</section>
					<section class="info_fuwu">
						<section class="ip_info">
							<section class="info_img">
								<span><img src="//static.tfeie.com/images/img29.png"></span>
							</section>
							<section class="ip_text">
								<p>
									<span>Martin</span><label class="lbl1 on">美国</label><i>已认证</i><em
										class="online on"><a href="#">在线服务</a></em>
								</p>
								<p>
									金融/合伙人/北京<em>21人见过</em>
								</p>
							</section>
							<div class="clear"></div>
						</section>
						<section class="oneon_text">
							<p>如果你无法简洁的表达你的想法，那只能说明你还不够了解它。—阿尔伯特·爱因斯坦.如果你无法简洁的表达你的想法，那只能说明你还…</p>
						</section>
					</section>
					<section class="oneon_span">
						<a href="#">浏览 12</a><a href="#">收藏 10</a>
						<div class="clear"></div>
					</section>
				</section>
			</section>
		</section>
	</section>




	<footer class="footer">
		<ul>
			<li class="on"><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f1.png" />
					</div>
					<div class="text">Be</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f2.png" />
					</div>
					<div class="text">Go</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f3.png" />
					</div>
					<div class="text">Frd</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f4.png" />
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>


	<div class="mask"></div>
	<section class="sec_menu">
		<div class="wrap">
			<span class="span1"><a><img src="//static.tfeie.com/images/circle.png" /></a></span> <span
				class="span2"><a href=""><img src="//static.tfeie.com/images/be.png" /></a></span> <span
				class="span3"><a href=""><img src="//static.tfeie.com/images/go.png" /></a></span>
		</div>
	</section>

</body>
</html>