package com.bbs.controller;

import com.bbs.bean.Section;
import com.bbs.bean.UsersInfo;
import com.bbs.service.SectionService;
import com.bbs.service.UsersInfoService;
import com.bbs.util.compare;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/moderator")
public class ModeratorController {
    @Autowired
    private UsersInfoService uis;
    @Autowired
    private SectionService ss;

    @RequestMapping(value = "/listInfo",method = RequestMethod.GET)
    public String listInfo(@RequestParam(value = "page",defaultValue = "1") String pag,
                           HttpSession hs){
        int page=1;     //当前第几页
        long rows;    //数据总数（可能比较长，就定义为了long）
        int size=5;    //每一页显示的记录条数
        int pageCount;//一共有多少页
        long sectionSum; //一共多少个板块
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
        sectionSum = ss.sectionSum(query);
        rows = uis.getSumByQ(query);
        /**
         * 排序：ASC正序，DESC，倒序
         * query.with(new Sort(new Sort.Order(ASC,"username"))).
         */
        query.limit(size).skip((page-1)*size);
        List<UsersInfo> uilist= uis.getAllByQ(query);
        //计算pageCount（总页数）
        if(rows%size==0)
        {
            pageCount = (int)(rows/size);

        }else {
            pageCount = (int) (rows / size) + 1;
        }

        List<Section> seclist = ss.getAll();
        //将数据发送给JSP页面，并实现转发
        hs.setAttribute("uilist",uilist);
        hs.setAttribute("seclist",seclist);
        hs.setAttribute("sectionSum",sectionSum);
        hs.setAttribute("row",rows);
        hs.setAttribute("pageCount",pageCount);
        hs.setAttribute("page",page);
        hs.setAttribute("errorMsg",hs.getAttribute("Msg"));
        return "forward:/WEB-INF/section/listModerator.jsp";
    }

    @RequestMapping(value = "/getValue",method = RequestMethod.GET)
    public void passValue(@RequestParam("username")String username,
                          @RequestParam(value = "section",defaultValue = "") String section,
                          HttpSession hs){
        if (!"".equals(section))
            hs.setAttribute("section",section);
        hs.setAttribute("username",username);
    }

    @RequestMapping(value = "/tempMag",method = RequestMethod.GET)
    public String tempMag(@RequestParam(value = "username",defaultValue = "")String username,
                          @RequestParam("Temp") int Temp,
                          HttpSession hs){
        if ("".equals(username)){
            username = hs.getAttribute("username").toString();
        }
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        Update update = new Update();
        if (Temp==0){
            update.set("isTempSect",1);
            if (uis.updateOneByQU(query,update)){
                hs.setAttribute("Msg","");
                return "forward:/moderator/listInfo";
            }
            hs.setAttribute("Msg","操作失败!");
            return "forward:/moderator/listInfo";
        }
        if (Temp==1){
            update.set("isTempSect",0);
            if (uis.updateOneByQU(query,update)){
                hs.setAttribute("Msg","");
                return "forward:/moderator/listInfo";
            }
            hs.setAttribute("Msg","操作失败!");
            return "forward:/moderator/listInfo";
        }
        hs.setAttribute("Msg","出现未知错误！");
        return "forward:/moderator/listInfo";

    }

    @RequestMapping(value = "/doSection",method = RequestMethod.GET)
    public String doSection(HttpSession hs){
        String username = hs.getAttribute("username").toString();
        String section = hs.getAttribute("section").toString();
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        Update update = new Update();
        update.pull("sectionList",section).inc("sectionSum",-1);
        Query query1 = new Query();
        query1.addCriteria(where("sectName").is(section));
        Update update1 = new Update();
        update1.pull("moderatorList",username).inc("moderatorSum",-1);
        if (uis.updateOneByQU(query,update)&&ss.updateOneByQU(query1,update1)){
            hs.setAttribute("Msg","");
            return "forward:/moderator/listInfo";
        }
        hs.setAttribute("Msg","解除失败!");
        return "forward:/moderator/listInfo";
    }

