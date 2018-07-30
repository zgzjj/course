package com.course.dao;

import com.course.pojo.FollowPo;
import com.course.pojo.UserPo;

import java.util.List;

public interface FollowDao {
    public List<UserPo> queryById(long userId);

    public FollowPo isFollow(FollowPo po);

    public void insertFollow(FollowPo po);

    public void deleteFollow(FollowPo po);
}
