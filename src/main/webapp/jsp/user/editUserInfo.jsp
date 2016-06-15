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
<title>编辑个人信息</title>
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
<script>
	$(function() {

		$(".chooes_2 ul li a").click(function() {
			if ($(this).parent("li").hasClass("on")) {
			} else {
				var str = $(this).html();
			}
		})

		$(".chooes_2 ul li a").click(
				function() {

					if ($(this).parents(".check_item").find(".xinqi")
							.find("li").length >= 5
							|| $(this).parent("li").hasClass("on")) {
					} else {
						var li = $(".xinqi ul li").first().clone(true);
						li.find("p").find("a").html($(this).html());
						$(this).parents(".check_item").find(".xinqi ul")
								.append(li);
						$(this).parents(".check_item").find(".xinqi")
								.find("em").html(
										$(this).parents(".check_item").find(
												".xinqi").find("li").length)
						$(this).parent("li").remove();
					}
				})

	})
	function KX_list(obg) {
		var str = $(obg).parents("li").find("p").find("a").html();

		var li = $(obg).parents(".check_item").find(".chooes_2").find("li")
				.first().clone(true);

		$(obg).parents(".check_item").find("em").html(
				$(obg).parents(".check_item").find("em").html() - 1)

		li.find("a").html(str);
		$(obg).parents(".check_item").find(".chooes_2").find("ul").prepend(li);
		$(obg).parents("li").remove();
	}
