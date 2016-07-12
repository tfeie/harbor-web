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
<title>发布G&O</title>
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
<script type="text/javascript" src="<%=_base%>/js/jedate/jedate.js"></script>

</head>
<body class="body">
	<section class="fabu_go">
		<section class="fabu_zhuti diyi">
			<p>发布主题</p>
		</section>
		<section class="geizhuti">
			<p>
				<input type="text" placeholder="请给个Sexy的主题" id="topic">
			</p>
		</section>
		<section class="fabu_zhuti dier">
			<p>活动信息</p>
		</section>
		<section class="act_info">
			<p>
				<span class="on" name="goType" goType="group">Group邀请<input
					type="text" placeholder="5-6" id="inviteMembers" />人
				</span> <span name="goType" goType="oneonone">One on One</span>
			</p>
		</section>
		<section class="inp_time">
			<p>
				<span><input class="datainp" id="expectedStartTime" type="text" placeholder="请选择"  readonly><!-- <input type="text" placeholder="2016-5-25 10:00 " id="expectedStartTime"
					class="datepicker" /> --></span><label><input type="text"
					placeholder="约一个小时" id="expectedDuration"/></label>
			</p> 
		</section>
		<section class="me_qingke">
			<p name="payMode" payMode="10">
				固定费用<input type="text" id="price" placeholder="">元/人
			</p>
			<p name="payMode" payMode="20">
				A A 预付<input type="text" id="price" placeholder="150">元/人<span>多退少补</span>
			</p>
			<p name="payMode" payMode="30">我请客</p>
		</section>
		<section class="online_no">
			<p>
				<span name="orgMode" orgMode="offline" class="on">线下服务</span><span name="orgMode" orgMode="online">在线服务</span>
			</p>
			<p id="p_location">
				<input type="text" placeholder="北京中关村附近" id="location"/>
			</p>
		</section>
		<section class="fabu_zhuti disan">
			<p>活动详情</p>
		</section>

		<section class="add_edit" id="SECTION_GO_DETAILS">

		</section>

		<section class="fabu_but">
			<p>
				<span class="in" id="SPAN_ADD_IMAGE"><a>添加图片</a></span><span class="on"  id="SPAN_ADD_TEXT"><a>添加文本</a></span>
			</p>
		</section>
		<div class="clear"></div>

		<section class="fabu_zhuti disi">
			<p>标签</p>
		</section>

		<section class="lat_xuanz">
			<section class="fabu_biaoqian" id="SELECTED_GO_TAGS">

			</section>
			<section class="chooes_2 fabu">
				<p>可选标签</p>
				<ul id="UI_CAN_SELECT_GO_TAGS">
					
				</ul>
			</section>
		</section>

		<section class="fabu_zhuti diwu" name="SELECTION_MYSTORY" style="display:none">
			<p>我的故事</p>
		</section>
		<section class="my_gushi" name="SELECTION_MYSTORY" style="display:none">
			<p>
				<textarea placeholder="请说说关于这个主题你的故事…" id="myStory"></textarea>
			</p>
		</section>

		<section class="sec_btn2 fabu">
			<input type="button" value="发布" id="BTN_SUBMIT">
		</section>

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
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
jeDate({
	dateCell:"#expectedStartTime",
	format:"YYYY-MM-DD hh:mm",
	//isinitVal:true,
	isTime:true, //isClear:false,
	minDate:jeDate.now(0),
})
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
		$.PublishGoPage = function(data){
			this.settings = $.extend(true,{},$.PublishGoPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.PublishGoPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData(); 
					this.initRenders();
				},
				
				bindEvents: function(){
					var _this = this; 
					
					//活动类型选择事件
					$("[name='goType']").on("click",function(){
						$("[name='goType']").removeClass("on");
						$(this).addClass("on");
						var goType = $(this).attr("goType");
						if(goType=="oneonone"){
							$("#expectedStartTime").hide();
							$("[name='payMode']").each(function(i,o){
								var payMode =$(this).attr("payMode");
								if(payMode=="10"){
									$(this).addClass("on").show();
								}else{
									$(this).removeClass("on").hide();
								}
							});
							$("[name='SELECTION_MYSTORY']").show();
						}else if(goType=="group"){
							$("#expectedStartTime").show();
							$("[name='payMode']").show();
							$("[name='SELECTION_MYSTORY']").hide();
						}
					});
					
					//付费模式
					$("[name='payMode']").on("click",function(){
						$("[name='payMode']").removeClass("on");
						$(this).addClass("on");
					});
					
					//组织形式
					$("[name='orgMode']").on("click",function(){
						$("[name='orgMode']").removeClass("on");
						$(this).addClass("on");
						
						var orgMode = $(this).attr("orgMode");
						if(orgMode=="offline"){
							$("#p_location").show();
						}else{
							$("#p_location").hide();
						}
					});
					
					//添加图片按钮事件
					$("#SPAN_ADD_IMAGE").on("click",function(){
						_this.godetails.push({
							_id: new Date().getTime(),
							type: "image",
							imageUrl:""
						});
						//渲染详情页面
						_this.renderGoDetails();
					});
					
					//添加文字按钮事件
					$("#SPAN_ADD_TEXT").on("click",function(){
						_this.godetails.push({
							_id: new Date().getTime(),
							type: "text",
							detail:""
						});
						//渲染详情页面
						_this.renderGoDetails();
					});
					
					//活动明细图文删除事件代理
					$("#SECTION_GO_DETAILS").delegate("[name='SECTION_DEL_GO_DETAIL']","click",function(){
						var _id =$(this).attr("_id");
						_this.deleteGoDetail(_id);
					});
					
					//活动明细文本框失去焦点事件代理
					$("#SECTION_GO_DETAILS").delegate("[name='GO_DETAIL_TEXTAREA']","blur",function(){
						var _id =$(this).attr("_id");
						var val = $(this).val();
						_this.modifyGoDetail(_id,val,"");
					}); 
					
					//图片上传服务
					$("#SECTION_GO_DETAILS").delegate("[name='P_GO_UPLOAD_IMG']","click",function(){
						var _id =$(this).attr("_id");
						var s = this;
						wx.chooseImage({
							count : 1,
							sizeType: ['compressed'],
							success : function(res) {
								var localId = res.localIds[0]; 
								wx.uploadImage({
									localId : localId,
									isShowProgressTips : 1,
									success : function(r) {
										var mediaId = r.serverId;
										ajaxController.ajax({
											url: "../go/uploadGoImgToOSS",
											type: "post",
											data: {
												mediaId: mediaId,
												userId: _this.getPropertyValue("userId")
											},
											success: function(transport){
												var imgURL  = transport.data;
												$(s).find("#IMG_GO").attr("src", imgURL);
												_this.modifyGoDetail(_id,"",imgURL);
											},
											failure: function(transport){
												weUI.alert({content:"图片上传失败"});
											}
											
										});
									},
									fail : function(res) {
										weUI.alert({content:"图片上传失败"});
									}
								});
							}
						});
					}); 
					
					//提交按钮
					$("#BTN_SUBMIT").on("click",function(){
						_this.submit();
					}); 
					//已选标签的删除事件代理
					$("#SELECTED_GO_TAGS").delegate("[name='TAG_DEL']","click",function(){
						var tagName = $(this).attr("tagName");
						//从已经选择标签列表中删除此标签
						_this.deleteSelectedGoTags(tagName);
					});
					
					//可选标签的选择添加事件代理
					$("#UI_CAN_SELECT_GO_TAGS").delegate("[name='LI_ADD_TAG']","click",function(){
						var tagName = $(this).attr("tagName");
						_this.addNewGoTag(tagName);
					});
					
					//自定义标签绑定事件
					$("#UI_CAN_SELECT_GO_TAGS").delegate("[name='IMG_CUSTOMIZE_TAG_ADD']","click",function(){
						if(_this.selectedGoTags.length==5){
							weUI.alert({content:"最多只能选择5个标签"});
							return ;
						} 
						var content = "<section class=\"par_name\">";
						content +="<p class=\"boss\">";
						content +="<input type=\"text\" id=\"CUSTOMIZE_GO_TAGS\" placeholder=\"请输入一个标签:4个字符以内\">";
						content +="</p>";
						content +="</section>";
						content +="<div class=\"message-err\" id=\"_customized_go_tag_error\"></div>";
						weUI.confirm({
							title: "请自定义一个标签",
							content: content,
							ok: function(){
								var tagName =$.trim($("#CUSTOMIZE_GO_TAGS").val());
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
								if(_this.selectedGoTags.length==5){
									$("#_customized_go_tag_error").html("<p><span>X</span>最多只能选择5个标签</p>").show();
									return;
								}else{
									$("#_customized_go_tag_error").hide();
								}
								var exists=_this.existsTagName(tagName,_this.selectedGoTags,_this.allGoTags);
								if(exists){
									$("#_customized_go_tag_error").html("<p><span>X</span>标签名称重复</p>").show();
									return;
								}else{
									$("#_customized_go_tag_error").hide();
								}
								
								var res=valueValidator.fireRulesAndReturnFirstError();
								if(res){
									$("#_customized_go_tag_error").html("<p><span>X</span>"+res+"</p>").show();
									return;
								} else{
									$("#_customized_go_tag_error").hide();
								}
								//添加到待选标签库
								var newTag = {
									tagId: "",
									tagType: "40",//40-GO标签
									tagName: tagName,
									tagCat: "11" //11为自定义标签
								};
								_this.selectedGoTags.push(newTag);
								
								//渲染已选技能标签
								_this.renderSelectedGoTags();
								
								//关闭窗口
								weUI.closeConfirm();
							}
						
						}); 
					});
					
				},
				
				initData: function(){ 
					this.selectedGoTags=[];
					this.godetails=[{
						_id: new Date().getTime(),
						type: "text",
						detail:""
					}];
					this.getAllTags(); 
				},
				
				initRenders: function(){
					this.renderSelectedGoTags();
					this.renderGoDetails();
				},
				
				getAllTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getGoSystemTags",
						type: "post", 
						data: { 
						},
						success: function(transport){
							var data =transport.data;
							_this.allGoTags=data["allGoTags"]?data["allGoTags"]:[]; 
							_this.renderCanSelecteGoTags(); 
						},
						failure: function(transport){ 
							_this.renderCanSelecteGoTags(); 
						}
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
				
				renderCanSelecteGoTags: function(){
					var _this = this;
					var d = {
						tags: _this.allGoTags?_this.allGoTags:[]
					}
					var opt=$("#CanSelectSysTagImpl").render(d);
					$("#UI_CAN_SELECT_GO_TAGS").html(opt);
				},
				
				renderSelectedGoTags: function(){
					var tags =this.selectedGoTags?this.selectedGoTags:[];
					var d = {
						title: "已选标签",
						count: tags?tags.length:0,
						tags: tags
					}
					var opt=$("#SelectedTagImpl").render(d);
					$("#SELECTED_GO_TAGS").html(opt);
				},
				
				addNewGoTag: function(tagName){
					var _this = this;
					if(_this.selectedGoTags.length>=5){ 
						weUI.alert({content:"最多只能选择5个标签"});
						return ;
					}
					//从待选列表中标记已经被选
					var queryTags=$.grep(_this.allGoTags,function(o,i){
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
						_this.selectedGoTags.push(newTag);
					}
					//渲染可选与备选区
					_this.renderSelectedGoTags();
					_this.renderCanSelecteGoTags();
					
				},
				
				deleteSelectedGoTags: function(tagName){
					var _this = this;
					var datas=_this.selectedGoTags;
					if(datas.length-1==0){
						weUI.alert({content:"请至少保留1个标签"});
						return ;
					}
					var tags=$.grep(datas,function(o,i){
						return o.tagName==tagName;
					});
					if(!tags || tags.length==0)return;
					var tag = tags[0];
					datas.splice($.inArray(tag,datas),1);
					
					//将所选择的系统级的技能标签回退到可选标签库
					var alltags = _this.allGoTags;
					var tags2=$.grep(alltags,function(o,i){
						return o.tagName==tagName;
					});
					if(tags2 && tags2.length>0){
						//如果删除的标签是系统内置标签，则修改选择状态
						var t = tags2[0];
						t.selected = false;
					}
					//渲染页面
					_this.renderSelectedGoTags();
					_this.renderCanSelecteGoTags();
					
				},
				
				modifyGoDetail: function(_id,val,url){
					var _this = this;
					var queryDetails = $.grep(_this.godetails,function(o,i){
						return o._id==_id;
					});
					if(queryDetails.length==0){
						return;
					}
					var d = queryDetails[0];
					if(d.type=="text"){
						d.detail = val;
					}else {
						d.imageUrl = url;
					}
				},
				
				deleteGoDetail: function(_id){
					var _this = this;
					if(_this.godetails.length==1){
						weUI.alert({content:"请至少保留一项活动详情"});
						return;
					}
					var queryDetails = $.grep(_this.godetails,function(o,i){
						return o._id==_id;
					});
					if(queryDetails.length==0){
						return;
					}
					var d = queryDetails[0];
					_this.godetails.splice($.inArray(d,_this.godetails),1);
					_this.renderGoDetails();
				},
				
				renderGoDetails: function(){
					var godetails =this.godetails?this.godetails:[];
					var d = { 
						godetails: godetails
					}
					var opt=$("#GoDetailsImpl").render(d);
					$("#SECTION_GO_DETAILS").html(opt);
				},
				
				submit: function(){
					var _this = this;
					var topic = $.trim($("#topic").val());
					var goType = $.trim($("[name='goType'].on").attr("goType"));
					var inviteMembers = $.trim($("#inviteMembers").val());
					
					var expectedStartTime = $.trim($("#expectedStartTime").val());
					var expectedDuration = $.trim($("#expectedDuration").val());
					var payMode = $.trim($("[name='payMode'].on").attr("payMode"));
					var price =  $.trim($("[name='payMode'].on").find("#price").val());
					var orgMode = $.trim($("[name='orgMode'].on").attr("orgMode"));
					var location = $.trim($("#location").val());
					var myStory = $.trim($("#myStory").val()); 
					//绑定规则
					var valueValidator = new $.ValueValidator();
					valueValidator.addRule({
						labelName: "发布主题",
						fieldName: "topic",
						getValue: function(){
							return topic;
						},
						fieldRules: {
							required: true, 
							cnlength: 120
						},
						ruleMessages: {
							required: "请填写发布主题",
							cnlength:"发布主题不能超过60个汉字"
						}
					}).addRule({
						labelName: "活动类型",
						fieldName: "goType",
						getValue: function(){
							return goType;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择活动类型"
						}
					});
					if(goType=="group"){
						valueValidator.addRule({
							labelName: "邀请人数",
							fieldName: "inviteMembers",
							getValue: function(){
								return inviteMembers;
							},
							fieldRules: {
								required: true,
								cnlength: 50
							},
							ruleMessages: {
								required: "请输入邀请人数(如:5-8)",
								cnlength: "邀请人数不操作25个汉字"
							}
						}).addRule({
							labelName: "预计开始时间",
							fieldName: "expectedStartTime",
							getValue: function(){
								return expectedStartTime;
							},
							fieldRules: {
								required: true, 
								datetime: true
							},
							ruleMessages: {
								required: "请选择预期开始时间",
								datetime:"预期开始时间格式必须是yyyy-MM-dd hh:mm:ss"
							}
						});
					}
					valueValidator.addRule({
						labelName: "预期持续时间",
						fieldName: "expectedDuration",
						getValue: function(){
							return expectedDuration;
						},
						fieldRules: {
							required: true, 
							cnlength: 10
						},
						ruleMessages: {
							required: "请填写预期持续时间",
							cnlength:"长度约为5个汉字。如:约1.5小时"
						}
					}).addRule({
						labelName: "付费方式",
						fieldName: "payMode",
						getValue: function(){
							return payMode;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择付费方式"
						}
					});
					if(payMode=="10" || payMode=="20"){
						valueValidator.addRule({
							labelName: "费用",
							fieldName: "price",
							getValue: function(){
								return price;
							},
							fieldRules: {
								required: true, 
								moneyNumber: true
							},
							ruleMessages: {
								required: "请填写费用",
								moneyNumber:"费用(单位:元)格式不正确。如:100.00"
							}
						});
					}
					valueValidator.addRule({
						labelName: "活动组织形式",
						fieldName: "orgMode",
						getValue: function(){
							return orgMode;
						},
						fieldRules: {
							required: true
						},
						ruleMessages: {
							required: "请选择线上或线下"
						}
					});
					
					if(orgMode=="offline"){
						valueValidator.addRule({
							labelName: "活动地址",
							fieldName: "location",
							getValue: function(){
								return location;
							},
							fieldRules: {
								required: true, 
								cnlength: 300
							},
							ruleMessages: {
								required: "请填写活动线下举办地址",
								cnlength:"活动地址最多输入150个汉字"
							}
						});
					}
					valueValidator.addRule({
						labelName: "活动明细",
						fieldName: "godetails",
						getValue: function(){
							return _this.godetails;
						},
						fieldRules: {
							minlength: 1
						},
						ruleMessages: {
							minlength: "活动明细至少填写一个"
						}
					}).addRule({
						labelName: "标签",
						fieldName: "tags",
						getValue: function(){
							return _this.selectedGoTags;
						},
						fieldRules: {
							rangelength: [1,5]
						},
						ruleMessages: {
							rangelength: "活动标签至少选择1个，最多选择5个"
						}
					});
					if(goType=="oneonone"){
						valueValidator.addRule({
							labelName: "我的故事",
							fieldName: "myStory",
							getValue: function(){
								return myStory;
							},
							fieldRules: {
								required: true, 
								cnlength: 300
							},
							ruleMessages: {
								required: "请填写我的故事",
								cnlength:"我的故事最多输入150个汉字"
							}
						});
					}
					
					
					var res=valueValidator.fireRulesAndReturnFirstError();
					if(res){
						weUI.alert({content:res});
						return;
					}
					//校验活动明细 
					var queryDetails = $.grep(_this.godetails,function(o,i){
						return (o.type=="text" && o.detail=="") || (o.type=="image" && o.imageUrl=="");
					});
					if(queryDetails.length>0){
						weUI.alert({content:"您还有没有填写完成的活动内容或者要上传的活动图片"});
						return ;
					}
					
					
					var data = {
						userId: _this.getPropertyValue("userId"),
						goType: goType,
						topic: topic,
						inviteMembers: (goType=="group")?inviteMembers:"",
						expectedStartTime: (goType=="group")?expectedStartTime:"",
						expectedDuration: expectedDuration,
						payMode: payMode,
						price: (payMode=="30")?"":price,
						orgMode: orgMode,
						location: (orgMode=="online")?"":location,
						myStory: (goType=="oneonone")?myStory:"",
						goDetails: _this.godetails,
						goTags: _this.selectedGoTags
					} 
					ajaxController.ajax({
						url: "../go/submitNewGo",
						type: "post", 
						data: {
							goData: JSON.stringify(data)
						},
						success: function(transport){
							weUI.alert({
								content: "活动提交成功",
								ok: function(){
									if(goType=="group"){
										window.location.href="../go/goindex.html?goType=" + "group";
									}else{
										window.location.href="../go/goindex.html?goType=" + "one";
									}
									weUI.closeAlert();
								}
							})
						},
						failure: function(transport){
							weUI.alert({
								content: "活动提交失败"+transport.statusInfo
							})
						}
						
					});
					
				},
				
				getPropertyValue: function(propertyName){
					if(!propertyName)return;
					return this.params[propertyName];
				}
			}
		})
	})(jQuery);
	

	$(document).ready(function(){
		var p = new $.PublishGoPage({
			userId: "<c:out value="${userInfo.userId}"/>"
		});
		p.init();
	});
	
