<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>

<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$("button").bind("click",function(){
		if (!!window.EventSource) {
			var source = new EventSource("<%=_base%>/user/listenerUserNotify");
			
			source.addEventListener('message', function(e) {
				$("p").html(e.data);
			});
		} else {
			
		}
	});

	
});
</script>
</head>
<body>
<p>监听消息</p>
<button>发起监听</button>

</body>
</html>