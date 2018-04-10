<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>新增系统菜单项信息</title>
</head>
<body>
<form id="dataForm" class="form-horizontal">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">增加系统菜单项</h4>
	</div>
	<div class="modal-body">
		<div class="content scroller">
			<input type="hidden" name="pid" value="${pid}">

			<div class="form-group">
				<label class="col-sm-3 control-label" for="id"><span class="text-red">*</span> 菜单项标识</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="id" id="id" placeholder="请输入菜单项标识，如：user" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="name"><span class="text-red">*</span> 菜单项名称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="name" id="name" placeholder="请输入菜单项名称" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="name"> 菜单项图标</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="icon" id="icon"
						   placeholder="请输入图标路径或css的class名称，为空则使用默认图标">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="url"> 访问地址</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="url" id="url" placeholder="请输入访问地址。如果是目录，则留空">
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
			messages: {
				id: {
					required: '菜单项标识不能为空'
				},
				name: {
					required: '菜单项名称不能为空'
				}
			}
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/res",
			type: "post",
			beforeSerialize: function ($form, options) {
				// 数据预处理
			},
			beforeSubmit: function () {
				$("#mask").css("display", "block");
			},
			success: function (data) {
				if (data.status == 0) {
					$("#modalDialog").modal("hide");
					$("#mask").css("display", "none");
					swal("恭喜您!", data.message, "success");

					// 重新加载菜单树
					$('#menuTree').jstree(true).refresh();
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
