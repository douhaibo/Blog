package com.blog.controller;

import com.blog.common.Const;
import com.blog.domain.Admin;
import com.blog.domain.AdminLoginLog;
import com.blog.service.impl.AdminLoginLogServiceImpl;
import com.blog.service.impl.ArticleServiceImpl;
import com.blog.service.impl.CommentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 管理主页
 * @author DouHaibo
 * @date 2019年6月7日20:35:49
 */
@Repository
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    public AdminLoginLogServiceImpl adminLoginLogService;
    @Autowired
    public ArticleServiceImpl articleService;
    @Autowired
    public CommentServiceImpl commentService;

    /**
     * 后台管理主页
     * @param request 判断登录
     * @return 主页
     */
    @RequestMapping("/main")
    public ModelAndView toMain(HttpServletRequest request){
        if (request.getSession().getAttribute(Const.CURRENT_USER)!=null){
            return new ModelAndView("admin/main");
        }
        else {
            return new ModelAndView("admin/login");
        }
    }

    /**
     * 系统相关信息
     * @param request 判断登录
     * @return 信息页面
     */
    @RequestMapping("/systemInfo")
    public ModelAndView sysInfo(HttpServletRequest request){
        if (request.getSession().getAttribute(Const.CURRENT_USER)!=null){
            ModelAndView modelAndView=new ModelAndView("admin/views/console");
            //获取客户端IP，如：127.0.0.1
            String clientIp=request.getRemoteAddr();
            String hostIp=request.getLocalAddr();
            int hostPort=request.getLocalPort();
            Date date = new Date();
            //设置日期格式
            SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            String dates = df.format(date);
            Admin admin=(Admin) request.getSession().getAttribute(Const.CURRENT_USER);
            System.out.println(admin.toString());
            AdminLoginLog lastLoginLog=null;
            try {
                if (adminLoginLogService.selectRencent(admin.getId())!=null && adminLoginLogService.selectRencent(admin.getId()).size()==2){
                    List<AdminLoginLog> adminLoginLogs=adminLoginLogService.selectRencent(admin.getId());
                    lastLoginLog=adminLoginLogs.get(1);
                }

            }catch (Exception e){
                e.printStackTrace();
            }finally {
                int articleCount = articleService.selectCount();
                int commentCount = commentService.countAllNum();
                int loginNum = adminLoginLogService.selectCountByAdminId(admin.getId());
                modelAndView.addObject("clientIp", clientIp);
                modelAndView.addObject("hostIp", hostIp);
                modelAndView.addObject("hostPort", hostPort);
                modelAndView.addObject("date", dates);
                modelAndView.addObject("admin",admin);
                if (lastLoginLog != null) {
                    modelAndView.addObject("loginLog", lastLoginLog);
                }
                modelAndView.addObject("articleCount", articleCount);
                modelAndView.addObject("commentCount", commentCount);
                modelAndView.addObject("loginNum", loginNum);
                return modelAndView;
            }
        }
        else {
            return new ModelAndView("admin/login");
        }

    }

}
