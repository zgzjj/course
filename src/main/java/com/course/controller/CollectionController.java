package com.course.controller;

import com.course.pojo.ArticlePo;
import com.course.pojo.CollectionPo;
import com.course.pojo.CoursePo;
import com.course.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api/collection")
public class CollectionController {
    @Autowired
    private CollectionService collectionService;

    @RequestMapping(value = "/isCollection", method = RequestMethod.POST)
    @ResponseBody
    public String isCollection(@RequestBody CollectionPo po){
         if(collectionService.queryByIdAndType(po)!=null){
             return "success";
         }else{
             return "fail";
         }
    }
    @RequestMapping(value = "/insertCollection", method = RequestMethod.POST)
    @ResponseBody
    public void insertCollection(@RequestBody CollectionPo po){
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        String now=fat.format(date.getTime());
        po.setCreateTime(now);
        collectionService.insertCollection(po);
    }
    @RequestMapping(value = "/getCollectionByUser/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public Map getCollectionByUser(@PathVariable long userId){
        Map result = new HashMap();
        List<CoursePo> courseList = collectionService.queryCourseByUserId(userId);
        List<ArticlePo> articleList = collectionService.queryArticleByUserId(userId);
        result.put("courseList",courseList);
        result.put("articleList",articleList);
        return result;
    }

    @RequestMapping(value = "/deleteCollection", method = RequestMethod.POST)
    @ResponseBody
    public void deleteCollection(@RequestBody CollectionPo po){
            collectionService.deleteCollection(po);
    }
}
