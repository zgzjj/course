package com.course.service;

import com.course.pojo.FollowPo;
import com.course.pojo.UserPo;

import java.util.List;

public interface FollowService {
    public List<UserPo> queryById(long userId);

    public void insertFollow(FollowPo po);

    public void deleteFollow(FollowPo po);

    public FollowPo isFollow(FollowPo po);
}
