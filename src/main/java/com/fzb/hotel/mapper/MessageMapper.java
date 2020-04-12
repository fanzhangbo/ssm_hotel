package com.fzb.hotel.mapper;

import com.fzb.hotel.entity.Message;

import java.util.List;
import java.util.Map;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
public interface MessageMapper {

    /**
     * 根据条件查询消息
     * @param message
     * @return
     */
    public List<Message> getMessageByMap(Message message);


    /**
     * 添加消息
     * @param message
     */
    public void addMessage(Message message);

    /**
     * 修改信息
     * @param message
     */
    public void editMessage(Message message);


    Integer getUnreadMsgNum(Long targetId);
}
