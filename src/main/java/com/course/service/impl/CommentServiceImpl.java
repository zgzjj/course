package com.course.service.impl;

import com.course.dao.CommentDao;
import com.course.pojo.CommentPo;
import com.course.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentDao commentDao;

    public List<Map> queryByIdAndType(CommentPo po) {
        return commentDao.queryByIdAndType(po);
    }

    public void insertComment(CommentPo po) {
        commentDao.insertComment(po);
    }

    public void deleteComment(long commentId) {
        commentDao.deleteComment(commentId);
    }
}
