package me.wangcl.sm.entity;

import org.springframework.security.core.GrantedAuthority;

/**
 * 应用的 GrantedAuthority 实现类。
 *
 * @author wangcl
 */
public class AppAuthority implements GrantedAuthority {
	// 授权的字符串表示
	private String authortity;

	public AppAuthority(String authority) {
		this.authortity = authority;
	}

	@Override
	public String getAuthority() {
		return authortity;
	}

}
