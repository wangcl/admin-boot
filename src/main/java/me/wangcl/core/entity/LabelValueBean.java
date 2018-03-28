package me.wangcl.core.entity;

/**
 * 包含Label和Value的页面显示对象，Label用于页面显示，Value表示实际的值。一般用于下拉框等元素中。
 *
 * @author wangcl
 */
public class LabelValueBean extends ValueObject {
    private static final long serialVersionUID = -1322247461015890103L;

    private String label;
    private String value;

    public LabelValueBean() {
    }

    public LabelValueBean(String label, String value) {
        this.label = label;
        this.value = value;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

}
