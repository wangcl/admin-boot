<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>修改密码</title>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryform" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryvalidation" %>
	<script src="${ctx}/app/js/md5.js"></script>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">修改密码</h4>
	</div>
	<div class="modal-body">
		<div class="content scroller">
			<input type="hidden" value="${user.id}" name="id" id="id"/>

			<div class="form-group">
				<label class="col-sm-3 control-label" for="account">账号</label>
				<div class="col-sm-9">
					<p id="account" class="form-control-static">${user.account}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="name">姓名</label>
				<div class="col-sm-9">
					<p id="name" class="form-control-static">${user.name}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="password">
					<span class="text-red">*</span> 密码
				</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" name="password" id="password" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="newPassword">
					<span class="text-red">*</span> 新密码
				</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" name="newPassword" id="newPassword" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="newPassword2">
					<span class="text-red">*</span> 重复输入新密码
				</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" name="newPassword2" id="newPassword2" required>
				</div>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="submit" class="btn btn-primary">提交</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	</div>
</form>

<script>
	//<![CDATA[
	$(document).ready(function () {
		$("#password").focus();

		$("#dataForm").validate({
			rules: {
				newPassword2: {
					equalTo: "#newPassword"
				}
			},
			messages: {
				password: {
					required: "请输入旧密码"
				},
				newPassword: {
					required: "请输入新密码"
				},
				newPassword2: {
					required: "请重复输入新密码",
					equalTo: "两次新密码输入不一致"
				}
			}
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/profile/" + $("#id").val(),
			type: "put",
			beforeSerialize: function($form, options) {
				$("#password").val(new $.Md5().hex_md5($("#password").val()));
				$("#newPassword").val(new $.Md5().hex_md5($("#newPassword").val()));
				$("#newPassword2").val("");
			},
			beforeSubmit: function () {
				$("#mask").css("display", "block");
			},
			success: function (data) {
				if (data.status == 0) {
					$("#modalDialog").modal("hide");
					$("#mask").css("display", "none");
					swal("恭喜您!", data.message, "success");
				} else {
					$("#mask").css("display", "none");
					swal("修改失败!", data.message, "error");
					$("#password").val("");
					$("#newPassword").val("");

				}
			},
			error: function callback(e, xhr, opt) {
				$("#mask").css("display", "none");
				swal("很遗憾!", "修改失败", "error");
				$("#password").val("");
				$("#newPassword").val("");
			}
		});
	});
	//]]>
</script>
</body>
</html>
