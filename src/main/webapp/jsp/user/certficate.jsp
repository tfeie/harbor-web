<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>认证</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 	
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>	
	<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
		src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
</head>

<body>
	<section class="ip_info">
		<section class="info_img">
			<span><a href="../user/userInfo.html?userId=<c:out value="${userInfo.userId}" />"><img src="<c:out value="${userInfo.wxHeadimg}" />"></a></span>
		</section>
		<section class="ip_text">
			<p>
				<span><c:out value="${userInfo.enName}" /></span><label class="lbl2" style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}" /></label><i><font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>><c:out value="${userInfo.userStatusName}" /></font></i>
			</p>
			<p><c:out value="${userInfo.employmentInfo}" /></p>
		</section>
	</section>
						
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>请上传认证角色资料</span>
			</h3>
		</div>
		<div class="img" id="IMGIDCardPicker">
			<img src="<c:out value="${userInfo.idcardPhoto}" />" width="193.8px" height="120px" id="img_card">
		</div>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>请上传海外经历证件</span>
			</h3>
		</div>
		<div class="img" id="IMGOverSeaPicker">
			<img src="<c:out value="${userInfo.overseasPhoto}"/>" width="193.8px" height="120px" id="img_overseas">
		</div>
	</section>
	<section class="me_qingke">
		<c:out value="${userInfo.authIdentityName}"/>
	</section>
	<section class="me_qingke">
		<p name="authResult" class="on" authStatus="12">通过</p>
		<p name="authResult" authStatus="13">不通过</p>
	</section>
	<section class="my_gushi" id="AUTH_REMARK" style="display:none">
        <p><textarea id="authRemark" placeholder="请填写审核不通原因…"></textarea></p>
    </section>
	<section class="but_baoc">
		<p>
			<input type="button" value="提交认证" id="BTN_SUBMIT"/>
		</p>
	</section>
</body>
<script type="text/javascript"
	src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>	
<script type="text/javascript">

//微信API配置
wx.config({
	debug : false,
	appId : '<c:out value="${appId}"/>',
	timestamp : '<c:out value="${timestamp}"/>',
	nonceStr : '<c:out value="${nonceStr}"/>',
	signature : '<c:out value="${signature}"/>',
	jsApiList : [ 'checkJsApi', 'previewImage']
});

(function() {
	$.AuthPage = function(data) {
		this.settings = $.extend(true,{},$.AuthPage.defaults);
		this.params= data?data:{};
	};
	
	$.extend($.AuthPage,{
		defaults:{
			
		},
		prototype:{
			init:function(){
				this.bindEvents();
			},
			
			bindEvents:function(){
				var _this = this;
				$("#BTN_SUBMIT").on("click",function(){
					_this.submit();
				});
				
				$("[name='authResult']").on("click",function(){
					$("[name='authResult']").removeClass("on");
					$(this).addClass("on");
					var authStatus = $(this).attr("authStatus");
					if(authStatus=="13"){
						$("#AUTH_REMARK").show();
					}else{
						$("#AUTH_REMARK").hide();
					}
				});
				
				$("#img_card").on("click",function(){
					var imageURL = $(this).attr("src");
					if(imageURL == ""){
						return;
					}
					var imageURLs = [];
					imageURLs.push(imageURL);
					wx.previewImage({
					    current: imageURL, // 当前显示图片的http链接
					    urls: imageURLs // 需要预览的图片http链接列表
					});
				});
				
				$("#img_overseas").on("click",function(){
					var imageURL = $(this).attr("src");
					if(imageURL == ""){
						return;
					}
					var imageURLs = [];
					imageURLs.push(imageURL);
					wx.previewImage({
					    current: imageURL, // 当前显示图片的http链接
					    urls: imageURLs // 需要预览的图片http链接列表
					});
				});
			},
			
			getPropertyValue: function(propertyName){
				if(!propertyName)return;
				return this.params[propertyName];
			},
			
			submit: function(){
				var authStatus = $.trim($("[name='authResult'].on").attr("authStatus"));
				var remark = $.trim($("#authRemark").val());
				var valueValidator = new $.ValueValidator();
				if(authStatus == "13"){
					valueValidator.addRule({
						labelName: "原因",
						fieldName: "remark",
						getValue: function(){
							var remark = $("#authRemark").val();
							return remark;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请填写原因"
						}
					});
				}
				var res=valueValidator.fireRulesAndReturnFirstError();
				if(res){
					weUI.showXToast(res);
					setTimeout(function () {
						weUI.hideXToast();
		            }, 1000);
					return;
				}
				ajaxController.ajax({
					url: "../user/submitUserAuthInfo",
					type: "post",
					data: {
						userId: this.getPropertyValue("userId"),
						status: authStatus,
						remark: remark
					},
					success: function(transport){
						weUI.showXToast("审核完成");
						setTimeout(function () {
							window.location.href="../user/unauthusers.html";
							weUI.hideXToast();
			            }, 1000);
					},
					failure: function(transport){
						weUI.showXToast(transport.statusInfo);
						setTimeout(function () {
							window.location.href="../user/unauthusers.html";
							weUI.hideXToast();
			            }, 1000);
					}
					
				});
			}
		}
	});
})(jQuery);

 $(document).ready(function(){
	var p = new $.AuthPage({
		userId: "<c:out value="${userInfo.userId}" />"
	});
	p.init();
});
</script>
</html>