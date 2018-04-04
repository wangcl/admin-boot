package me.wangcl.sm.service;

import me.wangcl.sm.entity.MenuItem;

import java.util.List;

/**
 * 功能菜单管理 service。
 *
 * @author wangcl
 */
public interface MenuItemService {

	String createMenuItem(MenuItem menuItem);

	void updateMenuItem(MenuItem menuItem);

	/**
	 * 删除指定菜单项。<br>
	 * 如果是目录（非叶子节点），<strong>级联删除</strong>其下的所有菜单项数据。
	 *
	 * @param id 菜单项标识
	 */
	void removeMenuItem(String id);

	MenuItem getMenuItem(String id);

	List<MenuItem> getMenuItemList(/* type1 param1, type2 param2, ... */);

	/**
	 * 递归查询某菜单的所有子菜单列表。
	 *
	 * @param menuItemId 菜单项标识
	 * @return 子菜单列表
	 */
	List<MenuItem> getSubMenuItemList(String menuItemId);

	/**
	 * 获取根节点菜单。
	 *
	 * @return 根节点菜单
	 */
	MenuItem getRootMenuItem();

}
