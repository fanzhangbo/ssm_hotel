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
        <label class="layui-form-label required">入住时间</label>
        <div class="layui-input-inline">
            <input type="text" name="moveTime" class="layui-input" id="moveTime" placeholder="yyyy-MM-dd HH:mm:ss">
        </div>
        <label class="layui-form-label" required>到期时间</label>
        <div class="layui-input-inline">
            <input type="text" name="expireTime" class="layui-input" id="expireTime" placeholder="yyyy-MM-dd HH:mm:ss">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">房间号</label>
        <div class="layui-input-inline">
            <input type="text" id="roomNo" name="roomNo" lay-verify="required" lay-reqtext="房型面积默认为0" placeholder="请输入房型面积" value="0" class="layui-input" disabled>
            <tip>填写房型面积</tip>
        </div>
        <label class="layui-form-label required">房型</label>
        <div class="layui-input-inline">
            <input type="text" id="layoutName" name="layoutName" lay-reqtext="房型面积默认为0" placeholder="请输入房型面积" value="0" class="layui-input" disabled>
            <tip>房型</tip>
        </div>
        <label class="layui-form-label required">单价</label>
        <div class="layui-input-inline">
            <input type="text" id="layoutPrice" name="layoutPrice" value="0.00" class="layui-input" disabled>
            <tip>单价</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">顾客姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="username" lay-verify="required" lay-reqtext="顾客姓名不能为空" placeholder="请输入顾客姓名" value="" class="layui-input">
            <tip>顾客姓名</tip>
        </div>

        <label class="layui-form-label required">身份证号</label>
        <div class="layui-input-inline">
            <input type="text" name="cardNo" lay-verify="required" lay-reqtext="身份证号" placeholder="请输入身份证号" value="" class="layui-input">
            <tip>身份证号</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="gender" value="1" title="男" checked="">
            <input type="radio" name="gender" value="2" title="女">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">总价</label>
        <div class="layui-input-block">
            <input type="text" id="totalPrice" name="totalPrice" value="0.00" class="layui-input" disabled>
            <tip>总价</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" name="roomId" id="roomId">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$,
            laydate = layui.laydate;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            $.ajax({
                url:"/move/addMoveAct",
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

        var layoutPrice = parseFloat($('#layoutPrice').val());
        var move_time;
        var expire_time;
        var days = 0;
        //日期时间选择器
        laydate.render({
            elem: '#moveTime'
            ,type: 'datetime'
            ,done: function(value, date){ //监听日期被切换
                move_time = {
                    value:value,
                    date:date
                };
            }
        });
        //日期时间选择器
        laydate.render({
            elem: '#expireTime'
            ,type: 'datetime'
            ,done: function(value, date){ //监听日期被切换
                expire_time = {
                    value:value,
                    date:date
                };

                var days = getDaysBetween(move_time.value, expire_time.value);

                var total_price = days * layoutPrice;
                $('#totalPrice').val(total_price);
            }
        });

        function getDaysBetween(dateString1,dateString2){
            var startDate = Date.parse(dateString1);
            var endDate = Date.parse(dateString2);
            var days=Math.ceil((endDate - startDate)/(1*24*60*60*1000));
            return  days;
        }

    });
</script>
</body>
</html>