package com.bbs.service;

import com.bbs.bean.BackPost;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service
public class BackPostService {
    @Autowired
    MongoTemplate mongoTemplate;

    //getALL
    public List<BackPost> getAll(){

        List<BackPost> data = mongoTemplate.findAll(BackPost.class);
        return data;
    }
    //getOne
    public BackPost getOneById(String _id){
        Query query = new Query();
        query.addCriteria(where("_id").is(_id));
        BackPost section = mongoTemplate.findOne(query,BackPost.class);
        return section;
    }
    //getAll，自定义语句查询对象
    public List<BackPost> getAllByQ(Query query){
        List<BackPost> data = mongoTemplate.find(query,BackPost.class);
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }
    //addOne
    public void addOneO(BackPost BackPost){

        mongoTemplate.insert(BackPost);
    }
    //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(new Query().addCriteria(where("_id").is(_id)),BackPost.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(query,BackPost.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(BackPost BackPost, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(BackPost.get_id()));
        WriteResult writeResult =mongoTemplate.updateFirst(query,update, com.bbs.bean.BackPost.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateFirst(query,update,BackPost.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateMulti(query,update,BackPost.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

}
