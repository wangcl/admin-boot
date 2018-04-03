package me.wangcl.sm.mapper;

import me.wangcl.sm.entity.UserRole;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author wangcl
 */
@Mapper
public interface UserRoleMapper {

	void insert(UserRole userRole);

	void deleteByUser(String userId);

	void deleteByRole(String roleId);

	int selectCountByUser(String userId);

	int selectCountByRole(String roleId);

	List<String> selectRoleIdsByUser(String userId);

}
