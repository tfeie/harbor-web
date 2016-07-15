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
<title>申请认证</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
	<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
</head>

<body>
	<section class="sec_item">
		<div class="div_title">
			<h3>
				<span>申请认证请提交以下材料</span>
			</h3>
		</div>
		<ul>
			<li>身份证照片</li>
			<li>海外学历认证文件或留学签证扫描件或<br />学生证扫描件
			</li>
			<li>认证通过之后，将点亮头像旁边的“已认证”字样，并可享受更多权限哦。</li>
		</ul>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传身份证（正）</span>
			</h3>
		</div>
		<div class="img" id="IMGIDCardPicker">
			<img src="//static.tfeie.com/images/img4.jpg" id="img_idcard"/>
		</div>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传海外学历认证/签证/学生证</span>
			</h3>
		</div>
		<div class="img" id="IMGOverSeaPicker">
			<img src="//static.tfeie.com/images/img5.png" id="img_oversea"/>
		</div>
	</section>
	<div class="message-err" id="DIV_TIPS"></div>
	<section class="but_baoc">
		<p>
			<input type="hidden" id="idcardPhoto"/>
			<input type="hidden" id="overseasPhoto"/>
			<input type="button" value="提交认证" id="BTN_SUBMIT"/>
		</p>
	</section>
	<footer class="footer">
		<ul>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f1.png" />
					</div>
					<div class="text">Be</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f2.png" />
					</div>
					<div class="text">Go</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f3.png" />
					</div>
					<div class="text">Frd</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f4.png" /><i>6</i>
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li class="on"><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>

</body>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
		src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript">
	wx.config({
		debug : false,
		appId : '<c:out value="${appId}"/>',
		timestamp : <c:out value="${timestamp}"/>,
		nonceStr : '<c:out value="${nonceStr}"/>',
		signature : '<c:out value="${signature}"/>',
		jsApiList : [ 'checkJsApi', 'chooseImage', 'previewImage',
				'uploadImage', 'downloadImage' ]
	});
	wx.ready(function() {
		$("#IMGOverSeaPicker").bind("click", function() {
			wx.chooseImage({
				count : 1,
				sizeType: ['original'],
				success : function(res) {
					var localId = res.localIds[0]; 
					wx.uploadImage({
						localId : localId,
						isShowProgressTips : 1,
						success : function(r) {
							var mediaId = r.serverId;
							ajaxController.ajax({
								url: "../user/uploadUserAuthFileToOSS",
								type: "post",
								data: {
									mediaId: mediaId,
									userId:"<c:out value="${userInfo.userId}"/>"
								},
								success: function(transport){
									var imgURL  = transport.data;
									$("#overseasPhoto").val(imgURL);
									$("#img_oversea").attr("src", imgURL).css({"width":"193.8px","height":"120px"});
								},
								failure: function(transport){
									alert("上传失败");
									$("#img_oversea").attr("src", "//static.tfeie.com/images/img5.png");
								}
								
							});
						},
						fail : function(res) {
							alert("上传失败");
							$("#img_oversea").attr("src", "//static.tfeie.com/images/img5.png");
						}
					});
				}
			});
		});
		
		$("#IMGIDCardPicker").bind("click", function() {
			wx.chooseImage({
				count : 1,
				sizeType: ['original'],
				success : function(res) {
					var localId = res.localIds[0]; 
					wx.uploadImage({
						localId : localId,
						isShowProgressTips : 1,
						success : function(r) {
							var mediaId = r.serverId;
							ajaxController.ajax({
								url: "../user/uploadUserAuthFileToOSS",
								type: "post",
								data: {
									mediaId: mediaId,
									userId:"<c:out value="${userInfo.userId}"/>"
								},
								success: function(transport){
									var imgURL  = transport.data;
									$("#idcardPhoto").val(imgURL);
									$("#img_idcard").attr("src", imgURL).css({"width":"193.8px","height":"120px"});
								},
								failure: function(transport){
									alert("上传失败");
									$("#img_idcard").attr("src", "//static.tfeie.com/images/img4.png");
								}
								
							});
						},
						fail : function(res) {
							alert("上传失败");
							$("#img_idcard").attr("src", "//static.tfeie.com/images/img4.png");
						}
					});
				}
			});
		});
	});
	
	
	(function($){
		$.UserCertificatePage = function(){
			this.settings = $.extend(true,{},$.UserCertificatePage.defaults);
		}
		$.extend($.UserCertificatePage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.bindRules(); 
				}, 
				
				bindRules: function(){
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "身份证正面",
						fieldName: "idcardPhoto",
						getValue: function(){
							var v = $("#idcardPhoto").val();
							return v;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请上传身份证正面照"
						}
					}).addRule({
						labelName: "海外学历认证/签证/学生证",
						fieldName: "overseasPhoto",
						getValue: function(){
							var v = $("#overseasPhoto").val();
							return v;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请上传海外学历认证/签证/学生证"
						}
					});
					this.valueValidator =valueValidator;
				},
				
				bindEvents: function(){
					var _this = this; 
					$("#BTN_SUBMIT").bind("click",function(){
						_this.submit();
					});
				}, 
				submit: function(){
					var _this=this;
					var res=_this.valueValidator.fireRulesAndReturnFirstError();
					if(res){
						_this.showError(res);
						return;
					}else{
						_this.hideMessage();
					}
					ajaxController.ajax({
						url: "../user/submitUserCertficate",
						type: "post",
						data: {
							userId:"<c:out value="${userInfo.userId}"/>",
							overseasPhoto: $("#overseasPhoto").val(),
							idcardPhoto: $("#idcardPhoto").val()
						},
						success: function(transport){
							_this.showSuccess("认证材料提交成功，请等待审核");
						},
						failure: function(transport){
							_this.showError("系统繁忙，请稍候重试");
						}
						
					});
					
				},
				
				showError: function(message){
					$(".message-err").show().html("<p><span>X</span>"+message+"</p>");
				},
				
				showSuccess: function(message){
					$(".message-err").show().html("<p><span></span>"+message+"</p>");
				},
				
				hideMessage: function(){
					$(".message-err").html("").hide();
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var p = new $.UserCertificatePage();
		p.init();
	});
</script>
</html>