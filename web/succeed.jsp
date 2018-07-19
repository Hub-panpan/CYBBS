<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <title>成功页面</title>


    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>


</head>


<body onload="countDown()">

<div class="container">

    <!-- Static navbar -->
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

    <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2> ${succeedInfo}</h2>

        <p>
            <a id="time" class="btn btn-lg btn-primary" href="${pageContext.request.contextPath}/login.jsp" role="button">返回首頁 &raquo;</a>
        </p>
    </div>

</div> <!-- /container -->






<script type="text/javascript">
    var t = 10;
    function countDown(){
        var time = document.getElementById("time");
        t--;
        time.innerHTML=t+"秒后 返回首頁 &raquo;";
        if (t<=0) {


            location.href="${pageContext.request.contextPath}/index.jsp";

            clearInterval(inter);
        };
    }
    var inter = setInterval("countDown()",1000);
    //window.onload=countDown;
</script>



<script src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>



</body>

</html>