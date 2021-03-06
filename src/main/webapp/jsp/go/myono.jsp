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
<title>我<c:if test="${type=='mycreate'}">创建</c:if><c:if test="${type=='myfavor'}">收藏</c:if>的OneOnOne活动</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<link href="//static.tfeie.com/v2/css/footer.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>

</head>
<body class="bg-eeeeee">
	<nav class="be-nav po-f box-s">
		<div class="hd clearfix">
			<a href="../be/mybe.html?type=<c:out value="${type}"/>" class="itms">Be</a> <a
				href="../go/mygroup.html?type=<c:out value="${type}"/>" class="itms">Group</a> <a
				href="../go/myono.html?type=<c:out value="${type}"/>" class="itms on">OnO</a>
		</div>
	</nav>
	<section class="group-main one-main" id="DIV_MY_GOES">
			<div id="UL_GOTO_NEXTPAGE" style="display:none">
				<p align="center">点击加载下一页</p>
			</div>
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
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
<script type="text/javascript">
	(function($) {
		$.MyOnOGoPage = function(data) {
			this.settings = $.extend(true, {}, $.MyOnOGoPage.defaults);
			this.params = data ? data : {}
		}
		$.extend($.MyOnOGoPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.initData();
					this.initEvents();
				},
				initEvents: function(){
					var _this = this;
					$("#DIV_MY_GOES").delegate("[name^='TD_']","click",function(){
						var goId = $(this).parent("[name='GROUP_DETL']").attr("goId");
						var goType = $(this).parent("[name='GROUP_DETL']").attr("goType");
						var type =_this.getPropertyValue("type");
						if(goType=="group"){
							window.location.href="../go/invite.html?goId="+goId;
						}else{
							if(type=="mycreate"){
								window.location.href="../go/mycreateonodetail.html?goId="+goId;
							}else{
								window.location.href="../go/onodetail.html?goId="+goId;
							}
							
						}
					});
					
					// 我发起的，点击编辑
					$("#DIV_MY_GOES").delegate("[id='SHOU_OR_EDIT']","click",function(){
						var type =_this.getPropertyValue("type");
						if(type=="mycreate"){
							weUI.showXToast("功能马上来");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 500);
						}
					});
					
					//删除GO
					$(document).delegate(".icon-sc","click",function(){
						var goId =$(this).attr("goId");
						weUI.confirm({
							content: "确定要删除吗?",
							ok: function(){
								_this.deleteGo(goId);
								weUI.closeConfirm();
							}
						})
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
				
				initData : function() {
					this.getMyGoes({pageNo: 1,newload: true});
				},
				
				gotoNextPage: function(){
					var nextPageNo = $("#UL_GOTO_NEXTPAGE").attr("nextPageNo");
					var pageCount=$("#UL_GOTO_NEXTPAGE").attr("pageCount");
					if(nextPageNo<=pageCount){
						this.getMyGoes({pageNo: nextPageNo,newload: false});
					}
					
				},
				
				deleteGo: function(goId){
					var _this =this;
					ajaxController.ajax({
						url: "../go/deleteGo",
						type: "post", 
						data: { 
							goId: goId
						},
						success: function(transport){
							var dom=$("#DIV_GO_"+goId);
							dom.fadeOut("200",function(){
								dom.detach();
								var len = $("[name='GROUP_DETL']").length;
								if(len==0){
									var opt="<div class='itms box-s'><div class='js chaochu_2' style='text-align:center;'>没有任何One On One活动哦~</div></div>";
									$("#DIV_MY_GOES").append(opt); 
								}
							});
						},
						failure: function(transport){
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
						}
					});
				},

				getMyGoes : function(p) {
					var _this = this;
					var type=_this.getPropertyValue("type");
					var url ="";
					if(type=="mycreate"){
						url = "../go/getMyGoes";
					}else if(type=="myfavor"){
						url = "../go/getMyFavorGoes";
					}
					if(!p.newload){
						weUI.showLoadingToast("加载中...");
					}
					ajaxController.ajax({
						url : url,
						type : "post",
						data : {
							goType: "oneonone",
							pageNo : p.pageNo?p.pageNo:1,
							pageSize : 10
						},
						success : function(transport) {
							if(!p.newload){
								weUI.hideLoadingToast();
							}
							var data = transport.data;
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<=pageCount){
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo+1).attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",0).attr("pageCount",pageCount);
							}
							_this.renderMyGroups(data.result,p.newload);
						},
						failure : function(transport) {
							if(!p.newload){
								weUI.hideLoadingToast();
							}
							_this.renderMyGroups([],p.newload);
						}
					});
				},

				renderMyGroups : function(data,newload) {
					data = data ? data : [];
					if(data.length>0){
						opt = $("#MyGroupsImpl").render(data);
					}else{
						if(newload){
							opt="<div class='itms box-s'><div class='js chaochu_2' style='text-align:center;'>没有任何One On One活动哦~</div></div>";
						}
					}
					if(newload){
						$("#DIV_MY_GOES").html(opt);
					}else{
						$("#DIV_MY_GOES").append(opt);
					}
				},

				getPropertyValue : function(propertyName) {
					if (!propertyName)
						return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);

	$(document).ready(function() {
		var b = new $.HarborBuilder();
		b.buildFooter();

		var p = new $.MyOnOGoPage({
			type: "<c:out value="${type}"/>"
		});
		p.init();

	});
</script>


<script id="MyGroupsImpl" type="text/x-jsrender"> 	
		<div class="itms box-s" name="GROUP_DETL" id="DIV_GO_{{:goId}}" goId="{{:goId}}" goType="{{:goType}}">
			<c:if test="${type=='mycreate'}">
			<i class="icon-sc" name="GO_DEL" goId="{{:goId}}"></i>
			</c:if>
			<div class="tie" name="TD_TOPIC">
				<p><b>{{:topic}}</b></p>
			</div>
			<div class="fw" name="TD_NAME">
				<div class="right">
					<span class="bg-f5922f">{{:orgModeName}}</span> <font class="fc-f5922f">{{:payModeName}}</font>
				</div>
				<div class="name clearfix">
					<div class="img">
						<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}" width="40" height="40"></a>
					</div>
					<div class="name-xx">
						<div class="xx">
							{{:enName}}<span class="bg-lv" style="background:{{:abroadCountryRGB}}">{{:abroadCountryName}}</span><font><font {{if userStatus=='20'}}color="#FFB90F"{{/if}}   
>{{:userStatusName}}</font></font>
						</div>
						<div class="jj">{{:employmentInfo}}</div>
					</div>
				</div>
			</div>
			<div class="c pad-10 chaochu_3" name="TD_CONTENT">
				{{:contentSummary}}
			</div>
			<div class="bottom">
				<div class="list">
					浏览<font>{{:viewCount}}</font>
				</div>
				<c:if test="${type=='mycreate'}">
				<div class="list list-sc" id='SHOU_OR_EDIT'>
					编辑<font></font>
				</div>
				</c:if>
				<c:if test="${type=='myfavor'}">
				<div class="list list-sc" id='SHOU_OR_EDIT'>
					收藏<font>{{:favorCount}}</font>
				</div>
				</c:if>
				
			</div>
		</div> 	
</script>
</html>