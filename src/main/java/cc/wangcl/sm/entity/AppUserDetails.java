package cc.wangcl.sm.entity;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

/**
 * 应用的 UserDetails 实现类。
 *
 * @author wangcl
 */
public class AppUserDetails implements UserDetails {
	private static final long serialVersionUID = -8432927829127197895L;

	private User user; // 系统用户信息

	private Collection<AppAuthority> authorities; // 授权信息

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		return user.getAccount();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setAuthorities(Collection<AppAuthority> authorities) {
		this.authorities = authorities;
	}

}
