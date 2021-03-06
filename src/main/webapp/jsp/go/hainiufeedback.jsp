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
<title>海牛评价</title>
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
	<section class="haiuliu-top pingjia">
		<p class="bgcolor">
			<label></label>
		</p>
		<div class="clear"></div>
		<p class="back">
			<i><a></a></i><i><a></a></i><i><a></a></i><i><a></a></i><i><a
				class="on"></a></i>
		</p>
		<p>
			<span>预约</span><span>支付费用</span><span>海牛确认</span><span>约见</span><span
				class="on">评价</span>
		</p>
	</section>
	<section class="mainer on">
		<section class="group_pingjia">
			<p><c:out value="${goOrder.topic}" escapeXml="false" /></p>
		</section>
		<section class="ip_info group">
			<section class="info_img">
				<span><img src="<c:out value="${userInfo.wxHeadimg}" escapeXml="false" />" /></span>
			</section>
			<section class="ip_text2 frt">
				<span><c:out value="${goOrder.orgModeName}" escapeXml="false" /></span> <label><c:out value="${goOrder.orderCount}" escapeXml="false" />人见过</label>
			</section>
			<section class="ip_text">
				<p>
					<span><c:out value="${userInfo.enName}" escapeXml="false" /></span><label class="lbl2" style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}" escapeXml="false" /></label><i><font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>><c:out value="${userInfo.userStatusName}" escapeXml="false" /></font></i>
				</p>
				<p>
						<c:out value="${userInfo.employmentInfo}" escapeXml="false" />
				</p>
			</section>

			<div class="clear"></div>
		</section>
		<section class="good_friend">
			<section class="friend_num">
				<p>
					<span><img src="//static.tfeie.com/images/img35.png" /></span><label><c:out value="${go.helpCount}" /></label>
				</p>
				<p>
					<span>助人统计</span>
				</p>
			</section>
			<section class="yes_no">
				<p>TA说您对他有帮助吗？</p>
				<p>
					<c:out value="${goOrder.helpValueName}" escapeXml="false" />
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="good_friend">
			<section class="friend_num">
				<p>
					<span><img src="//static.tfeie.com/images/img36.png" /></span>
				</p>
				<p>
					<span>TA赏给您的海贝</span>
				</p>
			</section>
			<section class="yes_no num">
				<p>
					<c:out value="${goOrder.giveHb}" escapeXml="false" />个
				</p>
			</section>
			<div class="clear"></div>
		</section>

		<section class="group_pinglun">
			<p>评论</p>
		</section>
		<section class="pinglun_textarea">
			<p>
				<textarea placeholder="评，具体帮助…" id="COMMENT_CONTENT"></textarea>
				<input type="hidden" id="parentCommentId"/>
				<input type="hidden" id="parentUserId"/>
			</p>
			<p>
				<input type="button" value="发射" id="BTN_SEND"/>
			</p>
		</section>
		<section class="liulan">
			<section class="look_pinglun">
				<p>评论浏览</p>
			</section>
			<section class="duihua" id="DIV_COMMENTS">
				
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
		$.GoHainiuFeedBackPage = function(data) {
			this.settings = $.extend(true, {},
					$.GoHainiuFeedBackPage.defaults);
			this.params = data ? data : {}
		}
		$.extend($.GoHainiuFeedBackPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents();
					this.getComments();
				},

				bindEvents : function() {
					var _this = this;
					$("#BTN_SEND").on("click", function() {
						_this.sendComment();
					});
					
					$(".yuejian-bott").delegate("[name='P_CONFIRM']","click",function(){
						$("[name='P_CONFIRM']").removeClass("on");
						$(this).addClass("on");
					});
					
					$("#DIV_COMMENTS").delegate("[name='DIV_COMMENT_CONTENT']","click",function(){
						var userId = $(this).attr("userId");
						var commentId = $(this).attr("commentId");
						var enName = $(this).attr("enName");
						$("#parentCommentId").val(commentId);
						$("#parentUserId").val(userId);
						$("#COMMENT_CONTENT").attr("placeholder","回复 "+enName+":").focus
					});

				},
				
				getComments: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getGoOrderComments",
						type: "post", 
						data: { 
							orderId: _this.getPropertyValue("goOrderId")
						},
						success: function(transport){
							var data =transport.data; 
							//alert(JSON.stringify(data));
							_this.renderComments(data); 
						},
						failure: function(transport){ 
							_this.renderComments([]); 
						}
					});
				},

				sendComment: function(){
					var _this = this;
					var content = $.trim($("#COMMENT_CONTENT").val());
					var parentCommentId =  $.trim($("#parentCommentId").val());
					var parentUserId =  $.trim($("#parentUserId").val());
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "评论内容",
						fieldName: "content",
						getValue: function(){
							return content;
						},
						fieldRules: {
							required: true, 
							cnlength: 200
						},
						ruleMessages: {
							required: "请填写评论",
							cnlength:"评论不能超过100个汉字"
						}
					});
					var res=valueValidator.fireRulesAndReturnFirstError();
					if(res){
						weUI.alert({content:res});
						return;
					}
					
					var data = {
						goId: _this.getPropertyValue("goId"),
						orderId: _this.getPropertyValue("goOrderId"),
						content: content,
						parentCommentId: parentCommentId,
						parentUserId: parentUserId
					}
					ajaxController.ajax({
						url: "../go/sendGoComment",
						type: "post", 
						data: data,
						success: function(transport){
							var data = transport.data;
							var arr = [data];
							var opt=$("#CommentsImpl").render(arr);
							if($("[name='SEL_NONE_COMMENTS']").length>0){
								$("#DIV_COMMENTS").html(opt); 
							}else{
								$("#DIV_COMMENTS").append(opt); 
							}
							
							$("#COMMENT_CONTENT").val("");
							$("#parentUserId").val("");
							$("#parentCommentId").val("");
							weUI.showXToast("评论成功..");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						},
						failure: function(transport){ 
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
					});
				},
				
				renderComments: function(data){
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#CommentsImpl").render(data);
					}else{
						opt="<section class=\"duihua_1\" name=\"SEL_NONE_COMMENTS\">没有任何评论哦~</section>"
					}
					
					$("#DIV_COMMENTS").html(opt); 
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
		var p = new $.GoHainiuFeedBackPage({
			goId : "<c:out value="${goOrder.goId}"/>",
			goOrderId : "<c:out value="${goOrder.orderId}"/>"

		});
		p.init();
	});
