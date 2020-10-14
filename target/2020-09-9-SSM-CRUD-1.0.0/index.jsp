<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/9/9
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--引入JQurey--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入Bootstrap框架样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 修改员工的模态框 -->
<div class="modal fade" id="updateEmpModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" id="updateEmpForm">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empNameP"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10" id="updateEmailDiv">
                            <input type="text" name="email" class="form-control" id="updateEmail" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="updateGenderM" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="updateGenderW" value="W"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="dId" id="updateNameSelect">

                            </select>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateEmp">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 添加员工的模态框 -->
<div class="modal fade" id="addEmpModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" id="addEmpForm">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputEmpName"
                                   placeholder="EmpName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10" id="emailDiv">
                            <input type="text" name="email" class="form-control" id="inputEmail" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="putGenderM" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="putGenderW" value="W"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="dId" id="deptNameSelect">

                            </select>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveEmp">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--搭建显示页面--%>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <%--按钮--%>
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="addEmp">新增</button>
            <button class="btn btn-danger deleteAnyEmp" id="deleteEmp">删除</button>
        </div>
    </div>
    <div class="row">
        <%--显示表格数据--%>
        <div class="col-md-12">
            <br>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="checkedAll">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="info">

                </tbody>
            </table>
        </div>
    </div>
    <div class="row" id="pageDiv">
        <%-- 显示分页信息
         <div class="col-md-6">
             当前页数：${pageInfo.pageNum}&nbsp;&nbsp;&nbsp;总页数：${pageInfo.pages}<br>
             总记录数:${pageInfo.total}
         </div>
         分页条--%>

    </div>
