package cc.wangcl.sm.service.impl;

import cc.wangcl.sm.entity.MenuItem;
import cc.wangcl.sm.mapper.MenuItemMapper;
import cc.wangcl.sm.service.MenuItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author wangcl
 */
@Service
@Transactional
public class MenuItemServiceImpl implements MenuItemService {

	@Autowired
	private MenuItemMapper menuItemMapper;

	@Override
	public String createMenuItem(MenuItem menuItem) {
    	menuItemMapper.insert(menuItem);
		return menuItem.getId();
    }

	@Override
	public void updateMenuItem(MenuItem menuItem) {
		menuItemMapper.update(menuItem);
	}

	@Override
	public void removeMenuItem(String id) {
		MenuItem item = menuItemMapper.select(id);
		if (item.getUrl() != null) { // 叶子节点
			menuItemMapper.delete(id);
		} else {
			List<MenuItem> list = menuItemMapper.selectSubListRecursively(id);
			for (MenuItem mi : list) {
				menuItemMapper.delete(mi.getId());
			}
		}
	}

    @Override
	@Transactional(readOnly = true)
	public MenuItem getMenuItem(String id) {
		return menuItemMapper.select(id);
	}

	@Override
	@Transactional(readOnly = true)
	public List<MenuItem> getMenuItemList(/* type1 param1, type2 param2, ... */) {
		return menuItemMapper.selectList(/* param1, param2, ... */);
	}

	@Override
	@Transactional(readOnly = true)
	public List<MenuItem> getSubMenuItemList(String menuItemId) {
		return menuItemMapper.selectSubListRecursively(menuItemId);
	}

	@Override
	@Transactional(readOnly = true)
	public MenuItem getRootMenuItem() {
		return menuItemMapper.selectRoot();
	}

}
