package com.bbs.controller;

import com.bbs.bean.FriendsGroup;
import com.bbs.bean.Post;
import com.bbs.bean.Users;
import com.bbs.bean.UsersInfo;
import com.bbs.service.FriendsGroupService;
import com.bbs.service.PostService;
import com.bbs.service.UsersInfoService;
import com.bbs.service.UsersService;
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
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

import static org.springframework.data.mongodb.core.query.Criteria.where;


@Controller
public class fgController {
    @Autowired
    private FriendsGroupService fs;
    @Autowired
    private PostService postService;
    @Autowired
    private UsersService usersService;
    @Autowired
    private UsersInfoService usersInfoService;

    @RequestMapping(value = "/friendgroup/searchAllFG.do")
    public String searchAllFG(HttpSession hs) {
        //List<myUsers> usersList = fs.getGroup(u.getUsername());

        String cuser = (String) hs.getAttribute("username");
        System.out.println("当前用户：" + cuser);


        Query query = new Query();

        query.addCriteria(where("fGController").is(cuser));

        List<FriendsGroup> friend_group = fs.getAllByQ(query);
        List<FriendsGroup> friend_group_join = new ArrayList<>();

        if (friend_group != null) {

            for (FriendsGroup p : friend_group) {
                System.out.println("Mongo语句执行成功！返回朋友圈名字：" + p.getfGName());
            }

        }

        UsersInfo usersInfo = usersInfoService.getOneById(cuser);

//        List<String> UFGList=new ArrayList<>();

        if (usersInfo.getJoinFGList().size() != 0) {
            for (String jgf : usersInfo.getJoinFGList()) {
                System.out.println(jgf);
                FriendsGroup ufg = fs.getOneById(jgf);
                friend_group_join.add(ufg);
            }

        } else {

            System.out.println("我参加的朋友圈为空！");
        }


        hs.setAttribute("errorMsg", hs.getAttribute("Eimg"));
        hs.setAttribute("friend_group", friend_group);
        hs.setAttribute("friend_group_join", friend_group_join);
        return "/All_friend_group";

    }


    /**
     * 显示一个圈子信息
     */
    @RequestMapping(value = "/friendgroup/searchSingleFG.do")
    public String searchSingleFG(HttpSession hs, HttpServletRequest req, HttpServletResponse resp) {

        //**首先　前台传入获取　的　具体圈子的名字　　*/
        String fg_id = req.getParameter("single_fg_id");
        System.out.println("当前请求进入的朋友圈id" + fg_id);

        //String fg_name="山科老干部";
        String username = (String) hs.getAttribute("username");
        System.out.println("当前在线用户：" + username);
        System.out.println(fg_id);


        FriendsGroup single_fg = fs.getOneById(fg_id);

        System.out.println("Mongo语句执行成功！返回朋友圈名字：" + single_fg.getfGName());
//            System.out.println("Mongo语句执行成功！返回朋友圈描述："+single_fg.getfGDescribe());

        List<String> p_shuzu = single_fg.getfGmemberList();
        for (int i = 0; i < p_shuzu.size(); i++) {
            System.out.println("成员：" + p_shuzu.get(i));
        }

        hs.setAttribute("single_fg", single_fg);

        hs.setAttribute("errorMsg", hs.getAttribute("Eimg"));


        Query query = new Query();
        query.addCriteria(where("postSonSection").is(single_fg.get_id()));

        List<Post> single_Post = postService.getAllByQ(query);

        hs.setAttribute("single_Post", single_Post);

        if (single_fg != null) {
//            System.out.println("返回帖子的数量："+single_Post.size());
        } else {
            System.out.println("帖子数量为０");
        }


        return "/Single_friend_group";

//                return "forword:get/getPostByUserName?u_name="+username;
    }


    /**
     * 创建新的圈子
     */

    @RequestMapping(value = "/friendgroup/createFG.do")
    public String createFG(@RequestParam("fg_name") String fg_name, @RequestParam("fg_desc") String fg_desc, HttpSession hs) {


        System.out.println("fg_name" + fg_name);
        System.out.println("fg_desc" + fg_desc);


        String cuser = (String) hs.getAttribute("username");
        List<String> fGmemberList = new ArrayList<>();
        List<String> fGPostList = new ArrayList<>();
        List<String> fGBackPostList = new ArrayList<>();


        FriendsGroup new_FG = new FriendsGroup(fg_name, cuser, 0, fGmemberList, fg_desc, 0, fGPostList, 0, fGBackPostList);


        System.out.println();
        Query query = new Query();

        fs.addOneO(new_FG);


        System.out.println(fg_name);
        String fg_id = fs.getAllByQ(Query.query(where("fGName").is(fg_name))).get(0).get_id();
        Query query2 = new Query();
        query2.addCriteria(where("username").is(cuser));
        Update update = new Update();
        update.push("createFGList", fg_id).inc("createFGSum", 1);
        usersInfoService.updateOneByQU(query2, update);


        return "redirect:/friendgroup/searchAllFG.do";


    }


    @RequestMapping(value = "/friendgroup/updateFG.do", method = RequestMethod.POST)
    public String updateFG(HttpSession hs, @RequestParam("fg_name") String fg_name, @RequestParam("fg_desc") String fg_desc) {

        System.out.println(fg_name);
        System.out.println(fg_desc);

        FriendsGroup single_fg = (FriendsGroup) hs.getAttribute("single_fg");


        single_fg.setfGName(fg_name);
        single_fg.setfGDescribe(fg_desc);

        System.out.println("当前修改的id:" + single_fg.get_id());
        System.out.println("修改后的：" + single_fg.getfGName());


        Query query = new Query();
        query.addCriteria(where("_id").is(single_fg.get_id()));


        Update update = new Update();

        update.set("fGName", fg_name).set("fGDescribe", fg_desc);

        fs.updateOneByQU(query, update);

        // fs.updateOneById(friendsGroup,update);


        hs.setAttribute("single_fg", single_fg);

        return "/Single_friend_group";


    }


