<%--
  Created by IntelliJ IDEA.
  User: DouHaibo
  Date: 2019/6/7
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/assets/css/layui.css">
    <link rel="stylesheet" href="${ctx}/assets/css/admin.css">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" />
    <title>博客后台管理</title>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header custom-header">

        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item slide-sidebar" lay-unselect>
                <a href="javascript:;" class="icon-font"><i class="ai ai-menufold"></i></a>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">Settings</a>
                <dl class="layui-nav-child">
                    <dd><a href="">帮助中心</a></dd>
                    <dd><a href="${ctx}/admin/logout">退出</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side custom-admin">
        <div class="layui-side-scroll">

            <div class="custom-logo">
                <img src="${ctx}/assets/images/logo.png" alt=""/>
                <h1>Admin Pro</h1>
            </div>
            <ul id="Nav" class="layui-nav layui-nav-tree">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe609;</i>
                        <em>主页</em>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctx}/admin/systemInfo">控制台</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe857;</i>
                        <em>文章管理</em>
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="${ctx}/admin/article/list">文章列表</a>
                        </dd>
                        <dd>
                            <a href="${ctx}/admin/article/add">添加文章</a>
                        </dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe612;</i>
                        <em>用户</em>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="views/users.html">用户组</a></dd>
                        <dd><a href="views/operaterule.html">权限配置</a></dd>
                    </dl>
                </li>
            </ul>

        </div>
    </div>

    <div class="layui-body">
        <div class="layui-tab app-container" lay-allowClose="true" lay-filter="tabs">
            <ul id="appTabs" class="layui-tab-title custom-tab"></ul>
            <div id="appTabPage" class="layui-tab-content"></div>
        </div>
    </div>

    <div class="layui-footer">
        <p>© 2019 </p>
    </div>

    <div class="mobile-mask"></div>
</div>
<script src="${ctx}/assets/layui.js"></script>
<script src="${ctx}/assets/home.js"></script>
</body>
</html>
