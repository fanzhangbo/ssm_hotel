<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>menu</title>
    <link rel="stylesheet" href="/resources/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="/resources/css/public.css" media="all">
    <style>
        .layui-btn:not(.layui-btn-lg ):not(.layui-btn-sm):not(.layui-btn-xs) {
            height: 34px;
            line-height: 34px;
            padding: 0 8px;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>发送消息</legend>
    </fieldset>

    <form class="layui-form" action="">

        <div class="layui-form-item">
            <label class="layui-form-label">选择接收人</label>
            <div class="layui-input-inline">
                <select name="targetId" lay-verify="required" lay-search="">
                    <c:forEach items="${users}" var="user">
                    <option value="${user.id}">${user.username}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item" pane="">
            <label class="layui-form-label">紧急程度</label>
            <div class="layui-input-block">
                <input type="radio" name="rank" value="1" title="紧急" checked="">
                <input type="radio" name="rank" value="2" title="普通">
            </div>
        </div>


        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">消息内容</label>
            <div class="layui-input-block">
                <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">发送</button>
            </div>
        </div>

    </form>
</div>

<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="/resources/js/lay-config.js?v=1.0.4" charset="utf-8"></script>

<script>
    layui.use(['form'], function () {
        var form = layui.form
            , $ = layui.jquery
            , layer = layui.layer;

        //监听提交
        form.on('submit(demo1)', function (data) {
            $.ajax({
                url:"/message/addMessageAct",
                type:"post",
                data:data.field,
                dataType:"json",
                success: function(data) {
                    var index;
                    if (data.code == 1) {
                        index = layer.alert('提交成功', {
                            title: '提交成功'
                        }, function () {
                            // 关闭弹出层
                            window.location.reload();
                        });
                    } else {
                        index = layer.alert('提交失败', {
                            title: data.msg
                        }, function () {
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