package me.wangcl.sm.mapper;

import me.wangcl.sm.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface UserMapper {

	void insert(User user);

	int update(User user);

	User select(String id);

	int delete(String id);

	User selectByAccount(String account);

	List<User> selectListPaging(@Param("account") String account,
								@Param("name") String name,
								@Param("fromDate") Date fromDate,
								@Param("toDate") Date toDate,
								@Param("pageNum") int pageNum,
								@Param("pageSize") int pageSize);

	User selectUserWithRolesByAccount(String account);

}
