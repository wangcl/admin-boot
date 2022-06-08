package cc.wangcl.sm.service.impl;

import cc.wangcl.sm.entity.User;
import cc.wangcl.sm.entity.UserRole;
import cc.wangcl.sm.mapper.UserMapper;
import cc.wangcl.sm.mapper.UserRoleMapper;
import cc.wangcl.sm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 用户服务的默认实现。
 *
 * @author wangcl
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private UserRoleMapper userRoleMapper;

	@Override
	public User create(User user) {
		userMapper.insert(user);
		return user;
	}

	@Override
	public int update(User user) {
		return userMapper.update(user);
	}

	@Override
	public int delete(String id) {
		return userMapper.delete(id);
	}

	@Override
	@Transactional(readOnly = true)
	public User queryById(String id) {
		return userMapper.select(id);
	}

	@Override
	@Transactional(readOnly = true)
	public User queryByAccount(String account) {
		return userMapper.selectByAccount(account);
	}

	@Override
	@Transactional(readOnly = true)
	public User queryUserDetailsByAccount(String account) {
		return userMapper.selectUserWithRolesByAccount(account);
	}

	@Override
	@Transactional(readOnly = true)
	public List<User> queryListPaging(String account, String name, Date fromDate, Date toDate, int pageNum, int pageSize) {
		return userMapper.selectListPaging(account, name, fromDate, toDate, pageNum, pageSize);
	}

	@Override
	@Transactional(readOnly = true)
	public List<String> getAuthorizedRoleIds(String userId) {
		return userRoleMapper.selectRoleIdsByUser(userId);
	}

	@Override
	public void authorize(String userId, List<String> roles) {
		// 删除旧数据
		userRoleMapper.deleteByUser(userId);

		if (roles != null) {
			// 插入新数据
			for (String roleId : roles) {
				UserRole ur = new UserRole();
				ur.setUserId(userId);
				ur.setRoleId(roleId);
				userRoleMapper.insert(ur);
			}
		}
	}

}
