package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;


@Document(collection = "Users")
//用户表
public class Users {
    @Id
    private String id;
    private String username;
    private String passwd;
    private String userstate; //用户状态,冻结、封号、正常
    private Date freezetime; //冻结时间
    private Date nfreezetime;  //解除冻结时间
    private Date regTime;  //注册时间

    public Users() {
    }

    public Users(String username, String passwd, String userstate, Date freezetime, Date nfreezetime, Date regTime) {
        this.username = username;
        this.passwd = passwd;
        this.userstate = userstate;
        this.freezetime = freezetime;
        this.nfreezetime = nfreezetime;
        this.regTime = regTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getUserstate() {
        return userstate;
    }

    public void setUserstate(String userstate) {
        this.userstate = userstate;
    }

    public Date getFreezetime() {
        return freezetime;
    }

    public void setFreezetime(Date freezetime) {
        this.freezetime = freezetime;
    }

    public Date getNfreezetime() {
        return nfreezetime;
    }

    public void setNfreezetime(Date nfreezetime) {
        this.nfreezetime = nfreezetime;
    }

    public Date getRegTime() {
        return regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }
}

