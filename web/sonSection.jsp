<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/6/8
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%--<meta charset="utf-8">--%>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1">--%>
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <%--<meta name="description" content="">--%>
    <%--<meta name="author" content="">--%>
    <%--<link rel="icon" href="../../favicon.ico">--%>

    <title>SonSection</title>

    <!-- Bootstrap core CSS -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>

</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top sidebar">
    <div class="container-fluid ">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">大牛带我飞吧</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/add/data">大牛带我飞吧</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/add/data">首页</a></li>
                <li><a href="/section/get/userSection">管理版块</a></li>


                <li><a href="${pageContext.request.contextPath}/addFG.jsp">创建朋友圈</a></li>
                <li><a href="${pageContext.request.contextPath}/friendgroup/searchAllFG.do">我的朋友圈</a></li>
                <li><a href="${pageContext.request.contextPath}/post.jsp">发帖</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">${username}<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/PersonalCenter.jsp">个人中心</a></li>

                        <li><a href="/siteinfo/showAllreceiveInfo.do">站内信</a></li>
                        <li><a href="/user/logoff">退出</a></li>

                    </ul>
                </li>
                <c:if test="${empty username}">
                    <li><a href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/register.jsp">注册 </a></li>
                </c:if>
                <li><a href="/users/admin">后台管理</a></li>

            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>




<div class="container" style="padding-top: 80px">

    <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
            <c:if test="${showIndexSect=='1'}">
                <center><h2>子版块</h2></center>
                <c:forEach items="${cwdPostList}" var="post">
                    <div class="" style="background-color: beige">
                        <h3><strong><a href="/get/Post?cwdPostId=${post.get_id()}">${post.getPostTitle()}</a></strong>&nbsp;&nbsp;|浏览量：${post.getPostPageView()}|发帖人：${post.getPostUname()}</h3>
                    </div>

                </c:forEach>
            </c:if>
            <c:if test="${showIndexSect=='2'}">
                <center><h2>专题</h2></center>
                <c:forEach items="${cwdPostList}" var="post">
                    <div class="" style="background-color: beige">
                        <h3><strong><a href="/get/Post?cwdPostId=${post.get_id()}">${post.getPostTitle()}</a></strong>&nbsp;&nbsp;|浏览量：${post.getPostPageView()}|发帖人：${post.getPostUname()}</h3>
                    </div>

                </c:forEach>
            </c:if>
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-sm-3" >

            <div class="row-sm-3 col-sm-offset-1 blog-sidebar">

                <div class="sidebar-module sidebar-module-inset">
                    <h4>热帖</h4>
                    <ol class="list-unstyled">
                        <c:forEach items="${hotPostList}" var="hotPost">
                            <a href="/get/Post?cwdPostId=${hotPost.get_id()}"> <li>${hotPost.getPostTitle()}</li></a>
                        </c:forEach>
                    </ol>
                </div>


            </div>
        </div>


    </div>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

