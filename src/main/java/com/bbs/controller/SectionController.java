package com.bbs.controller;

import com.bbs.bean.Post;
import com.bbs.bean.Section;
import com.bbs.bean.SonSection;
import com.bbs.bean.UsersInfo;
import com.bbs.service.SectionService;
import com.bbs.service.SonSectionService;
import com.bbs.service.UsersInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;

@Controller
@RequestMapping("/section")
public class SectionController {
    @Autowired
    private SonSectionService ssc;
    @Autowired
    private SectionService sectionService;
    @Autowired
    private SonSectionService sonSectionService;
    @Autowired
    private UsersInfoService usersInfoService;

    private List<String> nullList = new ArrayList();


    @RequestMapping(value = "/listSonSection")
    public String listInfo(@RequestParam(value = "page", defaultValue = "1") String pag,
                           @RequestParam("sectionName") String sectionName,
                           HttpSession hs) {
        int page = 1;     //当前第几页
        long rows;      //数据总数
        int size = 5;     //每一页显示的记录条数
        int pageCount;  //一共有多少页
        String pagenumber = pag;  //通过参数获取page（当前是第几页）


        //得到当前是第几页
        if (pagenumber != null && pagenumber.length() > 0) {
            try {
                page = Integer.parseInt(pagenumber);      //进行类型转换（得到的是一个字符串）
            } catch (NumberFormatException e) {
                page = 1;                         //如果又错，就返回第一页得到信息
                e.printStackTrace();
            }
        }
        Query query = new Query();
        /**
         * 排序：ASC正序，DESC，倒序
         * query.with(new Sort(new Sort.Order(ASC,"username"))).
         */
        query.addCriteria(where("fSectName").is(sectionName));
        rows = ssc.getSumByQ(query);
        query.limit(size).skip((page - 1) * size);
        List<SonSection> sonList = ssc.getAllByQ(query);
        //计算pageCount（总页数）
        if (rows % size == 0) {
            pageCount = (int) (rows / size);

        } else {
            pageCount = (int) (rows / size) + 1;
        }

        //将数据发送给JSP页面，并实现转发
        hs.setAttribute("sonList", sonList);
        hs.setAttribute("row", rows);
        hs.setAttribute("sectionName", sectionName);
        hs.setAttribute("pageCount", pageCount);
        hs.setAttribute("page", page);
        hs.setAttribute("errorMsg", hs.getAttribute("Msg"));
        return "forward:/WEB-INF/section/listSection.jsp";
    }

    @RequestMapping(value = "/deleteSection", method = RequestMethod.POST)
    public String deleteSection(@RequestParam("sectionName") String sectionName,
                                HttpSession hs) {
        Query query = new Query();
        query.addCriteria(where("sectName").is(sectionName));
        Section section = sectionService.getOneByQ(query);
        Query query1 = new Query();
        query1.addCriteria(where("fSectName").is(sectionName));
        if (!section.getSonSectionList().isEmpty()) {
            if (sectionService.deleteOneByQ(query) && ssc.deleteAllByQ(query1)) {
                hs.setAttribute("Msg", "");
                return "forward:/admin/index";
            }
        }
        if (sectionService.deleteOneByQ(query)) {
            hs.setAttribute("Msg", "");
            return "forward:/admin/index";

        }
        hs.setAttribute("Msg", "删除失败!");
        return "forward:/section/listSonSection?sectionName=" + sectionName;
    }

    @RequestMapping(value = "addSection", method = RequestMethod.POST)
    public String addSection(@RequestParam(value = "sectionName", defaultValue = "") String sectionName,
                             @RequestParam(value = "secDescribe", defaultValue = "") String secDescribe,
                             HttpSession hs) {
        if ("".equals(sectionName)) {
            hs.setAttribute("Msg", "请输入版块名");
            return "forward:/admin/index";
        }
        if (sectionService.ifExists(sectionName)) {
            hs.setAttribute("Msg", "版块已存在");
            return "forward:/admin/index";
        }
        Section sec = new Section(nullList, nullList, 0, 0, sectionName, secDescribe, 0, nullList, 0, nullList);
        sectionService.addOneO(sec);
        hs.setAttribute("Msg", "");
        return "forward:/admin/index";
    }

    @RequestMapping(value = "/addSonSection", method = RequestMethod.POST)
    public String addSonSection(@RequestParam(value = "sonSectionName", defaultValue = "") String sonSectionName,
                                @RequestParam(value = "sectionName", defaultValue = "") String sectionName,
                                @RequestParam(value = "sonSecDescribe", defaultValue = "") String sonSecDescribe,
                                @RequestParam("pageName") String pageName,
                                HttpSession hs) {
        System.out.println(pageName);
        if ("".equals(sonSectionName)) {
            hs.setAttribute("Msg", "请输入子版块名");
            return "forward:" + pageName;
        }
        if (ssc.ifExists(sonSectionName)) {
            hs.setAttribute("Msg", "子版块已存在");
            return "forward:" + pageName;
        }
        Query query = new Query();
        query.addCriteria(where("sectName").is(sectionName));
        Update update = new Update();
        update.addToSet("sonSectionList", sonSectionName).inc("sonSectionSum", 1);
        if (!sectionService.updateOneByQU(query, update)) {
            hs.setAttribute("Msg", "添加子版块失败");
            return "forward:" + pageName;
        }
        SonSection sonSection = new SonSection(sectionName, sonSectionName, sonSecDescribe, 0, 0);
        ssc.addOneO(sonSection);
        hs.setAttribute("Msg", "");
        return "forward:" + pageName;
    }

