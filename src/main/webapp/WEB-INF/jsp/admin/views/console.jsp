<%--
  Created by IntelliJ IDEA.
  User: DouHaibo
  Date: 2019/6/7
  Time: 21:08
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
    <link rel="stylesheet" href="${ctx}/assets/css/view.css"/>
    <title></title>
</head>
<body class="layui-view-body">
<div class="layui-content">
    <div class="layui-row layui-col-space20">
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body chart-card">
                    <div class="chart-header">
                        <div class="metawrap">
                            <div class="meta">
                                <span>用户</span>
                            </div>
                            <div class="total">${admin.username}</div>
                        </div>
                    </div>

                    <div class="chart-footer">
                        <div class="field">
                            <span>上次登录</span>
                            <span>${loginLog.localTime}</span>
                        </div>
                        <div class="field">
                            <span>登录ip</span>
                            <span>${clientIp}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body chart-card">
                    <div class="chart-header">
                        <div class="metawrap">
                            <div class="meta">
                                <span>文章数</span>
                            </div>
                            <div class="total">${articleCount}</div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body chart-card">
                    <div class="chart-header">
                        <div class="metawrap">
                            <div class="meta">
                                <span>登录次数</span>
                            </div>
                            <div class="total">${loginNum}</div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="layui-col-sm6 layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body chart-card">
                    <div class="chart-header">
                        <div class="metawrap">
                            <div class="meta">
                                <span>总用户数</span>
                            </div>
                            <div class="total">126,560</div>
                        </div>
                    </div>
                    <div class="chart-body">
                        <div class="contentwrap">
                            fsdfdsf
                        </div>
                    </div>
                    <div class="chart-footer">
                        <div class="field">
                            <span>日注册量</span>
                            <span>321</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-sm12 layui-col-md12">
            <div class="layui-card">
                <div class="layui-tab layui-tab-brief">
                    <ul class="layui-tab-title">
                        <li class="layui-this">新增数</li>
                        <li>活跃度</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            dddd
                        </div>
                        <div class="layui-tab-item">
                            ddd
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/assets/layui.all.js"></script>
<script>
    var element = layui.element;
</script>
</body>
</html>
