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
                <el-input v-model="userCnName" placeholder="输入用户昵称"></el-input>
                </el-col>
                <el-button type="primary" @click="search">搜索</el-button>
            </el-row>
            <el-table
                    :data="tableData.slice((currentPage-1)*pagesize,currentPage*pagesize)"

                    style="width: 100%">
                <el-table-column
                        prop="userName"
                        label="用户名"
                >
                </el-table-column>
                <el-table-column
                        prop="userCnName"
                        label="用户昵称"
                       >
                </el-table-column>
                <el-table-column
                        prop="sex"
                        label="性别"
                        >
                </el-table-column>
                <el-table-column
                        prop="address"
                        label="居住地"
                >
                </el-table-column>
                <el-table-column
                        prop="occupation"
                        label="所在行业"
                >
                </el-table-column>
                <el-table-column
                        prop="phone"
                        label="联系电话"
                >
                </el-table-column>
                <el-table-column
                        prop="email"
                        label="邮箱"
                >
                </el-table-column>
                <el-table-column
                        prop="roleId"
                        label="角色"

                >
                    <template slot-scope="scope"   >
                        <el-tag type="success"  v-if="scope.row.roleId==1">普通用户</el-tag>
                        <el-tag  v-if="scope.row.roleId==2">管理员用户</el-tag>
                    </template>
                </el-table-column>

                <el-table-column
                        prop="createTime"
                        label="注册时间"
                >
                </el-table-column>
                <el-table-column
                        prop="lastLogin"
                        label="上次登录"
                >
                </el-table-column>
                <el-table-column
                        label="账号状态"  prop="status"
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
                        <el-button @click="openForm(scope.row)" type="text" size="small">修改</el-button>
                        <el-button type="text" size="small"  @click="deleteMsg(scope.row)">删除</el-button>
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
        <el-dialog title="修改用户" :visible.sync="dialogFormVisible" width="600px">
            <el-form :model="paramData"  ref="paramData">
                <el-form-item label="用户角色" :label-width="formLabelWidth">
                    <el-select v-model="paramData.roleId" placeholder="请选择课程类别">
                        <el-option v-for="(item, index) in role" :key="index" :label="item.label" :value="item.value"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="账号状态" :label-width="formLabelWidth">
                        <el-switch
                                v-model="paramData.status"
                                active-color="#13ce66"
                                inactive-color="#ff4949"
                                active-value="1"
                                inactive-value="0">
                        </el-switch>
                    </el-tooltip>
                </el-form-item>
            </el-form>

            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false" >取 消</el-button>
                <el-button type="primary"  @click="changeUser">确 定</el-button>
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
                formLabelWidth:'120px',
                dialogFormVisible:false,
                tableData: [],
                userInfo:{},
                paramData:{
                    userId:'',
                    status:'',
                    roleId:'',
                },
                role:[
                    {
                        label:"普通用户",
                        value:"1",
                    },
                    {
                        label:"管理员用户",
                        value:"2",
                    }
                ],
                userCnName:'',
                pagesize:10,//每页的数据条数
                currentPage:1,//默认开始页面
            };
        },
        created:function(){
            this.getContextPath();
            this.initData();
        },
        methods: {
            getContextPath:function(){
                this.contextPath ="/"
            },
            initData:function () {
                var self=this;
                self.getUserList();
            },
            search:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/queryByUserCnName?userCnName="+self.userCnName).then(function(res){
                    self.tableData=res.data
                });
            },
            getUserList:function(){
                var self=this;
                axios.get(this.contextPath+"api/user/queryList").then(function(res){
                    self.tableData=res.data
                });
            },
            openForm:function(row){
                var self=this;
                self.paramData.userId=row.userId;
                self.paramData.status=row.status;
                self.paramData.roleId=row.roleId;
                self.dialogFormVisible=true

            },
            changeUser:function(){
                var self=this;
                axios.put(this.contextPath+"api/user/updateStatus",self.paramData).then(function(res){
                    self.dialogFormVisible = false
                    self.$message({message:'修改成功！', type: 'success'});
                    self.getUserList()
                });
            },
            deleteMsg:function(row){
                var self=this;
                this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.get(this.contextPath+"api/user/delete/"+row.userId).then(function(res){
                        self.getUserList();
                        self.$message({message:'操作成功！', type: 'success'});
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
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
