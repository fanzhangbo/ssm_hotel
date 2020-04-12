package com.fzb.hotel.mapper;

import com.fzb.hotel.entity.Menu;

import java.util.List;

public interface MenuMapper {

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
     * 根据用户id查询菜单列表(可见)
     * @param userId
     * @return
     */
    public List<Menu> getMenuListByUserId(Long userId);


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

    /**
     * 根据菜单id删除角色菜单中的记录
     * @return
     */
    public Integer deleteRoleMenu(Long menu_id);
}
