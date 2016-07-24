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
<title>我<c:if test="${type=='mycreate'}">创建</c:if><c:if test="${type=='myfavor'}">收藏</c:if>的Be</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>


</head>

<body class="bg-eeeeee">

	<nav class="be-nav po-f box-s">
    	<div class="hd clearfix">
            <a href="../be/mybe.html?type=<c:out value="${type}"/>" class="itms on">Be</a>
            <a href="../go/mygroup.html?type=<c:out value="${type}"/>" class="itms">Group</a>
            <a href="../go/myono.html?type=<c:out value="${type}"/>" class="itms">OnO</a>
        </div>
	</nav>
    
    <section class="betwo-main" id="SELECTTION_MY_BE_LIST">
    	
    	
    </section>
   	<div id="UL_GOTO_NEXTPAGE" style="display:none"></div>
    
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
					$(window).scroll(function() {
						var scrollTop = $(document).scrollTop();//获取垂直滚动的距离
			            var docheight = $(document).height();
			            var winheight = $(window).height();

			            if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
			            	_this.gotoNextPage();
			            }

					})
					
				},
				
				initData: function(){
					this.getMyBes({pageNo: 1,newload: true});
				}, 
				gotoNextPage: function(){
					var nextPageNo = $("#UL_GOTO_NEXTPAGE").attr("nextPageNo");
					var pageCount=$("#UL_GOTO_NEXTPAGE").attr("pageCount");
					if(nextPageNo<=pageCount){
						this.getMyBes({pageNo:nextPageNo,newload:false});
					}
				},
				
				getMyBes: function(p){
					var _this = this;
					var type=_this.getPropertyValue("type");
					var url ="";
					if(type=="mycreate"){
						url = "../be/getMyBes";
					}else if(type=="myfavor"){
						url = "../be/getMyFavorBes";
					}
					weUI.showLoadingToast("加载中...");
					ajaxController.ajax({
						url: url,
						type: "post", 
						data: {  
							pageNo: p.pageNo?p.pageNo:1,
							pageSize: 10
						},
						success: function(transport){
							weUI.hideLoadingToast();
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							_this.renderMyBeList(data.result,p.newload); 
							if(pageNo<=pageCount){
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo+1).attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo-1).attr("pageCount",pageCount);
							}
						},
						failure: function(transport){ 
							weUI.hideLoadingToast();
							_this.renderMyBeList([],p.newload); 
						}
					});
				},
				 
				renderMyBeList: function(data,newload){ 
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt = $("#MyBeListImpl").render(data);
					}else{
						opt="<div class='itms box-s'><div class='js chaochu_2'>没有任何动态哦~</div></div>";
					}
					if(newload){
						$("#SELECTTION_MY_BE_LIST").html(opt); 
					}else{
						$("#SELECTTION_MY_BE_LIST").append(opt); 
					}
					
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
			type: "<c:out value="${type}"/>"
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