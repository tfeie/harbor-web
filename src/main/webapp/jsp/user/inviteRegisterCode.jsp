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
<title>输入邀请码</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
</head>
<section class="mycenter">

	<section class="sec_item">
		<div class="div_cont">
			<div class="img">
				<img src="//static.tfeie.com/images/invite.png" alt="" />
			</div>
		</div>
	</section>

		<section class="sec_item">
		
		<div class="item">
			<span>邀请码</span><label><input type="text" id="inviteCode"
					placeholder="请输入4位邀请码" /></label>
		</div>
	</section>
	<section class="but_baoc">
		<p>
			<input type="button" value="立即注册" id="BTN_REG"/>
		</p>
	</section>

</section>


</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript">
	(function($) {
		$.InviteRegCodePage = function(data) {
			this.settings = $.extend(true, {}, $.InviteRegCodePage.defaults);
			this.params= data?data:{}
		}
		$.extend($.InviteRegCodePage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents(); 
				},

				bindEvents : function() {
					var _this = this;
					$("#BTN_REG").on("click", function() {
						_this.checkInviteCode();
					});
				},
				
				checkInviteCode: function(){
					var inviteCode = $.trim($("#inviteCode").val());
					if(inviteCode==""){
						weUI.alert({content:"请输入邀请码"});
					}
					ajaxController.ajax({
						url: "../user/checkUserInviteCode",
						type: "post", 
						data: {
							inviteCode: inviteCode,
						},
						success: function(transport){
							var data =transport.data;
							window.location.href="../user/toUserRegister.html?pcode=" + data;
						},
						failure: function(transport){  
							weUI.alert({content:transport.statusInfo});
						}
					});
				},
				

				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);

	$(document).ready(function() {
		var p = new $.InviteRegCodePage({
		});
		p.init();
	});
</script>
</html>