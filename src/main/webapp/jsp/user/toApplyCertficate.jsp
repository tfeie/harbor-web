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
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/footer.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/json2.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
</head>

<body class="bg-eeeeee">
	<section class="rztj-main">
    	<div class="top bor-bot">通过认证后，头像点亮角色字样，享受更多字样</div>
    	<c:if test="${userInfo.authSts=='13'}">
			<p><font color='red'>您提交的材料审核不通过，原因:<c:out value="${userInfo.certRemark }"/>。请重新按照要求提交</font></p>
		</c:if>
        <div class="hd">
        	<div class="t">请选择角色认证</div>
            <div class="m clearfix">
            	 <c:forEach var="ai" items="${authIdentityList}">
            	<label class="itms"><input type="radio" name="authIdentity" value="${ai.paramValue}"  class="In-radio">${ai.paramDesc}</label>
            	</c:forEach>
            </div>
        </div>
        <div class="bd">
            <div class="m">
            	<div class="itms">
                	<div class="up-1">
                        <div class="t">请上传海外经历证件</div>
                        <p>任选其一，留学签证，访问学者签证，工作签证，海外学生证，海外学历认证，</p>
                        <label class="upimg" id="IMGOverSeaPicker"><img src="//static.tfeie.com/v2/images/img51-1.png" id="img_oversea"></label>
                    </div>
                	<div class="up-2" style="display:none">
                        <div class="t">请上传认证角色资料</div>
                        <p>请上传公司名片</p>
                        <label class="upimg" id="IMGIDCardPicker"><img src="//static.tfeie.com/v2/images/img51-1.png" id="img_idcard"></label>
                    </div>
                </div>
            </div>
        </div>
        <div class="but-btn"><input type="hidden" id="idcardPhoto"/>
			<input type="hidden" id="overseasPhoto"/>
			<input type="button" value="提交认证" id="BTN_SUBMIT"/></div>
    </section>
</body>


<script type="text/javascript">
	$(document).ready(function(){
		var b = new $.HarborBuilder();
		b.buildFooter({showBeGoQuick: "hide"});
		var p = new $.UserCertificatePage({
			userId: "<c:out value="${userInfo.userId}" />"
		});
		p.init();
	});
	
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
				},
				
				bindEvents: function(){
					var _this = this; 
					$("#BTN_SUBMIT").on("click",function(){
						_this.submit();
					});
					
					$("[name='authIdentity']").on("click",function(){
						$("[name='authIdentity']").removeClass("on");
						$(this).addClass("on");
						var v=$(this).val();
						if(	v==	'1000'){
							$('.up-1').css({display:'block'})
							$('.up-2').css({display:'none'})
						}else if(v=='2000'){
							$('.up-1').css({display:'block'})
							$('.up-2').css({display:'block'})
						}else if(v=='3000'){
							$('.up-1').css({display:'block'})
							$('.up-2').css({display:'block'})
						}else if(v=='4000'){
							$('.up-1').css({display:'none'})
							$('.up-2').css({display:'block'})
						}else if(v=='5000'){
							$('.up-1').css({display:'none'})
							$('.up-2').css({display:'block'})
						}else if(v=='6000'){
							$('.up-1').css({display:'none'})
							$('.up-2').css({display:'block'})	
						}
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
												$("#img_oversea").attr("src", imgURL);
											},
											failure: function(transport){
												$("#img_oversea").attr("src", "//static.tfeie.com/v2/images/img51-1.png");
												weUI.showXToast("上传失败请重试");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 1000);
											}
											
										});
									},
									fail : function(res) {
										$("#img_oversea").attr("src", "//static.tfeie.com/v2/images/img51-1.png");
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
												$("#img_idcard").attr("src", imgURL);
											},
											failure: function(transport){
												weUI.showXToast("上传失败请重试");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 1000);
												$("#img_idcard").attr("src", "//static.tfeie.com/v2/images/img51-1.png");
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
					var v = $("[name='authIdentity']:checked").val();
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "认证身份",
						fieldName: "authIdentity",
						getValue: function(){
							return v;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择角色认证"
						}
					});
					
					if(v=="2000" || v=="3000"  || v=="4000"  || v=="5000"  || v=="6000"){
						valueValidator.addRule({
							labelName: "请上传认证角色资料",
							fieldName: "idcardPhoto",
							getValue: function(){
								var v = $("#idcardPhoto").val();
								return v;
							},
							fieldRules: {
								required: true
							},
							ruleMessages: {
								required: "请上传认证角色资料"
							}
						});
					}
					if(v=="1000" || v=="2000"  || v=="3000"){
						valueValidator.addRule({
							labelName: "请上传海外经历证件",
							fieldName: "overseasPhoto",
							getValue: function(){
								var v = $("#overseasPhoto").val();
								return v;
							},
							fieldRules: {
								required: true
							},
							ruleMessages: {
								required: "请上传海外经历证件"
							}
						});
					} 
					var res=valueValidator.fireRulesAndReturnFirstError();
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
							authIdentity: v
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
</script>
</html>