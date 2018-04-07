<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title><sitemesh:write property='title'/></title>
	<sitemesh:write property='head'/>

	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_bootstrapselect" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_datatables" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_sweetalert" %>

	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_bootstrapselect" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_datatables" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryform" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryvalidation" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_sweetalert" %>
</head>
<body>
<sitemesh:write property='body'/>

<!-- 通用modal外框 -->
<div class="modal fade" id="modalDialog" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

		</div>
	</div>
</div>

</body>
</html>
