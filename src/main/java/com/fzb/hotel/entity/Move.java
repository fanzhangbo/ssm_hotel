package com.fzb.hotel.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 入住
 */
public class Move {

    private Long id;
    private Long customerId;
    private Long roomId;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date moveTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date expireTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    private Double totalPrice;

    private Customer customer;
    private String customerName;
    private Room room;
    private String roomNo;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public Date getMoveTime() {
        return moveTime;
    }

    public void setMoveTime(Date moveTime) {
        this.moveTime = moveTime;
    }

    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "Move{" +
                "id=" + id +
                ", customerId=" + customerId +
                ", roomId=" + roomId +
                ", moveTime=" + moveTime +
                ", expireTime=" + expireTime +
                ", createTime=" + createTime +
                ", totalPrice=" + totalPrice +
                ", customer=" + customer +
                ", customerName='" + customerName + '\'' +
                ", room=" + room +
                ", roomNo='" + roomNo + '\'' +
                '}';
    }
}
