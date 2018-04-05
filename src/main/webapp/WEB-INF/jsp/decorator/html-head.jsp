<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/WEB-INF/jsp/include/head_meta" %>

	<title><sitemesh:write property='title'/></title>

	<%@ include file="/WEB-INF/jsp/include/head_css_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_fonticon" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_app" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_app" %>

	<sitemesh:write property='head'/>
</head>
<body>
<sitemesh:write property='body'/>
</body>
</html>
