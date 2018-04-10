<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>编辑系统菜单项信息</title>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">修改系统菜单项</h4>
	</div>
	<div class="modal-body">
		<div class="content scroller">
			<input type="hidden" value="${menuItem.id}" name="id" id="id"/>

			<div class="form-group">
				<label class="col-sm-3 control-label" for="name"><span class="text-red">*</span> 菜单项名称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="name" id="name" value="${menuItem.name}" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="name"> 菜单项图标</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="icon" id="icon" value="${menuItem.icon}">
				</div>
			</div>
			<c:if test="${not empty menuItem.url}">
				<div class="form-group">
					<label class="col-sm-3 control-label" for="url"><span class="text-red">*</span> 访问地址</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" name="url" id="url" value="${menuItem.url}" required>
					</div>
				</div>
			</c:if>
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
			messages: {
				name: {
					required: '菜单项名称不能为空'
				}
				<c:if test="${not empty menuItem.url}">
				, url: {required: '访问地址不能为空'}
				</c:if>
			}
		});

		console.log($("#id").val());

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/res/" + $("#id").val(),
			type: "put",
			beforeSubmit: function () {
				$("#mask").css("display", "block");
			},
			success: function (data) {
				if (data.status == 0) {
					$("#modalDialog").modal("hide");
					$("#mask").css("display", "none");
					swal("恭喜您!", data.message, "success");

					$('#menuTree').jstree(true).refresh();
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
