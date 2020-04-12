package com.fzb.hotel.controller;


import com.fzb.hotel.entity.Layout;
import com.fzb.hotel.entity.Room;
import com.fzb.hotel.service.LayoutService;
import com.fzb.hotel.service.RoomService;
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
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private LayoutService layoutService;


    @RequestMapping(value = "/listRoom", method = RequestMethod.GET)
    public String listRoom() {
        return "room/listRoom";
    }

    @RequestMapping(value = "/listRoomAct", method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult listRoomAct(int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Room> roomList = this.roomService.listRoom();
        PageInfo<Room> info = new PageInfo<>(roomList);
        return new GlobalResult(0, "success", roomList, info.getTotal());
    }

    @RequestMapping(value = "/searchRoom")
    @ResponseBody
    public GlobalResult searchRoom(Room room, int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Room> roomList = this.roomService.searchRoom(room);
        PageInfo<Room> info = new PageInfo<>(roomList);
        return new GlobalResult(0, "success", roomList, info.getTotal());
    }



    @RequestMapping(value = "/addRoom", method = RequestMethod.GET)
    public String addRoom(Model model) {
        List<Layout> layouts = this.layoutService.listLayout();
        model.addAttribute("layouts", layouts);
        return "room/addRoom";
    }

    @RequestMapping(value = "/addRoomAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addRoomAct(Room room) {
        GlobalResult globalResult = new GlobalResult();
        int retNum = this.roomService.addRoom(room);
        if (retNum > 0) {
            globalResult.setCode(1);
            globalResult.setMsg("success");
        } else {
            globalResult.setCode(0);
            globalResult.setMsg("添加失败");
        }

        return globalResult;
    }



    @RequestMapping(value = "/editRoom/{id}", method = RequestMethod.GET)
    public String editRoom(@PathVariable("id")Long id, Model model) {
        Room room = this.roomService.getRoomById(id);
        List<Layout> layouts = this.layoutService.listLayout();
        model.addAttribute("layouts", layouts);
        model.addAttribute("room", room);
        return "room/editRoom";
    }

    @RequestMapping(value = "/editRoomAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult editRoomAct(Room room) {
        GlobalResult globalResult = new GlobalResult();
        int retNum = this.roomService.editRoom(room);
        if (retNum > 0) {
            globalResult.setCode(1);
            globalResult.setMsg("success");

        } else {
            globalResult.setCode(0);
            globalResult.setMsg("修改失败，请重新提交");
        }

        return globalResult;
    }
    @RequestMapping(value = "/deleteRoomAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult deleteRoomAct(@RequestParam(name = "id") Long id) {
        GlobalResult globalResult = new GlobalResult();
        int retNum = this.roomService.deleteRoom(id);
        if (retNum == 1) {
            globalResult.setCode(1);
            globalResult.setMsg("success");
        } else {
            globalResult.setCode(0);
            globalResult.setMsg("删除失败，请重新提交");
        }
        return globalResult;
    }


}
