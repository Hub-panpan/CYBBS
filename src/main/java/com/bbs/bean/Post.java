package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "Post")
//发帖表
public class Post {
    @Id
    private String _id;
    private String postTitle;   //帖名(标题)
    private String postUname;   //发帖用户名
    private int postPageView;  //浏览量
    private Date postTime;      //发帖时间
    private String postSonSection;  //所属子板块或专题或朋友圈ID
    private int postType;       // 帖子类型（红包贴、奖励贴）
    private String postContent; //帖子内容
    private int backPostSum;    //回帖次数
    private int postIntegral;   //帖子积分
    private int postLabel;      //所属类别：1板块或2专题或3朋友圈

    public Post() {
    }

    public Post(String postTitle, String postUname, int postPageView, Date postTime, String postSonSection, int postType, String postContent, int backPostSum, int postIntegral, int postLabel) {
        this.postTitle = postTitle;
        this.postUname = postUname;
        this.postPageView = postPageView;
        this.postTime = postTime;
        this.postSonSection = postSonSection;
        this.postType = postType;
        this.postContent = postContent;
        this.backPostSum = backPostSum;
        this.postIntegral = postIntegral;
        this.postLabel = postLabel;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostUname() {
        return postUname;
    }

    public void setPostUname(String postUname) {
        this.postUname = postUname;
    }

    public long getPostPageView() {
        return postPageView;
    }

    public void setPostPageView(int postPageView) {
        this.postPageView = postPageView;
    }

    public Date getPostTime() {
        return postTime;
    }

    public void setPostTime(Date postTime) {
        this.postTime = postTime;
    }

    public String getPostSonSection() {
        return postSonSection;
    }

    public void setPostSonSection(String postSonSection) {
        this.postSonSection = postSonSection;
    }

    public int getPostType() {
        return postType;
    }

    public void setPostType(int postType) {
        this.postType = postType;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public int getBackPostSum() {
        return backPostSum;
    }

    public void setBackPostSum(int backPostSum) {
        this.backPostSum = backPostSum;
    }

    public int getPostIntegral() {
        return postIntegral;
    }

    public void setPostIntegral(int postIntegral) {
        this.postIntegral = postIntegral;
    }

    public int getPostLabel() {
        return postLabel;
    }

    public void setPostLabel(int postLabel) {
        this.postLabel = postLabel;
    }
}
