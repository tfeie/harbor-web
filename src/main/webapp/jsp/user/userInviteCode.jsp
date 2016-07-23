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
<title>邀请码</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
</head>
<body>
<!-- <section class="fabu_zhuti diwu" name="SELECTION_MYSTORY" >
	<p>邀请码</p>
</section>
<section class="par_name">
	<p class="boss">
	<input type="text" id="CUSTOMIZE_GO_TAGS" placeholder="请输入一个标签:4个字符以内">
	</p>
	</section>
	<div class="message-err" id="_customized_go_tag_error"></div> -->
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
		src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

(function() {
	$.PreAuthPage = function(data) {
		this.settings = $.extend(true,{},$.PreAuthPage.defaults);
		this.params= data?data:{};
	};
	
	$.extend($.PreAuthPage,{
		defaults:{
			
		},
		prototype:{
			init:function(){
				this.bindEvents();
				this.initData();
			},
			
			bindEvents:function(){
				
			},
			initData: function(){
				var _this = this; 

				var content = "<section class=\"par_name\">";
				content +="<p class=\"boss\">";
				content +="<input type=\"text\" id=\"INVITE_CODE\" placeholder=\"请输入邀请码\">";
				content +="</p>";
				content +="</section>";
				content +="<div class=\"message-err\" id=\"_customized_go_tag_error\"></div>";
				weUI.confirm({
					title: "请输入邀请码",
					content: content,
					ok: function(){
						
						_this.checkUserInvite();
						
					}
				
				});
			},
			
			checkUserInvite:function(){
				var _this = this;
				var code =$.trim($("#INVITE_CODE").val());
				if(code == ""){
					$("#_customized_go_tag_error").html("<p><span>X</span>请输入邀请码</p>").show();
					return;
				} else {
					$("#_customized_go_tag_error").hide();
				}
				ajaxController.ajax({
					url: "../user/checkUserInviteCode",
					type: "post", 
					data: {
						inviteCode:code,
					},
					success: function(transport){
						var data =transport.data;
						window.location.href="../user/toUserRegister.html?pcode=" + data;
						//关闭窗口
						weUI.closeConfirm();
					},
					failure: function(transport){  
						$("#_customized_go_tag_error").html("<p><span>X</span>邀请码不正确或已失效</p>").show();
					}
				});
			}
		}
	});
})(jQuery);

 $(document).ready(function(){
	var p = new $.PreAuthPage({});
	p.init();
});
</script>
</html>