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
<title>我创建的Group</title>
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

	<nav class="be-nav po-f box-s">
		<div class="hd clearfix">
			 <a href="../be/mybe.html" class="itms on">Be</a>
            <a href="../go/mygroup.html" class="itms">Group</a>
            <a href="../go/myono.html" class="itms">OnO</a>
		</div>
	</nav>

	<section class="group-main">
		<div class="itms box-s" href="#">
			<a href="#">
				<div class="tie">
					<p>户外健身</p>
					<div class="tim">5月6日</div>
				</div>
			</a> <a href="#">
				<div class="name clearfix">
					<div class="img">
						<img src="//static.tfeie.com/v2/images/tx.png" width="40"
							height="40">
					</div>
					<div class="name-xx">
						<div class="xx">
							MaysMays<span class="bg-lv">美国</span><font>已认证</font>
						</div>
						<div class="jj">金融/合伙人/北京</div>
					</div>
				</div>
			</a> <a href="#">
				<div class="time">
					2016-5-5 星期四 15:00<span class="bg-f5922f">线下服务</span>
				</div>
				<div class="yq">
					Group邀请2-3人<span class="fc-f5922f">我请客</span>
				</div>
				<div class="dz">北京，国贸附近</div>
				<div class="js chaochu_2">怎样提高你的身体效率，怎样有效的改善体型。怎怎样提高你的身体效率，怎样有效的改善体型。怎</div>
			</a>
			<div class="bottom">
				<div class="list">
					浏览<font>3</font>
				</div>
				<div class="list">
					参加<font>3</font>
				</div>
				<div class="list list-sc">
					收藏<font>3</font>
				</div>
			</div>
		</div>
		<div class="itms box-s" href="#">
			<a href="#">
				<div class="tie">
					<p>52小时精益创业</p>
					<div class="tim">5月6日</div>
				</div>
			</a> <a href="#">
				<div class="name clearfix">
					<div class="img">
						<img src="//static.tfeie.com/v2/images/tx.png" width="40"
							height="40">
					</div>
					<div class="name-xx">
						<div class="xx">
							MaysMays<span class="bg-lv">美国</span><font>已认证</font>
						</div>
						<div class="jj">金融/合伙人/北京</div>
					</div>
				</div>
			</a> <a href="#">
				<div class="time">
					2016-5-5 星期四 15:00<span class="bg-ff6a42">在线服务</span>
				</div>
				<div class="yq">
					Group邀请2-3人<span class="fc-ff6a42">我请客</span>
				</div>
				<div class="js chaochu_2">怎样提高你的身体效率，怎样有效的改善体型。怎怎样提高你的身体效率，怎样有效的改善体型。怎</div>
			</a>
			<div class="bottom">
				<div class="list">
					浏览<font>3</font>
				</div>
				<div class="list">
					参加<font>3</font>
				</div>
				<div class="list list-sc">
					收藏<font>3</font>
				</div>
			</div>
		</div>
		<div class="itms box-s" href="#">
			<a href="#">
				<div class="tie">
					<p>户外健身</p>
					<div class="tim">5月6日</div>
				</div>
			</a> <a href="#">
				<div class="name clearfix">
					<div class="img">
						<img src="//static.tfeie.com/v2/images/tx.png" width="40"
							height="40">
					</div>
					<div class="name-xx">
						<div class="xx">
							MaysMays<span class="bg-lv">美国</span><font>已认证</font>
						</div>
						<div class="jj">金融/合伙人/北京</div>
					</div>
				</div>
			</a> <a href="#">
				<div class="time">
					2016-5-5 星期四 15:00<span>线下服务</span>
				</div>
				<div class="yq">
					Group邀请2-3人<span>我请客</span>
				</div>
				<div class="dz">北京，国贸附近</div>
				<div class="js chaochu_2">怎样提高你的身体效率，怎样有效的改善体型。怎怎样提高你的身体效率，怎样有效的改善体型。怎</div>
			</a>
			<div class="bottom">
				<div class="list">
					浏览<font>3</font>
				</div>
				<div class="list">
					参加<font>3</font>
				</div>
				<div class="list list-sc">
					收藏<font>3</font>
				</div>
			</div>
		</div>

	</section>


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
		$(function() {

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

			//收藏
			$('.list-sc').tap(
					function() {
						//+1
						if ($(this).attr('class') == 'list list-sc') {
							$(this).children('font').text(
									Number($(this).children('font').text())
											+ Number(1))
							$(this).addClass('on');

						} else {

							$(this).children('font').text(
									Number($(this).children('font').text())
											- Number(1))
							$(this).removeClass('on');
						}

					})

		})
	</script>

</body>
</html>