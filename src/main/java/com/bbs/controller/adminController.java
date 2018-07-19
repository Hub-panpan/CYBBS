package com.bbs.controller;

import com.bbs.bean.Root;
import com.bbs.bean.Section;
import com.bbs.service.RootService;
import com.bbs.service.SectionService;
import com.bbs.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class adminController {
    @Autowired
    private RootService rootService;
    @Autowired
    private SectionService sectionService;
    @Autowired
    public Root root;

    @RequestMapping(value = "/admin/adminLogin",method = RequestMethod.POST)
    public String adminLogin(@RequestParam("username")String username,
                             @RequestParam("password")String password,
                             HttpSession hs){
        root = rootService.getAllRoot();
        if (root.getRootname().equals(username)){
            if (root.getPasswd().equals(password)){
                hs.setAttribute("root",root);
                System.out.println("验证成功，开始跳转到后台首页");
                return "forward:/admin/index";
            }
            hs.setAttribute("errorMsg","密码错误！");
            return "/admin/adminLogin";
        }
        hs.setAttribute("errorMsg","用户名错误！");
        System.out.println("验证失败，开始跳转到后台登录页");
        return "/admin/adminLogin";
    }

    @RequestMapping(value ="/admin/index",method = RequestMethod.POST)
    public String adminIndex(HttpSession hs){
        List<Section> seclist = sectionService.getAll();
        hs.setAttribute("seclist",seclist);
        return "forward:/WEB-INF/admin/adminManager.jsp";
    }

    @RequestMapping(value ="/admin/logoff")
    public String adminoff(HttpSession hs){
        System.out.println("退出登录");
        hs.removeAttribute("root");

        return "WEB-INF/admin/adminLogin";
    }


}
