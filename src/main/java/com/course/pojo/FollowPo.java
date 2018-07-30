package com.course.pojo;

public class FollowPo {
    private long followId;
    private long userId;
    private long beFollowUser;
    private String createTime;

    public long getFollowId() {
        return followId;
    }

    public void setFollowId(long followId) {
        this.followId = followId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getBeFollowUser() {
        return beFollowUser;
    }

    public void setBeFollowUser(long beFollowUser) {
        this.beFollowUser = beFollowUser;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
