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
<title>我的消息</title>
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


	<section class="sxms-main">
		<div class="time clearfix">
			<span>2015年11月30日 18:05</span>
		</div>
		<div class="itms clearfix">
			<div class="tx">
				<img src="//static.tfeie.com/v2/images/tx.png" width="35" height="35">
			</div>
			<div class="xx">
				<p>在吗？好想你。。。。</p>
			</div>
		</div>
		<div class="itms clearfix itms-my">
			<div class="tx">
				<img src="//static.tfeie.com/v2/images/tx.png" width="35" height="35">
			</div>
			<div class="xx">
				<p>在的，我也是。。。。</p>
			</div>
		</div>
		<div class="itms clearfix">
			<div class="tx">
				<img src="//static.tfeie.com/v2/images/tx.png" width="35" height="35">
			</div>
			<div class="xx">
				<p>对了，那个折叠床呢？</p>
			</div>
		</div>
		<div class="itms clearfix itms-my">
			<div class="tx">
				<img src="//static.tfeie.com/v2/images/tx.png" width="35" height="35">
			</div>
			<div class="xx">
				<p>那个床，就在二楼之前李鹏坐的那个地方</p>
			</div>
		</div>
	</section>

	<footer class="sxms-footer po-f">
		<form>
			<div class="right">
				<input type="text" class="In-text" placeholder="启动撂Ta的正确姿势...">
			</div>
			<input type="button" class="btn-xl"> <label class="btn-tp">
				<img src="//static.tfeie.com/v2/images/icon-tp.png" width="20" height="20"> <input
				type="file" class="op-0">
			</label>
		</form>
	</footer>




	<div class="tc-main">
		<span class="btn-show po-f"></span> <span class="btn-be po-f"></span>
		<span class="btn-go po-f"></span>
		<div class="bg-main po-f"></div>
	</div>

	<script>
		$(function() {

			//检查版本
			var u = navigator.userAgent, app = navigator.appVersion;
			var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端

			//苹果兼容
			if (isiOS) {

				$('.In-pof').focus(function() {

					$('.po-f').addClass('po-a')

				}).blur(function() {//输入框失焦后还原初始状态

					$('.po-f').removeClass('po-a')

				});

			}

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

		})
	</script>

</body>
</html>