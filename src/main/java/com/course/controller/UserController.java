package com.course.controller;

import com.course.pojo.UserPo;
import com.course.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/api/user")
@SessionAttributes("User")
public class UserController {
    @Autowired
    private UserService userService;
    private static String localPath="F:\\IDEA-workspace\\course\\src\\main\\webapp\\resources\\images\\user\\";

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getIndex(){
        return "index";
    }
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String getMain(){
        return "main";
    }
    @RequestMapping(value = "/mainPicture", method = RequestMethod.GET)
    public String getMainPicture(){
        return "mainPictureList";
    }
    @RequestMapping(value = "/info", method = RequestMethod.GET)
    public String getUserInfo(){
        return "userMsg";
    }
    @RequestMapping(value = "/article", method = RequestMethod.GET)
    public String insertArticle(){
        return "editorArticle";
    }
    @RequestMapping(value = "/userInfo", method = RequestMethod.GET)
    public String getTeacherInfo(){
        return "userInfo";
    }
    @RequestMapping(value = "/noticeList", method = RequestMethod.GET)
    public String getNoticeList(){
        return "noticeList";
    }
    @RequestMapping(value = "/courseList", method = RequestMethod.GET)
    public String getCourseList(){
        return "courseList";
    }
    @RequestMapping(value = "/coursePage", method = RequestMethod.GET)
    public String getCoursePage(){
        return "coursePage";
    }
    @RequestMapping(value = "/articlePage", method = RequestMethod.GET)
    public String getArticlePage(){
        return "articlePage";
    }
    @RequestMapping(value = "/articleList", method = RequestMethod.GET)
    public String getArticleList(){
        return "articleList";
    }
    @RequestMapping(value = "/articleContent", method = RequestMethod.GET)
    public String getArticleContent(){
        return "articleContent";
    }
    @RequestMapping(value = "/courseStudy", method = RequestMethod.GET)
    public String getCourseStudy(){
        return "courseStudy";
    }
    @RequestMapping(value = "/courseType", method = RequestMethod.GET)
    public String getCourseType(){
        return "courseType";
    }
    @RequestMapping(value = "/userList", method = RequestMethod.GET)
    public String getUserList(){
        return "userList";
    }
    @RequestMapping(value = "/sys", method = RequestMethod.GET)
    public String getSys(){
        return "sys";
    }
    @RequestMapping(value = "/getUserInfo", method = RequestMethod.GET)
    @ResponseBody
    public UserPo queryById(HttpSession session){
        UserPo userPo=(UserPo)session.getAttribute("User");
        return userService.getById( userPo.getUserId());
    }
    @RequestMapping(value = "/queryById/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public UserPo queryByUserId(@PathVariable long userId){
     return userService.getById(userId);
    }
    @RequestMapping(value = "/login/{userName}/{password}", method = RequestMethod.GET)
    @ResponseBody
    public String  queryByUserNameAndPwd(@PathVariable("userName") String userName,@PathVariable("password") String password,HttpSession session){
        UserPo user= userService.getByUserNameAndPwd(userName,password);
        Date date = new Date();
        SimpleDateFormat fat = new SimpleDateFormat("yyyy-MM-dd");
        String loginDate=fat.format(date.getTime());
        if(user!=null){
            session.setAttribute("User",user);
            userService.loginRank(user.getUserId(),loginDate);
            return "success";
        }
        return "fail";
    }
    @RequestMapping(value = "/checkLogin", method = RequestMethod.GET)
    @ResponseBody
    public String checkLogin(HttpSession session){

         if(session.getAttribute("User")!=null){
             return "success";
         }else{
             return "fail";
         }
    }
    @RequestMapping(value = "/queryByUserCnName", method = RequestMethod.GET)
    @ResponseBody
    public List<UserPo> queryByUserCnName(@RequestParam String userCnName){
        return  userService.queryByUserCnName(userCnName);
    }
    @RequestMapping(value = "/register/{userName}/{password}/{createTime}", method = RequestMethod.GET)
    @ResponseBody
    public String  insertUser(@PathVariable("userName") String userName,@PathVariable("password") String password,@PathVariable("createTime") String createTime){
        UserPo po=new UserPo();
        po.setUserName(userName);
        po.setUserPwd(password);
        po.setCreateTime(createTime);
        if(userService.havingUser(userName)!=null){
            return "fail";
        }else{
            userService.register(po);
            return "success";
        }
    }

    @RequestMapping(value = "/changePwd", method = RequestMethod.PUT)
    @ResponseBody
    public void changePwdById(@RequestBody UserPo po){
       userService.changePwdById(po);
    }

    @RequestMapping(value = "/outLogin", method = RequestMethod.GET)
    @ResponseBody
    public String outLogin(HttpSession session){
        //通过session.invalidata()方法来注销当前的session
        session.invalidate();
        return "false";
    }

    @RequestMapping(value = "/queryList", method = RequestMethod.GET)
    @ResponseBody
    public List<UserPo> List(){
        return  userService.queryUserList();
    }
    @RequestMapping(value = "/update", method = RequestMethod.PUT)
    @ResponseBody
    public void updateUser(@RequestBody UserPo po){
        userService.updateInfo(po);
    }

    @RequestMapping(value = "/updateStatus", method = RequestMethod.PUT)
    @ResponseBody
    public void updateStatus(@RequestBody UserPo po){
        userService.updateStatus(po);
    }


    @RequestMapping(value = "/delete/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public void deleteUser(@PathVariable long userId){
        userService.deleteById(userId);
    }

    @RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
    public @ResponseBody String uploadImg(
            HttpServletRequest request,
            @RequestParam(value = "file") MultipartFile multipartFile,
            HttpServletResponse response){
        String sqlPath = null;
        String filename=null;
        String uuid = UUID.randomUUID().toString().replaceAll("-","");
        String contentType=multipartFile.getContentType();
        String suffixName=contentType.substring(contentType.indexOf("/")+1);
        filename=uuid+"."+suffixName;
        try {
            multipartFile.transferTo(new File(localPath+filename));
        } catch (IOException e) {
            e.printStackTrace();
        }
        sqlPath = "/photo/user/"+filename;
        return sqlPath;
    }
}
