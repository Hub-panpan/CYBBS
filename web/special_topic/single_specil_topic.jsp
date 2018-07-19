<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>

</head>
<title>特别专题</title>

<body>

<!-- Static navbar -->
<%--<nav class="navbar navbar-default navbar-static-top">--%>
<nav class="navbar navbar-inverse navbar-fixed-top sidebar" >
    <div class="container-fluid ">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">山科大ＢＢＳ</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/add/data">山科大ＢＢＳ</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/add/data">首页</a></li>
                <li><a href="#about">管理版块</a></li>
                <li><a href="/get/TempSectionList">我的专题</a></li>
                <li><a href="${pageContext.request.contextPath}/addTempSection.jsp">开设专题</a></li>
                <li><a href="${pageContext.request.contextPath}/addFG.jsp">创建朋友圈</a></li>
                <li><a href="${pageContext.request.contextPath}/friendgroup/searchAllFG.do">我的朋友圈</a></li>
                <li><a href="${pageContext.request.contextPath}/post.jsp">发帖</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${username}<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/user/personal">个人中心</a></li>
                        <li><a href="#">回帖</a></li>
                        <li role="presentation"><a href="/siteinfo/showAllreceiveInfo.do?param=receive" >Messages <span class="badge">3</span></a></li>
                        <li><a href="/user/logoff">退出</a> </li>

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


                <div class="" style="background-color: beige">
                    <h2>正在进行</h2>
                </div>
                <div class="row">
                    <c:forEach items="${tempSectionList}" var="tempSection">
                        <c:if test="${tempSection.getTempSectStatu()==1}">
                            <div class="col-xs-6 col-lg-4">
                                <h3><a href="/get/TempSection?cwdTempSectionId=${tempSection.get_id()}">${tempSection.getTempSectName()}</a></h3>
                                    <%--<img  class="img-thumbnail"  style="width: 120px; height: 40px;"--%>
                                    <%--src="img/python.jpg" >--%>

                                <p>${tempSection.getTempSectDescribe()}</p>
                                    <%--<p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>--%>
                            </div><!--/.col-xs-6.col-lg-4-->

                        </c:if>
                    </c:forEach>
                </div>
                <div class="" style="background-color: beige">
                    <h2>已结束</h2>
                </div>
                <div class="row">

                        <center><h2>专题</h2></center>
                        <c:if test="${empty cwdPostList}">
                            <center><h2>该专题还没有帖子，快快去发表吧！</h2></center>
                        </c:if>
                        <c:if test="${not empty cwdPostList}">
                            <c:forEach items="${cwdPostList}" var="post">
                                <div class="" style="background-color: beige">
                                    <h3><strong>
                                        <a href="/get/Post0?cwdPostId=${post.get_id()}">
                                            标题：${post.getPostTitle()}</a>
                                    </strong>
                                        <br>帖子类型：
                                        <c:if test="${post.getPostType()==1}">
                                            普通贴|
                                        </c:if>
                                        <c:if test="${post.getPostType()==2}">
                                            积分贴(${post.getPostIntegral()}分)|
                                        </c:if>
                                        浏览量：${post.getPostPageView()}|发帖人：${post.getPostUname()}
                                        |<a href="/get/Post?cwdPostId=${post.get_id()}">
                                            查看
                                    </h3>
                                </div>

                            </c:forEach>
                        </c:if>
                        <br><br><br><br><br>

                </div>


        </div><!--/.col-xs-12.col-sm-9-->


        <div class="col-sm-3" >

            <div class="row-sm-3 col-sm-offset-1 blog-sidebar">

                <div class="sidebar-module sidebar-module-inset">
                    <h4>热帖</h4>
                    <ol class="list-unstyled">
                        <c:forEach items="${hotPostList}" var="hotPost">
                            <li><a href="/get/Post?cwdPostId=${hotPost.get_id()}">${hotPost.getPostTitle()}</a></li>
                        </c:forEach>
                    </ol>
                </div>
                <div class="sidebar-module">
                    <h4>推荐专题</h4>
                    <ol class="list-unstyled">
                        <c:forEach items="${hotTempSectList}" var="hotTempSect">
                            <li><a href="/get/TempSection?cwdTempSectionId=${hotTempSect.get_id()}">${hotTempSect.getTempSectName()}</a></li>
                        </c:forEach>
                    </ol>
                </div>
                <div class="sidebar-module">
                    <h4>推荐朋友圈</h4>
                    <ol class="list-unstyled">
                        <c:forEach items="${hotFGroupList}" var="hotFGroup">
                            <li><a href="/get/FGroup?cwdFGroupId=${hotFGroup.get_id()}">${hotFGroup.getfGName()}</a></li>
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
