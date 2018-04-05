/*
 * DataTables默认设置
 */
$.extend($.fn.dataTable.defaults, {
	paging: true,
	lengthChange: false,
	searching: false,
	ordering: true,
	info: true,
	autoWidth: false,
	paginationType: "full_numbers",
	language: {
		lengthMenu: "每页显示 _MENU_ 条记录",
		info: "从 _START_ 到 _END_ / 共 _TOTAL_ 条数据",
		infoEmpty: "没有数据",
		infoFiltered: "(从 _MAX_ 条数据中检索)",
		zeroRecords: "没有检索到数据",
		emptyTable: "没有检索到数据",
		search: "查询:",
		processing: "正在查询，请等待...",
		paginate: {
			"first": "首页",
			"previous": "上页",
			"next": "下页",
			"last": "末页"
		},
		select: {
			rows: {
				_: "选中 %d 行记录"
				// 0: ""
			}

		},
		buttons: {
			pageLength: '<i class="fa fa-bookmark-o"> 每页 %d 行 </i>'
		}
	},
	columns : {
		defaultContent : ""
	},
	lengthMenu: [
		[ 5, 10, 15 ],
		[ '每页 5 行', '每页 10 行', '每页 15 行' ]
	],
	processing: true //打开数据加载时的等待效果
	// serverSide: true,  //打开后台分页
	// serverMethod: "POST",
	// serverParams: function (aoData) {  //查询条件
	// 	if($("#searchConditionForm")) {
	// 		var formData = $("#searchConditionForm").serializeArray();
	// 		$.each(formData, function (i, n) {
	// 			aoData.push({name: n.name, value: n.value});
	// 		});
	// 	}
	// }
});

$.fn.dataTable.ext.buttons.btnCreate = {
	className: 'btn btn-small',
	text: '<i class="fa fa-plus-square-o"> 新增 </i>',
	url : "",
	func : "",
	modelWidth : 640,
	modelHeight : 480,
	action: function (e, dt, node, config) {
		if(config.func != "") {
			eval(config.func + "()");
			return;
		}

		openModal(config.url, config.modelWidth, config.modelHeight);
	}
};
