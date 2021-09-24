
/*==============================================================*/
/* Table: S_USER                                                */
/*==============================================================*/
create table S_USER
(
   ID_                  varchar(32) not null comment '用户标识，主键',
   ACCOUNT_             varchar(64) not null comment '登录账号',
   PASSWORD_            varchar(64) not null comment '登录密码，加密存储',
   NAME_                varchar(64) not null comment '系统显示名称',
   EMAIL_               varchar(64) comment '电子邮件',
   PHONE_               varchar(32) comment '电话号码',
   CREATE_TIME_         date not null comment '创建时间',
   primary key (ID_)
);

alter table S_USER comment '系统用户';

/*==============================================================*/
/* Table: S_ROLE                                                */
/*==============================================================*/
create table S_ROLE
(
   ID_                  varchar(32) not null comment '角色标识，主键',
   CODE_                varchar(64) not null comment '角色编码',
   NAME_                varchar(64) not null comment '角色名称',
   primary key (ID_)
);

alter table S_ROLE comment '角色';

/*==============================================================*/
/* Table: S_USER_ROLE                                           */
/*==============================================================*/
create table S_USER_ROLE
(
   ID_                  varchar(32) not null comment '主键标识',
   ROLE_ID_             varchar(32) not null comment '角色标识',
   USER_ID_             varchar(32) not null comment '用户标识',
   primary key (ID_)
);

alter table S_USER_ROLE comment '用户角色，标识用户和角色的多对多关系';

/*==============================================================*/
/* Table: S_MENU_ITEM                                           */
/*==============================================================*/
create table S_MENU_ITEM
(
   ID_   varchar(32)  not null comment '菜单项标识',
   PID_  varchar(32)  comment '父菜单项标识',
   NAME_ varchar(64)  not null comment '菜单项名称',
   ICON_ varchar(128) comment '菜单项图标',
   URL_  varchar(128) comment '访问地址',
   PRIMARY KEY (ID_)
);

alter table S_MENU_ITEM comment '系统菜单项';

/*==============================================================*/
/* Table: s_role_menu_item                                      */
/*==============================================================*/
create table S_ROLE_MENU_ITEM
(
   ID_           varchar(32) not null comment '主键标识',
   ROLE_ID_      varchar(32) not null comment '角色标识',
   MENU_ITEM_ID_ varchar(32) not null comment '菜单项标识',
   PRIMARY KEY (ID_)
);
