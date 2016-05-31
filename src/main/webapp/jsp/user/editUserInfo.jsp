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
<title>编辑个人信息</title>
<script type="text/javascript"
	src="${_base }/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${_base }/resources/js/main.js"></script>
<link rel="stylesheet" type="text/css"
	href="${_base }/resources/css/style.css">
<script type="text/javascript"
	src="${_base }/resources/js/owl.carousel.js"></script>
<link rel="stylesheet" type="text/css"
	href="${_base }/resources/css/owl.carousel.min.css">
</head>
<body class="body">
	<section class="per_info">
		<section class="par_name">
			<p>
				<input type="text" value="Martin">
			</p>
		</section>
		<section class="info_sex">
			<p>
				<span><img src="${_base }/resources/img/boy.png" /></span><span><img
					src="${_base }/resources/img/girl.png" /></span><span class="in">各种可能</span>
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
				<textarea>留下些有个性的....</textarea>
			</p>
		</section>
		<section class="xinqi">
			<p>
				兴趣标签 <i>4/6</i>
			</p>
			<ul>
				<li>
					<div class="xinqi_1">
						<p>
							<a>摄影</a>
						</p>
						<div class="det">
							<p>
								<img src="${_base }/resources/img/icon16.png" />
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
							<p>
								<img src="${_base }/resources/img/icon16.png" />
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
							<p>
								<img src="${_base }/resources/img/icon16.png" />
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
							<p>
								<img src="${_base }/resources/img/icon16.png" />
							</p>
						</div>
					</div>
				</li>
				<li class="on">
					<div class="xinqi_1">
						<p>
							<a href="#"><img src="${_base }/resources/img/icon15.png" /></a>
						</p>
					</div>
				</li>
			</ul>
			<div class="clear"></div>
		</section>

		<section class="chooes_2">
			<p>可选标签</p>
			<ul>
				<li><a>摄影</a></li>
				<li><a>打篮球</a></li>
				<li><a>水上运动</a></li>
				<li><a>打篮球</a></li>
				<li><a>看电影</a></li>
				<li><a>摄影</a></li>
				<li><a>睡觉</a></li>
				<li><a>旅游</a></li>
			</ul>
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

		<section class="xinqi">
			<p>
				技能标签 <i>4/6</i>
			</p>
			<ul>
				<li>
					<div class="xinqi_1">
						<p>
							<a>摄影</a>
						</p>
						<div class="det">
							<p>
								<img src="${_base }/resources/img/icon16.png" />
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
							<p>
								<img src="${_base }/resources/img/icon16.png" />
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
							<p>
								<img src="${_base }/resources/img/icon16.png" />
							</p>
						</div>
					</div>
				</li>
				<li class="on">
					<div class="xinqi_1">
						<p>
							<a href="#"><img src="${_base }/resources/img/icon15.png" /></a>
						</p>
					</div>
				</li>
			</ul>
			<div class="clear"></div>
		</section>

		<section class="chooes_2">
			<p>可选标签</p>
			<ul>
				<li><a>摄影</a></li>
				<li><a>打篮球</a></li>
				<li><a>水上运动</a></li>
				<li><a>打篮球</a></li>
				<li><a>看电影</a></li>
				<li><a>摄影</a></li>
				<li><a>睡觉</a></li>
				<li><a>旅游</a></li>
			</ul>
		</section>
		<section class="but_baoc">
			<p>
				<a href="#">保存</a>
			</p>
		</section>
	</section>
	<footer class="footer">
		<ul>
			<li><a href="">
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
						<img src="${_base }/resources/img/f4.png" /><i>6</i>
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li class="on"><a href="">
					<div class="img">
						<img src="${_base }/resources/img/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>
</body>
</html>