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
<title>您访问的页面不存在或已被删除</title>
<link rel="dns-prefetch" href="//static.tfeie.com" />
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
</head>
<body class="bg-eeeeee">
	<section>
		<img src="//static.tfeie.com/v2/images/bg-404.png" width="100%" class="tio">
		<p class="te-cen pad-10-0 fs-15">Sorry,您访问的页面不存在或已被删除...</p>
		<a href="javascript:window.location.reload();"
			class="dis-block te-cen fs-15 fc-fe6847">刷新</a>

		<div class="btn-main">
			<a href="javascript:history.back(-1);" class="btn">返回上一页</a>
		</div>
	</section>
</body>
</html>