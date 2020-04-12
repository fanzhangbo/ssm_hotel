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
    <link rel="stylesheet" href="/resources/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">

    <style>
        body {
            background-color: #ffffff;
        }
        .layui-iconpicker-body.layui-iconpicker-body-page .hide {display: none;}
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">菜单名称</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="required" lay-reqtext="菜单名称不能为空" placeholder="请输入菜单名称" value="${menu.title}" class="layui-input">
            <tip>菜单名称</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">链接地址</label>
        <div class="layui-input-block">
            <input type="text" name="href" lay-verify="" lay-reqtext="链接地址不能为空" placeholder="请输入链接地址" value="${menu.href}" class="layui-input">
            <tip>链接地址</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label  class="layui-form-label">菜单图标</label>
        <div class="layui-input-block">
            <input type="text" id="iconPicker" name="icon" value="${menu.icon}" lay-filter="iconPicker" class="hide">
            <tip>菜单图标</tip>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">排序权重</label>
        <div class="layui-input-block">
            <input type="number" name="weight" lay-verify="" placeholder="请输入排序权重" value="${menu.weight}" class="layui-input">
            <tip>排序权重</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input type="radio" name="visible" value="1" title="显示" <c:if test="${menu.visible == 1}" >checked=""</c:if> >
            <input type="radio" name="visible" value="2" title="隐藏" <c:if test="${menu.visible == 2}" >checked=""</c:if> >
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" name="id" value="${menu.id}">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="/resources/js/lay-config.js" charset="utf-8"></script>
<script>
    layui.use(['iconPickerFa','form', 'layer'], function () {
        var iconPickerFa = layui.iconPickerFa,
            form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        iconPickerFa.render({
            // 选择器，推荐使用input
            elem: '#iconPicker',
            // fa 图标接口
            url: "/resources/lib/font-awesome-4.7.0/less/variables.less",
            // 是否开启搜索：true/false，默认true
            search: true,
            // 是否开启分页：true/false，默认true
            page: true,
            // 每页显示数量，默认12
            limit: 12,
            // 点击回调
            click: function (data) {
                $('#iconPicker').val('fa ' + data.icon);
            },
            // 渲染成功后的回调
            success: function (d) {
                // console.log(d);
            }
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            $.ajax({
                url:"/menu/editMenuAct",
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