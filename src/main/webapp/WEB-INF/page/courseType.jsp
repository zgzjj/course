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
        .avatar {
            width: 178px;
            height: 178px;
            border-radius: 6px;
            vertical-align:top;
        }
        .article-type--card{
            margin:20px auto;
            width:70%;
        }
        .box-card {
            width: 560px;
            margin-left:80px;
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
        <div>
            <el-radio-group v-model="typeRadio" style="margin:20px 80px">
                <el-radio-button label="1">课程类别</el-radio-button>
                <el-radio-button label="2">文章类别</el-radio-button>
            </el-radio-group>
        </div>
        <el-row :gutter="20" v-if="typeRadio==2">
            <el-card class="article-type--card">
                <div slot="header" class="clearfix">
                    <span>文章分类</span>
                    <el-button style="float: right; padding: 3px 0" type="text" @click="openArticleTypeForn">添加分类</el-button>
                </div>
                <el-table
                        :data="tableData3"

                        style="width: 100%">
                    <el-table-column
                            prop="articleTypeName"
                            label="名称"
                    >
                    </el-table-column>
                    <el-table-column
                            prop="articleTypeCode"
                            label="关键字"
                    >
                    </el-table-column>
                    <el-table-column
                            label="状态"  prop="status"
                    >
                        <template slot-scope="scope">
                            <el-tag v-if="scope.row.status==1">已启用</el-tag>
                            <el-tag  v-if="scope.row.status==0" type="danger">已禁用</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column
                            fixed="right"
                            label="操作"
                    >
                        <template slot-scope="scope">
                            <el-button @click="changeArticleTypeForm(scope.row)" type="text" size="small">修改</el-button>
                            <el-button type="text" size="small"  @click="deleteArticleType(scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-card>
            <el-dialog title="添加文章分类" :visible.sync="articleTypeForm" width="600px">
                <el-form :model="articleTypeData" :rules="rules2" ref="articleTypeData">
                    <el-form-item label="文章分类名" :label-width="formLabelWidth" prop="articleTypeName">
                        <el-input v-model="articleTypeData.articleTypeName"  auto-complete="off"></el-input>
                    </el-form-item>

                    <el-form-item label="分类关键字" :label-width="formLabelWidth" prop="articleTypeCode">
                        <el-input v-model="articleTypeData.articleTypeCode"  auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="顺序" :label-width="formLabelWidth">
                        <el-slider
                                v-model="articleTypeData.sort"
                                show-input>
                        </el-slider>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="articleTypeForm = false" >取 消</el-button>
                    <el-button type="primary"   @click="submitArticleTypeForm('articleTypeData')">确 定</el-button>
                </div>
            </el-dialog>
            <el-dialog title="修改文章分类" :visible.sync="articleTypeChangeForm" width="600px">
                <el-form :model="articleTypeChangeData" :rules="rules2" ref="articleTypeChangeData">
                    <el-form-item label="分类名" :label-width="formLabelWidth" prop="courseTypeName">
                        <el-input v-model="articleTypeChangeData.articleTypeName"  auto-complete="off"></el-input>
                    </el-form-item>

                    <el-form-item label="关键字" :label-width="formLabelWidth" prop="courseTypeCode">
                        <el-input v-model="articleTypeChangeData.articleTypeCode"  auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="状态" :label-width="formLabelWidth">
                        <el-switch
                                v-model="articleTypeChangeData.status"
                                active-color="#13ce66"
                                inactive-color="#ff4949"
                                active-value="1"
                                inactive-value="0">
                        </el-switch>
                        </el-tooltip>
                    </el-form-item>
                    <el-form-item label="顺序" :label-width="formLabelWidth">
                        <el-slider
                                v-model="articleTypeChangeData.sort"
                                show-input>
                        </el-slider>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="resetForm('articleTypeChangeData')" >取 消</el-button>
                    <el-button type="primary"   @click="submitArticleTypeChangeForm('articleTypeChangeData')">确 定</el-button>
                </div>
            </el-dialog>
        </el-row>
        <el-row :gutter="20" v-if="typeRadio==1">
            <el-col :span="6">
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span>一级分类</span>
                <el-button style="float: right; padding: 3px 0" type="text" @click="openClassifyForm">添加分类</el-button>
            </div>
            <el-table
                    :data="tableData"

                    style="width: 100%">
                <el-table-column
                        prop="courseTypeName"
                        label="名称"
                       >
                </el-table-column>
                <el-table-column
                        prop="courseTypeCode"
                        label="关键字"
                        >
                </el-table-column>
                <el-table-column
                        label="状态"  prop="status"
                >
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.status==1">已启用</el-tag>
                        <el-tag  v-if="scope.row.status==0" type="danger">已禁用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                       >
                    <template slot-scope="scope">
                        <el-button @click="changeClassifyForm(scope.row)" type="text" size="small">修改</el-button>
                        <el-button type="text" size="small"  @click="deleteMsg(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
            </el-col>
            <el-col :span="6" :offset="5">
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span>二级分类</span>
                <el-button style="float: right; padding: 3px 0" type="text" @click="openSubClassifyForm">添加分类</el-button>
            </div>
            <el-table
                    :data="tableData2"

                    style="width: 100%">
                <el-table-column
                        prop="courseTypeName"
                        label="名称"
                >
                </el-table-column>
                <el-table-column
                        prop="courseTypeCode"
                        label="关键字"
                >
                </el-table-column>
                <el-table-column
                        prop="parentCode"
                        label="一级关键字"
                >
                </el-table-column>
                <el-table-column
                        label="状态"  prop="status"
                >
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.status==1">已启用</el-tag>
                        <el-tag  v-if="scope.row.status==0" type="danger">已禁用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                >
                    <template slot-scope="scope">
                        <el-button @click="changeSubClassifyForm(scope.row)" type="text" size="small">修改</el-button>
                        <el-button type="text" size="small" @click="deleteMsg(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
            </el-col>
        </el-row>
        <el-dialog title="添加一级分类" :visible.sync="classifyForm" width="600px">
            <el-form :model="paramData" :rules="rules" ref="paramData">
                <el-form-item label="分类名" :label-width="formLabelWidth" prop="courseTypeName">
                    <el-input v-model="paramData.courseTypeName"  auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="关键字" :label-width="formLabelWidth" prop="courseTypeCode">
                    <el-input v-model="paramData.courseTypeCode"  auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="顺序" :label-width="formLabelWidth">
                    <el-slider
                            v-model="paramData.sort"
                            show-input>
                    </el-slider>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="classifyForm = false" >取 消</el-button>
                <el-button type="primary"   @click="submitForm('paramData')">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="添加二级分类" :visible.sync="subClassifyForm" width="600px">
            <el-form :model="paramData" :rules="rules" ref="paramData">
                <el-form-item label="一级类别" :label-width="formLabelWidth">
                    <el-select v-model="paramData.parentCode" placeholder="请选择一级类别">
                        <el-option v-for="(item, index) in tableData" :key="index" :label="item.courseTypeName" :value="item.courseTypeCode"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="分类名" :label-width="formLabelWidth" prop="courseTypeName">
                    <el-input v-model="paramData.courseTypeName"  auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="关键字" :label-width="formLabelWidth" prop="courseTypeCode">
                    <el-input v-model="paramData.courseTypeCode"  auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="顺序" :label-width="formLabelWidth">
                    <el-slider
                            v-model="paramData.sort"
                            show-input>
                    </el-slider>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="subClassifyForm = false" >取 消</el-button>
                <el-button type="primary"   @click="submitForm('paramData')">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="修改一级分类" :visible.sync="classifyChangeForm" width="600px">
            <el-form :model="changeForm" :rules="rules" ref="changeForm">
                <el-form-item label="分类名" :label-width="formLabelWidth" prop="courseTypeName">
                    <el-input v-model="changeForm.courseTypeName"  auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="关键字" :label-width="formLabelWidth" prop="courseTypeCode">
                    <el-input v-model="changeForm.courseTypeCode"  auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="状态" :label-width="formLabelWidth">
                    <el-switch
                            v-model="changeForm.status"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="1"
                            inactive-value="0">
                    </el-switch>
                    </el-tooltip>
                </el-form-item>
                <el-form-item label="顺序" :label-width="formLabelWidth">
                    <el-slider
                            v-model="changeForm.sort"
                            show-input>
                    </el-slider>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="resetForm('changeForm')" >取 消</el-button>
                <el-button type="primary"   @click="submitChangeForm('changeForm')">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="修改二级分类" :visible.sync="subClassifyChangeForm" width="600px">
            <el-form :model="changeForm" :rules="rules" ref="changeForm">
                <el-form-item label="二级类别" :label-width="formLabelWidth">
                    <el-select v-model="changeForm.parentCode" placeholder="请选择一级类别">
                        <el-option v-for="(item, index) in tableData" :key="index" :label="item.courseTypeName" :value="item.courseTypeCode"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="分类名" :label-width="formLabelWidth" prop="courseTypeName">
                    <el-input v-model="changeForm.courseTypeName"  auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="关键字" :label-width="formLabelWidth" prop="courseTypeCode">
                    <el-input v-model="changeForm.courseTypeCode"  auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="状态" :label-width="formLabelWidth">
                    <el-switch
                            v-model="changeForm.status"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="1"
                            inactive-value="0">
                    </el-switch>
                    </el-tooltip>
                </el-form-item>
                <el-form-item label="顺序" :label-width="formLabelWidth">
                    <el-slider
                            v-model="changeForm.sort"
                            show-input>
                    </el-slider>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="subClassifyForm = false" >取 消</el-button>
                <el-button type="primary"   @click="submitChangeForm('changeForm')">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</div>
<script>
    var vue = new Vue({
        el:'#app',
        data() {
            return {
                contextPath:"",
                articleTypeForm:false,
                articleTypeChangeForm:false,
                subClassifyChangeForm:false,
                classifyChangeForm:false,
                classifyForm:false,
                subClassifyForm:false,
                formLabelWidth:'120px',
                typeRadio:'1',
                paramData:{
                    courseTypeName:'',
                    courseTypeCode:'',
                    parentCode:'',
                    sort:0,
                },
                articleTypeData:{},
                articleTypeChangeData:{},
                changeForm:{},
                rules:{
                    courseTypeName: [
                        { required: true, message: '请输入分类名', trigger: 'blur' },
                    ],
                    courseTypeCode: [
                        { required: true, message: '请输入关键字', trigger: 'blur' },
                    ],
                },
                rules2:{
                    articleTypeName: [
                        { required: true, message: '请输入分类名', trigger: 'blur' },
                    ],
                    articleTypeCode: [
                        { required: true, message: '请输入关键字', trigger: 'blur' },
                    ],
                },
                tableData: [
                ],
                tableData2: [
                ],
                tableData3: [
                ],
                userInfo:{},
            };
        },
        created:function(){
            this.getContextPath();
            this.initData();
        },
        methods: {
            getContextPath:function(){
                this.contextPath = "/";
            },
            initData:function () {
                var self=this;
                self.getUserInfo();
                self.getArticleType();
                self.getClassify();
                self.getSubClassify();
            },
            getUserInfo:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/getUserInfo").then(function(res){
                    self.userInfo=res.data;
                });
            },
            getClassify:function(){
                var self=this;
                axios.get(this.contextPath+"api/courseType/queryClassify").then(function(res){

                    self.tableData=res.data;
                });
            },
            getSubClassify:function(){
                var self=this;
                axios.get(this.contextPath+"api/courseType/querySubClassify").then(function(res){
                    self.tableData2=res.data;
                });
            },
            openArticleTypeForn:function(){
                var self=this;
                self.articleTypeData={}
                self.articleTypeForm=true
            },
            openClassifyForm:function(){
                var self=this;
                self.paramData={
                    courseTypeName:'',
                    courseTypeCode:'',
                    parentCode:'',
                    sort:0,
                }
                self.classifyForm=true
            },
            openSubClassifyForm:function(){
                var self=this;
                self.paramData={
                    courseTypeName:'',
                    courseTypeCode:'',
                    parentCode:'',
                    sort:0,
                }
                self.subClassifyForm=true
            },
            changeArticleTypeForm:function(row){
                var self=this;
                self.articleTypeChangeForm=true;
                self.articleTypeChangeData=row;
            },
            changeClassifyForm:function(row){
                var self=this;
                self.classifyChangeForm=true
                self.changeForm=row;
            },
            changeSubClassifyForm:function(row){
                var self=this;
                self.subClassifyChangeForm=true
                self.changeForm=row;
            },
            getArticleType:function(){
                var self=this;
                axios.get(this.contextPath+"api/articleType/sysQueryAll").then(function(res){
                    self.tableData3=res.data;
                });
            },
            insertArticleType:function(){
                var self=this;
                axios.post(this.contextPath+"api/articleType/insertArticleType",self.articleTypeData).then(function(res){
                    self.articleTypeForm = false
                    self.getArticleType()
                    self.$message({message:'添加成功！', type: 'success'});
                });
            },
            insertCourseType:function(){
                var self=this;
                axios.post(this.contextPath+"api/courseType/insertCourseType",self.paramData).then(function(res){
                    self.classifyForm = false
                    self.subClassifyForm=false
                    self.getClassify()
                    self.getSubClassify()
                    self.$message({message:'添加成功！', type: 'success'});
                });
            },
            changeCourseType:function(){
                var self=this;
                axios.put(this.contextPath+"api/courseType/updateCourseType",self.changeForm).then(function(res){
                    self.classifyChangeForm = false
                    self.subClassifyChangeForm = false
                    self.getClassify()
                    self.getSubClassify()
                    self.$message({message:'修改成功！', type: 'success'});
                });
            },
            changeArticleType:function(){
                var self=this;
                axios.put(this.contextPath+"api/articleType/updateArticleType",self.articleTypeChangeData).then(function(res){
                    self.articleTypeChangeForm = false
                    self.getArticleType()
                    self.$message({message:'修改成功！', type: 'success'});
                });
            },
            submitForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.insertCourseType();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            submitArticleTypeForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.insertArticleType();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            submitChangeForm(formName) {
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.changeCourseType();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            submitArticleTypeChangeForm(formName ){
                var self=this;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        self.changeArticleType();
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            resetForm(formName) {
                var self=this
                self.$refs[formName].resetFields();
                self.classifyChangeForm=false
                self.subClassifyChangeForm = false
            },
            deleteArticleType:function(row){
                var self=this;
                this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get(this.contextPath+"api/articleType/deleteById/"+row.articleTypeId).then(function(res){
                        self.getArticleType()
                        self.$message({message:'操作成功！', type: 'success'});
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            deleteMsg:function(row){
                var self=this;
                this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.post(this.contextPath+"api/courseType/deleteCourseType",row).then(function(res){
                        self.getClassify()
                        self.getSubClassify()
                        self.$message({message:'操作成功！', type: 'success'});
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

        }
    })
</script>
</body>


</html>
