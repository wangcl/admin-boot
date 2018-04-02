package me.wangcl.sm.entity;

import me.wangcl.core.entity.Entity;

/**
 * 数据库表实体对象：<code>S_MENU_ITEM</code> (系统菜单项)<br>
 * 通过url是否为空，确定菜单项是否是叶子节点。
 *
 * @author wangcl
 */
public class MenuItem extends Entity {
    private static final long serialVersionUID = -6707442795525469675L;

    private String id; // 菜单项标识
    private String pid; // 父菜单项标识
    private String icon; // 图标，可以是图片路径、css的class类名
    private String url; // 访问地址
    private String name; // 菜单项名称

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getPid() {
        return pid;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUrl() {
        return url;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

}
