package com.fzb.hotel.service.impl;


import com.fzb.hotel.entity.Room;
import com.fzb.hotel.mapper.LayoutMapper;
import com.fzb.hotel.mapper.RoomMapper;
import com.fzb.hotel.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomMapper roomMapper;

    @Autowired
    private LayoutMapper layoutMapper;


    @Override
    public List<Room> listRoom() {
        List<Room> rooms = this.roomMapper.listRoom();
        for (int i = 0; i < rooms.size(); i++) {
            rooms.get(i).setLayout(this.layoutMapper.getLayoutById(rooms.get(i).getLayoutId()));
        }
        return rooms;
    }

    @Override
    public Room getRoomById(Long id) {
        return this.roomMapper.getRoomById(id);
    }

    @Override
    public List<Room> searchRoom(Room room) {
        if (room.getRoomNo() == "") {
            room.setRoomNo(null);
        }
        if (room.getStatus() == 0) {
            room.setStatus(null);
        }
        List<Room> rooms = this.roomMapper.searchRoom(room);
        for (int i = 0; i < rooms.size(); i++) {
            rooms.get(i).setLayout(this.layoutMapper.getLayoutById(rooms.get(i).getLayoutId()));
        }
        return rooms;

    }

    @Override
    public Integer addRoom(Room room) {
        return this.roomMapper.addRoom(room);
    }

    @Override
    public Integer editRoom(Room room) {
        return this.roomMapper.editRoom(room);
    }

    @Override
    public Integer deleteRoom(Long id) {
        return this.roomMapper.deleteRoom(id);
    }
}