    @RequestMapping(value = "/passValue", method = RequestMethod.GET)
    public void passValue(@RequestParam("sectionName") String sectionName,
                          @RequestParam("sonSectionName") String sonSectionName,
                          HttpSession hs) {
        hs.setAttribute("sectionName", sectionName);
        hs.setAttribute("sonSectionName", sonSectionName);
    }

    @RequestMapping(value = "deleteSonSection", method = RequestMethod.GET)
    public String deleteSonSection(HttpSession hs) {
        String sectionName = hs.getAttribute("sectionName").toString();
        String sonSectionName = hs.getAttribute("sonSectionName").toString();
        Query query = new Query();
        query.addCriteria(where("fSectName").is(sectionName).and("sonSectName").is(sonSectionName));
        Query query1 = new Query();
        query1.addCriteria(where("sectName").is(sectionName));
        Update update = new Update();
        update.pull("sonSectionList", sonSectionName).inc("sonSectionSum", -1);
        if (ssc.deleteAllByQ(query) && sectionService.updateOneByQU(query1, update)) {
            hs.setAttribute("Msg", "");
            return "forward:/section/listSonSection?sectionName=" + sectionName;
        }
        hs.setAttribute("Msg", "删除失败！");
        return "forward:/section/listSonSection?sectionName=" + sectionName;
    }

    @RequestMapping(value = "toChange", method = RequestMethod.GET)
    public String toChange(@RequestParam("sectionName") String sectionName,
                           @RequestParam("sonSectionName") String sonSectionName,
                           @RequestParam("sonDescribe") String sonDescribe,
                           HttpSession hs) {
        hs.setAttribute("sectionName", sectionName);
        hs.setAttribute("sonSectionName", sonSectionName);
        hs.setAttribute("sonDescribe", sonDescribe);
        return "/section/changeSonSection";
    }

    @RequestMapping(value = "Change", method = RequestMethod.POST)
    public String Change(@RequestParam("newSonSectionName") String newSonSectionName,
                         @RequestParam("newSonSecDescribe") String newSonSecDescribe,
                         HttpSession hs) {
        String sectionName = hs.getAttribute("sectionName").toString();
        String oldSonSecName = hs.getAttribute("oldSonSecName").toString();
        Query query = new Query();
        query.addCriteria(where("fSectName").is(sectionName).and("sonSectName").is(oldSonSecName));
        Update update = new Update();
        update.set("sonSectName", newSonSectionName).set("sonSectDescribe", newSonSecDescribe);
        if (ssc.updateOneByQU(query, update)) {
            hs.setAttribute("Msg", "");
            return "forward:/section/listSonSection?sectionName=" + sectionName;
        }
        hs.setAttribute("Msg", "修改失败！");
        return "forward:/section/listSonSection?sectionName=" + sectionName;
    }

    //    ----------------------------------------------------------------------
//获取所有的版块信息，并加载对应的版主、帖子数、内容描述
    @RequestMapping(value = "/add/AllSection", method = RequestMethod.POST)
    public String addAllSection(HttpSession session) {
        List<Section> sectionList = sectionService.getAll();
        session.setAttribute("sectionData", sectionList);
        return "redirect:/index.jsp";
    }

    //获取版块中的子版块的贴子
    @RequestMapping(value = "/get/OneSection", method = RequestMethod.POST)
    public String getOneSection(HttpSession session, String cwdSection) {
        session.setAttribute("cwdSection", cwdSection);
        //获取版块帖子的信息
        List<Post> postList = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            Post post = new Post();
            post.setBackPostSum(4);
            post.setPostContent("这是这个版块的第" + (i + 1) + "个帖子！");
            post.setPostSonSection("子版块11");
            post.setPostTitle("一个test帖子");
            post.setPostTime(new Date());
            post.setPostPageView(10);
            post.setPostUname("duan");
            postList.add(post);
        }
        session.setAttribute("postList", postList);
        return "redirect:/postList.jsp";
    }

    /**
     * 获取用户管理版块的信息         ********成功
     */
    @RequestMapping(value = "/get/userSection")
    public String getOneSection(HttpSession session) {
        //获取用户信息
        String username = (String) session.getAttribute("username");
        UsersInfo usersInfo = usersInfoService.getOneById(username);
        List<Section> USectionList = new ArrayList<>();
        List<SonSection> UsonSectionList = new ArrayList<>();
        List<SonSection> sonSectionList0 = new ArrayList<>();

        //判断用户是否可以进行管理版块
        if (usersInfo.getRole().equals("普通用户")) {
            session.setAttribute("errorInfo", "非版主不能管理板块，您暂时没有权限管理板块");
            return "error";
        }
        //判断用户是否有可以进行管理的版块  可以管理的板块的数量为３
        if (usersInfo.getSectionSum() == 0) {
            session.setAttribute("USectionList", null);
            return "MangeMySection";
        }
        //加载版块数据
        for (String usetc : usersInfo.getSectionList()) {
            Section section0 = sectionService.getAllByQ(new Query().addCriteria(where("sectName").is(usetc))).get(0);
//            System.out.println(usetc+"==="+section0.getSectName());
            sonSectionList0 = sonSectionService.getAllByQ(new Query().addCriteria(where("fSectName").is(usetc)));
//          //加载子版块信息
            for (int i = 0; i < sonSectionList0.size(); i++) {
                UsonSectionList.add(sonSectionList0.get(i));
            }

            USectionList.add(section0);
        }
        //加载子版块数据
        System.out.println("----------zhixing daoci");

//        System.out.println(USectionList.size()+"======");
        session.setAttribute("UsonSectionList", UsonSectionList);
        session.setAttribute("USectionList", USectionList);

        return "section/MangeMySection";


    }
}
