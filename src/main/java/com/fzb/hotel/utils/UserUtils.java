package com.fzb.hotel.utils;

import com.fzb.hotel.entity.User;
import org.apache.shiro.SecurityUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class UserUtils {

//    public static User getSubjectUser() {
//        return  (User) SecurityUtils.getSubject().getPrincipal();
//    }

    public static User getSubjectUser(HttpSession session) {
         return (User) session.getAttribute("loginUser");
    }

}
