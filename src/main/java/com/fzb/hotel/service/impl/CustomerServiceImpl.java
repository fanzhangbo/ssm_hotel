package com.fzb.hotel.service.impl;


import com.fzb.hotel.entity.Customer;
import com.fzb.hotel.mapper.LayoutMapper;
import com.fzb.hotel.mapper.CustomerMapper;
import com.fzb.hotel.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private LayoutMapper layoutMapper;


    @Override
    public List<Customer> listCustomer() {
        return this.customerMapper.listCustomer();
    }

    @Override
    public List<Customer> searchCustomer(String username) {
        return this.customerMapper.searchCustomer(username);
    }

    @Override
    public Customer getCustomerByCardNo(String cardNo) {
        this.customerMapper.getCustomerByCardNo(cardNo);
        return null;
    }

    @Override
    public Customer getCustomerById(Long id) {
        return this.customerMapper.getCustomerById(id);
    }

    @Override
    public Long addCustomer(Customer customer) {
        return this.customerMapper.addCustomer(customer);
    }

    @Override
    public Integer editCustomer(Customer customer) {
        return this.customerMapper.editCustomer(customer);
    }

    @Override
    public Integer deleteCustomer(Long id) {
        return this.customerMapper.deleteCustomer(id);
    }

    @Override
    public Integer getCustomerTotalNum() {
        return this.customerMapper.getCustomerTotalNum();
    }
}
