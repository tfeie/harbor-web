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
<title>首页</title>
<script type="text/javascript"
	src="${_base }/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${_base }/resources/js/main.js"></script>
<link rel="stylesheet" type="text/css"
	href="${_base }/resources/css/style.css">
<script type="text/javascript"
	src="${_base }/resources/js/owl.carousel.js"></script>
<link rel="stylesheet" type="text/css"
	href="${_base }/resources/css/owl.carousel.min.css">
<script>
	$(function() {
		$(".banner").owlCarousel({
			items : 1
		})
		$(".title_owl").owlCarousel({
			items : 5,
			dots : false
		})
	})
</script>
</head>
<body>
	<header class="header"></header>

	<section class="banner">
		<section class="item">
			<a href=""><img src="${_base }/resources/img/aimg.jpg" /></a>
		</section>
		<section class="item">
			<a href=""><img src="${_base }/resources/img/aimg.jpg" /></a>
		</section>
		<section class="item">
			<a href=""><img src="${_base }/resources/img/aimg.jpg" /></a>
		</section>
		<section class="item">
			<a href=""><img src="${_base }/resources/img/aimg.jpg" /></a>
		</section>
	</section>
	<div class="clear"></div>
	<section class="mainer">

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

		<section class="sec_list">
			<ul>
				<li>
					<section class="list">
						<div class="member_info">
							<div class="img">
								<img src="${_base }/resources/img/img1.png" />
							</div>
							<span>Martin</span> <label class="lbl2">英国</label> <em>已认证</em>
						</div>
						<div class="member">
							<div class="div_title">
								<h3>
									<a href="">好朋友相聚，一切都不一样了</a>
								</h3>
								<p>
									<a>#</a><a>摄影</a><a>风景</a><a>建筑</a><a>欧洲</a><a>手机</a>
								</p>
								<div class="img">
									<img src="${_base }/resources/img/img2.png" />
								</div>
							</div>
						</div>

						<div class="b_more">
							<span class="span_time">10分钟前</span> <span class="span_pl"><a>24</a></span>
							<span class="span_bk"><a>16</a></span> <span class="span_z"><a>20</a></span>
						</div>

					</section>
				</li>
				<li>
					<section class="list">
						<div class="member_info">
							<div class="img">
								<img src="${_base }/resources/img/img1.png" />
							</div>
							<span>Martin</span> <label class="lbl1">美国</label> <em>已认证</em>
						</div>
						<div class="member">
							<div class="div_title">
								<h3>
									<a href="">好朋友相聚，一切都不一样了</a>
								</h3>
								<p>
									<a>#</a><a>摄影</a><a>风景</a><a>建筑</a><a>欧洲</a><a>手机</a>
								</p>
								<div class="img">
									<img src="${_base }/resources/img/img2.png" />
								</div>
							</div>
						</div>

						<div class="b_more">
							<span class="span_time">10分钟前</span> <span class="span_pl"><a>24</a></span>
							<span class="span_bk"><a>16</a></span> <span class="span_z"><a>20</a></span>
						</div>

					</section>
				</li>
				<li>
					<section class="list">
						<div class="member_info">
							<div class="img">
								<img src="${_base }/resources/img/img1.png" />
							</div>
							<span>Martin</span> <label class="lbl2">英国</label> <em>已认证</em>
						</div>
						<div class="member">
							<div class="div_title">
								<h3>
									<a href="">好朋友相聚，一切都不一样了</a>
								</h3>
								<p>
									<a>#</a><a>摄影</a><a>风景</a><a>建筑</a><a>欧洲</a><a>手机</a>
								</p>
								<div class="img">
									<img src="${_base }/resources/img/img2.png" />
								</div>
							</div>
						</div>

						<div class="b_more">
							<span class="span_time">10分钟前</span> <span class="span_pl"><a>24</a></span>
							<span class="span_bk"><a>16</a></span> <span class="span_z"><a>20</a></span>
						</div>

					</section>
				</li>
				<li>
					<section class="list">
						<div class="member_info">
							<div class="img">
								<img src="${_base }/resources/img/img1.png" />
							</div>
							<span>Martin</span> <label class="lbl1">美国</label> <em>已认证</em>
						</div>
						<div class="member">
							<div class="div_title">
								<h3>
									<a href="">好朋友相聚，一切都不一样了</a>
								</h3>
								<p>
									<a>#</a><a>摄影</a><a>风景</a><a>建筑</a><a>欧洲</a><a>手机</a>
								</p>
								<div class="img">
									<img src="${_base }/resources/img/img2.png" />
								</div>
							</div>
						</div>

						<div class="b_more">
							<span class="span_time">10分钟前</span> <span class="span_pl"><a>24</a></span>
							<span class="span_bk"><a>16</a></span> <span class="span_z"><a>20</a></span>
						</div>

					</section>
				</li>
			</ul>
		</section>

	</section>

	<footer class="footer">
		<ul>
			<li class="on"><a href="">
					<div class="img">
						<img src="${_base }/resources/img/f1.png" />
					</div>
					<div class="text">Be</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="${_base }/resources/img/f2.png" />
					</div>
					<div class="text">Go</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="${_base }/resources/img/f3.png" />
					</div>
					<div class="text">Frd</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="${_base }/resources/img/f4.png" />
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="${_base }/resources/img/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>


	<div class="mask"></div>
	<section class="sec_menu">
		<div class="wrap">
			<span class="span1"><a><img
					src="${_base }/resources/img/circle.png" /></a></span> <span class="span2"><a
				href=""><img src="${_base }/resources/img/be.png" /></a></span> <span
				class="span3"><a href=""><img
					src="${_base }/resources/img/go.png" /></a></span>
		</div>
	</section>
</body>
</html>