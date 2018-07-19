<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <title>大牛带我飞吧后台</title>
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl">
            <form action="/admin/index" id="myform" method="post">
                <a class="logo navbar-logo f-l mr-10 hidden-xs" onclick="test('myform')">大牛带我飞吧</a>
            </form>
            <span class="logo navbar-slogan f-l mr-10 hidden-xs"></span>
            <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;" >&#xe667;</a>
            <nav class="nav navbar-nav">
                <ul class="cl">


                    <%--<li>--%>
                        <%--<a type="button" data-toggle="modal" data-target=".bs-example-modal-addsonsec">--%>
                            <%--<i class="Hui-iconfont">&#xe600;</i>子版块--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a type="button" data-toggle="modal" data-target=".bs-example-modal-addsec">--%>
                            <%--<i class="Hui-iconfont">&#xe600;</i> 添加版块--%>
                        <%--</a>--%>
                    <%--</li>--%>
                </ul>
            </nav>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">


                    <li class="dropDown dropDown_hover">

                        <marquee scrollAmount=2 direction="left" scrolldelay="60"> 超级管理员：${root.rootname}</marquee>

                        <ul class="dropDown-menu menu radius box-shadow">

                            <%--
                            退出后台
                            --%>
                                <li><a href="/admin/logoff">退出</a></li>

                        </ul>
                    </li>
                    <%--

                     管理员消息管理

                    --%>

                    <%--<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>--%>
                        <%--<ul class="dropDown-menu menu radius box-shadow">--%>
                            <%--<li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>--%>
                            <%--<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>--%>
                            <%--<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>--%>
                            <%--<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>--%>
                            <%--<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>--%>
                            <%--<li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>--%>
                        <%--</ul>--%>
                    <%--</li>--%>
                </ul>
            </nav>
        </div>
    </div>
</header>
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">
        <dl id="menu-member">
            <dt><i class="Hui-iconfont">&#xe60d;</i> 用户中心<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="/users/listUsers" data-title="用户列表" href="javascript:;">用户管理</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-comments">
            <dt><i class="Hui-iconfont">&#xe62b;</i>版主管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="/moderator/listInfo" data-title="版主列表" href="javascript:;">版主列表</a></li>
                </ul>
            </dd>
        </dl>

        <dl id="menu-article">
            <c:if test="${empty seclist}">
                <dt><i class="Hui-iconfont">&#xe616;</i> 板块管理</dt>
            </c:if>
            <c:if test="${not empty seclist}">
                <dt><i class="Hui-iconfont">&#xe616;</i> 板块管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                    <dd>
                        <c:forEach items="${seclist}" var="se">
                            <ul>
                                <li><a data-href="/section/listSonSection?sectionName=${se.sectName}" data-title="板块管理" href="javascript:void(0)">${se.sectName}</a></li>
                            </ul>
                        </c:forEach>
                    </dd>
            </c:if>
        </dl>

        <dl id="menu-system">
            <dt><i class="Hui-iconfont">&#xe62e;</i> 基础功能<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                        <a type="button" data-toggle="modal" data-target=".bs-example-modal-addsonsec">
                            添加子版块
                        </a>
                    </li>
                    <li>
                        <a type="button" data-toggle="modal" data-target=".bs-example-modal-addsec">
                             添加主版块
                        </a>
                    </li>
                </ul>
            </dd>
        </dl>
    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <%--
                    用户
                    --%>
                    <span title="用户列表" data-href="/users/listUsers">用户列表</span>
                    <em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="/users/listUsers"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前 </li>
        <li id="closeall">关闭全部 </li>
    </ul>
</div>

<div  class="modal fade bs-example-modal-addsec" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加版块</h4>
            </div>
            <div class="modal-body">
                <form action="/section/addSection" id="myform1" method="post">
                    <div>
                        <label class="form-label"></label>
                        <div class="formControls">
                            <input type="text" class="input-text" placeholder="版块名" name="sectionName" autocomplete="off"/>
                        </div>
                    </div>
                    <br>
                    <div>
                        <div class="formControls">
                            <textarea cols="" rows="" class="textarea" name="secDescribe"  placeholder="版块描述"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <button type="submit" onclick="test('myform1');" class="btn btn-primary radius">添加</button>
            </div>
        </div>
    </div>
</div>


<div  class="modal fade bs-example-modal-addsonsec" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加子版块</h4>
            </div>
            <c:if test="${empty seclist}">
                <div class="modal-body">
                    <p class="modal-title">还没有版块</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary radius" data-dismiss="modal">去添加</button>
                </div>
            </c:if>
            <c:if test="${not empty seclist}">
                <div class="modal-body">
                    <form action="/section/addSonSection?pageName=/admin/index" id="myform2" method="post">
                        <label class="form-label">所属版块：</label>
                        <div class="formControls skin-minimal">
                            <c:forEach items="${seclist}" var="se">
                                <div class="radio-box">
                                    <input type="radio" id="${se.sectName}" name="sectionName" value="${se.sectName}">
                                    <label for="${se.sectName}">${se.sectName}</label>
                                </div>
                            </c:forEach>
                        </div>
                        <br>
                        <div>
                            <label class="form-label"></label>
                            <div class="formControls">
                                <input type="text" class="input-text" placeholder="子版块名" name="sonSectionName" autocomplete="off">
                            </div>
                        </div>
                        <br>
                        <div>
                            <div class="formControls">
                                <textarea cols="" rows="" class="textarea" name="sonSecDescribe"  placeholder="子版块名描述"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                    <button type="submit" onclick="test('myform2');" class="btn btn-primary radius">添加</button>
                </div>
            </c:if>
        </div>
    </div>
</div>



<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery-ui/1.9.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.SuperSlide/2.1.1/jquery.SuperSlide.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">

    /**
     * 板块-添加
     * 子板块-添加
     */
    function  plate_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

    /**
     *表单提交
     * @param myform
     */
    function test(myform) {
        document.getElementById(myform).submit();
    }
</script>
</body>
</html>
