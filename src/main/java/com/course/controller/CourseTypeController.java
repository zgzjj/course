package com.course.controller;

import com.course.pojo.CoursePo;
import com.course.pojo.CourseTypePo;
import com.course.pojo.UserPo;
import com.course.service.CourseService;
import com.course.service.CourseTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/api/courseType")
public class CourseTypeController {
    @Autowired
    private CourseTypeService courseTypeService;

    @RequestMapping(value = "/queryClassify", method = RequestMethod.GET)
    @ResponseBody
    public List<CourseTypePo> queryClassify(){
        return courseTypeService.queryClassify();
    }
    @RequestMapping(value = "/queryClassifyByCode/{courseTypeCode}", method = RequestMethod.GET)
    @ResponseBody
    public CourseTypePo queryClassifyByCode(@PathVariable String courseTypeCode){
        return courseTypeService.queryClassifyByCode(courseTypeCode);
    }
    @RequestMapping(value = "/querySubClassify", method = RequestMethod.GET)
    @ResponseBody
    public List<CourseTypePo> querySubClassify(){
        return courseTypeService.querySubClassify();
    }

    @RequestMapping(value = "/querySubClassifyByParent/{courseTypeCode}", method = RequestMethod.GET)
    @ResponseBody
    public List<CourseTypePo> querySubClassifyByParent(@PathVariable String courseTypeCode){
        return courseTypeService.querySubClassifyByParent(courseTypeCode);
    }

    @RequestMapping(value = "/insertCourseType", method = RequestMethod.POST)
    @ResponseBody
    public void insertCourse(@RequestBody  CourseTypePo po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User");
        po.setCreateUser(user.getUserId());
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        po.setCreateTime(fat.format(date.getTime()));
        courseTypeService.insertCourseType(po);
    }
    @RequestMapping(value = "/deleteCourseType", method = RequestMethod.POST)
    @ResponseBody
    public void deleteCourse(@RequestBody  CourseTypePo po){
        if(courseTypeService.querySubClassifyByParent(po.getCourseTypeCode())!=null){
            courseTypeService.deleteCourseTypeById(po.getCourseTypeId());
            courseTypeService.deleteCourseTypeByParent(po.getCourseTypeCode());
        }else{
            courseTypeService.deleteCourseTypeById(po.getCourseTypeId());
        }
    }
    @RequestMapping(value = "/updateCourseType", method = RequestMethod.PUT)
    @ResponseBody
    public void updateCourse(@RequestBody  CourseTypePo po, HttpSession session){
        UserPo user=(UserPo)session.getAttribute("User");
        po.setUpdateUser(user.getUserId());
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        po.setUpdateTime(fat.format(date.getTime()));
         courseTypeService.updateById(po);
    }
}
