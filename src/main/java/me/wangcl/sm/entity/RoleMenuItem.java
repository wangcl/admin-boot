package me.wangcl.sm.entity;

import me.wangcl.core.entity.Entity;

/**
 * 数据库表实体对象：<code>S_ROLE_MENU_ITEM</code> (角色菜单授权)
 *
 * @author wangcl
 */
public class RoleMenuItem extends Entity {
	private static final long serialVersionUID = 8219023725036506734L;

	private String id; // 主键标识
	private String roleId; // 角色标识
	private String menuItemId; // 菜单标识

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleId() {
		return roleId;
	}

	public String getMenuItemId() {
		return menuItemId;
	}

	public void setMenuItemId(String menuItemId) {
		this.menuItemId = menuItemId;
	}

}
