package me.wangcl.sm.controller;

import com.github.pagehelper.PageInfo;
import me.wangcl.core.entity.DataTablesPagingRequest;
import me.wangcl.core.entity.DataTablesPagingResult;
import me.wangcl.core.entity.JsonResult;
import me.wangcl.core.util.DataTablesUtils;
import me.wangcl.sm.entity.Role;
import me.wangcl.sm.entity.User;
import me.wangcl.sm.service.RoleService;
import me.wangcl.sm.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 用户管理功能控制器。
 *
 * @author wangcl
 */
@Controller
@RequestMapping("/sys/user")
public class UserController {
	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	/**
	 * 显示首页面<br>
	 * GET: /{model}<br>
	 * 返回: {model}/index.jsp
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	@PreAuthorize("hasRole('ADMIN') or hasAnyAuthority('user')")
	public String index() {
		return "sys/user/index";
	}

	/**
	 * 显示新增页面<br>
	 * GET: /{model}/input<br>
	 * 返回: {model}/input.jsp
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input() {
		return "sys/user/input";
	}

	/**
	 * 新增页面提交保存后执行<br>
	 * POST: /{model}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult create(User user) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("新增成功");

		user.setCreateTime(new Date());

		try {
			userService.create(user);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

	/**
	 * 点击查询按钮后执行（物理分页）<br>
	 * POST: /{model}/search<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "/query", method = RequestMethod.POST)
	@ResponseBody
	public DataTablesPagingResult<User> query(HttpServletRequest request,
											  @RequestParam(required = false) String account,
											  @RequestParam(required = false) String name,
											  @RequestParam(required = false) String fromDateString,
											  @RequestParam(required = false) String toDateString) {
		DataTablesPagingRequest dt = DataTablesUtils.processPagingRequest(request);

		int pageSize = dt.getLength();
		int pageNum = dt.getStart() / dt.getLength() + 1;

		Date fromDate = null, toDate = null;
		if (StringUtils.isNotEmpty(fromDateString)) {
			try {
				fromDate = DateUtils.parseDate(fromDateString, "yyyy-MM-dd");
			} catch (ParseException e) {
				logger.warn(e.getMessage());
			}
		}
		if (StringUtils.isNotEmpty(toDateString)) {
			try {
				toDate = DateUtils.parseDate(toDateString, "yyyy-MM-dd");
			} catch (ParseException e) {
				logger.warn(e.getMessage());
			}
		}

		// 通过PageHelper插件实现分页查询
		List<User> users = userService.queryListPaging(account, name, fromDate, toDate, pageNum, pageSize);
		PageInfo page = new PageInfo(users);

		DataTablesPagingResult<User> pr = new DataTablesPagingResult<>();
		pr.setData(users);
		pr.setRecordsTotal(page.getTotal());
		pr.setRecordsFiltered(page.getTotal());
		pr.setDraw(Integer.valueOf(dt.getDraw()));

		return pr;
	}

	/**
	 * 列表页面点击修改单条记录时执行<br>
	 * GET: /{model}/{id}/edit<br>
	 * 返回: {model}/edit.jsp
	 */
	@RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
	public ModelAndView edit(@PathVariable("id") String id) {
		ModelAndView mv = new ModelAndView("sys/user/edit");
		User user = userService.queryById(id);
		mv.addObject("user", user);
		return mv;
	}

	/**
	 * 修改页面提交保存后执行<br>
	 * PUT: /{model}/{id}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public JsonResult update(@PathVariable("id") String id, User user) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("修改成功");

		user.setId(id);
		try {
			userService.update(user);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

	/**
	 * 列表页面点击显示单条记录时执行<br>
	 * GET: /{model}/{id}<br>
	 * 返回: {model}/view.jsp
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ModelAndView view(@PathVariable("id") String id) {
		ModelAndView mv = new ModelAndView("sys/user/view");
		User user = userService.queryById(id);
		mv.addObject("user", user);
		return mv;
	}

	/**
	 * 列表页面删除记录时执行<br>
	 * DELETE: /{model}/{id}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public JsonResult delete(@PathVariable("id") String id) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("删除成功");

		try {
			userService.delete(id);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

	/**
	 * 列表页面点击授权单条记录时执行<br>
	 * GET: /{model}/{account}/auth<br>
	 * 返回: {model}/auth.jsp
	 */
	@RequestMapping(value = "/{account}/authz", method = RequestMethod.GET)
	public ModelAndView config(@PathVariable("account") String account) {
		ModelAndView mv = new ModelAndView("sys/user/authz");
		User user = userService.queryUserDetailsByAccount(account);
		mv.addObject("user", user);
		List<Role> roles = roleService.getRoleList(null);
		mv.addObject("roles", roles);
		return mv;
	}

	/**
	 * 授权页面提交后执行<br>
	 * POST: /{model}/{id}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "/{id}/authz", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult authz(@PathVariable("id") String id,
							@RequestParam(value = "roles", required = false) String[] roles) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("用户角色授权成功");

		List<String> list = new ArrayList<>();
		if (roles != null && roles.length > 0) {
			list = Arrays.asList(roles);
		}

		try {
			userService.authorize(id, list);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

	/**
	 * 获取用户已授予的角色标识的列表。
	 *
	 * @param userId 用户标识
	 * @return json数据
	 */
	@RequestMapping(value = "/role/{userId}", method = RequestMethod.GET)
	@ResponseBody
	public List<String> roles(@PathVariable("userId") String userId) {
		return userService.getAuthorizedRoleIds(userId);
	}

}
