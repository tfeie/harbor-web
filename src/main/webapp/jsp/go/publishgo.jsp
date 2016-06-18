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

</head>
<body class="body">
	<section class="fabu_go">
		<section class="fabu_zhuti diyi">
			<p>发布主题</p>
		</section>
		<section class="geizhuti">
			<p>
				<input type="text" value="请给个Sexy的主题">
			</p>
		</section>
		<section class="fabu_zhuti dier">
			<p>活动信息</p>
		</section>
		<section class="act_info">
			<p>
				<span>Group邀请<input type="text" value="5-6" />人
				</span><span class="on">One on One</span>
			</p>
		</section>
		<section class="inp_time">
			<p>
				<span><input type="text" value="2016-5-25 星期三 10:41 "
					class="datepicker" /></span><label><input type="text"
					value="约一个小时" /></label>
			</p>
		</section>
		<section class="me_qingke">
			<p>
				固定费用<input type="text" value="150">/人
			</p>
			<p>
				A A 预付<input type="text" value="150">/人<span>多退少补</span>
			</p>
			<p>我请客</p>
		</section>
		<section class="online_no">
			<p>
				<span class="on">线下服务</span><span>在线服务</span>
			</p>
			<p>
				<input type="text" value="北京中关村附近" />
			</p>
		</section>
		<section class="fabu_zhuti disan">
			<p>活动详情</p>
		</section>

		<section class="add_edit">
			<section class="zhuti_hanhua add_mask items">
				<p>
					<textarea>
请说说这个主题能掏些什么干货…
一.主题
二.内容
三.说明
四.注意
                    </textarea>
				</p>
				<section class="yingchang">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>

			<section class="zhuti_hanhua items">
				<p>
					<textarea>
请说说这个主题能掏些什么干货…
一.主题
二.内容
三.说明
四.注意
                    </textarea>
				</p>
			</section>






			<section class="jia_img add_mask items">
				<p>
					<img src="//static.tfeie.com/images/img51.png">
				</p>
				<p>上传图片</p>
				<section class="yingchang on">
					<img src="//static.tfeie.com/images/img50.png" />
				</section>
			</section>



		</section>

		<section class="fabu_but">
			<p>
				<span class="in"><a>添加图片</a></span><span class="on"><a>添加文本</a></span>
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

		<section class="fabu_zhuti diwu">
			<p>我的故事</p>
		</section>
		<section class="my_gushi">
			<p>
				<textarea>请说说关于这个主题你的故事…</textarea>
			</p>
		</section>

		<section class="sec_btn2 fabu">
			<input type="button" value="发布">
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
				},
				
				bindEvents: function(){
					var _this = this;
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
					this.getAllTags(); 
					this.renderSelectedGoTags();
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
				
</html>