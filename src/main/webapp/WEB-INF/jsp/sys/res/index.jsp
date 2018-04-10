<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>系统菜单项管理</title>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_sweetalert" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_jstree" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jstree" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryform" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryvalidation" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_sweetalert" %>
</head>
<body>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		系统菜单项管理
		<small><i>管理系统菜单项信息</i></small>
	</h1>
</section>
<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-sm-4">
			<div class="box box-solid">
				<div class="box-header with-border">
					菜单树
				</div>
				<div class="box-body">
					<div id="menuTree">
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-8">
			<div class="box box-solid">
				<div class="box-header with-border">
					菜单项信息
				</div>
				<div class="box-body">
					<div id="itemInfoViewDiv" style="display: none">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="view_id">菜单编码</label>
							<div class="col-sm-10">
								<p id="view_id" class="form-control-static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="view_text">菜单名称</label>
							<div class="col-sm-10">
								<p id="view_text" class="form-control-static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="view_icon">菜单图标</label>
							<div class="col-sm-10">
								<p id="view_icon" class="form-control-static"></p>
							</div>
						</div>
						<div id="urlDiv" class="form-group">
							<label class="col-sm-2 control-label" for="view_url">访问地址</label>
							<div class="col-sm-10">
								<p id="view_url" class="form-control-static"></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 通用modal外框 -->
<div class="modal fade" id="modalDialog" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function () {
		// 定位功能菜单
		highlightMenuItem('sys', 'res'); // 设置菜单id

		$('#menuTree').jstree({
			'core': {
				"multiple": false,
				"themes": {
					"dots": false
				},
				'data': {
					'url': '${ctx}/sys/res/tree',
					'dataType': 'json'
				}
			},
			'contextmenu': {
				'items': function (node) {
					var items = {};

					var addItem = {
						label: "创建",
						icon: 'fa fa-plus',
						action: function (obj) {
							console.log("Add: " + node.id);

							openModal("${ctx}/sys/res/input/" + node.id, 500, 400);
						}
					};
					var editItem = {
						label: "编辑",
						icon: 'fa fa-edit',
						action: function (obj) {
							console.log("Edit: " + node.id);

							openModal("${ctx}/sys/res/" + node.id + "/edit", 500, 400);
						}
					};
					var delItem = {
						label: "删除",
						icon: 'fa fa-trash',
						action: function (obj) {
							console.log("Del: " + node.id);

							swal({
								title: "您确定要删除吗？",
								text: "本菜单项及所有子菜单将全部被删除",
								type: "warning",
								showCancelButton: true,
								closeOnConfirm: false,
								confirmButtonText: "是的，我要删除",
								cancelButtonText: "取消",
								confirmButtonColor: "#DD6B55"
							}, function () {
								$.post("${ctx}/sys/res/" + node.id, {_method: "DELETE"}, function (data) {
									swal.close();
									$('#menuTree').jstree(true).refresh();
								})
							});
						}
					};

					if (node.id === "root") { // 根节点
						items.addItem = addItem;
					} else {
						if (!node.data) { // 非叶子节点
							items.addItem = addItem;
						}
						items.editItem = editItem;
						items.delItem = delItem;
					}

					return items;
				},
				'select_node': false // 右键不触发节点选中事件
			},
			'plugins': ['contextmenu']
		});

		// 菜单树节点的点击（选中）事件
		$('#menuTree').on("select_node.jstree", function (e, data) {
			// console.log(data.node);

			var item = data.node;
			$('#view_id').html(item.id);
			$('#view_icon').html(item.icon);
			$('#view_text').html(item.text);
			if (item.data) {
				$('#view_url').html(item.data);
				$('#urlDiv').show();
			} else {
				$('#urlDiv').hide();
			}

			$('#itemInfoViewDiv').show();
		});
	});
</script>
</body>
</html>
