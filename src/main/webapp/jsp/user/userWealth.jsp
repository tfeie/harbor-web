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
<title>我的财富</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
</head>
<body>
<section class="my_price">
		<section class="price_top">
			<p class="on"><span>被赞</span><label><c:out value="${userWealth.totalDianzan}"/></label></p>
			
		</section>
		
		<section class="shouji">
			<p class="title"><span>海贝收支</span><label></label></p>
			<p class="on1"><span>被赏海贝</span><label><c:out value="${userWealth.totalBeishang}"/></label></p>
			<p class="on2"><span>奖励海贝</span><label><c:out value="${userWealth.totalJiangli}"/></label></p>
			<p class="on3"><span>打赏海贝</span><label><c:out value="${userWealth.totalDashang}"/></label></p>
			<p class="on4"><span>公益支出</span><label><c:out value="${userWealth.totalGongyi}"/></label></p>
		</section>

		<section class="keyong">
			<p>
				<span>可用海贝<i><c:out value="${userWealth.hbBalance}"/>&nbsp;&nbsp;&nbsp;</i></span><input type="button" value="购贝" id="BTN_BUY_HAIBEI">
			</p>
			<p class="on">
				<span>现金余额<i><c:out value="${userWealth.cashBlanceYuan}"/></i></span>
			</p>
		</section>
	</section>

</body>

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script> 
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.weui.js"></script>
<script src="//static.tfeie.com/js/jquery.harborbuilder-1.0.js"></script>
<script type="text/javascript">
	(function($){
		$.MyWealthPage = function(data){
			this.settings = $.extend(true,{},$.MyWealthPage.defaults);
			this.params= data?data:{}
		}
		$.extend($.MyWealthPage,{
			defaults: { 
			},
		
			prototype: {
				init: function(){
					this.bindEvents(); 
				},
				
				bindEvents: function(){
					var _this = this;  
					$("#BTN_BUY_HAIBEI").on("click",function(){
						window.location.href="../user/buyhaibei.html";
					});
				},
				
				buyHaibei: function(){
					
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
		
		var p = new $.MyWealthPage({ 
		});
		p.init();	
	});
</script>

</html>