package com.fzb.hotel.controller;

import com.fzb.hotel.entity.Role;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.service.RoleService;
import com.fzb.hotel.service.UserService;
import com.fzb.hotel.utils.UserUtils;
import com.fzb.hotel.vo.GlobalResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;


/**
 * TODO
 *
 * @author Fan Zhangbo
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;


    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {

        User userSubject = UserUtils.getSubjectUser(session);
        User user = this.userService.getUserById(userSubject.getId());
        session.setAttribute("loginUser", user);
        model.addAttribute("user", user);

        List<Long> tmpList = new ArrayList<>();

        List<Role> roleListByUserId = this.roleService.getRoleListByUserId(user.getId());
        for (Role role : roleListByUserId) {
            tmpList.add(role.getId());
        }
        model.addAttribute("checkedRoles", tmpList);

        List<Role> roles = this.roleService.listRole();
        model.addAttribute("roles", roles);

        return "user/profile";
    }

    @RequestMapping(value = "/profileAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult profileAct(User user) {
        user.setLocked(null);
        try {
            Integer retNum = this.userService.editUser(user);
            if (retNum > 0) {

                return GlobalResult.build(1, "修改成功");
            } else {
                return GlobalResult.build(0, "修改失败，请重新提交");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return GlobalResult.build(0, "修改失败，请重新提交");
        }
    }

    @RequestMapping(value = "/listUser", method = RequestMethod.GET)
    public String listUser() {
        return "user/listUser";
    }


    @RequestMapping(value = "/listUserAct")
    @ResponseBody
    public GlobalResult listUserAct(int page, int limit) {
        PageHelper.startPage(page, limit);
        List<User> users = this.userService.listUser();
        PageInfo<User> info = new PageInfo<>(users);
        return new GlobalResult(0, "", users, info.getTotal());
    }

    @RequestMapping(value = "/searchUser")
    @ResponseBody
    public GlobalResult searchUser(String username, int page, int limit) {
        PageHelper.startPage(page, limit);
        List<User> users = this.userService.searchUser(username);
        PageInfo<User> info = new PageInfo<>(users);
        return new GlobalResult(0, "", users, info.getTotal());
    }


    @RequestMapping(value = "/addUser", method = RequestMethod.GET)
    public String addUser(Model model) {
        List<Role> roles = this.roleService.listRole();
        model.addAttribute("roles", roles);
        return "user/addUser";
    }

    @RequestMapping(value = "/addUserAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addUserAct(User user, String roleIds) {
        Long retNum = this.userService.addUser(user);
        if (retNum > 0) {
            if (roleIds != null && !("".equals(roleIds))) {
                this.userService.updateUserRole(user.getId(), roleIds);
            }
            return GlobalResult.build(1, "添加成功");
        } else {
            return GlobalResult.build(0, "添加失败");
        }
    }

    @RequestMapping(value = "/editUser/{id}", method = RequestMethod.GET)
    public String editUser(@PathVariable("id")Long id, Model model) {


        List<Long> tmpList = new ArrayList<>();

        List<Role> roleListByUserId = this.roleService.getRoleListByUserId(id);
        for (Role role : roleListByUserId) {
            tmpList.add(role.getId());
        }
        model.addAttribute("checkedRoles", tmpList);

        List<Role> roles = this.roleService.listRole();
        model.addAttribute("roles", roles);

        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);

        System.out.println(user);
        return "user/editUser";
    }

    @RequestMapping(value = "/editUserAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult editUserAct(User user, String roleIds) {

        int retNum = this.userService.editUser(user);
        if (retNum > 0) {
            if (roleIds != null && !("".equals(roleIds))) {
                this.userService.updateUserRole(user.getId(), roleIds);
            }
            return GlobalResult.build(1, "修改成功");
        } else {
            return GlobalResult.build(0, "修改失败，请重新提交");
        }

    }
    @RequestMapping(value = "/deleteUserAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult deleteUserAct(@RequestParam(name = "id") Long id) {
        if (id == 1) {
            return GlobalResult.build(1, "该用户禁止删除");
        }

        int retNum = this.userService.deleteUser(id);
        if (retNum == 1) {
            return GlobalResult.build(1, "删除成功");
        } else {
            return GlobalResult.build(1, "删除失败，请重新提交");
        }
    }
}
