<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String _base = request.getContextPath();
			request.setAttribute("_base", _base);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
<script type="text/javascript"
	src="${_base }/resources/js/jquery-1.11.1.min.js"></script>
<title>支付</title>
</head>
<script type="text/javascript">
$(function(){
	$("#btn-quera").bind("click",function(){
		var orderId = $("#norder").val();
		var orderAmount = "0.01";
		location.href="<%=_base%>/payment/getAuthorizeCode?orderId=" + orderId + "&orderAmount=" + orderAmount;
	});
});
</script>

<body>
 <li>验证码：
 <input id="norder" type="text" placeholder="请输入订单号" maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')"/></li>
 
<div style="width:100%; float:left; padding-bottom:44px; margin-top:20px; padding:0 10px;" id='pbtnIda'>
    <a style="width:100%; float:left; color:#fff; background:#ffc323; line-height:44px; text-align:center;border-radius:5px;" 
    href="#" id="btn-quera">确定</a>
 </div>
</body>
</html>