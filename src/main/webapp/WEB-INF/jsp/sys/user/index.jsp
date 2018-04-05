<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>用户管理</title>

	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_datepicker" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_datepicker" %>
</head>
<body>

<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		用户管理
		<small><i>管理系统用户信息</i></small>
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
				<form id="qryForm">
					<div class="col-sm-3">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa"><span>账号</span></i>
							</div>
							<input id="account" type="text" class="form-control" name="account" placeholder="请输入账号">
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa"><span>姓名</span></i>
							</div>
							<input id="name" type="text" class="form-control" name="name" placeholder="请输入名称">
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa"><span>创建时间</span></i>
							</div>
							<input id="fromDateString" type="text" class="form-control" name="fromDateString"
								   placeholder="请选择时间">
						</div>
					</div>
					<div class="col-sm-3">
						<a type="button" class="btn btn-small btn-primary" href="#" id="btnQry">
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
					<th>账号</th>
					<th>姓名</th>
					<th>邮箱</th>
					<th>电话</th>
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
		highlightMenuItem('sys', 'user');

		$('#fromDateString').datepicker({
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayHighlight: true,
			language: 'zh-CN'
		});

		<!-- 数据表格处理 -->
		var table = $('#dataTable').DataTable({
			serverSide: true,
			ajax: {
				url: "${ctx}/sys/user/query",
				data: function (d) {
					var formArray = $('#qryForm').serializeArray();
					for (var i = 0; i < formArray.length; i++) {
						d[formArray[i]['name']] = formArray[i]['value'];
					}
				},
				// dataSrc: '',
				type: "POST"
			},
			columns: [
				{data: "id", visible: false},
				{data: "account"},
				{data: "name"},
				{data: "email", orderable: false},
				{data: "phone", orderable: false},
				{data: null, orderable: false}
			],
			columnDefs: [
				{
					targets: 5,
					render: function (data, type, row, meta) {
						var operations = '';

						// 查看
						operations += '<a href="#" onclick=view(\'' + row.id + '\')>'
							+ '<i class="fa fa-info"></i>&nbsp;查看</a>';

						// 修改
						<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('user_U', 'user_F')">
						operations += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						operations += '<a href="#" onclick=edit(\'' + row.id + '\')>'
							+ '<i class="fa fa-pencil"></i>&nbsp;修改</a>';
						</se:authorize>

						if ('admin' != data.account) { // 管理员用户不能删除、授权
							// 删除
							<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('user_D', 'user_F')">
							operations += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							operations += '<a href="#" onclick=del(\'' + row.id + '\')>'
								+ '<i class="fa fa-trash"></i>&nbsp;删除</a>';
							</se:authorize>

							// 角色授权
							<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('user_F')">
							operations += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							operations += '<a href="#" onclick=auth(\'' + row.account + '\')>'
								+ '<i class="fa fa-trash"></i>&nbsp;授权</a>';
							</se:authorize>
						}

						return operations;
					}
				}
			],
			pageLength: 5,
			order: [[1, 'asc']]
		});

		new $.fn.dataTable.Buttons(table, {
			buttons: [
				{
					extend: 'pageLength'
				}
				<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('user_C', 'user_F')">
				,
				{
					extend: 'btnCreate',
					url: "${ctx}/sys/user/input",
					modelWidth: 550,
					modelHeight: 550
				}
				</se:authorize>
			]
		});
		table.buttons(0, null).container().appendTo('#data-table-buttons');

		$("#btnQry").on("click", function () {
			table.ajax.reload();
		});

	});

	function view(id) {
		console.log('view clicked, id=' + id);
		openModal("${ctx}/sys/user/" + id, 500, 400);
	}

	function edit(id) {
		console.log('edit clicked, id=' + id);
		openModal("${ctx}/sys/user/" + id + "/edit", 550, 550);
	}

	function del(id) {
		console.log('delete clicked, id=' + id);
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
			$.post("${ctx}/sys/user/" + id, {_method: "DELETE"}, function (data) {
				swal.close();
				$('#dataTable').DataTable().ajax.reload();
			})
		});
	}

	function auth(account) {
		openModal("${ctx}/sys/user/" + account + "/authz", 550, 550);
	}
</script>
</body>
</html>
