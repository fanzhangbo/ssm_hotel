package com.fzb.hotel.interceptor;

import com.fzb.hotel.entity.Menu;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.service.MenuService;
import com.fzb.hotel.utils.StringUtils;
import com.fzb.hotel.utils.UserUtils;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * TODO
 *
 * @author Fan Zhangbo
 */
public class LoginInterceptor implements HandlerInterceptor{

    @Autowired
    private MenuService menuService;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        User user = (User) httpServletRequest.getSession().getAttribute("loginUser");
        if (user != null) {
            if (user.getId() == 1) {
                return true;
            }
            String requestURI = httpServletRequest.getRequestURI();
            System.out.println("requestURI = " + requestURI);
            List<String> allowArr = new ArrayList<>();
            allowArr.add("/");
            allowArr.add("/index");
            if (allowArr.contains(requestURI)) {
                return true;
            }

            List<Menu> menuList = menuService.getMenuListAllByUserId(user.getId());
            requestURI = StringUtils.trimFirstAndLastChar(requestURI, "/");
            System.out.println("requestURI = " + requestURI);
            for (Menu menu : menuList) {
                System.out.println("menu.getHref = " + menu.getHref());
                if (menu.getHref().length() > 0 && requestURI.startsWith(menu.getHref())) {
                    return  true;
                }
            }

            httpServletResponse.sendRedirect("/unauthorized");
            return false;
        } else {
            httpServletResponse.sendRedirect("/login");
            return false;
        }

    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
