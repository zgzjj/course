package com.course.service;

import com.course.pojo.UserPo;

import java.util.List;

public interface UserService {
    //查询单个用户信息
    public UserPo getById(long userId);

    public List<UserPo> queryByUserCnName(String userCnName);

    public UserPo getByUserNameAndPwd(String userName,String password);

    public void register(UserPo userPo);

    public UserPo havingUser(String userName);

    public List<UserPo> queryUserList();

    public void updateInfo(UserPo userPo);

    public int loginRank(long userId,String loginDate);

    public void changePwdById(UserPo po);

    public void deleteById(long userId);

    public void updateStatus(UserPo po);
}
