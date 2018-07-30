package com.course.service;

import com.course.pojo.ArticlePo;
import com.course.pojo.CollectionPo;
import com.course.pojo.CoursePo;

import java.util.List;

public interface CollectionService {
    public CollectionPo queryByIdAndType(CollectionPo po);

    public List<CoursePo> queryCourseByUserId(long userId);

    public List<ArticlePo> queryArticleByUserId(long userId);

    public void insertCollection(CollectionPo po);

    public void deleteCollection(CollectionPo po);
}
