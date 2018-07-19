package com.bbs.service;

import com.bbs.bean.FriendsGroup;
import com.bbs.bean.Section;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service
public class FriendsGroupService {
    @Autowired
    MongoTemplate mongoTemplate;

    //getALL
    public List<FriendsGroup> getAll(){

        List<FriendsGroup> data = mongoTemplate.findAll(FriendsGroup.class,"FriendsGroup");
        return data;
    }
    //getOne
    public FriendsGroup getOneById(String _id){
        Query query = new Query();
        query.addCriteria(where("_id").is(_id));
        FriendsGroup friendsGroup = mongoTemplate.findOne(query,FriendsGroup.class,"FriendsGroup");
        return friendsGroup;
    }
    //getAll，自定义语句查询对象
    public List<FriendsGroup> getAllByQ(Query query){
        List<FriendsGroup> data = mongoTemplate.find(query,FriendsGroup.class,"FriendsGroup");
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }
    //addOne
    public void addOneO(FriendsGroup friendsGroup){

        mongoTemplate.insert(friendsGroup,"FriendsGroup");
    }
    //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(new Query().addCriteria(where("_id").is(_id)),FriendsGroup.class,"FriendsGroup");
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(query,FriendsGroup.class,"FriendsGroup");
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(FriendsGroup friendsGroup, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(friendsGroup.get_id()));
        WriteResult writeResult =mongoTemplate.updateFirst(query,update,FriendsGroup.class,"FriendsGroup");
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateFirst(query,update,Section.class,"FriendsGroup");
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateMulti(query,update,FriendsGroup.class,"FriendsGroup");
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }
}
