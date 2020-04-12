package com.fzb.hotel.entity;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

public class Menu implements Serializable {

    private Long id;
    private String title;
    private String icon;
    private String href;
    private String target;
    private Long pid;
    private Integer weight;
    private Integer visible;

    private List<Menu> child = new LinkedList<>();

    public Menu() {
    }

    public Menu(String title, String href) {
        this.title = title;
        this.href = href;
    }

    public Menu(Long id, String title, String icon, String href, String target, Long pid, Integer weight, Integer visible, List<Menu> child) {
        this.id = id;
        this.title = title;
        this.icon = icon;
        this.href = href;
        this.target = target;
        this.pid = pid;
        this.weight = weight;
        this.visible = visible;
        this.child = child;
    }

    public Long getId() {

        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public Integer getVisible() {
        return visible;
    }

    public void setVisible(Integer visible) {
        this.visible = visible;
    }

    public List<Menu> getChild() {
        return child;
    }

    public void setChild(List<Menu> child) {
        this.child = child;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", icon='" + icon + '\'' +
                ", href='" + href + '\'' +
                ", target='" + target + '\'' +
                ", pid=" + pid +
                ", weight=" + weight +
                ", visible=" + visible +
                ", child=" + child +
                '}';
    }
}
