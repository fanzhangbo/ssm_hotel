package com.fzb.hotel.entity;

import java.io.Serializable;

public class Room implements Serializable {

    private Long id;
    private String roomNo;
    private Long layoutId;
    private Integer status;
    private Layout layout;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public Long getLayoutId() {
        return layoutId;
    }

    public void setLayoutId(Long layoutId) {
        this.layoutId = layoutId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Layout getLayout() {
        return layout;
    }

    public void setLayout(Layout layout) {
        this.layout = layout;
    }

    @Override
    public String toString() {
        return "Room{" +
                "id=" + id +
                ", roomNo='" + roomNo + '\'' +
                ", layoutId=" + layoutId +
                ", status=" + status +
                ", layout=" + layout +
                '}';
    }
}
