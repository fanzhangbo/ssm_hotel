package com.fzb.hotel.service;

import com.fzb.hotel.entity.Role;

import java.util.List;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
public interface RoleService {

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
     * 更新角色菜单
     */
    public void updateRoleMenu(Long roleId, String menuIds);

}