    /**
     * 删除一个圈子
     */
    @RequestMapping(value = "/friendgroup/deleteFG.do")
    public String deleteFG(HttpSession hs, HttpServletRequest req, HttpServletResponse resp) {

        //得到请求删除的朋友圈id
        String fg_id = req.getParameter("fg_id");

        //根据ＩＤ插出来　　朋友圈实体记录
        FriendsGroup friendsGroup = fs.getOneById(fg_id);

        //得到　　　朋友圈的成员
        List<String> user_name_list = friendsGroup.getfGmemberList();

        Query query = new Query();
        Update update = new Update();

        for (String name : user_name_list) {
            System.out.println("正在更新"+name);
            query.addCriteria(where("username").is(name));
            update.pull("joinFGList", fg_id).inc("joinFGSum", -1);
            usersInfoService.updateOneByQU(query, update);
        }

        Query query1 = new Query();
        Update update1 = new Update();

        String active_user_name=(String)hs.getAttribute("username");

        query.addCriteria(where("username").is(active_user_name));
        update1.pull("createFGList",fg_id).inc("createFGSum",-1);




        //String fg_name="山科老干部";
        if (fs.deleteOneById(fg_id)) {
            System.out.println("删除成功！");
        }
        // String username="duan";

        System.out.println(fg_id);
        System.out.println();


        return "redirect:/friendgroup/searchAllFG.do";
    }


    /**
     * 模糊查寻　　邀请　用户　进入我的圈子
     */
    @RequestMapping(value = "/friendgroup/yaoqing_FgMember.do")
    public String addFgMember(@RequestParam("key_word") String key_word, HttpSession hs) {


        System.out.println("获取到模糊查新的关键字：" + key_word);

//        Pattern pattern = Pattern.compile("^.*key_word.*$", Pattern.CASE_INSENSITIVE);


        Query query = new Query();
        if (key_word != null) {

            query.addCriteria(Criteria.where("username").regex(".*" + key_word + ".*"));

        }
        List<Users> fuzzy_user_list = usersService.getAllByQ(query);


        hs.setAttribute("fuzzy_user_list", fuzzy_user_list);


        return "/ManageFgMember";

    }

    /*********成功*/
    @RequestMapping(value = "/friendgroup/deleteFGMember.do")
    public String deleteFGMember(HttpSession hs, HttpServletRequest req, HttpServletResponse resp) {
        String fg_id = req.getParameter("fg_id");
        String fg_member_name = req.getParameter("fg_member_name");

        System.out.println("fg_id：" + fg_id);
        System.out.println("正在删除圈子成员　fg_member_name：" + fg_member_name);
        //删除一个群成员需要两个操作


        //从圈子　成员列表中删除　　　成员字段　修改成员总数
        Query query = new Query();
//        query.addCriteria(where("fg_name").is(fg_name).and("fgmemberList").is(fg_member_name));
        query.addCriteria(where("_id").is(fg_id));
        Update update = new Update();
        //  WriteResult rs = mop.updateFirst(query, new Update().pull("fGmemberList",mem).inc("fgSum",-1),                Contacts.class);
        update.pull("fGmemberList", fg_member_name).inc("fGMemberSum", -1);
        fs.updateOneByQU(query, update);


        UsersInfo usersInfo = usersInfoService.getOneById(fg_member_name);


        //从个人信息中删除　　　加入的圈子的id
        Query query1 = new Query();
        System.out.println(" //从个人信息中删除　　　加入的圈子的id" + usersInfo.getId());
//        query.addCriteria(where("fg_name").is(fg_name).and("fgmemberList").is(fg_member_name));
        query1.addCriteria(where("_id").is(usersInfo.getId()));
        Update update1 = new Update();
        //  WriteResult rs = mop.updateFirst(query, new Update().pull("fGmemberList",mem).inc("fgSum",-1),                Contacts.class);
        update1.pull("joinFGList", fg_id).inc("joinFGSum", -1);
        usersInfoService.updateOneByQU(query1, update1);


        return "forward:/friendgroup/searchSingleFG.do?single_fg_id=" + fg_id;
    }


    /***********成功*/
    @RequestMapping(value = "/friendgroup/addFGMember.do")
    public String addFGMember(HttpSession hs, HttpServletRequest req, HttpServletResponse resp) {
        String fg_id = req.getParameter("fg_id");
        String fg_member_name = req.getParameter("fg_member_name");


        fg_id = "5b1d3e3f6c1eaf92ad37ef63";
        fg_member_name = "GGasdfasdfasdfasdfasdfGGG";


        System.out.println("fg_id：" + fg_id);
        System.out.println("fg_member_name：" + fg_member_name);
        Query query = new Query();
//        query.addCriteria(where("fg_name").is(fg_name).and("fgmemberList").is(fg_member_name));


        query.addCriteria(where("_id").is(fg_id));
        Update update = new Update();
        //  WriteResult rs = mop.updateFirst(query, new Update().pull("fGmemberList",mem).inc("fgSum",-1),                Contacts.class);
        update.push("fGmemberList", fg_member_name).inc("fGMemberSum", +1);
        fs.updateOneByQU(query, update);


        FriendsGroup fff = ((FriendsGroup) hs.getAttribute("single_fg"));
        List<String> sss = fff.getfGmemberList();


        Iterator e = sss.iterator();

        if (e.toString() == fg_member_name) {
            e.remove();
        }


        hs.setAttribute("single_fg", fff);

        return "/Single_friend_group";
    }


}
