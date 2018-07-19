package com.bbs.controller;

import com.bbs.bean.Post;
import com.bbs.bean.Section;
import com.bbs.bean.SonSection;
import com.bbs.bean.UsersInfo;
import com.bbs.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Controller
public class SonSectionController {
    @Autowired
    private SonSectionService sonSectionService;
    @Autowired
    private SectionService sectionService;
    @Autowired
    private PostService postService;
    @Autowired
    private UsersInfoService usersInfoService;
    @Autowired
    private BackPostService backPostService;


    /**   * 1.添加新的子板块    * 2.修改父亲专题的　子板块的列表    * */

    /**增加一个子版块         ＊＊＊＊＊＊＊成功！ */
    @RequestMapping(value = "/add/SonSection01")
    public String addSonSection01(HttpSession session,String cwdSectionId){
        System.out.println("***父亲id"+cwdSectionId);
        session.setAttribute("add_cwdSectionId",cwdSectionId);

        return "section/add_section";

    }
    @RequestMapping(value = "/add/SonSection02")
    public String addSonSection02(HttpSession hs,  String sonSectionName,  String sonSectDescribe){
        //得到当前请求操作的　　　父亲板块的ＩＤ
        String   cwdSectionId=(String) hs.getAttribute("add_cwdSectionId");
        System.out.println(cwdSectionId);
        System.out.println(sonSectDescribe);
        System.out.println(sonSectionName);

        if ("".equals(sonSectionName)){
            hs.setAttribute("errorInfo","请输入子版块名");
            return "error";
        }
        System.out.println(sonSectionService.ifExists(sonSectionName));
        if (sonSectionService.ifExists(sonSectionName)){
            hs.setAttribute("errorInfo","子版块已存在");
            return "error";
        }
        Query query=new Query();
        query.addCriteria(where("_id").is(cwdSectionId));
        //得到父板块的名字　　　
        String sectName=sectionService.getOneByQ(query).getSectName();
        System.out.println(sectName);

         List<String> sonSectPostList=null;
//        SonSection  sonSection = new SonSection(sectName,sonSectionName,sonSectDescribe,sonSectPostList,sonSectPostList,0,0);
        SonSection  sonSection = new SonSection(sectName,sonSectionName,sonSectDescribe,0,0);

        sonSectionService.addOneO(sonSection);


        Query q=new Query();
        q.addCriteria(where("_id").is(cwdSectionId));
        Update update = new Update();
        update.addToSet("sonSectionList",sonSectionName).inc("sonSectionSum",1);
        if (!sectionService.updateOneByQU(q,update)){
            hs.setAttribute("errorInfo","添加子版块失败");

        }


        return "redirect:../section/get/userSection";

    }

    /**删除子版块　　　　　　　　　＊＊＊＊＊＊＊成功！*/
    @RequestMapping(value = "/delete/SonSection")
    public String deleteSonSection(HttpSession session,String cwdSonSectionId){

        System.out.println("版主请求删除的子版块的 ID为："+cwdSonSectionId);

        session.setAttribute("cwdSonSectionId",cwdSonSectionId);
        //得到当前在线用户
        String username=(String) session.getAttribute("username");
        //得到在线用户　的详细信息
        UsersInfo usersInfo=usersInfoService.getOneById(username);

        //删除子版块下面的发帖
        //得到　删除的帖子列表信息　　Ｐost表
        List<Post> postDeleteList=new ArrayList<>();
        //１．首先把　删除所有属于此子版块的　　帖子　Ｐost表集合
        postDeleteList=postService.getAllByQ(new Query().addCriteria(where("postSonSection").is(cwdSonSectionId)));

        //2.删除　　回帖信息

        for (Post po:postDeleteList){
            System.out.println("正在删除回帖子："+po.get_id()+po.getPostTitle());
            boolean flag1=postService.deleteOneById(po.get_id());
            boolean s= backPostService.deleteAllByQ(new Query().addCriteria(where("postId").is(po.get_id())));
            System.out.println(s);
        }

      //更新主板块信息
       SonSection  sonSection=sonSectionService.getOneById(cwdSonSectionId);
        System.out.println(sonSection.getfSectName());

        Query q=new Query();
        q.addCriteria(where("sectName").is(sonSection.getfSectName()));
        Update update = new Update();
        update.pull("sonSectionList",sonSection.getSonSectName()).inc("sonSectionSum",-1);

       boolean isTrue2= sectionService.updateOneByQU(q,update);

        //删除子版块
        boolean isSuc3=sonSectionService.deleteOneById(cwdSonSectionId);


        session.setAttribute("succeedInfo","成功");
        return "succeed";
    }


