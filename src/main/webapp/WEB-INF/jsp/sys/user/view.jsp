<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>查看用户信息</title>
</head>
<body>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title">查看用户</h4>
</div>
<div class="modal-body">
	<div class="content scroller">
		<div class="form-group">
			<label class="col-sm-2 control-label" for="account">账号</label>
			<div class="col-sm-10">
				<p id="account" class="form-control-static">${user.account}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">姓名</label>
			<div class="col-sm-10">
				<p id="name" class="form-control-static">${user.name}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="email">邮箱</label>
			<div class="col-sm-10">
				<p id="email" class="form-control-static">${user.email}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="phone">电话</label>
			<div class="col-sm-10">
				<p id="phone" class="form-control-static">${user.phone}</p>
			</div>
		</div>
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
</div>
</body>
</html>
