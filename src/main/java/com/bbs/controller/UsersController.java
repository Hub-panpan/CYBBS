package com.bbs.controller;

import com.bbs.bean.*;
import com.bbs.service.*;
import com.bbs.util.addDateMinut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Controller
//@RequestMapping("/users")
public class UsersController {
    @Autowired
    private UsersInfoService usersInfoService;
    @Autowired
    private SectionService sectionService;
    @Autowired
    private SonSectionService sonSectionService;
    @Autowired
    private PostService postService;

    @Autowired
    private UsersService usersService;
    @Autowired
    private SiteInfoService siteInfoService;
    @Autowired
    public Users u;
    @Autowired
    public FriendsGroupService friendsGroupService;
    /**用户登录　*/
    @RequestMapping(value = "/users/Login",method = RequestMethod.POST)
    public String userLogin(HttpSession session, String username, String passwd){

        System.out.println(username);
        System.out.println(passwd);


        if (username.equals("")||passwd.equals("")||username==null||passwd==null){

            session.setAttribute("errorInfo","输入的用户名或密码为空！");
            return "error";
        }
        Users user=usersService.getOneById(username);
        if (user==null){
            session.setAttribute("errorInfo","该用户名不存在！");
            return "error";
        }
        if (user.getUserstate().equals("冻结")){   //users.getStatus().equals("yes")
            session.setAttribute("errorInfo","对不起！该用户已被冻结！");
            return "error";
        }
        if (user.getUserstate().equals("封号")){
            session.setAttribute("errorInfo","对不起！该用户已被封号！");
            return "error";
        }
        if(!(user.getPasswd().equals(passwd))){
            session.setAttribute("errorInfo","密码错误，请重新是登录");
            return "error";
        }
        if((user.getPasswd().equals(passwd))){
            session.removeAttribute("errorInfo");
            session.setAttribute("username",username);
            session.setAttribute("user",user);

            //加载个人中心
            UsersInfo usersInfo=usersInfoService.getOneById(username);
            if (usersInfo!=null){
            //根据积分更新等级
            // 获得用户积分
                int  integralsum=usersInfo.getIntegralSum();
                int rank=1;
                if (integralsum>0&&integralsum<100){
                    rank=1;
                }
                if (integralsum>99&&integralsum<200){
                    rank=2;
                }
                if (integralsum>199&&integralsum<300){
                    rank=3;
                }
                if (integralsum>299&&integralsum<600){
                    rank=4;
                }

                usersInfo.setRank(rank);
                usersInfoService.updateOneById(usersInfo,new Update().set("rank",rank));
                session.setAttribute("userInfo",usersInfo);




                List<String> UFGList=new ArrayList<>();


                for( String jgf:usersInfo.getJoinFGList()){
                    System.out.println(jgf);
                    String ufg =friendsGroupService.getOneById(jgf).getfGName();
                    System.out.println("用户参加的朋友圈"+ufg);

                    UFGList.add(ufg);
                }
                session.setAttribute("UFGList",UFGList);



            }

            return "forward:/add/data";

        }
        session.setAttribute("errorInfo","未知错误，请重新登录吧");
        //发生未知错误
        return "error";

    }
    /**用户注册　*/
    @RequestMapping(value = "/user/register.do")
    public String userRegister(HttpSession hs,  HttpServletRequest request){


        String username = (String) request.getParameter("username");
        String password = (String) request.getParameter("password");
        String hdyzm = (String) request.getParameter("isTrue");
        System.out.println(hdyzm);

        Users user=usersService.getOneById(username);

        if (!hdyzm.equals("true")) {
            hs.setAttribute("errorInfo","滑动验证码未通过！");
            return "error";

        }else if (user==null){
            /** 新建用户*/
                user=new Users();
                user.setPasswd(password);
                user.setRegTime(new Date());
                user.setUsername(username);
                user.setUserstate("正常");
                user.setFreezetime(null);
                user.setNfreezetime(null);

                usersService.addOneO(user);
            /** 新建用户　详细信息*/
                UsersInfo usersInfo=new UsersInfo();
                usersInfo.setRole("普通用户");
                usersInfo.setUsername(username);
                //初始化积分为　　
                usersInfo.setIntegralSum(99);
               //初始化等级为１
                usersInfo.setRank(1);

                usersInfoService.addOneO(usersInfo);
               /** 新建信箱*/
                List<Mail> mail1 =new ArrayList<>();
                List<Mail> mail2 =new ArrayList<>();
                System.out.println("信箱"+username);
                SiteInformation siteInformation=new SiteInformation(username,mail1,mail2);
                siteInfoService.addOneO(siteInformation);
                hs.setAttribute("succeedInfo","注册成功！快开始你的水吧之旅吧！用户　信息初始化成功　信箱初始化成功");
                return "succeed";
        }else {

            hs.setAttribute("errorInfo","用户名已经存在！请重新注册！");
        }

        return "register";
    }
    /**个人中心*/
    @RequestMapping(value = "/user/personal",method = RequestMethod.GET)
    public String userPersonal(HttpSession session){

        Users user=(Users)session.getAttribute("user");
        UsersInfo usersInfo=usersInfoService.getOneById(user.getUsername());
        System.out.println("进入个人中心　:"+usersInfo.getUsername());

        //加载个人中心

        if (usersInfo!=null){
            //根据积分更新等级
            // 获得用户积分
            int  integralsum=usersInfo.getIntegralSum();
            int rank=1;
            if (integralsum>0&&integralsum<100){
                rank=1;
            }
            if (integralsum>99&&integralsum<200){
                rank=2;
            }
            if (integralsum>199&&integralsum<300){
                rank=3;
            }
            if (integralsum>299&&integralsum<400){
                rank=3;
            }


            usersInfo.setRank(rank);
            usersInfoService.updateOneById(usersInfo,new Update().set("rank",rank));
            session.setAttribute("userInfo",usersInfo);
            // session.setAttribute("regTime",user.getRegTime());



            List<String> UFGList=new ArrayList<>();




            for( String jgf:usersInfo.getJoinFGList()){
                System.out.println(jgf);
                String ufg =friendsGroupService.getOneById(jgf).getfGName();
                System.out.println("用户参加的朋友圈"+ufg);

                UFGList.add(ufg);
            }
            session.setAttribute("UFGList",UFGList);


            return "PersonalCenter";
        }
        return "login";
    }
    /**前台数据预加载*/
    @RequestMapping(value = "/add/data")
    public String index0(HttpSession session){
        List<Section> sectionList=sectionService.getAll();
        List<SonSection> sonSectionList=sonSectionService.getAll();
        session.setAttribute("sectionList",sectionList);
        session.setAttribute("sonSectionList",sonSectionList);
        //取出基于浏览量的5个热帖
        List<Post> hotPostList=postService.getAllByQ(new Query().addCriteria(where("postLabel").is(1).andOperator(where("postPageView").gte(5))).limit(10));

//        List<Post> hotPostList=postService.getAllByQ(new Query().addCriteria(where("postType").is(2)).with(new Sort.Order(Sort.Direction.DESC,"postPageView"))).limit(5));


        session.setAttribute("hotPostList",hotPostList);

        //加载推荐的朋友圈  模拟测试
        List<FriendsGroup> hotFGroupList=new ArrayList<>();
        for(int i=0;i<5;i++){
            FriendsGroup fGroup=new FriendsGroup();
            fGroup.setfGController("duan");
            fGroup.setfGName("这是测试朋友圈！");
            hotFGroupList.add(fGroup);
        }
        session.setAttribute("hotFGroupList",hotFGroupList);
        return "redirect:/Zong-index.jsp";
    }
    /**用户登出*/
    @RequestMapping(value = "/user/logoff",method = RequestMethod.GET)
    public String logOff(HttpSession hs){
        System.out.println("退出登录");
        hs.removeAttribute("username");
        hs.removeAttribute("user");
        hs.removeAttribute("");
        return "login";
    }

