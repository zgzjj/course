package com.course.service.impl;

import com.course.dao.ArticleDao;
import com.course.pojo.ArticlePo;
import com.course.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    private ArticleDao articleDao;

    public ArticlePo queryById(long articleId) {
        return articleDao.queryById(articleId);
    }

    public void updateCount(long articleId) {
        articleDao.updateCount(articleId);
    }

    public List<ArticlePo> queryByUser(long createUser) {
        return articleDao.queryByUser(createUser);
    }

    public ArticlePo queryByName(String articleName) {
        return articleDao.queryByName(articleName);
    }

    public List<ArticlePo> sysQueryAll() {
        return articleDao.sysQueryAll();
    }

    public List<ArticlePo> indexQueryByCount() {
        return articleDao.indexQueryByCount();
    }

    public List<ArticlePo> indexQueryCreateTime() {
        return articleDao.indexQueryCreateTime();
    }

    public List<Map> pageQueryAll() {
        return articleDao.pageQueryAll();
    }

    public List<ArticlePo> pageQueryByClassify(String classify) {
        return articleDao.pageQueryByClassify(classify);
    }

    public void insertArticle(ArticlePo po) {
        articleDao.insertArticle(po);
    }

    public void deleteArticle(long articleId) {
        articleDao.deleteArticle(articleId);
    }

    public void updateById(ArticlePo po) {
        articleDao.updateById(po);
    }

    public void changeStatus(ArticlePo po) {
        articleDao.changeStatus(po);
    }
}
