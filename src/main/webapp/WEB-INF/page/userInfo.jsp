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
            width: 178px;
            height: 178px;
            line-height: 178px;
            text-align: center;
        }
        .avatar {
            width: 178px;
            height: 178px;
            display: block;
        }
        .photo {
            width: 178px;
            height: 178px;
            border-radius: 6px;
            vertical-align:top;
        }
        .box-card {
            width: 80%;
            margin:20px auto;
        }
        .box-tabs{
            width: 80%;
            margin:20px auto;
        }
        .button {
            margin-top: -10px;
            float: right;
        }
        .collection-card{
            color: #000034;
            background-color: #ffffff;
            height:120px;
            margin-top:10px;
            border: 1px solid #E7ECF3;
        }
        .course-card-img{
            float:left;
            height: 120px;
            width: 160px;
        }
    </style>
</head>
<body>
<div id="app" v-cloak>
    <div id="main">
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
        <el-card class="box-card">
            <div style="width:200px;float:left">
            <img v-if="teacherInfo.photo" :src="teacherInfo.photo" class="photo">
            </div>
            <div  style="width:940px;float:left">
            <span style="font-size: 24px;font-weight:bold;margin-left:8px;line-height:36px">{{teacherInfo.userCnName}}</span><br/>
                <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:36px">性别：{{teacherInfo.sex}}</span><br/>
                <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:36px">居住地：{{teacherInfo.address}}</span><br/>
                <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:36px">所在行业：{{teacherInfo.occupation}}</span><br/>
            <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:24px">简介：{{teacherInfo.content}}</span>
            </div>
            <el-tooltip class="item" effect="dark" :content="followItem"  placement="right">
            <el-button type="primary"  class="button" plain @click="doFollow">{{isfollowed?'已关注':'关注'}}</el-button>
            </el-tooltip>
        </el-card>
        <el-tabs type="border-card" class="box-tabs">
            <el-tab-pane label="他的课程">
                <div  class="collection-card" v-for="(data,index) in courseList">
                    <img  :src="data.coursePhoto"  class="course-card-img">
                    <a style="float: left;margin-left:20px;margin-top:10px;font-size: 24px;width:800px" @click="window.open('/api/user/courseStudy?courseId='+data.courseId)">{{data.courseName}}</a>
                    <span style="font-size: 13px;margin-top:50px;color: #999;float: left;margin-left:20px;">分类：{{data.classifyName}}&nbsp;&nbsp;-&nbsp;&nbsp;难度：{{data.courseLevel}}&nbsp;&nbsp;-&nbsp;&nbsp;点击量：{{data.count}}</span>
                </div>
            </el-tab-pane>
            <el-tab-pane label="他的文章">他的文章</el-tab-pane>
            <el-tab-pane label="关注列表">他注列表</el-tab-pane>
        </el-tabs>
    </div>
</div>
<script>
    var vue = new Vue({
        el:'#app',
        data() {
            return {
                contextPath:"",
                photo:'',
                imageUrl: 'https://fuss10.elemecdn.com/3/63/4e7f3a15429bfda99bce42a18cdd1jpeg.jpeg?imageMogr2/thumbnail/360x360/format/webp/quality/100',
                dialogFormVisible:false,
                dialogRegFormVisible:false,
                dialogPwdVisible:false,
                formLabelWidth:'120px',
                isLogin:'',
                isfollowed:false,
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
                followItem:'点击关注用户',
                courseList:[],
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
                userInfo:{},
                teacherInfo:{},
            };
        },
        created:function(){
            this.getContextPath();
            this.initData();
        },
        methods: {
            getContextPath:function(){
                this.contextPath = '/'
            },
            initData:function () {
                var self=this;
                self.checkLogin();
                self.getTeacherInfo()
                self.getUserInfo()
            },
            getTeacherInfo:function(){
                var self=this;
                var url = window.location.href;
                var userId=url.split('=')[1];
                axios.get(this.contextPath+"api/user/queryById/"+userId).then(function(res){
                    self.teacherInfo=res.data;
                    self.getCourseList();
                });
            },
            getUserInfo:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/getUserInfo").then(function(res){
                    self.userInfo=res.data;
                    self.isFollow();
                });
            },
            getCourseList:function(){
                var self=this;
                axios.get(this.contextPath+"api/course/queryByUser/"+self.teacherInfo.userId).then(function(res){
                    self.courseList=res.data.courseList;
                });
            },

            outLogin:function(){
                var self=this;
                axios.get(this.contextPath+"course/user/outLogin").then(function(res){
                    self.isLogin=res.data;
                    location.href='/api/user/main'
                });
            },
            checkLogin:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/checkLogin").then(function(res){
                    console.log(res.data)
                    if(res.data=='success'){
                        self.isLogin=true

                    }else{
                        self.isLogin=false
                    }
                });
            },
            setItem:function(){
                var self=this;
                if(self.isfollowed){
                    self.followItem='点击取消关注'
                }else{
                    self.followItem='点击关注用户'
                }
            },
            isFollow:function(){
                var self=this;
                var param={
                    userId:self.userInfo.userId,
                    beFollowUser:self.teacherInfo.userId
                }
                axios.post(this.contextPath+"api/follow/isFollow",param).then(function(res){
                    if(res.data=='success'){
                        self.isfollowed=true;
                    }
                    if(res.data=='fail'){
                        self.isfollowed=false;
                    }
                    self.setItem();
                });
            },
            doFollow:function(){
                var self=this;
                if(!self.isLogin){
                    self.$message.error('请先登录！');
                }else {
                    if (self.isfollowed) {
                        self.deleteFollow()
                    } else {
                        self.insertFollow()
                    }
                }
            },
            insertFollow:function(){
                var self=this;
                var param={
                    userId:self.userInfo.userId,
                    beFollowUser:self.teacherInfo.userId
                }
                axios.post(this.contextPath+"api/follow/insertFollow",param).then(function(res){
                    self.$message({message:'已关注！', type: 'success'});
                    self.isFollow()
                });
            },
            deleteFollow:function(){
                var self=this;
                var param={
                    userId:self.userInfo.userId,
                    beFollowUser:self.teacherInfo.userId
                }
                axios.post(this.contextPath+"api/follow/deleteFollow",param).then(function(res){
                    self.$message({message:'取消关注！', type: 'success'});
                    self.isFollow()
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
