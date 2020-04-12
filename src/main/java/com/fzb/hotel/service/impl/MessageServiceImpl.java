package com.fzb.hotel.service.impl;

import com.fzb.hotel.entity.Message;
import com.fzb.hotel.mapper.MessageMapper;
import com.fzb.hotel.mapper.UserMapper;
import com.fzb.hotel.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
@Service
public class MessageServiceImpl implements MessageService{

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Message> getMessageByMap(Message message) {
        List<Message> messageByMap = this.messageMapper.getMessageByMap(message);
        for (Message msg : messageByMap) {
            msg.setSendUser(this.userMapper.getUserById(msg.getSendId()));
            msg.setTargetUser(this.userMapper.getUserById(msg.getTargetId()));
        }
        return messageByMap;
    }




    @Override
    public void addMessage(Message message) {
        this.messageMapper.addMessage(message);
    }

    @Override
    public void editMessage(Message message) {
        this.messageMapper.editMessage(message);
    }

    @Override
    public Integer getUnreadMsgNum(Long targetId) {

        return this.messageMapper.getUnreadMsgNum(targetId);
    }
}
