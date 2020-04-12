<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <label class="layui-form-label required">房型名</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" lay-reqtext="房型名不能为空" placeholder="请输入房型名" value="" class="layui-input">
            <tip>填写房型名称</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">房型价格</label>
        <div class="layui-input-block">
            <input type="text" name="price" lay-verify="required" lay-reqtext="房型价格默认为0" placeholder="请输入房型价格" value="0" class="layui-input">
            <tip>填写房型价格</tip>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">房型面积</label>
        <div class="layui-input-block">
            <input type="text" name="area" lay-verify="required" lay-reqtext="房型面积默认为0" placeholder="请输入房型面积" value="0" class="layui-input">
            <tip>填写房型面积</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
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
            console.log(data)
            $.ajax({
                url:"/layout/addLayoutAct",
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
                            window.parent.location.reload();
                            layer.close(index);
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);

                        });
                    } else {
                        index = layer.alert('提交失败', {
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