package com.course.service;

import com.course.pojo.ArticleTypePo;

import java.util.List;

public interface ArticleTypeService {
    public List<ArticleTypePo> pageQueryAll();
    public List<ArticleTypePo> sysQueryAll();

    public ArticleTypePo queryClassifyByCode(String articleTypeCode);

    public void insertArticleType(ArticleTypePo po);

    public void deleteArticleTypeById(long articleTypeId);

    public void updateById(ArticleTypePo po);
}
