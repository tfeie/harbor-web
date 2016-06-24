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
<title>我的关注</title>
<link href="//static.tfeie.com/v2/css/global.css" rel="stylesheet"
	type="text/css" />
<link href="//static.tfeie.com/v2/css/css.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="//static.tfeie.com/v2/css/swiper.min.css">

<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery.ajaxcontroller.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/json2.js"></script>
<script src="//static.tfeie.com/v2/js/swiper.min.js"></script>
<script src="//static.tfeie.com/v2/js/tap.js"></script>

</head>
<body>

	<section class="wdgz-main">
    	<div class="itms clearfix">
        	<div class="img"><a href="#"><img src="//static.tfeie.com/v2/images/tx.png" width="50" height="50"></a><font>1</font></div>
            <div class="r">
            	<div class="time">30分钟前</div>
                <div class="c">
                	<a href="#">
                	<div class="name">系统通知<c:out value="${loginUserId }"/></div>
                    <div class="xx">已报名</div>
                    </a>
                </div>
            </div>
            <div class="icon-gb"></div>
        </div>
    	<div class="itms clearfix">
        	<div class="img"><a href="#"><img src="//static.tfeie.com/v2/images/tx.png" width="50" height="50"></a><font>1</font></div>
            <div class="r">
            	<div class="time">30分钟前</div>
                <div class="c">
                	<a href="#">
                	 <div class="name">MaysMays<span class="bg-lv">美国</span><font>已认证</font></div>
                    <div class="xx">已报名</div>
                    </a>
                </div>
            </div>
            <div class="icon-gb"></div>
        </div>
    
    </section>
   
   
   
    <div class="tc-main">
    	<span class="btn-show po-f"></span>
    	<span class="btn-be po-f"></span>
    	<span class="btn-go po-f"></span>
        <div class="bg-main po-f"></div>
    </div>
   
	<footer class="footer po-f">
    	<a href="#"><i class="icon-f1"></i><span>Be</span></a>
    	<a href="#"><i class="icon-f2"></i><span>Go</span></a>
    	<a href="#"><i class="icon-f3"></i><span>Frd</span></a>
    	<a href="#"><i class="icon-f4"><font>6</font></i><span>Msg</span></a>
    	<a href="#"><i class="icon-f5"></i><span>Me</span></a>
    </footer>
    
     
<script>
$(function(){
	
			
		
	
			//检查版本
		var u = navigator.userAgent, app = navigator.appVersion;
		var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
		
		
		//苹果兼容
		if(isiOS){
			
			$('.In-pof').focus(function(){
				
				$('.po-f').addClass('po-a')
				
			}).blur(function(){//输入框失焦后还原初始状态
			
				$('.po-f').removeClass('po-a')
			
			});
			
			}
			
			//显示底部
			$('.btn-show').tap(function(){
				if($(this).parent('.tc-main').attr('class')	==	'tc-main' || $(this).parent('.tc-main').attr('class')	==	'tc-main on1'){
					$(this).parent('.tc-main').removeClass('on1');
					$(this).parent('.tc-main').addClass('on');
					$(this).parent('.tc-main').children('.bg-main').fadeIn();
					
					}else{
					$(this).parent('.tc-main').removeClass('on');
					$(this).parent('.tc-main').addClass('on1');
					$(this).parent('.tc-main').children('.bg-main').fadeOut();
						
						}
			})
			
			//删除
			$('.icon-gb').tap(function(){
				$(this).parents('.itms').detach();
				})
			
		
			
	})
</script>

</body>
</html>