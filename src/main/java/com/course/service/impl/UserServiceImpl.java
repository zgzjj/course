package com.course.service.impl;

import com.course.dao.UserDao;
import com.course.pojo.UserPo;
import com.course.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDao userDao;
    public UserPo getById(long userId){
        return userDao.queryById(userId);
    }


    public UserPo getByUserNameAndPwd(String userName, String password) {
        return userDao.queryByNameAndPwd(userName,password);
    }

    public void register(UserPo po) {
         userDao.insertUser(po);
    }

    public UserPo havingUser(String userName){
        return userDao.queryByName(userName);
    }

    public List<UserPo> queryUserList(){
        return userDao.queryAll();
    }
    public void updateInfo(UserPo userPo){
         userDao.updateById(userPo);
    }

    public int loginRank(long userId,String loginDate) {
       return userDao.loginRank(userId,loginDate);
    }

    public void changePwdById(UserPo po){
         userDao.changePwdById(po);
    }

    public void deleteById(long userId){
        userDao.deleteById(userId);
    }

    public void updateStatus(UserPo po){
        userDao.updateStatus(po);
    }
}
