<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>

<%
if(pageContext.getException() instanceof com.the.harbor.base.exception.BusinessException){
	com.the.harbor.base.exception.BusinessException ex = (com.the.harbor.base.exception.BusinessException)pageContext.getException();
	request.setAttribute("title", "页面访问失败");
	request.setAttribute("error", ex.getMessage());
}else {
	request.setAttribute("title", "系统繁忙，请稍候再试..");
	request.setAttribute("error", "系统繁忙，请稍候再试..");
} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title><c:out value="${title}"/> </title>
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
	<section class="hailiuqueren"> 

		<section class="feiyong">
			<p>
				<img src="//static.tfeie.com/images/img23.png">
			</p>
			<section class="monry-info">
				<p>
					<label>
					
					<c:out value="${error}"/>
					
					</label>
				</p> 
			</section>
		</section>
	</section>

</body>
</html>