package com.bbs.bean;


import java.util.Date;

public class Mail {

    private String _id;
    private String receive;
    private String send;
    private Date send_date;  //注册时间
    private String content;
    private int type;
    private int state;


    public Mail() {
    }

    public Mail(String _id,String receive, String send, Date send_date, String content, int type, int state) {
        this._id=_id;
        this.receive = receive;
        this.send = send;
        this.send_date = send_date;
        this.content = content;
        this.type = type;
        this.state = state;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getReceive() {
        return receive;
    }

    public void setReceive(String receive) {
        this.receive = receive;
    }

    public String getSend() {
        return send;
    }

    public void setSend(String send) {
        this.send = send;
    }

    public Date getSend_date() {
        return send_date;
    }

    public void setSend_date(Date send_date) {
        this.send_date = send_date;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
