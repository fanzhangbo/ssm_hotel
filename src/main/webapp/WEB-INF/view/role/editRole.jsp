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
        <label class="layui-form-label required">角色名称</label>
        <div class="layui-input-block">
            <input type="text" name="roleName" lay-verify="required" lay-reqtext="角色名称不能为空" placeholder="请输入角色名称" value="${role.roleName}" class="layui-input">
            <tip>角色名称</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" name="id" value="${role.id}">
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
                url:"/role/editRoleAct",
                type:"post",
                data:data.field,
                dataType:"json",
                success: function(data) {
                    var index;
                    if (data.code == 1) {
                        index = layer.alert(data.msg, {
                            title: '提交成功'
                        }, function () {
                            window.parent.location.reload();
                            // 关闭弹出层
                            layer.close(index);
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);

                        });
                    } else {
                        index = layer.alert(data.msg, {
                            title: data.msg
                        }, function () {
                            // 关闭弹出层
                            layer.close(index);
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