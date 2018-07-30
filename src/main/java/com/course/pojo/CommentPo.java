package com.course.pojo;

public class CommentPo {
    private long commentId;
    private long userId;
    private long resourceId;
    private long resourceType;
    private String commentContent;
    private String createTime;

    public long getResourceType() {
        return resourceType;
    }

    public void setResourceType(long resourceType) {
        this.resourceType = resourceType;
    }

    public long getCommentId() {
        return commentId;
    }

    public void setCommentId(long commentId) {
        this.commentId = commentId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getResourceId() {
        return resourceId;
    }

    public void setResourceId(long resourceId) {
        this.resourceId = resourceId;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
