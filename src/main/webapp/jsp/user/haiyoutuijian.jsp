<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta content="telephone=no" name="format-detection" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="#035c9b">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title>海友推荐</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/json2.js"></script>
<script src="//static.tfeie.com/v2/js/swiper.min.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>
<body class="bg-eeeeee">

	<section class="txl-main">
		<div class="swiper-container" id="banner-img">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<a href="#"><img src="//static.tfeie.com/v2/images/aimg.jpg"
						width="100%"></a>
				</div>
				<div class="swiper-slide">
					<a href="#"><img src="//static.tfeie.com/v2/images/aimg.jpg"
						width="100%"></a>
				</div>
				<div class="swiper-slide">
					<a href="#"><img src="//static.tfeie.com/v2/images/aimg.jpg"
						width="100%"></a>
				</div>
				<div class="swiper-slide">
					<a href="#"><img src="//static.tfeie.com/v2/images/aimg.jpg"
						width="100%"></a>
				</div>
				<div class="swiper-slide">
					<a href="#"><img src="//static.tfeie.com/v2/images/aimg.jpg"
						width="100%"></a>
				</div>
			</div>

			<div class="pagination">
				<div class="ppage"></div>
			</div>
		</div>

		<div class="top-tap box-s">
			<div class="hd" id="hd">
				<div class="itms on">新海友&推荐</div>
				<div class="itms">我的海友</div>
			</div>
		</div>


		<div id="bd">
			<!--新海友-->
			<div class="bd">
				<div class="new-main box-s mar-top-10 pad-0-10">
					<div class="top-tie">
						<span>新海友请求</span>
					</div>
					<div class="itms clearfix">
						<div class="btn-right">
							<span class="btn-hl">忽略</span> <span class="btn-js">接受</span>
						</div>
						<div class="c">
							<div class="img">
								<img src="//static.tfeie.com/v2/images/tx.png" width="40"
									height="40">
							</div>
							<div class="name">
								<div class="name-xx">
									<div class="xx">MaysMays</div>
									<div class="yrz">
										<span class="bg-lan">香港</span><font>已认证</font>
									</div>
								</div>
								<div class="jj">金融/合伙人/北京</div>
								<div class="hyy">Hi，Nice to meet you.</div>
							</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="btn-right">
							<span class="btn-hl">忽略</span> <span class="btn-js">接受</span>
						</div>
						<div class="c">
							<div class="img">
								<img src="//static.tfeie.com/v2/images/tx.png" width="40"
									height="40">
							</div>
							<div class="name">
								<div class="name-xx">
									<div class="xx">Mays</div>
									<div class="yrz">
										<span class="bg-cen">英国</span><font>已认证</font>
									</div>
								</div>
								<div class="jj">金融/合伙人/北京</div>
								<div class="hyy">Hi，Nice to meet you.</div>
							</div>
						</div>
					</div>
				</div>

				<div class="tj-main box-s mar-top-10 pad-0-10">
					<div class="top-tie">
						<span>推荐的海友</span>
						<div class="btn-search"></div>
						<div class="search-main">
							<div class="m">
								<input type="text" placeholder="国家/行业/学校/职业" class="In-text">
							</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lv">美国</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>

				</div>
			</div>
			<!--新海友-->


			<!--我的海友-->
			<div class="bd" style="display: none;">
				<div class="myhy">

					<div class="btn-search"></div>
					<div class="search-main">
						<div class="m">
							<input type="text" placeholder="国家/行业/学校/职业" class="In-text">
						</div>
					</div>
				</div>

				<div class="nav-r po-a">
					<a href="#a" class="itms">A</a> <a href="#b" class="itms">B</a> <a
						href="#c" class="itms">C</a> <a href="#d" class="itms">D</a> <a
						href="#e" class="itms">E</a> <a href="#f" class="itms">F</a> <a
						href="#g" class="itms">G</a> <a href="#h" class="itms">H</a> <a
						href="#i" class="itms">I</a> <a href="#j" class="itms">J</a> <a
						href="#k" class="itms">K</a> <a href="#l" class="itms">L</a> <a
						href="#m" class="itms">M</a> <a href="#n" class="itms">N</a> <a
						href="#o" class="itms">O</a> <a href="#p" class="itms">P</a> <a
						href="#q" class="itms">Q</a> <a href="#r" class="itms">R</a> <a
						href="#s" class="itms">S</a> <a href="#t" class="itms">T</a> <a
						href="#u" class="itms">U</a> <a href="#v" class="itms">V</a> <a
						href="#w" class="itms">W</a> <a href="#x" class="itms">X</a> <a
						href="#y" class="itms">Y</a> <a href="#z" class="itms">Z</a>
				</div>
				<div class="bg-eeeeee pad-0-10 line-40 fs-16" id="a">A</div>
				<div class="tj-main box-s pad-0-10">
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lv">美国</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>

				</div>

				<div class="bg-eeeeee pad-0-10 line-40 fs-16" id="b">B</div>
				<div class="tj-main box-s pad-0-10">
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lv">美国</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>
					<div class="itms clearfix">
						<div class="img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="40"
								height="40">
						</div>
						<div class="name">
							<div class="name-xx">
								<div class="xx">MaysMays</div>
								<div class="yrz">
									<span class="bg-lan">香港</span><font>已认证</font>
								</div>
							</div>
							<div class="jj">金融/合伙人/北京</div>
						</div>
					</div>

				</div>




			</div>
			<!--我的海友-->
		</div>


	</section>

	<footer class="footer po-f">
		<a href="#"><i class="icon-f1"></i><span>Be</span></a> <a href="#"><i
			class="icon-f2"></i><span>Go</span></a> <a href="#"><i
			class="icon-f3"></i><span>Frd</span></a> <a href="#"><i
			class="icon-f4"><font>6</font></i><span>Msg</span></a> <a href="#"><i
			class="icon-f5"></i><span>Me</span></a>
	</footer>


	<div class="tc-main">
		<span class="btn-show po-f"></span> <span class="btn-be po-f"></span>
		<span class="btn-go po-f"></span>
		<div class="bg-main po-f"></div>
	</div>


	<script>
		//轮播
		var mySwiper = new Swiper('.swiper-container', {
			grabCursor : true,
			loop : true,
			paginationClickable : true,
			pagination : '.ppage',
			autoplay : 5000,

		})
	</script>

	<script>
		$(function() {
			//新朋友确认
			$('.btn-js').tap(function() {
				var dom = $(this).parents('.itms');
				dom.fadeOut("200", function() {
					dom.detach();
				})
			})

			//新朋友取消
			$('.btn-hl').tap(function() {
				var dom = $(this).parents('.itms');
				dom.fadeOut("200", function() {
					dom.detach();
				})
			})

			//点击搜索
			$('.btn-search').tap(function() {
				$(this).siblings('.search-main').fadeIn();
			})
			//显示底部
			$('.btn-show')
					.tap(
							function() {
								if ($(this).parent('.tc-main').attr('class') == 'tc-main'
										|| $(this).parent('.tc-main').attr(
												'class') == 'tc-main on1') {
									$(this).parent('.tc-main').removeClass(
											'on1');
									$(this).parent('.tc-main').addClass('on');
									$(this).parent('.tc-main').children(
											'.bg-main').fadeIn();

								} else {
									$(this).parent('.tc-main')
											.removeClass('on');
									$(this).parent('.tc-main').addClass('on1');
									$(this).parent('.tc-main').children(
											'.bg-main').fadeOut();

								}
							})
			//tap切换
			$('#hd .itms').tap(function() {
				$(this).siblings().removeClass('on')
				$(this).addClass('on')
				$('#bd .bd').css({
					display : 'none'
				})
				$('#bd .bd').eq($(this).index()).css({
					display : 'block'
				})

			})
		})
	</script>
</body>
</html>