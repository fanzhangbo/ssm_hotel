package com.fzb.hotel.controller;


import com.fzb.hotel.entity.Customer;
import com.fzb.hotel.entity.Layout;
import com.fzb.hotel.entity.Move;
import com.fzb.hotel.entity.Room;
import com.fzb.hotel.service.CustomerService;
import com.fzb.hotel.service.LayoutService;
import com.fzb.hotel.service.MoveService;
import com.fzb.hotel.service.RoomService;
import com.fzb.hotel.vo.GlobalResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/move")
public class MoveController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private MoveService moveService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private LayoutService layoutService;


    @RequestMapping("/listMove")
    public String listMove() {
        return "move/listMove";
    }


    @RequestMapping(value = "/listMoveAct", method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult listMoveAct(int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Move> moveList = this.moveService.listMove();
        PageInfo<Move> info = new PageInfo<>(moveList);
        return new GlobalResult(0, "success", moveList, info.getTotal());
    }

    @RequestMapping("/addMove")
    public String addMove() {
        return "move/addMove";
    }

    @RequestMapping(value = "/addMoveAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult listRoomAct(Move move,
         @RequestParam("username")String username,
         @RequestParam("gender")Integer gender,
        @RequestParam("cardNo")String cardNo) {

        GlobalResult globalResult = new GlobalResult();

        Map<String, Object> map = new HashMap<>();

        Integer status = this.roomService.getRoomById(move.getRoomId()).getStatus();
        if (status ==  4) {
            globalResult.setCode(0);
            globalResult.setMsg("房间有人，不可入住!");
            return globalResult;
        }

        Long customerId = 0L;
        // 根据身份证号查询用户是否存在 存在获取id 不存在插入并获取自增id
        Customer customerByCardNo = this.customerService.getCustomerByCardNo(cardNo);
        if (customerByCardNo !=null) {
            customerId = customerByCardNo.getId();
        } else {
            Customer customer = new Customer();
            customer.setCreateTime(new Date());
            customer.setCardNo(cardNo);
            customer.setGender(gender);
            customer.setUsername(username);
            this.customerService.addCustomer(customer);
            customerId = customer.getId();
        }

        move.setCustomerId(customerId);
        move.setCreateTime(new Date());
        int retNum = this.moveService.addMove(move);
        if (retNum > 0) {

            // 更新房间状态
            Room r = new Room();
            r.setId(move.getRoomId());
            r.setStatus(4);
            this.roomService.editRoom(r);

            globalResult.setCode(1);
            globalResult.setMsg("success");
        } else {
            globalResult.setCode(0);
            globalResult.setMsg("添加失败");
        }

        return globalResult;
    }

    @RequestMapping("/editMove/{id}")
    public String editMove(@PathVariable("id")Long id, Model model) {
        Move moveById = this.moveService.getMoveById(id);
        Customer customer = this.customerService.getCustomerById(moveById.getCustomerId());
        Room room = this.roomService.getRoomById(moveById.getRoomId());
        Layout layout = this.layoutService.getLayoutById(room.getLayoutId());
        model.addAttribute("customer", customer);
        model.addAttribute("room", room);
        model.addAttribute("layout", layout);
        model.addAttribute("move", moveById);
        return "move/editMove";
    }

    @RequestMapping(value = "/editMoveAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult editMoveAct(Move move) {

        try {
            this.moveService.editMove(move);

            return new GlobalResult(1, "success");
        } catch (Exception e) {
            e.printStackTrace();
            return new GlobalResult(0, "更新失败");
        }
    }


}
