package com.fzb.hotel.service;

import com.fzb.hotel.entity.Move;

import java.util.List;

public interface MoveService {

    /**
     * 查询入住列表
     * @return
     */
    List<Move> listMove();

    /**
     * 根据入住id查询入住
     * @param id
     * @return
     */
    Move getMoveById(Long id);

    /**
     * 添加入住
     * @param move
     * @return
     */
    public int addMove(Move move);


    /**
     * 更新入住
     * @param move
     */
    public void editMove(Move move);
}
