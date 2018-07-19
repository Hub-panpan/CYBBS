package com.bbs.controller;

import com.bbs.bean.*;
import com.bbs.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Controller
public class SiteInfoController {
    @Autowired
    private FriendsGroupService fs;
    @Autowired
    private PostService postService;
    @Autowired
    private UsersService usersService;
    @Autowired
    private SiteInfoService siteInfoService;
    @Autowired
    private UsersInfoService usersInfoService;

    /******************      创建新用户的时候　进行创建信箱    　成功 */
    @RequestMapping(value = "/siteinfo/create_mysiteInfo.do")
    public String create_mysiteinfo(HttpSession hs) {

        List<Mail> mail1 = new ArrayList<>();
        List<Mail> mail2 = new ArrayList<>();


        String username = (String) hs.getAttribute("username");

        System.out.println("信箱" + username);

        SiteInformation siteInformation = new SiteInformation(username, mail1, mail2);


        siteInfoService.addOneO(siteInformation);


        return "/Zong-index";

    }


    /**********新增一条　　　发件箱子                */
    @RequestMapping(value = "/siteinfo/send_mesg.do")
    public String add_one_info(HttpServletResponse response, HttpServletRequest request, HttpSession hs) {


        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");
        String content = request.getParameter("content");


        System.out.println("fg_name" + sender);
        System.out.println("receiver" + receiver);
        System.out.println("content" + content);


        Date date = new Date();

        //０　　是未读　　　　　　　１指的是这是一条邀请加入朋友圈的操作　


        Date dt = new Date();
        String id = String.valueOf(dt.getTime());
        System.out.println(id);
        Mail mail1 = new Mail(id, receiver, sender, date, content, 1, 0);
        Query query1 = Query.query(Criteria.where("owner").is(sender));
        Update update1 = new Update();
        update1.addToSet("send", mail1);
        siteInfoService.updateOneByQU(query1, update1);


        Mail mail2 = new Mail(id, sender, receiver, date, content, 1, 0);
        Query query2 = Query.query(Criteria.where("owner").is(receiver));
        Update update2 = new Update();
        update2.addToSet("receive", mail2);
        siteInfoService.updateOneByQU(query2, update2);

        hs.setAttribute("succeedInfo", "邀请成功");

        return "succeed";


    }


    @RequestMapping(value = "/siteinfo/read_mesg.do")
    public String update_info(HttpServletResponse response, HttpServletRequest request, HttpSession hs) {

/*
        Query query = Query.query(Criteria.where("_id").is(id)
                .and("tags.tagId").is(tagId));
        Update update = new Update();
        update.set("tags.$.enable", false);

        Mail mail =new Mail(receiver,sender,date,content,1,0);



        Query query1 = Query.query(Criteria.where("owner").is(sender));
        Update update1 = new Update();
        update1.addToSet("send", mail);

        //将自定义的方法写进去
        siteInfoService.updateOneByQU(query1,update1);


        Query query2 = Query.query(Criteria.where("owner").is(receiver));
        Update update2 = new Update();
        update2.addToSet("receive", mail);
        siteInfoService.updateOneByQU(query2,update2);

*/
        return "";


    }


    @RequestMapping(value = "/siteinfo/showAllreceiveInfo.do")
    public String searchAll(HttpServletResponse response, HttpServletRequest request, HttpSession session) {

        System.out.println("我进来了");
        String active_user = (String) session.getAttribute("username");
        System.out.println(active_user);
//        String param=request.getParameter("type");
//        System.out.println(param);
//        List<Mail> receiveMaiList= new ArrayList<>();//收信列表
//        List<Mail> sendMailList= new ArrayList<>();//发件列表
//        Mail receive = new Mail();
//        Mail send = new Mail();
//        System.out.println("＊＊＊＊＊＊＊＊＊＊＊＊" + active_user);
        //查询自己的type，发件箱或者收件箱
        Query query = Query.query(Criteria.where("owner").is(active_user));
//        System.out.println(siteInfoService.getAllByQ(query));
        SiteInformation siteInfoList = siteInfoService.getAllByQ(query).get(0);//站内信对象集合，每人仅有一个信箱
        session.setAttribute("receiveMailList", siteInfoList.getReceive());
        session.setAttribute("sendMailList", siteInfoList.getSend());

        return "MySiteInfo";
    }


    @RequestMapping(value = "/siteinfo/agreeJoinFG")
    public String agree_join_FG(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        //用户　触发两个操作　　　　　　
        // 1.　　修改朋友圈加入圈子成为成员　　　
        // 2.   修改个人信息　我加入的圈子　id　写进去
        //　３．　信箱　是否已读的状态　修改 未完成
        String FGname = null;//来着那个朋友圈的邀请
        String mail_id = request.getParameter("id");//获取子文档id
        System.out.println("正在处理mail_id"+mail_id);

        String state = request.getParameter("state");//获取状态字段
        System.out.println(state.isEmpty());
        System.out.println("参数state："+state);

        //遍历session中的收件箱，获取到来自朋友圈邀请的朋友圈名字
        List<Mail> list = (List<Mail>) session.getAttribute("receiveMailList");
        for (Mail m : list) {
            if (m.get_id().equals(mail_id)) {
                FGname = m.getContent();
            }
        }
        String active_username = (String) session.getAttribute("username");
        System.out.println("同意参加的朋友圈名字："+FGname);
        String fg_id = fs.getAllByQ(Query.query(where("fGName").is(FGname))).get(0).get_id();
        Query query = new Query();
        query.addCriteria(where("username").is(active_username));
        Update update = new Update();
        update.push("joinFGList", fg_id).inc("joinFGSum", 1);
        usersInfoService.updateOneByQU(query, update);//xxx
        Query query1 = new Query();
        System.out.println("创建者的朋友圈的　ID　　请求加入" + fg_id);

        query1.addCriteria(where("_id").is(fg_id));
        Update update1 = new Update();

        update1.addToSet("fGmemberList", active_username).inc("fGMemberSum", +1);
        fs.updateOneByQU(query1, update1);

//        //修改状态值  首先获取receive
//        Query query2 = new Query();
//        query2.addCriteria(where("owner").is(active_username).elemMatch(where("receive._id").is(mail_id)));
//
//        Update update2 = new Update();
//        update2.set("receive.$.state",1);
//        System.out.println(siteInfoService.updateOneByQU(query2, update2));

        if (state == null) {
            Update update2 = new Update();
            update2.set("receive.$.state", 1);//改为已经阅读
//        update2.set("template.$.image", imagePath);
            Query query2 = Query.query(new Criteria().andOperator(Criteria.where("owner")
                    .is(active_username), Criteria.where("receive").elemMatch(Criteria.where("_id").is(mail_id))));
            System.out.println(siteInfoService.updateOneByQU(query2, update2));
        }

        if (state.equals("2")) {
            System.out.println("state2");
            Update update2 = new Update();
            update2.set("receive.$.state", 2);//类型改为忽略
//        update2.set("template.$.image", imagePath);
            Query query2 = Query.query(new Criteria().andOperator(Criteria.where("owner")
                    .is(active_username), Criteria.where("receive").elemMatch(Criteria.where("_id").is(mail_id))));
            System.out.println(siteInfoService.updateOneByQU(query2, update2));
        }

//        return db.updateFirst(query, update, ViewTemplate.class);



        System.out.println("成功加入朋友圈");

        return "forward:/friendgroup/searchAllFG.do";

    }

}