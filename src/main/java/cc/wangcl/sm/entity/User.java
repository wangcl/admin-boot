package cc.wangcl.sm.entity;


import cc.wangcl.core.entity.Entity;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class User extends Entity {
	private static final long serialVersionUID = 984957168769325204L;

	private String id; // 主键
	private String account; // 账号
	private String name; // 显示名称
	private String password; // 密码（密文）
	private String email; // 邮件
	private String phone; // 电话
	private Date createTime; // 创建时间

	private String createTimeString; // 创建时间的字符串表示，用于界面展示

	private List<Role> roleList; // 角色列表

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getAccount() {
		return account;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone() {
		return phone;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public String getCreateTimeString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(createTime);
	}

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}

}
