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
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
 	<script type="text/javascript" charset="utf-8">
	 	$(document).ready(function() {
	 		
	 		function onBridgeReady(){
		 	   var appId='${appId}';
		 	   var timeStamp='${timeStamp}';
		 	   var nonceStr='${nonceStr}';
		 	   var packageValue='${packageValue}';
		 	   var sign='${sign}';
		 	   alert("[appId:"+appId+";"+"timeStamp:"+timeStamp+";"+"nonceStr:"+nonceStr+";"+"packageValue:"+packageValue+";"+"sign:"+sign+"]");
	 		   WeixinJSBridge.invoke(
	 		       'getBrandWCPayRequest', {
	 		           "appId" : appId,     //公众号名称，由商户传入     
	 		           "timeStamp":timeStamp,         //时间戳，自1970年以来的秒数     
	 		           "nonceStr": nonceStr, //随机串     
	 		           "package":packageValue,     
	 		           "signType": "MD5",         //微信签名方式：     
	 		           "paySign":sign //微信签名 
	 		       },
	 		       function(res){     
	 		    	  WeixinJSBridge.log(res.err_msg);
						//alert("微信返回信息："+res.err_code +"," +res.err_desc +","+ res.err_msg);
						if (res.err_msg == "get_brand_wcpay_request:ok") {
							alert("支付成功");
						} else if (res.err_msg == "get_brand_wcpay_request:cancel") {
							alert("用户取消支付!");
						} else {
							alert("支付失败!");
						}
						WeixinJSBridge.call('closeWindow'); // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
	 		       }
	 		   ); 
	 		}
	 		if (typeof WeixinJSBridge == "undefined"){
	 		   if( document.addEventListener ){
	 		       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	 		   }else if (document.attachEvent){
	 		       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	 		       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	 		   }
	 		}else{
	 		   onBridgeReady();
	 		} 

	 	});
 	
 	</script>
  </head> 
</html>













