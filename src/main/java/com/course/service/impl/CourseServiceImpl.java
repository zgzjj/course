package com.course.service.impl;

import com.course.dao.CourseDao;
import com.course.pojo.CoursePo;
import com.course.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseDao courseDao;

    public CoursePo queryById(long courseId){
        return courseDao.queryById(courseId);
    }
    //点击量增加
    public void updateCount(long courseId){
        courseDao.updateCount(courseId);
    }
    public  List<CoursePo> queryByName(String courseName) {
        return courseDao.queryByName(courseName);
    }

    public List<CoursePo> sysQueryAll() {
        return courseDao.sysQueryAll();
    }

    //通过上传者ID查询课程
    public List<CoursePo> queryByUser(long createUser){
        return courseDao.queryByUser(createUser);
    }

    public void insertCourse(CoursePo po) {
         courseDao.insertCourse(po);
    }

    public void deleteCourse(long courseId) {
         courseDao.deleteCourse(courseId);
    }

    public void updateById(CoursePo po) {
         courseDao.updateById(po);
    }

    public void changeStatus(CoursePo po) {
         courseDao.changeStatus(po);
    }

    public List<CoursePo> indexQueryByCount() {
        return courseDao.indexQueryByCount();
    }

    public List<CoursePo> indexQueryCreateTime() {
        return courseDao.indexQueryCreateTime();
    }

    public List<CoursePo> indexQueryByLevel() {
        return courseDao.indexQueryByLevel();
    }

    public List<CoursePo> pageQueryAll() {
        return courseDao.pageQueryAll();
    }

    public List<CoursePo> pageQueryByLevel(String courseLevel) {
        return courseDao.pageQueryByLevel(courseLevel);
    }

    public List<CoursePo> pageQueryByClassify(String classify) {
        return courseDao.pageQueryByClassify(classify);
    }

    public List<CoursePo> pageQueryBySubClassify(String subClassify) {
        return courseDao.pageQueryBySubClassify(subClassify);
    }

    public List<CoursePo> pageQueryByClassifyAndLevel(String classify, String courseLevel) {
        return courseDao.pageQueryByClassifyAndLevel(classify,courseLevel);
    }

    public List<CoursePo> pageQueryBySubClassifyAndLevel(String subClassify, String courseLevel) {
        return courseDao.pageQueryBySubClassifyAndLevel(subClassify,courseLevel);
    }
}
