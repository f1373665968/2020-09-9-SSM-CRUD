<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/9/9
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:forward page="/emps"></jsp:forward>--%>

<html>
<head>
    <title>Title</title>
    <%--引入JQurey--%>
    <script type="text/javascript" src="static/js/jquery-1.12.4.min.js"></script>
    <%--引入Bootstrap框架样式--%>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js">
        $(function () {
            $.ajax({
                url: "/emps",
                type:"get",
                data:"json",
                success:function (data) {
                    //每次查询都清空旧数据
                    $("#info").html("");
                    //循环遍历data查询新的数据
                    $.each(data,function (i,n) {
                        $("#info").append("<tr>")
                            .append("<td>"+ n.id).append("<td/>")
                            .append("<td>"+ n.name).append("<td/>")
                            .append("<td>"+ n.age).append("<td/>")
                            .append("<tr/>")
                    })
                }
            })
        })
    </script>

</head>
<body>
<a href="emps.do">跳转</a>

</body>
</html>
