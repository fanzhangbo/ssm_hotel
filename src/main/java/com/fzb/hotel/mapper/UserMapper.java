package com.fzb.hotel.mapper;


import com.fzb.hotel.entity.Role;
import com.fzb.hotel.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    /**
     * 根据用户名查询用户
     * @param username
     * @param password
     * @return
     */
    public User findUserByUsernameAndPassword(@Param("username")String username,
                                              @Param("password")String password) ;


    /**
     * 查询所有用户
     * @return
     */
    public List<User> listUser();


    /**
     * 搜索用户
     * @param username
     * @return
     */
    public List<User> searchUser(String username);

    /**
     * 根据用户id获取用户
     * @return
     */
    public User getUserById(Long id);


    /**
     * 根据角色id查询用户列表
     * @param roleId
     * @return
     */
    public List<User> getUserListByRoleId(Long roleId);


    /**
     * 添加用户
     * @return
     */
    public Long addUser(User user);

    /**
     * 编辑用户
     * @return
     */
    public Integer editUser(User user);


    /**
     * 删除用户
     * @return
     */
    public Integer deleteUser(Long id);

    /**
     * 添加用户角色
     * @param userId
     * @param roleId
     */
    public void addUserRole(@Param("userId") Long userId, @Param("roleId")Long roleId);

    /**
     * 删除用户角色
     * @param userId
     */
    public void deleteUserRole(@Param("userId") Long userId);


}
