<%@ page import="com.bbs.bean.Post" %><%--
  Created by IntelliJ IDEA.
  User: syq
  Date: 2018/6/5
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>帖子详情</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.min.js"></script>

    <link href="/res/common/css/zui.min.css" rel="stylesheet">
    <%--<link href="/res/front/css/app.css" rel="stylesheet">--%>

    <!-- Bootstrap core CSS -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <%--<script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>--%>

    <script src="/res/common/js/html5shiv.min.js"></script>
    <script src="/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script language="javascript" type="text/javascript" src="/res/common/js/jquery-2.1.1.min.js"></script>
    <script language="javascript" type="text/javascript" src="/res/common/js/zui.min.js"></script>
    <script language="javascript" type="text/javascript" src="/res/plugins/layer/layer.js"></script>
    <script language="javascript" type="text/javascript" src="/res/common/js/jquery.form.js"></script>
    <script language="javascript" type="text/javascript" src="/res/front/js/jeesns.js"></script>
    <script src="/res/front/js/cms.js"></script>

    <script>
        $(document).ready(function(){
            $("#btnVCode").click(function () {
               // setTimeout(1500);
                window.location.reload();
            });
        });
    </script>

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
    <div class="container">
        <div class="main-content">
            <div class="row">
                <div class="col-xs-12 col-sm-9">
                    <center><h2>帖子标题：${post.postTitle}</h2></center>
                    <article class="article article-detail">
                        <header>
                        <div class="dl-inline">
                            <dt></dt>
                            <dd>
                                <span class="label label-danger">
                                    <i class="icon-eye-open"></i>
                                    浏览量：${post.getPostPageView()}
                                </span>
                                <span class="label label-warning">
                                    <i class="icon icon-list-ul"></i>
                                        所属父级：${cwdSectName}
                                </span>

                                <span class="label label-info">
                                    <i class="icon icon-time"></i>
                                    发贴时间：<fmt:formatDate value="${post.getPostTime()}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </span>
                                <span class="label label-warning" style="margin-left: 80px">
                                    发帖者：${post.getPostUname()}
                                </span>

                                <span class="label label-success" style="margin-left: 0px">
                                    回帖量：${post.getBackPostSum()}
                                </span>

                            </dd>

                        </div>
                        </header>
                        <div class="content" align="center" style="margin-top:10px;background-color: lightsteelblue">
                            ${post.postContent}
                        </div>
                        <div class="text-center">
                        </div>
                    </article>


                    <div class="comments panel">
                        <header>
                            <div class="reply-form">

                            </div>
                        </header>

                        <c:forEach items="${backPosts}" var="p">
                            <section class="comments-list" id="commentList">
                                <div class="comment">
                                    <a href="/u/1" class="avatar"><span class="glyphicon  glyphicon-user" aria-hidden="true"></span></a>
                                    <div class="content">
                                            <div class="pull-right text-muted"> <fmt:formatDate value="${p.bPostTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </div>
                                            <div> <strong> 回帖者： ${p.bPostUname} </strong> </div>
                                            <div class="text">${p.bPostContent} </div>
                                            <a href="/back/delete/backPost?bapo_id=${p._id}" >${p._id}</a>
                                    </div>
                                </div>
                            </section>
                        </c:forEach>








                    </div>
                </div>




             </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function () {
    var pageNo = 1;
    cms.commentList(articleId, pageNo);
    $("#moreComment").click(function () {
        pageNo++;
        cms.commentList(articleId, pageNo);
    });
    $(".article-favor").click(function () {
        cms.favor($(this), "${basePath}")
    });
});
</script>
<script type = "text/javascript" >
    var ue = UE.getEditor('editor', {
        toolbars: [
            ['fullscreen', 'source', 'undo', 'redo', 'bold','emotion']
        ],
        autoHeightEnabled: true,
        autoFloatEnabled: true
    });
</script>


</body>
</html>
