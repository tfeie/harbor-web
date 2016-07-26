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
<title>审核信息</title>
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
</head>
<body>
	<section class="mainer in">
		<section class="ma_shenghe">
			<p>
				<c:out value="${go.topic}" />
			</p>
		</section>
		<section class="shenhe_xinxi">
			<section class="info_fuwu">
				<section class="ip_info">
					<section class="info_img">
						<span><a href="../user/userInfo.html?userId=<c:out value="${go.userId}" />"><img src="<c:out value="${go.wxHeadimg}"/>"></a></span>
					</section>
					<section class="ip_text">
						<p>
							<span><c:out value="${go.enName}" /></span><label class="lbl2" style="background:<c:out value="${go.abroadCountryRGB}" />"><c:out
									value="${go.abroadCountryName}" /></label>
							<c:out value="${go.userStatusName}" />
						</p>
						<p>
							
								<c:out value="${go.employmentInfo}" escapeXml="false" />
					
						</p>
					</section>
					<div class="clear"></div>
				</section>
				<section class="info_time">
					<p>
						<span><c:out value="${go.expectedStartTime}" /></span><a href="#"><c:out value="${go.orgModeName}" /></a>
					</p>
				</section>
				<section class="info_time back1">
					<p>
						<span>Group邀请<c:out value="${go.inviteMembers}" />人</span><a href="#"><c:out value="${go.fixPriceYuan}" />元</a>
					</p>
				</section>
				<section class="info_time back2">
					<p>
						<span><c:out value="${go.location}" /></span>
					</p>
				</section>
				<section class="info_fangf pz">
					<article>
					<c:forEach var="detail" items="${go.goDetails }">
						<c:if test="${detail.type=='text'}">
							<p>
								<c:out value="${detail.detail}" />
							</p>
						</c:if>
						<c:if test="${detail.type=='image'}">
							<p>
								<img src="<c:out value="${detail.imgThumbnailUrl}"/>" width="100%">
							</p>
						</c:if>
					</c:forEach>
					</article> 
				</section>
				<div class="clear"></div>
			</section>
			<section class="num_liulan">
				<p>
					<a href="#">浏览 <c:out value="${go.viewCount}" /></a><a href="#">参加 <c:out value="${go.joinCount}" /></a><a href="#">收藏 <c:out value="${go.favorCount}" /></a>
				</p>
			</section>
		</section>

		<section class="daiqueren">
			<p>待确认</p>
		</section>
		<section class="queren_back" id="WAIT_CONFIRM_LIST">
			
		</section>
		<section class="heiwu"></section>
		<section class="daiqueren">
			<p>已确认</p>
		</section>
		<section class="queren_back" id="BEEN_CONFIRM_LIST">
			
			
		</section>
		<section class="heiwu"></section>
		<section class="daiqueren">
			<p></p>
		</section>
		
	</section>
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script> 
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
<script type="text/javascript">
	(function($) {
		$.GoGroupConfirmPage = function(data) {
			this.settings = $.extend(true, {},
					$.GoGroupConfirmPage.defaults);
			this.params = data ? data : {}
		}
		$.extend($.GoGroupConfirmPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents();
					this.getGroupJoinWaitConfirms();
					this.getGroupJoinBeenConfirms();
				},

				bindEvents : function() {
					var _this = this;
					$("#WAIT_CONFIRM_LIST").delegate("[name='BTN_REJECT']","click",function(){
						var userId =$(this).attr("userId");
						_this.reject(userId);
					});
					$("#WAIT_CONFIRM_LIST").delegate("[name='BTN_PASS']","click",function(){
						var userId =$(this).attr("userId");
						_this.agree(userId);
					});
					
					$("#BEEN_CONFIRM_LIST").delegate("[name='BTN_GOTO_COMMENT']","click",function(){
						var orderId =$(this).attr("goOrderId");
						window.location.href="../go/hainiugroupcomments.html?goOrderId="+orderId;
					});
					
					

				},
				
				reject: function(userId){
					var _this = this;
					var data = {
						goId: _this.getPropertyValue("goId"),
						topic: _this.getPropertyValue("topic"),
						userId: userId
					}
					ajaxController.ajax({
						url: "../go/rejectUserJoinGroup",
						type: "post", 
						data: data,
						success: function(transport){
							weUI.showXToast("已拒绝..");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 500);
							var dom=$("#WAIT_CONFIRM_"+userId);
							dom.fadeOut("200",function(){dom.detach();});
							var len = $("[name='WAIT_CONFIRM_DETL']").length;
							if(len==0){
								var opt="<section class=\"daique_info\" name=\"WAIT_CONFIRM_DETAIL\">没有待确认的信息哦~</section>";
								$("#WAIT_CONFIRM_LIST").append(opt); 
							}
						},
						failure: function(transport){ 
							weUI.showXToast("系统繁忙，稍候重试..");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 500);
						}
					});
				},
				
				agree: function(userId){
					var _this = this;
					var data = {
							goId: _this.getPropertyValue("goId"),
							topic: _this.getPropertyValue("topic"),
							userId: userId
						}
						ajaxController.ajax({
							url: "../go/agreeUserJoinGroup",
							type: "post", 
							data: data,
							success: function(transport){
								var dom=$("#WAIT_CONFIRM_"+userId);
								dom.fadeOut("200",function(){dom.detach();});
								var len = $("[name='WAIT_CONFIRM_DETL']").length;
								if(len==0){
									var opt="<section class=\"daique_info\" name=\"WAIT_CONFIRM_DETAIL\">没有待确认的信息哦~</section>";
									$("#WAIT_CONFIRM_LIST").append(opt); 
								}
								
								var userData=transport.data;
								var opt=$("#BeenConfirmImpl").render(userData?[userData]:[]);
								var len = $("[name='BEEN_CONFIRM_DETL']").length;
								if(len==0){
									$("#BEEN_CONFIRM_LIST").html(opt); 
								}else{
									$("#BEEN_CONFIRM_LIST").append(opt); 
								}
								
								weUI.showXToast("已同意..");
								setTimeout(function () {
									weUI.hideXToast();
					            }, 500);
								
								
							},
							failure: function(transport){ 
								weUI.showXToast("系统繁忙，请稍候再试..");
								setTimeout(function () {
									weUI.hideXToast();
					            }, 500);
							}
						});
					
				},

				getGroupJoinWaitConfirms: function(){
					var _this = this;					
					var data = {
						goId: _this.getPropertyValue("goId")
					}
					ajaxController.ajax({
						url: "../go/getGroupJoinWaitConfirms",
						type: "post", 
						data: data,
						success: function(transport){
							var data = transport.data;
							_this.renderWaitConfirm(data);
						},
						failure: function(transport){ 
							_this.renderWaitConfirm([]);
						}
					});
				},
				
				getGroupJoinBeenConfirms: function(){
					var _this = this;					
					var data = {
						goId: _this.getPropertyValue("goId")
					}
					ajaxController.ajax({
						url: "../go/getGroupJoinBeenConfirms",
						type: "post", 
						data: data,
						success: function(transport){
							var data = transport.data;
							_this.renderBeenConfirm(data);
						},
						failure: function(transport){ 
							_this.renderBeenConfirm([]);
						}
					});
				},
				
				renderWaitConfirm: function(data){
					data= data?data:[];
					var opt="";
					console.log(data);
					if(data.length>0){
						opt=$("#WaitConfirmImpl").render(data);
					}else{
						opt="<section class=\"daique_info\" name=\"WAIT_CONFIRM_DETAIL\">没有待确认的信息哦~</section>"
					}
					
					$("#WAIT_CONFIRM_LIST").html(opt); 
				},
				
				renderBeenConfirm: function(data){
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#BeenConfirmImpl").render(data);
					}else{
						opt="<section class=\"daique_info\" name=\"BEEN_CONFIRM_DETAIL\">没有确认记录哦~</section>"
					}
					
					$("#BEEN_CONFIRM_LIST").html(opt); 
				},

				getPropertyValue : function(propertyName) {
					if (!propertyName)
						return;
					return this.params[propertyName];
				}
			}
		});
	})(jQuery);

	$(document).ready(function() {
		var b = new $.HarborBuilder();
		b.buildFooter({showBeGoQuick: "hide"});
		
		var p = new $.GoGroupConfirmPage({
			goId : "<c:out value="${go.goId}"/>",
			goOrderId: "<c:out value="${goOrderId}"/>",
			topic : "<c:out value="${go.topic}"/>"

		});
		p.init();
	});
