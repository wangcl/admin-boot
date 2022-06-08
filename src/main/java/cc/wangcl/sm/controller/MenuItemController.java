package cc.wangcl.sm.controller;

import cc.wangcl.core.entity.JsonResult;
import cc.wangcl.core.entity.TreeNode;
import cc.wangcl.sm.entity.MenuItem;
import cc.wangcl.sm.service.MenuItemService;
import cc.wangcl.sm.util.MenuItemTreeNodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * 功能菜单管理 controller。
 *
 * @author wangcl
 */
@Controller
@RequestMapping("/sys/res")
public class MenuItemController {

	@Autowired
	private MenuItemService menuItemService;

	/**
	 * 显示首页面<br>
	 * GET: /{model}<br>
	 * 返回: {model}/index.jsp
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "sys/res/index";
	}

	/**
	 * 获取目录树
	 *
	 * @return 目录树json数据
	 */
	@RequestMapping(value = "/tree", method = RequestMethod.GET)
	@ResponseBody
	public List<TreeNode> getMenuTree() {
		List<TreeNode> tree = new ArrayList<>(1);

		// 获取root节点
		MenuItem root = menuItemService.getRootMenuItem();
		if (root == null) throw new RuntimeException("没有配置根节点菜单");

		List<MenuItem> menuItemList = menuItemService.getSubMenuItemList(root.getId());

		// 从节点列表数据中删除root节点（后续不需要使用）
		for (MenuItem item : menuItemList) {
			if (root.getId().equals(item.getId())) {
				menuItemList.remove(item);
				break;
			}
		}

		TreeNode menu = new TreeNode();
		menu.setId(root.getId());
		menu.setIcon(root.getIcon());
		menu.setText(root.getName());

		MenuItemTreeNodeUtils.setMenuItemChildren(menu, menuItemList);

		tree.add(menu);

		return tree;
	}

	/**
	 * 显示新增页面<br>
	 * GET: /{model}/input/{pid}<br>
	 * 返回: {model}/input.jsp
	 */
	@RequestMapping(value = "/input/{pid}", method = RequestMethod.GET)
	public ModelAndView input(@PathVariable("pid") String pid) {
		ModelAndView mv = new ModelAndView("sys/res/input");

		mv.addObject("pid", pid);

		return mv;
	}

	/**
	 * 新增<br>
	 * POST: /{model}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult create(MenuItem menuItem) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("新增成功");

		try {
			menuItemService.createMenuItem(menuItem);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

	/**
	 * 列表页面点击修改单条记录时执行<br>
	 * GET: /{model}/{id}/edit<br>
	 * 返回: {model}/edit.jsp
	 */
	@RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
	public ModelAndView edit(@PathVariable("id") String id) {
		ModelAndView mv = new ModelAndView("sys/res/edit");
		MenuItem menuItem = menuItemService.getMenuItem(id);
		mv.addObject("menuItem", menuItem);
		return mv;
	}

	/**
	 * 修改页面提交保存后执行<br>
	 * PUT: /{model}/{id}<br>
	 * 返回: json数据
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public JsonResult update(@PathVariable("id") String id, MenuItem menuItem) {
		JsonResult json = new JsonResult();
		json.setStatus(0);
		json.setMessage("修改成功");

		menuItem.setId(id);
		try {
			menuItemService.updateMenuItem(menuItem);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

	/**
	 * 删除记录时执行<br>
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
			menuItemService.removeMenuItem(id);
		} catch (Exception e) {
			json.setStatus(-1);
			json.setMessage(e.getMessage());
		}

		return json;
	}

}
