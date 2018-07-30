package com.course.dao;

import com.course.pojo.UserPo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    //通过用户名密码查询用户
    public UserPo queryByNameAndPwd(@Param("userName")  String userName,@Param("userPwd")  String userPwd);

    //通过I的查询用户
    public UserPo queryById(long userId);

    //查询所有用户
    public List<UserPo> queryAll();

    //添加用户
    public void  insertUser(UserPo po);

    public UserPo queryByName(String userName);

    //通过id修改用户
    public void updateById(UserPo po);

    //每天登陆增加成长值
    public int loginRank(@Param("userId")  long userId,@Param("loginDate")  String loginDate);

    //通过id修该密码
     public void changePwdById(UserPo po);

     public void deleteById(long userId);

     public void updateStatus(UserPo po);
}
