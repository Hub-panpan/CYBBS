<!DOCTYPE HTML>
<%--
  Created by IntelliJ IDEA.
  User: shang
  Date: 2018/6/25
  Time: 0:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改子版块</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/style.css" />
</head>
<body>
<article class="page-container">
    <form action="/section/Change" target="_parent" method="post" class="form form-horizontal">
        <%
            session.setAttribute("sectionName",session.getAttribute("sectionName"));
            session.setAttribute("oldSonSecName",session.getAttribute("sonSectionName"));
        %>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">子版块名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text"  placeholder="${sonSectionName}" value="${sonSectionName}" name="newSonSectionName">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">子版块描述：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea cols="" rows="" class="textarea" placeholder="${sonDescribe}" name="newSonSecDescribe">${sonDescribe}</textarea>
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;&nbsp;修改&nbsp;&nbsp;&nbsp;&nbsp;"/>
            </div>
        </div>
    </form>
</article>


<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui.admin/js/H-ui.admin.js"></script>
</body>
</html>
