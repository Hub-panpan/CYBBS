package com.bbs.service;


import com.bbs.bean.Section;
import com.mongodb.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Service("SectionService")
public class SectionService {
    @Autowired
    private MongoTemplate mop;

    //getALL
    public List<Section> getAll(){

        List<Section> data = mop.findAll(Section.class);
        return data;
    }
    //getOne
    public Section getOneById(String username){
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        Section section = mop.findOne(query,Section.class);
        return section;
    }

    public Section getOneByQ(Query query){
        Section section = mop.findOne(query,Section.class);
        return section;
    }

    //getAll，自定义语句查询对象
    public List<Section> getAllByQ(Query query){
        List<Section> data = mop.find(query,Section.class);
        if(!data.isEmpty()){
            return data;
        }
        return null;
    }

    //是否存在该版块
    public boolean ifExists(String secName){
        List<Section> secList = mop.findAll(Section.class);
        for (Section sec:secList){
            if (secName.equals(sec.getSectName()))
                return true;
        }
        return false;
    }

    //addOne
    public void addOneO(Section section){
        mop.insert(section);
    }
    //deleteOne
    public boolean deleteOneById(String _id){
        WriteResult writeResult=mop.remove(new Query().addCriteria(where("_id").is(_id)),Section.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    public boolean deleteOneByQ(Query query){
        WriteResult rs = mop.remove(query,Section.class);
        if (rs.getN()>0)
            return true;
        return false;
    }

    //板块总数：
    public long sectionSum(Query query){
        return mop.count(query,Section.class);
    }

    //delete，自己设计删除语句
    public boolean deleteAllByQ(Query query){
        WriteResult writeResult=mop.remove(query,Section.class);
        if(writeResult.getN()>0){
            return true;
        }
        return  false;
    }

    //updateOne
    public boolean updateOneById(Section section, Update update){
        Query query=new Query();
        query.addCriteria(where("_id").is(section.getId()));
        WriteResult writeResult =mop.updateFirst(query,update,Section.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateOne,自定义语句进行更新
    public boolean updateOneByQU(Query query, Update update){
        WriteResult writeResult =mop.updateFirst(query,update,Section.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

    //updateAll,自定义语句进行更新
    public boolean updateAllByQU(Query query, Update update){
        WriteResult writeResult =mop.updateMulti(query,update,Section.class);
        if(writeResult.getN()>0){
            return true;
        }
        return false;
    }

}
