package com.bbs.service;

import com.bbs.bean.SonSection;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service("SonSectionService")
public class SonSectionService {
    @Autowired
    private MongoTemplate mop;

    //getALL
    public List<SonSection> getAll(){

        List<SonSection> data = mop.findAll(SonSection.class);
        return data;
    }
    //getOne
    public SonSection getOneById(String _id){
        Query query = new Query();
        query.addCriteria(where("_id").is(_id));
        SonSection sonSection = mop.findOne(query,SonSection.class);
        return sonSection;
    }
    //getAll，自定义语句查询对象
    public List<SonSection> getAllByQ(Query query){
        List<SonSection> data = mop.find(query,SonSection.class);
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }
    //get数据数
    public long getSumByQ(Query query){
        return mop.count(query,SonSection.class);
    }

    //addOne
    public void addOneO(SonSection sonSection){

        mop.insert(sonSection);
    }

    //是否存在该版块
    public boolean ifExists(String sonSecName) {
        List<SonSection> sonList = mop.findAll(SonSection.class);
        for (SonSection son : sonList) {
            if (sonSecName.equals(son.getSonSectName()))
                return true;
        }
        return false;
    }
        //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mop.remove(new Query().addCriteria(where("_id").is(_id)),SonSection.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mop.remove(query,SonSection.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(SonSection sonSection, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(sonSection.getId()));
        WriteResult writeResult =mop.updateFirst(query,update,SonSection.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mop.updateFirst(query,update,SonSection.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mop.updateMulti(query,update,SonSection.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

}
