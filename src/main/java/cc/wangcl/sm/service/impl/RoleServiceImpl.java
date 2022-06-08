package cc.wangcl.sm.service.impl;

import cc.wangcl.sm.entity.MenuItem;
import cc.wangcl.sm.entity.Role;
import cc.wangcl.sm.entity.RoleMenuItem;
import cc.wangcl.sm.mapper.RoleMapper;
import cc.wangcl.sm.mapper.RoleMenuItemMapper;
import cc.wangcl.sm.mapper.UserRoleMapper;
import cc.wangcl.sm.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author wangcl
 */
@Service
@Transactional
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private UserRoleMapper userRoleMapper;

	@Autowired
	private RoleMenuItemMapper roleMenuItemMapper;

	@Override
	public String createRole(Role role) {
		if (getRoleByCode(role.getCode()) != null) {
			throw new IllegalArgumentException("角色编码已存在，请修改");
		}
		roleMapper.insert(role);
		return role.getId();
	}

	@Override
	public void updateRole(Role role) {
		Role _role = getRoleByCode(role.getCode());
		if ((_role != null) && !(_role.getId().equals(role.getId()))) {
			throw new IllegalArgumentException("角色编码已存在，请修改");
		}
		roleMapper.update(role);
	}

	@Override
	public void removeRole(String id) {
		if (isInUse(id)) {
			throw new RuntimeException("角色已被授权给用户使用，请首先解除授权再删除角色");
		}
		roleMapper.delete(id);
	}

	@Override
	@Transactional(readOnly = true)
	public Role getRole(String id) {
		return roleMapper.select(id);
	}

	@Override
	@Transactional(readOnly = true)
	public Role getRoleByCode(String code) {
		return roleMapper.selectByCode(code);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Role> getRoleList(String name) {
		return roleMapper.selectList(name);
	}

	@Override
	@Transactional(readOnly = true)
	public Role getRoleWithMenuItemsByCode(String code) {
		return roleMapper.selectRoleWithMenuItemsByCode(code);
	}

	@Override
	@Transactional(readOnly = true)
	public List<MenuItem> getAuthorizedMenuItems(String roleId) {
		return roleMenuItemMapper.selectMenuItemListByRole(roleId);
	}

	@Override
	public void authorize(String roleId, List<String> menuItemIds) {
		// 清除已有数据
		roleMenuItemMapper.deleteByRole(roleId);

		// 插入新数据
		for (String id : menuItemIds) {
			RoleMenuItem rmi = new RoleMenuItem();
			rmi.setRoleId(roleId);
			rmi.setMenuItemId(id);
			roleMenuItemMapper.insert(rmi);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public Boolean isInUse(String roleId) {
		int i = userRoleMapper.selectCountByRole(roleId);
		return i > 0;
	}

}
