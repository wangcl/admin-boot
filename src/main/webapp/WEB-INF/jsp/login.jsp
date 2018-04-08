<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/WEB-INF/jsp/include/head_meta" %>
	<title>系统登录</title>
	<%@ include file="/WEB-INF/jsp/include/head_css_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_fonticon" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_app" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryvalidation" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_app" %>
	<script src="${ctx}/app/js/md5.js"></script>
</head>
<body class="hold-transition login-page">
<div class="login-box">
	<div class="login-logo">
		<a href="#"><b>Admin-Boot</b></a>
	</div>
	<div class="login-box-body" style="border:1px solid #d4d4d4">
		<form action="${ctx}/login" method="post" id="loginForm">
			<c:if test="${param.error != null}">
				<div class="form-group has-error">
					<label class="control-label">
						<i class="fa fa-times-circle-o"></i> 用户名或密码错误，请重新输入
					</label>
				</div>
			</c:if>
			<c:if test="${param.logout != null}">
				<div class="form-group has-success">
					<label class="control-label">
						<i class="fa fa-check"></i> 成功登出
					</label>
				</div>
			</c:if>
			<div class="form-group has-feedback" id="usernameDiv">
				<input type="text" name="username" id="username" class="form-control" placeholder="账号" required>
				<span class="form-control-feedback"><i class="fa fa-user"></i></span>
			</div>
			<div class="form-group has-feedback" id="passwordDiv">
				<input type="password" name="password" id="password" class="form-control" placeholder="密码" required>
				<span class="form-control-feedback"><i class="fa fa-lock"></i></span>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<div class="checkbox">
						<label>
							<input type="checkbox" name="rememberMe" id="rememberMe"> 两周之内记住我
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary btn-block ">登录</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$().ready(function () {
		$("#username").focus();

		$("#loginForm").validate({
			submitHandler: function (form) {
				$("#password").val(new $.Md5().hex_md5($("#password").val()));
				form.submit();
			}
		});
	});
</script>
</body>
</html>
