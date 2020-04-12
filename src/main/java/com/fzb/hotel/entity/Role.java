package com.fzb.hotel.entity;

import java.util.List;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
public class Role {
    private Long id;
    private String roleName;
    private List<Menu> menus;

    public Role() {
    }

    public Role(Long id, String roleName, List<Menu> menus) {
        this.id = id;
        this.roleName = roleName;
        this.menus = menus;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", roleName='" + roleName + '\'' +
                ", menus=" + menus +
                '}';
    }
}
