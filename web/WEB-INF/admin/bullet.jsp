
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="listUsers.jsp"%>--%>
<jsp:include page="listUsers.jsp"/>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <title>弹框</title>
</head>
<body>
<div  class="modal fade bs-example-modal-fh" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">封号</h4>
            </div>
            <div class="modal-body">
                <p class="modal-title">确认封号？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a href="/users/operate?operation=fenghao&uname=${username}"><button type="button" class="btn btn-primary" >确认</button></a>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js " type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/npm.js" type="text/javascript"></script>
</body>
</html>