    @RequestMapping(value = "/upModerator",method = RequestMethod.GET)
    public String upModerator(@RequestParam(value = "secName",required = false,defaultValue = " ") String[] secName,
                              HttpSession hs){
        String username = hs.getAttribute("username").toString();
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        Update update = new Update();
        Update update1 = new Update();
        update1.addToSet("moderatorList",username).inc("moderatorSum",1);
        if ("".equals(secName[0])) {
            hs.setAttribute("Msg", "至少要选择一个版块！");
            return "forward:/moderator/listInfo";
        }
        if (secName.length==1){
            update.set("role","版主").addToSet("sectionList",secName[0]).inc("sectionSum",secName.length);
            Query query1 = new Query();
            query1.addCriteria(where("sectName").is(secName[0]));
            if (!ss.updateOneByQU(query1,update1)) {
                hs.setAttribute("Msg", "操作失败!");
                return "forward:/moderator/listInfo";
            }
        }
        if (secName.length>1) {
            update.set("role", "版主").addToSet("sectionList").each(secName).inc("sectionSum", secName.length);
            for (String seName:secName){
                Query query2 = new Query();
                query2.addCriteria(where("sectName").is(seName));
                if (!ss.updateOneByQU(query2,update1)) {
                    hs.setAttribute("Msg", "操作失败!");
                    return "forward:/moderator/listInfo";
                }
            }
        }
            if (uis.updateOneByQU(query,update)){
            hs.setAttribute("Msg","");
            return "forward:/moderator/listInfo";
        }
        hs.setAttribute("Msg","操作失败!");
        return "forward:/moderator/listInfo";
    }
    @RequestMapping(value = "/downUsers",method = RequestMethod.GET)
    public String upModerator(HttpSession hs){
        String username = hs.getAttribute("username").toString();
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        List<String> seList = uis.getOneById(username).getSectionList();
        Object[] section = seList.toArray();
        Update update = new Update();
        Update update1 = new Update();
        update1.pull("moderatorList",username).inc("moderatorSum",-1);
        update.set("role","普通用户").pullAll("sectionList",section).set("sectionSum",0);
        if (uis.updateOneByQU(query,update)){
            /**
             * 循环删除该版块的版主
             */
            for (String se : seList){
                Query query1 = new Query();
                query1.addCriteria(where("sectName").is(se));
                if (!ss.updateOneByQU(query1,update1)) {
                    hs.setAttribute("Msg","操作失败!");
                    return "forward:/moderator/listInfo";
                }
            }
            hs.setAttribute("Msg","");
            return "forward:/moderator/listInfo";
        }
        hs.setAttribute("Msg","操作失败!");
        return "forward:/moderator/listInfo";
    }

    @RequestMapping(value = "/getList",method = RequestMethod.GET)
    public String getList(@RequestParam("username")String username,
                          HttpSession hs){
        UsersInfo ui = uis.getOneById(username);
        // 获取改用户管理的版块
        List<String> ls = ui.getSectionList();
        // 获取全部版块
        List<Section> lsc =  ss.getAll();
        List<String> lsr = new ArrayList();
        //获取全部版块名集合
        for(Section se:lsc ){
            lsr.add(se.getSectName());
        }
        List<String> list= compare.Mycompare(ls,lsr);
        hs.setAttribute("comlist",list);
        hs.setAttribute("username",username);
        return "forward:/WEB-INF/section/compareSection.jsp";
    }


    //当前是否存在　相同名字的子版块
    @RequestMapping(value = "/compareSection",method = RequestMethod.GET)
    public String compareSection(@RequestParam(value = "sectionName",required = false,defaultValue = " ")String[] sectionName,
                          HttpSession hs){
        String username = hs.getAttribute("username").toString();
        Query query = new Query();
        query.addCriteria(where("username").is(username));
        Update update = new Update();
        Update update1 = new Update();
        update1.addToSet("moderatorList",username).inc("moderatorSum",1);
        if ("".equals(sectionName[0])){
            hs.setAttribute("Msg", "至少要选择一个版块！");
            return "forward:/moderator/listInfo";
        }
        if (sectionName.length==1) {
            update.addToSet("sectionList", sectionName[0]).inc("sectionSum", sectionName.length);
            Query query1 = new Query();
            query1.addCriteria(where("sectName").is(sectionName[0]));
            if (!ss.updateOneByQU(query1,update1)) {
                hs.setAttribute("Msg", "操作失败!");
                return "forward:/moderator/listInfo";
            }
        }
        if (sectionName.length>1) {
            update.addToSet("sectionList").each(sectionName).inc("sectionSum", sectionName.length);
            for (String seName:sectionName){
                Query query2 = new Query();
                query2.addCriteria(where("sectName").is(seName));
                if (!ss.updateOneByQU(query2,update1)) {
                    hs.setAttribute("Msg", "操作失败!");
                    return "forward:/moderator/listInfo";
                }
            }
        }
        if (uis.updateOneByQU(query,update)){
            hs.setAttribute("Msg","");
            return "forward:/moderator/listInfo";
        }
        hs.setAttribute("Msg","操作失败!");
        return "forward:/moderator/listInfo";
    }



}
