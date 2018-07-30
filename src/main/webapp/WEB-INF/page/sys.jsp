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
    <el-row class="tac">
        <el-col :span="3">
            <el-menu
                    default-active="1"
                    class="el-menu-vertical-demo"
                    @open="handleOpen"
                    @close="handleClose">
                <el-menu-item index="1"  @click="mainUrl='/api/user/userList'">
                    <i class="el-icon-setting"></i>
                    <span slot="title">人员管理</span>
                </el-menu-item>
                <el-menu-item index="2"  @click="mainUrl='/api/user/courseList'">
                    <i class="el-icon-setting"></i>
                    <span slot="title">课程管理</span>
                </el-menu-item>
                <el-menu-item index="3">
                    <i class="el-icon-setting"></i>
                    <span slot="title" >文章管理</span>
                </el-menu-item>
                <el-menu-item index="4" @click="mainUrl='/api/user/courseType'">
                    <i class="el-icon-setting"></i>
                    <span slot="title">类型管理</span>
                </el-menu-item>
                <el-menu-item index="5">
                    <i class="el-icon-setting"></i>
                    <span slot="title">广告管理</span>
                </el-menu-item>
                <el-menu-item index="6" @click="mainUrl='/api/user/noticeList'" >
                    <i class="el-icon-setting"></i>
                    <span slot="title">公告管理</span>
                </el-menu-item>
            </el-menu>
        </el-col>
        <el-col :span="21">
            <iframe :src="mainUrl" name="ifd"

                    height="800px"
                    width="100%" scrolling="no"
                    frameborder="0" ></iframe>
        </el-col>
    </el-row>
    </div>
</div>
<script>
    var vue = new Vue({
        el:'#app',
        data() {
            return {
                contextPath:"",
                userInfo:{},
                mainUrl:'/api/user/userList',
                dialogPwdVisible:false,
                isLogin:'',
                pwdForm:{
                    oldPwd:'',
                    newPwd1:'',
                    newPwd2:'',
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
                this.contextPath = "/"
            },
            initData:function () {
                var self=this;
                self.checkLogin();
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
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
            handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
        }
    })
</script>
</body>


</html>
