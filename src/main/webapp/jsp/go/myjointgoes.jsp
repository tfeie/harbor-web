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
<title>我参加的Group & One On One</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
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
				<p><span goType="group" <c:if test="${goType=='group' }">class="on"</c:if>>Group</span><span  <c:if test="${goType=='ono' }">class="on"</c:if> goType="ono">One on One</span></p>
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
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
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
					//点击活动分类标签
					$(".bor_wid p span").on("click",function(){
						$(this).parents("p").find("span").removeClass("on")
		        	    $(this).addClass("on")
		        	    var goType=$(".bor_wid p span.on").attr("goType");
						if(goType=="group"){
							_this.queryGroupGoes({searchKey:"",pageNo:1,newload:true});
							$("#DIV_GROUP_GOES").show();
							$("#DIV_ONO_GOES").hide();
						}else{
							_this.queryOnOGoes({searchKey:"",pageNo:1,newload:true});
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
						_this.gotoNextPage();
					});
					
					$(window).scroll(function() {
						var scrollTop = $(document).scrollTop();//获取垂直滚动的距离
			            var docheight = $(document).height();
			            var winheight = $(window).height();

			            if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
			            	_this.gotoNextPage();
			            }

					})
					
				},
				
				initData: function(){
					this.getIndexPageSilders();
					var goType = this.getPropertyValue("goType");
					if(goType == "group") {
						$("#DIV_GROUP_GOES").show();
						$("#DIV_ONO_GOES").hide();
						this.queryGroupGoes({searchKey:"",pageNo:1,newload:true});
					} else {
						$("#DIV_GROUP_GOES").hide();
						$("#DIV_ONO_GOES").show();
						this.queryOnOGoes({searchKey:"",pageNo:1,newload:true});
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
					var pageCount=$("#UL_GOTO_NEXTPAGE").attr("pageCount");

					var searchKey="";
					if(goType=="group" && nextPageNo<=pageCount){
						this.queryGroupGoes({searchKey: searchKey,pageNo:nextPageNo,newload:false});
					}else if(goType=="ono" && nextPageNo<=pageCount){
						this.queryOnOGoes({searchKey: searchKey,pageNo:nextPageNo,newload:false});
					}
				},
				
				queryGroupGoes: function(p){
					var _this = this;
					ajaxController.ajax({
						url: "../go/queryMyJointGoes",
						type: "post",  
						data : {
							goType: "group",
							searchKey: p.searchKey?p.searchKey:"",
							pageNo : p.pageNo?p.pageNo:1,
							pageSize : 10
						},
						success: function(transport){
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<pageCount){
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo",pageNo+1).attr("goType","group").attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo",pageNo+1).attr("goType","group").attr("pageCount",pageCount).hide();
							}
							_this.renderGroups(data.result,p.newload); 
						},
						failure: function(transport){ 
							_this.renderGroups([],p.newload); 
						}
					});
				},
				
				queryOnOGoes: function(p){
					var _this = this;
					ajaxController.ajax({
						url: "../go/queryMyJointGoes",
						type: "post",  
						data : {
							goType: "oneonone",
							searchKey: p.searchKey?p.searchKey:"",
							pageNo : p.pageNo?p.pageNo:1,
							pageSize : 10
						},
						success: function(transport){
							var data =transport.data;  
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<pageCount){
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo",pageNo+1).attr("goType","oneonone").attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").show().attr("nextPageNo","").attr("goType","oneonone").attr("pageCount",pageCount).hide();
							}
							_this.renderOneOnOne(data.result,p.newload); 
						},
						failure: function(transport){ 
							_this.renderOneOnOne([],p.newload); 
						}
					});
				},
				
				renderGroups : function(data,newload) {
					data = data ? data : [];
					var opt="";
					if(data.length>0){
						 opt = $("#GroupsImpl").render(data);
					}else{
						opt="<section class=\"wuwai_jiansheng\">还没有相关活动信息哦~</section>";
					}
					if(newload){
						$("#DIV_GROUP_GOES").html(opt);
					}else{
						 $("#DIV_GROUP_GOES").append(opt);
					}
					
				},
				
				renderOneOnOne : function(data,newload) {
					data = data ? data : [];
					var opt="";
					if(data.length>0){
						 opt = $("#OneOnOnImpl").render(data);
					}else{
						opt="<section class=\"wuwai_jiansheng\">还没有相关活动信息哦~</section>";
					}
					if(newload){
						$("#DIV_ONO_GOES").html(opt);
					}else{
						 $("#DIV_ONO_GOES").append(opt);
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