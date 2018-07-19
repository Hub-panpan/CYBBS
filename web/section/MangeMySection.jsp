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



                <c:if test="${empty USectionList}">
                    <center>
                        <div class="col-xs-6 col-lg-4">
                            <h2>您还没有管理的版块！</h2>
                        </div>
                    </center>
                </c:if>
                <c:if test="${not empty userInfo.getSectionList()}">
                    <c:forEach var="usection" items="${userInfo.getSectionList()}">
                        ${usection}|
                    </c:forEach>
                </c:if>


                <c:if test="${not empty USectionList}">
                    <div class="" style="background-color: beige">
                        <h2>管理版块</h2>
                    </div>
                    <div class="row">
                        <c:forEach items="${USectionList}" var="USection">
                            <div class="col-lg-3">

                                <h4>子版块数目:${USection.getSonSectionSum()}</h4>
                                <h3>
                                    版块名：${USection.getSectName()}
                                </h3>
                            </div>
                            <div class="col-lg-6">
                                <p><h3>版块描述：</h3></p>
                                <p>${USection.getSectDescribe()}</p>
                            </div>
                            <div class="col-lg-3">
                                <p> <a class="btn btn-default" href="#"
                                       style="color: #ffffff;background-color: #ffffff;border-color: #ffffff";role="button"></a>
                                </p>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <p>
                                    <button type="button" class="btn btn-primary"  data-toggle="collapse" data-target="#demo${USection.getSectName()}">
                                        管理
                                    </button>
                                    <a href="/add/SonSection01?cwdSectionId=${USection.id}">新建子版块</a>
                                </p>
                            </div>
                            <div id="demo${USection.getSectName()}" class="collapse ">
                                <table class="table">
                                    <thead>
                                    <c:if test="${not empty UsonSectionList}">
                                        <tr>
                                            <th>子版块操作</th>
                                            <th>子版块名</th>
                                            <th>查看子版块</th>
                                            <th>修改子版块</th>
                                            <th>删除子版块</th>
                                        </tr>
                                    </c:if>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${UsonSectionList}" var="UsonSection">
                                        <c:if test="${UsonSection.getfSectName()==USection.getSectName()}">
                                            <tr>
                                                <th scope="row">#</th>
                                                <td><h3><a href="/get/SonSection?cwdSonSectionId=${UsonSection.id}">${UsonSection.getSonSectName()}</a></h3></td>


                                                <td> <a class="btn btn-primary" href="/get/SonSection?cwdSonSectionId=${UsonSection.id}"
                                                        role="button">查看子版块</a></td>
                                                <td> <a class="btn btn-primary" href="/update/SonSection01?cwdSonSectionId=${UsonSection.id}"
                                                        role="button">修改子版块</a></td>
                                                <td><a class="btn btn-success" href="/delete/SonSection?cwdSonSectionId=${UsonSection.id}"
                                                       role="button">删除子版块</a></td>
                                            </tr>





                                            </li>







                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:forEach>
                    </div>
                    <br><br><br><br><br><br>
                </c:if>

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
