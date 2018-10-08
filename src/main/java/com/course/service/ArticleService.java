package com.course.service;

import com.course.pojo.ArticlePo;

import java.util.List;
import java.util.Map;

public interface ArticleService {
    //通过ID查询文章
    public ArticlePo queryById(long articleId);
    //点击量增加
    public void updateCount(long articleId);
    //通过上传者ID查询文章
    public List<ArticlePo> queryByUser(long createUser);
    //通过名称查询文章
    public List<ArticlePo> queryByName(String articleName);
    //查询所有文章
    public List<ArticlePo> sysQueryAll();

    //首页通过点击量查询文章
    public List<ArticlePo> indexQueryByCount();
    //首页通过上传时间查询文章
    public List<ArticlePo> indexQueryCreateTime();

    public  List<Map> pageQueryAll();

    //通过类别查询文章
    public  List<Map> pageQueryByClassify(String classify);


    //添加文章
    public void insertArticle(ArticlePo po);

    //通过id删除文章
    public void deleteArticle(long articleId);

    //通过id修改文章
    public void updateById(ArticlePo po);

    //通过id修改文章状态
    public void changeStatus(ArticlePo po);
}
