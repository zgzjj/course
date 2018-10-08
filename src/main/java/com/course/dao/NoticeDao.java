package com.course.dao;

import com.course.pojo.NoticePo;

import java.util.List;

public interface NoticeDao {
    public List<NoticePo> queryAll();

    public List<NoticePo> queryByStatus();
    public List<NoticePo> queryByName(String noticeName);

    public void insertNotice(NoticePo po);

    public void updateNotice(NoticePo po);

    public void deleteNotice(long noticeId);
}
