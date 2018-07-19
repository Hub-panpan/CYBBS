package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.List;
@Document(collection = "SiteInformation")
public class SiteInformation {

    @Id
    private String _id;
    private String owner;
    private List<Mail> receive;
    private List<Mail> send;


    public SiteInformation() {
    }

    public SiteInformation(String owner, List<Mail> receive, List<Mail> send) {
        this.owner = owner;
        this.receive = receive;
        this.send = send;
    }


    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public List<Mail> getReceive() {
        return receive;
    }

    public void setReceive(List<Mail> receive) {
        this.receive = receive;
    }

    public List<Mail> getSend() {
        return send;
    }

    public void setSend(List<Mail> send) {
        this.send = send;
    }


    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }
}
