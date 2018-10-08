package com.course.controller;

import com.course.pojo.CoursePo;
import com.course.pojo.UserPo;
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
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/api/course")
public class CourseController {
    @Autowired
    private CourseService courseService;


    @RequestMapping(value = "/queryByName", method = RequestMethod.GET)
    @ResponseBody
    public  List<CoursePo> queryByName(@RequestParam String courseName){
        return courseService.queryByName(courseName);
    }
    @RequestMapping(value = "/queryByUser/{createUser}", method = RequestMethod.GET)
    @ResponseBody
    public Map queryByUser(@PathVariable("createUser") long createUser){
        Map result=new HashMap();
        List<CoursePo> courseList = courseService.queryByUser(createUser);
        result.put("courseList",courseList);
        return result;
    }
    @RequestMapping(value = "/queryById/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public CoursePo queryById(@PathVariable("courseId") long courseId){
        courseService.updateCount(courseId);
        return courseService.queryById(courseId);
    }
    @RequestMapping(value = "/sysQueryAll", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> sysQueryAll(){
        return courseService.sysQueryAll();
    }

    //首页根据点击量展示top6课程
    @RequestMapping(value = "/indexQueryByCount", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> indexQueryByCount(){
        return courseService.indexQueryByCount();
    }
    //首页根据课程上传时间展示top6课程
    @RequestMapping(value = "/indexQueryCreateTime", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> indexQueryCreateTime(){
        return courseService.indexQueryCreateTime();
    }
    //首页展示初级的top6课程
    @RequestMapping(value = "/indexQueryByLevel", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> queryByLevel(){
        return courseService.indexQueryByLevel();
    }


    @RequestMapping(value = "/pageQueryAll", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> pageQueryAll(){
        return courseService.pageQueryAll();
    }

    @RequestMapping(value = "/pageQueryByLevel/{courseLevel}", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> pageQueryByLevel(@PathVariable String courseLevel){
        return courseService.pageQueryByLevel(courseLevel);
    }
    @RequestMapping(value = "/pageQueryByClassify/{classify}", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> pageQueryByClassify(@PathVariable("classify") String classify){
        return courseService.pageQueryByClassify(classify);
    }
    @RequestMapping(value = "/pageQueryByClassifyAndLevel/{classify}/{courseLevel}", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> pageQueryByClassifyAndLevel(@PathVariable("classify") String classify,@PathVariable("courseLevel") String courseLevel){
        return courseService.pageQueryByClassifyAndLevel(classify,courseLevel);
    }
    @RequestMapping(value = "/pageQueryBySubClassify/{subClassify}", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> pageQueryBySubClassify(@PathVariable("subClassify") String subClassify){
        return courseService.pageQueryBySubClassify(subClassify);
    }
    @RequestMapping(value = "/pageQueryBySubClassifyAndLevel/{subClassify}/{courseLevel}", method = RequestMethod.GET)
    @ResponseBody
    public List<CoursePo> pageQueryBySubClassifyAndLevel(@PathVariable("subClassify") String subClassify,@PathVariable("courseLevel") String courseLevel){
        return courseService.pageQueryBySubClassifyAndLevel(subClassify,courseLevel);
    }
    @RequestMapping(value = "/insertCourse", method = RequestMethod.POST)
    @ResponseBody
    public void insertCourse(@RequestBody  CoursePo po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User") ;
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        po.setCreateTime(fat.format(date.getTime()));
        po.setCreateUser(user.getUserId());
        courseService.insertCourse(po);
    }
    @RequestMapping(value = "/deleteCourse/{courseId}", method = RequestMethod.GET)
    @ResponseBody
    public void deleteCourse(@PathVariable  long courseId){
         courseService.deleteCourse(courseId);
    }
    @RequestMapping(value = "/updateCourse", method = RequestMethod.PUT)
    @ResponseBody
    public void updateCourse(@RequestBody  CoursePo po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User") ;
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        po.setModifyTime(fat.format(date.getTime()));
        po.setUpdateUser(user.getUserId());
        courseService.updateById(po);
    }
    @RequestMapping(value = "/changeStatus", method = RequestMethod.PUT)
    @ResponseBody
    public void changeStatus(@RequestBody  CoursePo po){
         courseService.changeStatus(po);
    }
    @RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
    public @ResponseBody String uploadImg(
            HttpServletRequest request,
            @RequestParam(value = "file") MultipartFile multipartFile,
            HttpServletResponse response){
            String sqlPath = null;
            String filename=null;
            String localPath="F:\\IDEA-workspace\\course\\src\\main\\webapp\\resources\\images\\course\\";
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            String contentType=multipartFile.getContentType();
            String suffixName=contentType.substring(contentType.indexOf("/")+1);
            filename=uuid+"."+suffixName;
            try {
                multipartFile.transferTo(new File(localPath+filename));
            } catch (IOException e) {
                e.printStackTrace();
            }
            sqlPath = "/photo/course/"+filename;
            return sqlPath;
        }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public @ResponseBody String uploadFile(
            HttpServletRequest request,
            @RequestParam(value = "file") MultipartFile multipartFile,
            HttpServletResponse response){
        String sqlPath = null;
        String filename=null;
        String localPath="F:\\IDEA-workspace\\course\\src\\main\\webapp\\resources\\video\\";
        String uuid = UUID.randomUUID().toString().replaceAll("-","");
        String contentType=multipartFile.getContentType();
        String suffixName=contentType.substring(contentType.indexOf("/")+1);
        filename=uuid+"."+suffixName;
        try {
            multipartFile.transferTo(new File(localPath+filename));
        } catch (IOException e) {
            e.printStackTrace();
        }
        sqlPath = "/video/"+filename;
        return sqlPath;
    }
}
