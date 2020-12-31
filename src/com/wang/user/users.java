package com.wang.user;

public class users {
    private String name;
    private String pwd;

    public users() {
    }

    public users(String name, String pwd) {
        this.name = name;
        this.pwd = pwd;
    }

    public users(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

}
