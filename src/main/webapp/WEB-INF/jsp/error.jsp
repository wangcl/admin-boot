<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>错误信息</title>
	<%@ include file="/WEB-INF/jsp/include/head_css_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_fonticon" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_base" %>
</head>
<body>
<section id="error" class="content">
	<div class="callout callout-danger">
		<h4><i class="fa fa-warning"></i> 系统运行错误</h4>
		系统运行时发生内部错误。如果错误持续存在，请联系系统维护人员。
	</div>
	<div class="row">
		<div class="col-sm-12">
			<a class="btn btn-success pull-right" href="${ctx}/">回到首页</a>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-info collapsed-box">
				<div class="box-header with-border">
					<h3 class="box-title"><strong>错误信息：</strong><span class="text-red">${message}</span></h3>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i
								class="fa fa-plus"></i>
						</button>
					</div>
				</div>
				<div class="box-body">
					<p><strong>HTTP 状态码：<span class="text-light-blue">${status}</span></strong></p>
					<p><strong>详细错误信息：</strong></p>
					<p>${trace}</p>
				</div>
			</div>
		</div>
	</div>

	<!--
		<p>时间: ${timestamp}</p>
		<p>error: ${error}</p>
		<p>message: ${message}</p>
		<p>exception: ${exception}</p>
		<p>path: ${path}</p>
		<p>errors: ${errors}</p>
	-->

</section>
</body>
</html>
