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
<title>Group & One on One</title>
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

	<header class="header"></header>

	<section class="banner" id="INDEX_SILDER"></section>
	<div class="clear"></div>
	<section class="mainer">
		<section class="choose_go">
			<div class="bor_wid">
			<p><span goType="group" <c:if test="${goType=='group' }">class="on"</c:if>>Group</span><span  <c:if test="${goType=='ono' }">class="on"</c:if> goType="ono">One on One</span></p>
			</div>
		</section>
		<section class="title">
			<div class="tit_nav">
				<div class="title_owl" id="DIV_GROUP_TAGS" style="display:none"></div>
				<div class="title_owl" id="DIV_ONO_TAGS" style="display:none"></div>
			</div>
			<div class="search">
			</div>
		</section> 

		<section class="group_oneon" >
			<section class="lat_group on" id="DIV_GOES">
			</section>
		</section>
		<div id="UL_GOTO_NEXTPAGE" style="display:none"></div>
		
	</section>
</body>
<script type="text/javascript"
	src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
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
//微信API配置
wx.config({
	debug : false,
	appId : '<c:out value="${appId}"/>',
	timestamp : '<c:out value="${timestamp}"/>',
	nonceStr : '<c:out value="${nonceStr}"/>',
	signature : '<c:out value="${signature}"/>',
	jsApiList : [ 'checkJsApi', 'previewImage','onMenuShareTimeline','onMenuShareAppMessage']
});

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
					wx.ready(function () {
						 var shareData = {
								   title: "Group & One on One",
								   desc: "海归海湾，海归创业第一站",
								   link: '${url}',
								   imgUrl: '${userInfo.wxHeadimg}'
							};
						 
						wx.onMenuShareTimeline(shareData);	
						wx.onMenuShareAppMessage(shareData);	
					});
				},
				
				bindEvents: function(){
					var _this = this;  
					//点击标签
					$("#DIV_ONO_TAGS").delegate("[name='GO_TAG']","click",function(){
						var tagId = $(this).attr("tagId");
						$("[name='GO_TAG']").removeClass("on");
						$(this).addClass("on");
						_this.queryOnOGoes({tagId: tagId, searchKey: "", pageNo: 1, newload: true});
					});
					$("#DIV_GROUP_TAGS").delegate("[name='GO_TAG']","click",function(){
						var tagId = $(this).attr("tagId");
						$("[name='GO_TAG']").removeClass("on");
						$(this).addClass("on");
						_this.queryGroupGoes({tagId: tagId, searchKey: "", pageNo: 1, newload: true});
					});
					
					//点击活动分类标签
					$(".bor_wid p span").on("click",function(){
						$(this).parents("p").find("span").removeClass("on")
		        	    $(this).addClass("on")
		        	    var goType=$(".bor_wid p span.on").attr("goType");
						
						if(goType=="group"){
							$("#DIV_GROUP_TAGS").show();
							$("#DIV_ONO_TAGS").hide();
							var tagId=$("#DIV_GROUP_TAGS").find("[name='GO_TAG'].on").attr("tagId");
							_this.queryGroupGoes({tagId: tagId, searchKey: "", pageNo: 1, newload: true});
						}else{
							$("#DIV_GROUP_TAGS").hide();
							$("#DIV_ONO_TAGS").show();
							var tagId=$("#DIV_ONO_TAGS").find("[name='GO_TAG'].on").attr("tagId");
							_this.queryOnOGoes({tagId: tagId, searchKey: "", pageNo: 1, newload: true});
						}
					});
					
					$(".group_oneon").delegate(".title_jiansheng","click",function(){
						var goId = $(this).parent().attr("goId");
						var goType = $(this).parent().attr("goType");
						if(goType=="group"){
							window.location.href="../go/invite.html?goId="+goId;
						}else{
							window.location.href="../go/onodetail.html?goId="+goId;
						}
						
					});
					
					$(".group_oneon").delegate(".info_fuwu","click",function(){
						var goId =$(this).parent().attr("goId");
						var goType =$(this).parent().attr("goType");
						if(goType=="group"){
							window.location.href="../go/invite.html?goId="+goId;
						}else{
							window.location.href="../go/onodetail.html?goId="+goId;
						}
					});
					
					// 收藏
					$(".group_oneon").delegate("[name='GO_FAVORITE']","click",function(){
						var goId =$(this).parents(".wuwai_jiansheng").attr("goId");
						var goType =$(this).parents(".wuwai_jiansheng").attr("goType");
						_this.doGoFavorite($(this),goId,goType);
					});
					
					$("#UL_GOTO_NEXTPAGE").on("click",function(){
						var tagId=$("#DIV_GO_TAGS").find("[name='GO_TAG'].on").attr("tagId");
						tagId=tagId?tagId:"";
						_this.gotoNextPage(tagId);
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
					this.getAllGroupIndexPageTags();
					this.getAllOnOIndexPageTags();
					var goType = this.getPropertyValue("goType");
					if(goType == "group") {
						$("#DIV_GROUP_TAGS").show();
						$("#DIV_ONO_TAGS").hide();
						this.queryGroupGoes({tagId: "", searchKey: "", pageNo: 1, newload: true});
					} else {
						$("#DIV_GROUP_TAGS").hide();
						$("#DIV_ONO_TAGS").show();
						this.queryOnOGoes({tagId: "", searchKey: "", pageNo: 1, newload: true});
					}
				}, 
				
				doGoFavorite:function(_this,goId,goType){
					var v = _this.attr("value");
					weUI.showLoadingToast("正在处理中...");
					ajaxController.ajax({
						url: "../go/doGoFavorite",
						type: "post", 
						data:{
							goId: goId
						},
						success: function(transport){
							var count = parseInt(v) + 1;
							_this.html("收藏" + count);
							weUI.hideLoadingToast();
							weUI.showXToast("收藏成功");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						},
						failure: function(transport){
							weUI.hideLoadingToast();
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
						
					});
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
					var tagId=$("[name='GO_TAG'].on").attr("tagId");
					if(goType=="group" && nextPageNo<=pageCount){
						this.queryGroupGoes({tagId: tagId, searchKey: "", pageNo: nextPageNo, newload: false});
					}else if(goType=="ono" && nextPageNo<=pageCount){
						this.queryOnOGoes({tagId: tagId, searchKey: "", pageNo: nextPageNo, newload: false});
					}
				},
				
				getAllGroupIndexPageTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getAllGroupIndexPageTags",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							var allGoTags =  data.allGoTags;
							//设置第一个元素选中
							if(allGoTags.length>0){
								var firstTag = allGoTags[0];
								firstTag.selected=true;
							}
							_this.renderGroupTags(allGoTags); 
						},
						failure: function(transport){ 
							_this.renderGroupTags([]); 
						}
					});
				},
				
				getAllOnOIndexPageTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getAllOnOIndexPageTags",
						type: "post",  
						success: function(transport){
							var data =transport.data;  
							var allGoTags =  data.allGoTags;
							//设置第一个元素选中
							if(allGoTags.length>0){
								var firstTag = allGoTags[0];
								firstTag.selected=true;
							}
							_this.renderOnOTags(allGoTags); 
						},
						failure: function(transport){ 
							_this.renderOnOTags([]); 
						}
					});
				},
				
				queryGroupGoes: function(p){
					var _this = this;
					if(!p.newload){
						weUI.showLoadingToast("加载中...");
					}
					ajaxController.ajax({
						url: "../go/queryGoes",
						type: "post",  
						data : {
							goType: "group",
							polyTagId: p.tagId?p.tagId:"",
							searchKey: p.searchKey?p.searchKey:"",
							pageNo : p.pageNo?p.pageNo:1,
							pageSize : 5
						},
						success: function(transport){
							weUI.hideLoadingToast();
							var data =transport.data;  
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<=pageCount){
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo+1).attr("goType","group").attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",0).attr("goType","group").attr("pageCount",pageCount);
							}
							_this.renderGroups(data.result,p.newload); 
						},
						failure: function(transport){ 
							weUI.hideLoadingToast();
							_this.renderGroups([],p.newload); 
						}
					});
				},
				
				queryOnOGoes: function(p){
					var _this = this;
					if(!p.newload){
						weUI.showLoadingToast("加载中...");
					}
					ajaxController.ajax({
						url: "../go/queryGoes",
						type: "post",  
						data : {
							goType: "oneonone",
							goTag: p.tagId?p.tagId:"",
							searchKey: p.searchKey?p.searchKey:"",
							pageNo : p.pageNo?p.pageNo:1,
							pageSize : 5
						},
						success: function(transport){
							if(!p.newload){
								weUI.hideLoadingToast();
							}
							var data =transport.data; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<=pageCount){
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo+1).attr("goType","oneonone").attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",0).attr("goType","oneonone").attr("pageCount",pageCount);
							}
							_this.renderOneOnOne(data.result,p.newload); 
						},
						failure: function(transport){ 
							if(!p.newload){
								weUI.hideLoadingToast();
							}
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
						if(newload){
							opt="<section class=\"wuwai_jiansheng\" style='text-align:center;'>还没有相关活动信息哦~</section>";
						}
					}
					if(newload){
						$("#DIV_GOES").html(opt);
					}else{
						$("#DIV_GOES").append(opt);
					}
					
				},
				
				renderOneOnOne : function(data,newload) {
					data = data ? data : [];
					var opt="";
					if(data.length>0){
						 opt = $("#OneOnOnImpl").render(data);
					}else{
						if(newload){
							opt="<section class=\"wuwai_jiansheng\" style='text-align:center;'>还没有相关活动信息哦~</section>";
						}
					}
					if(newload){
						$("#DIV_GOES").html(opt);
					}else{
						$("#DIV_GOES").append(opt);
					}
				}, 
				
				renderGroupTags: function(allGoTags){
					var data= {
						allGoTags: allGoTags
					}
					var opt=$("#GoTagsImpl").render(data);
					$("#DIV_GROUP_TAGS").html(opt); 
					
					$("#DIV_GROUP_TAGS").owlCarousel({
						items : 5,
						dots : false
					})
					
				},
				
				renderOnOTags: function(allGoTags){
					var data= {
						allGoTags: allGoTags
					}
					var opt=$("#GoTagsImpl").render(data);
					$("#DIV_ONO_TAGS").html(opt); 
					$("#DIV_ONO_TAGS").owlCarousel({
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
<div class="item">
	<a href="javascript:void(0)" name="GO_TAG" tagId="" tagName="全部">全部</a>
</div>
{{for allGoTags}}
<div class="item">
	<a href="javascript:void(0)" name="GO_TAG" tagId="{{:tagId}}" tagName="{{:tagName}}">{{:tagName}}</a>
</div>
{{/for}} 
</script>

<script id="GroupsImpl" type="text/x-jsrender"> 
				<section class="wuwai_jiansheng" goId="{{:goId}}" goType="{{:goType}}">
					<section class="title_jiansheng">
						<p>{{:topic}} {{if topFlag=="1"}}<font color='red'>[已置顶]</font>{{/if}}</p>
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
									<span>{{:enName}}</span><label class="lbl2" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</label><i><font {{if userStatus=='20'}}color="#FFB90F"{{/if}}   
>{{:userStatusName}}</font></i>
								</p>
								<p>{{:employmentInfo}}</p>
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
							<a href="javascript:void(0)">浏览 {{:viewCount}}</a><a href="javascript:void(0)">参加 {{:joinCount}}</a><a href="javascript:void(0)" name="GO_FAVORITE" value='{{:favorCount}}'>收藏 {{:favorCount}}</a>
						</p>
					</section>
				</section>
</script>

<script id="OneOnOnImpl" type="text/x-jsrender"> 
				<section class="wuwai_jiansheng" goId="{{:goId}}" goType="{{:goType}}">
					<section class="title_jiansheng">
						<p>{{:topic}} {{if topFlag=="1"}}<font color='red'>[已置顶]</font>{{/if}}</p>
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
									<span>{{:enName}}</span><label class="lbl2" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</label><i><font {{if userStatus=='20'}}color="#FFB90F"{{/if}}   
>{{:userStatusName}}</font></i><em
										class="online"><a href="#">{{:orgModeName}}</a></em>
								</p>
								<p>
									{{:employmentInfo}}<em>{{:joinCount}}人见过</em>
								</p>
							</section>
							<div class="clear"></div>
						</section>
						<section class="oneon_text">
							<p><a href="../go/onodetail.html?goId={{:goId}}">{{:contentSummary}}</p>
						</section>
					</section>
					<section class="oneon_span">
						<a href="javascript:void(0)">浏览 {{:viewCount}}</a><a href="javascript:void(0)" name='GO_FAVORITE' value='{{:favorCount}}'>收藏 {{:favorCount}}</a>
						<div class="clear"></div>
					</section>
				</section>
</script>

</html>