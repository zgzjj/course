package com.course.controller;

import com.baidu.ueditor.ActionEnter;
import com.course.pojo.ArticlePo;
import com.course.pojo.CoursePo;
import com.course.pojo.UserPo;
import com.course.service.ArticleService;
import com.course.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/api/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @RequestMapping(value = "/insertArticle", method = RequestMethod.POST)
    @ResponseBody
    public void insertArticle(@RequestBody ArticlePo po,HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User") ;
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        po.setCreateTime(fat.format(date.getTime()));
        po.setCreateUser(user.getUserId());
        articleService.insertArticle(po);
    }

    @RequestMapping(value = "/sysArticleList", method = RequestMethod.GET)
    @ResponseBody
    public List<ArticlePo> sysQueryAll(){
        return articleService.sysQueryAll();
    }
    @RequestMapping(value = "/pageArticleList", method = RequestMethod.GET)
    @ResponseBody
    public List<Map> pageQueryAll(){
            return articleService.pageQueryAll();
    }
    @RequestMapping(value = "/queryById/{articleId}", method = RequestMethod.GET)
    @ResponseBody
    public ArticlePo queryById(@PathVariable long articleId){
        return articleService.queryById(articleId);
    }
}
