package com.course.controller;

import com.course.pojo.NoticePo;
import com.course.pojo.UserPo;
import com.course.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/api/notice")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;
    @RequestMapping(value = "/queryAll", method = RequestMethod.GET)
    @ResponseBody
    public List<NoticePo> queryAll(){
        return noticeService.queryAll();
    }
    @RequestMapping(value = "/queryByStatus", method = RequestMethod.GET)
    @ResponseBody
    public List<NoticePo> queryByStatus(){
        return noticeService.queryByStatus();
    }
    @RequestMapping(value = "/insertNotice", method = RequestMethod.POST)
    @ResponseBody
    public void insertNotice(@RequestBody NoticePo po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User");
        po.setUserId(user.getUserId());
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        String now=fat.format(date.getTime());
        po.setCreateTime(now);
         noticeService.insertNotice(po);
    }

    @RequestMapping(value = "/updateNotice", method = RequestMethod.PUT)
    @ResponseBody
    public void updateNotice(@RequestBody NoticePo po){
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        String now=fat.format(date.getTime());
        po.setModifyTime(now);
        noticeService.updateNotice(po);
    }

    @RequestMapping(value = "/deleteNotice/{noticeId}", method = RequestMethod.GET)
    @ResponseBody
    public void deleteNotice(@PathVariable long noticeId){
        noticeService.deleteNotice(noticeId);
    }
}
