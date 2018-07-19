<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>站内信</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <script>
        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').focus()
        })
    </script>
</head>
<body>
<%--<%@include file="header.jsp" %>--%>
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
        <div class="col-xs-12 col-sm-11">
            <div class="panel panel-default">
                <div class="panel-heading" align="center"><h3>我的站内信</h3></div>
                <table class="table">
                    <tr>
                        <td colspan="7" align="center"><h3>收件箱</h3></td>
                    </tr>
                    <c:if test="${not empty receiveMailList}">
                        <c:forEach items="${receiveMailList}" var="m">
                            <tr>
                                <td>
                                    发件人： ${m.send}
                                </td>
                                <td>
                                    收件人： ${m.receive}
                                </td>
                                <c:if test="${m.type == 1}" >
                                    <td>
                                            ${m.send} 桥邀请您进入朋友圈名为： ${m.content}:的圈子
                                    </td>

                                </c:if>
                                <c:if test="${m.type == 2}" >
                                    <td>
                                        内容： ${m.content}
                                    </td>

                                </c:if>


                                <td>
                                    是否已读： <c:if test="${m.state!=0}">已读</c:if>
                                </td>
                                <td>
                                    类型： ${m.type}
                                </td>

                                <c:if test="${m.state == 0 && m.type == 1}">
                                    <td>
                                            <%--这里传入的id为当前消息子文档的id--%>
                                        <a href="/siteinfo/agreeJoinFG?id=${m._id}&state=1" class="btn btn-primary btn-sm"
                                           data-toggle="" data-target="#myModal">
                                            同意
                                        </a>
                                        <a href="/siteinfo/agreeJoinFG?id=${m._id}&state=2" class="btn btn-primary btn-sm"
                                           data-toggle="" data-target="#myModal">
                                            忽略
                                        </a>

                                    </td>
                                </c:if>

                                <c:if test="${m.state == 1 }">
                                    <td colspan="2">
                                        <button type="button" class="btn btn-primary btn-sm" disabled="true">
                                            已&nbsp;&nbsp;&nbsp;读
                                        </button>
                                    </td>
                                </c:if>
                                <c:if test="${m.state == 2 }">
                                    <td>
                                        <button type="button" class="btn btn-primary btn-sm" disabled="true">
                                                <%--阅读但是不同意 type不变 state为2--%>
                                            已忽略
                                        </button>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty receiveMailList}">
                        <tr>
                            <td colspan="7" align="center"><h4>您还没有收到新消息！</h4></td>
                        </tr>
                    </c:if>
                    <tr>
                        <td colspan="7" align="center"><h3>发件箱</h3></td>
                    </tr>
                    <c:if test="${not empty sendMailList}">
                        <c:forEach items="${sendMailList}" var="m">
                            <tr>
                                <td>
                                    发件人： ${m.send}
                                </td>
                                <td>
                                    收件人： ${m.receive}
                                </td>
                                <td>
                                    内容： ${m.content}
                                </td>
                                <td>
                                    状态： 已读
                                </td>
                                <td>
                                    类型： ${m.type}
                                </td>

                                <td>
                                    <c:if test="${m.state == 0 && m.type == 1}">
                                        <a href="#" class="btn btn-primary btn-sm"
                                           data-toggle="" data-target="#myModal" disabled="true">
                                            无操作
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty sendMailList}">
                        <tr>
                            <td colspan="7" align="center"><h4>您还没有发过新消息！</h4></td>
                        </tr>
                    </c:if>
                </table>
            </div>
        </div>
        <%--右侧推荐栏目--%>
        <%--<%@include file="right.jsp" %>--%>
    </div>
</div>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
