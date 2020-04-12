<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/resources/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="/resources/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" lay-reqtext="姓名不能为空" placeholder="请输入姓名" value="${user.username}" class="layui-input" disabled>
            <tip>姓名</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">密码</label>
        <div class="layui-input-block">
            <input type="password" name="password" lay-verify="" lay-reqtext="密码不能为空" placeholder="请输入密码" value="" class="layui-input">
            <tip>密码</tip>
        </div>
    </div>

    <c:if test="${user.id != 1}">
        <div class="layui-form-item">
            <label class="layui-form-label">角色</label>
            <div class="layui-input-block">
                <c:forEach items="${roles}" var="role">
                    <c:if test="${checkedRoles.contains(role.id)}" ><input type="checkbox" checked="" title="${role.roleName}" disabled></c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="gender" value="1" title="男" <c:if test="${user.gender == 1}" >checked=""</c:if> >
            <input type="radio" name="gender" value="2" title="女" <c:if test="${user.gender == 2}" >checked=""</c:if> >
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <c:if test="${user.locked == 1}" ><input type="radio" value="1" title="可用" checked="" ></c:if>
            <c:if test="${user.locked == 2}" ><input type="radio" value="2" title="禁用" checked="" ></c:if>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" name="id" value="${user.id}">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {

            $.ajax({
                url:"/user/profileAct",
                type:"post",
                data:data.field,
                dataType:"json",
                success: function(data) {
                    var index;
                    if (data.code == 1) {
                        index = layer.alert(data.msg, {
                            title: '提交成功'
                        }, function () {
                            window.location.reload();
                        });
                    } else {
                        index = layer.alert(data.msg, {
                            title: data.msg
                        });
                    }

                }
            });
            return false;
        });

    });
</script>
</body>
</html>