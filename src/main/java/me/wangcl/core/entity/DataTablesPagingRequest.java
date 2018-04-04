package me.wangcl.core.entity;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * DataTables插件的分页查询请求对象。<br>
 * ref: https://datatables.net/manual/server-side
 *
 * @author wangcl
 */
public class DataTablesPagingRequest implements Serializable {
    private static final long serialVersionUID = -7530207253315527098L;

    private Integer draw; // draw counter.

    private Integer start; // 本页第一条数据的序号（0-based）

    private Integer length; // 每页包含的数据长度

    private List<Integer> orderColumnList = new ArrayList<>(); // 排序列索引集合

    private List<String> orderDirectionList = new ArrayList<>(); // 排序方向（asc | desc）集合

    private List<String> columnsDataList = new ArrayList<>(); // Column's data source, as defined by columns.data

    private List<String> columnsNameList = new ArrayList<>(); // Column's name, as defined by columns.name

    public Integer getDraw() {
        return draw;
    }

    public void setDraw(Integer draw) {
        this.draw = draw;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public List<Integer> getOrderColumnList() {
        return orderColumnList;
    }

    public void setOrderColumnList(List<Integer> orderColumnList) {
        this.orderColumnList = orderColumnList;
    }

    public List<String> getOrderDirectionList() {
        return orderDirectionList;
    }

    public void setOrderDirectionList(List<String> orderDirectionList) {
        this.orderDirectionList = orderDirectionList;
    }

    public List<String> getColumnsDataList() {
        return columnsDataList;
    }

    public void setColumnsDataList(List<String> columnsDataList) {
        this.columnsDataList = columnsDataList;
    }

    public List<String> getColumnsNameList() {
        return columnsNameList;
    }

    public void setColumnsNameList(List<String> columnsNameList) {
        this.columnsNameList = columnsNameList;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    @Override
    public boolean equals(Object o) {
        return EqualsBuilder.reflectionEquals(this, o);
    }

    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this);
    }

}
