<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/css.css">
    <title>版主管理</title>
</head>
<body>


    <div class="page">
        <div class="connoisseur">
        <div class="conShow">
        <table border="1" cellspacing="0" cellpadding="0">
            <tr>
                <td width="400px" class="tdColor tdC">用户名</td>
                <td width="400px" class="tdColor">角色</td>
                <td width="150px" class="tdColor">用户操作</td>

                <td width="350px" class="tdColor">管理的版块</td>
                <td width="300px" class="tdColor">版块操作</td>
            </tr>

            <c:forEach items="${uilist}" var="u" varStatus="index">
                <c:if test="${u.sectionSum==0}">
                    <tr height="40px">
                    <td>
                        <u style="cursor:pointer" class="text-primary" onclick="showUsers('用户详情','/users/showUsersInfo?username=${u.username}','360','400')">${u.username}</u>
                    </td>
                    <td>${u.role}</td>
                    <td>
                        <a href="/moderator/getValue?username=${u.username}" data-toggle="modal" data-target=".bs-example-modal-up" style="text-decoration:none" title="升为版主">
                            <i class="Hui-iconfont">&#xe679;</i>
                        </a>
                    </td>




                    <td>无权限</td>
                    <td>还没有相应操作呢<td/>
                </c:if>

                <c:if test="${u.sectionSum==1}">
                    <tr height="40px">
                    <td>
                        <u style="cursor:pointer" class="text-primary" onclick="showUsers('用户详情','/users/showUsersInfo?username=${u.username}','360','400')">${u.username}</u>
                    </td>
                    <td>${u.role}</td>
                    <td>
                        <a href="/moderator/getValue&username=${u.username}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-do" title="降为普通用户">
                            <i class="Hui-iconfont">&#xe674;</i>
                        </a>
                        <c:if test="${sectionSum ne 1}">
                            <a href="javascript:;" onclick="plate_add('添加版块管理权限','/moderator/getList?username=${u.username}','360','400');" style="text-decoration:none" title="添加以他版块权限">
                                <i class="Hui-iconfont">&#xe717;</i>
                            </a>
                        </c:if>
                    </td>






                    <td>${u.sectionList[0]}</td>
                    <td>
                        <a href="/moderator/getValue?username=${u.username}&section=${u.sectionList[0]}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-se" title="解除该版块的管理权限">
                            <i class="Hui-iconfont">&#xe6de;</i>
                        </a>
                    <td/>
                </c:if>


                <c:if test="${u.sectionSum>1}">
                    <tr height="40px">
                        <td rowspan="${u.sectionSum}">
                            <u style="cursor:pointer" class="text-primary" onclick="showUsers('用户详情','/users/showUsersInfo?username=${u.username}','360','400')">${u.username}</u>
                        </td>
                        <td rowspan="${u.sectionSum}">${u.role}</td>
                        <td rowspan="${u.sectionSum}">
                            <a href="/moderator/getValue?username=${u.username}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-do" title="降为普通用户">
                                <i class="Hui-iconfont">&#xe674;</i>
                            </a>
                            <c:if test="${u.sectionSum ne sectionSum}">
                                <a href="javascript:;" onclick="plate_add('添加版块管理权限','/moderator/getList?username=${u.username}','360','400')" style="text-decoration:none" title="添加以他版块权限">
                                    <i class="Hui-iconfont">&#xe717;</i>
                                </a>
                            </c:if>
                        </td>



                        <td>${u.sectionList[0]}</td>
                        <td>
                            <a href="/moderator/getValue?username=${u.username}&section=${u.sectionList[0]}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-se" title="解除该版块的管理权限">
                                <i class="Hui-iconfont">&#xe6de;</i>
                            </a>
                        <td/>
                    </tr>
                    <c:forEach items="${u.sectionList}" var="sl" begin="1" end="${u.sectionSum}">
                        <tr height="40px">
                            <td>${sl}</td>
                            <td>
                                <a href="/moderator/getValue?username=${u.username}&section=${sl}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-se" title="解除该版块的管理权限">
                                    <i class="Hui-iconfont">&#xe6de;</i>
                                </a>
                            <td/>
                        </tr>
                    </c:forEach>
                </c:if>
            </c:forEach>

        </table>
        <div class="pagination">
            <ul>
                <li class="page-item"><a class="page-link" href="/moderator/listInfo?page=1">首页</a></li>
                <c:if test="${!(page==1)}">
                    <li class="page-item"><a class="page-link" href="/moderator/listInfo?page=${page-1 }">上一页</a></li>
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
                        <li class="page-item active">
                            <a class="page-link" href="/moderator/listInfo?page=${p}">${p}</a>
                        </li>
                    </c:if>
                    <c:if test="${p ne page}">
                        <li class="page-item"><a class="page-link" href="/moderator/listInfo?page=${p}">${p}</a></li>
                    </c:if>
                </c:forEach>
                <c:if test="${!(page==pageCount)}">
                    <li class="page-item"><a class="page-link" href="/moderator/listInfo?page=${page+1 }">下一页</a></li>
                </c:if>
                <li class="page-item"><a class="page-link" href="/moderator/listInfo?page=${pageCount}">尾页</a></li>
                <li class="page-item"><a class="page-link" href="#" > 共有数据：<strong>${row}</strong>条</a></li>



            </ul>
        </div>
    </div>
    </div>
    </div>
</div>
</div>



<div  class="modal fade bs-example-modal-tm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">专题</h4>
            </div>
            <div class="modal-body">
                <p class="modal-title">确认要解除开设专题权限？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <a href="/moderator/tempMag?Temp=1"><button type="button" class="btn btn-primary radius" >确认</button></a>
            </div>
        </div>
    </div>
</div>


<div  class="modal fade bs-example-modal-do" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户操作</h4>
            </div>
            <div class="modal-body">
                <p class="modal-title">确认要降为普通用户？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <a href="/moderator/downUsers"><button type="button" class="btn btn-primary radius" >确认</button></a>
            </div>
        </div>
    </div>
</div>


<div  class="modal fade bs-example-modal-se" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户版块</h4>
            </div>
            <div class="modal-body">
                <p class="modal-title">确认要解除该版块的管理权限？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <a href="/moderator/doSection"><button type="button" class="btn btn-primary radius" >确认</button></a>
            </div>
        </div>
    </div>
</div>

<div  class="modal fade bs-example-modal-up" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">升为版主</h4>
            </div>
            <div class="modal-body">
                <form action="/moderator/upModerator" id="myform" method="get">
                    <div class="form-group">
                        <div>
                            <label class="form-label">选择版块：</label>
                            <div class="formControls skin-minimal">
                                <c:forEach items="${seclist}" var="se">
                                    <div class="check-box">
                                        <input type="checkbox" data-toggle="checkbox" name="secName" value="${se.sectName}" id="${se.sectName}"/>
                                        <label for="${se.sectName}">${se.sectName}</label>
                                    </div><br>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <button type="submit" onclick="test('myform');" class="btn btn-primary radius" >确认</button>
            </div>
        </div>
    </div>
</div>






<script type="text/javascript">
    function test(myform) {
        document.getElementById(myform).submit();
    }
    /**
     * 板块-添加
     * 子板块-添加
     */
    function  plate_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

    function  showUsers(title,url,w,h) {
        layer_show(title,url,w,h);

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
