package cc.wangcl.sm.controller;

import cc.wangcl.core.entity.JsonResult;
import cc.wangcl.sm.entity.MenuItem;
import cc.wangcl.sm.entity.Role;
import cc.wangcl.sm.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 角色管理 Controller.
 *
 * @author wangcl
 */
@Controller
@RequestMapping("/sys/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /**
     * 显示首页面<br>
     * GET: /{model}<br>
     * 返回: {model}/index.jsp
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "sys/role/index";
    }

    /**
     * 显示新增页面<br>
     * GET: /{model}/input<br>
     * 返回: {model}/input.jsp
     */
    @RequestMapping(value = "/input", method = RequestMethod.GET)
    public String input() {
        return "sys/role/input";
    }

    /**
     * 新增页面提交保存后执行<br>
     * POST: /{model}<br>
     * 返回: json数据
     */
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult create(Role role) {
        JsonResult json = new JsonResult();
        json.setStatus(0);
        json.setMessage("新增成功");

        try {
            roleService.createRole(role);
        } catch (Exception e) {
            json.setStatus(-1);
            json.setMessage(e.getMessage());
        }

        return json;
    }

    /**
     * 点击查询按钮后执行<br>
     * POST: /{model}/search<br>
     * 返回: json数组
     */
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    @ResponseBody
    public List<Role> search(@RequestParam(value = "qryName", required = false) String name) {
        return roleService.getRoleList(name);
    }

    /**
     * 列表页面点击修改单条记录时执行<br>
     * GET: /{model}/{id}/edit<br>
     * 返回: {model}/edit.jsp
     */
    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") String id) {
        ModelAndView mv = new ModelAndView("sys/role/edit");
        Role role = roleService.getRole(id);
        mv.addObject("role", role);
        return mv;
    }

    /**
     * 修改页面提交保存后执行<br>
     * PUT: /{model}/{id}<br>
     * 返回: json数据
     */
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult update(@PathVariable("id") String id, Role role) {
        JsonResult json = new JsonResult();
        json.setStatus(0);
        json.setMessage("修改成功");

        role.setId(id);
        try {
            roleService.updateRole(role);
        } catch (Exception e) {
            json.setStatus(-1);
            json.setMessage(e.getMessage());
        }

        return json;
    }

    /**
     * 列表页面点击授权单条记录时执行<br>
     * GET: /{model}/{id}<br>
     * 返回: {model}/view.jsp
     */
    @RequestMapping(value = "/{id}/authz", method = RequestMethod.GET)
    public ModelAndView config(@PathVariable("id") String id) {
        ModelAndView mv = new ModelAndView("sys/role/authz");
        Role role = roleService.getRole(id);
        mv.addObject("role", role);
        List<MenuItem> items = roleService.getAuthorizedMenuItems(id);
        mv.addObject("items", items);
        return mv;
    }

    /**
     * 授权页面提交后执行<br>
     * POST: /{model}/{id}<br>
     * 返回: json数据
     */
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult authz(@PathVariable("id") String id,
                            @RequestParam(value = "items", required = false) String[] items) {
        JsonResult json = new JsonResult();
        json.setStatus(0);
        json.setMessage("角色功能授权成功");

        List<String> list = new ArrayList<>();
        if (items != null && items.length > 0) {
            list = Arrays.asList(items);
        }

        try {
            roleService.authorize(id, list);
        } catch (Exception e) {
            json.setStatus(-1);
            json.setMessage(e.getMessage());
        }

        return json;
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
            roleService.removeRole(id);
        } catch (Exception e) {
            json.setStatus(-1);
            json.setMessage(e.getMessage());
        }

        return json;
    }

}
