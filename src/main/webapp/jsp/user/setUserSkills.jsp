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
<title>兴趣技能</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
</head>
<body>
	<section class="skill_top">
		<p>请告诉Calypso，该怎样取悦你呢…</p>
	</section>
	<section class="tab">
		<section class="tab_title">
			<p>
				兴趣标签<span>(1/5)</span>
			</p>
		</section>
		<section class="tab_con" id="SELECTION_INTEREST_TAGS">

		</section>
	</section>
	<section class="tab in">
		<section class="tab_title">
			<p>
				技能标签<span>(4/5)</span>
			</p>
		</section>
		<section class="tab_con" id="SELECTION_SKILLS_TAGS">
			
		</section>
	</section>
	<section class="but_baoc">
		<p>
			<input type="button" value="确 认" />
		</p>
	</section>
</body>

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/json2.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript">
	(function($) {
		$.UserSkillsPage = function() {
			this.settings = $.extend(true, {}, $.UserSkillsPage.defaults);
		}
		$.extend($.UserSkillsPage, {
			defaults : {},

			prototype : {
				init : function() {
					this.bindEvents();
					this.getAllBaseInterestTags();
					this.getAllBaseSkillTags();
				},

				bindEvents : function() {
					var _this = this;
					$("#BTN_SUBMIT").bind("click", function() {
						_this.submit();
					});
				},
				getAllBaseInterestTags : function() {
					var _this = this;
					ajaxController.ajax({
						url : "../sys/getAllBaseInterestTags",
						type : "post",
						success : function(transport) {
							var d = transport.data; 
							//alert(JSON.stringify(d));
							var template = $.templates("#InterestTagsImpl");
		                    var htmlOutput = template.render(d?d:[]);
		                    $("#SELECTION_INTEREST_TAGS").html(htmlOutput);
						},
						failure : function(transport) {
						}

					});

				},
				
				getAllBaseSkillTags : function() {
					var _this = this;
					ajaxController.ajax({
						url : "../sys/getAllBaseSkillTags",
						type : "post",
						success : function(transport) {
							var d = transport.data; 
							//alert(JSON.stringify(d));
							var template = $.templates("#SkillTagsImpl");
		                    var htmlOutput = template.render(d?d:[]);
		                    $("#SELECTION_SKILLS_TAGS").html(htmlOutput);
						},
						failure : function(transport) {
						}

					});

				},

				showError : function(message) {
					$(".message-err").show().html(
							"<p><span>X</span>" + message + "</p>");
				},

				showSuccess : function(message) {
					$(".message-err").show().html(
							"<p><span></span>" + message + "</p>");
				},

				hideMessage : function() {
					$(".message-err").html("").hide();
				}
			}
		})
	})(jQuery);

	$(document).ready(function() {
		var p = new $.UserSkillsPage();
		p.init();
	});
</script>

<script id="InterestTagsImpl" type="text/x-jsrender">
<section class="tab_location{{: #index}}">
	<button>{{:tagName}}</button>
</section> 
</script>

<script id="SkillTagsImpl" type="text/x-jsrender">
<section class="tab_location{{: #index}}">
	<button>{{:tagName}}</button>
</section> 
</script>
</html>