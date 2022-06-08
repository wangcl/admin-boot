package cc.wangcl.sm.controller;

import cc.wangcl.core.entity.JsonResult;
import cc.wangcl.sm.entity.User;
import cc.wangcl.sm.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

/**
 * 用户个人信息处理控制器。
 *
 * @author wangcl
 */
@Controller
@RequestMapping("/profile")
public class ProfileController {
	private static Logger logger = LoggerFactory.getLogger(ProfileController.class);

	@Autowired
	private UserService userService;

	/**
	 * 显示修改密码页面<br>
	 * GET /profile/{account}/changePassword<br>
	 * 返回: /profile/changePassword.jsp
	 *
	 * @return
	 */
	@RequestMapping(value = "/{account}/changePassword", method = RequestMethod.GET)
	public ModelAndView changePasswordPage(@PathVariable("account") String account) {
		ModelAndView mv = new ModelAndView("sys/user/changePassword");
		User user = userService.queryByAccount(account);
		mv.addObject("user", user);
		return mv;
	}

	/**
	 * 修改密码提交保存后执行<br>
	 * PUT: /profile/{id}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public JsonResult changePassword(@PathVariable("id") String id,
									 @RequestParam(required = true) String password,
									 @RequestParam(required = true) String newPassword) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("修改成功");

		// 校验旧密码
		User userInDb = userService.queryById(id);
		if (!password.equals(userInDb.getPassword())) {
			json.setStatus(-1);
			json.setMessage("密码错误，请重新输入");
			return json;
		}

		// 更新密码
		User user = new User();
		user.setId(id);
		user.setPassword(newPassword);
		try {
			userService.update(user);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

}
