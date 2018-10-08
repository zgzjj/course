package com.course.service.impl;

import com.course.dao.FollowDao;
import com.course.dao.MainPictureDao;
import com.course.pojo.FollowPo;
import com.course.pojo.MainPicturePo;
import com.course.pojo.UserPo;
import com.course.service.FollowService;
import com.course.service.MainPictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainPictureServiceImpl implements MainPictureService {
    @Autowired
    private MainPictureDao mainPictureDao;

    public MainPicturePo queryById(long pictureId) {
        return mainPictureDao.queryById(pictureId);
    }

    public List<MainPicturePo> sysQuery() {
        return mainPictureDao.sysQuery();
    }

    public List<MainPicturePo> pageQuery() {
        return mainPictureDao.pageQuery();
    }

    public void insertPicture(MainPicturePo po) {
        mainPictureDao.insertPicture(po);
    }
    public void updatePicture(MainPicturePo po){
        mainPictureDao.updatePicture(po);
    }
    public void deletePicture(MainPicturePo po) {
        mainPictureDao.deletePicture(po);
    }
}
