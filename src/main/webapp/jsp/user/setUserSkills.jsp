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
				兴趣标签<span id="SPAN_TOTAL_INTEREST_TAG_SELECTED">(0/5)</span>
			</p>
		</section>
		<section class="tab_con" id="SELECTION_INTEREST_TAGS">

		</section>
	</section>
	<section class="tab in">
		<section class="tab_title">
			<p>
				技能标签<span id="SPAN_TOTAL_SKILL_TAG_SELECTED">(0/5)</span>
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
					this.interestSelectedTags =[];
					this.skillSelectedTags =[];
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
							var template = $.templates("#InterestTagsImpl");
		                    var htmlOutput = template.render(d?d:[]);
		                    $("#SELECTION_INTEREST_TAGS").html(htmlOutput);
		                    _this.renderInterestTagsBtn();
						},
						failure : function(transport) {
						}

					});

				},
				
				renderInterestTagsBtn: function(){
					var _this = this;
					$("[name='BTN_INTEREST_TAG']").bind("click",function(){
						var tagId = $(this).attr("tagId");
						var tagName = $(this).text();
						var selected =_this.checkTagSelected(_this.interestSelectedTags,tagId);
						if(selected){
							//如果已经选择，则取消
							_this.deleteTagSelected(_this.interestSelectedTags,tagId);
							$(this).css("background","#ffe0d6");
						}else{
							//如果没有选择，则选择
							if(_this.interestSelectedTags.length>=5){
								alert("兴趣标签最多只能选择5个");
								return ;
							}
							_this.interestSelectedTags.push({
								tagId: tagId,
								tagName: tagName
							});
							$(this).css("background","#f96b3e");
						}
						$("#SPAN_TOTAL_INTEREST_TAG_SELECTED").html("("+_this.interestSelectedTags.length+"/5)");
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
		                    _this.renderSkillTagsBtn();
						},
						failure : function(transport) {
						}

					});

				},
				
				renderSkillTagsBtn: function(){
					var _this = this;
					$("[name='BTN_SKILL_TAG']").bind("click",function(){
						var tagId = $(this).attr("tagId");
						var tagName = $(this).text();
						var selected =_this.checkTagSelected(_this.skillSelectedTags,tagId);
						if(selected){
							//如果已经选择，则取消
							_this.deleteTagSelected(_this.skillSelectedTags,tagId);
							$(this).css("background","#ffecb2");
						}else{
							//如果没有选择，则选择
							if(_this.skillSelectedTags.length>=5){
								alert("技能标签最多只能选择5个");
								return ;
							}
							_this.skillSelectedTags.push({
								tagId: tagId,
								tagName: tagName
							});
							$(this).css("background","#f96b3e");
						}
						$("#SPAN_TOTAL_SKILL_TAG_SELECTED").html("("+_this.skillSelectedTags.length+"/5)");
					});
				},
				
				checkTagSelected: function(selecteddata,tagId){
					var arr = $.grep(selecteddata,function(n,i){
						return n.tagId==tagId;
					});
					return arr.length?true:false;
				},
				
				deleteTagSelected: function(selecteddata,tagId){
					var arr = $.grep(selecteddata,function(n,i){
						return n.tagId==tagId;
					});
					if(arr.length){
						var e = arr[0];
						selecteddata.splice($.inArray(e,selecteddata),1);
					}
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
<section class="tab_location{{: #index+1}}">
	<button name="BTN_INTEREST_TAG" tagId="{{:tagId}}">{{:tagName}}</button>
</section> 
</script>

<script id="SkillTagsImpl" type="text/x-jsrender">
<section class="tab_location{{: #index+1}}">
	<button name="BTN_SKILL_TAG" tagId="{{:tagId}}">{{:tagName}}</button>
</section> 
</script>
</html>