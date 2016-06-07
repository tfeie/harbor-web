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
<title>编辑个人信息</title>
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

		$(".chooes_2 ul li a").click(function() {
			if ($(this).parent("li").hasClass("on")) {
			} else {
				var str = $(this).html();
			}
		})

		$(".chooes_2 ul li a").click(
				function() {

					if ($(this).parents(".check_item").find(".xinqi")
							.find("li").length >= 5
							|| $(this).parent("li").hasClass("on")) {
					} else {
						var li = $(".xinqi ul li").first().clone(true);
						li.find("p").find("a").html($(this).html());
						$(this).parents(".check_item").find(".xinqi ul")
								.append(li);
						$(this).parents(".check_item").find(".xinqi")
								.find("em").html(
										$(this).parents(".check_item").find(
												".xinqi").find("li").length)
						$(this).parent("li").remove();
					}
				})

	})
	function KX_list(obg) {
		var str = $(obg).parents("li").find("p").find("a").html();

		var li = $(obg).parents(".check_item").find(".chooes_2").find("li")
				.first().clone(true);

		$(obg).parents(".check_item").find("em").html(
				$(obg).parents(".check_item").find("em").html() - 1)

		li.find("a").html(str);
		$(obg).parents(".check_item").find(".chooes_2").find("ul").prepend(li);
		$(obg).parents("li").remove();
	}
</script>
</head>
<body class="body">
	<section class="top_info">
		<p class="span_file">
			<img src="//static.tfeie.com/images/aimg2.png">
		</p>
		<section class="ip_logo">
			<p>
				<span class="span_file"><img
					src="//static.tfeie.com/images/icon18.png"></span>
			</p>
		</section>
	</section>
	<section class="sec_title"></section>
	<section class="per_info padding-bottom">
		<section class="par_name">
			<p>
				<input type="text" value="Martin">
			</p>
		</section>
		<section class="info_sex">
			<p>
				<span><img src="//static.tfeie.com/images/boy.png" /></span><span><img
					src="//static.tfeie.com/images/girl.png" /></span><span class="in"><img
					src="//static.tfeie.com/images/other.png" /></span>
			</p>
		</section>
		<section class="sel_con">
			<p class="boss">
				<select><option>UK-英国</option></select>
			</p>
		</section>
		<section class="par_name">
			<p class="boss">
				<input type="text" value="Cambridge College">
			</p>
		</section>
		<section class="sel_con">
			<p class="boss">
				<select><option>单身</option></select>
			</p>
		</section>
		<section class="sel_con">
			<p class="boss">
				<select><option>狮子座</option></select>
			</p>
		</section>
		<section class="par_textare">
			<p>
				<textarea>个性签名....</textarea>
			</p>
		</section>
		<section class="check_item">
			<section class="xinqi left_t">
				<p class="left_t">
					已选兴趣标签<i><em>4</em>/5</i>
				</p>
				<ul>
					<li>
						<div class="xinqi_1">
							<p>
								<a>摄影</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>水上运动</a>
							</p>
							<div class="det">
								<p onclick="  KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>健身</a>
							</p>
							<div class="det">
								<p onclick="  KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>旅游</a>
							</p>
							<div class="det">
								<p onclick="  KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>

				</ul>
				<div class="clear"></div>
			</section>

			<section class="chooes_2">
				<p class="left_t">可选兴趣标签</p>
				<ul>
					<li><a>摄影</a></li>
					<li><a>打篮球</a></li>
					<li><a>水上运动</a></li>
					<li><a>打篮球</a></li>
					<li><a>看电影</a></li>
					<li><a>摄影</a></li>
					<li><a>睡觉</a></li>
					<li><a>旅游</a></li>
					<li class="on"><a><img
							src="//static.tfeie.com/images/icon15.png" /></a></li>
				</ul>
			</section>
		</section>
		<section class="par_name">
			<p class="boss">
				<input type="text" value="185****2516">
			</p>
		</section>

		<section class="sel_con">
			<p class="boss">
				<select><option>狮子座</option></select>
			</p>
		</section>

		<section class="par_name">
			<p class="boss">
				<input type="text" value="XX公司">
			</p>
		</section>

		<section class="par_name">
			<p class="boss">
				<input type="text" value="CXO">
			</p>
		</section>
		<section class="check_item">
			<section class="xinqi">
				<p class="left_t">
					已选技能标签<i><em>3</em>/5</i>
				</p>
				<ul>
					<li>
						<div class="xinqi_1">
							<p>
								<a>摄影</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>水上运动</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>健身</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<!--<li class="on">
                        <div class="xinqi_1">
                            <p><a href="#"><img src="//static.tfeie.com/images/icon15.png" /></a></p>
                        </div>
                    </li>-->
				</ul>
				<div class="clear"></div>
			</section>

			<section class="chooes_2">
				<p class="left_t">可选技能标签</p>
				<ul>
					<li><a>摄影</a></li>
					<li><a>打篮球</a></li>
					<li><a>水上运动</a></li>
					<li><a>打篮球</a></li>
					<li><a>看电影</a></li>
					<li><a>摄影</a></li>
					<li><a>睡觉</a></li>
					<li><a>旅游</a></li>
					<li class="on"><a><img
							src="//static.tfeie.com/images/icon15.png" /></a></li>
				</ul>
			</section>
		</section>
		<section class="but_baoc">
			<p>
				<input type="button" value="保存" />
			</p>
		</section>
	</section>
	<footer class="footer">
		<ul>
			<li><a href="">
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
						<img src="//static.tfeie.com/images/f4.png" /><i>6</i>
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li class="on"><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>

</body>
</html>