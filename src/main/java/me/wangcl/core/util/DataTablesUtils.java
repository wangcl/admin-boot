package me.wangcl.core.util;

import me.wangcl.core.entity.DataTablesPagingRequest;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author wangcl
 */
public final class DataTablesUtils {

    public static DataTablesPagingRequest processPagingRequest(HttpServletRequest request) {
        DataTablesPagingRequest dt = new DataTablesPagingRequest();

        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");

        if (StringUtils.isEmpty(start) || StringUtils.isEmpty(length)) {
            throw new IllegalArgumentException("分页信息（start | length）不能为空");
        }

        if (StringUtils.isNotEmpty(draw)) {
            dt.setDraw(Integer.valueOf(draw));
        }
        dt.setStart(Integer.valueOf(start));
        dt.setLength(Integer.valueOf(length));

        int i = 0;
        while (i >= 0) {
            String orderColumn = request.getParameter("order[" + i + "][column]");
            if (StringUtils.isNotEmpty(orderColumn)) {
                dt.getOrderColumnList().add(Integer.valueOf(orderColumn));
            }
            String orderDir = request.getParameter("order[" + i + "][dir]");
            if (StringUtils.isNotEmpty(orderDir)) {
                dt.getOrderDirectionList().add(orderDir);
            }
            String columnsData = request.getParameter("columns[" + i + "][data]");
            if (StringUtils.isNotEmpty(columnsData)) {
                dt.getColumnsDataList().add(columnsData);
            }
            String columnsName = request.getParameter("columns[" + i + "][name]");
            if (StringUtils.isNotEmpty(columnsName)) {
                dt.getColumnsNameList().add(columnsName);
            }

            if (orderColumn == null && orderDir == null && columnsData == null && columnsName == null) {
                break;
            }

            i++;
        }

        return dt;
    }

}
