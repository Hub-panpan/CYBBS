package com.bbs.bean;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Tools")
//道具表
public class Tools {
    private String _id;
    private String toolName; //道具名
    private double toolPrice; //道具价格

    public Tools() {
    }

    public Tools(String toolName, double toolPrice) {
        this.toolName = toolName;
        this.toolPrice = toolPrice;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getToolName() {
        return toolName;
    }

    public void setToolName(String toolName) {
        this.toolName = toolName;
    }

    public double getToolPrice() {
        return toolPrice;
    }

    public void setToolPrice(double toolPrice) {
        this.toolPrice = toolPrice;
    }
}
