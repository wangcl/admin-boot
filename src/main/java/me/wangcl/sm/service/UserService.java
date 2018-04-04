package me.wangcl.sm.service;

import me.wangcl.sm.entity.User;

import java.util.Date;
import java.util.List;

/**
 * 用户服务，管理系统用户信息。
 *
 * @author wangcl
 */
public interface UserService {

    /**
     * 新增用户
     *
     * @param user 用户信息
     * @return 带有主键标识的用户信息
     */
    User create(User user);

    /**
     * 更新用户信息
     *
     * @param user 用户信息
     * @return 更新记录数
     */
    int update(User user);

    /**
     * 删除
     *
     * @param id 用户标识
     * @return 删除记录数
     */
    int delete(String id);

    /**
     * 根据主键信息查询
     *
     * @param id 用户标识
     * @return 用户信息
     */
    User queryById(String id);

    /**
     * 根据账号信息查询
     *
     * @param account 登录账号
     * @return
     */
    User queryByAccount(String account);

    /**
     * 根据账号信息查询，包括用户关联的角色列表信息
     *
     * @param account 登录账号
     * @return 用户信息
     */
    User queryUserDetailsByAccount(String account);

    /**
     * 根据用户账号及/或姓名模糊查询，分页
     *
     * @param account  账号
     * @param name     姓名
     * @param fromDate 起始时间
     * @param toDate   截止时间
     * @param pageNum  第几页
     * @param pageSize 每页数据量
     * @return 指定页的用户信息列表
     */
    List<User> queryListPaging(String account, String name, Date fromDate, Date toDate, int pageNum, int pageSize);

    /**
     * 获取指定用户的已授权角色标识的列表。
     *
     * @param userId 用户标识
     * @return 角色标识列表
     */
    List<String> getAuthorizedRoleIds(String userId);

    /**
     * 为指定用户分配角色。
     *
     * @param userId 用户标识
     * @param roles 角色标识列表
     */
    void authorize(String userId, List<String> roles);

}
