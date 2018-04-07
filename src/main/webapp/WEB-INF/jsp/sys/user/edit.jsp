<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>编辑用户信息</title>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">修改用户</h4>
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
				<label class="col-sm-3 control-label" for="name"><span class="text-red">*</span> 姓名</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="name" id="name" value="${user.name}" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="email">邮箱</label>
				<div class="col-sm-9">
					<input type="email" class="form-control" name="email" id="email" value="${user.email}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="phone">电话</label>
				<div class="col-sm-9">
					<input type="tel" class="form-control" name="phone" id="phone" value="${user.phone}">
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
		$("#dataForm").validate({
			rules: {
				phone: {
					phone: true
				}
			},
			messages: {
				phone: {
					phone: "请输入正确的电话号码，手机号或固定电话"
				}
			}
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/user/" + $("#id").val(),
			type: "put",
			beforeSubmit: function () {
				$("#mask").css("display", "block");
			},
			success: function (data) {
				if (data.status == 0) {
					$("#modalDialog").modal("hide");
					$("#mask").css("display", "none");
					swal("恭喜您!", data.message, "success");
					$('#dataTable').DataTable().ajax.reload(null, false);
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
</body>
</html>
