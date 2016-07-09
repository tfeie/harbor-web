<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
<title>Group首页</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script> 
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>
<body>

	<header class="header"></header>

	<section class="banner" id="INDEX_SILDER"></section>
	<div class="clear"></div>
	<section class="mainer">
		<section class="choose_go">
			<div class="bor_wid">
				<p>
					<span class="on"><a href="../go/groupindex.html">Group</a></span><span><a
						href="../go/oneononeindex.html">One on One</a></span>
				</p>
			</div>
		</section>
		<section class="title">
			<div class="tit_nav">
				<div class="title_owl" id="DIV_GO_TAGS"></div>
			</div>
			<div class="search">
			</div>
		</section> 

		<section class="group_oneon" >
			<section class="lat_group on" id="DIV_GOES">
			</section>
		</section>
		
		
	</section>
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder.js"></script>
<script type="text/javascript">
	(function($){
		$.GoIndexPage = function(data){
			this.settings = $.extend(true,{},$.GoIndexPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.GoIndexPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this;  
					//点击标签
					$("#DIV_GO_TAGS").delegate("[name='GO_TAG']","click",function(){
						var tagId = $(this).attr("tagId");
						$("[name='GO_TAG']").removeClass("on");
						$(this).addClass("on");
						_this.queryGoes(tagId,"");
					})
					
				},
				
				initData: function(){
					this.getIndexPageSilders();
					this.getGoSystemTags();
					this.queryGoes();
				}, 
				
				getIndexPageSilders: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getIndexPageSilders",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							_this.renderBannerSider(data); 
						},
						failure: function(transport){ 
							_this.renderBannerSider([]); 
						}
					});
				},
				 
				renderBannerSider: function(data){ 
					data= data?data:[];
					var opt=$("#BannerSiderImpl").render(data);
					$("#INDEX_SILDER").html(opt); 
					$(".banner").owlCarousel({
						items : 1
					})
				},
				
				getGoSystemTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getGoSystemTags",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							_this.allGoTags =  data.allGoTags;
							//设置第一个元素选中
							if(_this.allGoTags.length>0){
								var firstTag = _this.allGoTags[0];
								firstTag.selected=true;
							}
							_this.renderGoTags(); 
						},
						failure: function(transport){ 
							_this.renderGoTags(); 
						}
					});
				},
				
				queryGoes: function(goTag,searchKey){
					var _this = this;
					ajaxController.ajax({
						url: "../go/queryGoes",
						type: "post",  
						data : {
							goType: "group",
							goTag: goTag?goTag:"",
							searchKey: searchKey?searchKey:"",
							pageNo : 1,
							pageSize : 10
						},
						success: function(transport){
							var data =transport.data;  
							_this.renderGroups(data.result); 
						},
						failure: function(transport){ 
							_this.renderGroups(); 
						}
					});
				},
				
				renderGroups : function(data) {
					data = data ? data : [];
					var opt = $("#GroupsImpl").render(data);
					$("#DIV_GOES").html(opt);
				},
				
				renderGoTags: function(){
					var allGoTags =this.allGoTags;
					data= {
						allGoTags:allGoTags
					}
					var opt=$("#GoTagsImpl").render(data);
					$("#DIV_GO_TAGS").html(opt); 
					this.owlCarousel();
				},
				
				owlCarousel: function(){
					$(".title_owl").owlCarousel({
						items : 5,
						dots : false
					})
				},
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var b = new $.HarborBuilder();
		b.buildFooter();
		
		var p = new $.GoIndexPage({ 
		});
		p.init();	
	});
</script>

<script id="BannerSiderImpl" type="text/x-jsrender"> 
		<section class="item">
			<a href="{{:linkURL}}"><img src="{{:imgURL}}" /></a>
		</section>
</script>

<script id="GoTagsImpl" type="text/x-jsrender"> 
{{for allGoTags}}
<div class="item">
	<a href="javascript:void(0)" name="GO_TAG" tagId="{{:tagId}}" tagName="{{:tagName}}">{{:tagName}}</a>
</div>
{{/for}} 
</script>

<script id="GroupsImpl" type="text/x-jsrender"> 
		
				<section class="wuwai_jiansheng">
					<section class="title_jiansheng">
						<p><a href="../go/invite.html?goId={{:goId}}">{{:topic}}</a></p>
						<section class="pos_yuan">
							<span></span><span class="on"></span>
							<div class="clear"></div>
						</section>
					</section>
					<section class="info_fuwu">
						<section class="ip_info">
							<section class="info_img">
								<span><a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"></a></span>
							</section>
							<section class="ip_text">
								<p>
									<span>{{:enName}}</span><label class="lbl2">{{:abroadCountryName}}</label><i>{{:userStatusName}}</i>
								</p>
								<p>{{:industryName}}/{{:title}}/{{:atCityName}}</p>
							</section>
							<div class="clear"></div>
						</section>
						<section class="info_time">
							<p>
								<span>{{:expectedStartTime}}</span><a href="#">{{:orgModeName}}</a>
							</p>
						</section>
						<section class="info_time back1">
							<p>
								<span>Group邀请{{:inviteMembers}}人</span><a href="#">{{if payMode=="10"}}{{:fixPriceYuan}}元{{else payMode=="20"}}{{:payModeName}}{{:fixPriceYuan}}元 {{else payMode=="30"}} {{:payModeName}} {{/if}}</a>
							</p>
						</section>
						<section class="info_time back2">
							<p>
								<span>{{:location}}</span>
							</p>
						</section>
						<section class="info_fangf">
							<p><a href="../go/invite.html?goId={{:goId}}">{{:contentSummary}}</a></p>
						</section>
						<div class="clear"></div>
					</section>
					<section class="num_per">
						<p>
							<a href="#">浏览 {{:viewCount}}</a><a href="#">参加 {{:joinCount}}</a><a href="#">收藏 {{:favorCount}}</a>
						</p>
					</section>
				</section>
</script>

</html>