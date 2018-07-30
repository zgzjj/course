package com.course.controller;

import com.course.pojo.ArticlePo;
import com.course.pojo.ArticleTypePo;
import com.course.pojo.UserPo;
import com.course.service.ArticleTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/api/articleType")
public class ArticleTypeController {
    @Autowired
    private ArticleTypeService articleTypeService;

    @RequestMapping(value = "/insertArticleType", method = RequestMethod.POST)
    @ResponseBody
    public void insertArticle(@RequestBody ArticleTypePo po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User") ;
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        po.setCreateTime(fat.format(date.getTime()));
        po.setCreateUser(user.getUserId());
        articleTypeService.insertArticleType(po);
    }

    @RequestMapping(value = "/sysQueryAll", method = RequestMethod.GET)
    @ResponseBody
    public List<ArticleTypePo> sysQueryAll(){
        return articleTypeService.sysQueryAll();
    }

    @RequestMapping(value = "/pageQueryAll", method = RequestMethod.GET)
    @ResponseBody
    public List<ArticleTypePo> pageQueryAll(){
        return articleTypeService.pageQueryAll();
    }
}
