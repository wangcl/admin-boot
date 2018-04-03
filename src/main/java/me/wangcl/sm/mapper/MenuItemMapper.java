package me.wangcl.sm.mapper;

import me.wangcl.sm.entity.MenuItem;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author wangcl
 */
@Mapper
public interface MenuItemMapper {

	void insert(MenuItem menuItem);

	void update(MenuItem menuItem);

	void delete(String id);

	MenuItem select(String id);

	MenuItem selectRoot();

	List<MenuItem> selectList(/* @Param("param1") type1 param1, @Param("param2") type2 param2, ... */);

	List<MenuItem> selectSubListRecursively(String id);

}
