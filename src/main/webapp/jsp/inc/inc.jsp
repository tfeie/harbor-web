<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String _base = request.getContextPath();
    request.setAttribute("_base", _base);

    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "No-cache");
%> 
<link rel="stylesheet" type="text/css" href="${_base }/resources/css/style.css"/>
<link rel="stylesheet" type="text/css" href="${_base }/resources/owl.carousel.min.css"/>

<script src="${_base}/resources/js/jquery.min.js" ></script>
<script src="${_base}/resources/js/owl.carousel.js" ></script>
<script src="${_base}/resources/js/selectivizr.js" ></script> 
<script>
    var _base = "${_base}";
</script>
