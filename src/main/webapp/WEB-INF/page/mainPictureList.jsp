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
            height: 80px;
            width: 180px;
        }
        .picture{
            border-radius:10%;
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
            width: 360px;
            height: 180px;
            line-height: 180px;
            text-align: center;
        }
        .avatar {
            width: 360px;
            height: 180px;
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
                <el-button type="primary"@click="openInsertForm">新增轮播图</el-button>
            </el-row>
        <el-dialog title="新增轮播图" :visible.sync="dialogFormVisible">
            <el-form :model="form">
                <el-form-item label="轮播图":label-width="formLabelWidth" >
                    <el-upload
                            class="avatar-uploader"
                            action="/api/mainPicture/uploadImg"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            :before-upload="beforeAvatarUpload">
                        <img v-if="form.url" :src="form.url" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="顺序" :label-width="formLabelWidth">
                    <el-slider
                            v-model="form.sort"
                            show-input>
                    </el-slider>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="insertPicture">保 存</el-button>
            </div>
        </el-dialog>
        <el-dialog title="轮播图设置" :visible.sync="dialogChangeFormVisible" width="600px">
            <el-form :model="form"   ref="form">
                <el-form-item label="轮播图":label-width="formLabelWidth" >
                    <el-upload
                            class="avatar-uploader"
                            action="/api/mainPicture/uploadImg"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            :before-upload="beforeAvatarUpload">
                        <img v-if="form.url" :src="form.url" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="顺序" :label-width="formLabelWidth">
                    <el-slider
                            v-model="form.sort"
                            show-input>
                    </el-slider>
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
                <el-button type="primary"  @click="changePicture">确 定</el-button>
            </div>
        </el-dialog>
            <el-table
                    :data="tableData.slice((currentPage-1)*pagesize,currentPage*pagesize)"
                    style="width: 100%">
                <el-table-column
                        label="轮播图"
                        align="center"
                >
                    <template slot-scope="scope">
                        <img v-if="scope.row.url" :src="scope.row.url" class="picture">
                    </template>
                </el-table-column>
                <el-table-column
                        prop="url"
                        label="图片路径"
                        align="center"
                       >
                </el-table-column>

                <el-table-column
                        prop="sort"
                        label="轮播顺序"
                        align="center"
                >
                </el-table-column>
                <el-table-column
                        prop="createTime"
                        label="上传时间"
                        align="center"
                >
                </el-table-column>
                <el-table-column
                        prop="modifyTime"
                        label="修改时间"
                        align="center"
                >
                </el-table-column>
                <el-table-column
                        label="审核状态"
                        prop="status"
                        align="center"
                >
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.status==1">使用中</el-tag>
                        <el-tag  v-if="scope.row.status==0" type="danger">未使用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                        align="center"
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
                course:'',
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
                self.getPicture();
            },
            openInsertForm:function(){
                var self=this;
                self.form={
                    url:''
                }
                self.imageUrl=""
                self.dialogFormVisible=true
            },
            openChangeForm:function(row){
                var self=this;
                self.form=row;
                self.dialogChangeFormVisible=true
            },
            getPicture:function(){
                var self=this;
                axios.get(this.contextPath+"api/mainPicture/sysQuery").then(function(res){
                    self.tableData=res.data;
                });
            },
            handleFileSuccess(res, file){
                this.form.coursePath = res;
            },
            handleAvatarSuccess(res, file) {
                this.imageUrl = res;
                this.form.url = this.imageUrl;
            },
            deleteMsg:function(row){
                var self=this;
                this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.post(this.contextPath+"api/mainPicture/deletePicture",row).then(function(res){
                        self.getPicture();
                        self.$message({message:'操作成功！', type: 'success'});
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            insertPicture:function(){
                var self=this;
                axios.post(this.contextPath+"api/mainPicture/insertPicture",self.form).then(function(res){
                    self.dialogFormVisible = false
                    self.$message({message:'新增成功！', type: 'success'});
                    self.getPicture()
                });
            },
            changePicture:function(){
                var self=this;
                axios.put(this.contextPath+"api/mainPicture/updatePicture",self.form).then(function(res){
                    self.dialogChangeFormVisible = false
                    self.$message({message:'修改成功！', type: 'success'});
                    self.getPicture()
                });
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
            current_change:function(currentPage){
                this.currentPage = currentPage;
            }
        }
    })
</script>
</body>


</html>
