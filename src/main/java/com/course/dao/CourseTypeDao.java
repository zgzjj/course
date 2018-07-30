package com.course.dao;

import com.course.pojo.CoursePo;
import com.course.pojo.CourseTypePo;

import java.util.List;

public interface CourseTypeDao {

    //通过code查询分类
    public CourseTypePo queryClassifyByCode(String courseTypeCode);
    //查询一级分类
    public List<CourseTypePo> queryClassify();

    public List<CourseTypePo> querySubClassifyByParent(String parentCode);
    //查询二级分类
    public List<CourseTypePo> querySubClassify();
    //添加课程分类
    public void insertCourseType(CourseTypePo po);

    //通过id删除课程分类
    public void deleteCourseTypeById(long courseTypeId);

    public void deleteCourseTypeByParent(String parentCode);

    //通过id修改课程分类
    public void updateById(CourseTypePo po);

}
