package com.course.service.impl;

import com.course.dao.FollowDao;
import com.course.pojo.FollowPo;
import com.course.pojo.UserPo;
import com.course.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FollowServiceImpl implements FollowService {
    @Autowired
    private FollowDao followDao;
    public List<UserPo> queryById(long userId) {
        return followDao.queryById(userId);
    }

    public FollowPo isFollow(FollowPo po){
        return followDao.isFollow(po);
    }

    public void insertFollow(FollowPo po) {
        followDao.insertFollow(po);
    }

    public void deleteFollow(FollowPo po) {
        followDao.deleteFollow(po);
    }
}
