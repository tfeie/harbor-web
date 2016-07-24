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
<title>我创建的One On One活动详情</title>
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
	<section class="ip2_zhongxin on">
		<section class="ip2_top">
			<p>
				<img src="<c:out value="${go.homePageBg}"/>" id="dm_homePageBg">
			</p>
			<section class="ip_logo ip2">
				<p>
					<span><img src="<c:out value="${go.wxHeadimg}"/>" id="dm_wxHeadimg"/></span>
				</p>
			</section>
		</section>

		<section class="ip_name ip2">
			<p>
				<span><c:out value="${go.enName}"/></span><label class="lbl2" style="background:<c:out value="${go.abroadCountryRGB}" />"><c:out value="${go.abroadCountryName}"/></label><c:out value="${go.userStatusName}"/>
			</p>
		</section>
		<section class="ip_shengf ip3">
			<p>
				<span><c:out value="${go.industryName}"/>/<c:out value="${go.title}"/>/<c:out value="${go.atCityName}"/></span><span class="span2"><c:out value="${go.orgModeName}"/></span>
			</p>
		</section>


		<section class="sec_info_list">
			<section class="item">
				<div class="title">
					<span><c:out value="${go.topic}"/></span>
				</div>
				
				
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
				
				<div class="div_bottom">
					<span><a href="#" class="money"><c:out value="${go.fixPriceYuan}"/>元</a></span> <span><a
						href="#"><c:out value="${go.expectedDuration}"/></a></span> <span><a href="#">见过 126</a></span> <span><a
						href="#">分享</a></span>
					<div class="clear"></div>
				</div>
			</section>
			<section class="item">
				<div class="title">
					<span>海牛的故事</span>
				</div>
				<article>
					<p><c:out value="${go.myStory}"/></p>
				</article>
			</section>
			<section class="item">
				<div class="div_bottom2">
					<span><a href="#">付费预约</a></span> <span><a href="#">一对一分享</a></span>
					<span><a href="#">不满意可退</a></span>
					<div class="clear"></div>
				</div>
			</section>
			
			<section class="item">
				<div class="title title2">
					<span>预约此活动的人</span>
				</div>
				<section class="sec_pj" id="UL_ORDER_USERS">
						

				</section>
			</section>
		
			<section class="item">
				<div class="title title2">
					<span>评价</span>
				</div>
				<section class="sec_pj">
					<ul id="UL_ONO_COMMETS">
						
					</ul>
				</section>
			</section>
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
<script type="text/javascript">
	(function($) {
		$.OnOGoDetailPage = function(data) {
			this.settings = $.extend(true, {}, $.OnOGoDetailPage.defaults);
			this.params = data ? data : {}
		}
		$.extend($.OnOGoDetailPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents();
					this.getGoComments();
					this.getMyOnoOrderRecords();
				},

				bindEvents : function() {
					var _this = this;
					//预约
					$("#BTN_GO_APPLY").on("click", function() {
						_this.checkGoOrder();
					});
					
					$("#BTN_GO_FAVOR").on("click", function() {
						_this.doFavor();
					});
					
					$("#UL_ORDER_USERS").delegate("[name='BTN_NEXT']","click",function(){
						var orderId =$(this).attr("orderId");
						var orderStatus =$(this).attr("orderStatus");
						if(orderStatus=="20"){
							//待海牛确认
							window.location.href="../go/toHainiuConfirm.html?goOrderId="+orderId;
						}else if(orderStatus=="30"){
							//待约见，设置约见地点
							window.location.href="../go/toHainiuAppointment.html?goOrderId="+orderId;
						}else if(orderStatus=="40"){
							//活动结束，评论
							window.location.href="../go/toHainiuFeedback.html?goOrderId="+orderId;
						}
					});
					
					
				},

				getPropertyValue : function(propertyName) {
					if (!propertyName)
						return;
					return this.params[propertyName];
				},
				
				doFavor: function(){
					var _this = this;
					var goId=_this.getPropertyValue("goId");
					ajaxController.ajax({
						url : "../go/doInterest",
						type : "post",
						data : {
							goId : goId
						},
						success : function(transport) {
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先注册~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else{
								weUI.alert({content:"收藏成功"});
							}
						},
						failure : function(transport) {
							weUI.alert({content:transport.statusInfo });
						}

					});
				},
				
				checkGoOrder : function() {
					var _this = this;
					var goId=_this.getPropertyValue("goId");
					ajaxController.ajax({
						url : "../go/checkGoOrder",
						type : "post",
						data : {
							goId : goId
						},
						success : function(transport) {
							window.location.href="../go/toOrder.html?goId="+goId;
						},
						failure : function(transport) {
							weUI.alert({content:transport.statusInfo });
						}

					});
				},
				
				getMyOnoOrderRecords: function(){
					var _this = this;					
					var data = {
						goId: _this.getPropertyValue("goId")
					}
					ajaxController.ajax({
						url: "../go/getMyOnoOrderRecords",
						type: "post", 
						data: data,
						success: function(transport){
							var data = transport.data;
							_this.renderOrderUsers(data);
						},
						failure: function(transport){ 
							_this.renderOrderUsers([]);
						}
					});
				},
				
				renderOrderUsers: function(data){
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#OrderUsersImpl").render(data);
					}else{
						opt="<section class=\"daique_info\" name=\"WAIT_CONFIRM_DETAIL\">没有人预约此活动~</section>"
					}
					
					$("#UL_ORDER_USERS").html(opt); 
				},

				getGoComments : function() {
					var _this = this;
					ajaxController.ajax({
						url : "../go/getGoComments",
						type : "post",
						data : {
							goId : _this.getPropertyValue("goId")
						},
						success : function(transport) {
							var data = transport.data;
							_this.renderGoComments(data);
						},
						failure : function(transport) {
							_this.renderGoComments([]);
						}

					});
				},
				renderGoComments: function(data){
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#OnOCommentsImpl").render(data);
					}else{
						opt="<li>还没有任何评论~~</li>";
					} 
					$("#UL_ONO_COMMETS").html(opt); 
				}
			}
		});
	})(jQuery);

	$(document).ready(function() {
		var p = new $.OnOGoDetailPage({
			goId : "<c:out value="${go.goId}"/>"
		});
		p.init();
	});
</script>

<script id="OnOCommentsImpl" type="text/x-jsrender"> 
<li>
							<div class="img">
								<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"></a>
							</div>
							<div class="text">
								<h2>
									{{:enName}}<label class="lbl2" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</label><i>{{:userStatusName}}</i><span class="frt">{{:createTimeInteval}}
									</span>
								</h2>
								<p>{{:content}}</p>
							</div>
						</li>
</script>

<script id="OrderUsersImpl" type="text/x-jsrender"> 
		<section class="daique_info" id="WAIT_CONFIRM_{{:userId}}" name="WAIT_CONFIRM_DETL">
				<section class="info_img">
					<span><a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"></a></span>
				</section>
				<section class="ip_text oz">
					<p>
						<span>{{:enName}}</span><label class="lbl2" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</label><i>{{:userStatusName}}</i>
					</p>
					<p>{{:industryName}}/{{:title}}/{{:atCityName}}</p>
				</section>
				<section class="but_queren">
					{{:orderStatusName}} <input type="button" value="下一步" name="BTN_NEXT"
						class="inpbut" orderId="{{:orderId}}" orderStatus="{{:orderStatus}}"/>
				</section>
				<div class="clear"></div>
		</section>


</script>

</html>