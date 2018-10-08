package com.course.controller;

import com.course.pojo.FollowPo;
import com.course.pojo.MainPicturePo;
import com.course.pojo.UserPo;
import com.course.service.FollowService;
import com.course.service.MainPictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/api/mainPicture")
public class MainPictureController {
    @Autowired
    private MainPictureService pictureService;
    private static String localPath="F:\\IDEA-workspace\\course\\src\\main\\webapp\\resources\\images\\main\\";
    @RequestMapping(value = "/sysQuery", method = RequestMethod.GET)
    @ResponseBody
    public List<MainPicturePo> sysQuery(){
        return pictureService.sysQuery();
    }
    @RequestMapping(value = "/pageQuery", method = RequestMethod.GET)
    @ResponseBody
    public List<MainPicturePo> pageQuery(){
        return pictureService.pageQuery();
    }
    @RequestMapping(value = "/deletePicture", method = RequestMethod.POST)
    @ResponseBody
    public void deletePicture(@RequestBody MainPicturePo po){
        String filename=po.getUrl();
        String path=filename.split("/")[filename.split("/").length-1];
        File file=new File(localPath+path);
        if(file.exists()&&file.isFile()){
            file.delete();
        }
         pictureService.deletePicture(po);
    }
    @RequestMapping(value = "/insertPicture", method = RequestMethod.POST)
    @ResponseBody
    public void insert(@RequestBody MainPicturePo po){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String createTime=df.format(new Date());
        po.setCreateTime(createTime);
         pictureService.insertPicture(po);
    }
    @RequestMapping(value = "/updatePicture", method = RequestMethod.PUT)
    @ResponseBody
    public void updatePicture(@RequestBody MainPicturePo po){

        MainPicturePo p=pictureService.queryById(po.getPictureId());
        if(!p.getUrl().equals(po.getUrl())){
            String path=p.getUrl().split("/")[p.getUrl().split("/").length-1];
            File file=new File(localPath+path);
            if(file.exists()&&file.isFile()){
                file.delete();
            }
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String modifyTime=df.format(new Date());
        po.setModifyTime(modifyTime);
        pictureService.updatePicture(po);
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
        sqlPath = "/photo/main/"+filename;
        return sqlPath;
    }

}
