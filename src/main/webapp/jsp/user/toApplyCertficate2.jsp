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
<script type="text/javascript"
	src="${_base}/js/webuploader/webuploader.min.js"></script>

</head>

<body>
	<input type="file" accept="image/*" name="pic" id="pic"
		style="display: none;" />

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
		<div class="img" id="frontagefileid">
			<img src="//static.tfeie.com/images/img4.png" />
		</div>
	</div>
	<div class="sec_item sec_item_img">
		<div class="div_title">
			<h3>
				<span>上传海外学历认证/签证/学生证</span>
			</h3>
		</div>
		<div class="img" id="certfileid">
			<div id="fileList" class="uploader-list"></div>
    		<div id="filePicker"><img src="//static.tfeie.com/images/img5.png" /></div>
		</div>
	</div>
	<div class="message-err"></div>
	<section class="but_baoc">
		<p>
			<input type="button" id='upimage' value="提交认证" />
		</p>
	</section>
	
	<script type="text/javascript">
var uploader = WebUploader.create({

    // 选完文件后，是否自动上传。
    auto: false,

    // swf文件路径
    swf: '${_base}/js/webuploader/Uploader.swf',

    // 文件接收服务端。
    server: 'http://webuploader.duapp.com/server/fileupload.php',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker',
    
    disableGlobalDnd: true,

    chunked: true,

    // 只允许选择图片文件。
    accept: {
        title: 'Images',
        extensions: 'gif,jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    }
});

uploader.on( 'fileQueued', function( file ) {
    var $li = $(
            '<div id="' + file.id + '" class="file-item thumbnail">' +
                '<img>' +
            '</div>'
            ),
        $img = $li.find('img');


    // $list为容器jQuery实例
    $("#filePicker").html( $li );

    // 创建缩略图
    // 如果为非图片文件，可以不用调用此方法。
    // thumbnailWidth x thumbnailHeight 为 100 x 100
    uploader.makeThumb( file, function( error, src ) {
        if ( error ) {
            $img.replaceWith('<span>不能预览</span>');
            return;
        }

        $img.attr( 'src', src );
    }, 320, 200 );
});


//文件上传过程中创建进度条实时显示。
uploader.on( 'uploadProgress', function( file, percentage ) {
    var $li = $( '#'+file.id ),
        $percent = $li.find('.progress span');

    // 避免重复创建
    if ( !$percent.length ) {
        $percent = $('<p class="progress"><span></span></p>')
                .appendTo( $li )
                .find('span');
    }

    $percent.css( 'width', percentage * 100 + '%' );
});

// 文件上传成功，给item添加成功class, 用样式标记上传成功。
uploader.on( 'uploadSuccess', function( file ) {
    $( '#'+file.id ).addClass('upload-state-done');
});

// 文件上传失败，显示上传出错。
uploader.on( 'uploadError', function( file ) {
    alert('上传失败');
});

// 完成上传完了，成功或者失败，先删除进度条。
uploader.on( 'uploadComplete', function( file ) {
    $( '#'+file.id ).find('.progress').remove();
});





</script>
</body>
</html>