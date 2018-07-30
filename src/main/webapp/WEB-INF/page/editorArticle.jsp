<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="utf-8">

<head>
    <%@include file="common/head.jsp"%>
    <script type="text/javascript" charset="utf-8" src="/utf8-jsp/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/utf8-jsp/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
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
    </style>
</head>
<body>
<div id="app" v-cloak>
    <div class="header">
        <span class="header-text">精品课程网站</span>
        <el-button type="text" class="header-button" @click="location.href='/api/user/main'">首页</el-button>
        <el-button type="text" class="header-button" @click="location.href='/api/user/coursePage'">课程</el-button>
        <el-button type="text" class="header-button">文章</el-button>
        <el-button type="text" class="header-button">广告</el-button>
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
        <el-button @click="location.href='/api/user/article'" v-if="isLogin"  type="info" size="small" style="float: right;margin-top:14px;margin-right:14px" icon="el-icon-edit" round>写文章</el-button>
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
    <div id="main"  style="background-color:#efefef;margin-top:0px">
            <div style="width:1024px;margin:0px auto;padding-top: 10px">
            <el-input v-model="articleForm.articleName"  placeholder="请输入文章标题" auto-complete="off"></el-input>
            </div>
        <script id="editor" type="text/plain" style="width:1024px;height:500px;margin:5px auto"></script>
        <div style="width:1024px;margin:20px auto">

            <el-form ref="regform" :model="form" >
            <el-row>
            <el-col :span="6">
            <el-form-item label-position="left" label="文章类型" label-width="80px">
            <el-select v-model="articleForm.articleType" placeholder="请选择文章类型">
            <el-option label="原创" value="原创"></el-option>
            <el-option label="转载" value="转载"></el-option>
            <el-option label="翻译" value="翻译"></el-option>
            </el-select>
            </el-form-item>
                </el-col>
            <el-col :span="8" :offset="1">
            <el-form-item label-position="left" label="文章分类" label-width="120px">
            <el-select v-model="articleForm.subClassify" placeholder="请选择文章分类" >
            <el-option v-for="(item, index) in articleTypeList" :key="index" :label="item.articleTypeName" :value="item.articleTypeCode"></el-option>
            </el-select>
            </el-form-item>
            </el-col>
                </el-row>
                </el-form>
            <el-button  @click="location.href='/api/user/info'">取 消</el-button>
            <el-button type="primary"  @click="submitArticle">发 布</el-button>
            </div>
<script type="text/javascript">
var ue = UE.getEditor('editor');
</script>
<script>
    var vue = new Vue({
        el:'#app',
        data() {
            return {
                contextPath:"",
                mainUrl:'/api/user/main',
                dialogFormVisible:false,
                dialogRegFormVisible:false,
                dialogPwdVisible:false,
                isLogin:'',
                articleTypeList:[],
                articleForm:{
                    articleName:'',
                },
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
                userInfo:{},
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
                this.contextPath ="/" ;
            },
            initData:function () {
                var self=this;
                self.checkLogin();
                self.getArticleType();
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
                    self.userMsg=self.userInfo
                });
            },
            getArticleType:function(){
                var self=this;
                axios.get(this.contextPath+"api/articleType/pageQueryAll").then(function(res){
                    self.articleTypeList=res.data
                });
            },
            submitArticle:function(){
              var self=this;
              if(self.articleForm.articleName==''){
                  self.$message.error('文章名为空,请输入文章名!');
              }
              //获取富文本编辑器的内容

              self.articleForm.articleContent=UE.getEditor('editor').getContent()
                axios.post(this.contextPath+"api/article/insertArticle",self.articleForm).then(function(res){
                    self.$message({message:'发布成功!', type: 'success'});
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
                    self.mainUrl='/api/user/main'
                });
            },
            handleCommand(command) {
                var self=this;
                if(command=='a'){
                    self.mainUrl="/api/user/info"
                }
                if(command=='b'){
                    self.dialogPwdVisible=true
                }
                if(command=='c'){
                    self.outLogin();
                }
                if(command=='d'){
                    self.mainUrl="/api/user/sys"
                }
            },
        }
    })
</script>
</body>


</html>
