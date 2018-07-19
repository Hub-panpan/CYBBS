package com.bbs.service;

import com.bbs.bean.Post;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service
public class PostService {
    @Autowired
    MongoTemplate mongoTemplate;

    //getALL
    public List<Post> getAll(){

        List<Post> data = mongoTemplate.findAll(Post.class);
        return data;
    }
    //getOne
    public Post getOneById(String _id){
        Query query = new Query();
        query.addCriteria(where("_id").is(_id));
        Post section = mongoTemplate.findOne(query,Post.class);
        return section;
    }
    //getAll，自定义语句查询对象
    public List<Post> getAllByQ(Query query){
        List<Post> data = mongoTemplate.find(query,Post.class);
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }

    //addOne
    public void addOneO(Post post){

        mongoTemplate.insert(post);
    }
    //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(new Query().addCriteria(where("_id").is(_id)),Post.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(query,Post.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(String _id, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(_id));
        WriteResult writeResult =mongoTemplate.updateFirst(query,update,Post.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateMulti(query,update,Post.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateMulti(query,update,Post.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

}
