package cc.wangcl.sm.service;

import cc.wangcl.sm.entity.MenuItem;
import cc.wangcl.sm.entity.Role;

import java.util.List;

/**
 * 角色管理服务。
 *
 * @author wangcl
 */
public interface RoleService {

	/**
	 * 创建角色。
	 *
	 * @param role 角色信息
	 * @return 角色标识
	 */
	String createRole(Role role);

	/**
	 * 更新角色信息。
	 *
	 * @param role 角色信息
	 */
	void updateRole(Role role);

	/**
	 * 删除角色信息。
	 *
	 * @param id 角色标识
	 */
	void removeRole(String id);

	/**
	 * 根据主键获取角色信息。
	 *
	 * @param id 角色标识
	 * @return 角色信息
	 */
	Role getRole(String id);

	/**
	 * 根据角色编码获取角色信息。
	 *
	 * @param code 角色编码
	 * @return 角色信息
	 */
	Role getRoleByCode(String code);

	/**
	 * 查询满足条件的角色列表。
	 *
	 * @param name 角色名称
	 * @return 角色列表
	 */
	List<Role> getRoleList(String name);

	/**
	 * 根据角色编码获取包含功能菜单列表的角色信息。
	 *
	 * @param code 角色编码
	 * @return 包含功能菜单列表的角色信息
	 */
	Role getRoleWithMenuItemsByCode(String code);

	/**
	 * 获取指定角色的已授权的菜单列表。
	 *
	 * @param roleId 角色标识
	 * @return 菜单列表
	 */
	List<MenuItem> getAuthorizedMenuItems(String roleId);

	/**
	 * 为指定角色分配功能菜单。
	 *
	 * @param roleId 角色标识
	 * @param menuItemIds 功能菜单标识列表
	 */
	void authorize(String roleId, List<String> menuItemIds);

	/**
	 * 角色是否在用。<br>
	 * 通过 s_user_role 表中是否有记录来判断。
	 *
	 * @param roleId 角色标识
	 * @return true or false
	 */
	Boolean isInUse(String roleId);

}
