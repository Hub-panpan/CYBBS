package com.bbs.util;//package com.bbs.util;
//
//import com.bbs.bean.Users;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.mongodb.core.MongoTemplate;
//import org.springframework.data.mongodb.core.query.Query;
//import org.springframework.data.mongodb.core.query.Update;
//import org.springframework.stereotype.Service;
//
//import java.util.Date;
//import java.util.Timer;
//import java.util.TimerTask;
//
//import static org.springframework.data.mongodb.core.query.Criteria.where;
//
//@Service("Task")
//public class Task {
//    @Autowired
//    private MongoTemplate mop;
//      public void excuteTask(){
//          Timer timer = new Timer();
//          timer.schedule(new MyTask(),1000,1800000);
//      }
//
//
//    class MyTask extends TimerTask{
//        @Override
//        public void run() {
//            Query query = new Query();
//            query.addCriteria(where("userstate").is("已冻结").and("nfreezetime").lte(new Date()));
//            mop.updateMulti(query,new Update().
//                            set("userstate","正常").
//                            set("freezetime",null).
//                            set("nfreezetime",null),
//                    Users.class);
//        }
//
//    }
//}
