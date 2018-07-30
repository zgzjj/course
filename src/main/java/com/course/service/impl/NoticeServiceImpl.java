package com.course.service.impl;

import com.course.dao.NoticeDao;
import com.course.pojo.NoticePo;
import com.course.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeDao noticeDao;

    public List<NoticePo> queryAll() {
        return noticeDao.queryAll();
    }

    public List<NoticePo> queryByStatus() {
        return noticeDao.queryByStatus();
    }

    public void insertNotice(NoticePo po) {
        noticeDao.insertNotice(po);
    }

    public void updateNotice(NoticePo po) {
        noticeDao.updateNotice(po);
    }

    public void deleteNotice(long noticeId) {
        noticeDao.deleteNotice(noticeId);
    }
}
