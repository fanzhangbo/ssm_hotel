package com.fzb.hotel.controller;

import com.fzb.hotel.entity.Menu;
import com.fzb.hotel.entity.Role;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.service.MenuService;
import com.fzb.hotel.service.RoleService;
import com.fzb.hotel.service.UserService;
import com.fzb.hotel.vo.GlobalResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


/**
 * TODO
 *
 * @author Fan Zhangbo
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/listRole", method = RequestMethod.GET)
    public String listRole() {
        return "role/listRole";
    }


    @RequestMapping(value = "/listRoleAct")
    @ResponseBody
    public GlobalResult listRoleAct(int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Role> roles = this.roleService.listRole();
        PageInfo<Role> info = new PageInfo<>(roles);
        return new GlobalResult(0, "", roles, info.getTotal());
    }

    @RequestMapping(value = "/addRole", method = RequestMethod.GET)
    public String addRoles() {
        return "role/addRole";
    }

    @RequestMapping(value = "/addRoleAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addRoleAct(Role role) {
        Long retNum = this.roleService.addRole(role);
        return GlobalResult.build(1, "添加成功");

    }

    @RequestMapping(value = "/setMenus/{id}", method = RequestMethod.GET)
    public String addMenus(@PathVariable("id")Long id, Model model) {
        ArrayList<Long> menuIds = new ArrayList<>();
        List<Menu> menuList = this.menuService.getMenuListByRoleId(id);
        for (Menu menu : menuList) {
            if (menu.getHref() != null && !("".equals(menu.getHref())))
            menuIds.add(menu.getId());
        }
        System.out.println(menuIds);
        model.addAttribute("menuIds", StringUtils.join(menuIds, ","));
        model.addAttribute("roleId", id);
        return "role/setMenus";
    }

    @RequestMapping(value = "/setMenusAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addMenusAct(@RequestParam("menuIds") String menuIds,
                                    @RequestParam("roleId") Long roleId) {

        if (menuIds != null ) {
            this.roleService.updateRoleMenu(roleId, menuIds);
            return GlobalResult.build(1, "更新成功");
        }

        return GlobalResult.build(0, "参数有误");
    }

    @RequestMapping(value = "/editRole/{id}", method = RequestMethod.GET)
    public String editRole(@PathVariable("id")Long id, Model model) {
        Role role = this.roleService.getRoleById(id);
        model.addAttribute("role", role);
        return "role/editRole";
    }

    @RequestMapping(value = "/editRoleAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult editRoleAct(Role role) {
        int retNum = this.roleService.editRole(role);
        if (retNum > 0) {
            return GlobalResult.build(1, "修改成功");
        } else {
            return GlobalResult.build(0, "修改失败，请重新提交");
        }

    }


    @RequestMapping(value = "/deleteRoleAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult deleteRoleAct(@RequestParam(name = "id") Long id) {


        //  查询该角色下是否有用户 有则不可删除
        List<User> userListByRoleId = this.userService.getUserListByRoleId(id);
        if (userListByRoleId.size() > 0) {
            return GlobalResult.build(0, "删除失败，该角色下有用户");
        }

        int retNum = this.roleService.deleteRole(id);
        if (retNum == 1) {
            return GlobalResult.build(1, "删除成功");
        } else {
            return GlobalResult.build(0, "删除失败，请重新提交");
        }
    }
}
