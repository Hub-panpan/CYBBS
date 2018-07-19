package com.bbs.service;

import com.bbs.bean.Root;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

@Service("RootService")
public class RootService {
    @Autowired
    private MongoTemplate mop;
    public Root getAllRoot(){
        return mop.findAll(Root.class).get(0);
    }
}
