<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>首页</title>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_sweetalert" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_sweetalert" %>
</head>
<body>

<!-- 通用modal外框 -->
<div class="modal fade" id="modalDialog" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

		</div>
	</div>
</div>

</body>
</html>
