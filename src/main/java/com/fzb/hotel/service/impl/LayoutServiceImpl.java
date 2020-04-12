package com.fzb.hotel.service.impl;

import com.fzb.hotel.entity.Layout;
import com.fzb.hotel.mapper.LayoutMapper;
import com.fzb.hotel.service.LayoutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LayoutServiceImpl implements LayoutService {

    @Autowired
    private LayoutMapper layoutMapper;

    @Override
    public List<Layout> listLayout() {
        return this.layoutMapper.listLayout();
    }

    @Override
    public Layout getLayoutById(Long id) {
        return this.layoutMapper.getLayoutById(id);
    }

    @Override
    public List<Layout> searchLayout(String name) {
        return this.layoutMapper.searchLayout(name);
    }

    @Override
    public Integer addLayout(Layout layout) {
        return this.layoutMapper.addLayout(layout);
    }

    @Override
    public Integer editLayout(Layout layout) {
        return this.layoutMapper.editLayout(layout);
    }

    @Override
    public Integer deleteLayout(Long id) {
        return this.layoutMapper.deleteLayout(id);
    }


}
