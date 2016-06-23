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
							userId: _this.getPropertyValue("userId"),
							openId: _this.getPropertyValue("openId"),
							pageNo: 1,
							pageSize: 100
						},
						success: function(transport){
							var data =transport.data; 
							//alert(JSON.stringify(data));
							_this.renderMyBeList(data); 
						},
						failure: function(transport){ 
							_this.renderMyBeList([]); 
						}
					});
				},
				 
				renderMyBeList: function(data){ 
					data= data?data:[];
					var opt=$("#MyBeListImpl").render(data);
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
			userId: "<c:out value="${userInfo.userId}"/>",
			openId: "<c:out value="${userInfo.wxOpenid}"/>"
		});
		p.init();
		
		
	});
</script>


<script id="MyBeListImpl" type="text/x-jsrender"> 
	{{for belist ~userInfo=userInfo}} 	
	<div  class="itms box-s">
        	<div class="top">
                <div class="img">
                    <a href="javascript:void(0)"><img src="{{:~userInfo.wxHeadimg}}" width="40" height="40"></a>
                    <div class="name-xx">
                        <div class="xx">{{:~userInfo.enName}}</div>
                        <div class="yrz"><span class="bg-cen">{{:~userInfo.abroadCountryName}}</span><font>{{:~userInfo.userStatusName}}</font></div>
                    </div>
                </div>
                <div class="c">
					{{if hastext==true}}
                    <h3>{{:firstTextDetail.detail}}</h3>
                    {{/if}}
					<div class="bq">
                   		#
						{{for tags}} 
                        <a href="javascript:void(0)">{{:tagName}}</a>  
						{{/for}}
                    </div>
					{{if hasimg==true}}
                    <img src="{{:firstImgDetail.imageUrl}}" width="100%">
					{{/if}}
					{{if hasimg==false}}
					<img  width="100%">
					{{/if}}
                </div>
            </div>
            <div class="bottom">
            	<div class="time">{{:publishdate}}</div>
                <div class="ic">
                    <a class="list btn-pl" href="../be/detail.html?beId={{:beId}}"><font>2</font></a>
                    <div class="list btn-bk"><font>30</font></div>
                    <div class="list btn-z"><font>3</font></div>
                </div>
            </div>
        </div>  
		{{/for}} 	
</script>
	
</html>