package com.fzb.hotel.service;

import com.fzb.hotel.entity.Room;

import java.util.List;


public interface RoomService {

    /**
     * 获取房型列表
     * @return
     */
    public List<Room> listRoom();

    /**
     * 根据房型id获取房型
     * @return
     */
    public Room getRoomById(Long id);

    /**
     * 搜索房间
     * @param room
     * @return
     */
    public List<Room> searchRoom(Room room);


    /**
     * 添加房型
     * @return
     */
    public Integer addRoom(Room room);


    /**
     * 编辑房型
     * @return
     */
    public Integer editRoom(Room room);



    /**
     * 删除房型
     * @return
     */
    public Integer deleteRoom(Long id);
}
