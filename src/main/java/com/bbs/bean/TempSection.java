package com.bbs.bean;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Document(collection = "tempSection")
//专题表（临时板块）
public class TempSection {
    private String _id;
    private String tempSectName;  //专题名字(唯一)
    private String tempSectUname; //发起用户名
    private String tempSectDescribe; //主题描述
    private List<String> tempSectPostList=new ArrayList<>(); //发帖
    private List<String> tempSectBPostList=new ArrayList<>(); //回帖
    private int tempSectBPostSum;  //回帖个数        //废弃
    private int tempSectPostSum;  //发帖个数         //废弃
    private Date endTime;        //结束时间
    private Date startTime;     //开始时间
    private int tempSectStatu; //专题的状态，1正在进行、0结束


    public TempSection() {
    }

    public int getTempSectStatu() {
        return tempSectStatu;
    }

    public void setTempSectStatu(int tempSectStatu) {
        this.tempSectStatu = tempSectStatu;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getTempSectName() {
        return tempSectName;
    }

    public void setTempSectName(String tempSectName) {
        this.tempSectName = tempSectName;
    }

    public String getTempSectUname() {
        return tempSectUname;
    }

    public void setTempSectUname(String tempSectUname) {
        this.tempSectUname = tempSectUname;
    }

    public String getTempSectDescribe() {
        return tempSectDescribe;
    }

    public void setTempSectDescribe(String tempSectDescribe) {
        this.tempSectDescribe = tempSectDescribe;
    }

    public List<String> getTempSectPostList() {
        return tempSectPostList;
    }

    public void setTempSectPostList(List<String> tempSectPostList) {
        this.tempSectPostList = tempSectPostList;
    }

    public List<String> getTempSectBPostList() {
        return tempSectBPostList;
    }

    public void setTempSectBPostList(List<String> tempSectBPostList) {
        this.tempSectBPostList = tempSectBPostList;
    }

    public int getTempSectBPostSum() {
        return tempSectBPostSum;
    }

    public void setTempSectBPostSum(int tempSectBPostSum) {
        this.tempSectBPostSum = tempSectBPostSum;
    }

    public int getTempSectPostSum() {
        return tempSectPostSum;
    }

    public void setTempSectPostSum(int tempSectPostSum) {
        this.tempSectPostSum = tempSectPostSum;
    }
}
