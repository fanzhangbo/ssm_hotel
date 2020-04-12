package com.fzb.hotel.mapper;

import com.fzb.hotel.entity.Customer;

import java.util.List;

public interface CustomerMapper {

    /**
     * 获取顾客列表
     * @return
     */
    public List<Customer> listCustomer();

    /**
     * 搜索顾客
     * @param username
     * @return
     */
    public List<Customer> searchCustomer(String username);

    /**
     * 根据顾客身份证号获取顾客信息
     * @param cardNo
     * @return
     */
    public Customer getCustomerByCardNo(String cardNo);


    /**
     * 根据顾客id获取顾客
     * @return
     */
    public Customer getCustomerById(Long id);


    /**
     * 添加顾客
     * @return
     */
    public Long addCustomer(Customer customer);

    /**
     * 编辑顾客
     * @return
     */
    public Integer editCustomer(Customer customer);


    /**
     * 删除顾客
     * @return
     */
    public Integer deleteCustomer(Long id);

    /**
     * 查询顾客总数
     * @return
     */
    public Integer getCustomerTotalNum();
}
