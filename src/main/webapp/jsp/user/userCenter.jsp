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
<title>个人中心</title>
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
<body>
	<section class="ip2_zhongxin">
		<section class="ip2_top">
			<p><img src="${_base }/resources/img/banner4.png"></p>
			<section class="ip_logo ip2">
				<p><span><img src="${_base }/resources/img/icon18.png"/></span></p>
			</section>
		</section>
		
		<section class="ip_name ip2">
			<p><span>Martin</span><label>英国</label>已认证</p>
		</section>
		<section class="ip_shengf ip2">
			<p>金融/合伙人/北京</p>
			<p><span><img src="${_base }/resources/img/icon19.png"/></span></p>
		</section>
		
		<section class="ip2_pengyou">
			<ul>
				<li><a href="#"><span>10</span><label>益友</label></a></li>
				<li><a href="#"><span>10</span><label>助人</label></a></li>
				<li><a href="#"><span>35</span><label>关注</label></a></li>
				<li><a href="#"><span>16</span><label>粉丝</label></a></li>
			</ul>
			<div class="clear"></div>
		</section>
		
		<section class="ip2_my">
			<section class="ip2_wid">
				<p class="ip2_1"><a href="#">我参加的</a></p>
				<p class="ip2_2"><a href="#">我发起的</a></p>
				<p class="ip2_3"><a href="#">我的收藏</a></p>
			</section>
		</section>
		
		<section class="ip2_my">
			<section class="ip2_wid">
				<p class="ip2_4"><a href="#">我的时间线</a></p>
				<p class="ip2_5"><a href="#">我的名片</a></p>
				<p class="ip2_6"><a href="#">财富</a></p>
			</section>
		</section>
		
		<section class="ip2_my">
			<section class="ip2_wid">
				<p class="ip2_7"><a href="#">会员中心</a></p>
				<p class="ip2_8"><a href="#">设置</a></p>
			</section>
		</section>
		
	</section>
	<footer class="footer">
        <ul>
            <li><a href="">
                <div class="img"><img src="${_base }/resources/img/f1.png" /></div>
                <div class="text">Be</div>
                </a>
            </li>
            <li><a href="">
                <div class="img"><img src="${_base }/resources/img/f2.png" /></div>
                <div class="text">Go</div>
                </a>
            </li>
            <li><a href="">
                <div class="img"><img src="${_base }/resources/img/f3.png" /></div>
                <div class="text">Frd</div>
                </a>
            </li>
            <li><a href="">
                <div class="img"><img src="${_base }/resources/img/f4.png" /><i>6</i></div>
                <div class="text">Msg</div>
                </a>
            </li>
            <li class="on"><a href="">
                <div class="img"><img src="${_base }/resources/img/f5.png" /></div>
                <div class="text">Me</div>
                </a>
            </li>
        </ul>
    </footer>
	
</body>
</html>