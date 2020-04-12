package com.fzb.hotel.service.impl;

import com.fzb.hotel.entity.Menu;
import com.fzb.hotel.mapper.MenuMapper;
import com.fzb.hotel.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;


    @Override
    public List<Menu> listMenu() {
        return tree(this.menuMapper.listMenu(), 0L);
    }

    @Override
    public Menu getMenuById(Long id) {
        return this.menuMapper.getMenuById(id);
    }

    @Override
    public List<Menu> getMenuListByRoleId(Long roleId) {
        return this.menuMapper.getMenuListByRoleId(roleId);
    }

    @Override
    public List<Menu> getMenuListByUserId(Long userId, Boolean isTree) {
        if (isTree) {
            return tree(this.menuMapper.getMenuListByUserId(userId), 0L);
        }
        return this.menuMapper.getMenuListByUserId(userId);
    }

    @Override
    public List<Menu> getMenuListAllByUserId(Long userId) {
        return this.menuMapper.getMenuListAllByUserId(userId);
    }

    @Override
    public Long addMenu(Menu menu) {
        return this.menuMapper.addMenu(menu);
    }

    @Override
    public Integer editMenu(Menu menu) {
        return this.menuMapper.editMenu(menu);
    }

    @Override
    public Integer deleteMenu(Long id) {
        this.menuMapper.deleteRoleMenu(id);
        return this.menuMapper.deleteMenu(id);
    }


    // 获取树形菜单列表
    private static List<Menu> tree(List<Menu> menus, Long pid) {

        List<Menu> treeMenus = new LinkedList<>();
        // 获取一级级菜单
        for (Menu menu : menus) {
            if (menu.getPid().equals(pid)) {
                treeMenus.add(menu);

                // 获取二级菜单
                for (Menu menu1 : menus) {
                    if (!menu.equals(menu1) && menu1.getPid().equals(menu.getId())) {
                        menu.getChild().add(menu1);

                        // 获取三级菜单
                        for (Menu menu2 : menus) {
                            if (!menu1.equals(menu2) && menu2.getPid().equals(menu1.getId())) {
                                menu2.setChild(null);
                                menu1.getChild().add(menu2);

                            }
                        }
                    }
                }
            }
        }
        return treeMenus;

    }
}
