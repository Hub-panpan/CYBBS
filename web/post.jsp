<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>发帖</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.min.js"></script>
    <%--<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->--%>
    <%--<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->--%>
    <script type="text/javascript" charset="utf-8" src="ueditor/lang/zh-cn/zh-cn.js"></script>

    <link href="${basePath}/css/bootstrap.min.css" rel="stylesheet">


    <link href="${basePath}/res/plugins/webuploader/webuploader.css" rel="stylesheet">
    <link href="${basePath}/res/manage/css/skins/_all-skins.css" rel="stylesheet">
    <link href="${basePath}/res/plugins/layer/skin/layer.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${basePath}/res/common/js/html5shiv.js"></script>
    <script src="${basePath}/res/common/js/respond.min.js"></script>




   <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">


    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>


    <![endif]-->
    <script src="${basePath}js/jquery-2.1.1.min.js"></script>
    <script src="${basePath}js/jquery.form.js"></script>
    <%--<script src="${basePath}/res/common/js/bootstrap.min.js"></script>--%>
    <%--<script src="${basePath}/res/manage/js/app.js"></script>--%>
    <%--<script src="${basePath}/res/plugins/webuploader/webuploader.min.js"></script>--%>
    <%--<script src="${basePath}/res/plugins/layer/layer.js"></script>--%>
    <%--<script src="${basePath}/res/common/js/jeesns.js"></script>--%>
    <%--<script src="${basePath}/res/plugins/ckeditor/ckeditor.js"></script>--%>
    <%--<script type="text/javascript">--%>
        <%--// $(function () {--%>
        <%--//     CKEDITOR.replace('content');--%>
        <%--// });--%>
        <%--var basePath = "${basePath}";--%>
        <%--var uploadServer = "${managePath}/uploadImage";--%>
    <%--</script>--%>
    <%--<script src="${basePath}/res/plugins/webuploader/upload.js"></script>--%>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#ss").change(function(){
                if(document.getElementById("select_type").value==0)
                {
                    $("#sonSection").fadeOut().attr({disabled:true});
                    $("#fg").fadeOut().attr({disabled:true});
                    $("#zt").fadeOut().attr({disabled:true});
                    $("#bk1").attr({name:""});
                    $("#bk2").attr({name:""});
                    $("#bk3").attr({name:""});
                }
                if(document.getElementById("select_type").value==1)
                {
                    $("#sonSection").fadeIn().attr({disabled:false});
                    $("#fg").fadeOut().attr({disabled:true});
                    $("#zt").fadeOut().attr({disabled:true});
                    $("#bk2").attr({name:""});
                    $("#bk3").attr({name:""});
                }
                if(document.getElementById("select_type").value==2)
                {
                    $("#zt").fadeIn().attr({disabled:true});
                    $("#sonSection").fadeOut().attr({disabled:false});
                    $("#fg").fadeOut().attr({disabled:true});
                    $("#bk1").attr({name:""});
                    $("#bk3").attr({name:""});
                }
                if(document.getElementById("select_type").value==3)
                {
                    $("#fg").fadeIn().attr({disabled:true});
                    $("#sonSection").fadeOut().attr({disabled:true});
                    $("#zt").fadeOut().attr({disabled:false});
                    $("#bk1").attr({name:""});
                    $("#bk2").attr({name:""});
                }
            });
        });
    </script>

</head>

<body class="hold-transition">

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
    <%--<div class="container">--%>
        <div class="main-content">
            <div class="row">
                <div class="col-xs-12 col-sm-9">
                    <center><h2>发帖</h2></center>
                    <form class="form-horizontal jeesns_form" role="form" action="/add/Post">
                        
                        <div class="form-group" id="ss">
                            <label for="" class="col-sm-1 control-label">所属</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="postLabel" data-type="selected" alt="所属" id="select_type">
                                    <option value="0" selected>=请选择</option>
                                    <option value="1">板块</option>
                                    <option value="3">朋友圈</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group" id="sonSection" hidden="hidden">
                            <label for="" class="col-sm-1 control-label">板块</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="postSonSection" data-type="selected" alt="栏目" id="bk1">
                                    <option value="" selected>=请选择板块=</option>
                                    <c:forEach items="${sectionList}" var="sect">
                                        <option disabled="disabled" style="background-color:blue;">${sect.sectName}</option>
                                        <c:forEach items="${sonSectionList}" var="sonSect">
                                            <c:if test="${sect.getSectName() == sonSect.getfSectName()}">
                                                <option value="${sonSect.getId()}">${sonSect.getSonSectName()}</option>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>



                        <div class="form-group" id="fg" hidden="hidden">
                            <label for="" class="col-sm-1 control-label">朋友圈</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="postSonSection" data-type="selected" alt="栏目" id="bk3">
                                    <option value="" selected>=请选择朋友圈=</option>
                                    <c:forEach items="${friend_group}" var="son">
                                        <option value="${son._id}">${son.fGName}</option>
                                    </c:forEach>
                                    <c:forEach items="${friend_group_join}" var="son">
                                        <option value="${son._id}">${son.fGName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="" class="col-sm-1 control-label">标题</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="title" name="postTitle" placeholder="标题" data-type="require" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="" class="col-sm-1 control-label">类型</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="postType" data-type="selected" alt="类型" >
                                    <option value="1">普通帖</option>
                                    <option value="2">积分贴</option>

                                </select>
                            </div>
                        </div>



                        <div class="form-group">
                            <label for="" class="col-sm-1 control-label">积分</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control"  name="postIntegral" placeholder="积分" data-type="require" value="0" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="" class="col-sm-1 control-label">内容</label>
                            <div class="col-sm-10">
                                <%--<textarea class="ckeditor" cols="80" id="content" name="content" rows="10"></textarea>--%>
                                <script id="editor" name="postContent" type="text/plain" ></script>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-1 col-sm-10">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="reset" class="btn btn-info jeesns-submit" name="" value="重置">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="submit" class="btn btn-info jeesns-submit">发帖</button>
                            </div>
                        </div>
                    </form>
                    <br><br><br><br><br><br><br><br>
                </div>



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
        </div>

</div>

</body>


<script type = "text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

</script>
</html>