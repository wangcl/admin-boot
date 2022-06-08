package cc.wangcl.sm.service.impl;

import cc.wangcl.sm.entity.AppAuthority;
import cc.wangcl.sm.entity.AppUserDetails;
import cc.wangcl.sm.entity.MenuItem;
import cc.wangcl.sm.entity.Role;
import cc.wangcl.sm.entity.User;
import me.wangcl.sm.entity.*;
import cc.wangcl.sm.service.RoleService;
import cc.wangcl.sm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Collection;
import java.util.HashSet;

/**
 * 应用自定义的 UserDetailsService 实现。
 *
 * @author wangcl
 */
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		AppUserDetails userDetails = new AppUserDetails();
		User user = userService.queryUserDetailsByAccount(username);
		if (user == null) {
			throw new UsernameNotFoundException(username);
		}
		userDetails.setUser(user);

		// 根据角色设置权限
		Collection<AppAuthority> authorities = new HashSet<>();
		for (Role role : user.getRoleList()) {
			// 添加角色授权，根据Spring Security的要求，格式为"ROLE_角色编码"，如"ROLE_ADMIN"
			authorities.add(new AppAuthority("ROLE_" + role.getCode()));
			if (! "ADMIN".equals(role.getCode())) { // 非管理员，读取角色的菜单授权，格式为"菜单编码"，如"user"
				Role _role = roleService.getRoleWithMenuItemsByCode(role.getCode());
				for (MenuItem item : _role.getMenuItemList()) {
					authorities.add(new AppAuthority(item.getId()));
				}
			}
		}
		userDetails.setAuthorities(authorities);

		return userDetails;
	}

}
