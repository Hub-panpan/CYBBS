package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;

@Document(collection = "sonSection")
//子版块表
public class SonSection {
    @Id
    private String id;
    private String fSectName;  //父板块名
    private String sonSectName; //子板块名
    private String sonSectDescribe; //板块描述
//    private List<String> sonSectPostList=new ArrayList<>(); //发帖
//    private List<String> sonSectBPostList=new ArrayList<>(); //回帖
    private int sonSectPostSum; //发帖个数
    private int sonSectBPostSum;//回帖个数

    public SonSection() {
    }

    public SonSection(String fSectName, String sonSectName, String sonSectDescribe,  int sonSectPostSum, int sonSectBPostSum) {
        this.fSectName = fSectName;
        this.sonSectName = sonSectName;
        this.sonSectDescribe = sonSectDescribe;
//        this.sonSectPostList = sonSectPostList;
//        this.sonSectBPostList = sonSectBPostList;
        this.sonSectPostSum = sonSectPostSum;
        this.sonSectBPostSum = sonSectBPostSum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getfSectName() {
        return fSectName;
    }

    public void setfSectName(String fSectName) {
        this.fSectName = fSectName;
    }

    public String getSonSectName() {
        return sonSectName;
    }

    public void setSonSectName(String sonSectName) {
        this.sonSectName = sonSectName;
    }

    public String getSonSectDescribe() {
        return sonSectDescribe;
    }



    public int getSonSectPostSum() {
        return sonSectPostSum;
    }

    public void setSonSectPostSum(int sonSectPostSum) {
        this.sonSectPostSum = sonSectPostSum;
    }

    public int getSonSectBPostSum() {
        return sonSectBPostSum;
    }

    public void setSonSectBPostSum(int sonSectBPostSum) {
        this.sonSectBPostSum = sonSectBPostSum;
    }
}
