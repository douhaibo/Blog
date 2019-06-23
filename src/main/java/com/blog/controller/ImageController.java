package com.blog.controller;

import com.blog.common.Const;
import com.blog.service.FileService;
import com.blog.util.JsonResult;
import com.blog.util.PropertiesUtil;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 图片上传
 * @author DouHaibo
 * @date 2019/6/8 19:39
 **/

@RequestMapping("/admin/")
@Controller
public class ImageController {

    @Autowired
    private FileService fileService;

    /**
     * markdown中图片上传
     * @param session 判断是否登录
     * @param file 图片
     * @param request 请求临时文件夹
     * @return json数据
     */
    @RequestMapping("upload")
    @ResponseBody
    public Object upload(HttpSession session,@RequestParam(value = "editormd-image-file") MultipartFile file, HttpServletRequest request){

        Map fileMap = Maps.newHashMap();
        if (session.getAttribute(Const.CURRENT_USER)!=null) {

            String path = request.getSession().getServletContext().getRealPath("upload");
            String targetFileName = fileService.upload(file, path);
            String url = PropertiesUtil.getProperty("ftp.server.http.prefix") + targetFileName;

            fileMap.put("success", 1);
            fileMap.put("message", "上传成功");
            fileMap.put("url", url);
        }
        else {
            fileMap.put("success",0);
            fileMap.put("message","未登录，无权限");
        }
        return fileMap;
    }

    /**
     * 上传博客封面
     * @param session 判断是否登录
     * @param file 图片
     * @param request 请求临时文件夹
     * @return json数据
     */
    @RequestMapping("uploadFM")
    @ResponseBody
    public Object uploadFM(HttpSession session,@RequestParam(value = "file") MultipartFile file, HttpServletRequest request){

        Map fileMap = Maps.newHashMap();
        if (session.getAttribute(Const.CURRENT_USER)!=null) {

            String path = request.getSession().getServletContext().getRealPath("upload");
            String targetFileName = fileService.upload(file, path);
            String url = PropertiesUtil.getProperty("ftp.server.http.prefix") + targetFileName;

            Map data = Maps.newHashMap();
            data.put("src",url);
            fileMap.put("code", 0);
            fileMap.put("msg", "上传成功");
            fileMap.put("data", data);
        }
        else {
            fileMap.put("code",1);
            fileMap.put("msg","未登录，无权限");
        }
        return fileMap;
    }
}

