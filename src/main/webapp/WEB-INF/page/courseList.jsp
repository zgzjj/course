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
        .box-tabs{
            width: 1200px;
            margin-left:160px;
            margin-top:20px
        }
        .button {
            margin-top: -10px;
            float: right;
        }
    </style>
</head>
<body>
<div id="app" v-cloak>
    <div id="main">
            <el-row :gutter="20">
                <el-col :span="6">
                <el-input v-model="course" placeholder="输入课程名"></el-input>
                </el-col>
                <el-button type="primary">搜索</el-button>
                <el-button type="primary"  @click="openForm">添加课程</el-button>
            </el-row>
        <el-dialog title="添加课程" :visible.sync="dialogFormVisible" width="600px">
            <el-form :model="form"  :rules="rules" ref="form">
                <el-form-item label="课程图片":label-width="formLabelWidth" >
                    <el-upload
                            class="avatar-uploader"
                            action="/api/course/uploadImg"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            :before-upload="beforeAvatarUpload">
                        <img v-if="imageUrl" :src="imageUrl" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="课程文件":label-width="formLabelWidth" >
                    <el-upload
                            class="upload-demo"
                            drag
                            action="/api/course/uploadFile"
                            :on-success="handleFileSuccess"
                            multiple>
                        <i class="el-icon-upload"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="课程名称":label-width="formLabelWidth" prop="courseName">
                    <el-input v-model="form.courseName" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="分类" :label-width="formLabelWidth">
                    <el-select v-model="form.classify" placeholder="请选择课程类别" @change="getSubClassify">
                        <el-option v-for="(item, index) in classify" :key="index" :label="item.courseTypeName" :value="item.courseTypeCode"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="二级分类" :label-width="formLabelWidth">
                    <el-select v-model="form.subClassify" placeholder="请选择二级类别">
                        <el-option v-for="(item, index) in subClassify" :key="index" :label="item.courseTypeName" :value="item.courseTypeCode"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="课程级别" :label-width="formLabelWidth">
                    <el-select v-model="form.courseLevel" placeholder="请选择课程级别">
                        <el-option v-for="(item, index) in level" :key="index" :label="item.label" :value="item.value"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="课程概述" :label-width="formLabelWidth" prop="courseContent">
                    <el-input type="textarea" v-model="form.courseContent"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false" >取 消</el-button>
                <el-button type="primary"  @click="submitForm('form')">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="修改课程" :visible.sync="dialogChangeFormVisible" width="600px">
            <el-form :model="form"  :rules="rules" ref="form">
                <el-form-item label="课程图片":label-width="formLabelWidth" >
                    <el-upload
                            class="avatar-uploader"
                            action="/api/course/uploadImg"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            :before-upload="beforeAvatarUpload">
                        <img v-if="form.coursePhoto" :src="form.coursePhoto" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="课程文件":label-width="formLabelWidth" >
                    <el-upload
                            class="upload-demo"
                            drag
                            action="/api/course/uploadFile"
                            :on-success="handleFileSuccess"
                            multiple>
                        <i class="el-icon-upload"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="课程名称":label-width="formLabelWidth" prop="courseName">
                    <el-input v-model="form.courseName" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="分类" :label-width="formLabelWidth">
                    <el-select v-model="form.classify" placeholder="请选择课程类别" @change="getSubClassify">
                        <el-option v-for="(item, index) in classify" :key="index" :label="item.courseTypeName" :value="item.courseTypeCode"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="二级分类" :label-width="formLabelWidth">
                    <el-select v-model="form.subClassify" placeholder="请选择二级类别">
                        <el-option v-for="(item, index) in subClassify" :key="index" :label="item.courseTypeName" :value="item.courseTypeCode"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="课程级别" :label-width="formLabelWidth">
                    <el-select v-model="form.courseLevel" placeholder="请选择课程级别">
                        <el-option v-for="(item, index) in level" :key="index" :label="item.label" :value="item.value"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="课程概述" :label-width="formLabelWidth" prop="courseContent">
                    <el-input type="textarea" v-model="form.courseContent"></el-input>
                </el-form-item>
                <el-form-item label="审核状态" :label-width="formLabelWidth">
                    <el-switch
                            v-model="form.status"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="1"
                            inactive-value="0">
                    </el-switch>
                    </el-tooltip>
                </el-form-item>
            </el-form>

            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogChangeFormVisible = false" >取 消</el-button>
                <el-button type="primary"  @click="changeCourse">确 定</el-button>
            </div>
        </el-dialog>
            <el-table
                    :data="tableData.slice((currentPage-1)*pagesize,currentPage*pagesize)"
                    style="width: 100%">
                <el-table-column
                        prop="courseName"
                        label="课程名称"
                       >
                </el-table-column>
                <el-table-column
                        prop="courseContent"
                        label="课程概述"
                        >
                </el-table-column>
                <el-table-column
                        prop="subClassifyName"
                        label="课程类别"
                >
                </el-table-column>
                <el-table-column
                        prop="courseLevel"
                        label="课程等级"
                >
                    <template slot-scope="scope">
                        <el-tag  type="info">{{scope.row.courseLevel}}</el-tag>

                    </template>
                </el-table-column>
                <el-table-column
                        prop="createTime"
                        label="上传时间"
                >
                </el-table-column>
                <el-table-column
                        prop="count"
                        label="浏览次数"
                >
                </el-table-column>
                <el-table-column
                        label="审核状态"
                        prop="status"
                >
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.status==1">课程上架</el-tag>
                        <el-tag  v-if="scope.row.status==0" type="danger">课程下架</el-tag>
                    </template>
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                       >
                    <template slot-scope="scope">
                        <el-button @click="openChangeForm(scope.row)" type="text" size="small">修改</el-button>
                        <el-button type="text" size="small" @click="deleteMsg(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        <el-pagination
                layout="total, sizes, prev, pager, next, jumper"
                :page-sizes="[10, 20, 50, 100]"
                :page-size="pagesize"
                :total="tableData.length"
                @current-change="current_change">
        </el-pagination>
    </div>
