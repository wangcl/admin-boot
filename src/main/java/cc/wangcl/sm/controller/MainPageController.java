package cc.wangcl.sm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 系统主页Controller。
 *
 * @author wangcl
 */
@Controller
public class MainPageController {

	/**
	 * 显示首页。
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "index";
	}

}