    //跳转进入后台
    @RequestMapping(value = "/users/admin",method = RequestMethod.GET)
    public String userAdmin(){
        System.out.println("进入跳转后台");
        return "forward:/WEB-INF/admin/adminLogin.jsp";
    }


    /***********-------------------------------------*/
    @RequestMapping(value = "/users/listUsers",method = RequestMethod.GET)
    public String listUsers(@RequestParam(value = "page",defaultValue = "1") String pag,
                            HttpSession hs){
        int page=1;     //当前第几页
        long rows;    //数据总数（可能比较长，就定义为了long）
        int size=5;    //每一页显示的记录条数
        int pageCount;//一共有多少页
        String pn=pag;//通过参数获取page（当前是第几页）

        //得到当前是第几页
        if(pn!=null && pn.length()>0)
        {
            try {
                page=Integer.parseInt(pn);      //进行类型转换（得到的是一个字符串）
            } catch (NumberFormatException e) {
                page=1;                         //如果又错，就返回第一页得到信息
                e.printStackTrace();
            }
        }
        Query query = new Query();
        rows = usersService.getSumByQ(query);
        query.limit(size).skip((page-1)*size);
        List<Users> ulist = usersService.getAllByQ(query);

        //计算pageCount（总页数）
        if(rows%size==0)
        {
            pageCount = (int)(rows/size);

        }else{
            pageCount = (int)(rows/size)+1;
        }

        //将数据发送给JSP页面，并实现转发
        hs.setAttribute("ulist",ulist);
        hs.setAttribute("rows",rows);
        hs.setAttribute("pageCount",pageCount);
        hs.setAttribute("page",page);
        hs.setAttribute("errorMsg",hs.getAttribute("Msg"));
        return "forward:/WEB-INF/admin/listUsers.jsp";
    }

