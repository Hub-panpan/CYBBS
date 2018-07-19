<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <title>增加朋友圈</title>


    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>

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
        <center>
            <div class="" style="background-color: beige">
                <h2><a href="/user/personal">个人中心</a></h2>
            </div>
        </center>
        <div class="col-xs-12 col-sm-9">


                <br><br>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户名：${userInfo.getUsername()}</p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户等级：${userInfo.getRank()}级</p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户积分：${userInfo.getIntegralSum()}分</p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户角色：${userInfo.getRole()}</p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户发帖量：${userInfo.getPostSum()}条</p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户回帖量：${userInfo.getBackPostSum()}条</p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户参加朋友圈：
                    <c:if test="${empty UFGList}">
                        无
                    </c:if>
                    <c:if test="${not empty UFGList}">
                        <c:forEach var="ufg" items="${UFGList}">
                            ${ufg}|
                        </c:forEach>
                    </c:if>
                </p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户管理的版块：
                    <c:if test="${empty userInfo.getSectionList()}">
                        无
                    </c:if>
                    <c:if test="${not empty userInfo.getSectionList()}">
                        <c:forEach var="usection" items="${userInfo.getSectionList()}">
                            ${usection}|
                        </c:forEach>
                    </c:if>
                </p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户开设的专题：
                    <c:if test="${empty tempUSectionList}">
                        无
                    </c:if>
                    <c:if test="${not empty tempUSectionList}">
                        <c:forEach var="tempUSection" items="${tempUSectionList}">
                            ${tempUSection}|
                        </c:forEach>
                    </c:if>

                </p>
                <p style="margin-left: 100px;font-size: 20px;font-weight: 200;font-weight: bold">用户注册日期：
                    <%--<fmt:formatDate value="${user.regTime}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>

                    ${user.regTime}
                </p>

        </div>



        <div class="col-sm-3" >

            <div class="row-sm-3 col-sm-offset-1 blog-sidebar">

                <div class="sidebar-module sidebar-module-inset">
                    <h4>新消息列表</h4>
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