</script>

<script id="WaitConfirmImpl" type="text/x-jsrender"> 
		<section class="daique_info" id="WAIT_CONFIRM_{{:userId}}" name="WAIT_CONFIRM_DETL">
				<section class="info_img">
					<span><a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"></a></span>
				</section>
				<section class="ip_text oz">
					<p>
						<span>{{:enName}}</span><label class="lbl2" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</label><i>{{:userStatusName}}</i>
					</p>
					<p> {{:employmentInfo}} </p>
				</section>
				<section class="but_queren">
					<input type="button" value="拒绝" name="BTN_REJECT" userId="{{:userId}}"/><input type="button" value="通过" name="BTN_PASS"
						class="inpbut" userId="{{:userId}}"/>
				</section>
				<div class="clear"></div>
		</section>


</script>

<script id="BeenConfirmImpl" type="text/x-jsrender"> 
<section class="daique_info" name="BEEN_CONFIRM_DETL">
		<section class="info_img">
			<span><a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"></a></span>
		</section>
		<section class="ip_text oz">
			<p>
						<span>{{:enName}}</span><label class="lbl2" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</label><i>{{:userStatusName}}</i>
					</p>
					<p>{{:employmentInfo}}</p>
		</section>
		<section class="but_queren">
			<input type="button" value="互评" name="BTN_GOTO_COMMENT"
						class="inpbut" goOrderId="{{:orderId}}"/>
		</section>
		<div class="clear"></div>
	</section>

</script>

</html>