    //修改子版块
    @RequestMapping(value = "/update/SonSection01")
    public String updateSonSection01(HttpSession session,String cwdSonSectionId){


        //String   cwdSonSectionId=(String) session.getAttribute("cwdSonSectionId");
        System.out.println("当前的子版块"+cwdSonSectionId);


        SonSection single_sonSection=sonSectionService.getOneById(cwdSonSectionId);
        session.setAttribute("cwdSectName",single_sonSection.getfSectName());
        System.out.println("用户自定义的管理的板块的id："+single_sonSection.getSonSectName());
        session.setAttribute("cwdSonSectId",single_sonSection.getId());
        //获取当前子版块的所有的帖子信息，加入到集合中。
        List<Post> postList=postService.getAllByQ(new Query().addCriteria(where("postSonSection").is(cwdSonSectionId)));
        System.out.println("管理单一　板块　请求成功！");
        session.setAttribute("single_sonSection",single_sonSection);
        session.setAttribute("cwdPostList",postList);

        return "section/update_section";
    }
    @RequestMapping(value = "/update/SonSection02")
    public String updateSonSection02(HttpSession session,String  old_name, String cwdSonSectionId,String sonSectName,
                                   String sonSectDescribe){
//        session.setAttribute("cwdSonSectionId",cwdSonSectionId);
        //查询子版块信息
        System.out.println(old_name);
        System.out.println(cwdSonSectionId);
        System.out.println(sonSectName);
        System.out.println(sonSectDescribe);


       SonSection sonSection=sonSectionService.getOneById(cwdSonSectionId);
      //  session.setAttribute("cwdSonSection",sonSection);
        if (sonSectName==null||sonSectDescribe==null)
            return "section/update_section";

        boolean s1= sectionService.updateOneByQU(new Query(where("sectName").is(sonSection.getfSectName())),new Update().pull("sonSectionList",old_name));
        boolean s2= sectionService.updateOneByQU(new Query(where("sectName").is(sonSection.getfSectName())),new Update().push("sonSectionList",sonSectName));


        Query query=new Query();
        query.addCriteria(where("_id").is(cwdSonSectionId));

        Update update=new Update();
        update.set("sonSectDescribe",sonSectDescribe).set("sonSectName",sonSectName);
        boolean isSuc=sonSectionService.updateOneByQU(query,update);



//
//        if (!isSuc&&s1&&s2){
//            session.setAttribute("errorInfo","修改失败");
//            return "error";
//        }

        session.setAttribute("succeedInfo","子版块信息修改成功");

        return "succeed";

    }

    //获取一个子版块
    @RequestMapping(value = "/get/SonSection",method = RequestMethod.GET)
    public String getSonSection(HttpSession session,String cwdSonSectionId){
        //传入的参数　是请求查看的朋友圈的　id
        SonSection single_sonSection=sonSectionService.getOneById(cwdSonSectionId);
        session.setAttribute("cwdSectName",single_sonSection.getfSectName());
        System.out.println("用户自定义的管理的板块的id："+single_sonSection.getSonSectName());



        session.setAttribute("cwdSonSectId",single_sonSection.getId());
        //获取当前子版块的所有的帖子信息，加入到集合中。
        List<Post> postList=postService.getAllByQ(new Query().addCriteria(where("postSonSection").is(cwdSonSectionId)));
//        List<Post> postList=new ArrayList<>();
//        for(int i=0;i<5;i++){
//            Post post=new Post();
//            post.setPostUname("duan");
//            post.setPostPageView(3);
//            post.setPostTitle("帖子"+i);
//            postList.add(post);
//        }
        System.out.println("管理单一　板块　请求成功！");
        session.setAttribute("single_sonSection",single_sonSection);
        session.setAttribute("cwdPostList",postList);
        return "section/single_section";
    }


}
