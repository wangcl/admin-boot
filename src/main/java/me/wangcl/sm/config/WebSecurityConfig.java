package me.wangcl.sm.config;

import me.wangcl.sm.service.impl.UserDetailServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * Spring Security config.
 *
 * @author wangcl
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	@Bean
	public UserDetailsService userDetailsService() { // 使用自定义的UserDetailsService
		return new UserDetailServiceImpl();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
				.authorizeRequests() // 针对HTTP Request
				.anyRequest().authenticated() // 所有请求都必须登录才能访问

                .and()
				.formLogin()
				.loginPage("/login") // 设置自定义的登录页面
				.defaultSuccessUrl("/") // 登录成功跳转页面
				.failureUrl("/login?error") // 登录失败跳转页面
				.permitAll() // 登录页面所有人均可访问

                .and()
				.logout()
				// .logoutUrl("/logout") // 默认/logout
				// .logoutSuccessUrl("/") // 默认重定向到/login?logout
				.permitAll() // 使用默认的登出页面（/logout），所有人均可访问

                .and()
				.rememberMe() // 开启remember me功能
				.key("adminboot") // 项目使用的私钥
				.rememberMeCookieName("adminboot-remember-me") // cookie的名字
				.rememberMeParameter("rememberMe") // form提交时使用的参数名，默认remember-me
				.tokenValiditySeconds(60 * 60 * 24 * 7 * 2) // cookie的过期时间，默认7天

                .and()
				.csrf().disable() // 禁用Spring Security自带的抵御跨域伪造攻击处理，因其要求form表单中包含_csrf token信息
		;
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService());
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		// 不拦截静态资源
		web.ignoring().antMatchers(
				"/adminlte/**",
				"/app/**",
				"/bootstrap/**",
				"/jquery/**",
				"/plugins/**"
		);
	}

}
