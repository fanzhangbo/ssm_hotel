package com.fzb.hotel.controller;

import com.fzb.hotel.entity.Message;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.service.CustomerService;
import com.fzb.hotel.service.MessageService;
import com.fzb.hotel.service.UserService;
import com.fzb.hotel.utils.RandomValidateCode;
import com.fzb.hotel.utils.UserUtils;
import com.fzb.hotel.vo.GlobalResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
@Controller

public class IndexController {


    @Autowired
    private MessageService messageService;

    @Autowired
    private UserService userService;


    /**
     * 登录页面生成验证码
     */
    @RequestMapping(value = "/getVerify")
    public void getVerify(HttpServletRequest request, HttpServletResponse response){
        response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片
        response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        RandomValidateCode randomValidateCode = new RandomValidateCode();
        try {
            randomValidateCode.getRandcode(request, response);//输出验证码图片方法
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping({"/", "/index"})
    public String index(Model model,HttpSession session) {
        User user = UserUtils.getSubjectUser(session);
        model.addAttribute("user", user);
        return "index";
    }

    @RequestMapping("/welcome")
    public String welcome(Model model, HttpSession session) {

//        User user = UserUtils.getSubjectUser(session);
//        Message m = new Message();
//        m.setTargetId(user.getId());
//        m.setReadFlag(1);
//
//        List<Message> msgs = this.messageService.getMessageByMap(m);
//        model.addAttribute("msgs", msgs);

        return "welcome";
    }


    @RequestMapping(value = "/loginAct", method = RequestMethod.POST)
    @ResponseBody
    public GlobalResult loginAct(@RequestParam("username") String username,
                                 @RequestParam("password") String password,
                                 HttpSession session,String inputStr) {


        //从session中获取随机数
        String random = (String) session.getAttribute("RANDOMVALIDATECODEKEY");

//        try {
            if(random.equalsIgnoreCase(inputStr)){
//                // 1.创建令牌
//                UsernamePasswordToken token = new UsernamePasswordToken(username, password);
//                // 2.获取主题subject
//                Subject subject = SecurityUtils.getSubject();
//                // 3.执行login方法
//                subject.login(token);
                User user = this.userService.findUserByUsernameAndPassword(username, password);
                if (user != null) {
                    session.setAttribute("loginUser", user);
                    return GlobalResult.build(1, "登录成功");
                }

                return GlobalResult.build(0, "账号或密码错误");
            } else {
                return GlobalResult.build(0, "验证码错误");
            }
//        } catch (AuthenticationException e) {
//            e.printStackTrace();
//            return GlobalResult.build(0, "账号或密码错误");
//        }
    }


    @RequestMapping("/logout")
    public String logout(HttpSession session) {

        session.removeAttribute("loginUser");
        return "redirect: /login";
    }

    @RequestMapping("/404")
    public String notFound() {
        return "404";
    }
    @RequestMapping("/unauthorized")
    public String unauthorized() {
        return "unauthorized";
    }

}
