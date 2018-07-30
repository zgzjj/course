package com.course.dao;

import com.course.pojo.CommentPo;

import java.util.List;
import java.util.Map;

public interface CommentDao {
    public List<Map> queryByIdAndType(CommentPo po);

    public void insertComment(CommentPo po);

    public void deleteComment(long commentId);
}
