package com.blog.controller;

import com.blog.common.Const;
import com.blog.domain.AdminLoginLog;
import com.blog.service.impl.AdminLoginLogServiceImpl;
import com.blog.service.impl.AdminServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;

/**
 * 管理员登录
 * @author DouHaibo
 * @date 2019年6月7日19:27:17
 */
@Controller
public class LoginController {
    @Autowired
    AdminServiceImpl adminService;
    @Autowired
    AdminLoginLogServiceImpl adminLoginLogService;

    /**
     * 跳转到登录页
     * @return 登录页面
     */
    @RequestMapping(value = {"/admin/index","/admin","/admin/login"})
    public String toIndex() {

        return "admin/login";
    }

    /**
     * 登录请求验证
     * @param request 获取页面传的值
     * @param httpServletResponse cookie
     * @return json格式数据 0:用户不存在  1:密码错误 2:登陆成功
     */
    @RequestMapping(value = "/api/loginCheck", method = RequestMethod.POST)
    public @ResponseBody Object loginCheck(HttpServletRequest request,HttpServletResponse httpServletResponse) {
        int id=Integer.parseInt(request.getParameter("id"));
        String password = request.getParameter("password");
        HashMap<String, String> res = new HashMap<String, String>();
        if(adminService.getById(id)==null){
            res.put("stateCode", "0");
        }
        else if(!adminService.getById(id).getPassword().equals(password)){
            res.put("stateCode", "1");
        }else {
            String ip=request.getRemoteAddr();
            AdminLoginLog adminLoginLog=new AdminLoginLog();
            adminLoginLog.setAdminId(id);
            adminLoginLog.setDate(new Date());
            adminLoginLog.setIp(ip);
            int log=adminLoginLogService.insert(adminLoginLog);
            Cookie cookie = new Cookie("userId",""+id);
            cookie.setMaxAge(3600*24);
            httpServletResponse.addCookie(cookie);
            request.getSession().setAttribute(Const.CURRENT_USER,adminService.getById(id));
            res.put("stateCode", "2");
        }
        return res;
    }

    /**
     * 退出
     * @param request 移除session
     * @return 返回到登录页
     */
    @RequestMapping(value = {"/admin/logout"})
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute(Const.CURRENT_USER);
        return "redirect:/admin";

    }

}
