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
<title>G&O首页</title>
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
			<section class="lat_group on" id="DIV_GROUP_GOES">
			</section>
			<section class="lat_group on" id="DIV_ONO_GOES" style="display: none">
			</section>
			<div id="UL_GOTO_NEXTPAGE" style="display:none">
				<p align="center">点击加载下一页</p>
			</div>
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
					var goType = this.getPropertyValue("goType");
					if(goType == "group") {
						var html = "<p><span class=\"on\" goType=\"group\">Group</span><span goType=\"ono\">One on One</span></p>";
						$(".bor_wid").html(html);
					}else{
						var html = "<p><span goType=\"group\">Group</span><span class=\"on\" goType=\"ono\">One on One</span></p>";
						$(".bor_wid").html(html);
					}
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
						_this.lastTagId=_this.currentTagId
						_this.currentTagId=tagId;
						var goType=$(".bor_wid p span.on").attr("goType");
						if(goType=="group"){
							_this.queryGroupGoes(tagId,"");
						}else{
							_this.queryOnOGoes(tagId,"");
						}
					});
					
					//点击活动分类标签
					$(".bor_wid p span").on("click",function(){
						$(this).parents("p").find("span").removeClass("on")
		        	    $(this).addClass("on")
		        	    var goType=$(".bor_wid p span.on").attr("goType");
						var tagId=$("[name='GO_TAG'].on").attr("tagId");
						if(goType=="group"){
							_this.queryGroupGoes(tagId,"");
							$("#DIV_GROUP_GOES").show();
							$("#DIV_ONO_GOES").hide();
						}else{
							_this.queryOnOGoes(tagId,"");
							$("#DIV_GROUP_GOES").hide();
							$("#DIV_ONO_GOES").show();
						}
					});
					
					$(".group_oneon").delegate(".wuwai_jiansheng","click",function(){
						var goId =$(this).attr("goId");
						var goType =$(this).attr("goType");
						if(goType=="group"){
							window.location.href="../go/invite.html?goId="+goId;
						}else{
							window.location.href="../go/onodetail.html?goId="+goId;
						}
						
					});
					
					$("#UL_GOTO_NEXTPAGE").on("click",function(){
						var tagId=$("#DIV_GO_TAGS").find("[name='GO_TAG'].on").attr("tagId");
						tagId=tagId?tagId:"";
						_this.lastTagId=_this.currentTagId
						_this.currentTagId=tagId;
						_this.gotoNextPage(tagId);
					});
					
				},
				
				initData: function(){
					this.getIndexPageSilders();
					this.getGoSystemTags();
					this.lastTagId="";
					this.currentTagId="";
					var goType = '${goType}';
					if(goType == "group") {
						$("#DIV_GROUP_GOES").show();
						$("#DIV_ONO_GOES").hide();
						this.queryGroupGoes();
					} else {
						$("#DIV_GROUP_GOES").hide();
						$("#DIV_ONO_GOES").show();
						this.queryOnOGoes();
					}
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
				
				gotoNextPage: function(){
					var nextPageNo = $("#UL_GOTO_NEXTPAGE").attr("nextPageNo");
					var goType = $("#UL_GOTO_NEXTPAGE").attr("goType");
					var goTag="";
					var searchKey="";
					if(goType=="group"){
						this.queryGroupGoes(goTag,searchKey,nextPageNo);
					}else if(goType=="ono"){
						this.queryOnOGoes(goTag,searchKey,nextPageNo);
					}
				},
				
				getGoSystemTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getGoIndexPageTags",
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
				
				queryGroupGoes: function(goTag,searchKey,pageNo){
					var _this = this;
					ajaxController.ajax({
						url: "../go/queryGoes",
						type: "post",  
						data : {
							goType: "group",
							goTag: goTag?goTag:"",
							searchKey: searchKey?searchKey:"",
							pageNo : pageNo?pageNo:1,
							pageSize : 5
						},
						success: function(transport){
							var data =transport.data;  
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<pageCount){
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo",pageNo+1).attr("goType","group");
							}else{
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo","").attr("goType","group").hide();
							}
							_this.renderGroups(data.result); 
						},
						failure: function(transport){ 
							_this.renderGroups(); 
						}
					});
				},
				
				queryOnOGoes: function(goTag,searchKey,pageNo){
					var _this = this;
					ajaxController.ajax({
						url: "../go/queryGoes",
						type: "post",  
						data : {
							goType: "oneonone",
							goTag: goTag?goTag:"",
							searchKey: searchKey?searchKey:"",
							pageNo : pageNo?pageNo:1,
							pageSize : 5
						},
						success: function(transport){
							var data =transport.data; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<pageCount){
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo",pageNo+1).attr("goType","oneonone");
							}else{
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo","").attr("goType","oneonone").hide();
							}
							_this.renderOneOnOne(data.result); 
						},
						failure: function(transport){ 
							_this.renderOneOnOne(); 
						}
					});
				},
				
				renderGroups : function(data) {
					data = data ? data : [];
					var opt="";
					if(data.length>0){
						 opt = $("#GroupsImpl").render(data);
					}else{
						opt="<section class=\"wuwai_jiansheng\">还没有相关活动信息哦~</section>";
					}
					//alert(this.currentTagId+"/"+this.lastTagId);

					if(this.currentTagId==this.lastTagId){
						$("#DIV_GROUP_GOES").append(opt);
					}else{
						$("#DIV_GROUP_GOES").html(opt);
					}
					
				},
				
				renderOneOnOne : function(data) {
					data = data ? data : [];
					var opt="";
					if(data.length>0){
						 opt = $("#OneOnOnImpl").render(data);
					}else{
						opt="<section class=\"wuwai_jiansheng\">还没有相关活动信息哦~</section>";
					}
					//alert(this.currentTagId+"/"+this.lastTagId);
					if(this.currentTagId==this.lastTagId){
						$("#DIV_ONO_GOES").append(opt);
					}else{
						$("#DIV_ONO_GOES").html(opt);
					}
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
			goType: "<c:out value="${goType}"/>"
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
				<section class="wuwai_jiansheng" goId="{{:goId}}" goType="{{:goType}}">
					<section class="title_jiansheng">
						<p>{{:topic}}</p>
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

<script id="OneOnOnImpl" type="text/x-jsrender"> 
				<section class="wuwai_jiansheng" goId="{{:goId}}" goType="{{:goType}}">
					<section class="title_jiansheng">
						<p>{{:topic}}</p>
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
									<span>{{:enName}}</span><label class="lbl2">{{:abroadCountryName}}</label><i>{{:userStatusName}}</i><em
										class="online"><a href="#">{{:orgModeName}}</a></em>
								</p>
								<p>
									{{:industryName}}/{{:title}}/{{:atCityName}}<em>{{:joinCount}}人见过</em>
								</p>
							</section>
							<div class="clear"></div>
						</section>
						<section class="oneon_text">
							<p><a href="../go/onodetail.html?goId={{:goId}}">{{:contentSummary}}</p>
						</section>
					</section>
					<section class="oneon_span">
						<a href="#">浏览 {{:viewCount}}</a><a href="#">收藏 {{:favorCount}}</a>
						<div class="clear"></div>
					</section>
				</section>
</script>

</html>