package com.course.service.impl;

import com.course.dao.CollectionDao;
import com.course.pojo.ArticlePo;
import com.course.pojo.CollectionPo;
import com.course.pojo.CoursePo;
import com.course.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CollectionServiceImpl implements CollectionService {
    @Autowired
    private CollectionDao collectionDao;
    public CollectionPo queryByIdAndType(CollectionPo po) {
        return collectionDao.queryByIdAndType(po);
    }

    public List<CoursePo> queryCourseByUserId(long userId) {
        return collectionDao.queryCourseByUserId(userId);
    }

    public List<ArticlePo> queryArticleByUserId(long userId) {
        return collectionDao.queryArticleByUserId(userId);
    }

    public void insertCollection(CollectionPo po) {
        collectionDao.insertCollection(po);
    }

    public void deleteCollection(CollectionPo po) {
        collectionDao.deleteCollection(po);
    }
}
