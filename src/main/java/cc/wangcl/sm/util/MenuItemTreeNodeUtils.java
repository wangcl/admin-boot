package cc.wangcl.sm.util;

import cc.wangcl.core.entity.TreeNode;
import cc.wangcl.sm.entity.MenuItem;

import java.util.List;

/**
 * 树控件辅助类。
 *
 * @author wangcl
 */
public final class MenuItemTreeNodeUtils {

    /**
     * 递归设置菜单树层级结构。
     *
     * @param parent 父节点
     * @param list   菜单树
     */
    public static void setMenuItemChildren(TreeNode parent, List<MenuItem> list) {
        // TODO：可优化，如动态调整list大小
        for (MenuItem item : list) {
            if (parent.getId().equals(item.getPid())) {
                TreeNode node = new TreeNode();
                node.setId(item.getId());
                node.setIcon(item.getIcon());
                node.setText(item.getName());
                node.setData(item.getUrl());
                parent.getChildren().add(node);
                setMenuItemChildren(node, list);
            }
        }
    }

    public static void buildMenuTreeJsp(StringBuilder builder, TreeNode node) {
        if (node.isFolder()) {
            builder.append("<li class='treeview' id='tree_" + node.getId() + "'>\n");
            builder.append("<a href='#'>\n");
            builder.append("<i class='" + node.getIcon() + "'></i> <span>" + node.getText() + "</span>\n");
            builder.append("<span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span>\n");
            builder.append("</a>\n");
            builder.append("<ul class='treeview-menu'>\n");
            for (TreeNode child : node.getChildren()) {
                buildMenuTreeJsp(builder, child);
            }
            builder.append("</ul>\n");
            builder.append("</li>\n");
        } else { // 叶子节点
            builder.append("<se:authorize access=\"hasRole('ADMIN') or hasAuthority('" + node.getId() + "')\">\n");
            builder.append("<li id='item_" + node.getId() + "'>\n");
            builder.append("<a href='${ctx}" + node.getData() + "'>\n");
            builder.append("<i class='" + node.getIcon() + "'></i> ");
            builder.append("<span>" + node.getText() + "</span>\n");
            builder.append("</a>\n");
            builder.append("</li>\n");
            builder.append("</se:authorize>\n");
        }
    }

}
