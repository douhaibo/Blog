<%--
  Created by IntelliJ IDEA.
  User: DouHaibo
  Date: 2019/6/7
  Time: 23:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="${ctx}/assets/css/layui.css">
    <link rel="stylesheet" href="${ctx}/assets/css/view.css" />
    <link rel="stylesheet" href="${ctx}/plugin/editor.md-master/css/editormd.css"/>
    <script src="${ctx}/js/jquery-1.12.4.min.js"></script>
    <script src="${ctx}/plugin/editor.md-master/editormd.min.js"></script>
    <title></title>
</head>
<body class="layui-view-body">
<div class="layui-content">
    <div class="layui-row">
        <div class="layui-card">
            <div class="layui-card-header">写文章</div>
            <div style="position: relative;top: 10%">
                <c:if test="${!empty success}">
                    <div class="alert alert-success" role="alert">
                            ${success}
                    </div>
                </c:if>
                <c:if test="${!empty error}">
                    <div class="alert alert-danger" role="alert">
                            ${error}
                    </div>
                </c:if>
            </div>
            <form class="layui-form layui-card-body" action="${ctx}/admin/article/add/do" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">标题</label>
                    <div class="layui-input-block">
                        <input type="text" name="title" required lay-verify="required" placeholder="请输入标题"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">栏目</label>
                    <div class="layui-input-block">
                        <select name="catalogId" lay-verify="required">
                            <option value=""></option>
                            <option value="0">学习</option>
                            <option value="1">生活</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">关键字</label>
                    <div class="layui-input-block">
                        <input type="text" name="keywords" required lay-verify="required" placeholder="请输入关键字"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">选择封面</label>
                    <div class="layui-upload">
                        <button type="button" class="layui-btn" id="test1"  style="float: left;">上传图片</button>
                        <p id="demoText"></p>
                    </div>
                    <input type="hidden" name="pic" id="pic"/>
                </div>

                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">简介</label>
                    <div class="layui-input-block">
                        <textarea name="describe" placeholder="请输入简介" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">内容</label>
                    <div id="content-editormd" class="form-group">
                        <textarea style="display:none;" class="form-control" id="content-editormd-markdown-doc" name="content-editormd-markdown-doc"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-blue" lay-submit lay-filter="formDemo">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${ctx}/assets/layui.all.js"></script>
<script>
    var form = layui.form
        , layer = layui.layer;
    $(function() {
        editormd("content-editormd", {
            width   : "90%",
            height  : 500,
            syncScrolling : "single",
            path    : "${ctx}/plugin/editor.md-master/lib/",
            saveHTMLToTextarea : true, // 保存HTML到Textarea
            imageUpload : true,
            imageFormats: ["jpg","jpeg","gif","png","bmp","webp"],
            imageUploadURL: "${ctx}/admin/upload"
        });
    });
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '${ctx}/admin/uploadFM'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功
                else if(res.code === 0){
                    document.getElementById("pic").value=res.data.src;
                    console.log(res.data.src);
                    return layer.msg('上传成功');
                }
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });
    })
</script>
</body>
</html>
