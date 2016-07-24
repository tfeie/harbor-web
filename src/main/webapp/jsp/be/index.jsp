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
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script> 
<style>
         #bg{ display: block;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);}


#shareit {
	-webkit-user-select: none;
	display: block;
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
	position:absolute;
	top:1%;
	right: 0%;
}

#share-text {
	margin-top: 400px;
}

</style>

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
					
				</div>
			</div>
			<div class="search"></div>
		</section>

		<section class="sec_list">
			<ul id="UL_BES">
				
			</ul>
			
		</section>
		<div id="UL_GOTO_NEXTPAGE" style="display:none"></div>
			

	</section>
	<div id="imgbaner">
	
	</div>
	 
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
						_this.queryBes({tagId: tagId,searchKey: "",pageNo: 1,newload: true});
					});
					$("#UL_BES").delegate("[name='DIV_BE_CONTENT']","click",function(){
						var beId =$(this).attr("beId");
						window.location.href="../be/detail.html?beId="+beId;
					});
					$("#UL_BES").delegate("[name='SPN_DASHANG']","click",function(){
						var beId =$(this).attr("beId");
						_this.giveHB(beId);
					});
					$("#UL_BES").delegate("[name='SPN_DIANZAN']","click",function(){
						var beId =$(this).attr("beId");
						_this.doDianzan(beId);
					});
					
					$("#UL_GOTO_NEXTPAGE").on("click",function(){
						var tagId=$("#DIV_BE_TAGS").find("[name='BE_TAG'].on").attr("tagId");
						_this.lastTagId=_this.currentTagId
						_this.currentTagId=tagId;
						_this.gotoNextPage(tagId);
					});
					
					
					$(window).scroll(function() {
						var scrollTop = $(document).scrollTop();//获取垂直滚动的距离
			            var docheight = $(document).height();
			            var winheight = $(window).height();

			            if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
			            	var tagId=$("#DIV_BE_TAGS").find("[name='BE_TAG'].on").attr("tagId");
			            	_this.gotoNextPage(tagId);
			            }

					})
					
				},
				
				initData: function(){
					this.getIndexPageSilders();
					this.getAllBeIndexPageTags();
					this.queryBes({tagId: "",searchKey: "",pageNo: 1,newload: true});
				}, 
				
				giveHB: function(beId){
					var _this=this;
					ajaxController.ajax({
						url: "../be/giveHaibei",
						type: "post", 
						data: {
							beId: beId,
							count: 1
						},
						success: function(transport){ 
							var count = transport.data;
							$("#a_givehb_"+beId).text(count);
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
				
				doDianzan: function(beId){
					var _this = this;
					ajaxController.ajax({
						url: "../be/dianzan",
						type: "post", 
						data: { 
							beId: beId
						},
						success: function(transport){
							var count = transport.data;
							$("#a_dianzan_"+beId).text(count);
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
				
				getAllBeIndexPageTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getAllBeIndexPageTags",
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
				
				gotoNextPage: function(tagId){
					var nextPageNo = $("#UL_GOTO_NEXTPAGE").attr("nextPageNo");
					var searchKey="";
					var pageCount=$("#UL_GOTO_NEXTPAGE").attr("pageCount");
					if(nextPageNo>0 && nextPageNo<=pageCount){
						this.queryBes({tagId: tagId,searchKey: searchKey,pageNo: nextPageNo,newload: false});
					}
					
				},
				
				queryBes: function(p){
					var _this = this;
					weUI.showLoadingToast("加载中...");
					ajaxController.ajax({
						url: "../be/queryBes",
						type: "post",  
						data : {
							polyTagId: p.tagId?p.tagId:"",
							searchKey: p.searchKey?p.searchKey:"",
							pageNo : p.pageNo?p.pageNo: 1,
							pageSize : 2
						},
						success: function(transport){
							weUI.hideLoadingToast();
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							_this.renderBes(data.result,p.newload); 
							if(pageNo<=pageCount){
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo+1).attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",0).attr("pageCount",0);
							}
						},
						failure: function(transport){ 
							weUI.hideLoadingToast();
							_this.renderBes([],p.newload); 
						}
					});
				},
				
				renderBes : function(data,newload) {
					data = data ? data : [];
					var opt="";
					if(data.length>0){
						opt = $("#BeListImpl").render(data);
					}else{
						if(newload){
							opt="<li>没有任何内容哦~~</li>";
						}
					}
					if(newload){
						$("#UL_BES").html(opt);
					}else{
						$("#UL_BES").append(opt);
					}
					
				},
				
				renderBeTags: function(){
					var allBeTags =this.allBeTags;
					data= {
						allBeTags: allBeTags
					}
					var opt=$("#BeTagsImpl").render(data);
					$("#DIV_BE_TAGS").html(opt); 
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
<div class="item">
						<a href="javascript:void(0)" class="on" tagId="" name="BE_TAG">推荐</a>
					</div>
{{for allBeTags}}
<div class="item">
	<a href="javascript:void(0)" name="BE_TAG" tagId="{{:tagId}}" tagName="{{:tagName}}">{{:tagName}}</a>
</div>
{{/for}} 
</script>

<script id="BeListImpl" type="text/x-jsrender"> 
<li name="BE_LI" beId="{{:beId}}">
					<section class="list">
						<div class="member_info">
							<div class="img">
				<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}"
					width="80" height="80"></a>
			</div>
							
							<span>{{:enName}}</span> <label class="lbl2">{{:abroadCountryName}}</label> <em>{{:userStatusName}}</em>
						</div>
						<div class="member" beId="{{:beId}}" name="DIV_BE_CONTENT">
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
							<span class="span_bk" name="SPN_DASHANG" beId="{{:beId}}"><a id="a_givehb_{{:beId}}">{{:giveHaibeiCount}}</a></span> <span class="span_z" name="SPN_DIANZAN" beId="{{:beId}}"><a id="a_dianzan_{{:beId}}">{{:dianzanCount}}</a></span>
						</div>

					</section>
			</li>

</script>

</html>