    @RequestMapping(value = "/users/passValue",method = RequestMethod.GET)
    public void passValue(@RequestParam("username")String username,
                            HttpSession hs){
        hs.setAttribute("username",username);
    }
    @RequestMapping(value = "/users/operate",method = RequestMethod.GET)
    public String operateUsers(@RequestParam(value = "username",defaultValue = "") String uname,
                                @RequestParam("operation") String operation,
                               HttpSession hs){
        if (uname.equals(""))
            uname = hs.getAttribute("username").toString();
        Query query = new Query();
        query.addCriteria(where("username").is(uname));
        Update update = new Update();
        u = usersService.getOneById(uname);
        if ("fenghao".equals(operation)){
            update.set("userstate","已封号").set("freezetime",null).set("nfreezetime",null);
            if (usersService.updateOneByQU(query,update)){
                hs.setAttribute("Msg","");
                return "forward:/users/listUsers";
            }
            hs.setAttribute("Msg","封号失败！");
            return "forward:/users/listUsers";
        }
        if ("start".equals(operation)){
            update.set("userstate","正常").set("freezetime",null).set("nfreezetime",null);
            if (usersService.updateOneByQU(query,update)){
                hs.setAttribute("Msg","");
                return "forward:/users/listUsers";
            }
            hs.setAttribute("Msg","启用失败！");
            return "forward:/users/listUsers";
        }
        hs.setAttribute("Msg","操作失败");
        return "forward:/users/listUsers";
    }
    @RequestMapping(value = "/users/operateFreeze",method = RequestMethod.GET)
    public String operateFreeze(@RequestParam("duration") String duration,
                               HttpSession hs){
        String uname = hs.getAttribute("username").toString();
        Query query = new Query();
        query.addCriteria(where("username").is(uname));
        Update update = new Update();
        Date date = new Date();
        Date date1 = new Date();
        if (duration.equals("30m"))
            date1 = addDateMinut.addMinute(date,30);
        if (duration.equals("1h"))
            date1 = addDateMinut.addHour(date,1);
        if (duration.equals("1d"))
            date1 = addDateMinut.addDay(date,1);
        if (duration.equals("7d"))
            date1 = addDateMinut.addDay(date,7);
        update.set("userstate","已冻结").set("freezetime",date).set("nfreezetime",date1);
        if (usersService.updateOneByQU(query,update)){
            hs.setAttribute("Msg","");
            return "forward:/users/listUsers";
        }
        hs.setAttribute("Msg","冻结失败！");
        return "forward:/users/listUsers";
    }


}
