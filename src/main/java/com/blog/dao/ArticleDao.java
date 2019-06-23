package com.blog.dao;

import com.blog.domain.Article;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Article record);

    int insertSelective(Article record);

    Article selectByPrimaryKey(Integer id);

    Article selectLastArticle(Integer id);

    Article selectNextArticle(Integer id);

    int updateByPrimaryKeySelective(Article record);

    int updateByPrimaryKeyWithBLOBs(Article record);

    int updateByPrimaryKey(Article record);

    int countAllNum();


    List<Article> queryAll();

    /**
     * 查询博客列表
     * @return 列表
     */
    List<Article> selectArticleList();

    List<Article> selectByWord(String word);
}