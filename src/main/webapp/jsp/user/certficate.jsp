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
<title>认证</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
	<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
</head>
<script type="text/javascript">
	var ss = '${userInfo.idcardPhoto}';
	var s = 0;
</script>
<body>
	<section class="ip_info">
		<section class="info_img">
			<span><a href="#"><img src="${userInfo.wxHeadimg}"></a></span>
		</section>
		<section class="ip_text">
			<p>
				<span>${userInfo.enName}</span><label class="lbl2">${userInfo.abroadCountryName}</label><i>${userInfo.userStatusName}</i>
			</p>
			<p>${userInfo.industryName}/${userInfo.title}/${userInfo.atCityName}</p>
		</section>
	</section>
						
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传身份证（正）</span>
			</h3>
		</div>
		<div class="img" id="IMGIDCardPicker">
		<c:choose>
			<c:when test="${userInfo.idcardPhoto != ''}">
				<img src="${userInfo.idcardPhoto}" id="img_idcard"/>
			</c:when>
			<c:otherwise>
     			<img src="//static.tfeie.com/images/img4.jpg" id="img_idcard"/>
    		</c:otherwise>
		</c:choose>
			
		</div>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传海外学历认证/签证/学生证</span>
			</h3>
		</div>
		<div class="img" id="IMGOverSeaPicker">
		<c:choose>
			<c:when test="${userInfo.overseasPhoto != ''}">
				<img src="${userInfo.overseasPhoto}" id="img_oversea"/>
			</c:when>
			<c:otherwise>
     			<img src="//static.tfeie.com/images/img5.png" id="img_oversea"/>
    		</c:otherwise>
		</c:choose>
			
		</div>
	</section>
	<section class="me_qingke">
			<p name="payMode" class="on" subsStatus="20">通过</p>
			<p name="payMode" subsStatus="11">不通过</p>
	</section>
	<div class="message-err" id="DIV_TIPS"></div>
	<section class="but_baoc">
		<p>
			<input type="button" value="提交认证" id="BTN_SUBMIT"/>
		</p>
	</section>
</body>
</html>