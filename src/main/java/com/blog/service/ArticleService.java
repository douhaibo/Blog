package com.blog.service;

import com.blog.domain.Article;

import java.util.List;

/**
 * 文章操作接口
 * @author DouHaibo
 */
public interface ArticleService {

    /**
     * 根据文章id查询
     * @param id 文章id
     * @return Article
     */
    Article selectById(Integer id);


    Article selectLastArticle(Integer id);

    Article selectNextArticle(Integer id);

    List<Article> queryAll();

    /**
     * 查询博客列表
     * @return 部分数据
     */
    List<Article> selectArticleList();

    int countAllNum();

    boolean updateArticle(Article article);

    int deleteById(Integer id);

    int selectCount();

    List<Article> selectByWord(String word);

    boolean insert(Article article);
}
