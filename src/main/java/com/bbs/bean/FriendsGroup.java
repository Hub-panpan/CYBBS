package com.bbs.bean;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;

@Document(collection = "FriendsGroup")
//朋友圈类
public class FriendsGroup {
    private String _id;
    private String fGName;    //朋友圈名
    private String fGController;  //管理者用户名
    private int fGMemberSum;  //圈子成员个数  //废弃
    private List<String> fGmemberList=new ArrayList<>(); //圈子成员
    private String fGDescribe; //对朋友圈的描述
    private int fGPostSum; //发帖个数     //废弃
    private List<String> fGPostList=new ArrayList<>(); //发帖
    private int fGBackPostSum;  //回帖个数   //废弃
    private List<String> fGBackPostList=new ArrayList<>(); //回帖

    public FriendsGroup() {
    }

    public FriendsGroup(String fGName, String fGController, int fGMemberSum, List<String> fGmemberList, String fGDescribe, int fGPostSum, List<String> fGPostList, int fGBackPostSum, List<String> fGBackPostList) {
        this.fGName = fGName;
        this.fGController = fGController;
        this.fGMemberSum = fGMemberSum;
        this.fGmemberList = fGmemberList;
        this.fGDescribe = fGDescribe;
        this.fGPostSum = fGPostSum;
        this.fGPostList = fGPostList;
        this.fGBackPostSum = fGBackPostSum;
        this.fGBackPostList = fGBackPostList;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getfGName() {
        return fGName;
    }

    public void setfGName(String fGName) {
        this.fGName = fGName;
    }

    public String getfGController() {
        return fGController;
    }

    public void setfGController(String fGController) {
        this.fGController = fGController;
    }

    public int getfGMemberSum() {
        return fGMemberSum;
    }

    public void setfGMemberSum(int fGMemberSum) {
        this.fGMemberSum = fGMemberSum;
    }

    public List<String> getfGmemberList() {
        return fGmemberList;
    }

    public void setfGmemberList(List<String> fGmemberList) {
        this.fGmemberList = fGmemberList;
    }

    public String getfGDescribe() {
        return fGDescribe;
    }

    public void setfGDescribe(String fGDescribe) {
        this.fGDescribe = fGDescribe;
    }

    public int getfGPostSum() {
        return fGPostSum;
    }

    public void setfGPostSum(int fGPostSum) {
        this.fGPostSum = fGPostSum;
    }

    public List<String> getfGPostList() {
        return fGPostList;
    }

    public void setfGPostList(List<String> fGPostList) {
        this.fGPostList = fGPostList;
    }

    public int getfGBackPostSum() {
        return fGBackPostSum;
    }

    public void setfGBackPostSum(int fGBackPostSum) {
        this.fGBackPostSum = fGBackPostSum;
    }

    public List<String> getfGBackPostList() {
        return fGBackPostList;
    }

    public void setfGBackPostList(List<String> fGBackPostList) {
        this.fGBackPostList = fGBackPostList;
    }
}
