<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>

</head>
<title>管理子版块信息</title>

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
                <form action="/update/SonSection02" method="post">

                    <div class="form-group">
                        <label for="">${single_sonSection.sonSectName}</label>
                        <input type="hidden" name="old_name" class="form-control"  value="${single_sonSection.sonSectName}">
                    </div>


                    <div class="form-group">
                        <label for="">${single_sonSection.id}</label>
                        <input type="hidden" name="cwdSonSectionId" class="form-control"  value="${single_sonSection.id}">
                    </div>

                    <div class="form-group">
                        <label for="">修改子板块名称</label>
                        <input type="text" name="sonSectName" class="form-control" id=""
                               placeholder="${single_sonSection.sonSectName}">
                    </div>
                    <div class="form-group">
                        <%--@declare id="exampleinputpassword1"--%>
                        <label for="exampleInputPassword1">修改圈子描述</label>
                        <textarea class="form-control" rows="3" name="sonSectDescribe"
                                  placeholder="${single_sonSection.sonSectDescribe}"></textarea>
                    </div>


                    <input type="submit" class="btn btn-default" value="确认修改">
                </form>


                <h4>子板块名id${single_sonSection.sonSectBPostSum}</h4>
                <h4>父板块名${single_sonSection.fSectName}</h4>
                <h4>子板块名${single_sonSection.sonSectName}</h4>
                <h4>板块描述${single_sonSection.sonSectDescribe}</h4>
                <h4>发帖个数${single_sonSection.sonSectPostSum}</h4>
                <h4>回帖个数${single_sonSection.sonSectBPostSum}</h4>

            </div>
            <div class="row">

                <center>帖子列表</h2></center>
                <c:if test="${empty cwdPostList}">
                    <center><h2>还没有帖子，快快去发表吧！</h2></center>
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
                                |<a href="/get/Post1?cwdPostId=${post._id}">
                                    查看</a>

                                <a href="/post/deletePost.do?po_id=${post._id}"> 删除</a>

                            </h3>



                        </div>

                    </c:forEach>
                </c:if>
                <br><br><br><br><br>

            </div>


        </div><!--/.col-xs-12.col-sm-9-->


        <div class="col-sm-3" >


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
