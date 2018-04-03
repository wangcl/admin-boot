/*
 * 模态对话框
 */
function openModal(url, width, height) {
	if (url.indexOf("?") > 0) {
		url = url + "&";
	}
	else {
		url = url + "?";
	}
	$(".modal-content").load(url + Math.random());
	$(".modal-content").attr("style", "width:" + width + "px;height:" + height + "px;");
	$("#modalDialog").modal("show");
}
