package com.blog.controller;

import com.blog.common.Const;
import com.blog.domain.Article;
import com.blog.domain.Comment;
import com.blog.util.JsonResult;
import com.blog.service.impl.ArticleServiceImpl;
import com.blog.service.impl.CommentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * 文章的相关控制类
 * @author DouHaibo
 * @date 2019年6月5日17:04:26
 */
@Controller
public class ArticleController {


    @Autowired
    ArticleServiceImpl articleService;
    @Autowired
    public CommentServiceImpl commentService;

    /**
     * 博客详情
     * @param request 获取传过来的id
     * @return detail.jsp
     */
    @RequestMapping("/article")
    public ModelAndView detail(HttpServletRequest request){

        int id=Integer.parseInt(request.getParameter("id"));
        List<Comment> comments=commentService.allComments(id,0,10);

        Article article=articleService.selectById(id);
        Article lastArticle=articleService.selectLastArticle(id);
        Article nextArticle=articleService.selectNextArticle(id);

        Integer clickNum=article.getClick();
        article.setClick(clickNum+1);
        articleService.updateArticle(article);

        ModelAndView modelAndView=new ModelAndView("detail");
        modelAndView.addObject("article",article);
        modelAndView.addObject("comments",comments);
        modelAndView.addObject("lastArticle",lastArticle);
        modelAndView.addObject("nextArticle",nextArticle);
        return modelAndView;
    }

    @RequestMapping("/admin/article/detail")
    public ModelAndView adminArticleDetail(HttpServletRequest request){
        int id=Integer.parseInt(request.getParameter("id"));
        Article article=articleService.selectById(id);

        ModelAndView modelAndView=new ModelAndView("/admin/article_detail");
        modelAndView.addObject("article",article);

        return modelAndView;
    }
    @RequestMapping("/admin/article/comment")
    public ModelAndView adminArticleComment(HttpServletRequest request){
        int id=Integer.parseInt(request.getParameter("id"));
        List<Comment> comments=commentService.allComments(id,0,10);
        ModelAndView modelAndView=new ModelAndView("/admin/comment_list");
        modelAndView.addObject("comments",comments);
        return modelAndView;
    }

    /**
     * 返回列表页面
     * @param request 判断登录
     * @return 页面
     */
    @RequestMapping("/admin/article/list")
    public ModelAndView articleList(HttpServletRequest request){
        if (request.getSession().getAttribute(Const.CURRENT_USER)!=null){
            return new ModelAndView("admin/views/article-list");
        }else {
            return new ModelAndView("admin/login");
        }
    }

    /**
     * 获取博客列表
     * @param request 判断是否登录
     * @return json数据
     */
    @RequestMapping("/admin/article/getList")
    @ResponseBody
    public JsonResult getArticleList(HttpServletRequest request)
    {
        if (request.getSession().getAttribute(Const.CURRENT_USER)!=null){
            List<Article> articles=articleService.selectArticleList();
            int totalCount = articleService.selectCount();
            return JsonResult.success(articles,totalCount);
        }
        else {
            return JsonResult.fail(200,"未登录");
        }
    }

    /**
     * 博客添加页面
     * @param request 判断登录
     * @return 页面
     */
    @RequestMapping("/admin/article/add")
    public ModelAndView articleAdd(HttpServletRequest request){
        if (request.getSession().getAttribute(Const.CURRENT_USER)!=null){
            return new ModelAndView("admin/views/article-add");
        }else {
            return new ModelAndView("admin/login");
        }
    }

    /**
     * 博客添加操作
     * @param request 判断登录
     * @param redirectAttributes 用于重定向之后带参数跳转
     * @return 提示信息和页面
     */
    @RequestMapping(value = "/admin/article/add/do",method = RequestMethod.POST)
    public String articleAddDo(HttpServletRequest request,RedirectAttributes redirectAttributes) {
        Article article=new Article();
        article.setTitle(request.getParameter("title"));
        article.setCatalogId(Integer.parseInt(request.getParameter("catalogId")));
        article.setKeywords(request.getParameter("keywords"));
        article.setPic(request.getParameter("pic"));
        article.setdesci(request.getParameter("describe"));
        article.setContent(request.getParameter("content-editormd-html-code"));
        article.setTime(new Date());
        if (articleService.insert(article)){
            redirectAttributes.addFlashAttribute("success", "发表文章成功！");
            return "redirect:/admin/article/add";
        }else {
            redirectAttributes.addFlashAttribute("error", "发表文章失败！");
            return "redirect:/admin/article/add";
        }
    }

    @RequestMapping(value = "/admin/article/search")
    public ModelAndView articleSearch(HttpServletRequest request){
        String word=request.getParameter("word");
        List<Article> articles=articleService.selectByWord(word);

        ModelAndView modelAndView=new ModelAndView("/admin/article_list");
        modelAndView.addObject("articles",articles);
        return modelAndView;
    }
    @RequestMapping(value = "/admin/article/edit")
    public ModelAndView articleEdit(HttpServletRequest request){
        int id=Integer.parseInt(request.getParameter("id"));
        Article article=articleService.selectById(id);
        ModelAndView modelAndView=new ModelAndView("/admin/article_edit");
        modelAndView.addObject("article",article);
        return modelAndView;
    }
    @RequestMapping(value = "/admin/article/edit/do")
    public ModelAndView articleEditDo(HttpServletRequest request){
        Article article=new Article();
        article.setId(Integer.parseInt(request.getParameter("id")));
        article.setTitle(request.getParameter("title"));
        article.setCatalogId(Integer.parseInt(request.getParameter("catalogId")));
        article.setKeywords(request.getParameter("keywords"));
        article.setdesci(request.getParameter("desci"));
        article.setContent(request.getParameter("content"));
        article.setPic(request.getParameter("pic"));
        ModelAndView modelAndView=new ModelAndView("/admin/article_edit");
        if (articleService.updateArticle(article)){
            modelAndView.addObject("succ", "修改文章成功！");

        }else {
            modelAndView.addObject("error", "修改文章失败！");
        }
        return modelAndView;
    }

    /**
     * 博客删除
     * @param request 判断登录
     * @return json格式数据 1 删除成功 0 删除失败
     */
    @RequestMapping(value = "/api/article/del", method = RequestMethod.POST)
    public @ResponseBody Object loginCheck(HttpServletRequest request) {
        int id=Integer.parseInt(request.getParameter("id"));
        HashMap<String, String> res = new HashMap<String, String>();
        if (request.getSession().getAttribute(Const.CURRENT_USER)!=null){
            int result=articleService.deleteById(id);
            if (result==1){
                res.put("stateCode", "1");
            }
            else {
                res.put("stateCode", "0");
            }
        }
        else {
            res.put("stateCode", "0");
        }
        return res;
    }
}
