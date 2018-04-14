<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title><sitemesh:write property='title'/></title>
	<sitemesh:write property='head'/>
</head>

<body class="hold-transition skin-blue-light sidebar-mini">
<div class="wrapper">
	<header class="main-header">
		<!-- Logo -->
		<a href="${ctx}/" class="logo">
			<!-- mini logo for sidebar mini 50x50 pixels -->
			<span class="logo-mini"><img src="${ctx}/app/images/app_logo.png" width="32" height="32" alt="app"></span>
			<!-- logo for regular state and mobile devices -->
			<span class="logo-lg">
				<img src="${ctx}/app/images/app_logo.png" width="32" height="32" alt="app">&nbsp;Admin<b><small>Boot</small></b>
			</span>
		</a>

		<!-- Header Navbar: style can be found in header.less -->
		<nav class="navbar navbar-static-top">
			<!-- Sidebar toggle button-->
			<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
				<span class="sr-only">显示/隐藏</span>
			</a>
			<!-- Navbar Right Menu -->
			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav">
					<!-- User Account: style can be found in dropdown.less -->
					<li class="dropdown user user-menu">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<%--<img src="dist/img/user2-160x160.jpg" class="user-image" alt="User Image">--%>
							<i class="fa fa-user">
								<span class="hidden-xs"><se:authentication property="principal.user.name"/></span>
							</i>
						</a>
						<ul class="dropdown-menu">
							<!-- User image -->
							<li class="user-header">
								<se:authentication property="principal" var="principal"/>
								<%--<img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">--%>
								<p>
									<strong>
										<se:authentication property="principal.username"/>（<se:authentication
											property="principal.user.name"/>）
									</strong>
								</p>
								<p>
									<c:choose>
										<c:when test="${empty principal.user.phone}">
											<small>未设置联系电话</small>
										</c:when>
										<c:otherwise>
											<se:authentication property="principal.user.phone"/>
										</c:otherwise>
									</c:choose>
								</p>
								<p>
									<c:choose>
										<c:when test="${empty principal.user.email}">
											<small>未设置电子邮件</small>
										</c:when>
										<c:otherwise>
											<se:authentication property="principal.user.email"/>
										</c:otherwise>
									</c:choose>
								</p>
								<p>
									<small>创建于 <se:authentication
											property="principal.user.createTimeString"/></small>
								</p>
							</li>
							<!-- Menu Body -->
							<!--
							<li class="user-body">
								<div class="row">
									<div class="col-xs-4 text-center">
										<a href="#">Followers</a>
									</div>
									<div class="col-xs-4 text-center">
										<a href="#">Sales</a>
									</div>
									<div class="col-xs-4 text-center">
										<a href="#">Friends</a>
									</div>
								</div>
							</li>
							-->
							<!-- Menu Footer-->
							<li class="user-footer">
								<div class="pull-left">
									<a href="#" onclick="changePassword()" class="btn btn-default btn-flat">修改密码</a>
								</div>
								<div class="pull-right">
									<a href="${ctx}/logout" class="btn btn-default btn-flat">退出</a>
								</div>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
	</header>

	<!-- Left side column. contains the logo and sidebar -->
	<aside class="main-sidebar">
		<!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar">
			<!-- sidebar menu: : style can be found in sidebar.less -->
			<ul class="sidebar-menu">
				<li class="treeview" id="tree_sys">
					<a href="#">
						<i class="fa fa-gear"></i> <span>系统管理</span>
						<span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span>
					</a>
					<ul class="treeview-menu">
						<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('user_R', 'user_F')">
							<li id="item_user">
								<a href="${ctx}/sys/user"><i class="fa fa-circle-o"></i> 用户管理</a>
							</li>
						</se:authorize>
						<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('res')">
							<li id="item_res">
								<a href="${ctx}/sys/res"><i class="fa fa-circle-o"></i> 资源管理</a>
							</li>
						</se:authorize>
						<se:authorize access="hasRole('ADMIN') or hasAnyAuthority('role')">
							<li id="item_res">
								<a href="${ctx}/sys/role"><i class="fa fa-circle-o"></i> 角色管理</a>
							</li>
						</se:authorize>
						<se:authorize access="not hasRole('ADMIN')
								and not hasAnyAuthority('user', 'res', 'role')">
							<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;没有可以访问的功能</li>
						</se:authorize>
					</ul>
				</li>
			</ul>
		</section>
		<!-- /.sidebar -->
	</aside>

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<sitemesh:write property='body'/>
	</div>

	<footer class="main-footer">
		<div class="pull-right hidden-xs">
			<b>Version</b> 1.0.0
		</div>
		<strong>Copyright &copy; 2018 <a href="http://wangcl.github.io">wangcl.me </a>.</strong> All rights reserved.
	</footer>
</div>
<script>
	function changePassword() {
		var account = '<se:authentication property="principal.username"/>';
		if (account) {
			console.log("account: " + account);
			openModal("${ctx}/profile/" + account + "/changePassword", 550, 450);
		}
	}

	// 定位sidebar的菜单项
	function highlightMenuItem(tree, item) {
		if ($.isArray(tree)) {
			$.each(tree, function highlight(index, value) {
				$('#tree_' + value).addClass('active');
			});
		} else {
			$('#tree_' + tree).addClass('active');
		}
		$('#item_' + item).addClass('active');
	}
</script>
</body>
</html>
