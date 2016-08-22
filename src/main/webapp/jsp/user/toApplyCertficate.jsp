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
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>

</head>

<body>
	<section class="sec_item">
		<div class="div_title">
			<h3>
				<span>申请认证请提交以下材料</span>
				<c:if test="${userInfo.authSts=='13'}">
				<p><font color='red'>您提交的材料审核不通过，原因:<c:out value="${userInfo.certRemark }"/>。请重新按照要求提交</font></p>
				</c:if>
			</h3>
		</div>
		<ul>
			<li>海外学历认证、学生证、毕业证或工作证</li>
			<li>学生签证、或海外居住证明
			</li>
			<li>认证通过之后，将点亮头像旁边的“已认证”字样，并可享受更多权限哦。</li>
			
			
		</ul>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传海外学历认证、学生证、毕业证或工作证</span>
			</h3>
		</div>
		<div class="img" id="IMGIDCardPicker">
			<img src="//static.tfeie.com/images/img5.png" id="img_idcard"/>
		</div>
	</section>
	<section class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传学生签证、或海外居住证明</span>
			</h3>
		</div>
		<div class="img" id="IMGOverSeaPicker">
			<img src="//static.tfeie.com/images/img5.png" id="img_oversea"/>
		</div>
	</section>
	<section class="me_qingke">
		<p name="authIdentity" authIdentity="1000">创业者</p>
		<p name="authIdentity" authIdentity="2000">投资人</p>
		<p name="authIdentity" authIdentity="3000">导师</p>
		<p name="authIdentity" authIdentity="4000">创业服务</p>
	</section>
	<div class="message-err" id="DIV_TIPS"></div>
	<section class="but_baoc">
		<p>
			<input type="hidden" id="idcardPhoto"/>
			<input type="hidden" id="overseasPhoto"/>
			<input type="button" value="提交认证" id="BTN_SUBMIT"/>
		</p>
	</section>
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
		src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>

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
	(function($){
		$.UserCertificatePage = function(data){
			this.settings = $.extend(true,{},$.UserCertificatePage.defaults);
			this.params= data?data:{}
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
					}).addRule({
						labelName: "认证身份",
						fieldName: "authIdentity",
						getValue: function(){
							var v = $.trim($("[name='authIdentity'].on").attr("authIdentity"));
							return v;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择认证身份"
						}
					});
					this.valueValidator =valueValidator;
				},
				
				bindEvents: function(){
					var _this = this; 
					$("#BTN_SUBMIT").on("click",function(){
						_this.submit();
					});
					
					$("[name='authIdentity']").on("click",function(){
						$("[name='authIdentity']").removeClass("on");
						$(this).addClass("on");
					});
					
					$("#IMGOverSeaPicker").on("click", function() {
						wx.chooseImage({
							count : 1,
							sizeType: ['compressed'],
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
												userId: _this.getPropertyValue("userId")
											},
											success: function(transport){
												weUI.showXToast("上传成功");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 1000);
												var imgURL  = transport.data;
												$("#overseasPhoto").val(imgURL);
												$("#img_oversea").attr("src", imgURL).css({"width":"193.8px","height":"120px"});
											},
											failure: function(transport){
												$("#img_oversea").attr("src", "//static.tfeie.com/images/img5.png");
												weUI.showXToast("上传失败请重试");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 1000);
											}
											
										});
									},
									fail : function(res) {
										$("#img_oversea").attr("src", "//static.tfeie.com/images/img5.png");
										weUI.showXToast("上传失败请重试");
										setTimeout(function () {
											weUI.hideXToast();
							            }, 1000);
									}
								});
							}
						});
					});
					
					$("#IMGIDCardPicker").on("click", function() {
						wx.chooseImage({
							count : 1,
							sizeType: ['compressed'],
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
												userId: _this.getPropertyValue("userId")
											},
											success: function(transport){
												weUI.showXToast("上传成功");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 1000);
												var imgURL  = transport.data;
												$("#idcardPhoto").val(imgURL);
												$("#img_idcard").attr("src", imgURL).css({"width":"193.8px","height":"120px"});
											},
											failure: function(transport){
												weUI.showXToast("上传失败请重试");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 1000);
												$("#img_idcard").attr("src", "//static.tfeie.com/images/img5.png");
											}
											
										});
									},
									fail : function(res) {
										weUI.showXToast("上传失败请重试");
										setTimeout(function () {
											weUI.hideXToast();
							            }, 1000);
										$("#img_idcard").attr("src", "//static.tfeie.com/images/img5.png");
									}
								});
							}
						});
					});
				}, 
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				},
			
				submit: function(){
					var _this=this;
					var res=_this.valueValidator.fireRulesAndReturnFirstError();
					if(res){
						weUI.showXToast(res);
						setTimeout(function () {
							weUI.hideXToast();
			            }, 500);
						return;
					}
					ajaxController.ajax({
						url: "../user/submitUserCertficate",
						type: "post",
						data: {
							userId: _this.getPropertyValue("userId"),
							overseasPhoto: $("#overseasPhoto").val(),
							idcardPhoto: $("#idcardPhoto").val(),
							authIdentity: $.trim($("[name='authIdentity'].on").attr("authIdentity"))
						},
						success: function(transport){
							weUI.showXToast("已提交等待审核");
							setTimeout(function () {
								weUI.hideXToast();
								window.location.href="../user/userCenter.html";
				            }, 1000);
						},
						failure: function(transport){
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
						
					});
					
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var b = new $.HarborBuilder();
		b.buildFooter({showBeGoQuick: "hide"});
		var p = new $.UserCertificatePage({
			userId: "<c:out value="${userInfo.userId}" />"
		});
		p.init();
	});
</script>
</html>