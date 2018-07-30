package com.course.service.impl;


import com.course.dao.CourseTypeDao;
import com.course.pojo.CourseTypePo;
import com.course.service.CourseTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseTypeServiceImpl implements CourseTypeService {
    @Autowired
    private CourseTypeDao courseTypeDao;

    //通过code查询分类
    public CourseTypePo queryClassifyByCode(String courseTypeCode){
        return courseTypeDao.queryClassifyByCode(courseTypeCode);
    }

    public List<CourseTypePo> queryClassify() {
        return courseTypeDao.queryClassify();
    }

    public List<CourseTypePo> querySubClassify() {
        return courseTypeDao.querySubClassify();
    }

    public void insertCourseType(CourseTypePo po) {
        courseTypeDao.insertCourseType(po);

    }
    public List<CourseTypePo> querySubClassifyByParent(String parentCode){
        return courseTypeDao.querySubClassifyByParent(parentCode);
    }
    public void deleteCourseTypeById(long courseTypeId) {
        courseTypeDao.deleteCourseTypeById(courseTypeId);
    }
    public void deleteCourseTypeByParent(String parentCode){
        courseTypeDao.deleteCourseTypeByParent(parentCode);
    }

    public void updateById(CourseTypePo po) {
        courseTypeDao.updateById(po);
    }
}
