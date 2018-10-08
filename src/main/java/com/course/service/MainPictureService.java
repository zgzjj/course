package com.course.service;

import com.course.pojo.FollowPo;
import com.course.pojo.MainPicturePo;
import com.course.pojo.UserPo;

import java.util.List;

public interface MainPictureService {
    public MainPicturePo queryById(long pictureId);

    public List<MainPicturePo> sysQuery();

    public List<MainPicturePo> pageQuery();

    public void insertPicture(MainPicturePo po);

    public void updatePicture(MainPicturePo po);

    public void deletePicture(MainPicturePo po);
}
