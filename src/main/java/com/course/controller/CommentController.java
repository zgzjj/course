package com.course.controller;

import com.course.pojo.CommentPo;
import com.course.pojo.UserPo;
import com.course.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.awt.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/queryByIdAndType", method = RequestMethod.POST)
    @ResponseBody
    public List<Map> queryByIdAndType(@RequestBody CommentPo  po){
        return commentService.queryByIdAndType(po);
    }

    @RequestMapping(value = "/insertComment", method = RequestMethod.POST)
    @ResponseBody
    public void insertComment(@RequestBody CommentPo  po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User");
        po.setUserId(user.getUserId());
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        String now=fat.format(date.getTime());
        po.setCreateTime(now);
         commentService.insertComment(po);
    }

    @RequestMapping(value = "/deleteComment/{commentId}", method = RequestMethod.GET)
    @ResponseBody
    public void insertComment(@PathVariable long  commentId){
        commentService.deleteComment(commentId);
    }
}
