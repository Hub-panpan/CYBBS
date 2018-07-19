package com.bbs.controller;

import com.bbs.bean.BackPost;
import com.bbs.service.BackPostService;
import com.bbs.service.PostService;
import com.bbs.service.SonSectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Date;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Controller()
@RequestMapping("/back")
public class BackPostController {
    @Autowired
    private BackPostService backPostService;
    @Autowired
    private PostService postService;
    @Autowired
    private SonSectionService sonSectionService;



    @RequestMapping(value = "backPost.do",method = RequestMethod.POST)
    public String backPost(HttpSession session,@RequestParam("backPostContent") String backPostContent,
                           @RequestParam("postID") String postId) throws Exception
    {
        session.removeAttribute("backPosts");//清空评论信息
        //回帖的用户名从超链接中获取
        String bPostUname=(String) session.getAttribute("username");
        //如果输入内容为空，则评论失败！
        if (backPostContent.equals("")) { return "forward:/PersonalCenter.jsp"; }
        //开始封装回帖对象BackPost
        Date bPostTime=new Date();//获取系统时间
        BackPost backPost=new BackPost();
        backPost.setPostId(postId);
        backPost.setbPostUname(bPostUname);
        backPost.setbPostContent(backPostContent);
        backPost.setbPostTime(bPostTime);
        backPostService.addOneO(backPost);
        Query query=new Query();
        query.addCriteria(where("_id").is(postId));
        //按照时间进行逆序查询输出，重新查找，更新session
        query.with(new Sort(new Sort.Order(Sort.Direction.DESC,"bPostTime")));
        session.setAttribute("backPosts",backPostService.getAllByQ(query));
       // Thread.sleep(3000);
        //更新评论次数
        boolean isSue1=postService.updateOneById(postId,new Update().inc("backPostSum",1));

       // boolean isSue2=sonSectionService.updateOneById(query.addCriteria(where("").is()),new Update().inc(" sonSectBPostSum",1));

        if (isSue1){
            //重新加载数据
            String returnStr="forward:/get/Post?cwdPostId="+postId;
            System.out.println(returnStr);
            return returnStr;
        }
        //评论完成，更新session数据
        return null;
    }

    @RequestMapping(value = "/delete/backPost")
    public String deletebackPost(@RequestParam(value = "bapo_id") String bapoid,HttpSession session){

        System.out.println("删除评论："+bapoid);

if ( backPostService.deleteOneById(bapoid)){

    session.setAttribute("succeedInfo","删除评论成功");
    return "succeed";
}else {

    session.setAttribute("errorInfo","删除评论成功");
    return "error";
}




    }


}
