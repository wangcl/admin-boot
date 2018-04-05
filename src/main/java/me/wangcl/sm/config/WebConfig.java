package me.wangcl.sm.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * web config.
 *
 * @author wangcl
 */
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

	/**
	 * 设置 sitemesh 过滤器。
	 *
	 * @return
	 */
	@Bean
	public FilterRegistrationBean siteMeshFilter() {
		FilterRegistrationBean filter = new FilterRegistrationBean();
		SiteMeshFilter siteMeshFilter = new SiteMeshFilter();
		filter.setFilter(siteMeshFilter);
		return filter;
	}

}
