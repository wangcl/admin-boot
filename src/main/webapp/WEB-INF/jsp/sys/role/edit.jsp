<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>编辑系统角色信息</title>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">修改系统角色</h4>
	</div>
	<div class="modal-body">
		<div class="content scroller">
			<input type="hidden" value="${role.id}" name="id" id="id"/>

			<div class="form-group">
				<label class="col-sm-3 control-label" for="code"><span class="text-red">*</span> 角色编码</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="code" id="code" value="${role.code}" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="name"><span class="text-red">*</span> 角色名称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="name" id="name" value="${role.name}" required>
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
				// 设置校验规则
			},
			messages: {
				code: {
					required: "请输入角色编码"
				},
				name: {
					required: "请输入角色名称"
				}
			}
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/role/" + $("#id").val(),
			type: "put",
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
					swal("修改失败!", data.message, "error");
				}
			},
			error: function callback(e, xhr, opt) {
				$("#mask").css("display", "none");
				swal("很遗憾!", "修改失败", "error");
			}
		});
	});
	//]]>
</script>
</body>
</html>
