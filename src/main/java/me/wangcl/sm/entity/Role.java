package me.wangcl.sm.entity;

import me.wangcl.core.entity.Entity;

import java.util.List;

/**
 * 数据库表实体对象：<code>S_ROLE</code> (系统角色)
 *
 * @author wangcl
 */
public class Role extends Entity {
	private static final long serialVersionUID = -3380779533939137552L;

	private String id; // 角色标识，主键
	private String code; // 角色编码
	private String name; // 角色名称

	private List<MenuItem> menuItemList; // 功能菜单项列表

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCode() {
		return code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public List<MenuItem> getMenuItemList() {
		return menuItemList;
	}

	public void setMenuItemList(List<MenuItem> menuItemList) {
		this.menuItemList = menuItemList;
	}

}