</script>
</head>
<body class="body">
	<section class="top_info">
		<p class="span_file">
			<img src="<c:out value="${userInfo.homePageBg}"/>">
		</p>
		<section class="ip_logo">
			<p>
				<span class="span_file"><img
					src="<c:out value="${userInfo.wxHeadimg}"/>"></span>
			</p>
		</section>
	</section>
	<section class="sec_title"></section>
	<section class="per_info padding-bottom">
		<section class="par_name">
			<p>
				<input type="text" id="enName" placeholder="您的英文名称" value="<c:out value="${userInfo.enName}"/>">
			</p>
		</section>
		<section class="info_sex" id="SEX_SELECT"> 
		</section>
		<section class="sel_con">
			<p class="boss">
				<select id="abroadCountry">
				</select>
			</p>
		</section>
		<section class="par_name">
			<p class="boss">
				<input type="text" placeholder="您留学的学校名称" value="<c:out value="${userInfo.abroadUniversity}"/>" id="abroadUniversity">
			</p>
		</section>
		<section class="sel_con">
			<p class="boss">
				<select id="maritalStatus"></select>
			</p>
		</section>
		<section class="sel_con">
			<p class="boss">
				<select id="constellation"></select>
			</p>
		</section>
		<section class="par_textare">
			<p>
				<textarea id="signature" placeholder="您的个性签名..."><c:out value="${userInfo.signature}"/></textarea>
			</p>
		</section>
		<section class="check_item">
			<section class="xinqi left_t">
				<p class="left_t">
					已选兴趣标签<i><em>4</em>/5</i>
				</p>
				<ul>
					<li>
						<div class="xinqi_1">
							<p>
								<a>摄影</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>水上运动</a>
							</p>
							<div class="det">
								<p onclick="  KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>健身</a>
							</p>
							<div class="det">
								<p onclick="  KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>旅游</a>
							</p>
							<div class="det">
								<p onclick="  KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>

				</ul>
				<div class="clear"></div>
			</section>

			<section class="chooes_2">
				<p class="left_t">可选兴趣标签</p>
				<ul>
					<li><a>摄影</a></li>
					<li><a>打篮球</a></li>
					<li><a>水上运动</a></li>
					<li><a>打篮球</a></li>
					<li><a>看电影</a></li>
					<li><a>摄影</a></li>
					<li><a>睡觉</a></li>
					<li><a>旅游</a></li>
					<li class="on"><a><img
							src="//static.tfeie.com/images/icon15.png" /></a></li>
				</ul>
			</section>
		</section>
		<section class="par_name">
			<p class="boss">
				<input type="text" id="mobilePhone" value="<c:out value="${userInfo.mobilePhone}"/>" placeholder="您的移动电话号码">
			</p>
		</section>

		<section class="sel_con">
			<p class="boss">
				<select id="industry">
				</select>
			</p>
		</section>

		<section class="par_name">
			<p class="boss">
				<input type="text" id="company" value="<c:out value="${userInfo.company}"/>" placeholder="您就职的公司">
			</p>
		</section>

		<section class="par_name">
			<p class="boss">
				<input type="text" id="title" value="<c:out value="${userInfo.title}"/>" placeholder="您的职位头衔,如:CTO">
			</p>
		</section>
		<section class="check_item">
			<section class="xinqi">
				<p class="left_t">
					已选技能标签<i><em>3</em>/5</i>
				</p>
				<ul>
					<li>
						<div class="xinqi_1">
							<p>
								<a>摄影</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>水上运动</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
					<li>
						<div class="xinqi_1">
							<p>
								<a>健身</a>
							</p>
							<div class="det">
								<p onclick=" KX_list($(this));">
									<img src="//static.tfeie.com/images/icon16.png" />
								</p>
							</div>
						</div>
					</li>
				</ul>
				<div class="clear"></div>
			</section>

			<section class="chooes_2">
				<p class="left_t">可选技能标签</p>
				<ul>
					<li><a>摄影</a></li>
					<li><a>打篮球</a></li>
					<li><a>水上运动</a></li>
					<li><a>打篮球</a></li>
					<li><a>看电影</a></li>
					<li><a>摄影</a></li>
					<li><a>睡觉</a></li>
					<li><a>旅游</a></li>
					<li class="on"><a><img
							src="//static.tfeie.com/images/icon15.png" /></a></li>
				</ul>
			</section>
		</section>
		<section class="but_baoc">
			<p>
				<input type="button" value="保存" />
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
	<script type="text/javascript">
	(function($){
		$.UserEditPage = function(data){
			this.settings = $.extend(true,{},$.UserEditPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.UserEditPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData(); 
				},
				
				initData: function(){
					this.getAllHyCountries();
					this.getAllHyIndustries();
					this.getAllDicts();
					this.renderSex();
				},
				
				bindEvents: function(){ 
					//性别选择事件代理
					$("#SEX_SELECT").delegate("span","click",function(){
						$(this).parents("p").find("span").removeClass("on")
						$(this).addClass("on")
					});
					
					
				},
				
				renderSex: function(){
					var sex = this.getPropertyValue("sex");
					var opt=$("#SexImpl").render({sex:sex});
					$("#SEX_SELECT").append(opt);
				},
				
				getAllDicts: function(){
					var _this = this;
					var keydata = ["HY_USER.CONSTELLATION","HY_USER.MARITAL_STATUS"];
					ajaxController.ajax({
						url: "../sys/getHyDicts",
						type: "post", 
						data:{
							queryDictKeys:  JSON.stringify(keydata)
						},
						success: function(transport){
							var data =transport.data;
							_this.renderConstellationSelect(data["HY_USER.CONSTELLATION"]);
							_this.renderMaritalStatusSelect(data["HY_USER.MARITAL_STATUS"]);
						},
						failure: function(transport){
							_this.renderConstellationSelect();
							_this.renderMaritalStatusSelect();
						}
						
					});
				},
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				},
				
				renderConstellationSelect: function(options){
					var d  = {
						defaultValue: this.getPropertyValue("constellation"),
						showAll: true,
						allValue: "",
						allDesc: "请选择星座",
						options: options?options:[]
					};
					var opt=$("#SelectOptionImpl").render(d);
					$("#constellation").append(opt);
				},
				
				renderMaritalStatusSelect: function(options){
					var d  = {
						defaultValue: this.getPropertyValue("maritalStatus"),
						showAll: true,
						allValue: "",
						allDesc: "请选择婚姻情况",
						options: options?options:[]
					};
					var opt=$("#SelectOptionImpl").render(d);
					$("#maritalStatus").append(opt);
				},

				getAllHyCountries: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../sys/getAllHyCountries",
						type: "post", 
						success: function(transport){
							var data =transport.data;
							_this.fillCountriesSelelct(data);
						},
						failure: function(transport){
							_this.fillCountriesSelelct([]);
						}
						
					});
				},
				
				fillCountriesSelelct: function(options){ 
					var d  = {
						defaultValue: this.getPropertyValue("abroadCountry"),
						showAll: true,
						allValue: "",
						allDesc: "请选择留学国家",
						options: options?options:[]
					};
					var opt=$("#AbroadCountrySelectOptionImpl").render(d);
					$("#abroadCountry").append(opt);
				},
				
				getAllHyIndustries: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../sys/getAllHyIndustries",
						type: "post", 
						success: function(transport){
							var data =transport.data;
							_this.fillIndustriesSelelct(data);
						},
						failure: function(transport){
							_this.fillIndustriesSelelct([]);
						}
						
					});
				},
				
				fillIndustriesSelelct: function(options){
					var d  = {
						defaultValue: this.getPropertyValue("industry"),
						showAll: true,
						allValue: "",
						allDesc: "请选择行业",
						options: options?options:[]
					};
					var opt=$("#IndustrySelectOptionImpl").render(d);
					$("#industry").append(opt);
				},

				
				showError: function(message){
					$(".message-err").show().html("<p><span>X</span>"+message+"</p>");
				},
				
				showSuccess: function(message){
					$(".message-err").show().html("<p><span></span>"+message+"</p>");
				},
				
				hideMessage: function(){
					$(".message-err").html("").hide();
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var p = new $.UserEditPage({
			userId: "<c:out value="${userInfo.userId}"/>",
			sex: "<c:out value="${userInfo.sex}"/>",
			abroadCountry: "<c:out value="${userInfo.abroadCountry}"/>",
			industry: "<c:out value="${userInfo.industry}"/>",
			maritalStatus: "<c:out value="${userInfo.maritalStatus}"/>",
			constellation: "<c:out value="${userInfo.constellation}"/>"
		});
		p.init();
	});
	</script>
	
	<script id="SelectOptionImpl" type="text/x-jsrender"> 
	{{if showAll==true}}
    <option value="{{:allValue}}">{{:allDesc}}</option>
	{{/if}}
    {{for options ~defaultValue=defaultValue}}
        <option value="{{:paramValue}}"  {{if ~defaultValue==paramValue}} selected {{/if}}>{{:paramDesc}}</option>
    {{/for}}
	</script>
	
	<script id="IndustrySelectOptionImpl" type="text/x-jsrender"> 
	{{if showAll==true}}
    <option value="{{:allValue}}">{{:allDesc}}</option>
	{{/if}}
    {{for options ~defaultValue=defaultValue}}
        <option value="{{:industryCode}}"  {{if ~defaultValue==industryCode}} selected {{/if}}>{{:industryName}}</option>
    {{/for}}
	</script>
	
	<script id="AbroadCountrySelectOptionImpl" type="text/x-jsrender"> 
	{{if showAll==true}}
    <option value="{{:allValue}}">{{:allDesc}}</option>
	{{/if}}
    {{for options ~defaultValue=defaultValue}}
        <option value="{{:countryCode}}"  {{if ~defaultValue==countryCode}} selected {{/if}}>{{:countryCode}}-{{:countryName}}</option>
    {{/for}}
	</script>
	
	<script id="SexImpl" type="text/x-jsrender"> 
	<p>
		<span sex="1" class="{{if sex==1}}on{{/if}}">
			<img src="//static.tfeie.com/images/boy.png" />
		</span>
		<span sex="2" class="{{if sex==2}}on{{/if}}">
			<img src="//static.tfeie.com/images/girl.png" />
		</span>
		<span class="in {{if sex==0}}on{{/if}}" sex="0">
			<img src="//static.tfeie.com/images/other.png" />
		</span>
	</p>
	</script>
</html>