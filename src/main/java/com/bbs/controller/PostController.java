package com.bbs.controller;

import com.bbs.bean.BackPost;
import com.bbs.bean.Post;
import com.bbs.bean.Users;
import com.bbs.bean.UsersInfo;
import com.bbs.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

/**
 * PostController
 *
 */
@Controller
public class PostController {

    @Autowired
    private PostService postService;
    @Autowired
    private BackPostService backPostService;
    @Autowired
    private SonSectionService sonSectionService;

    @Autowired
    private FriendsGroupService friendsGroupService;
    @Autowired
    private  UsersInfoService usersInfoService;
    /**
     * 添加帖子
     *
     */
    @RequestMapping(value = "/add/Post",method = RequestMethod.GET)
    public String addPost(@RequestParam("postTitle") String postTitle,
                          @RequestParam("postSonSection") String postSonSection,
                          @RequestParam("postType") int postType,
                          @RequestParam("postIntegral") int postIntegral,
                          @RequestParam("postLabel") int postLabel,
                          @RequestParam("postContent") String postContent,
                          HttpSession session) {
        //Request uname from session by HttpSession
        String uname=(String) session.getAttribute("username");
        int postPageView=0;//浏览量初始化为0
        int backPostSum=0;//回帖次数初始化为0
        Date date=new Date();//初始化发帖时间
        //开始封装post对象
        Post post = new Post(postTitle,uname,postPageView,date,postSonSection,postType,postContent,backPostSum,postIntegral,postLabel);
        //使用段狗子的代码
        postService.addOneO(post);

        Query query=new Query();
        Update update =new Update();
        System.out.println("请求此："+postSonSection+"发帖子");
        query.addCriteria(where("_id").is(postSonSection));

        update.inc("sonSectPostSum",1);




        return "redirect:/post.jsp";
    }



//    文章列表
    @RequestMapping(value = "listPostNmae.do",method = RequestMethod.GET)
    public String listPostName(HttpSession session)
    {
        //使用段狗子的代码
        List<Post> posts=postService.getAll();
        session.setAttribute("posts",posts);//不确定有没有用，待测试
        return "redirect:/listPostName.jsp";
    }
    /**
     * 查看帖子
     */
    @RequestMapping(value = "/get/Post")
    public String viewPost(@RequestParam("cwdPostId") String postId,@RequestParam(value = "post_jifen" ,required = false,defaultValue = "0") int post_jifen,HttpSession session) throws InterruptedException {
        session.removeAttribute("post");
        session.removeAttribute("backPosts");
        System.out.println(postId);
        System.out.println(post_jifen);
        Post post=postService.getOneById(postId);
        session.setAttribute("post",post);
        //查询当前的帖子所属的父版块名或专题名或朋友圈名-----1板块或2专题或3朋友圈
        int postLabel=post.getPostLabel();
        String fuId=post.getPostSonSection();
        String cwdSectName="";
        if (postLabel==1){
            cwdSectName=sonSectionService.getOneById(fuId).getSonSectName();
        }else
        {
            cwdSectName=friendsGroupService.getOneById(fuId).getfGName();
        }
        session.setAttribute("cwdSectName",cwdSectName); //将当前的父级放入session



        Query query=new Query();
        query.addCriteria(where("postId").is(postId));
        //按照时间进行逆序查询
        query.with(new Sort(new Sort.Order(Sort.Direction.DESC,"bPostTime")));
        //条件查找
        List<BackPost> backPost=backPostService.getAllByQ(query);
        session.setAttribute("backPosts",backPost);
        //查看帖子时增加浏览量
        Update update=new Update();
        update.inc("postPageView",1);


        postService.updateOneById(postId,update);

        sonSectionService.updateOneByQU(query,update);
        UsersInfo u=(UsersInfo) session.getAttribute("userInfo");

        if (u.getIntegralSum()>0){

            usersInfoService.updateOneByQU(new Query(where("username").is(u.getUsername())),new Update().inc("integralSum",-post_jifen));

        }else {

            session.setAttribute("errorInfo","您的积分不足!");
        }


        return "redirect:/postContent.jsp";
    }


    @RequestMapping(value = "/get/Post1")
    public String viewPost1(@RequestParam("cwdPostId") String postId,@RequestParam(value = "post_jifen" ,required = false,defaultValue = "0") int post_jifen,HttpSession session) throws InterruptedException {
        session.removeAttribute("post");
        session.removeAttribute("backPosts");
        System.out.println(postId);
        System.out.println(post_jifen);
        Post post=postService.getOneById(postId);
        session.setAttribute("post",post);
        //查询当前的帖子所属的父版块名或专题名或朋友圈名-----1板块或2专题或3朋友圈
        int postLabel=post.getPostLabel();
        String fuId=post.getPostSonSection();
        String cwdSectName="";
        if (postLabel==1){
            cwdSectName=sonSectionService.getOneById(fuId).getSonSectName();
        }else
        {
            cwdSectName=friendsGroupService.getOneById(fuId).getfGName();
        }
        session.setAttribute("cwdSectName",cwdSectName); //将当前的父级放入session



        Query query=new Query();
        query.addCriteria(where("postId").is(postId));
        //按照时间进行逆序查询
        query.with(new Sort(new Sort.Order(Sort.Direction.DESC,"bPostTime")));
        //条件查找
        List<BackPost> backPost=backPostService.getAllByQ(query);
        session.setAttribute("backPosts",backPost);
        //查看帖子时增加浏览量
        Update update=new Update();
        update.inc("postPageView",1);


        postService.updateOneById(postId,update);

        sonSectionService.updateOneByQU(query,update);
        UsersInfo u=(UsersInfo) session.getAttribute("userInfo");

        if (u.getIntegralSum()>0){

            usersInfoService.updateOneByQU(new Query(where("username").is(u.getUsername())),new Update().inc("integralSum",-post_jifen));

        }else {

            session.setAttribute("errorInfo","您的积分不足!");
        }


        return "redirect:/postContent1.jsp";
    }


    @RequestMapping(value = "/post/deletePost.do")
    public String deletePost(String po_id,HttpSession session){


        System.out.println("请求删除的帖子id"+po_id);

        Query query=new Query();

        boolean isSure1=  backPostService.deleteAllByQ(query.addCriteria(where("postId").is(po_id)));
        boolean isSure2 =postService.deleteOneById(po_id);


        if (isSure1 && isSure2){

            session.setAttribute("succeedInfo","删除成功");
            return "succeed";

        }
        session.setAttribute("error","删除失败");
        return "error";


    }



} //这个右括号匹配的是类括号




