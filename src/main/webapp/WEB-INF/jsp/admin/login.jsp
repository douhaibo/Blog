<%--
  Created by IntelliJ IDEA.
  User: DouHaibo
  Date: 2019/6/7
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/assets/css/layui.css">
    <link rel="stylesheet" href="${ctx}/assets/css/login.css">
    <title>管理后台--登录</title>
    <script src="${ctx}/js/jquery-1.12.4.min.js"></script>
    <script src="${ctx}/js/md5.js"></script>
</head>
<body class="login-wrap">
<div class="login-container">
    <form class="login-form">
        <div class="input-group">
            <input type="text" id="username" class="input-field" name="id">
            <label for="username" class="input-label">
                <span class="label-title">用户名</span>
            </label>
        </div>
        <div class="input-group">
            <input type="password" id="password" class="input-field">
            <input type="hidden" id="password_md5" name="password">
            <label for="password" class="input-label">
                <span class="label-title">密码</span>
            </label>
        </div>
        <button type="button" class="login-button" id="loginButton">登录<i class="ai ai-enter"></i></button>
        <p style="text-align: right;color: red;position: absolute" id="info"></p>
    </form>
</div>
</body>

<script>

    $("#loginButton").click(function () {
        if($("#username").val()==''&&$("#password").val()==''){
            $("#info").text("提示:账号和密码不能为空");
        }
        else if ($("#username").val()==''){
            $("#info").text("提示:账号不能为空");
        }
        else if($("#password").val()==''){
            $("#info").text("提示:密码不能为空");
        }
        else if(isNaN($("#username").val())){
            $("#info").text("提示:账号必须为数字");
        }
        else {
            var password_input = document.getElementById('password');
            var password_md5 = document.getElementById('password_md5');

            // set password
            password_md5.value =  md5(password_input.value);

            $.ajax({
                type: "POST",
                url: "${ctx}/api/loginCheck",
                data: {
                    id:$("#username").val() ,
                    password: $("#password_md5").val()
                },
                dataType: "json",
                success: function(data) {
                    if(data.stateCode.trim() == "0") {
                        $("#info").text("提示:该用户不存在");
                    } else if(data.stateCode.trim() == "1") {
                        $("#info").text("提示:密码错误");
                    } else if(data.stateCode.trim() == "2"){
                        $("#info").text("提示:登陆成功，跳转中...");
                        window.location.href="${ctx}/admin/main";
                    }
                }
            });
        }
    })

</script>
</html>
