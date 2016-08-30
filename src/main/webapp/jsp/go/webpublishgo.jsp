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
<title><c:if test="${islogin==true}">发布G&O</c:if><c:if test="${islogin!=true}">登录跳转中</c:if></title>
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

<script src="//static.tfeie.com/js/jquery-te/jquery-te-1.4.0.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/js/jquery-te/jquery-te-1.4.0.css"> 
  <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
  <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
  <script src="//static.tfeie.com/js/layer/layer.js"></script>
<style>
.inp_time	.l {
	position: relative;
	z-index: 99;
}
</style>


<script type="text/javascript">
	var isLogin="<c:out value="${islogin}"/>";
	if(isLogin=="false"){
		window.location.href="../user/login.html";
	}
</script>

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
					type="text" id="inviteMembers" />人
				</span> <span name="goType" goType="oneonone">One on One</span>
			</p>
		</section>
		
        <section class="inp_time">
			<label class="l"><input type="datetime-local" id="expectedStartTime"/></label>

			<div class="r">
            	<select id="expectedDuration">
					<option value="">时长</option>
					<option value="约1个小时">约1小时</option>
					<option value="约2小时">约2小时</option>
					<option value="半天">半天</option>
					<option value="一天">一天</option>
				</select>
            </div>
        </section>
		
		<section class="me_qingke">
			<p name="payMode" payMode="10">
				固定费用<input type="text" id="price" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">元/人
			</p>
			<p name="payMode" payMode="20">
				A A 预付<input type="text" id="price" placeholder="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">元/人<span>多退少补</span>
			</p>
			<p name="payMode" payMode="30">我请客</p>
		</section>
		
		
		<section class="online_no">
            <p>
				<span name="orgMode" orgMode="offline" class="on">线下服务</span><span name="orgMode" orgMode="online">在线服务</span>
			</p>
            <div class="xx">
                <div class="sel">
                    <select id="offlineProvince">
                       
                    </select>
                </div>
                <div class="sel">
                    <select id="offlineCity">
                        
                    </select>
                </div>
            	<p>
					<input type="text" placeholder="例如：朝阳区星巴克(中关村店)" id="location"/>
				</p>
            </div>
            <div class="online" style="display:none;">
            	<p><input type="text" placeholder="例：http://...  或微信号码" id="onlineNet"></p>
                
                <section class="jia_img  items">
                    <p><img src="//static.tfeie.com/images/img51-1.png" id="IMG_ONLINEPIC"></p> 
                    <input type="hidden" id="onlinePic">
                </section>
            </div>
        </section>
		
		
		<section class="fabu_zhuti disan">
			<p>活动详情</p>
		</section>

		<section class="add_edit" id="SECTION_GO_DETAILS">

		</section>

		<section class="fabu_but">
			<p>
				<span class="in"  id="SPAN_ADD_TEXT"><a>添加文本</a></span>
				<span class="on" id="SPAN_ADD_IMAGE"><a>添加图片</a></span>
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
		<section class="my_gushi" name="SELECTION_MYSTORY"  id="SECTION_GO_STORIES" style="display:none">
			
		</section>
		<section class="fabu_but" name="SELECTION_MYSTORY" style="display:none">
			<p>
				<span class="in"  id="STORY_ADD_TEXT"><a>添加文本</a></span>
				<span class="on" id="STORY_ADD_IMAGE"><a>添加图片</a></span>
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
<script type="text/javascript">
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
							$("[name='payMode']").each(function(i,o){
								var payMode =$(this).attr("payMode");
								if(payMode=="10"){
									$(this).addClass("on").show();
								}else{
									$(this).removeClass("on").hide();
								}
							});
							$("[name='SELECTION_MYSTORY']").show();
							$('.inp_time').addClass('on');
						}else if(goType=="group"){
							$('.inp_time').removeClass('on');
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
							$(this).parents(".online_no").children('.xx').css({display:'block'})
							$(this).parents(".online_no").children('.online').css({display:'none'})
						}else{
							$(this).parents(".online_no").children('.online').css({display:'block'})
							$(this).parents(".online_no").children('.xx').css({display:'none'})
						}
						
					});
					
					//添加图片按钮事件
					$("#SPAN_ADD_IMAGE").on("click",function(){
						var url="../user/towebupload.html?type=GO_DETAILS";
						layer.open({
							type: 2,
							title: '图片上传',
							maxmin: true,
							shadeClose: true, //点击遮罩关闭层
							area : ['800px' , '520px'],
							content: url
						}); 
					});
					
					//添加文字按钮事件
					$("#SPAN_ADD_TEXT").on("click",function(){
						_this.godetails.push({
							_id: new Date().getTime(),
							type: "text",
							candel: true,
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
					$("#SECTION_GO_DETAILS").delegate("#GO_DETAIL_TEXTAREA_TOPIC","blur",function(){
						var _id =$(this).attr("_id");
						var val = $(this).val();
						_this.modifyGoDetail(_id,val,"");
					}); 
					
					//线上活动图片上传
					$("#IMG_ONLINEPIC").on("click",function(){
						var _this = this;
						var url="../user/towebupload.html?type=GO_ONLINE_IMG&limit=1";
						layer.open({
							type: 2,
							title: '图片上传',
							maxmin: true,
							shadeClose: true, //点击遮罩关闭层
							area : ['800px' , '520px'],
							content: url
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
					
					//选择省份
					$("#offlineProvince").on("change",function(){
						var provinceCode =$(this).val();
						_this.getAllHyCities(provinceCode);
					});
					
					//自定义标签绑定事件
					$("#UI_CAN_SELECT_GO_TAGS").delegate("[name='IMG_CUSTOMIZE_TAG_ADD']","click",function(){
						if(_this.selectedGoTags.length==5){
							weUI.showXToast("标签已选满");
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
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
					
					//我的故事-添加图片按钮事件
					$("#STORY_ADD_IMAGE").on("click",function(){
						var _this = this;
						var url="../user/towebupload.html?type=GO_STORIES";
						layer.open({
							type: 2,
							title: '图片上传',
							maxmin: true,
							shadeClose: true, 
							area : ['800px' , '520px'],
							content: url
						}); 
					});
					
					//我的故事-添加文字按钮事件
					$("#STORY_ADD_TEXT").on("click",function(){
						_this.gostories.push({
							_id: new Date().getTime(),
							type: "text",
							candel: true,
							detail:""
						});
						//渲染我的故事图文表单
						_this.renderGoStories();
					});
					
					//我的故事--图文删除事件代理
					$("#SECTION_GO_STORIES").delegate("[name='SECTION_DEL_GO_STORY_DETAIL']","click",function(){
						var _id =$(this).attr("_id");
						_this.deleteGoStory(_id);
					});
					
				},
				
				
				returnDataToLayer: function(images,type){
					var _this = this;
					layer.closeAll();
					if(!images || images.length==0){
						return;
					}
					if(type=='GO_ONLINE_IMG'){
						var imgURL = images[0];
						$("#IMG_ONLINEPIC").attr("src", imgURL+"@!go_thumbnail");
						$("#onlinePic").val(imgURL);
					}else if(type=='GO_STORIES'){
						$.each(images,function(index,url){
							_this.gostories.push({
								_id: new Date().getTime(),
								type: "image",
								candel: true,
								imageUrl: url,
								imgThumbnailUrl: url+"@!go_thumbnail"
							});
						});
						_this.renderGoStories();
					}else if(type=='GO_DETAILS'){
						$.each(images,function(index,url){
							_this.godetails.push({
								_id: new Date().getTime(),
								type: "image",
								candel: true,
								imageUrl: url,
								imgThumbnailUrl: url+"@!go_thumbnail"
							});
						});
						_this.renderGoDetails();
					}
				},
				
				initData: function(){ 
					this.selectedGoTags=[];
					this.godetails=[{
						_id: new Date().getTime(),
						type: "text",
						candel: false,
						detail:""
					}];
					this.gostories=[{
						_id: new Date().getTime(),
						type: "text",
						candel: false,
						detail:""
					}];
					this.getAllTags(); 
					
					this.getAllHyProvincies();
				},
				
				initRenders: function(){
					this.renderSelectedGoTags();
					this.renderGoDetails();
					this.renderGoStories();
				},
				
				getAllTags: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../go/getGroupSystemTags",
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
				
				
				getAllHyProvincies: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../sys/getAllProvincies",
						type: "post", 
						success: function(transport){
							var data =transport.data;
							_this.fillAtProvinceSelelct(data);
						},
						failure: function(transport){
							_this.fillAtProvinceSelelct([]);
						}
						
					});
				},
				
				fillAtProvinceSelelct: function(options){
					var d  = {
						showAll: true,
						allValue: "",
						allDesc: "请选择省份",
						options: options?options:[]
					};
					var opt=$("#AreaSelectOptionImpl").render(d);
					$("#offlineProvince").append(opt);
				},
				
				
				getAllHyCities: function(offlineProvince){
					var _this = this;
					ajaxController.ajax({
						url: "../sys/getCities",
						type: "post", 
						data: {
							proviceCode: offlineProvince
						},
						success: function(transport){
							var data =transport.data;
							_this.fillAtCitySelelct(data);
						},
						failure: function(transport){
							_this.fillAtCitySelelct([]);
						}
						
					});
				},
				
				fillAtCitySelelct: function(options){
					var d  = {
						showAll: true,
						allValue: "",
						allDesc: "请选择地市",
						options: options?options:[]
					};
					var opt=$("#AreaSelectOptionImpl").render(d);
					$("#offlineCity").html(opt);
				},
				
				addNewGoTag: function(tagName){
					var _this = this;
					if(_this.selectedGoTags.length>=5){ 
						weUI.showXToast("标签已选满");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return ;
					}
					//从待选列表中标记已经被选
					var queryTags=$.grep(_this.allGoTags,function(o,i){
						return o.tagName==tagName;
					});
					if(queryTags && queryTags.length>0){
						var currentTag = queryTags[0];
						currentTag.selected = true;
						//alert(currentTag.polyTagId)
						//追加到已选列表
						var newTag = {
							tagId: currentTag.tagId,
							tagType: currentTag.tagType,
							tagName: currentTag.tagName,
							tagCat: currentTag.tagCat,
							polyTagId: currentTag.polyTagId
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
						weUI.showXToast("至少保留1个");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
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
						d.imgThumbnailUrl=url+"@!go_thumbnail";
					}
				},
				
				deleteGoDetail: function(_id){
					var _this = this;
					if(_this.godetails.length==1){
						weUI.showXToast("至少保留一项");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return;
					}
					// 第一个文本不能删
					var firstgo = _this.godetails[0];
					if(firstgo._id == _id){
						weUI.showXToast("第一个文本框不允许删除");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
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
					var _this = this;
					var godetails =this.godetails?this.godetails:[];
					var d = { 
						godetails: godetails
					}
					var opt=$("#GoDetailsImpl").render(d);
					$("#SECTION_GO_DETAILS").html(opt);
					
					$.each(godetails,function(idx,o){
						if(o.type=="text"){
							$("#GO_DETAIL_TEXTAREA_"+o._id).jqte({
								title: false,
								sup: false,
								strike: false,
								sub: false,
								source: true,
								i: false,
								u: false,
								rule: false,
								remove: false,
								outdent: false,
								format: false,
								blur: function(){
									var val=$("#GO_DETAIL_TEXTAREA_"+o._id).val();
									_this.modifyGoDetail(o._id,val,"");
								}
							});
							$("#GO_DETAIL_TEXTAREA_"+o._id).jqteVal(o.detail);
						}
						
					})
				},
				
				
				deleteGoStory: function(_id){
					var _this = this;
					if(_this.gostories.length==1){
						weUI.showXToast("至少保留一项");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return;
					}
					// 第一个文本不能删
					var firstgo = _this.gostories[0];
					if(firstgo._id == _id){
						weUI.showXToast("不允许删除");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return;
					}
					
					var gostories = $.grep(_this.gostories,function(o,i){
						return o._id==_id;
					});
					if(gostories.length==0){
						return;
					}
					var d = gostories[0];
					_this.gostories.splice($.inArray(d,_this.gostories),1);
					_this.renderGoStories();
				},
				
				renderGoStories: function(){
					var _this = this;
					var gostories =this.gostories?this.gostories:[];
					var d = { 
						gostories: gostories
					}
					var opt=$("#GoStoriesImpl").render(d);
					$("#SECTION_GO_STORIES").html(opt);
					
					$.each(gostories,function(idx,o){
						if(o.type=="text"){
							$("#GO_STORY_TEXTAREA_"+o._id).jqte({
								title: false,
								sup: false,
								strike: false,
								sub: false,
								source: true,
								i: false,
								u: false,
								rule: false,
								remove: false,
								outdent: false,
								format: false,
								blur: function(){
									var val=$("#GO_STORY_TEXTAREA_"+o._id).val();
									_this.modifyGoStory(o._id,val,"");
								}
							});
							$("#GO_STORY_TEXTAREA_"+o._id).jqteVal(o.detail);
						}
						
					})
				},
				
				modifyGoStory: function(_id,val,url){
					var _this = this;
					var gostories = $.grep(_this.gostories,function(o,i){
						return o._id==_id;
					});
					if(gostories.length==0){
						return;
					}
					var d = gostories[0];
					if(d.type=="text"){
						d.detail = val;
					}else {
						d.imageUrl = url;
						d.imgThumbnailUrl=url+"@!go_thumbnail";
					}
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
					var offlineProvince = $.trim($("#offlineProvince").val());
					var offlineCity = $.trim($("#offlineCity").val());
					var onlineNet = $.trim($("#onlineNet").val());
					var onlinePic = $.trim($("#onlinePic").val());
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
								required: true/* , 
								datetime: true */
							},
							ruleMessages: {
								required: "请选择预期开始时间",
								/* datetime:"预期开始时间格式必须是yyyy-MM-dd hh:mm:ss" */
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
							required: "请选择预期持续时间",
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
							fieldName: "gostories",
							getValue: function(){
								return _this.gostories;
							},
							fieldRules: {
								minlength: 1
							},
							ruleMessages: {
								minlength: "请填写我的故事"
							}
						});
					}
					
					
					var res=valueValidator.fireRulesAndReturnFirstError();
					if(res){
						weUI.showXToast(res);
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
						return;
					}
					//校验活动明细 
					var queryDetails = $.grep(_this.godetails,function(o,i){
						return (o.type=="text" && o.detail=="") || (o.type=="image" && o.imageUrl=="");
					});
					if(queryDetails.length>0){
						weUI.showXToast("图片或文字没有填写");
						setTimeout(function () {
							weUI.hideXToast();
			            }, 1000);
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
						offlineProvince: (orgMode=="online")?"":offlineProvince,
						offlineCity: (orgMode=="online")?"":offlineCity,
						onlineNet: (orgMode=="online")?onlineNet:"",
						onlinePic: (orgMode=="online")?onlinePic:"",
						goStories: (goType=="oneonone")?_this.gostories:[],
						goDetails: _this.godetails,
						goTags: _this.selectedGoTags
					} 
					
					weUI.showLoadingToast("正在发布..")
					ajaxController.ajax({
						url: "../go/submitNewGo",
						type: "post", 
						data: {
							goData: JSON.stringify(data)
						},
						success: function(transport){
							weUI.hideLoadingToast();
							weUI.showXToast("发布成功");
							setTimeout(function () {
								weUI.hideXToast();
								window.location.href="../user/webentrance.html";
				            }, 1000);
						},
						failure: function(transport){
							weUI.hideLoadingToast();
							weUI.showXToast(transport.statusInfo);
							setTimeout(function () {
								weUI.hideXToast();
				            }, 1000);
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
	
	var p;
	$(document).ready(function(){
		p = new $.PublishGoPage({
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
			<section class="zhuti_hanhua items">
				<p>
					{{if candel==false}}
					<textarea name="GO_DETAIL_TEXTAREA"  id="GO_DETAIL_TEXTAREA_TOPIC" _id="{{:_id}}" placeholder="请输入不超过3行的简介">{{:detail}}</textarea>
					{{/if}}
					{{if candel==true}}
					<textarea name="GO_DETAIL_TEXTAREA"  id="GO_DETAIL_TEXTAREA_{{:_id}}" _id="{{:_id}}">{{:detail}}</textarea>
					{{/if}}
					
				</p>
				{{if candel==true}}
					<section class="yingchang" name="SECTION_DEL_GO_DETAIL" _id="{{:_id}}">
						<img src="//static.tfeie.com/images/img50.png" />
					</section>
				{{/if}}
				
			</section>
		{{/if}}
		{{if type=="image"}}
			<section class="jia_img items">
				<p name="P_GO_UPLOAD_IMG" _id="{{:_id}}">
					<img id="IMG_GO" src="{{if imageUrl=="" || imageUrl==false}}//static.tfeie.com/images/img51-1.png{{else}}{{:imgThumbnailUrl}}{{/if}}">
				</p>
				<section class="yingchang on" name="SECTION_DEL_GO_DETAIL" _id="{{:_id}}">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>
		{{/if}}
	{{/for}}
</script>	

<script id="GoStoriesImpl" type="text/x-jsrender">
	{{for gostories}} 
		{{if type=="text"}}
			<section class="zhuti_hanhua items">
				<p>
					<textarea name="GO_STORY_TEXTAREA"  id="GO_STORY_TEXTAREA_{{:_id}}" _id="{{:_id}}">{{:detail}}</textarea>
				</p>
				{{if candel==true}}
					<section class="yingchang" name="SECTION_DEL_GO_STORY_DETAIL" _id="{{:_id}}">
						<img src="//static.tfeie.com/images/img50.png" />
					</section>
				{{/if}}
				
			</section>
		{{/if}}
		{{if type=="image"}}
			<section class="jia_img items">
				<p name="P_GO_STORY_UPLOAD_IMG" _id="{{:_id}}">
					<img id="IMG_GO_STORY" src="{{if imageUrl=="" || imageUrl==false}}//static.tfeie.com/images/img51-1.png{{else}}{{:imgThumbnailUrl}}{{/if}}">
				</p>
				<section class="yingchang on" name="SECTION_DEL_GO_STORY_DETAIL" _id="{{:_id}}">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>
		{{/if}}
	{{/for}}
</script>	

	<script id="AreaSelectOptionImpl" type="text/x-jsrender"> 
	{{if showAll==true}}
    <option value="{{:allValue}}">{{:allDesc}}</option>
	{{/if}}
    {{for options ~defaultValue=defaultValue}}
        <option value="{{:areaCode}}"  {{if ~defaultValue==areaCode}} selected {{/if}}>{{:areaName}}</option>
    {{/for}}
	</script>		
</html>