<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>系统角色管理</title>
</head>
<body>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		系统角色管理
		<small><i>管理系统角色信息</i></small>
	</h1>
</section>
<!-- Main content -->
<section class="content">
	<!-- 查询条件 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h5 class="box-title">
				<i class="fa fa-book"></i> 查询条件
			</h5>
			<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
			</div>
		</div>
		<!-- 查询条件表单 -->
		<div class="box-body">
			<div class="row">
				<form id="searchForm">
					<div class="col-sm-3">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa"><span> 角色名称</span></i><!-- 调整查询参数 -->
							</div>
							<input id="qryName" type="text" class="form-control" name="qryName" placeholder="请输入角色名称">
						</div>
					</div>
					<div class="col-sm-9">
						<a type="button" class="btn btn-small btn-primary" href="#" id="searchBtn">
							<i class='fa fa-search'></i>&nbsp;&nbsp;查询
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 数据表格 -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h5 class="box-title"><i class="fa fa-th"></i> 查询结果</h5>
			<div class="box-tools pull-right" id="data-table-buttons"></div>
		</div>
		<div class="box-body">
			<table id="dataTable" class="table table-bordered table-striped">
				<thead>
				<tr>
					<th>ID</th>
					<th>角色编码</th>
					<th>角色名称</th>
					<th>操作</th>
				</tr>
				</thead>
			</table>
		</div>
	</div>

</section>

<script type="text/javascript">
	$(document).ready(function () {
		// 定位功能菜单
		highlightMenuItem('sys', 'role'); // 设置菜单id

		<!-- 数据表格处理 -->
		var table = $('#dataTable').DataTable({
			ajax: {
				url: "${ctx}/sys/role/search",
				data: function (d) {
					var formArray = $('#searchForm').serializeArray();
					for (var i = 0; i < formArray.length; i++) {
						d[formArray[i]['name']] = formArray[i]['value'];
					}
				},
				dataSrc: '', // 因返回数组，此处为空
				type: "POST"
			},
			columns: [
				{data: "id", visible: false},
				{data: "code", orderable: false},
				{data: "name", orderable: false},
				{data: null, orderable: false}
			],
			columnDefs: [
				{
					targets: 3, // 0-based，与columns中的"操作"一栏对应
					render: function (data, type, row, meta) {
						var operations = '';

						if (row.code != 'ADMIN') { // 管理员角色是系统预留，不能操作
							// 授权
							operations += '<a href="#" onclick=authz(\'' + row.id + '\')>'
								+ '<i class="fa fa-gear"></i>&nbsp;授权</a>';

							// 修改
							operations += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							operations += '<a href="#" onclick=edit(\'' + row.id + '\')>'
								+ '<i class="fa fa-pencil"></i>&nbsp;修改</a>';

							// 删除
							operations += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							operations += '<a href="#" onclick=del(\'' + row.id + '\')>'
								+ '<i class="fa fa-trash"></i>&nbsp;删除</a>';
						}

						return operations;
					}
				}
			],
			pageLength: 5
		});

		new $.fn.dataTable.Buttons(table, {
			buttons: [
				{
					extend: 'pageLength'
				},
				{
					extend: 'btnCreate',
					url: "${ctx}/sys/role/input",
					modelWidth: 500,
					modelHeight: 400
				}
			]
		});
		table.buttons(0, null).container().appendTo('#data-table-buttons');

		$("#searchBtn").on("click", function () {
			table.ajax.reload();
		});

	});

	function authz(id) {
		// openModal("${ctx}/sys/role/" + id + "/authz", 800, 600);
		window.open("${ctx}/sys/role/" + id + "/authz");
	}

	function edit(id) {
		openModal("${ctx}/sys/role/" + id + "/edit", 500, 400);
	}

	function del(id) {
		swal({
			title: "您确定要删除吗？",
			text: "将有 1 条记录被删除",
			type: "warning",
			showCancelButton: true,
			closeOnConfirm: false,
			confirmButtonText: "是的，我要删除",
			cancelButtonText: "取消",
			confirmButtonColor: "#DD6B55"
		}, function () {
			$.post("${ctx}/sys/role/" + id, {_method: "DELETE"}, function (data) {
				swal.close();
				$('#dataTable').DataTable().ajax.reload();
			})
		});
	}
</script>
</body>
</html>
