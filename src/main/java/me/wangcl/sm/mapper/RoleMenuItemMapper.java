package me.wangcl.sm.mapper;

import me.wangcl.sm.entity.MenuItem;
import me.wangcl.sm.entity.RoleMenuItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangcl
 */
@Mapper
public interface RoleMenuItemMapper {

	void insert(RoleMenuItem roleMenuItem);

	void update(RoleMenuItem roleMenuItem);

	void delete(String id);

	void deleteByRole(String roleId);

	RoleMenuItem select(String id);

	List<RoleMenuItem> selectList(/* @Param("param1") type1 param1, @Param("param2") type2 param2, ... */);

	Integer selectCountByMenuItem(@Param("menuItemId") String menuItemId);

	Integer selectCountByRole(@Param("roleId") String roleId);

	List<MenuItem> selectMenuItemListByRole(@Param("roleId") String roleId);

}
