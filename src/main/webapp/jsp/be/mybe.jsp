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
<title>我创建的Be</title>
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
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>

<body class="bg-eeeeee">

	<nav class="be-nav po-f box-s">
    	<div class="hd clearfix">
            <a href="../be/mybe.html" class="itms on">Be</a>
            <a href="../go/mygroup.html" class="itms">Group</a>
            <a href="../go/myono.html" class="itms">OnO</a>
        </div>
	</nav>
    
    <section class="betwo-main" id="SELECTTION_MY_BE_LIST">
    	
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
<script src="//static.tfeie.com/js/jquery.harborbuilder.js"></script>
<script type="text/javascript">
	(function($){
		$.MyBePage = function(data){
			this.settings = $.extend(true,{},$.MyBePage.defaults);
			this.params= data?data:{}
		}
		$.extend($.MyBePage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this; 
					
					//添加图片按钮事件
					$("#SPAN_ADD_IMAGE").on("click",function(){
						 
					}); 
					
				},
				
				initData: function(){
					this.getMyBes();
				}, 
				
				getMyBes: function(){
					var _this = this;
					ajaxController.ajax({
						url: "../be/getMyBes",
						type: "post", 
						data: {  
							pageNo: 1,
							pageSize: 100
						},
						success: function(transport){
							var data =transport.data; 
							_this.renderMyBeList(data.result); 
						},
						failure: function(transport){ 
							_this.renderMyBeList([]); 
						}
					});
				},
				 
				renderMyBeList: function(data){ 
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt = $("#MyBeListImpl").render(data);
					}else{
						opt="<div class='itms box-s'><div class='js chaochu_2'>您还没有发布任何动态哦~</div></div>";
					}
					$("#SELECTTION_MY_BE_LIST").html(opt); 
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
		
		var p = new $.MyBePage({
		});
		p.init();
		
		
	});
</script>


<script id="MyBeListImpl" type="text/x-jsrender"> 
	<div  class="itms box-s">
        	<div class="top">
                <div class="img">
                   <a href="../user/userInfo.html?userId={{:userId}}"><img src="{{:wxHeadimg}}" width="40" height="40"></a>
                    <div class="name-xx">
                        <div class="xx">{{:enName}}</div>
                        <div class="yrz"><span class="bg-cen">{{:abroadCountryName}}</span><font>{{:userStatusName}}</font></div>
                    </div>
                </div>
                <div class="c">
					{{if hastext==true}}
                    <h3><a href="../be/detail.html?beId={{:beId}}">{{:contentSummary}}</a></h3>
                    {{/if}}
					<div class="bq">
						{{for beTags}} 
                        #<a href="javascript:void(0)">{{:tagName}}</a>  
						{{/for}}
                    </div>
					{{if hasimg==true}}
                    <img src="{{:imageURL}}" width="100%">
					{{else}}
					<div  width="100%"></div>
					{{/if}}
                </div>
            </div>
            <div class="bottom">
            	<div class="time">{{:createTimeInterval}}</div>
                <div class="ic">
                    <a class="list btn-pl" href="../be/detail.html?beId={{:beId}}"><font>{{:commentCount}}</font></a>
                    <div class="list btn-bk"><font>{{:giveHaibeiCount}}</font></div>
                    <div class="list btn-z"><font>{{:dianzanCount}}</font></div>
                </div>
            </div>
        </div>  
</script>
	
</html>