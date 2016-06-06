<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
<title>申请认证</title>
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/style.css">
<link rel="stylesheet" type="text/css"
	href="//static.tfeie.com/css/owl.carousel.min.css">
<script type="text/javascript"
	src="//static.tfeie.com/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//static.tfeie.com/js/main.js"></script>
<script type="text/javascript"
	src="//static.tfeie.com/js/owl.carousel.js"></script>
<style>
.mengc {position:fixed;width:100%;height:100%;z-index: 10;background: rgba(0, 0, 0, .8);text-align:center;display:none;}
.mengc img {margin-top:20%;}
</style>
</head>
<script type="text/javascript">
$(function(){
	var pic=$("#pic");
	var pic_dom = document.getElementById('pic');
	pic_dom.addEventListener('change',function(e){
        var file_obj = e.currentTarget.files[0];
        var pic_div = getPhotoDiv();
		if(file_obj){
            var reader = new FileReader();
            reader.onload=function(e){
            	compressImg(this.result,function(data){//压缩完成后执行的callback
            		//准备上传的数据
            		var input_id = pic_div.attr("name");
            	alert(input_id);
            		$("#"+input_id).val(data.substr(23));
            		$("#"+input_id).attr("valchanged","1");
            		var img = new Image();
            		img.src = data;
            		img.onclick = function(){
            			$("#mc").empty();
            			var top_img = new Image();
            			top_img.src = data;
            			$("#mc").append(top_img);
            			$("#mc").css("display","block");
            		};
            		pic_div.empty();
            		pic_div.append(img);
            	});
			};
			reader.readAsDataURL(file_obj);
		}
	},false);
	//蒙层展示图片放大效果
	$("#mc").click(function(){//蒙层展示图片放大效果
		var dis = $(this).css("display");
		if(dis!="none")
		{
			$(this).css("display","none");
		}
	});
	var mc_div = document.getElementById('mc');
	mc_div.addEventListener('touchmove', function(event) {
		event.preventDefault();	//添加触摸事件 阻止滚动条动作
	}, false);
	//添加点击效果
	var photo_divs = document.getElementsByClassName('sec_item');
	for(i=0;i<photo_divs.length;i++){
		var photo_div = photo_divs[i];
		photo_div.addEventListener('touchstart', function(event) {
				var pic_div = $(".img",$(this));
				var touch = event.targetTouches[0];
				var in_pic_div = isTouchInBody(touch,pic_div);
				if(in_pic_div==false){
					event.preventDefault();
					$(this).css("background","#f1f1f1");	
				}
		}, false);
		photo_div.addEventListener('touchend', function(event) {
			var back = $(this).css("background");
			if(back!="none")
			{	
				$(this).css("background","none");
			}
			var pic_div = $(".img",$(this));
			var touch = event.changedTouches[0];
			var in_photo_div = isTouchInBody(touch,$(this));
			var in_pic_div = isTouchInBody(touch,pic_div);
			if(in_photo_div&&!in_pic_div)
			{
				$(".sec_item").attr("photo","0");
				$(this).attr("photo","1");
				pic.click();
			}
		}, false);
	};
	
	$("#upimage").bind("click",function(){
		var _front=$("#frontagefileid").val();
		var _cert=$("#certfileid").val();
		if(_front==""||_cert==""){
			alert("请选择要上传的照片");	
		}else {
			ajaxController.ajax({
				url: "../user/submitCertficate",
				type: "post",
				data: {
					_front: _front,
					_cert: _cert
				},
				success: function(transport){
					alert("认证成功"); 
				},
				failure: function(transport){
					alert(transport.statusInfo);
				}
				
			});
		}
	})
});

function isTouchInBody(touch,jq_obj){//判是否落在目标中
	var pis_x=0,pis_y=0;//点坐标
	 pis_x = touch.pageX, pis_y = touch.pageY;
	var offset = jq_obj.offset();
	var width =  jq_obj.width(),height = jq_obj.height();;
	var left = offset.left,top = offset.top;
	if(pis_x>=left&&pis_x<=left+width&&pis_y>=top&&pis_y<=top+height)
	{//在区域中
		return true;
	}
	return false;
}

function getPhotoDiv(){
	var photo_div;
	$(".sec_item").each(function(){
		var photo = $(this).attr("photo");
		if(photo=="1")
		{
			photo_div = $(this);
		}
	});
	return  $(".img",photo_div);
}

function compressImg(imgData,onCompress){//图片压缩工具
	if(!imgData)return;
	onCompress = onCompress || function(){};
	var canvas = document.createElement('canvas');
	var img = new Image();
	img.onload = function() {
		var square = 320;
	    canvas.width = square;
	    canvas.height = square;
		var ctx = canvas.getContext("2d"); 
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		var imageWidth; var imageHeight; var offsetX = 0; var offsetY = 0;
		if (this.width > this.height) {
			imageWidth = Math.round(square * this.width / this.height);
			imageHeight = square;
			offsetX = - Math.round((imageWidth - imageHeight) / 2);
		} else {
			imageHeight = Math.round(square * this.height / this.width);
			imageWidth = square; 
			offsetY = - Math.round((imageHeight - imageWidth) / 2); 
		}
		ctx.drawImage(this, offsetX,offsetY, imageWidth,imageHeight);
		onCompress(canvas.toDataURL("image/jpeg"));
	};
	img.src = imgData;
}
</script>
<body>
	<input type="file" accept="image/*"  name="pic" id="pic" style="display:none;"/>

   	<div class="mengc" id="mc"><img/></div>

	<section class="sec_item">
		<div class="div_title">
			<h3>
				<span>申请认证请提交以下材料</span>
			</h3>
		</div>
		<ul>
			<li>身份证照片</li>
			<li>海外学历认证文件或留学签证扫描件或<br />学生证扫描件
			</li>
		</ul>
	</section>
	<div class="sec_item sec_item_img" id="">
		<div class="div_title">
			<h3>
				<span>上传身份证（正）</span>
			</h3>
		</div>
		<div class="img" name="frontagefileid">
			<img src="//static.tfeie.com/images/img4.png" />
		</div>
	</div>
	<div class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传海外学历认证/签证/学生证</span>
			</h3>
		</div>
		<div class="img" name="certfileid">
			<img src="//static.tfeie.com/images/img5.png" />
		</div>
	</div>
	<section class="but_baoc">
		<p>
			<input type="button" id='upimage' value="提交认证" />
		</p>
	</section>
	
	<input id="frontagefileid" type="hidden" value=""/>
	<input id="certfileid" type="hidden" value=""/>
</body>
</html>