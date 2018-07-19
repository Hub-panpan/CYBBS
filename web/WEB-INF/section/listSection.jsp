<!DOCTYPE HTML>
<%--
  Created by IntelliJ IDEA.
  User: shang
  Date: 2018/6/6
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page.css">
    <title>用户管理</title>
</head>
<body>
<nav class="breadcrumb"> ${sectionName} <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c"></div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a type="button" class="btn btn-danger radius"  data-toggle="modal" data-target=".bs-example-modal-del">
                <i class="Hui-iconfont">&#xe6e2;</i> 删除该版块
            </a>

            <a href="button" class="btn btn-primary radius" data-toggle="modal" data-target=".bs-example-modal-adds">
                <i class="Hui-iconfont">&#xe600;</i> 添加子版块
            </a>
        </span>
        <span class="c-red">
             ${errorMsg}
        <c:if test="${errorMsg ne null}">
            <c:remove var="errorMsg" scope="session"/>
            <c:remove var="Msg" scope="session"/>
        </c:if>
        </span>
        <span class="r">共有数据：<strong>${row}</strong> 条</span>
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
                <tr class="text-c">
                    <th width="100">子版块名</th>
                    <th width="130">子版块描述</th>
                    <th width="100">操作</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty sonList}">
                    <tr>
                        <td colspan="3">亲　没有子版块存在</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${sonList}" var="son" varStatus="index">
                        <tr class="text-c">
                            <td>${son.sonSectName}</td>
                            <td>${son.sonSectDescribe}</td>
                            <td class="td-manage">
                                <%--<a href="javascript:;" onclick="addSonSection('修改子版块','/section/toChange?sectionName=${son.fSectName}&sonSectionName=${son.sonSectName}&sonDescribe=${son.sonSectDescribe}','360','400');" title="修改">--%>
                                    <%--<i class="Hui-iconfont">&#xe6df;</i>--%>
                                <%--</a>--%>
                                <a type="button" href="/section/passValue?sectionName=${son.fSectName}&sonSectionName=${son.sonSectName}" style="text-decoration:none" data-toggle="modal" data-target=".bs-example-modal-delSon" title="删除">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        <div class="pagination">
            <ul>
                <li><a href="/section/listSonSection?page=1&sectionName=${sectionName}">首页</a></li>
                <c:if test="${!(page==1)}">
                    <li><a href="/section/listSonSection?page=${page-1 }&sectionName=${sectionName}">上一页</a></li>
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
                            <a href="/section/listSonSection?page=${p}&sectionName=${sectionName}">${p}</a>
                        </li>
                    </c:if>
                    <c:if test="${p ne page}">
                        <li>
                            <a href="/section/listSonSection?page=${p}&sectionName=${sectionName}">${p}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${!(page==pageCount)}">
                    <li><a href="/section/listSonSection?page=${page+1 }&sectionName=${sectionName}">下一页</a></li>
                </c:if>
                <li><a href="/section/listSonSection?page=${pageCount}&sectionName=${sectionName}">尾页</a></li>
            </ul>
        </div>

    </div>
</div>

<div  class="modal fade bs-example-modal-del" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除</h4>
            </div>
            <div class="modal-body">
                <p class="modal-title">删除后，下面的子版块也会消失哦。</p>
            </div>
            <div class="modal-footer">
                <form action="/section/deleteSection?sectionName=${sectionName}" target="_parent" method="post">
                    <button type="button" class="btn btn-primary radius" data-dismiss="modal">再考虑考虑</button>
                    <button type="submit" class="btn btn-danger radius">忍心删除</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%--
btn-primary btn-default btn-danger
--%>

<div  class="modal fade bs-example-modal-adds" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加子版块</h4>
            </div>
            <div class="modal-body">
                <form action="/section/addSonSection?sectionName=${sectionName}&pageName=/section/listSonSection" id="myform" method="post">
                    <div>
                        <label class="form-label"></label>
                        <div class="formControls">
                            <input type="text" class="input-text" placeholder="子版块名" name="sonSectionName"autocomplete="off">
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
                <button type="submit" onclick="test('myform');" formmethod="post" class="btn btn-primary radius" >添加</button>
            </div>
        </div>
    </div>
</div>

<div  class="modal fade bs-example-modal-delSon" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除</h4>
            </div>
            <div class="modal-body">
                <p class="modal-title">确认要删除该子版块？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default radius" data-dismiss="modal">取消</button>
                <a href="/section/deleteSonSection"><button type="button" class="btn btn-primary radius" >确认</button></a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    /*用户-查看*/
    function  addSonSection(title,url,w,h) {
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

</body>


</html>
