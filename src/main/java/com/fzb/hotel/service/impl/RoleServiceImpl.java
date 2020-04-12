package com.fzb.hotel.service.impl;

import com.fzb.hotel.entity.Role;
import com.fzb.hotel.mapper.RoleMapper;
import com.fzb.hotel.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> listRole() {
        return this.roleMapper.listRole();
    }

    @Override
    public Role getRoleById(Long id) {
        return this.roleMapper.getRoleById(id);
    }

    @Override
    public List<Role> getRoleListByUserId(Long userId) {
        return this.roleMapper.getRoleListByUserId(userId);
    }

    @Override
    public Long addRole(Role role) {
        return this.roleMapper.addRole(role);
    }

    @Override
    public Integer editRole(Role role) {
        return this.roleMapper.editRole(role);
    }

    @Override
    public Integer deleteRole(Long id) {
        return this.roleMapper.deleteRole(id);
    }

    @Override
    public void updateRoleMenu(Long roleId, String menuIds) {
        // 删除角色对应的菜单
        this.roleMapper.deleteMenusByRoleId(roleId);
        if (!("".equals(menuIds))) {
            // 添加菜单
            String[] ids = menuIds.split(",");
            for (String id : ids) {
                this.roleMapper.addRoleMenus(roleId, Long.parseLong(id));
            }
        }
    }


}
