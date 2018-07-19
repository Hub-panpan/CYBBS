<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <script>
//        $('#myModal').on('shown.bs.modal', function () {
//            $('#myInput').focus()
//        })

        $(function() {
            $(".mybtn").click(function() {
                var id = $(this).attr("id");

                $("#mymodal"+id).on('shown.bs.modal', function () {
                    $('#myInput').focus()
                })
            });
        });

    </script>
</head>
<title>特别专题</title>

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


                <div class="" style="background-color: beige">
                    <h3>子板块名id:${single_sonSection.id}</h3>
                    <h3>父板块名:${single_sonSection.fSectName}</h3>
                    <h3>子板块名:${single_sonSection.sonSectName}</h3>
                    <h3>板块描述:${single_sonSection.sonSectDescribe}</h3>
                    <%--<h3>发帖个数:${single_sonSection.sonSectPostSum}</h3>--%>
                    <%--<h3>回帖个数:${single_sonSection.sonSectBPostSum}</h3>--%>

                </div>
                <div class="row">

                        <center>帖子列表</h2></center>
                        <c:if test="${empty cwdPostList}">
                            <center><h2>还没有帖子，快快去发表吧！</h2></center>
                        </c:if>
                        <c:if test="${not empty cwdPostList}">
                            <c:forEach items="${cwdPostList}" var="post">
                                <!-- Modal --> <!-- Modal --> <!-- Modal --> <!-- Modal -->
                                <div class="modal fade" id="myModal${post.get_id()}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                            </div>
                                            <div class="modal-body">
                                                您将要 积分贴(${post.getPostIntegral()}分)|
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>


                                                <a  href="/get/Post?cwdPostId=${post._id}&post_jifen=${post.getPostIntegral()}" type="button" class="btn btn-primary">查看</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>




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





                                        <c:if test="${post.getPostType()==2 and post.getPostUname()!= user.username}">


                                            |<a class="mybtn"  data-toggle="modal" data-target="#myModal${post._id}">
                                            查看
                                            </a>

                                            <%--<a class="btn" id=${post.get_id()} >查看</a>--%>


                                        </c:if>
                                        <c:if test="${post.getPostType()==1  and post.getPostUname()!= user.username }">
                                            |<a href="/get/Post?cwdPostId=${post._id}&post_jifen=${post.getPostIntegral()}">
                                            查看
                                            </a>
                                        </c:if>

                                        <c:if test="${post.getPostUname()== user.username }">
                                            |<a href="/get/Post?cwdPostId=${post._id}&post_jifen=${post.getPostIntegral()}">
                                            查看
                                            </a>


                                        </c:if>




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
                            <div class="modal fade" id="myModal${hotPost.get_id()}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            您将要 查看　标题为：${hotPost.getPostTitle()}的积分贴，将要(${hotPost.getPostIntegral()}分)|
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>


                                            <a  href="/get/Post?cwdPostId=${hotPost._id}&post_jifen=${hotPost.getPostIntegral()}" type="button" class="btn btn-primary">查看</a>
                                        </div>
                                    </div>
                                </div>
                            </div>





                            <li> |<a class="mybtn"  data-toggle="modal" data-target="#myModal${hotPost._id}">
                                    ${hotPost.getPostTitle()}
                            </a></li>
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
