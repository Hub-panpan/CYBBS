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

        <div class="col-xs-12 col-sm-9">
            <center><h2>修改圈子</h2></center>
            <form action="/friendgroup/updateFG.do" method="post">
                <div class="form-group">
                    <label for="exampleInputEmail1">修改圈子名称</label>
                    <input type="text" name="fg_name" class="form-control" id="exampleInputEmail1"
                           placeholder="${single_fg.fGName}">
                </div>
                <div class="form-group">
                    <%--@declare id="exampleinputpassword1"--%>
                    <label for="exampleInputPassword1">修改圈子描述</label>
                    <textarea class="form-control" rows="3" name="fg_desc"
                              placeholder="${single_fg.fGDescribe}"></textarea>
                </div>

                <div class="form-group">
                    <%--@declare id="exampleinputpassword1"--%>
                    <label for=""></label>
                    <p> 管理员： ${single_fg.fGController}&nbsp;&nbsp;&nbsp;&nbsp;圈子人数：${single_fg.fGMemberSum}</p>
                </div>

                <div class="form-group">
                    <%--@declare id="exampleinputpassword1"--%>
                    <label for="">群成员</label>


                    <c:forEach items="${single_fg.fGmemberList}" var="f">

                        <p>${f}
                            <a href="/friendgroup/deleteFGMember.do?fg_id=${single_fg._id}&fg_member_name=${f}"> 删除</a>
                        </p>

                    </c:forEach>

                </div>


                <input type="submit" class="btn btn-default" value="确认修改">
            </form>
            <hr>

            <div class="row">

                <div id="navbar" class="navbar-collapse collapse">
                    <form class="navbar-form navbar-left" action="/friendgroup/yaoqing_FgMember.do">
                        <div class="form-group">
                            <input type="text" placeholder="用户名" class="form-control" name="key_word">
                        </div>

                        <button type="submit" class="btn btn-success">搜索</button>
                    </form>
                </div><!--/.navbar-collapse -->
                <div>
                    <c:forEach items="${fuzzy_user_list}" var="f">

                        <p>${f.username}</p>
                        <p>${f.regTime}</p>

                        <a href="${pageContext.request.contextPath}/siteinfo/send_mesg.do?content=${single_fg.fGName}&sender=${username}&receiver=${f.username} ">
                            邀请</a></p>
                    </c:forEach>

                </div>


            </div><!--/row-->
            <%--</c:forEach>--%>
        </div><!--/.col-xs-12.col-sm-9-->


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

