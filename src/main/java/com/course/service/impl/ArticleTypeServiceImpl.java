package com.course.service.impl;

import com.course.dao.ArticleTypeDao;
import com.course.pojo.ArticleTypePo;
import com.course.service.ArticleTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleTypeServiceImpl implements ArticleTypeService {
    @Autowired
    private ArticleTypeDao articleTypeDao;
    public List<ArticleTypePo> pageQueryAll(){
        return articleTypeDao.pageQueryAll();
    }
    public List<ArticleTypePo> sysQueryAll() {
        return articleTypeDao.sysQueryAll();
    }

    public ArticleTypePo queryClassifyByCode(String articleTypeCode) {
        return articleTypeDao.queryClassifyByCode(articleTypeCode);
    }

    public void insertArticleType(ArticleTypePo po) {
        articleTypeDao.insertArticleType(po);
    }

    public void deleteArticleTypeById(long articleTypeId) {
        articleTypeDao.deleteArticleTypeById(articleTypeId);
    }

    public void updateById(ArticleTypePo po) {
        articleTypeDao.updateById(po);
    }
}
