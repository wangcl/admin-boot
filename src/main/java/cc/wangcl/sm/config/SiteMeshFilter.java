package cc.wangcl.sm.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

/**
 * SiteMesh过滤器。
 *
 * @author wangcl
 */
public class SiteMeshFilter extends ConfigurableSiteMeshFilter {

	private static final String DECORATORS_PATH = "/WEB-INF/jsp/decorator/";

	private static final String DECORATOR_HEAD = DECORATORS_PATH + "html-head.jsp";
	private static final String DECORATOR_MAIN = DECORATORS_PATH + "mainframe.jsp";
	private static final String DECORATOR_CRUD = DECORATORS_PATH + "crud-index.jsp";

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.
				addDecoratorPaths("/", // 系统主页
						DECORATOR_HEAD,
						DECORATOR_MAIN)
				.addDecoratorPaths("/sys/user", // 用户管理主页面
						DECORATOR_HEAD,
						DECORATOR_CRUD,
						DECORATOR_MAIN)
				.addDecoratorPaths("/sys/role", // 角色管理主页面
						DECORATOR_HEAD,
						DECORATOR_CRUD,
						DECORATOR_MAIN)
				.addDecoratorPaths("/sys/res", // 资源管理主页面
						DECORATOR_HEAD,
						DECORATOR_MAIN)
				.addExcludedPath("/login") // 登录页面
				.addExcludedPath("/logout") // 登出
				.addExcludedPath("/**/*") // 请求默认不进行装饰（防止被"/"拦截）
		;
	}

}
