<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta content="telephone=no" name="format-detection" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="#035c9b">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="dns-prefetch" href="//static.tfeie.com" />
<title>B&E动态详情</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script src="//static.tfeie.com/v2/js/swiper.min.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style>
#shareit {
	-webkit-user-select: none;
	display: none;
	position: absolute;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.85);
	text-align: center;
	top: 0;
	left: 0;
	z-index: 105;
}

#shareit img {
	max-width: 100%;
}

.arrow {
	position: absolute;
	right: 10%;
	top: 5%;
}

#share-text {
	margin-top: 400px;
}
</style>
</head>

<body class="bg-eeeeee">
	<section class="be_main">
		<div class="tx_top box-s">
			<div class="btn-right">
				<span class="btn-gz" id="SPAN_ADD_FANS" userId="<c:out value="${userInfo.userId}"/>">+关注</span> <span class="btn-pl"></span>
			</div>
			<div class="c">
				<div class="img">
					<img src="<c:out value="${userInfo.wxHeadimg}"/>" width="40"
						height="40" class="br-100">
				</div>
				<div class="name">
					<div class="name-xx">
						<div class="xx chaochu_1"><c:out value="${userInfo.enName}"/></div>
						<div class="yrz">
							<span class="bg-lan"><c:out value="${userInfo.abroadCountryName}"/></span><font><c:out value="${userInfo.userStatusName}"/></font>
						</div>
					</div>
					<div class="jj"><c:out value="${userInfo.industryName}"/>/<c:out value="${userInfo.title}"/>/<c:out value="${userInfo.atCityName}"/></div>
				</div>
			</div>
		</div>

		<div class="con  box-s mar-top-10 pad-10" id="DIV_BE_DETAIL">
			
		</div>


		<div class="like-main  box-s mar-top-10 pad-10">
			<div class="list" id="DIV_REWARD_USERS">
				
			</div>
			<div class="c">
				<div class="f-left">认为值得赏</div>
				<div class="num btn-like" id="DIV_REWARD_COUNT">0</div>
			</div>

		</div>


		<div class="pl-main box-s mar-top-10 pad-10" id="DIV_BE_COMMENTS">

		</div>


	</section>

	<footer class="be_footer po-f">
		<div class="c">
			<input type="button" class="In-btn" value="发射" id="BTN_SEND">
			<div class="left">
				<input type="text" class="In-text" id="COMMENT_CONTENT" placeholder="朕以为...">
				<input type="hidden" id="parentCommentId"/>
				<input type="hidden" id="parentUserId"/>
			</div>
		</div>
	</footer>
	
	<div id="shareit">
	  <a href="#" id="follow">
	     <img class="arrow" src="//static.tfeie.com/images/share.jpg">
	  </a>
	</div>
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
//微信API配置
wx.config({
	debug : false,
	appId : '<c:out value="${appId}"/>',
	timestamp : <c:out value="${timestamp}"/>,
	nonceStr : '<c:out value="${nonceStr}"/>',
	signature : '<c:out value="${signature}"/>',
	jsApiList : [ 'checkJsApi', 'onMenuShareTimeline','onMenuShareAppMessage']
});

	(function($){
		$.BeDetailPage = function(data){
			this.settings = $.extend(true,{},$.BeDetailPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.BeDetailPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this; 
					
					$("#DIV_BE_DETAIL").delegate("#DIV_DO_SHARE","click",function(){
						alert(1);
						wx.onMenuShareTimeline({
						    title: _this.getPropertyValue("topic"),
						    link:  _this.getPropertyValue("url"), 
						    //imgUrl: _this.getPropertyValue("shareImg"), 
						    success: function () {  
						    	weUI.alert({content:"分享成功",ok: function(){
						    		weUI.closeAlert();
						    	}});
						    },
						    cancel: function () {  
						    	$("#shareit").hide(); 
						    }
						});	
						wx.onMenuShareAppMessage({
						    title: _this.getPropertyValue("topic"),
						    link:  _this.getPropertyValue("url"), 
						    //imgUrl: _this.getPropertyValue("shareImg"), 
						    success: function () {  
						    	weUI.alert({content:"分享成功",ok: function(){
						    		$("#shareit").hide(); 
						    		weUI.closeAlert();
						    	}});
						    },
						    cancel: function () {  
						    	$("#shareit").hide(); 
						    }
						});	
						
						$("#shareit").show();
					});
					
					$("#shareit").on("click", function(){
					    $("#shareit").hide(); 
					 })
					 
					
					//添加图片按钮事件
					$("#BTN_SEND").on("click",function(){
						 _this.sendBeComment();
					}); 
					
					//添加关注按钮事件 
					$("#SPAN_ADD_FANS").on("click",function(){
						var userId = $(this).attr("userId");
						 _this.addGuanzhu(userId,this);
					});  
					//点赞事件代理
					$("#DIV_BE_DETAIL").delegate("#DIV_DO_DIANZAN","click",function(){
						_this.doDianzan();
					});
					
					//打赏按钮 
					$("#DIV_REWARD_COUNT").on("click",function(){
						_this.rewardBe(1);
					}); 
					
					$("#DIV_BE_COMMENTS").delegate("[name='DIV_COMMENT_CONTENT']","click",function(){
						var userId = $(this).attr("userId");
						var commentId = $(this).attr("commentId");
						var enName = $(this).attr("enName");
						$("#parentCommentId").val(commentId);
						$("#parentUserId").val(userId);
						$("#COMMENT_CONTENT").attr("placeholder","回复 "+enName+":").focus
					}); 
				},
				
				initData: function(){
					this.getBeDetail();
					this.getRewardUsers();
					this.getBeComments();
				}, 
				
				rewardBe: function(count){
					var _this=this;
					var beId =_this.getPropertyValue("beId");
					ajaxController.ajax({
						url: "../be/giveHaibei",
						type: "post", 
						data: {
							beId: beId,
							count: count
						},
						success: function(transport){ 
							var count = transport.data;
							_this.getRewardUsers(count); 
						},
						failure: function(transport){ 
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先注册后再打赏~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else if(busiCode=="haibei_not_enough"){
								weUI.confirm({content:"您的海贝余额不足啦，是否先进行充值后再打赏~",ok: function(){
									window.location.href="../user/buyhaibei.html";
								}});
							}else if(busiCode=="user_unauthoried"){
								weUI.confirm({content:"您还没有经过认证，暂时不能打赏，是否去认证~",ok: function(){
									window.location.href="../user/toApplyCertficate.html";
								}});
							}else{
								weUI.alert({content:statusInfo});
							}
						}
					});
				},
				
				sendBeComment: function(){
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
						beId: _this.getPropertyValue("beId"),
						content: content,
						parentCommentId: parentCommentId,
						parentUserId: parentUserId
					}
					ajaxController.ajax({
						url: "../be/sendBeComment",
						type: "post", 
						data: data,
						success: function(transport){
							var data = transport.data;
							var arr = [data];
							var opt=$("#BeCommentsImpl").render(arr);
							$("#DIV_BE_COMMENTS").append(opt); 
							$("#COMMENT_CONTENT").val("");
							$("#parentUserId").val("");
							$("#parentCommentId").val("");
						},
						failure: function(transport){
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先注册后再发表评论~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else if(busiCode=="user_unauthoried"){
								weUI.confirm({content:"您还没有经过认证，暂时不能评论，是否去认证~",ok: function(){
									window.location.href="../user/toApplyCertficate.html";
								}});
							}else{
								weUI.alert({content:statusInfo});
							}
							
						}
					});
				},
				
				doDianzan: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/dianzan",
						type: "post", 
						data: { 
							beId: _this.getPropertyValue("beId")
						},
						success: function(transport){
							var count = transport.data;
							$("#DIV_DO_DIANZAN").html("<font>"+count+"</font>");
						},
						failure: function(transport){ 
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先注册后再点赞~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else{
								weUI.alert({content:statusInfo});
							}
							
						}
					});
				},
				
				cancelDianzan: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/cancelDianzn",
						type: "post", 
						data: { 
							beId: _this.getPropertyValue("beId")
						},
						success: function(transport){
							var count = transport.data;
							$("#DIV_DO_DIANZAN").html("<font>"+count+"</font>");
						},
						failure: function(transport){ 
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先去注册~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else{
								weUI.alert({content:statusInfo});
							}
						}
					});
				},
				
				addGuanzhu: function(userId,_t){
					var _this = this;
					ajaxController.ajax({
						url: "../user/addGuanzhu",
						type: "post", 
						data: { 
							userId: userId
						},
						success: function(transport){
							$(_t).html("已关注").off("click");
						},
						failure: function(transport){ 
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先注册后再关注~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else{
								weUI.alert({content:statusInfo});
							}
						}
					});
				},
				
				getBeDetail: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getOneBe",
						type: "post", 
						data: { 
							beId: _this.getPropertyValue("beId")
						},
						success: function(transport){
							var data =transport.data; 
							_this.renderBeDetail(data); 
						},
						failure: function(transport){ 
							_this.renderBeDetail({}); 
						}
					});
				},
				
				
				renderBeDetail: function(data){ 
					data= data?data:{};
					var opt=$("#BeDetailImpl").render(data);
					$("#DIV_BE_DETAIL").html(opt); 
				},
				
				getRewardUsers: function(count){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getRewardUsers",
						type: "post", 
						data: { 
							beId: _this.getPropertyValue("beId")
						},
						success: function(transport){
							var data =transport.data; 
							_this.renderBeRewardUsers(data); 
							$("#DIV_REWARD_COUNT").html(count);
						},
						failure: function(transport){ 
							_this.renderBeRewardUsers([]); 
						}
					});
				},
				
				getBeComments: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getBeComments",
						type: "post", 
						data: { 
							beId: _this.getPropertyValue("beId")
						},
						success: function(transport){
							var data =transport.data; 
							_this.renderBeComments(data); 
						},
						failure: function(transport){ 
							_this.renderBeComments([]); 
						}
					});
				},
				 
				renderBeRewardUsers: function(data){ 
					data= data?data:[];
					var opt=$("#BeRewardUsersImpl").render(data);
					$("#DIV_REWARD_USERS").html(opt); 
				},
				
				renderBeComments: function(data){
					data= data?data:[];
					var opt=$("#BeCommentsImpl").render(data);
					$("#DIV_BE_COMMENTS").html(opt); 
				},
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){ 
		var p = new $.BeDetailPage({
			beId: "<c:out value="${beId}"/>",
			topic: "<c:out value="${topic}"/>",
			url: "<c:out value="${url}"/>"
		});
		p.init();
		
	});
