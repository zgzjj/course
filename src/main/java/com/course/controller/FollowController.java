package com.course.controller;

import com.course.pojo.FollowPo;
import com.course.pojo.UserPo;
import com.course.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/api/follow")
public class FollowController {
    @Autowired
    private FollowService followService;

    @RequestMapping(value = "/queryById/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public List<UserPo> queryById(@PathVariable long  userId){
       return followService.queryById(userId);
    }

    @RequestMapping(value = "/isFollow", method = RequestMethod.POST)
    @ResponseBody
    public String isFollow(@RequestBody FollowPo  po){
        if(followService.isFollow(po)!=null){
            return "success";
        } else{
            return "fail";
        }
    }

    @RequestMapping(value = "/insertFollow", method = RequestMethod.POST)
    @ResponseBody
    public void insertFollow(@RequestBody FollowPo po){
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        String now=fat.format(date.getTime());
        po.setCreateTime(now);
        followService.insertFollow(po);
    }
    @RequestMapping(value = "/deleteFollow", method = RequestMethod.POST)
    @ResponseBody
    public void deleteFollow(@RequestBody FollowPo po){
        followService.deleteFollow(po);
    }
}
