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
<title>发布G&O</title>
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
        $(function () {
            $(".act_info p span").click(function () {
                $(this).parents("p").find("span").removeClass("on")
                $(this).addClass("on")
            })
            $(".me_qingke p").click(function () {
                $(this).parents(".me_qingke").find("p").removeClass("on")
                $(this).addClass("on")
            })
            $(".online_no p span").click(function () {
                $(this).parents("p").find("span").removeClass("on")
                $(this).addClass("on")
            })
            $(".quxiao img").click(function () {
                $(this).parents("li").hide()
            })
            $(".yingchang img").click(function () {
                $(this).parents(".items").remove();
            }) 
               $(".fabu_but p span.on").click(function () {
                   var obj = $(".add_edit").find(".zhuti_hanhua.add_mask").clone(true);
                   $(".add_edit").append(obj.removeClass("add_mask"));
            })
            $(".fabu_but p span.in").click(function () {
                var obj = $(".add_edit").find(".jia_img.add_mask").clone(true);
                $(".add_edit").append(obj.removeClass("add_mask"));
            })
            $(".chooes_2 ul li a").click(function () {
                if ($(this).parent("li").hasClass("on")) { }
                else {
                    var str = $(this).html();
                }
            })
            $(".chooes_2 ul li a").click(function () {
                if ($(this).parent("li").hasClass("on")) { }
                else {
                    var str = $(this).html();
                }
            })
            $(".chooes_2 ul li a").click(function () {
                if ($(this).parents(".lat_xuanz").find(".fabu_biaoqian").find("li").length >= 6 || $(this).parent("li").hasClass("on")) { }
                else {
                    var li = $(".fabu_biaoqian ul li").first().clone(true);
                    li.find("a").html($(this).html());
                    $(this).parents(".lat_xuanz").find(".fabu_biaoqian ul").append(li);
                    $(this).parents(".lat_xuanz").find(".fabu_biaoqian").find("em").html($(this).parents(".lat_xuanz").find(".fabu_biaoqian").find("li").length-1)
                    $(this).parent("li").remove();
                }
            })
			
			
			$(".datepicker").datepicker({
				showOtherMonths: true,
				selectOtherMonths: true
			});
	 
 
        })
		function pkFunc(){
		 
		}
		function week(wk){
		var week="";
		switch(wk){
		case 0:week="星期日";break;
		case 1:week="星期一";break;
		case 2:week="星期二";break;
		case 3:week="星期三";break;
		case 4:week="星期四";break;
		case 5:week="星期五";break;
		case 6:week="星期六";break; 
		}
		}
        function FB_none(obg) {
            var str = $(obg).parents("li").find("a").html();
            var li = $(obg).parents(".lat_xuanz").find(".chooes_2").find("li").first().clone(true);

            $(".lat_xuanz").find(".fabu_biaoqian").find("p").find("em").html($(".lat_xuanz").find(".fabu_biaoqian").find("li").length - 2);

            li.find("a").html(str);
            $(obg).parents(".lat_xuanz").find(".chooes_2").find("ul").prepend(li);
            $(obg).parents("li").remove();
        }
    </script>
</head>
<body class="body">
	<section class="fabu_go">
		<section class="fabu_zhuti diyi">
			<p>发布主题</p>
		</section>
		<section class="geizhuti">
			<p>
				<input type="text" value="请给个Sexy的主题">
			</p>
		</section>
		<section class="fabu_zhuti dier">
			<p>活动信息</p>
		</section>
		<section class="act_info">
			<p>
				<span>Group邀请<input type="text" value="5-6" />人
				</span><span class="on">One on One</span>
			</p>
		</section>
		<section class="inp_time">
			<p>
				<span><input type="text" value="2016-5-25 星期三 10:41 "
					class="datepicker" /></span><label><input type="text"
					value="约一个小时" /></label>
			</p>
		</section>
		<section class="me_qingke">
			<p>
				固定费用<input type="text" value="150">/人
			</p>
			<p>
				A A 预付<input type="text" value="150">/人<span>多退少补</span>
			</p>
			<p>我请客</p>
		</section>
		<section class="online_no">
			<p>
				<span class="on">线下服务</span><span>在线服务</span>
			</p>
			<p>
				<input type="text" value="北京中关村附近" />
			</p>
		</section>
		<section class="fabu_zhuti disan">
			<p>活动详情</p>
		</section>

		<section class="add_edit">
			<section class="zhuti_hanhua add_mask items">
				<p>
					<textarea>
请说说这个主题能掏些什么干货…
一.主题
二.内容
三.说明
四.注意
                    </textarea>
				</p>
				<section class="yingchang">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>

			<section class="zhuti_hanhua items">
				<p>
					<textarea>
请说说这个主题能掏些什么干货…
一.主题
二.内容
三.说明
四.注意
                    </textarea>
				</p>
			</section>






			<section class="jia_img add_mask items">
				<p>
					<img src="//static.tfeie.com/images/img51.png">
				</p>
				<p>上传图片</p>
				<section class="yingchang on">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>



		</section>

		<section class="fabu_but">
			<p>
				<span class="in"><a>添加图片</a></span><span class="on"><a>添加文本</a></span>
			</p>
		</section>
		<div class="clear"></div>

		<section class="fabu_zhuti disi">
			<p>标签</p>
		</section>

		<section class="lat_xuanz">
			<section class="fabu_biaoqian">
				<p>
					已选标签（<em>3</em>/5）
				</p>
				<ul>
					<li><a>营销</a>
						<section class="quxiao" onclick="FB_none($(this));">
							<img src="//static.tfeie.com/images/img50.png" />
						</section></li>
					<li><a>营销</a>
						<section class="quxiao" onclick="FB_none($(this));">
							<img src="//static.tfeie.com/images/img50.png" />
						</section></li>
					<li><a>品牌</a>
						<section class="quxiao" onclick="FB_none($(this));">
							<img src="//static.tfeie.com/images/img50.png" />
						</section></li>
					<li><a>渠道</a>
						<section class="quxiao" onclick="FB_none($(this));">
							<img src="//static.tfeie.com/images/img50.png" />
						</section></li>
				</ul>
			</section>
			<section class="chooes_2 fabu">
				<p>可选标签</p>
				<ul>
					<li><a>品牌</a></li>
					<li><a>渠道</a></li>
					<li><a>营销</a></li>
					<li><a>战略</a></li>
					<li><a>创意</a></li>
					<li><a>管理</a></li>
					<li><a>运动</a></li>
					<li><a>设计</a></li>
					<li><a>编程</a></li>
					<li class="on"><a><img
							src="//static.tfeie.com/images/img54.png"></a></li>
				</ul>
			</section>
		</section>

		<section class="fabu_zhuti diwu">
			<p>我的故事</p>
		</section>
		<section class="my_gushi">
			<p>
				<textarea>请说说关于这个主题你的故事…</textarea>
			</p>
		</section>

		<section class="sec_btn2 fabu">
			<input type="button" value="发布">
		</section>

	</section>
</body>
</html>