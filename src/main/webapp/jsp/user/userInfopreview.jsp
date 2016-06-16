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
				<span><c:out value="${userInfo.enName}"/></span><label class="lbl2"><c:out value="${userInfo.abroadCountryName}"/></label><c:out value="${userInfo.userStatusName}"/>
			</p>
		</section>
		<section class="ip_shengf">
			<p><c:out value="${userInfo.industryName}"/>/<c:out value="${userInfo.title}"/>/<c:out value="${userInfo.atCity}"/></p>
		</section>

		<section class="ip_eng">
			<p><c:out value="${userInfo.signature}"/></p>
		</section>

		<section class="ip_aihao" id="SELECTED_INTEREST_TAGS">
			
		</section>
		<section class="ip_smone">
			<p><c:out value="${userInfo.abroadUniversity}"/></p>
			<p><c:out value="${userInfo.maritalStatusName}"/></p>
			<p><c:out value="${userInfo.constellationName}"/></p>
		</section>

		<section class="ip_jineng" id="SELECTED_SKILL_TAGS">
			
		</section>

		<section class="ip_zhiwei">
			<p><c:out value="${userInfo.mobilePhone}"/></p>
			<p><c:out value="${userInfo.industryName}"/></p>
			<p><c:out value="${userInfo.company}"/></p>
			<p><c:out value="${userInfo.title}"/></p>
		</section>

		<section class="but_baoc but_baoc1">
			<p>
				<input type="button" value="申请认证" />
			</p>
		</section>
		<section class="zhangdemei">
			<p>(据说长得美的都认证了....)</p>
		</section>

		<section class="ip_bianji">
			<p>
				<a href="#">编辑信息</a>
			</p>
		</section>
	</section>
	<footer class="footer">
		<ul>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f1.png" />
					</div>
					<div class="text">Be</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f2.png" />
					</div>
					<div class="text">Go</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f3.png" />
					</div>
					<div class="text">Frd</div>
			</a></li>
			<li><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f4.png" /><i>6</i>
					</div>
					<div class="text">Msg</div>
			</a></li>
			<li class="on"><a href="">
					<div class="img">
						<img src="//static.tfeie.com/images/f5.png" />
					</div>
					<div class="text">Me</div>
			</a></li>
		</ul>
	</footer>
</body>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>

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
				},
				
				initData: function(){ 
					this.getAllTags(); 
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
		var p = new $.UserViewPreviewPage({
			userId: "<c:out value="${userInfo.userId}"/>"
		});
		p.init();
	});	
	
	</script>
	
	<script id="SelectedTagImpl" type="text/x-jsrender"> 
		<p>
				<span>{{:tagName}}</span>
		</p>
	</script>

</html>