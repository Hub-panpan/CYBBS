<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <title>登录页面</title>


    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>

    <script>
        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').focus()
        })
    </script>
</head>

<body>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel"> 牛带我飞吧-专业考研论坛 </h4>
            </div>
            <div class="modal-body">
                游客您好　请先登录！
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

            </div>
        </div>
    </div>
</div>
<!-- Static navbar -->
<%--<nav class="navbar navbar-default navbar-static-top">--%>
<nav class="navbar navbar-inverse navbar-fixed-top sidebar">
    <div class="container-fluid ">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/add/data"></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/add/data">首页</a></li>
                <li><a href="#" data-toggle="modal" data-target="#myModal" >管理版块</a></li>
                <li><a href="#" data-toggle="modal" data-target="#myModal" >创建朋友圈</a></li>
                <li><a href="#" data-toggle="modal" data-target="#myModal" >我的朋友圈</a></li>
                <li><a href="#" data-toggle="modal" data-target="#myModal">发帖</a></li>

            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">${username}<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">个人中心</a></li>
                        <li><a href="#">专题</a></li>
                        <li><a href="/login.jsp">退出</a></li>
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

    <div class="row row-self page-container">
        <div class="col-md-4 col-md-offset-4">
            <div class="page-header">

                <h2>管理员登录</h2>

            </div>
            <form action="/admin/adminLogin" class="padder" method="post">
                <div class="form-group ">
                    <label>用户名</label>
                    <input type="text" placeholder="admin" class="form-control" name="username">
                    <p id="phoneInfo"></p>
                </div>
                <div class="form-group ">
                    <label for="password">密码</label>
                    <input type="password" id="inputPassword" placeholder="admin" class="form-control" name="password">


                </div>


                <div class="row">
                    <div class="col-md-4">
                        <p><input type="checkbox"> 记住我</p>
                    </div>
                    <div class="col-md-8">
                        <p class="text-right"><a href="">忘记密码?</a></p>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">登录</button>

            </form>
        </div>
    </div>

</div>

<!-- Placed at the end of the document so the pages load faster -->
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>

<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>


</body>
</html>

