package me.wangcl.sm.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 用户登录控制器。
 *
 * @author wangcl
 */
@Controller
public class LoginController {
	private static Logger logger = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 显示登录页面。
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String index() {
		return "login";
	}

}
