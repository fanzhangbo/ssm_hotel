package com.fzb.hotel.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
public class Message implements Serializable {

    private Long id;
    private Long sendId;
    private Long targetId;
    private Integer rank;
    private Integer readFlag;
    private String content;
    private Date createTime;
    private Date editTime;

    private User sendUser;
    private User targetUser;

    public Message() {
    }

    public Message(Long id, Long sendId, Long targetId, Integer rank, Integer readFlag, String content, Date createTime, Date editTime, User sendUser, User targetUser) {
        this.id = id;
        this.sendId = sendId;
        this.targetId = targetId;
        this.rank = rank;
        this.readFlag = readFlag;
        this.content = content;
        this.createTime = createTime;
        this.editTime = editTime;
        this.sendUser = sendUser;
        this.targetUser = targetUser;
    }

    public Long getId() {

        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSendId() {
        return sendId;
    }

    public void setSendId(Long sendId) {
        this.sendId = sendId;
    }

    public Long getTargetId() {
        return targetId;
    }

    public void setTargetId(Long targetId) {
        this.targetId = targetId;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public Integer getReadFlag() {
        return readFlag;
    }

    public void setReadFlag(Integer readFlag) {
        this.readFlag = readFlag;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getEditTime() {
        return editTime;
    }

    public void setEditTime(Date editTime) {
        this.editTime = editTime;
    }

    public User getSendUser() {
        return sendUser;
    }

    public void setSendUser(User sendUser) {
        this.sendUser = sendUser;
    }

    public User getTargetUser() {
        return targetUser;
    }

    public void setTargetUser(User targetUser) {
        this.targetUser = targetUser;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", sendId=" + sendId +
                ", targetId=" + targetId +
                ", rank=" + rank +
                ", readFlag=" + readFlag +
                ", content='" + content + '\'' +
                ", createTime=" + createTime +
                ", editTime=" + editTime +
                ", sendUser=" + sendUser +
                ", targetUser=" + targetUser +
                '}';
    }
}
