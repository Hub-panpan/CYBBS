<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page.css">
    <title>用户管理</title>
</head>
<body>
<nav class="breadcrumb"> <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c"></div>

    <div class="mt-20">
        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="100">用户名</th>
                <th width="130">注册时间</th>
                <th width="120">状态</th>
                <%--<th width="100">操作</th>--%>
            </tr>
            </thead>
            <tbody>
                <c:forEach items="${ulist}" var="u" varStatus="index">
                    <tr class="text-c">
                        <td>
                            <u style="cursor:pointer" class="text-primary" onclick="showUsers('用户详情','/users/showUsersInfo?username=${u.username}','360','400')">${u.username}</u>
                        </td>
                        <td><fmt:formatDate value="${u.regTime}" pattern="yyyy-MM-dd"/></td>
                        <c:if test="${u.userstate eq '正常'}">
                            <td class="td-status"><span class="label label-success radius">${u.userstate}</span></td>
                            <%--<td class="td-manage">--%>
                                <%--<a type="button" href="/users/passValue?username=${u.username}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-fz" title="冻结">--%>
                                    <%--<i class="Hui-iconfont">&#xe631;</i>--%>
                                <%--</a>--%>
                                <%--<a type="button" href="/users/passValue?username=${u.username}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-fh" title="封号">--%>
                                    <%--<i class="Hui-iconfont">&#xe60b;</i>--%>
                                <%--</a>--%>
                            <%--</td>--%>
                        </c:if>
                        <%--<c:if test="${u.userstate eq '已冻结'}">--%>
                            <%--<td class="td-status"><span class="label radius">${u.userstate}</span></td>--%>
                            <%--<td class="td-manage">--%>
                                <%--<a  href="/users/operate?username=${u.username}&operation=start" style="text-decoration:none" title="启用">--%>
                                    <%--<i class="Hui-iconfont">&#xe615;</i>--%>
                                <%--</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${u.userstate eq '已封号'}">--%>
                            <%--<td class="td-status"><span class="label label-danger radius">${u.userstate}</span></td>--%>
                            <%--<td class="td-manage">--%>
                                <%--<a  href="/users/operate?username=${u.username}&operation=start" style="text-decoration:none" title="启用">--%>
                                    <%--<i class="Hui-iconfont">&#xe615;</i>--%>
                                <%--</a>--%>
                            <%--</td>--%>
                        <%--</c:if>--%>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination">
            <ul>
                <li><a href="/users/listUsers?page=1">首页</a></li>
                <c:if test="${!(page==1)}">
                    <li><a href="/users/listUsers?page=${page-1 }">上一页</a></li>
                </c:if>
                <%--计算begin和end --%>
                <c:choose>
                    <%--如果总页数不足10，那么就把所有的页都显示出来 --%>
                    <c:when test="${pageCount<=10}">
                        <c:set var="begin" value="1" />
                        <c:set var="end" value="${pageCount}" />
                    </c:when>
                    <c:otherwise>
                        <%--如果总页数大于10，通过公式计算出begin和end --%>
                        <c:set var="begin" value="${page}" />
                        <c:set var="end" value="${page+9}" />
                        <c:set var="bz" value="1"></c:set>
                        <%--头溢出 --%>
                        <c:if test="${begin<1}">
                            <c:set var="begin" value="1"></c:set>
                            <c:set var="end" value="10"></c:set>
                        </c:if>
                        <%--尾溢出 --%>
                        <c:if test="${end>pageCount}">
                            <c:set var="begin" value="${pageCount - 9}"></c:set>
                            <c:set var="end" value="${pageCount}"></c:set>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:forEach var="p" begin="${begin}" end="${end}">
                    <c:if test="${p eq page}">
                        <li class="active">
                            <a href="/users/listUsers?page=${p}">${p}</a>
                        </li>
                    </c:if>
                    <c:if test="${p ne page}">
                        <li><a href="/users/listUsers?page=${p}">${p}</a></li>
                    </c:if>
                </c:forEach>
                <c:if test="${!(page==pageCount)}">
                    <li><a href="/users/listUsers?page=${page+1 }">下一页</a></li>
                </c:if>
                <li><a href="/users/listUsers?page=${pageCount}">尾页</a></li>
                <li><a href="#">共有记录：<strong>${rows}</strong> 条</a></li>


            </ul>

        </div>
    </div>
</div>

<div  class="modal fade bs-example-modal-fz" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">冻结</h4>
            </div>
            <div class="modal-body">
                <form action="/users/operateFreeze"id="myform" method="get">
                    <label class="form-label">冻结时长：</label>
                        <select class="select-box" name="duration">
                            <option value="30m">30分钟</option>
                            <option value="1h">1小时</option>
                            <option value="1d">1天</option>
                            <option value="7d">7天</option>
                        </select>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <button type="submit" onclick="test();" class="btn btn-primary radius" >确认</button>
            </div>
        </div>
    </div>
</div>

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
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <a href="/users/operate?operation=fenghao"><button type="button" class="btn btn-primary radius" >确认</button></a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    /*用户-查看*/
    function  showUsers(title,url,w,h) {
        layer_show(title,url,w,h);

    }
    /*提交form*/
    function test() {
        document.getElementById("myform").submit();
    }
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery-ui/1.9.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.SuperSlide/2.1.1/jquery.SuperSlide.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui.admin/js/H-ui.admin.js"></script>

</body>
</html>
