package com.fzb.hotel.controller;


import com.fzb.hotel.entity.Layout;
import com.fzb.hotel.service.LayoutService;
import com.fzb.hotel.vo.GlobalResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 房型管理
 */
@Controller
@RequestMapping("/layout")
public class LayoutController {

    @Autowired
    private LayoutService layoutService;


    @RequestMapping(value = "/listLayout", method = RequestMethod.GET)
    public String listLayout() {
        return "layout/listLayout";
    }

    @RequestMapping(value = "/listLayoutAct", method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult listLayoutAct(int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Layout> layoutList = this.layoutService.listLayout();
        PageInfo<Layout> info = new PageInfo<>(layoutList);
        return new GlobalResult(0, "success", layoutList, info.getTotal());
    }

    @RequestMapping(value = "/searchLayout")
    @ResponseBody
    public GlobalResult searchLayout(String name, int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Layout> layoutList = this.layoutService.searchLayout(name);
        PageInfo<Layout> info = new PageInfo<>(layoutList);
        return new GlobalResult(0, "success", layoutList, info.getTotal());
    }



    @RequestMapping(value = "/addLayout", method = RequestMethod.GET)
    public String addLayout() {
        return "layout/addLayout";
    }

    @RequestMapping(value = "/addLayoutAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addLayoutAct(Layout layout) {
        GlobalResult globalResult = new GlobalResult();
        int retNum = this.layoutService.addLayout(layout);
        if (retNum > 0) {
            globalResult.setStatus(1);
            globalResult.setMsg("success");
        } else {
            globalResult.setStatus(0);
            globalResult.setMsg("添加失败");
        }
        return globalResult;
    }



    @RequestMapping(value = "/editLayout/{id}", method = RequestMethod.GET)
    public String editLayout(@PathVariable("id")Long id, Model model) {
        Layout layout = this.layoutService.getLayoutById(id);
        model.addAttribute("layout", layout);
        return "layout/editLayout";
    }

    @RequestMapping(value = "/editLayoutAct", method = RequestMethod.POST)
    @ResponseBody
    public String editLayoutAct(Layout layout) {
        Map<String, Object> map = new HashMap<>();
        int retNum = this.layoutService.editLayout(layout);
        if (retNum > 0) {
            map.put("code", 1);
            map.put("msg", "success");

        } else {
            map.put("code", 0);
            map.put("msg", "修改失败，请重新提交");
        }

        return new JSONObject(map).toString();
    }
    @RequestMapping(value = "/deleteLayoutAct", method = RequestMethod.POST)
    @ResponseBody
    public String deleteLayoutAct(@RequestParam(name = "id") Long id) {
        Map<String, Object> map = new HashMap<>();

        int retNum = this.layoutService.deleteLayout(id);
        if (retNum == 1) {
            map.put("code", 1);
            map.put("msg", "success");

        } else {
            map.put("code", 0);
            map.put("msg", "删除失败，请重新提交");
        }
        return new JSONObject(map).toString();
    }


}
