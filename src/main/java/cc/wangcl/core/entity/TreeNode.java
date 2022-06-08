package cc.wangcl.core.entity;

import com.fasterxml.jackson.annotation.JsonInclude;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * jstree.js 插件对应的树节点结构。
 *
 * @author wangcl
 */
public class TreeNode extends Entity {
    private static final long serialVersionUID = -575144544651421168L;

    /* 默认图标 */
    private static final String ICON_FOLDER = "fa fa-folder-o";
    private static final String ICON_LEAF = "fa fa-circle-thin";

    @JsonInclude(JsonInclude.Include.NON_NULL)
    // 节点标识
    private String id;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    // 节点显示信息
    private String text;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    // 节点图标，可以是文件路径、class名称
    private String icon;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    // 节点元数据信息（任意形式，与显示效果无关），目前用来保存叶子节点的url信息
    private String data;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    // 子节点
    private List<TreeNode> children = new ArrayList<>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getIcon() {
        /* 如果未设置图标，则使用默认值 */
        if (icon == null) {
            icon = isFolder() ? ICON_FOLDER : ICON_LEAF;
        }
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public List<TreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }

    public boolean isFolder() {
        return StringUtils.isEmpty(this.data);
    }

    public boolean isLeaf() {
        return !isFolder();
    }

}
