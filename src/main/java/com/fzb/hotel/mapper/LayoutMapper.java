package com.fzb.hotel.mapper;

import com.fzb.hotel.entity.Layout;

import java.util.List;

public interface LayoutMapper {

    /**
     * 获取房型列表
     * @return
     */
    public List<Layout> listLayout();


    /**
     * 根据房型id获取房型
     * @return
     */
    public Layout getLayoutById(Long id);

    /**
     * 搜索房型
     * @param name
     * @return
     */
    public List<Layout> searchLayout(String name);


    /**
     * 添加房型
     * @return
     */
    public Integer addLayout(Layout layout);

    /**
     * 编辑房型
     * @return
     */
    public Integer editLayout(Layout layout);


    /**
     * 删除房型
     * @return
     */
    public Integer deleteLayout(Long id);
}
