<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<title>系统繁忙，请稍候再试</title>
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
					<%
					if(pageContext.getException() instanceof com.the.harbor.base.exception.BusinessException){
						com.the.harbor.base.exception.BusinessException ex = (com.the.harbor.base.exception.BusinessException)pageContext.getException();
						response.getWriter().println(ex.getMessage());
					}else {
						response.getWriter().println("系统繁忙，请稍候再试..");
					} 
					%>
					
					
					</label>
				</p> 
			</section>
		</section>
	</section>

</body>
</html>