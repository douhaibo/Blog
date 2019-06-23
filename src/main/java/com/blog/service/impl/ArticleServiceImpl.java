package com.blog.service.impl;

import com.blog.dao.ArticleDao;
import com.blog.domain.Article;
import com.blog.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 文章操作实现类
 * @author DouHaibo
 */
@Service
public class ArticleServiceImpl implements ArticleService{

    @Autowired
    public ArticleDao articleDao;

    @Override
    public Article selectById(Integer id) {
        return articleDao.selectByPrimaryKey(id);
    }

    @Override
    public List<Article> queryAll() {
        return articleDao.queryAll();
    }

    @Override
    public List<Article> selectArticleList() {
        return articleDao.selectArticleList();
    }

    @Override
    public int countAllNum() {
        return articleDao.countAllNum();
    }

    @Override
    public boolean updateArticle(Article article) {
        return articleDao.updateByPrimaryKeySelective(article)>0;
    }

    @Override
    public int deleteById(Integer id) {
        return articleDao.deleteByPrimaryKey(id);
    }

    @Override
    public int selectCount() {
        return articleDao.countAllNum();
    }

    @Override
    public List<Article> selectByWord(String word) {
        return articleDao.selectByWord(word);
    }

    @Override
    public boolean insert(Article article) {
        return articleDao.insert(article)>0;
    }

    @Override
    public Article selectLastArticle(Integer id) {
        return articleDao.selectLastArticle(id);
    }

    @Override
    public Article selectNextArticle(Integer id) {
        return articleDao.selectNextArticle(id);
    }
}
