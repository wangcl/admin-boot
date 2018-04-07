<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>新增用户信息</title>
	<script src="${ctx}/app/js/md5.js"></script>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">增加用户</h4>
	</div>
	<div class="modal-body">
		<div class="content scroller">
			<div class="form-group">
				<label class="col-sm-3 control-label" for="account"><span class="text-red">*</span> 账号</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="account" id="account" placeholder="请输入账号" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="name"><span class="text-red">*</span> 姓名</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="name" id="name" placeholder="请输入姓名" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="password"><span class="text-red">*</span> 密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" name="password" id="password" placeholder="请输入密码"
						   required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="password2"><span class="text-red">*</span> 重复输入密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" name="password2" id="password2" placeholder="请再次输入密码"
						   required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="email">邮箱</label>
				<div class="col-sm-9">
					<input type="email" class="form-control" name="email" id="email" placeholder="请输入邮箱">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="phone">电话</label>
				<div class="col-sm-9">
					<input type="tel" class="form-control" name="phone" id="phone" placeholder="请输入联系电话">
				</div>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="submit" class="btn btn-primary" id="btnSubmit">提交</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	</div>
</form>

<script>
	//<![CDATA[
	$(document).ready(function () {
		$("#dataForm").validate({
			rules: {
				password2: {
					equalTo: "#password"
				},
				phone: {
					phone: true
				}
			},
			messages: {
				password: {
					required: "请输入密码"
				},
				password2: {
					required: "请重复输入密码",
					equalTo: "两次密码输入不一致"
				},
				phone: {
					phone: "请输入正确的电话号码，手机号或固定电话"
				}
			}
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/user",
			type: "post",
			beforeSerialize: function($form, options) {
				$("#password").val(new $.Md5().hex_md5($("#password").val()));
				$("#password2").val("");
			},
			beforeSubmit: function () {
				$("#mask").css("display", "block");
			},
			success: function (data) {
				if (data.status == 0) {
					$("#modalDialog").modal("hide");
					$("#mask").css("display", "none");
					swal("恭喜您!", data.message, "success");
					$('#dataTable').DataTable().ajax.reload();
				} else {
					$("#mask").css("display", "none");
					swal("添加失败!", data.message, "error");
				}
			},
			error: function callback(e, xhr, opt) {
				$("#mask").css("display", "none");
				swal("很遗憾!", "添加失败", "error");
			}
		});
	});
	//]]>
</script>
</div>
</body>
</html>
