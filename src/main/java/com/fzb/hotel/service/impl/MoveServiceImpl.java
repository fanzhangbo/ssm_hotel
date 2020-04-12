package com.fzb.hotel.service.impl;

import com.fzb.hotel.entity.Move;
import com.fzb.hotel.mapper.MoveMapper;
import com.fzb.hotel.service.MoveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class MoveServiceImpl implements MoveService {

    @Autowired
    private MoveMapper moveMapper;

    @Override
    public List<Move> listMove() {
        return this.moveMapper.listMove();
    }

    @Override
    public Move getMoveById(Long id) {
        return this.moveMapper.getMoveById(id);
    }

    @Override
    public int addMove(Move move) {
        return this.moveMapper.addMove(move);
    }

    @Override
    public void editMove(Move move) {
        this.moveMapper.editMove(move);
    }
}
