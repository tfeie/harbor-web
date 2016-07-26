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
<title>发布Be</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
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

</head>

<body>
	<section class="xjbe-main">
		<div class="xx" id="DIV_BE_DETAILS">
			
		</div>
		<div class="btn-m">
			<div class="btn-wb" id="SPAN_ADD_TEXT">添加文本</div>
			<div class="btn-img" id="SPAN_ADD_IMAGE">添加图片</div>
		</div>
		<div class="t">
			已选标签（<font id="F_SELECTED_TAG_NUMBER">0</font>/5）
		</div>
		<div class="bq-yx clearfix" id="SELECTED_BE_TAGS">
			
		</div>
		<div class="t">可选/添加标签</div>
		<div class="bq-kx clearfix" id="UI_CAN_SELECT_BE_TAGS"> 
		</div> 
		<div class="btn-fs">
			<input type="submit" class="btn" value="发射" id="BTN_SUBMIT">
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
		$.PublishBePage = function(data){
			this.settings = $.extend(true,{},$.PublishBePage.defaults);
			this.params= data?data:{}
		}
		$.extend($.PublishBePage,{
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
					
					//添加图片按钮事件
					$("#SPAN_ADD_IMAGE").on("click",function(){
						_this.bedetails.push({
							_id: new Date().getTime(),
							type: "image",
							imageUrl:""
						});
						//渲染详情页面
						_this.renderBeDetails();
					});
					
					//添加文字按钮事件
					$("#SPAN_ADD_TEXT").on("click",function(){
						_this.bedetails.push({
							_id: new Date().getTime(),
							type: "text",
							candel: true,
							detail:""
						});
						//渲染详情页面
						_this.renderBeDetails();
					});
					
					//活动明细图文删除事件代理
					$("#DIV_BE_DETAILS").delegate("[name='LI_DEL_BE_DETAIL']","click",function(){
						var _id =$(this).attr("_id");
						_this.deleteBeDetail(_id);
					});
					
					//活动明细文本框失去焦点事件代理
					$("#DIV_BE_DETAILS").delegate("[name='BE_DETAIL_TEXTAREA']","blur",function(){
						var _id =$(this).attr("_id");
						var val = $(this).val();
						_this.modifyBeDetail(_id,val,"");
					}); 
					
					//图片上传服务
					$("#DIV_BE_DETAILS").delegate("[name='LBL_BE_UPLOAD_IMG']","click",function(){
						var s = this;
						var _id =$(this).attr("_id"); 
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
										weUI.showLoadingToast("图片转存中..")
										ajaxController.ajax({
											url: "../be/uploadBeImgToOSS",
											type: "post",
											data: {
												mediaId: mediaId,
												userId: _this.getPropertyValue("userId")
											},
											success: function(transport){
												weUI.hideLoadingToast();
												weUI.showXToast("图片转存成功");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 500);
												var imgURL  = transport.data;
												$(s).find("#IMG_BE").attr("src", imgURL+"@!be_thumbnail");
												_this.modifyBeDetail(_id,"",imgURL);
											},
											failure: function(transport){
												weUI.hideLoadingToast();
												weUI.showXToast("图片转存失败");
												setTimeout(function () {
													weUI.hideXToast();
									            }, 500);
											}
											
										});
									},
									fail : function(res) {
										weUI.showXToast("图片上传失败");
										setTimeout(function () {
											weUI.hideXToast();
							            }, 500);
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
					$("#SELECTED_BE_TAGS").delegate("[name='TAG_DEL']","click",function(){
						var tagName = $(this).attr("tagName");
						//从已经选择标签列表中删除此标签
						_this.deleteSelectedBeTags(tagName);
					});
					
					//可选标签的选择添加事件代理
					$("#UI_CAN_SELECT_BE_TAGS").delegate("[name='SPAN_ADD_TAG']","click",function(){
						var tagName = $(this).attr("tagName");
						_this.addNewBeTag(tagName);
					});
					
					//自定义标签绑定事件
					$("#UI_CAN_SELECT_BE_TAGS").delegate("[name='IMG_CUSTOMIZE_TAG_ADD']","click",function(){
						if(_this.selectedBeTags.length==5){
							weUI.alert({content:"最多只能选择5个标签"});
							return ;
						}
						var content = "<div class=\"wb-m\">";
						content +="<input class=\"In-text\" type=\"text\" id=\"CUSTOMIZE_BE_TAGS\" placeholder=\"请输入一个标签:4个字符以内\">";
						content +="</div>";
						content +="<div style=\"padding-left:1em;line-height:1em;color:#ff6142;\" id=\"_customized_be_tag_error\"></div>";
						weUI.confirm({
							title: "请自定义一个标签",
							content: content,
							ok: function(){
								var tagName =$.trim($("#CUSTOMIZE_BE_TAGS").val());
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
								if(_this.selectedBeTags.length==5){
									$("#_customized_be_tag_error").html("<p>最多只能选择5个标签</p>").show();
									return;
								}else{
									$("#_customized_be_tag_error").hide();
								}
								var exists=_this.existsTagName(tagName,_this.selectedBeTags,_this.allBeTags);
								if(exists){
									$("#_customized_be_tag_error").html("<p>标签名称重复</p>").show();
									return;
								}else{
									$("#_customized_be_tag_error").hide();
								}
								
								var res=valueValidator.fireRulesAndReturnFirstError();
								if(res){
									$("#_customized_be_tag_error").html("<p>"+res+"</p>").show();
									return;
								} else{
									$("#_customized_be_tag_error").hide();
								}
								//添加到待选标签库
								var newTag = {
									tagId: "",
									tagType: "30",//40-BE标签
									tagName: tagName,
									tagCat: "11" //11为自定义标签
								};
								_this.selectedBeTags.push(newTag);
								
								//渲染已选技能标签
								_this.renderSelectedBeTags();
								
								//关闭窗口
								weUI.closeConfirm();
							}
						
						}); 
					});
					
				},
				
				initData: function(){ 
					this.selectedBeTags=[];
					this.bedetails=[{
						_id: new Date().getTime(),
						type: "text",
						candel: false,
						detail:""
					}];
					this.getAllBeTags(); 
				},
				
				initRenders: function(){
					this.renderSelectedBeTags();
					this.renderBeDetails();
				},
				
				getAllBeTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getAllBeTags",
						type: "post", 
						data: { 
						},
						success: function(transport){
							var data =transport.data;
							_this.allBeTags=data["allBeTags"]?data["allBeTags"]:[]; 
							_this.renderCanSelecteBeTags(); 
						},
						failure: function(transport){ 
							_this.renderCanSelecteBeTags(); 
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
				
				renderCanSelecteBeTags: function(){
					var _this = this;
					var d = {
						tags: _this.allBeTags?_this.allBeTags:[]
					}
					var opt=$("#CanSelectSysTagImpl").render(d);
					$("#UI_CAN_SELECT_BE_TAGS").html(opt);
				},
				
				renderSelectedBeTags: function(){
					var tags =this.selectedBeTags?this.selectedBeTags:[];
					var opt=$("#SelectedTagImpl").render(tags);
					$("#SELECTED_BE_TAGS").html(opt);
					$("#F_SELECTED_TAG_NUMBER").text(tags.length);
				},
				
				addNewBeTag: function(tagName){
					var _this = this;
					if(_this.selectedBeTags.length>=5){ 
						weUI.alert({content:"最多只能选择5个标签"});
						return ;
					}
					//从待选列表中标记已经被选
					var queryTags=$.grep(_this.allBeTags,function(o,i){
						return o.tagName==tagName;
					});
					if(queryTags && queryTags.length>0){
						var currentTag = queryTags[0];
						currentTag.selected = true;
						//alert(currentTag.polyTagId);
						//追加到已选列表
						var newTag = {
							tagId: currentTag.tagId,
							tagType: currentTag.tagType,
							tagName: currentTag.tagName,
							tagCat: currentTag.tagCat,
							polyTagId: currentTag.polyTagId
						};
						_this.selectedBeTags.push(newTag);
					}
					//渲染可选与备选区
					_this.renderSelectedBeTags();
					_this.renderCanSelecteBeTags();
					
				},
				
				deleteSelectedBeTags: function(tagName){
					var _this = this;
					var datas=_this.selectedBeTags;
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
					
					//将所选择的系统级标签回退到可选标签库
					var alltags = _this.allBeTags;
					var tags2=$.grep(alltags,function(o,i){
						return o.tagName==tagName;
					});
					if(tags2 && tags2.length>0){
						//如果删除的标签是系统内置标签，则修改选择状态
						var t = tags2[0];
						t.selected = false;
					}
					//渲染页面
					_this.renderSelectedBeTags();
					_this.renderCanSelecteBeTags();
					
				},
				
				modifyBeDetail: function(_id,val,url){
					var _this = this;
					var queryDetails = $.grep(_this.bedetails,function(o,i){
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
						d.imgThumbnailUrl=url+"@!be_thumbnail";
					}
				},
				
				deleteBeDetail: function(_id){
					var _this = this;
					if(_this.bedetails.length==1){
						weUI.alert({content:"请至少得填写一项B&E..."});
						return;
					}
					var queryDetails = $.grep(_this.bedetails,function(o,i){
						return o._id==_id;
					});
					if(queryDetails.length==0){
						return;
					}
					var d = queryDetails[0];
					_this.bedetails.splice($.inArray(d,_this.bedetails),1);
					_this.renderBeDetails();
				},
				
				renderBeDetails: function(){
					var bedetails =this.bedetails?this.bedetails:[];
					var d = { 
						bedetails: bedetails
					}
					var opt=$("#BeDetailsImpl").render(d);
					$("#DIV_BE_DETAILS").html(opt);
				},
				
				submit: function(){
					var _this = this; 
					//校验活动明细 
					var queryDetails = $.grep(_this.bedetails,function(o,i){
						return (o.type=="text" && o.detail=="") || (o.type=="image" && o.imageUrl=="");
					});
					if(queryDetails.length>0){
						weUI.showXToast("您的B&E还有没有填写的内容或者上传的图片");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 500);
						return ;
					}
					
					if(_this.selectedBeTags.length>=5){ 
						weUI.showXToast("最多只能选择5个标签");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 500);
						return;
					}
					
					if(_this.selectedBeTags.length==0){ 
						weUI.showXToast("至少选择1个标签");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 500);
						return;
					}
					
					
					var data = {
						userId: _this.getPropertyValue("userId"),
						beDetails: _this.bedetails,
						beTags: _this.selectedBeTags
					} 
					weUI.showLoadingToast("正在发布...")
					ajaxController.ajax({
						url: "../be/submitNewBe",
						type: "post", 
						data: {
							beData: JSON.stringify(data)
						},
						success: function(transport){
							weUI.hideLoadingToast();
							weUI.showXToast("发布成功，跳转到首页");
							setTimeout(function () {
								weUI.hideXToast();
								window.location.href="../be/index.html";
				            }, 500);
						},
						failure: function(transport){
							weUI.hideLoadingToast();
							var busiCode = transport.busiCode;
							var statusInfo = transport.statusInfo;
							if(busiCode=="user_unregister"){
								weUI.confirm({content:"您还没有注册,是否先注册后再发表~",ok: function(){
									window.location.href="../user/toUserRegister.html";
								}});
							}else{
								weUI.showXToast(transport.statusInfo);
								setTimeout(function () {
									weUI.hideXToast();
					            }, 500);
							}
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
		var b = new $.HarborBuilder();
		b.buildFooter();
		
		var p = new $.PublishBePage({
			userId: "<c:out value="${userInfo.userId}"/>"
		});
		p.init();
		
		
	});
</script>


<script id="CanSelectSysTagImpl" type="text/x-jsrender"> 
	{{for tags}}
	{{if selected==false}}
	<span class="list" name="SPAN_ADD_TAG" tagName="{{:tagName}}">{{:tagName}}</span>
	{{/if}}
	{{/for}}
	<span class="tj"><img src="//static.tfeie.com/v2/images/icon-img.png" width="65" height="30" name="IMG_CUSTOMIZE_TAG_ADD"></span>
</script>

<script id="SelectedTagImpl" type="text/x-jsrender"> 
	<span class="list">{{:tagName}}<i class="icon-gb"  tagName="{{:tagName}}" name="TAG_DEL"></i></span>
</script>

<script id="BeDetailsImpl" type="text/x-jsrender">
	{{for bedetails}} 
	{{if type=="text"}}
	<div class="wb-m">
		<textarea class="In-text" name="BE_DETAIL_TEXTAREA"  _id="{{:_id}}" placeholder="请填写您的B&E...">{{:detail}}</textarea>
		{{if candel==true}}
		<i class="icon-gb-wb" name="LI_DEL_BE_DETAIL" _id="{{:_id}}"></i>
		{{/if}}
	</div>
	{{/if}}
	{{if type=="image"}}
	<div class="img-up">
		<label name="LBL_BE_UPLOAD_IMG" _id="{{:_id}}"><img id="IMG_BE" src="{{if imageUrl=="" || imageUrl==false}}//static.tfeie.com/v2/images/sctp.png{{else}}{{:imgThumbnailUrl}}{{/if}}" width="100%"></label> 
		<i class="icon-gb-img" name="LI_DEL_BE_DETAIL" _id="{{:_id}}"></i>
	</div>
	{{/if}}
	{{/for}}
</script>
</html>