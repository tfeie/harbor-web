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
<title>我的时间线</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />

<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/weui.min.css"> 
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>

</head>

<body style="background:#ffffff">
	<section class="wdsjx-main">
		<div class="top-img">
			<font><c:out value="${userInfo.hyId}"/></font><img
				src="<c:out value="${userInfo.homePageBg}"/>" width="100%">
		</div>
		<div class="grxx">
			<div class="img">
				<a href="#"><img src="<c:out value="${userInfo.wxHeadimg}"/>"
					width="80" height="80"></a>
			</div>
			<div class="r">
				<div class="name">
					<c:out value="${userInfo.enName}"/><span class="bg-lv" style="background:<c:out value="${userInfo.abroadCountryRGB}" />"><c:out value="${userInfo.abroadCountryName}"/></span><font <c:if test="${userInfo.userStatus=='20'}">color="#FFB90F"</c:if>><c:out value="${userInfo.userStatusName}"/></font>
				</div>
				<div class="xx"><c:out value="${userInfo.industryName}"/>/<c:out value="${userInfo.title}"/>/<c:out value="${userInfo.atCityName}"/></div>
			</div>
		</div>

		<div class="pad-10 clearfix line-20"><c:out value="${userInfo.signature}"/></div>
		
		<div id="DIV_MY_TIMELINE">
		
		</div>
		<div id="UL_GOTO_NEXTPAGE" style="display:none">
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
<script type="text/javascript">
	(function($){
		$.MyTimeLinePage = function(data){
			this.settings = $.extend(true,{},$.MyTimeLinePage.defaults);
			this.params= data?data:{}
		}
		$.extend($.MyTimeLinePage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
					this.initData();  
				},
				
				bindEvents: function(){
					var _this = this; 
					
					$("#DIV_MY_TIMELINE").delegate("[name='DEL_BE']","click",function(){
						 var beId =$(this).attr("beId");
						 var showMMdd =$(this).attr("showMMdd");
						 _this.deleteBe(beId,showMMdd);
					}); 
					
					$("#UL_GOTO_NEXTPAGE").on("click",function(){
						_this.gotoNextPage();
					});
					
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
					this.getMyTimeLine({pageNo: 1, newload: true});
				}, 
				
				deleteBe: function(beId,showMMdd){
					ajaxController.ajax({
						url: "../be/deleteBe",
						type: "post", 
						data: { 
							beId: beId
						},
						success: function(transport){
							var dom=$("#DIV_BE_"+beId);
							//获取下一个BE记录
							var next =dom.next("[name='DIV_BES']");
							dom.fadeOut("200",function(){
								dom.detach();
								var len = $("[name='DIV_BES']").length;
								if(len==0){
									var opt="<div class=\"itms\">还没有发表任何动态~</div>";
									$("#DIV_MY_TIMELINE").append(opt); 
								}else{
									if(next.length){
										var nextDateDiv = next.find("#DIV_MMDD");
										nextDateDiv.html(nextDateDiv.attr("date"));
									}
								}
							});
						}
					});
				},
				
				getMyTimeLine: function(p){
					var _this = this;
					if(!p.newload){
						weUI.showLoadingToast("加载中...");
					}
					ajaxController.ajax({
						url: "../be/getMyTimeLine",
						type: "post", 
						data: { 
							pageNo: p.pageNo?p.pageNo:1,
							pageSize: 15
						},
						success: function(transport){
							if(!p.newload){
								weUI.hideLoadingToast();
							}
							var data =transport.data?transport.data:{}; 
							var pageNo = data.pageNo;
							var pageCount = data.pageCount;
							if(pageNo<=pageCount){
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",pageNo+1).attr("pageCount",pageCount);
							}else{
								$("#UL_GOTO_NEXTPAGE").attr("nextPageNo",0).attr("pageCount",pageCount);
							}
							_this.renderMyTimeLineList(data.result,p.newload); 
						},
						failure: function(transport){ 
							if(!p.newload){
								weUI.hideLoadingToast();
							}
							console.log(transport);
							_this.renderMyTimeLineList([],p.newload); 
						}
					});
				},
				
				gotoNextPage: function(){
					var nextPageNo = $("#UL_GOTO_NEXTPAGE").attr("nextPageNo");
					var pageCount=$("#UL_GOTO_NEXTPAGE").attr("pageCount");
					if(nextPageNo<=pageCount){
						this.getMyTimeLine({pageNo:nextPageNo, newload: false});
					}
					
				},
				 
				renderMyTimeLineList: function(data,newload){ 
					data= data?data:[];
					var opt="";
					if(data.length>0){
						opt=$("#MyBeListImpl").render(data);
					}else{
						if(newload){
							opt="<div class=\"itms\">还没有发表任何动态~</div>";
						}
					}
					if(newload){
						$("#DIV_MY_TIMELINE").html(opt); 
					}else{
						$("#DIV_MY_TIMELINE").append(opt); 
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
		
		var p = new $.MyTimeLinePage({ 
		});
		p.init();
		
		
	});
</script>


<script id="MyBeListImpl" type="text/x-jsrender"> 
	<div class="itms" id="DIV_BE_{{:beId}}" name='DIV_BES'>
        	<div class="l" id="DIV_MMDD" date="{{:mmdd}}">{{if showMMdd==true}}{{:mmdd}} {{/if}}</div>
            <a href="../be/detail.html?beId={{:beId}}" class="r">
            	<div class="c">
            	<div class="i">
					{{if hasimg==true}}
						<img src="{{:imageURL}}" width="60"
							height="60">
						{{/if}}
						{{if hasimg==false}}
						<img src="//static.tfeie.com/images/defaultbe.png" width="60"
							height="60">
						{{/if}}
				</div>
                <div class="r-jj">
                	<p class="chaochu_3">{{if hastext==true}} {{:contentSummary}} {{/if}}</p>	
                </div>

                </div>
            </a>
			<div class="clearfix icon-sc" name="DEL_BE" beId="{{:beId}}" showMMdd={{:showMMdd}}>删除</div>
        </div> 
</script>
</html>