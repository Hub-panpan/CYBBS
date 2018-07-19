package com.bbs.service;

import com.bbs.bean.Section;
import com.bbs.bean.SiteInformation;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service
public class SiteInfoService {
    @Autowired
    MongoTemplate mongoTemplate;

    //getALL
    public List<SiteInformation> getAll(){

        List<SiteInformation> data = mongoTemplate.findAll(SiteInformation.class,"SiteInformation");
        return data;
    }
    //getOne
    public SiteInformation getOneById(String _id){
        Query query = new Query();
        query.addCriteria(where("_id").is(_id));
        SiteInformation siteInformation = mongoTemplate.findOne(query,SiteInformation.class,"SiteInformation");
        return siteInformation;
    }
    //getAll，自定义语句查询对象
    public List<SiteInformation> getAllByQ(Query query){
        List<SiteInformation> data = mongoTemplate.find(query,SiteInformation.class,"SiteInformation");
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }
    //addOne
    public void addOneO(SiteInformation siteInformation){

        mongoTemplate.insert(siteInformation,"SiteInformation");
    }
    //deleteOne
    public boolean deleteOneById(String _id){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(new Query().addCriteria(where("_id").is(_id)),SiteInformation.class,"SiteInformation");
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }
    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
//        PublicLinkMan publicUsers0=findByUName(pb_name);
        WriteResult writeResult=mongoTemplate.remove(query,SiteInformation.class,"SiteInformation");
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(SiteInformation siteInformation, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(siteInformation.get_id()));
        WriteResult writeResult =mongoTemplate.updateFirst(query,update,SiteInformation.class,"SiteInformation");
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateFirst(query,update,Section.class,"SiteInformation");
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mongoTemplate.updateMulti(query,update,SiteInformation.class,"SiteInformation");
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }
}
