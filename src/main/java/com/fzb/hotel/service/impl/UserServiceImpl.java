package com.fzb.hotel.service.impl;

import com.fzb.hotel.entity.User;
import com.fzb.hotel.mapper.UserMapper;
import com.fzb.hotel.service.UserService;
import com.fzb.hotel.vo.GlobalResult;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User findUserByUsernameAndPassword(String username,String password) {
        password = this.encrypt(password, username);
        System.out.println(password);
        return this.userMapper.findUserByUsernameAndPassword(username, password);
    }

    @Override
    public List<User> listUser() {
        return this.userMapper.listUser();
    }

    @Override
    public List<User> searchUser(String username) {
        return this.userMapper.searchUser(username);
    }

    @Override
    public User getUserById(Long id) {
        return this.userMapper.getUserById(id);
    }

    @Override
    public List<User> getUserListByRoleId(Long roleId) {
        return this.userMapper.getUserListByRoleId(roleId);
    }

    @Override
    public Long addUser(User user) {
        user.setPassword(this.encrypt(user.getPassword(), user.getUsername()));
        return this.userMapper.addUser(user);
    }

    @Override
    public Integer editUser(User user) {
        if (user.getPassword() != null && !("".equals(user.getPassword())) ) {
            user.setPassword(this.encrypt(user.getPassword(), user.getUsername()));
        } else {
            user.setPassword(null);
        }
        return this.userMapper.editUser(user);
    }

    @Override
    public Integer deleteUser(Long id) {
        // 删除用户的权限
        this.userMapper.deleteUserRole(id);
        // 删除用户
        return this.userMapper.deleteUser(id);
    }

    @Override
    public GlobalResult updateUserRole(Long userId, String roleIds) {

        // 删除用户下所有的角色
        this.userMapper.deleteUserRole(userId);
        String[] rIds = roleIds.split(",");

        for (String rId : rIds) {
            this.userMapper.addUserRole(userId, Long.parseLong(rId));
        }
        return GlobalResult.build(1, "");
    }



    /**
     * 加密
     *
     * @param source 密码
     * @param salt   账号
     */
    private String encrypt(String source, String salt) {
        int hashIterations = 2;
        Md5Hash md5 = new Md5Hash(source, salt, hashIterations);
        return md5.toString();
    }


}
