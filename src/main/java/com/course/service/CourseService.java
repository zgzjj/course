package com.course.service;

import com.course.pojo.CoursePo;

import java.util.List;

public interface CourseService {
    public CoursePo queryById(long courseId);
    //通过名称查询课程
    public CoursePo queryByName(String courseName);
    //通过上传者ID查询课程
    public List<CoursePo> queryByUser(long createUser);
    //点击量增加
    public void updateCount(long courseId);
    //查询所有课程
    public List<CoursePo> sysQueryAll();

    //通过点击量查询课程
    public List<CoursePo> indexQueryByCount();
    //通过上传时间查询课程
    public List<CoursePo> indexQueryCreateTime();
    //通过课程等级查询课程
    public List<CoursePo> indexQueryByLevel();

    public  List<CoursePo> pageQueryAll();

    public  List<CoursePo> pageQueryByLevel(String courseLevel);
    //通过类别查询课程
    public  List<CoursePo> pageQueryByClassify(String classify);

    //通过二级类别查询课程
    public  List<CoursePo> pageQueryBySubClassify(String subClassify);
    //通过类别和难度查询课程
    public  List<CoursePo> pageQueryByClassifyAndLevel(String classify,String courseLevel);

    //通过二级类别和难度查询课程
    public  List<CoursePo> pageQueryBySubClassifyAndLevel(String subClassify,String courseLevel);
    //添加课程
    public void insertCourse(CoursePo po);

    //通过id删除课程
    public void deleteCourse(long  courseId);

    //通过id修改课程
    public void updateById(CoursePo po);

    //通过id修改课程状态
    public void changeStatus(CoursePo po);
}
