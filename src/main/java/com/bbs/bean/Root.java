package com.bbs.bean;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Root")
//管理员表
public class Root {
    @Id
    private String id;
    private String rootname;
    private String passwd;

    public Root() {
    }

    public Root(String rootname, String passwd) {
        this.rootname = rootname;
        this.passwd = passwd;
    }

    public String getId() {
        return id;
    }

    public void setId(String _id) {
        this.id = id;
    }

    public String getRootname() {
        return rootname;
    }

    public void setRootname(String rootname) {
        this.rootname = rootname;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }
}