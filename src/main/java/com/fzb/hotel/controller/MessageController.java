package com.fzb.hotel.controller;

import com.fzb.hotel.entity.Message;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.service.MessageService;
import com.fzb.hotel.service.UserService;
import com.fzb.hotel.utils.UserUtils;
import com.fzb.hotel.vo.GlobalResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private UserService userService;

    @RequestMapping("/listMessage")
    public String listMessage(Model model, HttpSession session) {

        User user = UserUtils.getSubjectUser(session);
        Message m = new Message();
        m.setTargetId( user.getId());
        m.setReadFlag(1);

        List<Message> msgs = this.messageService.getMessageByMap(m);
        model.addAttribute("msgs", msgs);
        return "/welcome";
    }

    @RequestMapping(value = "/message/addMessage", method = RequestMethod.GET)
    public String addMessage(Model model) {

        List<User> users = this.userService.listUser();
        model.addAttribute("users", users);
        return "message/addMessage";
    }

    /**
     * 添加信息
     * @param message
     * @return
     */
    @RequestMapping(value = "/message/addMessageAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult addMessageAct(Message message, HttpSession session) {
        message.setSendId(UserUtils.getSubjectUser(session).getId());
        message.setCreateTime(new Date());
        message.setReadFlag(1);
        this.messageService.addMessage(message);
        return GlobalResult.build(1, "发送成功");
    }

    @RequestMapping(value = "/message/detail/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Long id, Model model, HttpSession session) {

        Message m = new Message();
        m.setId(id);

        List<Message> msgs = this.messageService.getMessageByMap(m);
        model.addAttribute("msgs", msgs);
        if (msgs.size() > 0 && !(msgs.get(0).getSendId().equals(UserUtils.getSubjectUser(session).getId()))) {
            // 设为已读
            m.setReadFlag(2);
            this.messageService.editMessage(m);
        }
        return "message/detail";
    }


    @RequestMapping(value = "/message/inbox", method = RequestMethod.GET)
    public String inbox() {
        return "message/inbox";
    }

    /**
     * 获取收件箱信息
     * @return
     */
    @RequestMapping(value = "/message/getInboxMessage")
    @ResponseBody
    public GlobalResult getInboxMessage(HttpSession session, int page, int limit) {

        User user = UserUtils.getSubjectUser(session);
        Message m = new Message();
        m.setTargetId(user.getId());

        PageHelper.startPage(page, limit);
        List<Message> msgs = this.messageService.getMessageByMap(m);
        PageInfo<Message> info = new PageInfo<>(msgs);
        return new GlobalResult(0, "success", msgs, info.getTotal());
    }


    @RequestMapping(value = "/message/outbox", method = RequestMethod.GET)
    public String outbox() {
        return "message/outbox";
    }


    /**
     * 获取发件箱信息
     * @return
     */
    @RequestMapping(value = "/message/getOutboxMessage", method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult getOutboxMessage(HttpSession session, int page, int limit) {

        User user = UserUtils.getSubjectUser(session);
        Message m = new Message();
        m.setSendId(user.getId());

        PageHelper.startPage(page, limit);
        List<Message> msgs = this.messageService.getMessageByMap(m);
        PageInfo<Message> info = new PageInfo<>(msgs);
        return new GlobalResult(0, "success", msgs, info.getTotal());
    }

    @RequestMapping(value = "/message/getUnreadMsg",method = RequestMethod.GET)
    @ResponseBody
    public GlobalResult getUnreadMsg(HttpSession session) {
        return GlobalResult.build(1, "", this.messageService.getUnreadMsgNum(UserUtils.getSubjectUser(session).getId()));
    }
}
