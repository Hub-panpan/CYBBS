package com.bbs.service;

import com.bbs.bean.UsersInfo;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service("UsersInfoService")
public class UsersInfoService {
    @Autowired
    private MongoTemplate mop;

    //getALL
    public List<UsersInfo> getAll(){

        List<UsersInfo> data = mop.findAll(UsersInfo.class);
        return data;
    }
    //getOne
    public UsersInfo getOneById(String username){
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        UsersInfo UsersInfo = mop.findOne(query, com.bbs.bean.UsersInfo.class);
        return UsersInfo;
    }
    //getAll，自定义语句查询对象
    public List<UsersInfo> getAllByQ(Query query){
        List<UsersInfo> data = mop.find(query,UsersInfo.class);
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }
    //getSumByQ
    public long getSumByQ(Query query){
        return mop.count(query,UsersInfo.class);
    }

    //addOne
    public void addOneO(UsersInfo UsersInfo){
        mop.insert(UsersInfo);
    }
    //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsersInfo0=findByUName(pb_name);
        WriteResult writeResult=mop.remove(new Query().addCriteria(where("_id").is(_id)),UsersInfo.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsersInfo0=findByUName(pb_name);
        WriteResult writeResult=mop.remove(query,UsersInfo.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(UsersInfo UsersInfo, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(UsersInfo.getId()));
        WriteResult writeResult =mop.updateFirst(query,update, com.bbs.bean.UsersInfo.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mop.updateFirst(query,update,UsersInfo.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mop.updateMulti(query,update,UsersInfo.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }
}