</div>
<script type="text/javascript">
    //定义全局变量，记录总页码
    var totalPages;
    //定义全部变量，记录部门信息
    var deptData;
    //定义全局变量，记录输入框的样式
    var inputLike;
    //定义全局变量
    var pageNum;

    $(function () {
        toPage(1);
    });

    function toPage(pn) {

        $("#info").empty();
        $("#pageDiv").empty();
        $("#pageDiv").empty();
        $.ajax({
            url: "${APP_PATH}/emps",
            type: "GET",
            data: "pn=" + pn,
            success: function (data) {
                creatEmpMsg(data);
                showPage(data);
                showPageNum(data)
            }
        });
    }

    //分页条
    function showPageNum(data) {
        //div容器
        var pageDiv = $("<div></div>").addClass("col-md-6");

        //首页和末页
        var firstPage = $("<li></li>").append($("<a></a>").attr("href", "#").append("首页"));
        var lastPage = $("<li></li>").append($("<a></a>").attr("href", "#").append("末页"));
        //给首页和末页绑定单击时间
        firstPage.click(function () {
            toPage(1);
        });
        lastPage.click(function () {
            toPage(data.map.pageInfo.pages);
        });
        //外部nav标签
        var nav = $("<nav></nav>");
        //外部ul标签
        var ul = $("<ul></ul>").addClass("pagination");
        ul.append(firstPage)
        //跳转至前一页和后一页的标签
        var beforeLi = $("<li></li>").attr("id", "beforeLi").append($("<a></a>").attr("href", "#").append($("<span></span>").append("&laquo;")));
        var lastPageLi = $("<li></li>").attr("id", "lastLi").append($("<a></a>").attr("href", "#").append($("<span></span>").append("&raquo;")))
        //给前一页和后一页绑定单击事件
        beforeLi.click(function () {
            if (data.map.pageInfo.pageNum > 1) {
                toPage(data.map.pageInfo.pageNum - 1);
            }
        });
        lastPageLi.click(function () {
            if (data.map.pageInfo.pageNum < data.map.pageInfo.pages) {
                toPage(data.map.pageInfo.pageNum + 1);
            }
        });
        if (!data.map.pageInfo.hasPreviousPage) {
            beforeLi.addClass("disabled");
            firstPage.addClass("disabled")
        }
        if (!data.map.pageInfo.hasNextPage) {
            lastPageLi.addClass("disabled")
            lastPage.addClass("disabled")
        }
        var ulLI = ul.append(beforeLi);
        var navUlLi = nav.append(ulLI);
        var pageDivNav = pageDiv.append(navUlLi);
        contPageNum(ul, data);

        $("#pageDiv").append(pageDivNav);
        ul.append(lastPageLi);
        ul.append(lastPage)
    }

    //分页条中连续显示的页码
    function contPageNum(ul, data) {
        var navs = data.map.pageInfo.navigatepageNums;
        $.each(navs, function (index, page) {
            var li = $("<li></li>").append($("<a></a>").attr("href", "#").append(page));

            if (page == data.map.pageInfo.pageNum) {
                li.addClass("active")
            }
            ul.append(li);
            li.click(function () {
                toPage(page);
            });
        })
        //给全局变量totalPages赋值，便于跳转使用
        totalPages = data.map.pageInfo.pages;
    }

    function showPage(data) {
        var page = data.map.pageInfo;
        var pageDiv = $("<div></div>").addClass("col-md-6").append("当前页数:" + page.pageNum + "总页数"
            + page.pages + "</br>" + "总记录数:" + page.total);
        pageNum = page.pageNum;
        $("#pageDiv").append(pageDiv);
    };


    //解析显示员工信息
    function creatEmpMsg(data) {
        var emps = data.map.pageInfo.list;
        $.each(emps, function (index, item) {

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>")
                .addClass("glyphicon glyphicon-pencil")).append("编辑");
            //给编辑按钮添加一个员工属性的id
            editBtn.attr("editId", item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm deleteEmp").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //给删除按钮添加一个员工属性的id
            deleteBtn.attr("deleteId", item.empId);
            var checkedEmp = $("<th></th>").append($("<input type='checkbox' class='checkOne'>"));
            $("#info").append($("<tr></tr>").append(checkedEmp)
                .append("<th>" + item.empId)
                .append("</th>")
                .append("<th>" + item.empName)
                .append("</th>")
                .append("<th>" + (item.gender == "M" ? "男" : "女"))
                .append("</th>")
                .append("<th>" + item.email)
                .append("</th>")
                .append("<th>" + item.department.deptName)
                .append("</th>")
                .append(editBtn).append("&nbsp;").append(deleteBtn)
            )
        });
    };
    //给编辑按钮绑定事件，打开修改员工的模态框
    $(document).on("click", ".edit_btn", function () {
        getDeptName($("#updateNameSelect"));
        getEmp($(this).attr("editId"));
        $("#updateEmpModel").modal({
            backdrop: "static"
        });
        //给修改员工的模态框的保存按钮添加editId属性，记录需要修改的员工的id
        $("#updateEmp").attr("editId", $(this).attr("editId"));
    })


    //获取要修改的员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/getEmp/" + id,
            type: "GET",
            success: function (data) {
                var empName = data.map.emp.empName;
                var empEmail = data.map.emp.email;
                var empGender = data.map.emp.gender;
                var empDid = data.map.emp.dId;
                $("#empNameP").text(empName);
                $("#updateEmail").val(empEmail);
                if ("M" == empGender) {
                    $("#updateGenderM").prop("checked", "checked");
                } else {
                    $("#updateGenderW").prop("checked", "checked");
                }
                $("#updateEmpModel select").val([empDid]);
            }
        });
    }


    //给新增员工添加事件，打开添加员工的模态框
    $("#addEmp").click(function () {
        //打开表单之前，发送ajax请求，查询部门信息，显示在表单中的下拉列表中
        getDeptName($("#deptNameSelect"));

        $("#addEmpModel").modal({
            backdrop: "static"
        });
    });

    //发送ajax请求，查询部门信息，显示在表单中的下拉列表中
    function getDeptName(element) {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (data) {
                console.log(data);
                showDepts(data, element);

            }
        });
    }


    //在模态框的部门下拉列表中展示部门信息
    function showDepts(data, element) {
        deptData = data;
        showDepartmentInSelect(data, element);
    }

    //在模态框中获取部门信息
    function showDepartmentInSelect(data, element) {
        $(element).empty();
        $.each(data.map.depts, function (index, result) {
            var optionDept = $("<option></option>").attr("value", data.map.depts[index].deptId).append(data.map.depts[index].deptName);
            $(element).append(optionDept);
        });
    }

    /* $("#inputEmpName").focus(function () {
         $("#inputEmpName").addClass(inputLike);
     });*/

    //给用户名输入框绑定丢失焦点事件，使用正则表达式进行用户名的格式验证
    $("#inputEmpName").blur(function () {
        $("#inputEmpName").parent().addClass(inputLike);
        //发起ajax请求之前对表单内容进行校验
        var empNameElt = /^[a-zA-Z0-9_-]{4,16}$/;

        if (!empNameElt.test($("#inputEmpName").val())) {
            inputLike = "";
            inputLike = "has-error";
            checkMsg($("#inputEmpName").parent(), inputLike, "用户名可以是2-5位中文或者6-16位英文和数字的组合!");
        } else {
            inputLike = "";
            inputLike = "has-success";
            checkMsg($("#inputEmpName").parent(), inputLike, "");
        }
    });
    //给email输入框绑定丢失焦点事件，使用正则表达式进行邮箱格式验证
    $("#inputEmail").blur(function () {
        var emailElt = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!emailElt.test($("#inputEmail").val())) {
            inputLike = "";
            inputLike = "has-error";
            checkMsg($("#inputEmail").parent(), inputLike, "邮箱格式不正确！");
        } else {
            inputLike = "";
            inputLike = "hasuccesss-";
            checkMsg($("#inputEmail").parent(), inputLike, "");
        }
    });
    //给保存按钮绑定单击事件，校验后添加员工
    $("#saveEmp").click(function () {
        var emailElt = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        var empNameElt = /^[a-zA-Z0-9_-]{4,16}$/;
        if (emailElt.test($("#inputEmail").val()) && empNameElt.test($("#inputEmpName").val())) {
            checkEmail($("#inputEmail").val());
        }
    });

    //向后台发起ajax请求，添加员工
    function addEmp() {
        $.ajax({
            url: "${APP_PATH}/add",
            type: "POST",
            data: $("#addEmpForm").serialize(),
            success: function (data) {
                /*var empNameErrorMsg = data.map.errorMap.empName;
                var emailErrorMsg = data.map.errorMap.email;*/
                if (undefined == data.map.errorMap.empName) {
                    checkMsg($("#inputEmpName").parent(), "has-error", empNameErrorMsg);
                    return false;
                } else if (undefined == data.map.errorMap.email) {
                    checkMsg($("#inputEmail").parent(), "has-error", emailErrorMsg);
                    return false;
                }
                $("#addEmpForm")[0].reset();
                $("#addEmpModel").modal('hide');
                toPage(totalPages);
            }
        });
    }

    //给email输入框绑定获取焦点事件，清空span中的校验内容
    $("#inputEmail").focus(function () {
        $("#inputEmail").next("span").text("");
    });

    //发起ajax请求，检测数据库中是否存在重复的email
    function checkEmail(data) {
        $.ajax({
            url: "${APP_PATH}/checkEmail",
            data: "email=" + data,
            type: "GET",
            success: function (data) {
                if (!data.map.result) {
                    $("#inputEmail").val("");
                    checkMsg($("#inputEmail").parent(), "has-error", "邮箱已存在！");
                    return false;
                }
                addEmp();
            }
        });
    }

    //校验后，给表单中的span元素添加样式和内容
    function checkMsg(element, status, message) {
        $(element).removeClass(inputLike);
        $(element).addClass(status);
        $(element).next("span").text(message);
    }

    //给修改员工的模态框的保存按钮绑定事件
    $("#updateEmp").click(function () {
        var formMSg = $("#updateEmpForm").serialize();
        $.ajax({
            url: "${APP_PATH}/updateEmp/" + $(this).attr("editId"),
            data: formMSg,
            type: "PUT",
            success: function (data) {
                $("#updateEmpModel").modal("hide");
                toPage(pageNum);
            }
        });
    });

    //给删除按钮绑定单击事件
    $(document).on("click", ".deleteEmp", function () {
        //获取要删除的员工的name
        var empName = $(this).parents("tr").find("th:eq(2)").text();
        //打开提示框
        if (confirm("确定要删除【" + empName + "】吗？")) {
            //点击确认发起ajax请求，删除该员工
            $.ajax({
                url: "${APP_PATH}/deleteEmp/" + $(this).attr("deleteId"),
                type: "DELETE",
                success: function (data) {
                    toPage(pageNum);
                }
            });
        }
    })

    //给checkbox复选框绑定事件，完成全选
    $("#checkedAll").click(function () {
        //将下方所有的复选框的状态设置为和全选复选框匹配
        $(".checkOne").prop("checked", $(this).prop("checked"));
    });

    //给下方所有的单选复选框绑定事件，当所有都选中时，全选复选框随之选中
    $(document).on("click", ".checkOne", function () {
        $("#checkedAll").prop("checked", $(".checkOne:checked").length == $(".checkOne").length);
    })


    $("#deleteEmp").click(function () {
        var empName = "";
        var empId = "";
        $.each($(".checkOne:checked"),function () {
            empName += $(this).parent().parent().find("th:eq(2)").text() + ",";
            empId += $(this).parent().parent().find("th:eq(1)").text() + "-";
        });
        empName = empName.substring(0, empName.length - 1);
        empId = empId.substring(0, empId.length - 1);
        if (confirm("确定要删除【" + empName + "】吗？")) {
            //发起ajax请求，进行批量删除数据
            $.ajax({
                url: "${APP_PATH}/deleteEmp/" + empId,
                type: "DELETE",
                success: function (data) {
                    toPage(pageNum);
                }
            });
        }
    });
</script>
</body>
</html>