</div>
<script>
    var vue = new Vue({
        el:'#app',
        data() {
            return {
                contextPath:"",
                pagesize:10,//每页的数据条数
                currentPage:1,//默认开始页面
                imageUrl: '',
                dialogFormVisible:false,
                dialogChangeFormVisible:false,
                formLabelWidth:'120px',
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
                course:'',
                rules:{
                    courseName: [
                        { required: true, message: '请输入课程名称', trigger: 'blur' },
                    ],
                    courseContent: [
                        { required: true, message: '请输入课程概述', trigger: 'blur' },
                    ],
                },
                tableData: [
                ],
                form: {
                },
                changeForm:{},
                userInfo:{},
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
                self.getClassify();
                self.getCourse();
            },
            openForm:function(){
                var self=this;
                self.form={}
                self.imageUrl=''
                self.dialogFormVisible=true
            },
            openChangeForm:function(row){
                var self=this;
                self.form=row;
                self.dialogChangeFormVisible=true
            },
            insertCourse:function(){
                var self=this;
                self.classify.forEach(function(item, index) {
                    if(item.courseTypeCode==self.form.classify){
                        self.form.classifyName=item.courseTypeName
                        self.form.courseType=item.courseTypeId
                    }
                })
                self.subClassify.forEach(function(item, index) {
                    if(item.courseTypeCode==self.form.subClassify){
                        self.form.subClassifyName=item.courseTypeName
                    }
                })
                axios.post(this.contextPath+"api/course/insertCourse",self.form).then(function(res){
                    self.$message({message:'添加成功!', type: 'success'});
                    self.dialogFormVisible=false
                    self.getCourse();
                });
            },
            getCourse:function(){
                var self=this;
                axios.get(this.contextPath+"api/course/sysQueryAll").then(function(res){
                    self.tableData=res.data;
                });
            },
            getClassify:function(){
                var self=this;
                axios.get(this.contextPath+"api/courseType/queryClassify").then(function(res){
                    self.classify=res.data;
                });
            },
            getSubClassify:function(){
                var self=this;
                axios.get(this.contextPath+"api/courseType/querySubClassifyByParent/"+self.form.classify).then(function(res){
                    self.subClassify=res.data;
                });
            },
            submitForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.insertCourse();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            handleFileSuccess(res, file){
                this.form.coursePath = res;
            },
            handleAvatarSuccess(res, file) {
                this.imageUrl = res;
                this.form.coursePhoto = this.imageUrl;
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
            deleteMsg:function(row){
                var self=this;
                this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get(this.contextPath+"api/course/deleteCourse/"+row.courseId).then(function(res){
                        self.getCourse();
                        self.$message({message:'操作成功！', type: 'success'});
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            changeCourse:function(){
                var self=this;
                axios.put(this.contextPath+"api/course/updateCourse",self.form).then(function(res){
                    self.dialogChangeFormVisible = false
                    self.$message({message:'修改成功！', type: 'success'});
                    self.getCourse()
                });
            },
            current_change:function(currentPage){
                this.currentPage = currentPage;
            }
        }
    })
</script>
</body>


</html>
