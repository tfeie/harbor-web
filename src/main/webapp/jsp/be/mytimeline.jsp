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
<title>我的时间线</title>
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

<body>
	<section class="wdsjx-main">
		<div class="top-img">
			<font><c:out value="${userInfo.hyId}"/></font><img
				src="<c:out value="${userInfo.homePageBg}"/>" width="100%">
		</div>
		<div class="grxx">
			<div class="img">
				<a href="#"><img src="<c:out value="${userInfo.wxHeadimg}"/>"
					width="80" height="80"></a>
			</div>
			<div class="r">
				<div class="name">
					<c:out value="${userInfo.enName}"/><span class="bg-lv"><c:out value="${userInfo.abroadCountryName}"/></span><font><c:out value="${userInfo.userStatusName}"/></font>
				</div>
				<div class="xx"><c:out value="${userInfo.industryName}"/>/<c:out value="${userInfo.title}"/>/<c:out value="${userInfo.atCityName}"/></div>
			</div>
		</div>

		<div class="pad-10 clearfix line-20"><c:out value="${userInfo.signature}"/></div>
		
		<div id="DIV_MY_TIMELINE">
		
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
<script src="//static.tfeie.com/js/jquery.harborbuilder.js"></script>
<script type="text/javascript">
	(function($){
		$.MyTimeLinePage = function(data){
			this.settings = $.extend(true,{},$.MyTimeLinePage.defaults);
			this.params= data?data:{}
		}
		$.extend($.MyTimeLinePage,{
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
					
				},
				
				initData: function(){
					this.getMyTimeLine();
				}, 
				
				getMyTimeLine: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getMyTimeLine",
						type: "post", 
						data: { 
							pageNo: 1,
							pageSize: 100
						},
						success: function(transport){
							var data =transport.data; 
							_this.renderMyTimeLineList(data.result); 
						},
						failure: function(transport){ 
							_this.renderMyBeList([]); 
						}
					});
				},
				 
				renderMyTimeLineList: function(data){ 
					data= data?data:[];
					var opt=$("#MyBeListImpl").render(data);
					$("#DIV_MY_TIMELINE").html(opt); 
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
		
		var p = new $.MyTimeLinePage({ 
		});
		p.init();
		
		
	});
</script>


<script id="MyBeListImpl" type="text/x-jsrender"> 	
		<div class="itms">
			<div class="l">
				{{if showMMdd==true}}{{:mmdd}} {{/if}}
			</div>
			<a href="../be/detail.html?beId={{:beId}}" class="r">
				<div class="c">
					<div class="i">
						{{if hasimg==true}}
						<img src="{{:imageURL}}" width="60"
							height="60">
						{{/if}}
						{{if hasimg==false}}
						<img src="//static.tfeie.com/v2/images/pyq-img.jpg" width="60"
							height="60">
						{{/if}}
					</div>
					<p class="chaochu_3">{{if hastext==true}} {{:contentSummary}} {{/if}}</p>
				</div>
			</a>
		</div>
</script>
</html>