</script>

<script id="CanSelectSysTagImpl" type="text/x-jsrender"> 
	{{for tags}}
	{{if selected==false}}
	<li name="LI_ADD_TAG" tagName="{{:tagName}}"><a>{{:tagName}}</a></li> 
	{{/if}}
	{{/for}}
	<li class="on">
		<a name="IMG_CUSTOMIZE_TAG_ADD"><img src="//static.tfeie.com/images/img54.png" /></a>
	</li>
</script>

<script id="SelectedTagImpl" type="text/x-jsrender"> 	
	<p>{{:title}}（<em>{{:count}}</em>/5）</p>
	<ul>
		<li>
			<a></a>
			<section class="quxiao" tagName="">
				<img src="//static.tfeie.com/images/img50.png" />
			</section>
		</li>
		{{for tags}} 
		<li>
			<a>{{:tagName}}</a>
			<section class="quxiao" tagName="{{:tagName}}" name="TAG_DEL">
				<img src="//static.tfeie.com/images/img50.png" />
			</section>
		</li>
		{{/for}}
	</ul> 
</script>

<script id="GoDetailsImpl" type="text/x-jsrender">
	{{for godetails}} 
		{{if type=="text"}}
			<section class="zhuti_hanhua add_mask items">
				<p>
					<textarea name="GO_DETAIL_TEXTAREA"  _id="{{:_id}}" placeholder="请说说这个主题能掏些什么干货…
一.主题
二.内容
三.说明
四.注意">{{:detail}}</textarea>
				</p>
				<section class="yingchang" name="SECTION_DEL_GO_DETAIL" _id="{{:_id}}">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>
		{{/if}}
		{{if type=="image"}}
			<section class="jia_img add_mask items">
				<p name="P_GO_UPLOAD_IMG" _id="{{:_id}}">
					<img id="IMG_GO" src="{{if imageUrl=="" || imageUrl==false}}//static.tfeie.com/images/img51-1.png{{else}}{{:imageUrl}}{{/if}}">
				</p>
				<section class="yingchang on" name="SECTION_DEL_GO_DETAIL" _id="{{:_id}}">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>
		{{/if}}
	{{/for}}
</script>				
</html>