</script>

<script id="CommentsImpl" type="text/x-jsrender"> 
				{{if isreply==false}}
				<section class="duihua_1">
					<section class="left_img">
						<span> </span>
					</section>
					<section class="duihua_text">
						<p name="DIV_COMMENT_CONTENT" commentId="{{:commentId}}" userId="{{:publishUserId}}" enName="{{:enName}}">{{:content}}</p>
						<p class="time">{{:createTimeInteval}}</p>
						<section class="zhixiang">
							<img src="//static.tfeie.com/images/img42.png" />
						</section>
					</section>
					<section class="right_img">
						<span><a href="../user/userInfo.html?userId={{:publishUserId}}"><img src="{{:wxHeadimg}}" /></a></span>
					</section>
				</section>
				{{else}}
				<section class="duihua_1">
					<section class="left_img">
						<span><a href="../user/userInfo.html?userId={{:publishUserId}}"><img src="{{:wxHeadimg}}" /></a></span>
					</section>
					<section class="duihua_text left">
						<p>{{if penName}} 回复<span href="javascript:void(0)" class="lc" style="color:red">{{:penName}}</span>  {{/if}} {{:content}}</p>
						<p class="time">{{:createTimeInteval}}</p>
						<section class="zhixiang left">
							<img src="//static.tfeie.com/images/img42_1.png" />
						</section>
					</section>
					<section class="right_img">
						<span> </span>
					</section>
				</section>
				<div class="clear"></div>
				{{/if}}
</script>
</html>