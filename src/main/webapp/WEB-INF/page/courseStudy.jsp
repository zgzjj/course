<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="common/head.jsp"%>
    <title>精品课程网站</title>
    <style>
        html,body{width:100%;height:100%;margin:0;padding:0;}
        .header{
            width: 100%;
            height: 60px;
            background-color: #6f7180;
            padding:0px;
        }
        .header-text{
            font-size: 24px;
            color: white;
            margin-top:12px;
            margin-left:20px;
        }
        .header-button{
            font-size: 18px;
            color: white;
            margin-top:10px;
            margin-left:36px;
        }
        .header-left{
            float:right;
            margin-top:10px;
            margin-right:40px;
            color: white;
        }
        .el-carousel{
            margin-top:24px;
            margin-left:11%;
            width:78%;
            height: 600px;
        }
        .el-carousel__item h3 {
            color: #475669;
            font-size: 18px;
            opacity: 0.75;
            margin: 0;
        }
        .img-header{
            float: right;
            margin-top: 10px;
            margin-right: 40px;
        }
        .img-header img{
            border-radius:50%;
            height: 40px;
            width: 40px;
        }
        .avatar-uploader .el-upload {
            border: 1px dashed #d9d9d9;
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .avatar-uploader .el-upload:hover {
            border-color: #409EFF;
        }
        .avatar-uploader-icon {
            font-size: 28px;
            color: #8c939d;
            width: 80px;
            height: 80px;
            line-height: 80px;
            text-align: center;
        }
        .avatar {
            width: 80px;
            height: 80px;
            display: block;
        }
        .box-card {
            width: 600px;
            margin-left:160px;
            margin-top:20px;
        }
        .box-top {
            width: 100%;
        }

        .time {
            float: left;
            width: 100%;
            margin-top:4px;
            margin-bottom: 4px;
            font-size: 13px;
            color: #999;
        }

        .bottom {
            margin-top: 13px;
            line-height: 12px;
        }
        .button{
            float: right;
        }

        .image {
            height:150px;
            width: 100%;
            display: block;
        }
        .top-img{
            height:150px;
            width: 100%;
            background-image: url('/resources/images/course/top.jpg');
            background-size: 100% 100%;
        }
        .initial-video{
            width: 1000px;
            height: 600px;
            background-color: black;
            margin: 50px auto;
        }
        .initial-video video{
            width: 100%;
            height: 100%;
            object-fit: fill;
        }
        .course-title{
            color: white;
            display:block;
            font-size: 28px;
            float:left;
            width:1000px;
            margin-left:256px;
            margin-top: 36px
        }
        .course-teacher{
            float:left;
            margin-left:256px;
            margin-top: 8px;
            border-radius:50%;
            height: 50px;
            width: 50px;
        }
        .course-content{
            color: white;
            font-size: 14px;
            float:left;
            margin-top: 22px
        }
        .item {
            margin:4px;
        }
        .collection-button{
            float: left;
            margin-top:12px;
            margin-left:14px
        }
        .comment{
            color: #000034;
            background-color: #ffffff;
            width: 1000px;
            margin:0px auto;
            border: 1px solid #E7ECF3;
            overflow:hidden;
        }
        .comment-info{
            color: #000034;
            background-color: #ffffff;
            width: 980px;
            height: auto;
            margin:0px auto;
            border-top: 1px solid #E7ECF3;
            border-bottom: 1px solid #E7ECF3;
            overflow:hidden;
        }
        .comment-img{
            float: left;
            height: 40px;
            width: 40px;
            border-radius:10%;
        }
        .comment-user-name{
            float:left;
            margin-left:4px;
            margin-top:8px;
            height:32px;
            width:800px
        }
        .comment-text{
            float: left;
            width:100%;
            margin-top:4px
        }
    </style>
</head>
<body>
<div id="app" v-cloak>
    <div class="header">
        <span class="header-text">精品课程网站</span>
        <el-button type="text" class="header-button" @click="location.href='/api/user/main'">首页</el-button>
        <el-button type="text" class="header-button" @click="location.href='/api/user/coursePage'">课程</el-button>
        <el-button type="text" class="header-button" @click="location.href='/api/user/articlePage'">文章</el-button>
        <el-button type="text" class="header-left" @click="dialogRegFormVisible = true" v-if="!isLogin">注册</el-button>
        <el-button type="text" class="header-left" @click="dialogFormVisible = true" v-if="!isLogin">登录</el-button>
        <div class="img-header" v-if="isLogin">
            <el-dropdown @command="handleCommand">
                <img  :src="userInfo.photo"  class="el-dropdown-link">
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item command="a">我的主页</el-dropdown-item>
                    <el-dropdown-item command="b">密码设置</el-dropdown-item>
                    <el-dropdown-item command="d" v-if="userInfo.roleId==2">系统管理</el-dropdown-item>
                    <el-dropdown-item command="c">登出</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </div>
        <el-dialog title="用户登录" :visible.sync="dialogFormVisible" width="400px">
            <el-form :model="form" :rules="rules" ref="form">
                <el-form-item label="用户名" label-width="80px" prop="username">
                    <el-input v-model="form.username" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="密码" label-width="80px"  prop="password">
                    <el-input v-model="form.password" type="password" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false" >取 消</el-button>
                <el-button type="primary"  @click="submitForm('form')">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="用户注册" :visible.sync="dialogRegFormVisible" width="400px">
            <el-form :model="regform" :rules="rules2" ref="regform">
                <el-form-item label="用户名" label-width="80px" prop="username">
                    <el-input v-model="regform.username" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="密码" label-width="80px"  prop="password1">
                    <el-input v-model="regform.password1" type="password" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="确认密码" label-width="80px"  prop="password2">
                    <el-input v-model="regform.password2" type="password" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogRegFormVisible = false">取 消</el-button>
                <el-button type="primary"  @click="submitRegForm('regform')">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="修改密码" :visible.sync="dialogPwdVisible" width="400px">
            <el-form :model="pwdForm" :rules="rules3" ref="pwdForm">
                <el-form-item label="旧密码" label-width="120px" prop="oldPwd">
                    <el-input v-model="pwdForm.oldPwd" type="password" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="新密码" label-width="120px"  prop="newPwd1">
                    <el-input v-model="pwdForm.newPwd1" type="password" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="确认新密码" label-width="120px"  prop="newPwd2">
                    <el-input v-model="pwdForm.newPwd2" type="password" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogPwdVisible = false" >取 消</el-button>
                <el-button type="primary"  @click="submitPwdForm('form')">确 定</el-button>
            </div>
        </el-dialog>
    </div>
    <div id="main">
    <div id="top" class="top-img">
        <span class="course-title" >{{courseInfo.courseName}}</span>
        <img  :src="courseTeacherInfo.photo"  class="course-teacher"  @click="window.open('/api/user/userInfo?userId='+courseTeacherInfo.userId)">
        <span class="course-content" style="margin-left:10px;font-weight: bold" >{{courseTeacherInfo.userCnName}}</span>
        <span class="course-content" style="margin-left:40px;" >分类：{{courseInfo.classifyName}}&nbsp;&nbsp;-&nbsp;&nbsp;难度：{{courseInfo.courseLevel}}&nbsp;&nbsp;-&nbsp;&nbsp;点击量：{{courseInfo.count}}</span>
        <el-tooltip class="item" effect="dark" :content="collectItem"  placement="right">
        <el-button class="collection-button"  icon="el-icon-star-off"  type="text" @click="doCollection">{{courseCollection?'已收藏':'收藏'}}</el-button>
        </el-tooltip>
    </div>
        <div class="initial-video">
        <video  :src="courseInfo.coursePath"  controls="controls">
            <source :src="courseInfo.coursePath" type="video/mp4">
        </video>
        </div>
        <div class="comment">
            <h2 style="margin-left:4px">{{commentList.length}}条评论</h2>
            <div v-for="(o, index) in commentList" :key="o" class="comment-info">
                <img  :src="o.photo"  class="comment-img"  @click="window.open('/api/user/userInfo?userId='+o.userId)"><span class="comment-user-name" >{{o.userCnName}}</span>
                <span class="comment-text" >{{o.commentContent}}</span>
                <span class="time">{{o.createTime}}</span>
            </div>
            <div class="comment-info">
                <el-form ref="form" :model="form" label-width="80px">
                    <el-input type="textarea" placeholder="写下你的评论..." v-model="form.commentContent" @focus="commentBtn=true" style="float:left;width: 970px;margin:8px auto "></el-input>
                    <el-button type="primary" v-if="commentBtn" style="float: right;margin-right: 8px;margin-bottom: 8px" @click="insertComment">提交</el-button>
                    <el-button type="primary" v-if="commentBtn" style="float: right;margin-right: 8px;margin-bottom: 8px" @click="commentBtn=false">取消</el-button>
                    </el-row>
                </el-form>
            </div>
        </div>
        <div style="height: 50px">
        </div>
    </div>
</div>
<script>
    var vue = new Vue({
        el:'#app',
        data() {
            return {
                contextPath:"",
                imageUrl: '',
                filter:{
                    classify:'all',
                    subClassify:'all',
                    level:'all',
                },
                courseTeacherInfo:{},
                classify:[],
                subClassify:[],
                level:[
                    {
                        label:'初级',
                        value:'初级',
                    }, {
                        label:'中级',
                        value:'中级',
                    }, {
                        label:'高级',
                        value:'高级',
                    }
                ],
                courseList: [
                ],
                commentList:[],
                courseInfo:{},
                courseCollection:false,
                commentBtn:false,
                collectItem:'',
                userInfo:{},
                dialogFormVisible:false,
                dialogRegFormVisible:false,
                dialogPwdVisible:false,
                isLogin:'',
                form: {
                    username:'',
                    password:'',
                },
                regform:{
                    username:'',
                    password1:'',
                    password2:'',
                },
                pwdForm:{
                    oldPwd:'',
                    newPwd1:'',
                    newPwd2:'',
                },
                rules: {
                    username: [
                        { required: true, message: '请输入用户名', trigger: 'blur' },
                    ],
                    password: [
                        { required: true, message: '请输入密码', trigger: 'blur' },
                    ],
                },
                rules2:{
                    username: [
                        { required: true, message: '请输入用户名', trigger: 'blur' },
                    ],
                    password1: [
                        { required: true, message: '请输入密码', trigger: 'blur' },
                    ],
                    password2: [
                        { required: true, message: '请再次输入密码', trigger: 'blur' },
                    ],
                },
                rules3:{
                    oldPwd: [
                        { required: true, message: '请输入旧密码', trigger: 'blur' },
                    ],
                    newPwd1: [
                        { required: true, message: '请输入新密码', trigger: 'blur' },
                    ],
                    newPwd2: [
                        { required: true, message: '请再次输入新密码', trigger: 'blur' },
                    ],
                },
            };
        },
        created:function(){
            this.getContextPath();
            this.initData();
        },
        methods: {
            getContextPath:function(){
                this.contextPath ="/";
            },
            initData:function () {
                var self=this;
                self.checkLogin();
                self.getCourse();
            },
            getCourse:function(){
                var self=this;
                var url = window.location.href;
                var courseId=url.split('=')[1];
                axios.get(this.contextPath+"api/course/queryById/"+courseId).then(function(res){
                    self.courseInfo=res.data;
                    self.getCourseTeacher();
                    self.getCommnet();
                });
            },
            setItem:function(){
              var self=this;
              if(self.courseCollection){
                  self.collectItem='点击取消收藏'
              }else{
                  self.collectItem='点击收藏课程'
              }
            },
            isCollection:function(){
                var self=this;
                var param={
                    userId:self.userInfo.userId,
                    resourceId:self.courseInfo.courseId,
                    resourceType:'1'
                }
                axios.post(this.contextPath+"api/collection/isCollection",param).then(function(res){
                    if(res.data=='success'){
                        self.courseCollection=true;
                    }
                    if(res.data=='fail'){
                        self.courseCollection=false;
                    }
                    self.setItem();
                });
            },
            doCollection:function(){
                var self=this;
                if(!self.userInfo.userId){
                    self.$message.error('请先登录！');
                }else{
                    if(self.courseCollection){
                        self.deleteCollection()
                    }else{
                        self.insertCollection()
                    }
                }
            },
            getCommnet:function(){
                var self=this;
                param={
                    resourceId:self.courseInfo.courseId,
                    resourceType:'1'
                }
                axios.post(this.contextPath+"api/comment/queryByIdAndType",param).then(function(res){
                        self.commentList=res.data
                });
            },
            insertComment:function(){
                var self=this;
                if(!self.userInfo.userId){
                    self.$message.error('请先登录！');
                }else {
                    self.form.resourceId=self.courseInfo.courseId;
                    self.form.resourceType='1';
                    axios.post(this.contextPath + "api/comment/insertComment", self.form).then(function (res) {
                        self.$message({message: '评论成功！', type: 'success'});
                        self.form.commentContent=''
                        self.getCommnet();
                    });
                }
            },
            insertCollection:function(){
                var self=this;
                var param={
                    userId:self.userInfo.userId,
                    resourceId:self.courseInfo.courseId,
                    resourceType:'1'
                }
                axios.post(this.contextPath+"api/collection/insertCollection",param).then(function(res){
                    self.$message({message:'已收藏！', type: 'success'});
                    self.isCollection();
                });
            },
            deleteCollection:function(){
                var self=this;
                var param={
                    userId:self.userInfo.userId,
                    resourceId:self.courseInfo.courseId,
                    resourceType:'1'
                }
                axios.post(this.contextPath+"api/collection/deleteCollection",param).then(function(res){
                    self.$message({message:'取消收藏！', type: 'success'});
                    self.isCollection();
                });
            },
            getCourseTeacher:function(){
                var self=this;;
                axios.get(this.contextPath+"api/user/queryById/"+self.courseInfo.createUser).then(function(res){
                    self.courseTeacherInfo=res.data;
                });
            },
            submitRegForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.register();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            submitPwdForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.changePwd();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            submitForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.login();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            register:function(){
                var self=this;

                var userName=self.regform.username;
                var password=self.regform.password1;
                var createTime=moment().format('YYYY-MM-DD');
                axios.get(this.contextPath+"api/user/register/"+userName+"/"+password+"/"+createTime).then(function(res){
                    if(res.data=='success'){
                        self.$message({message:'注册成功！', type: 'success'});
                        self.dialogRegFormVisible=false
                        self.regform={
                            username:'',
                            password1:'',
                            password2:'',
                        }
                    }
                    if(res.data=='fail'){
                        self.$message.error('该用户名已存在！');
                    }
                });
            },
            changePwd:function(){
                var self=this;
                if(self.pwdForm.oldPwd!=self.userInfo.userPwd){
                    self.$message.error('旧密码错误！');
                }else if(self.pwdForm.newPwd1!=self.pwdForm.newPwd2){
                    self.$message.error('新密码前后输入不一致！');
                }else{
                    var param={
                        userId:self.userInfo.userId,
                        userPwd:self.pwdForm.newPwd1,
                    }
                    axios.put(this.contextPath+"api/user/changePwd",param).then(function(res){
                        self.dialogPwdVisible = false
                        self.$message({message:'修改成功！', type: 'success'});
                        self.outLogin();
                    });
                }
            },
            getUserInfo:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/getUserInfo").then(function(res){
                    self.userInfo=res.data;
                    self.isCollection();
                });
            },
            login:function(){
                var self=this;
                var userName=self.form.username;
                var password=self.form.password;
                axios.get(this.contextPath+"api/user/login/"+userName+"/"+password).then(function(res){

                    if(res.data=='success'){
                        self.userInfo=res.data;
                        self.isLogin=true;
                        self.$message({message:'登录成功!', type: 'success'});
                        self.getUserInfo();
                        self.dialogFormVisible=false;
                        self. form={
                            username:'',
                            password:'',
                        }
                    }
                    if(res.data=='fail'){
                        self.$message.error('用户名或密码错误');
                    }
                });
            },
            checkLogin:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/checkLogin").then(function(res){
                    console.log(res.data)
                    if(res.data=='success'){
                        self.isLogin=true
                        self.getUserInfo()
                    }else{
                        self.isLogin=false
                    }
                });
            },
            outLogin:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/outLogin").then(function(res){
                    self.isLogin=res.data;
                    location.href='/api/user/main'
                });
            },
            handleCommand(command) {
                var self=this;
                if(command=='a'){
                    location.href="/api/user/info"
                }
                if(command=='b'){
                    self.dialogPwdVisible=true
                }
                if(command=='c'){
                    self.outLogin();
                }
                if(command=='d'){
                    location.href="/api/user/sys"
                }
            },
        }
    })
</script>
</body>


</html>
