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

</head>

<body class="bg-eeeeee">
	<section class="be_main">
		<div class="tx_top box-s">
			<div class="btn-right">
				<span class="btn-gz">+关注</span> <span class="btn-pl"></span>
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
			<div class="list" id="DIV_DIANZAN_USERS">
				
			</div>
			<div class="c">
				<div class="f-left">认为值得赞</div>
				<div class="num btn-like">12</div>
			</div>

		</div>


		<div class="pl-main box-s mar-top-10 pad-10">
			<div class="itms clearfix">
				<div class="img">
					<img src="//static.tfeie.com/v2/images/tx.png" width="40"
						height="40">
				</div>
				<div class="c">
					<div class="name-xx">
						<div class="icon-pl"></div>
						<div class="name">
							<div class="xx">Mays</div>
							<div class="yrz">
								<span class="bg-lan">香港</span><font>已认证</font>
							</div>
							<div class="time">10分钟前</div>
						</div>
					</div>
					<div class="pl">给老婆买的，质量好，性价比高。很喜欢，以后买给老婆买的，质量好，性价比高。很喜欢，以后买</div>
				</div>
			</div>
			<div class="itms clearfix">
				<div class="img">
					<img src="//static.tfeie.com/v2/images/tx.png" width="40"
						height="40">
				</div>
				<div class="c">
					<div class="name-xx">
						<div class="icon-pl"></div>
						<div class="name">
							<div class="xx">Mays</div>
							<div class="yrz">
								<span class="bg-lv">美国</span><font>已认证</font>
							</div>
							<div class="time">10分钟前</div>
						</div>
					</div>
					<div class="pl">给老婆买的，质量好，性价比高。很喜欢，以后买给老婆买的，质量好，性价比高。很喜欢，以后买</div>

					<div class="pl-more">
						<div class="pl-img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="30"
								height="30">
						</div>
						<div class="pl-c">
							<span href="#" class="lc">三楼</span>觉得<span href="#" class="lc">一楼</span>说的对
						</div>
					</div>
					<div class="pl-more">
						<div class="pl-img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="30"
								height="30">
						</div>
						<div class="pl-c">
							<span href="#" class="lc">三楼</span>觉得<span href="#" class="lc">一楼</span>说的对
						</div>
					</div>
				</div>
			</div>
			<div class="itms clearfix">
				<div class="img">
					<img src="//static.tfeie.com/v2/images/tx.png" width="40"
						height="40">
				</div>
				<div class="c">
					<div class="name-xx">
						<div class="icon-pl"></div>
						<div class="name">
							<div class="xx">Mays</div>
							<div class="yrz">
								<span class="bg-lv">美国</span><font>已认证</font>
							</div>
							<div class="time">10分钟前</div>
						</div>
					</div>
					<div class="pl">给老婆买的，质量好，性价比高。很喜欢，以后买给老婆买的，质量好，性价比高。很喜欢，以后买</div>

					<div class="pl-more">
						<div class="pl-img">
							<img src="//static.tfeie.com/v2/images/tx.png" width="30"
								height="30">
						</div>
						<div class="pl-c">
							<span href="#" class="lc">三楼</span>觉得<span href="#" class="lc">一楼</span>说的对说的对说的对说的对说的对说的对说的对说的对
						</div>
					</div>
				</div>
			</div>

		</div>


	</section>

	<footer class="be_footer po-f">
		<div class="c">
			<input type="button" class="In-btn" value="发射">
			<div class="left">
				<input type="text" class="In-text" id="In-pl" placeholder="朕以为...">
			</div>
		</div>
	</footer>
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
					
					//添加图片按钮事件
					$("#SPAN_ADD_IMAGE").on("click",function(){
						 
					}); 
					
					//点赞事件代理
					$("#DIV_BE_DETAIL").delegate("#DIV_DO_DIANZAN","click",function(){
						_this.doDianzan();
					});
					
				},
				
				initData: function(){
					this.getBeDetail();
					this.getBeDianzanUsers();
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
							_this.getBeDianzanUsers(); 
						},
						failure: function(transport){ 
							
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
							_this.getBeDianzanUsers(); 
						},
						failure: function(transport){ 
							
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
				
				getBeDianzanUsers: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getDianzanUsers",
						type: "post", 
						data: { 
							beId: _this.getPropertyValue("beId")
						},
						success: function(transport){
							var data =transport.data; 
							_this.renderBeDianzanUsers(data); 
						},
						failure: function(transport){ 
							_this.renderBeDianzanUsers([]); 
						}
					});
				},
				 
				renderBeDianzanUsers: function(data){ 
					data= data?data:[];
					var opt=$("#BeDianZanUsersImpl").render(data);
					$("#DIV_DIANZAN_USERS").html(opt); 
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
			beId: "<c:out value="${beId}"/>"
		});
		p.init();
		
	});
</script>


<script id="BeDetailImpl" type="text/x-jsrender"> 
			<div class="time">{{:createDate}}</div>
			{{for beDetails ~beTags=beTags}} 	
				{{if type=="text"}}
					<div class="c">
						{{:detail}}
					</div>
				{{/if}}
				{{if type=="image"}}
					<div class="img">
						<img src="{{:imageUrl}}" width="100%">
					</div>
				{{/if}}
				{{if #index==0}}
					<div class="bq clearfix">
					{{for ~beTags}} 	
					<a href="javascript:void(0)"># {{:tagName}}</a>
					{{/for}} 	
					</div>
				{{/if}}
			{{/for}} 

			<div class="btn-bottom">
				<div class="btn-fx box-s"></div>
				<div class="btn-z  box-s" id="DIV_DO_DIANZAN" beId = "{{:beId}}">
					<font>{{:dianzan}}</font>
				</div>
			</div> 
</script>

<script id="BeDianZanUsersImpl" type="text/x-jsrender"> 
<a href="javascript:void(0)"><img src="{{:wxHeadimg}}"  alt="{{:enName}}" width="30" height="30"></a> 
</script>

</html>