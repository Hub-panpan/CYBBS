<!DOCTYPE HTML>
<%--
  Created by IntelliJ IDEA.
  User: shang
  Date: 2018/6/11
  Time: 21:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/style.css" />
</head>
<body>
<article class="page-container">
    <form action="/moderator/compareSection" target="_parent" method="get" class="form form-horizontal">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">选择版块：</label>
            <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                <c:forEach items="${comlist}" var="com">
                    <div class="check-box">
                        <input name="sectionName" type="checkbox" id="${com}" value="${com}">
                        <label for="${com}">${com}</label>
                    </div><br>
                </c:forEach>
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;添加&nbsp;&nbsp;"/>
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
