package com.bbs.bean;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "BackPost")
//回帖表
public class BackPost {
    private String bPostContent;  //回帖内容
    private String bPostUname;    //回帖用户名
    private String postId;        //回复对应的发帖id
    private Date bPostTime;       //回帖时间
    private String _id;


    public BackPost(String bPostContent, String bPostUname, String postId, Date bPostTime) {
        this.bPostContent = bPostContent;
        this.bPostUname = bPostUname;
        this.postId = postId;
        this.bPostTime = bPostTime;
    }

    public BackPost() {
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getbPostContent() {
        return bPostContent;
    }

    public void setbPostContent(String bPostContent) {
        this.bPostContent = bPostContent;
    }

    public String getbPostUname() {
        return bPostUname;
    }

    public void setbPostUname(String bPostUname) {
        this.bPostUname = bPostUname;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public Date getbPostTime() {
        return bPostTime;
    }

    public void setbPostTime(Date bPostTime) {
        this.bPostTime = bPostTime;
    }
}
