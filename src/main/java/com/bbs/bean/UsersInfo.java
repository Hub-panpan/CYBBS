package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;

@Document(collection = "UsersInfo")
//用户详细信息表
public class UsersInfo {
    @Id
    private String id;
    private String username;
    private int integralSum;  //积分数量
    private int goldSum;   //金币数量
    private int rank;   //等级
    private double empiricValue;  //经验值
    private int joinFGSum;  //参加朋友圈个数
    private int createFGSum;  //参加朋友圈个数
    private List<String> joinFGList=new ArrayList<>();  //参加朋友圈
    private List<String> createFGList=new ArrayList<>(); //创建朋友圈
    private int postSum;  //发帖数
    private int backPostSum;  //回帖数目
    private List<String> backPostList=new ArrayList<>();  //回帖
    private List<String> postList=new ArrayList<>();  //发帖
    private List<String> tempSectList=new ArrayList<>();  //开始专题
    private int tempSectSum;  //开始专题个数


    private List<String> sectionList=new ArrayList<>();  //管理板块
    private int sectionSum;  //管理版块个数
    private List<String> toolList=new ArrayList<>();  //拥有道具
    private int toolSum;  //拥有道具个数
    private int isTempSect;  //是否可以开设专题

    private int isSection;  //是否可以管理版块
    private String role;  //用户的角色：版主或普通用户

    public UsersInfo() {
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

    public int getIntegralSum() {
        return integralSum;
    }

    public void setIntegralSum(int integralSum) {
        this.integralSum = integralSum;
    }

    public int getGoldSum() {
        return goldSum;
    }

    public void setGoldSum(int goldSum) {
        this.goldSum = goldSum;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public double getEmpiricValue() {
        return empiricValue;
    }

    public void setEmpiricValue(double empiricValue) {
        this.empiricValue = empiricValue;
    }

    public int getJoinFGSum() {
        return joinFGSum;
    }

    public void setJoinFGSum(int joinFGSum) {
        this.joinFGSum = joinFGSum;
    }

    public int getCreateFGSum() {
        return createFGSum;
    }

    public void setCreateFGSum(int createFGSum) {
        this.createFGSum = createFGSum;
    }

    public List<String> getJoinFGList() {
        return joinFGList;
    }

    public void setJoinFGList(List<String> joinFGList) {
        this.joinFGList = joinFGList;
    }

    public List<String> getCreateFGList() {
        return createFGList;
    }

    public void setCreateFGList(List<String> createFGList) {
        this.createFGList = createFGList;
    }

    public int getPostSum() {
        return postSum;
    }

    public void setPostSum(int postSum) {
        this.postSum = postSum;
    }

    public int getBackPostSum() {
        return backPostSum;
    }

    public void setBackPostSum(int backPostSum) {
        this.backPostSum = backPostSum;
    }

    public List<String> getBackPostList() {
        return backPostList;
    }

    public void setBackPostList(List<String> backPostList) {
        this.backPostList = backPostList;
    }

    public List<String> getPostList() {
        return postList;
    }

    public void setPostList(List<String> postList) {
        this.postList = postList;
    }

    public List<String> getTempSectList() {
        return tempSectList;
    }

    public void setTempSectList(List<String> tempSectList) {
        this.tempSectList = tempSectList;
    }

    public int getTempSectSum() {
        return tempSectSum;
    }

    public void setTempSectSum(int tempSectSum) {
        this.tempSectSum = tempSectSum;
    }

    public List<String> getSectionList() {
        return sectionList;
    }

    public void setSectionList(List<String> sectionList) {
        this.sectionList = sectionList;
    }

    public int getSectionSum() {
        return sectionSum;
    }

    public void setSectionSum(int sectionSum) {
        this.sectionSum = sectionSum;
    }

    public List<String> getToolList() {
        return toolList;
    }

    public void setToolList(List<String> toolList) {
        this.toolList = toolList;
    }

    public int getToolSum() {
        return toolSum;
    }

    public void setToolSum(int toolSum) {
        this.toolSum = toolSum;
    }

    public int getIsTempSect() {
        return isTempSect;
    }

    public void setIsTempSect(int isTempSect) {
        this.isTempSect = isTempSect;
    }

    public int getIsSection() {
        return isSection;
    }

    public void setIsSection(int isSection) {
        this.isSection = isSection;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}