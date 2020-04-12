package com.fzb.hotel.mapper;

import com.fzb.hotel.entity.Move;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MoveMapper {

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
