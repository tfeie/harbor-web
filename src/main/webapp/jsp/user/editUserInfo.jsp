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
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css">
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
	<section class="top_info">
		<p class="span_file" id="P_HOMEPAGEBG">
			<img src="<c:out value="${userInfo.homePageBg}"/>" id="IMG_HOMEPAGEBG">
			<input type="hidden" id="homePageBg" value="<c:out value="${userInfo.homePageBg}"/>">
		</p>
		<section class="ip_logo">
			<p id="P_HEADICON">
				<span class="span_file"><img
					src="<c:out value="${userInfo.wxHeadimg}"/>" id="IMG_HEADICON"></span>
					<input type="hidden" id="wxHeadimg" value="<c:out value="${userInfo.wxHeadimg}"/>">
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
			<section class="xinqi left_t" id="SELECTED_INTEREST_TAGS">

			</section>

			<section class="chooes_2">
				<p class="left_t">可选兴趣标签</p>
				<ul id="UI_CAN_SELECT_INTEREST_TAGS"> 
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
			<section class="xinqi" id="SELECTED_SKILL_TAGS">
				
			</section>

			<section class="chooes_2">
				<p class="left_t">可选技能标签</p>
				<ul id="UI_CAN_SELECT_SKILL_TAGS">
				</ul>
			</section>
		</section>
		<section class="but_baoc">
			<p>
				<input type="button" value="保存" id="BTN_SUBMIT"/>
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
		src="//static.tfeie.com/js/jquery.valuevalidator.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsrender.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jsviews/jsviews.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	
	<script type="text/javascript">
	//微信API配置
	wx.config({
		debug : false,
		appId : '<c:out value="${appId}"/>',
		timestamp : <c:out value="${timestamp}"/>,
		nonceStr : '<c:out value="${nonceStr}"/>',
		signature : '<c:out value="${signature}"/>',
		jsApiList : [ 'checkJsApi', 'chooseImage', 'previewImage',
				'uploadImage', 'downloadImage' ]
	});
	
	
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
					this.getAllTags();
					this.renderSex();
				},
				
				bindEvents: function(){ 
					var _this = this;
					
					//主页背景图片上传事件绑定
					$("#P_HOMEPAGEBG").on("click",function(){
						wx.chooseImage({
							count : 1,
							sizeType: ['original'],
							success : function(res) {
								var localId = res.localIds[0]; 
								wx.uploadImage({
									localId : localId,
									isShowProgressTips : 1,
									success : function(r) {
										var mediaId = r.serverId;
										ajaxController.ajax({
											url: "../user/uploadUserHomeBgToOSS",
											type: "post",
											data: {
												mediaId: mediaId,
												userId: _this.getPropertyValue("userId")
											},
											success: function(transport){
												var imgURL  = transport.data;
												$("#homePageBg").val(imgURL);
												$("#IMG_HOMEPAGEBG").attr("src", imgURL);
											},
											failure: function(transport){
												weUI.alert({content:"主页背景修改失败"});
											}
											
										});
									},
									fail : function(res) {
										weUI.alert({content:"主页背景修改失败"});
									}
								});
							}
						});
					});
					
					//头像图片上传事件绑定
					$("#P_HEADICON").on("click",function(){
						wx.chooseImage({
							count : 1,
							sizeType: ['original'],
							success : function(res) {
								var localId = res.localIds[0]; 
								wx.uploadImage({
									localId : localId,
									isShowProgressTips : 1,
									success : function(r) {
										var mediaId = r.serverId;
										ajaxController.ajax({
											url: "../user/uploadUserHeadIconToOSS",
											type: "post",
											data: {
												mediaId: mediaId,
												userId: _this.getPropertyValue("userId")
											},
											success: function(transport){
												var imgURL  = transport.data;
												$("#wxHeadimg").val(imgURL);
												$("#IMG_HEADICON").attr("src", imgURL);
											},
											failure: function(transport){
												weUI.alert({content:"头像修改失败"});
											}
											
										});
									},
									fail : function(res) {
										weUI.alert({content:"头像修改失败"});
									}
								});
							}
						});
					});
					
					//提交事件绑定
					$("#BTN_SUBMIT").on("click",function(){
						_this.submit();
					});
					
					//性别选择事件代理
					$("#SEX_SELECT").delegate("span","click",function(){
						$(this).parents("p").find("span").removeClass("on")
						$(this).addClass("on")
					});
					
					//已选兴趣标签的删除事件代理
					$("#SELECTED_INTEREST_TAGS").delegate("[name='IMG_DEL']","click",function(){
						var tagName = $(this).attr("tagName");
						//从已经选择的兴趣标签列表中删除此标签
						_this.deleteSelectedInterestTags(tagName);
					});
					
					//可选择兴趣标签的选择添加事件代理
					$("#UI_CAN_SELECT_INTEREST_TAGS").delegate("[name='LI_ADD_TAG']","click",function(){
						var tagName = $(this).attr("tagName");
						_this.addNewSelectInterestTag(tagName);
					});
					
					//自定义兴趣标签绑定事件
					$("#UI_CAN_SELECT_INTEREST_TAGS").delegate("[name='IMG_CUSTOMIZE_TAG_ADD']","click",function(){
						if(_this.selectedInterestTags.length==5){
							weUI.alert({content:"最多只能选择5个兴趣标签"});
							return ;
						}
						var content = "<section class=\"par_name\">";
						content +="<p class=\"boss\">";
						content +="<input type=\"text\" id=\"CUSTOMIZE_INTEREST_TAGS\" placeholder=\"请输入一个标签:4个字符以内\">";
						content +="</p>";
						content +="</section>";
						content +="<div class=\"message-err\" id=\"_customized_interest_tag_error\"></div>";
						weUI.confirm({
							title: "请自定义一个标签",
							content: content,
							ok: function(){
								var tagName =$.trim($("#CUSTOMIZE_INTEREST_TAGS").val());
								var valueValidator = new $.ValueValidator();
								valueValidator.addRule({
									labelName: "标签名称",
									fieldName: "tagName",
									getValue: function(){
										return tagName;
									},
									fieldRules: {
										required: true, 
										cnlength: 8
									},
									ruleMessages: {
										required: "请输入标签名称", 
										cnlength:"标签名称不能超过4个汉字"
									}
								});
								if(_this.selectedInterestTags.length==5){
									$("#_customized_interest_tag_error").html("<p><span>X</span>最多只能选择5个兴趣标签</p>").show();
									return;
								}else{
									$("#_customized_interest_tag_error").hide();
								}
								var exists=_this.existsTagName(tagName,_this.selectedInterestTags,_this.interestAllTags);
								if(exists){
									$("#_customized_interest_tag_error").html("<p><span>X</span>标签名称重复</p>").show();
									return;
								}else{
									$("#_customized_interest_tag_error").hide();
								}
								
								var res=valueValidator.fireRulesAndReturnFirstError();
								if(res){
									$("#_customized_interest_tag_error").html("<p><span>X</span>"+res+"</p>").show();
									return;
								} else{
									$("#_customized_interest_tag_error").hide();
								}
								//添加到待选标签库
								var newTag = {
									tagId: "",
									tagType: "10",//20-技能标签
									tagName: tagName,
									tagCat: "11" //11为自定义标签
								};
								_this.selectedInterestTags.push(newTag);
								
								//渲染已选技能标签
								_this.renderSelectedInterestTags(_this.selectedInterestTags);
								
								//关闭窗口
								weUI.closeConfirm();
							}
						
						}); 
					});
					
					//自定义技能标签绑定事件
					$("#UI_CAN_SELECT_SKILL_TAGS").delegate("[name='IMG_CUSTOMIZE_TAG_ADD']","click",function(){
						if(_this.selectedSkillTags.length==5){
							weUI.alert({content:"最多只能选择5个技能标签"});
							return ;
						}
						var content = "<section class=\"par_name\">";
						content +="<p class=\"boss\">";
						content +="<input type=\"text\" id=\"CUSTOMIZE_SKILL_TAGS\" placeholder=\"请输入一个标签:4个字符以内\">";
						content +="</p>";
						content +="</section>";
						content +="<div class=\"message-err\" id=\"_customized_skill_tag_error\"></div>";
						weUI.confirm({
							title: "请自定义一个标签",
							content: content,
							ok: function(){
								var tagName =$.trim($("#CUSTOMIZE_SKILL_TAGS").val());
								var valueValidator = new $.ValueValidator();
								valueValidator.addRule({
									labelName: "标签名称",
									fieldName: "tagName",
									getValue: function(){
										return tagName;
									},
									fieldRules: {
										required: true, 
										cnlength: 8
									},
									ruleMessages: {
										required: "请输入标签名称", 
										cnlength:"标签名称不能超过4个汉字"
									}
								});
								if(_this.selectedSkillTags.length==5){
									$("#_customized_skill_tag_error").html("<p><span>X</span>最多只能选择5个技能标签</p>").show();
									return;
								}else{
									$("#_customized_skill_tag_error").hide();
								}
								var exists=_this.existsTagName(tagName,_this.selectedSkillTags,_this.skillAllTags);
								if(exists){
									$("#_customized_skill_tag_error").html("<p><span>X</span>标签名称重复</p>").show();
									return;
								}else{
									$("#_customized_skill_tag_error").hide();
								}
								var res=valueValidator.fireRulesAndReturnFirstError();
								if(res){
									$("#_customized_skill_tag_error").html("<p><span>X</span>"+res+"</p>").show();
									return;
								} else{
									$("#_customized_skill_tag_error").hide();
								}
								//添加到待选标签库
								var newTag = {
									tagId: "",
									tagType: "20",//20-技能标签
									tagName: tagName,
									tagCat: "11" //11为自定义标签
								};
								_this.selectedSkillTags.push(newTag);
								
								//渲染已选技能标签
								_this.renderSelectedSkillTags(_this.selectedSkillTags);
								
								//关闭窗口
								weUI.closeConfirm();
							}
						
						}); 
					});
					
					
					//已选技能标签的删除事件代理
					$("#SELECTED_SKILL_TAGS").delegate("[name='IMG_DEL']","click",function(){
						var tagName = $(this).attr("tagName");
						//从已经选择的兴趣标签列表中删除此标签
						_this.deleteSelectedSkillTags(tagName);
					});
					
					//可选择技能标签的选择添加事件代理
					$("#UI_CAN_SELECT_SKILL_TAGS").delegate("[name='LI_ADD_TAG']","click",function(){
						var tagName = $(this).attr("tagName");
						_this.addNewSelectSkillTag(tagName);
					});
					
					
				},
				
				//判断标签是否存在已选和备选
				existsTagName: function(tagName,selectedtags,alltags){
					var queryTags=$.grep(selectedtags,function(o,i){
						return o.tagName==tagName;
					});
					if(queryTags && queryTags.length>0){
						return true;
					}
					queryTags=$.grep(alltags,function(o,i){
						return o.tagName==tagName;
					});
					if(queryTags && queryTags.length>0){
						return true;
					}
					return false;
				},
				
				//选择兴趣标签
				addNewSelectInterestTag: function(tagName){
					var _this = this;
					if(_this.selectedInterestTags.length>=5){
						weUI.alert({content:"最多只能选择5个兴趣标签"});
						return ;
					}
					//从待选列表中标记已经被选
					var queryTags=$.grep(_this.interestAllTags,function(o,i){
						return o.tagName==tagName;
					});
					if(queryTags && queryTags.length>0){
						var currentTag = queryTags[0];
						currentTag.selected = true;
						
						//追加到已选列表
						var newTag = {
							tagId: currentTag.tagId,
							tagType: currentTag.tagType,
							tagName: currentTag.tagName,
							tagCat: currentTag.tagCat
						};
						_this.selectedInterestTags.push(newTag);
					}
					//渲染可选与备选区
					_this.renderSelectedInterestTags(_this.selectedInterestTags);
					_this.renderCanSelecteInterestTags(_this.interestAllTags);
				},
				
				//删除已经选择的兴趣标签
				deleteSelectedInterestTags: function(tagName){
					var _this = this;
					var datas=_this.selectedInterestTags;
					if(datas.length-1==0){ 
						weUI.alert({content:"请至少保留1个兴趣标签"});
						return ;
					}
					var tags=$.grep(datas,function(o,i){
						return o.tagName==tagName;
					});
					if(!tags || tags.length==0)return;
					var tag = tags[0];
					datas.splice($.inArray(tag,datas),1);
					
					//将所选择的系统级的兴趣标签回退到可选标签库
					var alltags = _this.interestAllTags;
					var tags2=$.grep(alltags,function(o,i){
						return o.tagName==tagName;
					});
					if(tags2 && tags2.length>0){
						//如果删除的标签是系统内置标签，则修改选择状态
						var t = tags2[0];
						t.selected = false;
					}
					//渲染页面
					_this.renderSelectedInterestTags(datas);
					_this.renderCanSelecteInterestTags(alltags);
				},
				
				
				//选择添加技能标签
				addNewSelectSkillTag: function(tagName){
					var _this = this;
					if(_this.selectedSkillTags.length>=5){ 
						weUI.alert({content:"最多只能选择5个技能标签"});
						return ;
					}
					//从待选列表中标记已经被选
					var queryTags=$.grep(_this.skillAllTags,function(o,i){
						return o.tagName==tagName;
					});
					if(queryTags && queryTags.length>0){
						var currentTag = queryTags[0];
						currentTag.selected = true;
						
						//追加到已选列表
						var newTag = {
							tagId: currentTag.tagId,
							tagType: currentTag.tagType,
							tagName: currentTag.tagName,
							tagCat: currentTag.tagCat
						};
						_this.selectedSkillTags.push(newTag);
					}
					//渲染可选与备选区
					_this.renderSelectedSkillTags(_this.selectedSkillTags);
					_this.renderCanSelecteSkillTags(_this.skillAllTags);
				},
				
				//删除已经选择的技能标签
				deleteSelectedSkillTags: function(tagName){
					var _this = this;
					var datas=_this.selectedSkillTags;
					if(datas.length-1==0){
						weUI.alert({content:"请至少保留1个技能标签"});
						return ;
					}
					var tags=$.grep(datas,function(o,i){
						return o.tagName==tagName;
					});
					if(!tags || tags.length==0)return;
					var tag = tags[0];
					datas.splice($.inArray(tag,datas),1);
					
					//将所选择的系统级的技能标签回退到可选标签库
					var alltags = _this.skillAllTags;
					var tags2=$.grep(alltags,function(o,i){
						return o.tagName==tagName;
					});
					if(tags2 && tags2.length>0){
						//如果删除的标签是系统内置标签，则修改选择状态
						var t = tags2[0];
						t.selected = false;
					}
					//渲染页面
					_this.renderSelectedSkillTags(datas);
					_this.renderCanSelecteSkillTags(alltags);
				},
				
				
				
				renderSex: function(){
					var sex = this.getPropertyValue("sex");
					var opt=$("#SexImpl").render({sex:sex});
					$("#SEX_SELECT").append(opt);
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
							_this.skillAllTags=data["skillAllTags"]?data["skillAllTags"]:[];
							_this.interestAllTags=data["interestAllTags"]?data["interestAllTags"]:[];
							_this.selectedSkillTags=data["selectedSkillTags"]?data["selectedSkillTags"]:[];
							_this.selectedInterestTags=data["selectedInterestTags"]?data["selectedInterestTags"]:[];
							
							_this.renderCanSelecteSkillTags(data["skillAllTags"]);
							_this.renderCanSelecteInterestTags(data["interestAllTags"]);
							_this.renderSelectedSkillTags(data["selectedSkillTags"]);
							_this.renderSelectedInterestTags(data["selectedInterestTags"]);
						},
						failure: function(transport){ 
							_this.renderCanSelecteSkillTags([]);
							_this.renderCanSelecteInterestTags([]);
							_this.renderSelectedSkillTags([]);
							_this.renderSelectedInterestTags([]);
						}
					});
				},
				
				renderCanSelecteInterestTags: function(tags){
					var d = {
						tags: tags?tags:[]
					}
					var opt=$("#CanSelectSysTagImpl").render(d);
					$("#UI_CAN_SELECT_INTEREST_TAGS").html(opt);
				},
				
				renderCanSelecteSkillTags: function(tags){
					var d = {
						tags: tags?tags:[]
					}
					var opt=$("#CanSelectSysTagImpl").render(d);
					$("#UI_CAN_SELECT_SKILL_TAGS").html(opt);
				},
				
				renderSelectedSkillTags: function(tags){
					var d = {
						title: "已选技能标签",
						count: tags?tags.length:0,
						tags: tags?tags:[]
					}
					var opt=$("#SelectedTagImpl").render(d);
					$("#SELECTED_SKILL_TAGS").html(opt);
				},
				
				renderSelectedInterestTags: function(tags){
					var d = {
						title: "已选兴趣标签",
						count: tags?tags.length:0,
						tags: tags?tags:[]
					}
					var opt=$("#SelectedTagImpl").render(d);
					$("#SELECTED_INTEREST_TAGS").html(opt);
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
				
				submit: function(){
					var _this=this;
					//取值
					var homePageBg = $("#homePageBg").val();
					var wxHeadimg = $("#wxHeadimg").val();
					var enName = $.trim($("#enName").val());
					var sex = $("#SEX_SELECT").find("span.on").attr("sex");
					var abroadCountry=$("#abroadCountry").val();
					var abroadUniversity = $.trim($("#abroadUniversity").val());
					var signature=$.trim($("#signature").val());
					var maritalStatus = $("#maritalStatus").val();
					var constellation = $("#constellation").val();
					var industry= $("#industry").val();
					var mobilePhone = $.trim($("#mobilePhone").val());
					var company= $.trim($("#company").val());
					var title= $.trim($("#title").val());
					
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "英文名",
						fieldName: "enName",
						getValue: function(){
							return enName;
						},
						fieldRules: {
							required: true,
							regexp: /^[A-Za-z][A-Za-z\s]*[A-Za-z]$/,
							cnlength: 10
						},
						ruleMessages: {
							required: "请输入英文名",
							regexp:"英文名只能是字母",
							cnlength:"英文名长度不能超过10个字符"
						}
					}).addRule({
						labelName: "性别",
						fieldName: "sex",
						getValue: function(){
							return sex;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择性别"
						}
					}).addRule({
						labelName: "留学学校",
						fieldName: "abroadUniversity",
						getValue: function(){
							return abroadUniversity;
						},
						fieldRules: {
							required: true,
							cnlength: 120
						},
						ruleMessages: {
							required: "请输入留学学校",
							cnlength:"留学学校长度不能超过120个字符"
						}
					}).addRule({
						labelName: "留学国家",
						fieldName: "abroadCountry",
						getValue: function(){
							return abroadCountry;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择留学国家"
						}
					}).addRule({
						labelName: "个性签名",
						fieldName: "signature",
						getValue: function(){
							return signature;
						},
						fieldRules: {
							required: true,
							cnlength: 50
						},
						ruleMessages: {
							required: "请填写个性签名",
							cnlength:"个性签名长度不能超过50个字符"
						}
					}).addRule({
						labelName: "所在行业",
						fieldName: "industry",
						getValue: function(){
							return industry;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择所在行业"
						}
					}).addRule({
						labelName: "手机号码",
						fieldName: "mobilePhone",
						getValue: function(){
							return mobilePhone;
						},
						fieldRules: {
							required: true,
							phonenumber:true
						},
						ruleMessages: {
							required: "请输入手机号码",
							phonenumber:"手机号码格式不正确"
						}
					}).addRule({
						labelName: "就职公司",
						fieldName: "company",
						getValue: function(){
							return company;
						},
						fieldRules: { 
							cnlength: 60
						},
						ruleMessages: {
							cnlength:"公司名不能超过60个字符或30个汉字"
						}
					}).addRule({
						labelName: "职位",
						fieldName: "title",
						getValue: function(){
							return title;
						},
						fieldRules: { 
							cnlength: 40
						},
						ruleMessages: {
							cnlength:"头衔不能超过40个字符或20个汉字"
						}
					});
					
					var res=valueValidator.fireRulesAndReturnFirstError();
					if(res){
						weUI.alert({content:res});
						return;
					}
					
					var data={
						userId: _this.getPropertyValue("userId"),
						wxOpenid: _this.getPropertyValue("wxOpenid"),
						wxHeadimg: wxHeadimg,
						homePageBg: homePageBg,
						enName: enName,
						sex: sex,
						abroadCountry: abroadCountry,
						abroadUniversity: abroadUniversity,
						maritalStatus: maritalStatus,
						constellation: constellation,
						signature: signature,
						mobilePhone: mobilePhone,
						company: company,
						industry: industry,
						title: title,  
						interestSelectedTags: _this.selectedInterestTags,
						skillSelectedTags: _this.selectedSkillTags
					}
					
					ajaxController.ajax({
						url: "../user/submitUserEdit",
						type: "post", 
						data: {
							userData: JSON.stringify(data)
						},
						success: function(transport){
							weUI.alert({
								content: "资料修改成功"
							})
						},
						failure: function(transport){
							weUI.alert({
								content: "资料修改失败"
							})
						}
						
					});
					
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
			wxOpenid: "<c:out value="${openId}"/>",
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
	
	<script id="CanSelectSysTagImpl" type="text/x-jsrender"> 
	{{for tags}}
	{{if selected==false}}
	<li name="LI_ADD_TAG" tagName="{{:tagName}}"><a>{{:tagName}}</a></li> 
	{{/if}}
	{{/for}}
	<li class="on">
		<a name="IMG_CUSTOMIZE_TAG_ADD"><img src="//static.tfeie.com/images/icon15.png" /></a>
	</li>
	</script>
	
	<script id="SelectedTagImpl" type="text/x-jsrender"> 	
	<p class="left_t">
		{{:title}}<i><em>{{:count}}</em>/5</i>
	</p>
	<ul>
		{{for tags}}
		<li>
			<div class="xinqi_1">
				<p>
					<a>{{:tagName}}</a>
				</p>
				<div class="det">
					<p>
						<img name="IMG_DEL" src="//static.tfeie.com/images/icon16.png" tagName="{{:tagName}}"/>
					</p>
				</div>
			</div>
		</li>
		{{/for}}
	</ul>
	<div class="clear"></div>
	</script>
</html>