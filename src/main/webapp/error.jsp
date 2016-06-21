<%@page import="com.the.harbor.commons.exception.SDKException"%>
<%@page import="com.the.harbor.base.exception.BusinessException"%>
<%@page import="com.the.harbor.base.exception.SystemException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>

<%
if(pageContext.getException() instanceof BusinessException){
	BusinessException ex = (BusinessException)pageContext.getException();
	request.setAttribute("error", ex.getMessage());
	request.setAttribute("title", ex.getMessage());
	request.setAttribute("needjump", ex.isNeedjump());
	request.setAttribute("url", ex.getUrl());
}else if(pageContext.getException() instanceof SystemException){
	SystemException ex = (SystemException)pageContext.getException();
	request.setAttribute("error", ex.getMessage());
	request.setAttribute("title", "系统繁忙，请稍候再试...");
	request.setAttribute("needjump", false);
}else if(pageContext.getException() instanceof SDKException){
	SDKException ex = (SDKException)pageContext.getException();
	request.setAttribute("error", ex.getMessage());
	request.setAttribute("title", "系统繁忙，请稍候再试...");
	request.setAttribute("needjump", false);
}else {
	request.setAttribute("error", "服务器抛锚了，攻城狮正在紧急维护中...");
	request.setAttribute("title", "系统繁忙，请稍候再试...");
	request.setAttribute("needjump", false);
} 
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
<title><c:out value="${title}"/></title>
<link rel="dns-prefetch" href="//static.tfeie.com" />
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript">
	function jumpURL(){
		var url="<c:out value="${url}" escapeXml="false"/>";
		if(url==""){
			weUI.alert({
				content: "没有指明去哪儿哦"
			});
		}else{
			window.location.href=url;
		}
	}

</script>
</head>
<body class="bg-eeeeee">
	<section>
    	<img src="//static.tfeie.com/v2/images/bg-500.png" width="100%" class="tio">
    	<p class="te-cen pad-10-0 fs-15"><c:out value="${error}"/></p>
    	<c:if test="${needjump==false}">
    		<a href="javascript:window.location.reload();" class="dis-block te-cen fs-15 fc-fe6847">刷新</a>
        	<div class="btn-main"><a  href="javascript:history.back(-1);" class="btn">返回上一页</a></div>
    	</c:if>
    	<c:if test="${needjump==true}">
    		<div class="btn-main"><a  href="javascript:void(0)" class="btn" onclick="jumpURL()">点击前往</a></div>
    	</c:if>
    </section>
</body>
</html>