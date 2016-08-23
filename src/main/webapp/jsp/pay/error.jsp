<%@ page language="java" contentType="text/html; utf-8"
	pageEncoding="utf-8"%>
<%
	String bp = request.getContextPath();
	request.setAttribute("_base", bp);
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "No-cache");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
	<script type="text/javascript" src="<%=bp%>/resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
 	<script type="text/javascript" charset="utf-8">
	 	
 	
 	</script>
  </head> 
  <body>
  ${errmsg}
  </body>
</html>













