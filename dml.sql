-- s_user
INSERT INTO s_user (ID_, ACCOUNT_, NAME_, PASSWORD_, EMAIL_, PHONE_, CREATE_TIME_) VALUES (
	'1',
	'admin',
	'管理员',
	'c4ca4238a0b923820dcc509a6f75849b',
	'admin@company.com',
	'13812345678',
	now() -- STR_TO_DATE('2018-03-01 14:41:04', '%Y-%m-%d %T')
);

-- s_role
INSERT INTO s_role (ID_, CODE_, NAME_) VALUES (
	'1',
	'ADMIN',
	'系统管理员'
);

-- s_user_role
INSERT INTO s_user_role (ID_, ROLE_ID_, USER_ID_) VALUES (
	'1',
	'1',
	'1'
);

-- s_menu_item
INSERT INTO s_menu_item (ID_, PID_, ICON_, URL_, NAME_) VALUES (
	'root',
	NULL,
	NULL,
	NULL,
	'功能菜单'
);

-- 系统管理
INSERT INTO s_menu_item (ID_, PID_, ICON_, URL_, NAME_) VALUES (
	'sys',
	'root',
	'fa fa-gear',
	NULL,
	'系统管理'
);
INSERT INTO s_menu_item (ID_, PID_, ICON_, URL_, NAME_) VALUES (
	'user',
	'sys',
	NULL,
	'/sys/user',
	'用户管理'
);
INSERT INTO s_menu_item (ID_, PID_, ICON_, URL_, NAME_) VALUES (
	'res',
	'sys',
	NULL,
	'/sys/res',
	'资源管理'
);
INSERT INTO s_menu_item (ID_, PID_, ICON_, URL_, NAME_) VALUES (
	'role',
	'sys',
	NULL,
	'/sys/role',
	'角色管理'
);
