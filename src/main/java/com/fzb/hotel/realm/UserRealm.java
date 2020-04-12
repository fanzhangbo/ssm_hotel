package com.fzb.hotel.realm;

import com.fzb.hotel.entity.Menu;
import com.fzb.hotel.entity.User;
import com.fzb.hotel.mapper.MenuMapper;
import com.fzb.hotel.service.MenuService;
import com.fzb.hotel.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;


    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
            throws AuthenticationException {
        System.out.println("认证中......");
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken)authenticationToken;
        String password = new String(usernamePasswordToken.getPassword());
        System.out.println(1);
        System.out.println(usernamePasswordToken);
        System.out.println(usernamePasswordToken.getUsername());
        System.out.println(usernamePasswordToken.getPassword());
        System.out.println(2);
//		// 根据用户名和密码查找用户
        User user = userService.findUserByUsernameAndPassword(usernamePasswordToken.getUsername(), password);
        System.out.println(user);
        System.out.println(3);
        if(user != null) {
            System.out.println(4);
            System.out.println(user);
            //返回认证信息
            //参数1：主角，就是登陆的用户
            //参数2：证书，就是凭证，对应密码
            //参数3：当前realm的名称
            return new SimpleAuthenticationInfo(user, password, getName());
        }
        return null;
    }


    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("授权中。。。。。。。");
        User user = (User) principalCollection.getPrimaryPrincipal();
        List<Menu> menuList = menuService.getMenuListByUserId(user.getId(), false);
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        for (Menu menu : menuList) {
            info.addStringPermission(menu.getTitle());
        }

        return info;
    }


}
