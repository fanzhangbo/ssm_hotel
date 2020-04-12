package com.fzb.hotel.mapper;


import com.fzb.hotel.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {

    /**
     * 查询所有用户
     * @return
     */
    public List<Role> listRole();

    /**
     * 根据用户id获取用户
     * @return
     */
    public Role getRoleById(Long id);

    /**
     * 根据用户id查询角色列表
     * @param userId
     * @return
     */
    public List<Role> getRoleListByUserId(Long userId);

    /**
     * 添加用户
     * @return
     */
    public Long addRole(Role role);

    /**
     * 编辑用户
     * @return
     */
    public Integer editRole(Role role);


    /**
     * 删除用户
     * @return
     */
    public Integer deleteRole(Long id);

    /**
     * 根据角色id删除该角色对应的菜单
     * @param roleId
     */
    public void deleteMenusByRoleId(Long roleId);


    public void addRoleMenus(@Param("roleId")Long roleId,@Param("menuId")Long menuId);



}
