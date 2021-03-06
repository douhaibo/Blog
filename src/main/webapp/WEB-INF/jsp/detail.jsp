<%--
  Created by IntelliJ IDEA.
  User: DouHaibo
  Date: 2019/6/5
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <title>博客--文章</title>
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico"/>
    <link href="${ctx}/css/style.css" rel="stylesheet" type="text/css" media="all">
    <link rel="stylesheet" href="${ctx}/css/animate.min.css">
    <link rel="stylesheet" href="${ctx}/plugin/editor.md-master/css/editormd.css">
    <script src="${ctx}/js/jquery-1.12.4.min.js"></script>
    <script src="${ctx}/plugin/editor.md-master/editormd.js"></script>
    <script src="${ctx}/plugin/editor.md-master/lib/marked.min.js"></script>
    <script src="${ctx}/plugin/editor.md-master/lib/prettify.min.js"></script>
    <script src="${ctx}/js/wow.min.js"></script>
    <script>
        if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
            new WOW().init();
        };
        // 当网页向下滑动 500px 出现"返回顶部" 按钮
        window.onscroll = function() {
            scrollFunction()
        };
        function scrollFunction() {
            if (document.body.scrollTop > 500 || document.documentElement.scrollTop > 20) {
                document.getElementById("btnTop").style.display = "block";
            } else {
                document.getElementById("btnTop").style.display = "none";
            }
        }
        // 点击按钮，返回顶部
        function returnTop() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
    </script>
</head>
<body>
<header>
    <div class="logo">
        <img src="${ctx}/images/head.png" class="xwcms" onmouseover="this.src='${ctx}/images/head.jpg'" onmouseout="this.src='${ctx}/images/head.png'"/>
        <div class="logo-text">小豆<span style="color:#FF6347;font-size:1.4em;">'S</span> 博客</div>
    </div>
    <div class="right-block">
        <div class="wow pulse bg-yellow" data-wow-delay="0.1s">人生，</div>
        <div class="wow rollIn bg-red" data-wow-iteration="1" data-wow-duration="0.5s">就像一盒巧克力，</div>
        <div class="wow bounceInRight bg-blue">你永远不知道下一块会是什么味道！</div>
        <div class="wow bounceInRight bg-blue">---《阿甘正传》</div>
    </div>
</header>

<nav id="nav" class="nav-wrap">
    <ul class="clearfix">
        <li>
            <a href="${ctx}/">
                首页
            </a>
        </li>

        <li class="menuactive">
            <a href="#">
                个人日记
            </a>
        </li>

        <li>
            <a href="${ctx}/about">
                关于
            </a>
        </li>

        <li id="navEnd">
            <a href="${ctx}/leaveMsg">
                留言版
            </a>
        </li>
    </ul>
</nav>

<section class="banner">
    <div class="youtiy_slider">
        <div class="bd">
            <ul>
                <li><a target="_blank" href="#"><img src="${ctx}/plugin/SuperSlide/images/1.jpg" /></a></li>
                <li><a target="_blank" href="#"><img src="${ctx}/plugin/SuperSlide/images/2.jpg" /></a></li>
                <li><a target="_blank" href="#"><img src="${ctx}/plugin/SuperSlide/images/3.jpg" /></a></li>
            </ul>
        </div>
        <div class="hd">
            <ul>
            </ul>
        </div>
        <div class="pnBtn prev"><span class="blackBg"></span> <a class="arrow" href="javascript:void(0)"></a></div>
        <div class="pnBtn next"><span class="blackBg"></span> <a class="arrow" href="javascript:void(0)"></a></div>
    </div>
</section>

<section class="container-content">
    <div class="article-content">
        <h3>${article.title}</h3>
        <div class="tt">
            <label>作者：admin</label> | <label>发布：${article.localTime}</label> | <label>浏览：${article.click}</label>
        </div>
        <div class="content">
            <div class="desci">
                简介：${article.desci}
            </div>
            <div class="essay" id="content-editormd">
                ${article.content}
            </div>
        </div>
    </div>


</section>

<div class="clear">
</div>
<div>
    <button onclick="returnTop()" id="btnTop" title="返回顶部">
        <img src="${ctx}/images/back.png" alt="">
    </button>
</div>
<footer class="footer">
    <div class="nextone">
        <c:if test="${!empty lastArticle }">
            <div ><a href="${ctx}/article/?id=${lastArticle.id}"><h4><span class="label label-primary">上一篇:${lastArticle.title}</span></h4></a></div>
        </c:if>
        <c:if test="${!empty nextArticle }">
            <div><a href="${ctx}/article/?id=${nextArticle.id}"><h4><span class="label label-success">下一篇:${nextArticle.title}</span></h4></a></div>
        </c:if>
    </div>
    <div class="footer_content">
        <h2>小豆<span style="color:#FF6347;">'S</span> 博客</h2>
        <p>由<a href="http://www.youtiy.com" target="_blank" style="color:white;text-decoration:underline;">周元俊博客</a>提供模板</p>
        <p>© 2019 xiaodou97.top, all rights reserved <a href="http://www.beian.miit.gov.cn/" target="_blank">滇ICP备19005074号</a></p>
    </div>
</footer>


<script src="${ctx}/plugin/SuperSlide/js/jquery.min.js"></script>
<!-- <script src="js/jquery-1.12.4.min.js"></script> -->
<script src="${ctx}/plugin/SuperSlide/js/superslide.2.1.js"></script>
<script type="text/javascript">
    jQuery(".youtiy_slider .bd li").first().before( jQuery(".youtiy_slider .bd li").last() );
    jQuery(".youtiy_slider").hover(function(){
        jQuery(this).find(".arrow").stop(true,true).fadeIn(300)
    },function(){
        jQuery(this).find(".arrow").fadeOut(300) });
    jQuery(".youtiy_slider").slide(
        { titCell:".hd ul", mainCell:".bd ul", effect:"leftLoop",autoPlay:true, vis:3,autoPage:true, trigger:"mouseover"}
    );

    $(document).ready(function(e) {
        var offset = 890;
        $(window).on('scroll', function(){
            if($(this).scrollTop() > offset ) {
                $('.recommend').css('position','fixed');
                $('.recommend').css('top','0px');
            }
            else {
                $('.recommend').css('position','');
            }
        });
    });
    //渲染markdown
    $(function () {
        editormd.markdownToHTML("content-editormd");
    })
</script>
</body>
</html>
