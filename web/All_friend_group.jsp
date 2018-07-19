<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>大牛带我飞吧-专业考研论坛</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>

</head>

<body>

<!-- Static navbar -->
<%--<nav class="navbar navbar-default navbar-static-top">--%>
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

            <center><h2>显示所有我创建圈子</h2></center>
            <!-- Three columns of text below the carousel -->

                <c:if test="${not empty friend_group}">

                    <c:forEach items="${friend_group}" var="fg">
                        <div class="row">
                            <div class="col-lg-3">
                                    <%--<img class="img-circle"--%>
                                    <%--src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="--%>
                                    <%--alt="Generic placeholder image" width="140" height="140">--%>
                                <h3>${fg.fGName}</h3>
                                    <%--<a href="/friendgroup/updateFG01.do?fg_id=${fg._id}"> 编辑</a>--%>
                                <a href="/friendgroup/deleteFG.do?fg_id=${fg._id}"> 删除</a>

                            </div>
                            <div class="col-lg-6">
                                <p> 管理员： ${fg.fGController}&nbsp;&nbsp;&nbsp;&nbsp;圈子人数：${fg.fGMemberSum}</p>
                                <p></p>
                                <p>圈子描述：${fg.fGDescribe}.</p>
                            </div>
                            <div class="col-lg-3">
                                <p><a class="btn btn-default" href="/friendgroup/searchSingleFG.do?single_fg_id=${fg._id}" role="button">进入我的圈子 &raquo;</a></p>
                            </div>
                        </div>
                        <hr>
                    </c:forEach>
                </c:if>



            <center><h2>显示所有我加入圈子</h2></center>
            <!-- Three columns of text below the carousel -->

            <c:if test="${not empty friend_group_join}">

                <c:forEach items="${friend_group_join}" var="fg2">
                    <div class="row">
                        <div class="col-lg-3">
                                <%--<img class="img-circle"--%>
                                <%--src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="--%>
                                <%--alt="Generic placeholder image" width="140" height="140">--%>
                            <h3>${fg2.fGName}</h3>
                                <%--<a href="/friendgroup/updateFG01.do?fg_id=${fg._id}"> 编辑</a>--%>
                                    <c:if test="${username eq fg2.fGController}">

                                        <a href="/friendgroup/deleteFG.do?fg_id=${fg2._id}"> 删除</a>
                                    </c:if>


                        </div>
                        <div class="col-lg-6">
                            <p> 管理员： ${fg2.fGController}&nbsp;&nbsp;&nbsp;&nbsp;圈子人数：${fg2.fGMemberSum}</p>
                            <p></p>
                            <p>圈子描述：${fg2.fGDescribe}.</p>
                        </div>
                        <div class="col-lg-3">
                            <p><a class="btn btn-default" href="/friendgroup/searchSingleFG.do?single_fg_id=${fg2._id}" role="button">进入我的圈子 &raquo;</a></p>
                        </div>
                    </div>
                    <hr>
                </c:forEach>



            </c:if>


                <c:if test="${empty friend_group}">
                    <c:if test="${empty friend_group_join}">
                    朋友圈空空如野！
                    </c:if>

                </c:if>


        </div>


        <div class="col-sm-3">

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

