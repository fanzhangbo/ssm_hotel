package com.fzb.hotel.controller;

import com.fzb.hotel.entity.Menu;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.service.MenuService;
import com.fzb.hotel.utils.UserUtils;
import com.fzb.hotel.vo.GlobalResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("/indexMenu")
    @ResponseBody
    public Map<String, Object> indexMenu(HttpSession session) {
        Map<String, Object> retMap = new HashMap<>();
        User user = UserUtils.getSubjectUser(session);

        List<Menu> menus = this.menuService.getMenuListByUserId(user.getId(), true);
        retMap.put("menuInfo", menus);
        // homeInfo
        retMap.put("homeInfo", new Menu("首页", "/welcome"));
        return retMap;
    }

    @RequestMapping("/listMenu")
    public String listMenu() {
        return "menu/listMenu";
    }

    @RequestMapping("/listMenuAct")
    @ResponseBody
    public Map<String, Object> listMenuAct() {
        Map<String, Object> retMap = new HashMap<>();

        List<Menu> menus = this.menuService.listMenu();
        retMap.put("code", 200);

        // homeInfo
        retMap.put("data", menus);
        return retMap;
    }

    @RequestMapping(value = "/addMenu", method = RequestMethod.GET)
    public String addChildMenu() {
        return "menu/addMenu";
    }

    @RequestMapping(value = "/addMenuAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addMenuAct(Menu menu) {
        Long retNum = this.menuService.addMenu(menu);
        if (retNum > 0) {
            return GlobalResult.build(1, "添加成功");
        } else {
            return GlobalResult.build(0, "添加失败");
        }
    }


    @RequestMapping(value = "/editMenu/{id}", method = RequestMethod.GET)
    public String editMenu(@PathVariable("id")Long id, Model model) {
        Menu menu = this.menuService.getMenuById(id);
        model.addAttribute("menu", menu);
        return "menu/editMenu";
    }

    @RequestMapping(value = "/editMenuAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult editMenuAct(Menu menu) {
        int retNum = this.menuService.editMenu(menu);
        if (retNum > 0) {
            return GlobalResult.build(1, "修改成功");
        } else {
            return GlobalResult.build(0, "修改失败，请重新提交");
        }

    }

    @RequestMapping(value = "/deleteMenuAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult deleteMenuAct(@RequestParam(name = "id") Long id) {

        int retNum = this.menuService.deleteMenu(id);
        if (retNum == 1) {
            return GlobalResult.build(1, "删除成功");
        } else {
            return GlobalResult.build(0, "删除失败，请重新提交");
        }
    }

}
