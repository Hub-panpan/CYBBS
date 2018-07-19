package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;

@Document(collection = "Section")
//板块表
public class Section {
    @Id
    private String id;
    private List<String> sonSectionList=new ArrayList<>(); //子版块
    private List<String> moderatorList=new ArrayList<>();  //版主
    private int sonSectionSum;   //子板块个数
    private int moderatorSum;    //版主个数
    private String sectName;     //板块名
    private String sectDescribe; //内容描述
    private int sectPostSum;     //板块发帖数目
    private List<String> sectPostList=new ArrayList<>(); //板块发帖
    private int sectBPostSum;    //板块回帖数目
    private List<String> sectBPostList=new ArrayList<>(); //板块回帖

    public Section() {
    }

    public Section(List<String> sonSectionList, List<String> moderatorList, int sonSectionSum, int moderatorSum, String sectName, String sectDescribe, int sectPostSum, List<String> sectPostList, int sectBPostSum, List<String> sectBPostList) {
        this.sonSectionList = sonSectionList;
        this.moderatorList = moderatorList;
        this.sonSectionSum = sonSectionSum;
        this.moderatorSum = moderatorSum;
        this.sectName = sectName;
        this.sectDescribe = sectDescribe;
        this.sectPostSum = sectPostSum;
        this.sectPostList = sectPostList;
        this.sectBPostSum = sectBPostSum;
        this.sectBPostList = sectBPostList;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<String> getSonSectionList() {
        return sonSectionList;
    }

    public void setSonSectionList(List<String> sonSectionList) {
        this.sonSectionList = sonSectionList;
    }

    public List<String> getModeratorList() {
        return moderatorList;
    }

    public void setModeratorList(List<String> moderatorList) {
        this.moderatorList = moderatorList;
    }

    public int getSonSectionSum() {
        return sonSectionSum;
    }

    public void setSonSectionSum(int sonSectionSum) {
        this.sonSectionSum = sonSectionSum;
    }

    public int getModeratorSum() {
        return moderatorSum;
    }

    public void setModeratorSum(int moderatorSum) {
        this.moderatorSum = moderatorSum;
    }

    public String getSectName() {
        return sectName;
    }

    public void setSectName(String sectName) {
        this.sectName = sectName;
    }

    public String getSectDescribe() {
        return sectDescribe;
    }

    public void setSectDescribe(String sectDescribe) {
        this.sectDescribe = sectDescribe;
    }

    public int getSectPostSum() {
        return sectPostSum;
    }

    public void setSectPostSum(int sectPostSum) {
        this.sectPostSum = sectPostSum;
    }

    public List<String> getSectPostList() {
        return sectPostList;
    }

    public void setSectPostList(List<String> sectPostList) {
        this.sectPostList = sectPostList;
    }

    public int getSectBPostSum() {
        return sectBPostSum;
    }

    public void setSectBPostSum(int sectBPostSum) {
        this.sectBPostSum = sectBPostSum;
    }

    public List<String> getSectBPostList() {
        return sectBPostList;
    }

    public void setSectBPostList(List<String> sectBPostList) {
        this.sectBPostList = sectBPostList;
    }
}