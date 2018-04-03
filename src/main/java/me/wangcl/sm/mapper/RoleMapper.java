package me.wangcl.sm.mapper;

import me.wangcl.sm.entity.MenuItem;
import me.wangcl.sm.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangcl
 */
@Mapper
public interface RoleMapper {

	void insert(Role role);

	void update(Role role);

	void delete(String id);

	Role select(String id);

	Role selectByCode(String code);

	Role selectRoleWithMenuItemsByCode(String code);

	List<Role> selectList(@Param("name") String name);

	List<MenuItem> selectMenuItemsByRole(@Param("roleId") String roleId);

}
