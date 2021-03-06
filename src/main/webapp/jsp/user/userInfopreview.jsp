<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<title>浏览个人信息</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>
</head>
<body class="body">
	<section class="ip_info oc">
		<section class="top_info">
			<p class="span_file">
				<img src="<c:out value="${userInfo.homePageBg}"/>">
			</p>
			<section class="ip_logo">
				<p>
					<span class="span_file"><img src="<c:out value="${userInfo.wxHeadimg}"/>" /></span>
				</p>
			</section>
		</section>

		<section class="ip_name">
			<p>
				<span><c:out value="${userInfo.enName}"/></span><label class="lbl2" style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}"/></label><font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>><c:out value="${userInfo.userStatusName}"/></font>
			</p>
		</section>
		<section class="ip_shengf">
			<p><c:out value="${userInfo.employmentInfo}"/></p>
		</section>

		<section class="ip_eng">
			<p><c:out value="${userInfo.signature}"/></p>
		</section>

		<section class="ip_aihao">
			<p id="SELECTED_INTEREST_TAGS">
			</p>
		</section>
		<section class="ip_smone">
			<p><c:out value="${userInfo.abroadUniversity}"/></p>
			<p><c:out value="${userInfo.maritalStatusName}"/></p>
			<p><c:out value="${userInfo.constellationName}"/></p>
		</section>

		<section class="ip_jineng">
			<p id="SELECTED_SKILL_TAGS">
			</p>
		</section>

		<section class="ip_zhiwei">
			<p><c:out value="${userInfo.industryName}"/></p>
			<p><c:out value="${userInfo.company}"/></p>
			<p><c:out value="${userInfo.title}"/></p>
		</section>

		<section class="ip_bianji">
			<p>
				<a href="../user/editUserInfo.html">编辑信息</a>
			</p>
		</section>
		
		<c:if test="${userInfo.userStatus!='20'}">
		<section class="ip_bianji">
			<p>
				<a href="javascript:void(0)" id="BTN_APPLY_CERT">申请认证</a>
			</p>
		</section>
		<section class="zhangdemei">
			<p>(据说长得美的都认证了....)</p>
		</section>
		</c:if>
	</section>

</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>


	<script type="text/javascript">
	(function($){
		$.UserViewPreviewPage = function(data){
			this.settings = $.extend(true,{},$.UserViewPreviewPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.UserViewPreviewPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.initData(); 
					this.bindEvents();
				},
				
				initData: function(){ 
					this.getAllTags(); 
				},
				
				bindEvents: function(){
					$(document.body).delegate("#BTN_APPLY_CERT","click",function(){
						window.location.href="../user/toApplyCertficate.html"						
					});
				},
				
				getAllTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../user/getUserTags",
						type: "post", 
						data: {
							userId: this.getPropertyValue("userId")
						},
						success: function(transport){
							var data =transport.data;
							_this.selectedSkillTags=data["selectedSkillTags"]?data["selectedSkillTags"]:[];
							_this.selectedInterestTags=data["selectedInterestTags"]?data["selectedInterestTags"]:[];

							_this.renderSelectedSkillTags(data["selectedSkillTags"]);
							_this.renderSelectedInterestTags(data["selectedInterestTags"]);
						},
						failure: function(transport){  
							_this.renderSelectedSkillTags([]);
							_this.renderSelectedInterestTags([]);
						}
					});
				},

				
				renderSelectedSkillTags: function(tags){ 
					var opt=$("#SelectedTagImpl").render(tags);
					$("#SELECTED_SKILL_TAGS").html(opt);
				},
				
				renderSelectedInterestTags: function(tags){
					var opt=$("#SelectedTagImpl").render(tags);
					$("#SELECTED_INTEREST_TAGS").html(opt);
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
		b.buildFooter({showBeGoQuick: "hide"});
		
		var p = new $.UserViewPreviewPage({
			userId: "<c:out value="${userInfo.userId}"/>"
		});
		p.init();
	});	
	
	</script>
	
	<script id="SelectedTagImpl" type="text/x-jsrender"> 
				<span>{{:tagName}}</span>
	</script>

</html>