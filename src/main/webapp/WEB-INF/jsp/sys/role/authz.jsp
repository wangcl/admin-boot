<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/WEB-INF/jsp/include/head_meta" %>
	<title>系统角色授权</title>
	<%@ include file="/WEB-INF/jsp/include/head_css_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_fonticon" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_app" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_base" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_app" %>

	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_jstree" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jstree" %>
	<%@ include file="/WEB-INF/jsp/include/head_css_plugin_sweetalert" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_sweetalert" %>
	<%@ include file="/WEB-INF/jsp/include/head_js_plugin_jqueryform" %>
</head>
<body>
<div class="modal-header">
	<%--<button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
	<%--<span aria-hidden="true">&times;</span></button>--%>
	<h4 class="modal-title">系统角色授权</h4>
</div>
<div class="modal-body"><!-- style="height: 480px; overflow-y: scroll;" -->
	<div class="content scroller">
		<div class="row">
			<label class="col-sm-2 control-label" for="code">角色编码</label>
			<div class="col-sm-4">
				<p id="code" class="form-control-static">${role.code}</p>
			</div>
			<label class="col-sm-2 control-label" for="name">角色名称</label>
			<div class="col-sm-4">
				<p id="name" class="form-control-static">${role.name}</p>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<hr>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<p class="text-center"><strong>功能菜单</strong>
					<small><i>（通过右键菜单选择）</i></small>
				</p>
			</div>
			<div class="col-sm-6">
				<p class="text-center"><strong>已选择</strong>
					<small><i>（复选框选择，点击“删除”按钮从列表中清除）</i></small>
				</p>
			</div>
		</div>
		<div class="row">
			<div id="menuTree" class="col-sm-6">

			</div>
			<div class="col-sm-6">
				<form id="dataForm" class="form-horizontal">
					<input type="hidden" id="roleId" name="roleId" value="${role.id}">
					<c:forEach var="item" items="${items}">
						<div id="div_${item.id}" class="row">
							<div class="col-sm-12">
								<input type="hidden" name="items" value="${item.id}">
								<div class="checkbox">
									<label>
										<input type="checkbox" name="cbItem" value="${item.id}"> ${item.name}
									</label>
								</div>
							</div>
						</div>
					</c:forEach>
				</form>
				<div id="divRemove" class="row">
					<div class="col-sm-6"></div>
					<div class="col-sm-6">
						<button type="button" class="btn btn-sm btn-primary" id="btnRemove">删除</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal-footer">
	<button id="btnSubmit" type="button" class="btn btn-default">确定</button>
	<button id="btnClose" type="button" class="btn btn-default">关闭</button>
</div>

<script>
	$(document).ready(function () {
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
						label: "添加",
						icon: 'fa fa-plus',
						action: function (obj) {
							if ($('#div_' + node.id).length == 0) { // “已选择”列表中不存在，则增加（增加的元素与上方forEach相同）
								$('#dataForm').append(
									"<div id='div_" + node.id + "' class='row'>"
									+ "<div class='col-sm-12'>"
									+ "<input type='hidden' name='items' value='" + node.id + "'>"
									+ "<div class='checkbox'>"
									+ "<label>"
									+ "<input type='checkbox' name='cbItem' value='" + node.id + "'> " + node.text
									+ "</label>"
									+ "</div>"
									+ "</div>"
									+ "</div>"
								);
							}

							handleBtnRemove();
						}
					};

					if (node.data) { // 叶子节点
						items.addItem = addItem;
					}

					return items;
				},
				'select_node': false // 右键不触发节点选中事件
			},
			'plugins': ['contextmenu']
		});

		$('#btnRemove').on('click', function () {
			// 获取选中的复选框
			var $cb = $("input[name='cbItem']:checkbox:checked");

			// 从“已选择”中清除
			$.each($cb, function (idx, obj) {
				console.log("idx:" + idx + ",value:" + obj.value);
				var divId = "div_" + obj.value;
				$('#' + divId).remove();
			});

			handleBtnRemove();
		});

		$('#btnClose').on('click', function () {
			swal({
				title: "您确定要取消所有修改并关闭窗口吗？",
				text: "",
				type: "warning",
				showCancelButton: true,
				closeOnConfirm: false,
				confirmButtonText: "是的，我要关闭",
				cancelButtonText: "取消",
				confirmButtonColor: "#DD6B55"
			}, function () {
				swal.close();
				window.close();
			});
		});

		$('#btnSubmit').on('click', function () {
			$("#dataForm").submit();
		});

		$("#dataForm").ajaxForm({
			url: "${ctx}/sys/role/" + $('#roleId').val(),
			type: "post",
			beforeSerialize: function ($form, options) {
				// 数据预处理
			},
			beforeSubmit: function () {
			},
			success: function (data) {
				if (data.status == 0) {
					swal(
						{
							title: "恭喜您!",
							text: data.message,
							type: "success"
						},
						function () {
							window.close();
						});
				} else {
					swal("授权失败!", data.message, "error");
				}
			},
			error: function callback(e, xhr, opt) {
				swal("很遗憾!", "授权失败", "error");
			}
		});

		handleBtnRemove();
	});

	// “已选择”区域的“删除”按钮是否显示
	function handleBtnRemove () {
		var $cb = $("input[name='cbItem']:checkbox");
		if ($cb.length > 0) {
			$("#divRemove").show();
		} else {
			$("#divRemove").hide();
		}
	};
</script>

</body>
</html>
