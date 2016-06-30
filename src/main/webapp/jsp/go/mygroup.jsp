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
<title>我创建的Group</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/json2.js"></script>
<script src="//static.tfeie.com/v2/js/swiper.min.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>
<body class="bg-eeeeee">

	<nav class="be-nav po-f box-s">
		<div class="hd clearfix">
			<a href="../be/mybe.html" class="itms">Be</a> <a
				href="../go/mygroup.html" class="itms on">Group</a> <a
				href="../go/myono.html" class="itms">OnO</a>
		</div>
	</nav>

	<section class="group-main" id="DIV_MY_GOES">
		

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
	(function($) {
		$.MyGroupGoPage = function(data) {
			this.settings = $.extend(true, {}, $.MyGroupGoPage.defaults);
			this.params = data ? data : {}
		}
		$.extend($.MyGroupGoPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.initData();
				},
				initData : function() {
					this.getMyGoes();
				},

				getMyGoes : function() {
					var _this = this;
					ajaxController.ajax({
						url : "../go/getMyGoes",
						type : "post",
						data : {
							goType: "group",
							pageNo : 1,
							pageSize : 100
						},
						success : function(transport) {
							var data = transport.data;
							//alert(JSON.stringify(data))
							_this.renderMyGroups(data.result);
						},
						failure : function(transport) {
							_this.renderMyGroups([]);
						}
					});
				},

				renderMyGroups : function(data) {
					data = data ? data : [];
					var opt = $("#MyGroupsImpl").render(data);
					$("#DIV_MY_GOES").html(opt);
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

		var p = new $.MyGroupGoPage();
		p.init();

	});
</script>


<script id="MyGroupsImpl" type="text/x-jsrender"> 
		<div class="itms box-s">
			<div class="tie">
				<p>{{:topic}}</p>
				<div class="tim">{{:createTimeStr}}</div>
			</div>
			<div class="name clearfix">
				<div class="img">
					<a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}" width="40" height="40"></a>
				</div>
				<div class="name-xx">
					<div class="xx">
						{{:enName}}<span class="bg-lv">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font>
					</div>
					<div class="jj">{{:industryName}}/{{:title}}/{{:atCityName}}</div>
				</div>
			</div>
			<div class="time">
				{{:expectedStartTime}}<span class="bg-f5922f">{{:orgModeName}}</span>
			</div>
			<div class="yq">
				Group邀请{{:inviteMembers}}人<span class="fc-f5922f">{{if payMode=="10"}}{{:fixPriceYuan}}元{{else payMode=="20"}}{{:payModeName}}{{:fixPriceYuan}}元 {{else payMode=="30"}} {{:payModeName}} {{/if}}</span>
			</div>
			<div class="dz">{{:location}}</div>
			<div class="js chaochu_2">{{:contentSummary}}</div>
			<div class="bottom">
				<div class="list">
					浏览<font>{{:viewCount}}</font>
				</div>
				<div class="list">
					参加<font>{{:joinCount}}</font>
				</div>
				<div class="list list-sc">
					收藏<font>{{:favorCount}}</font>
				</div>
			</div>
		</div> 
</script>
</html>