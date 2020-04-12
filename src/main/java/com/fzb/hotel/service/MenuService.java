package com.fzb.hotel.service;

import com.fzb.hotel.entity.Menu;

import java.util.List;

public interface MenuService {

    /**
     * 获取菜单列表
     * @return
     */
    public List<Menu> listMenu();

    /**
     * 根据菜单id获取菜单
     * @return
     */
    public Menu getMenuById(Long id);

    /**
     * 根据角色id查询菜单列表
     * @param roleId
     * @return
     */
    public List<Menu> getMenuListByRoleId(Long roleId);

    /**
     * 根据用户id查询菜单列表
     * @param userId
     * @return
     */
    public List<Menu> getMenuListByUserId(Long userId, Boolean isTree);

    /**
     * 根据用户id查询菜单列表(全部)
     * @param userId
     * @return
     */
    public List<Menu> getMenuListAllByUserId(Long userId);

    /**
     * 添加菜单
     * @return
     */
    public Long addMenu(Menu menu);

    /**
     * 编辑菜单
     * @return
     */
    public Integer editMenu(Menu menu);


    /**
     * 删除菜单
     * @return
     */
    public Integer deleteMenu(Long id);
}
