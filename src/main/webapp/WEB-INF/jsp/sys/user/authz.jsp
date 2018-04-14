<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>角色授权</title>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">角色授权</h4>
	</div>
	<div class="modal-body">
		<div class="content scroller">
			<input type="hidden" id="userId" name="userId" value="${user.id}">
			<div class="row">
				<label class="col-sm-2 control-label" for="code">用户账号</label>
				<div class="col-sm-4">
					<p id="code" class="form-control-static">${user.account}</p>
				</div>
				<label class="col-sm-2 control-label" for="name">用户名称</label>
				<div class="col-sm-4">
					<p id="name" class="form-control-static">${user.name}</p>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<hr>
				</div>
			</div>
			<c:forEach var="role" items="${roles}">
				<div class="row">
					<div class="col-sm-12">
						<div class='checkbox'>
							<label>
								<input type='checkbox' id='${role.id}' name='roles' value='${role.id}'> ${role.name}
							</label>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="modal-footer">
		<button type="submit" class="btn btn-primary">提交</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	</div>
</form>
<script>
	$(document).ready(function () {
		// 设置已授权角色
		$.ajax({
			url: '${ctx}/sys/user/role/' + $('#userId').val(),
			type: 'GET',
			dateType: 'json',
			success: function (dataArray) {
				$.each(dataArray, function (i, data) {
					if ($('#' + data).length > 0) {
						$('#' + data).attr("checked", "true");
					}
				});
			}
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/user/" + $('#userId').val() + "/authz",
			type: "post",
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
					swal("添加失败!", data.message, "error");
				}
			},
			error: function callback(e, xhr, opt) {
				swal("很遗憾!", "授权失败", "error");
			}
		});
	});
</script>
</body>
</html>
