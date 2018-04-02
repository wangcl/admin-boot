package me.wangcl.sm.entity;

import me.wangcl.core.entity.Entity;

/**
 * 数据库表实体对象：<code>S_USER_ROLE</code> (用户角色)
 *
 * @author wangcl
 */
public class UserRole extends Entity {
	private static final long serialVersionUID = -8965039300959453028L;

	private String id; // 主键标识
	private String roleId; // 角色标识
	private String userId; // 用户标识

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

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}

}
