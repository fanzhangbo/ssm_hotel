package com.fzb.hotel.entity;

import java.io.Serializable;

public class User implements Serializable {

    private Long id;
    private String username;
    private String password;
    private Integer gender;
    private Integer locked;

    public User() {
    }

    public User(Long id, String username, String password, Integer gender, Integer locked) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.locked = locked;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getLocked() {
        return locked;
    }

    public void setLocked(Integer locked) {
        this.locked = locked;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender=" + gender +
                ", locked=" + locked +
                '}';
    }
}
