<%--
  Created by IntelliJ IDEA.
  User: DouHaibo
  Date: 2019/6/7
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/assets/css/layui.css"  media="all">
</head>
<body>


<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
</div>

<table class="layui-table" lay-filter="demo" id="blog-list">

</table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="${ctx}/assets/layui.js" charset="utf-8"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //执行渲染
        table.render({
            elem: '#blog-list' //指定原始表格元素选择器（推荐id选择器）
            ,url: '${ctx}/admin/article/getList'
            ,height: 468 //容器高度
            ,response: {
                statusName: 'status',
                statusCode: 200,
                msgName: "message",
                countName: "totalCount"
            },
            page: true
            ,cols: [[
                {type:'checkbox', fixed: 'left'},
                {field:'id',title:'ID', width:80, sort: true, fixed: true},
                {field:'title',title:'标题', width:380},
                {field:'keywords',title:'关键字', width:120},
                {field:'localTime',title:'发布时间', width:160},
                {field:'click',title:'点击量', width:80},
                {fixed: 'right',title:'操作', width:178, align:'center', toolbar: '#barDemo'}

            ]] //设置表头

        });
        //监听表格复选框选择
        table.on('checkbox(demo)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                // layer.msg('ID：'+ data.id + ' 的查看操作');
                window.open("${ctx}/article?id="+data.id);
            } else if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        type: 'POST',
                        url: '${ctx}/api/article/del',
                        datatype:'json',
                        data:{"id":data.id},
                        success: function(data){
                            if(data['stateCode']==1){
                                layer.msg('删除成功!',{icon:1,time:1000});
                                setTimeout("window.location.reload()",1000);
                            }
                            else {
                                layer.msg('删除失败!',{icon:5,time:1000});
                            }
                        },
                        error:function(data) {
                            console.log('错误...');
                        },
                    });
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.alert('编辑行：<br>'+ JSON.stringify(data))
            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('blog-list')
                    ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('blog-list')
                    ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('blog-list');
                layer.msg(checkStatus.isAll ? '全选': '未全选')
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>

</body>
</html>
