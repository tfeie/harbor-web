<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>申请认证</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
</head>

<body>
	<section class="sec_item">
		<div class="div_title">
			<h3>
				<span>申请认证请提交以下材料</span>
			</h3>
		</div>
		<ul>
			<li>身份证照片</li>
			<li>海外学历认证文件或留学签证扫描件或<br />学生证扫描件
			</li>
			<li>认证通过之后，将点亮头像旁边的“已认证”字样，并可享受更多权限哦。</li>
		</ul>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传身份证（正）</span>
			</h3>
		</div>
		<div class="img">
			<img src="//static.tfeie.com/images/img4.jpg" />
		</div>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传海外学历认证/签证/学生证</span>
			</h3>
		</div>
		<div class="img" id="filePicker">
			<img src="//static.tfeie.com/images/img5.png" id="img_oversea"/>
		</div>
	</section>
	<section class="but_baoc">
		<p>
			<input type="button" value="提交认证" />
		</p>
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
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	wx.config({
		debug : false,
		appId : '<c:out value="${appId}"/>',
		timestamp : <c:out value="${timestamp}"/>,
		nonceStr : '<c:out value="${nonceStr}"/>',
		signature : '<c:out value="${signature}"/>',
		jsApiList : [ 'checkJsApi', 'chooseImage', 'previewImage',
				'uploadImage', 'downloadImage' ]
	});
	wx.ready(function() {
		$("#filePicker").bind("click", function() {
			wx.chooseImage({
				count : 1,
				success : function(res) {
					var localId = res.localIds[0];
					$("#img_oversea").attr("src", localId).css({"width":"193.84px","height":"120px"}); 
					wx.uploadImage({
						localId : localId, // 需要上传的图片的本地ID，由chooseImage接口获得
						isShowProgressTips : 1, // 默认为1，显示进度提示
						success : function(r) {
							var serverId = r.serverId; // 返回图片的服务器端ID
						},
						fail : function(res) {
							alert(JSON.stringify(res));
						}
					});
				}
			});
		})
	});
</script>
</html>