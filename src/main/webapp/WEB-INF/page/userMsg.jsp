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
            border: 1px;
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
        .article-card{
            color: #000034;
            background-color: #ffffff;
            width:100%;
            height:100px;
            margin:10px auto;
            border: 1px solid #E7ECF3;
        }
        .course-teacher{
            float:left;
            margin-top:24px;
            margin-left:20px;
            border-radius:50%;
            height: 30px;
            width: 30px;
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
            <div class="img-header">
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
            <el-button @click="location.href='/api/user/article'" v-if="isLogin"  type="info" size="small" style="float: right;margin-top:14px;margin-right:14px" icon="el-icon-edit" round>写文章</el-button>
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
            <img  :src="userInfo.photo" class="photo">
            </div>
            <div  style="width:940px;float:left">
            <span style="font-size: 24px;font-weight:bold;margin-left:8px;line-height:36px">{{userInfo.userCnName}}</span><br/>
                <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:36px">性别：{{userInfo.sex}}</span><br/>
                <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:36px">居住地：{{userInfo.address}}</span><br/>
                <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:36px">所在行业：{{userInfo.occupation}}</span><br/>
            <span style="font-size: 16px;font-weight:bold;margin-left:8px;line-height:24px">简介：{{userInfo.content}}</span>
            </div>
            <el-button type="primary"  class="button" plain @click="dialogFormVisible = true">编辑个人资料</el-button>
        </el-card>
        <el-dialog title="个人资料" :visible.sync="dialogFormVisible">
            <el-form :model="userMsg">
                <el-form-item label="头像":label-width="formLabelWidth" >
                <el-upload
                        class="avatar-uploader"
                        action="/api/user/uploadImg"
                        :show-file-list="false"
                        :on-success="handleAvatarSuccess"
                        :before-upload="beforeAvatarUpload">
                    <img v-if="userInfo.photo" :src="userInfo.photo" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                </el-form-item>
                <el-form-item label="昵称" :label-width="formLabelWidth">
                    <el-input v-model="userMsg.userCnName" ></el-input>
                </el-form-item>
                <el-form-item label="性别" :label-width="formLabelWidth">
                    <el-input v-model="userMsg.sex"></el-input>
                </el-form-item>
                <el-form-item label="居住地" :label-width="formLabelWidth">
                    <el-input v-model="userMsg.address"></el-input>
                </el-form-item>
                <el-form-item label="所在行业" :label-width="formLabelWidth">
                    <el-select v-model="userMsg.occupation" placeholder="请选择所在行业">
                        <el-option label="计算机" value="计算机"></el-option>
                        <el-option label="互联网" value="互联网"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="电话" :label-width="formLabelWidth">
                    <el-input v-model="userMsg.phone" ></el-input>
                </el-form-item>
                <el-form-item label="邮箱" :label-width="formLabelWidth">
                    <el-input v-model="userMsg.email" ></el-input>
                </el-form-item>
                <el-form-item label="个人简介" :label-width="formLabelWidth">
                    <el-input type="textarea" v-model="userMsg.content"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="changeInfo">保 存</el-button>
            </div>
        </el-dialog>

        <el-tabs type="border-card" class="box-tabs">
            <el-tab-pane label="课程收藏">
                <div  class="collection-card" v-for="(data,index) in collectionCourseList">
                    <img  :src="data.coursePhoto"  class="course-card-img">
                    <a style="float: left;margin-left:20px;margin-top:10px;font-size: 24px;width:800px" @click="window.open('/api/user/courseStudy?courseId='+data.courseId)">{{data.courseName}}</a>
                    <span style="font-size: 13px;margin-top:50px;color: #999;float: left;margin-left:20px;">分类：{{data.classifyName}}&nbsp;&nbsp;-&nbsp;&nbsp;难度：{{data.courseLevel}}&nbsp;&nbsp;-&nbsp;&nbsp;点击量：{{data.count}}</span>
                </div>
            </el-tab-pane>
            <el-tab-pane label="文章收藏">
                <div  class="article-card" v-for="(data,index) in collectionArticleList">
                    <a style="float: left;margin-left:20px;margin-top:10px;font-size: 24px;width:100%" @click="window.open('/api/user/articleContent?articleId='+data.articleId)">{{data.articleName}}</a>
                    <span style="float:left;margin-top:28px;margin-left:2px;font-weight: bold" >{{data.userCnName}}</span>
                    <span style="font-size: 13px;margin-top:30px;color: #999;float: left;margin-left:20px;">{{data.createTime}}&nbsp;&nbsp;&nbsp;&nbsp;类型：{{data.articleType}}&nbsp;&nbsp;-&nbsp;&nbsp;分类：{{data.classifyName}}&nbsp;&nbsp;-&nbsp;&nbsp;阅读：{{data.count}}</span>
                </div>
            </el-tab-pane>
            <el-tab-pane label="关注列表">
                <div  class="collection-card" v-for="(data,index) in followList">
                    <img  :src="data.photo"  class="course-card-img"  >
                    <a style="float: left;margin-left:20px;margin-top:10px;font-size: 24px;width:800px"@click="window.open('/api/user/userInfo?userId='+data.userId)">{{data.userCnName}}</a>
                    <span style="font-size: 13px;margin-top:50px;color: #999;float: left;margin-left:20px;">性别：{{data.sex}}&nbsp;&nbsp;-&nbsp;&nbsp;居住地：{{data.address}}&nbsp;&nbsp;-&nbsp;&nbsp;简介：{{data.content}}</span>
                </div>
            </el-tab-pane>
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
                dialogPwdVisible:false,
                formLabelWidth:'120px',
                isLogin:'',
                pwdForm:{
                    oldPwd:'',
                    newPwd1:'',
                    newPwd2:'',
                },
                collectionCourseList:[],
                collectionArticleList:[],
                followList:[],
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
                userMsg:{
                },
                userInfo:{},
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
            },
            getUserInfo:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/getUserInfo").then(function(res){
                    self.userInfo=res.data;
                    self.userMsg=self.userInfo
                    self.getCollectionResource();
                    self.getFollow();
                });
            },
            getFollow:function(){
                var self=this;
                axios.get(this.contextPath+"api/follow/queryById/"+self.userInfo.userId).then(function(res){
                    self.followList=res.data
                });
            },
            getCollectionResource:function(){
                var self=this;
                axios.get(this.contextPath+"api/collection/getCollectionByUser/"+self.userInfo.userId).then(function(res){
                    self.collectionCourseList=res.data.courseList;
                    self.collectionArticleList=res.data.articleList;
                });
            },
            changeInfo:function(){
                var self=this;

                axios.put(this.contextPath+"api/user/update",self.userMsg).then(function(res){
                    self.dialogFormVisible = false
                    self.$message({message:'修改成功！', type: 'success'});
                    self.getUserInfo()
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
                        self.getUserInfo()
                    }else{
                        self.isLogin=false
                        self.$message.error('请先登录！');
                        location.href="/api/user/main"
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
            handleAvatarSuccess(res, file) {
                this.photo = res;
                this.userMsg.photo = this.photo;
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isLt2M = file.size / 1024 / 1024 < 2;

                if (!isJPG) {
                    this.$message.error('上传头像图片只能是 JPG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 2MB!');
                }
                return isJPG && isLt2M;
            },
        }
    })
</script>
</body>


</html>
