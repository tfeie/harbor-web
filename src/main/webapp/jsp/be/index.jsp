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
<title>Beauty & Excellence</title>
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

	<section class="banner" id="INDEX_SILDER">
		 
	</section>
	<div class="clear"></div>
	<section class="mainer">

		<section class="title">
			<div class="tit_nav">
				<div class="title_owl" id="DIV_BE_TAGS">
					<div class="item">
						<a href="javascript:void(0)" class="on" tagId="" name="BE_TAG">推荐</a>
					</div>
					<div class="item">
						<a href="javascript:void(0)" tagId="" name="BE_TAG">热点</a>
					</div>
				</div>
			</div>
			<div class="search"></div>
		</section>

		<section class="sec_list">
			<ul id="UL_BES">
				
			</ul>
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
		$.BeIndexPage = function(data){
			this.settings = $.extend(true,{},$.BeIndexPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.BeIndexPage,{
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
					$("#DIV_BE_TAGS").delegate("[name='BE_TAG']","click",function(){
						var tagId = $(this).attr("tagId");
						$("[name='BE_TAG']").removeClass("on");
						$(this).addClass("on");
						_this.queryBes(tagId,"");
					})
					
				},
				
				initData: function(){
					this.getIndexPageSilders();
					this.getBeSystemTags();
					this.queryBes();
				}, 
				
				getIndexPageSilders: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getIndexPageSilders",
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
				
				getBeSystemTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getBeSystemTags",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							_this.allBeTags =  data.allBeTags;
							//设置第一个元素选中
							if(_this.allBeTags.length>0){
								var firstTag = _this.allBeTags[0];
								firstTag.selected=true;
							}
							_this.renderBeTags(); 
						},
						failure: function(transport){ 
							_this.renderBeTags(); 
						}
					});
				},
				
				queryBes: function(beTag,searchKey){
					var _this = this;
					ajaxController.ajax({
						url: "../be/queryBes",
						type: "post",  
						data : {
							beTag: beTag?beTag:"",
							searchKey: searchKey?searchKey:"",
							pageNo : 1,
							pageSize : 100
						},
						success: function(transport){
							var data =transport.data;  
							_this.renderBes(data.result); 
						},
						failure: function(transport){ 
							_this.renderBes(); 
						}
					});
				},
				
				renderBes : function(data) {
					data = data ? data : [];
					var opt = $("#BeListImpl").render(data);
					$("#UL_BES").html(opt);
				},
				
				renderBeTags: function(){
					var allBeTags =this.allBeTags;
					data= {
						allBeTags: allBeTags
					}
					var opt=$("#BeTagsImpl").render(data);
					$("#DIV_BE_TAGS").append(opt); 
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
		
		var p = new $.BeIndexPage({ 
		});
		p.init();	
	});
</script>

<script id="BannerSiderImpl" type="text/x-jsrender"> 
		<section class="item">
			<a href="{{:linkURL}}"><img src="{{:imgURL}}" /></a>
		</section>
</script>

<script id="BeTagsImpl" type="text/x-jsrender"> 
{{for allBeTags}}
<div class="item">
	<a href="javascript:void(0)" name="BE_TAG" tagId="{{:tagId}}" tagName="{{:tagName}}">{{:tagName}}</a>
</div>
{{/for}} 
</script>

<script id="BeListImpl" type="text/x-jsrender"> 
<li>
					<section class="list">
						<div class="member_info">
							<div class="img">
				<a href="javascript:void(0)"><img src="{{:wxHeadimg}}"
					width="80" height="80"></a>
			</div>
							
							<span>{{:enName}}</span> <label class="lbl2">{{:abroadCountryName}}</label> <em>{{:userStatusName}}</em>
						</div>
						<div class="member">
							<div class="div_title">
								{{if hastext==true}}
								<h3>
									<a href="../be/detail.html?beId={{:beId}}">{{:contentSummary}}</a>
								</h3>
								{{/if}}
								<p>
									{{for beTags}} 
                        				#<a href="javascript:void(0)">{{:tagName}}</a>  
									{{/for}}
								</p>
								{{if hasimg==true}} 
								<div class="img">
									<img src="{{:imageURL}}" width="100%">
								</div>
								{{else}}
								<div  width="100%"></div>
								{{/if}}
							</div>
						</div>

						<div class="b_more">
							<span class="span_time">{{:createTimeInterval}}</span> <span class="span_pl"><a class="list btn-pl" href="../be/detail.html?beId={{:beId}}">{{:commentCount}}</a></span>
							<span class="span_bk"><a>{{:giveHaibeiCount}}</a></span> <span class="span_z"><a>{{:dianzanCount}}</a></span>
						</div>

					</section>
				</li>

</script>
</html>