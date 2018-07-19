package com.bbs.service;

import com.bbs.bean.Users;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service("UsersService")
public class UsersService {
    @Autowired
    private MongoTemplate mop;

    //getALL
    public List<Users> getAll(){
        List<Users> data = mop.findAll(Users.class);
        return data;
    }
    //getOne
    public Users getOneById(String username){
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        Users Users = mop.findOne(query, com.bbs.bean.Users.class);
        return Users;
    }
    //getAll，自定义语句查询对象
    public List<Users> getAllByQ(Query query){
        List<Users> data = mop.find(query,Users.class);
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }
    //getSumByQ
    public long getSumByQ(Query query){
        return mop.count(query,Users.class);
    }


    //addOne
    public void addOneO(Users Users){
        mop.insert(Users);
    }
    //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mop.remove(new Query().addCriteria(where("_id").is(_id)),Users.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mop.remove(query,Users.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(Users Users, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(Users.getId()));
        WriteResult writeResult =mop.updateFirst(query,update, com.bbs.bean.Users.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mop.updateFirst(query,update,Users.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mop.updateMulti(query,update,Users.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }
}
