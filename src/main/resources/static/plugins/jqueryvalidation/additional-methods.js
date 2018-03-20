/*
 * 扩展自定义的 jQuery validation 校验规则
 */
(function (factory) {
	if (typeof define === "function" && define.amd) {
		define(["jquery", "./jquery.validate.min-1.17.0"], factory);
	} else if (typeof module === "object" && module.exports) {
		module.exports = factory(require("jquery"));
	} else {
		factory(jQuery);
	}
}(function ($) {

	// 电话号码
	jQuery.validator.addMethod("phone", function(value, element) {
		var length = value.length;
		var mobile = /^1\d{10}$/; // /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
		return this.optional(element) || tel.test(value) || (length == 11 && mobile.test(value));
	}, "请正确填写电话号码");

	// 邮政编码
	jQuery.validator.addMethod("zipcode", function(value, element) {
		var zipCode = /^[0-9]{6}$/;
		return this.optional(element) || (zipCode.test(value));
	}, "请正确填写邮政编码");

}));