</script>


<script id="BeDetailImpl" type="text/x-jsrender"> 
			<div class="time">{{:createDate}}</div>
			<div class="m">
			{{for beDetails ~beTags=beTags}} 	
				{{if type=="text"}}
					<p> {{:detail}} </p>
				{{/if}}
				{{if type=="image"}}
					<img src="{{:imageUrl}}" width="100%">
				{{/if}}
				{{if #index==0}}
					<div class="bq clearfix">
					{{for ~beTags}} 	
					<a href="javascript:void(0)"># {{:tagName}}</a>
					{{/for}} 	
					</div>
				{{/if}}
			{{/for}} 
			</div>
			<div class="btn-bottom">
				<div class="btn-fx box-s" id="DIV_DO_SHARE"></div>
				<div class="btn-z  box-s" id="DIV_DO_DIANZAN" beId = "{{:beId}}">
					<font>{{:dianzanCount}}</font>
				</div>
			</div> 
</script>

<script id="BeRewardUsersImpl" type="text/x-jsrender"> 
<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"  alt="{{:enName}}" width="30" height="30"></a> 
</script>

<script id="BeCommentsImpl" type="text/x-jsrender"> 
			<div class="itms clearfix" commentId="{{:commentId}}">
				<div class="img">
					<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}" width="40"
						height="40"></a>
				</div>
				<div class="c">
					<div class="name-xx">
						<div class="icon-pl" name="DIV_COMMENT_CONTENT" commentId="{{:commentId}}" userId="{{:userId}}" enName="{{:enName}}"></div>
						<div class="name">
							<div class="xx">{{:enName}}</div>
							<div class="yrz">
								<span class="bg-lv">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font>
							</div>
							<div class="time">{{:createTimeInteval}}</div>
						</div>
					</div>
					<div class="pl" name="DIV_COMMENT_CONTENT" commentId="{{:commentId}}" userId="{{:userId}}" enName="{{:enName}}">{{if penName}} 回复<span href="javascript:void(0)" class="lc" style="color:red">{{:penName}}</span>  {{/if}} {{:content}}</div>
				</div>
			</div>	
</script>

</html>