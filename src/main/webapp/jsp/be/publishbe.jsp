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
<title>发布Be</title>
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

<body>
	<section class="xjbe-main">
		<div class="xx">
			<div class="wb-m">
				<textarea class="In-text">奶奶把那奖励来的半口袋“下风头”麦子精心设计，像是捧着稀世珍宝。老人家常说，粮食金，粮食金，粮食比金子还贵啊！</textarea>
				<div class="bq">
					<a href="#" class="list" data-id="0">#营销1</a> <a href="#"
						class="list" data-id="1">#营销2</a> <a href="#" class="list"
						data-id="2">#营销3</a>
				</div>
			</div>
			<div class="img-up">
				<label><img src="//static.tfeie.com/v2/images/sctp.png" width="100%"><input
					type="file" class="op-0" onchange="onchange_img(this)"></label> <i
					class="icon-gb-img" onclick="append_onclick(this)"></i>
			</div>

		</div>
		<div class="btn-m">
			<div class="btn-wb">添加文本</div>
			<div class="btn-img">添加图片</div>
		</div>
		<div class="t">
			已选标签（<font id="num-bq">3</font>/5）
		</div>
		<div class="bq-yx clearfix">
			<span data-id="0" class="list">营销1<i class="icon-gb"
				onclick="appendbq_onclick(this)"></i></span> <span data-id="1" class="list">营销2<i
				class="icon-gb" onclick="appendbq_onclick(this)"></i></span> <span
				data-id="2" class="list">营销3<i class="icon-gb"
				onclick="appendbq_onclick(this)"></i></span>
		</div>
		<div class="t">可选/添加标签</div>
		<div class="bq-kx clearfix">
			<span data-id="0" class="list on" onclick="bqkx_onclick(this)">营销1</span>
			<span data-id="1" class="list on" onclick="bqkx_onclick(this)">营销2</span>
			<span data-id="2" class="list on" onclick="bqkx_onclick(this)">营销3</span>
			<span data-id="3" class="list" onclick="bqkx_onclick(this)">营销4</span>
			<span data-id="4" class="list" onclick="bqkx_onclick(this)">营销5</span>
			<span data-id="5" class="list" onclick="bqkx_onclick(this)">营销6</span>
			<span data-id="6" class="list" onclick="bqkx_onclick(this)">营销7</span>
			<span data-id="7" class="list" onclick="bqkx_onclick(this)">营销8</span>
			<span data-id="8" class="list" onclick="bqkx_onclick(this)">营销9</span>
			<span class="tj"><img src="//static.tfeie.com/v2/images/icon-img.png" width="65"
				height="30"></span>
		</div>

		<div class="slk-main">
			<input type="text" class="In-text" id="bq-text" maxlength="3"
				placeholder="请输入标签"> <input type="button" value="提交"
				class="btn-tj">
		</div>
		<div class="btn-fs">
			<input type="submit" class="btn" value="发射">
		</div>
	</section>



	<div class="tc-main">
		<span class="btn-show po-f"></span> <span class="btn-be po-f"></span>
		<span class="btn-go po-f"></span>
		<div class="bg-main po-f"></div>
	</div>

	<footer class="footer po-f">
		<a href="#"><i class="icon-f1"></i><span>Be</span></a> <a href="#"><i
			class="icon-f2"></i><span>Go</span></a> <a href="#"><i
			class="icon-f3"></i><span>Frd</span></a> <a href="#"><i
			class="icon-f4"><font>6</font></i><span>Msg</span></a> <a href="#"><i
			class="icon-f5"></i><span>Me</span></a>
	</footer>

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

			//添加文本
			$('.btn-wb')
					.tap(
							function() {
								$('.xx')
										.append(
												'<div class="wb-m"><textarea class="In-text" placeholder="请输入文本信息"></textarea><i class="icon-gb-wb" onclick="append_onclick(this)"></i></div>');

							})
			//添加图片
			$('.btn-img')
					.tap(
							function() {
								$('.xx')
										.append(
												'<div class="img-up"><label><img src="//static.tfeie.com/v2/images/sctp.png" width="100%"><input type="file" class="op-0" onchange="onchange_img(this)" ></label><i class="icon-gb-img" onclick="append_onclick(this)"></i></div>');

							})

			//添加标签
			$('.tj').tap(function() {
				$('.slk-main').slideToggle();
			})
			$('.btn-tj')
					.tap(
							function() {
								if ($('#bq-text').val()) {

									$('.slk-main').slideUp();
									$('.tj')
											.before(
													'<span data-id="'
															+ $('.tj').index()
															+ '" class="list"  onclick="bqkx_onclick(this)">'
															+ $('#bq-text')
																	.val()
															+ '</span>');
									$('#bq-text').val('');

								} else {
									alert('请输入标签，字符数不超过3')
								}

							})

		})

		function append_onclick(e) {
			$(e).parent().detach();

		}
		function appendbq_onclick(e) {
			$(e).parent().detach();

			$('#num-bq').text($('.bq-yx .list').size())
			$('.bq-kx .list[data-id="' + $(e).parent().attr('data-id') + '"]')
					.removeClass('on');
			$('.bq .list[data-id="' + $(e).parent().attr('data-id') + '"]')
					.detach();

		}
		//
		function bqkx_onclick(e) {
			if ($(e).attr('class') == 'list') {
				//未选
				if (Number($('#num-bq').text()) < 5) {

					$(e).addClass('on')

					$('.bq-yx')
							.append(
									'<span data-id="'
											+ $(e).attr('data-id')
											+ '" class="list">'
											+ $(e).text()
											+ '<i class="icon-gb"  onclick="appendbq_onclick(this)"></i></span>');
					$('#num-bq').text($('.bq-yx .list').size())

					$('.bq').append(
							'<a data-id="' + $(e).attr('data-id')
									+ '" class="list" href="#">#' + $(e).text()
									+ '</a>');

				} else {
					alert('可选标签最多只能选5个')

				}

			} else {
				//已选
				$(e).removeClass('on')
				$('.bq-yx .list[data-id="' + $(e).attr('data-id') + '"]')
						.detach();
				$('#num-bq').text($('.bq-yx .list').size())

				$('.bq .list[data-id="' + $(e).attr('data-id') + '"]').detach();
			}

		}

		//H5图像	
		function onchange_img(e) {
			var objUrl = getObjectURL(e.files[0]);
			console.log("objUrl = " + objUrl);
			if (objUrl) {
				$(e).prev().attr({
					src : objUrl
				});
			}
		}

		//建立一個可存取到該file的url
		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) { // basic
				url = window.createObjectURL(file);
			} else if (window.URL != undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			return url;
		}
	</script>
	</body>
	</html>