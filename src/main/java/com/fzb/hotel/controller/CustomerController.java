package com.fzb.hotel.controller;


import com.fzb.hotel.entity.Customer;
import com.fzb.hotel.service.LayoutService;
import com.fzb.hotel.service.CustomerService;
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

/**
 * 房型管理
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private LayoutService layoutService;


    @RequestMapping(value = "/listCustomer", method = RequestMethod.GET)
    public String listCustomer() {
        return "customer/listCustomer";
    }

    @RequestMapping(value = "/listCustomerAct", method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult listCustomerAct(int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Customer> customerList = this.customerService.listCustomer();
        PageInfo<Customer> info = new PageInfo<>(customerList);
        return new GlobalResult(0, "success", customerList, info.getTotal());
    }

    @RequestMapping(value = "/searchCustomer", method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult searchCustomer(String username, int page, int limit) {
        PageHelper.startPage(page, limit);
        List<Customer> customerList = this.customerService.searchCustomer(username);
        PageInfo<Customer> info = new PageInfo<>(customerList);
        return new GlobalResult(0, "success", customerList, info.getTotal());
    }



    @RequestMapping(value = "/addCustomer", method = RequestMethod.GET)
    public String addCustomer(Model model) {
        return "customer/addCustomer";
    }

    @RequestMapping(value = "/addCustomerAct", method = RequestMethod.POST)
    @ResponseBody
    public String addCustomerAct(Customer customer) {
        Map<String, Object> map = new HashMap<>();
        customer.setCreateTime(new Date());
        Long retNum = this.customerService.addCustomer(customer);
        if (retNum > 0) {
            map.put("code", 1);
            map.put("msg", "success");
        } else {
            map.put("code", 0);
            map.put("msg", "添加失败");
        }

        return new JSONObject(map).toString();
    }



    @RequestMapping(value = "/editCustomer/{id}", method = RequestMethod.GET)
    public String editCustomer(@PathVariable("id")Long id, Model model) {
        Customer customer = this.customerService.getCustomerById(id);
        model.addAttribute("customer", customer);
        return "customer/editCustomer";
    }

    @RequestMapping(value = "/editCustomerAct", method = RequestMethod.POST)
    @ResponseBody
    public String editCustomerAct(Customer customer) {
        Map<String, Object> map = new HashMap<>();
        int retNum = this.customerService.editCustomer(customer);
        if (retNum > 0) {
            map.put("code", 1);
            map.put("msg", "success");

        } else {
            map.put("code", 0);
            map.put("msg", "修改失败，请重新提交");
        }

        return new JSONObject(map).toString();
    }
    @RequestMapping(value = "/deleteCustomerAct", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCustomerAct(@RequestParam(name = "id") Long id) {
        Map<String, Object> map = new HashMap<>();

        int retNum = this.customerService.deleteCustomer(id);
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
