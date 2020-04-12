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
            <input type="text" name="moveTime" class="layui-input" value="" id="moveTime" placeholder="yyyy-MM-dd HH:mm:ss">
        </div>
        <label class="layui-form-label" required>到期时间</label>
        <div class="layui-input-inline">
            <input type="text" name="expireTime" class="layui-input" id="expireTime" value="" placeholder="yyyy-MM-dd HH:mm:ss">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">房间号</label>
        <div class="layui-input-inline">
            <input type="text" id="roomNo" name="roomNo" lay-verify="required" lay-reqtext="房型面积默认为0" placeholder="请输入房型面积" value="${room.roomNo}" class="layui-input" disabled>
            <tip>房间号</tip>
        </div>
        <label class="layui-form-label required">房型</label>
        <div class="layui-input-inline">
            <input type="text" id="layoutName" name="layoutName" lay-reqtext="房型面积默认为0" placeholder="请输入房型面积" value="${layout.area}" class="layui-input" disabled>
            <tip>房型</tip>
        </div>
        <label class="layui-form-label required">单价</label>
        <div class="layui-input-inline">
            <input type="text" id="layoutPrice" name="layoutPrice" value="${layout.price}" class="layui-input" disabled>
            <tip>单价</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">顾客姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="username" lay-verify="required" lay-reqtext="顾客姓名不能为空" placeholder="请输入顾客姓名" value="${customer.username}" class="layui-input">
            <tip>顾客姓名</tip>
        </div>

        <label class="layui-form-label required">身份证号</label>
        <div class="layui-input-inline">
            <input type="text" name="cardNo" lay-verify="required" lay-reqtext="身份证号" placeholder="请输入身份证号" value="${customer.cardNo}" class="layui-input">
            <tip>身份证号</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="gender" value="1" title="男" ${customer.gender == 1 ? "checked=''" : ""}  >
            <input type="radio" name="gender" value="2" title="女" ${customer.gender == 2 ? "checked=''" : ""}  >
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">总价</label>
        <div class="layui-input-block">
            <input type="text" id="totalPrice" name="totalPrice" value="${move.totalPrice}" class="layui-input" disabled>
            <tip>总价</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" name="id" value="${move.id}">
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
                url:"/move/editMoveAct",
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

        var move_time = getTaskTime("${move.moveTime}");
        var expire_time = getTaskTime("${move.expireTime}");
        var days = 0;
        //日期时间选择器
        laydate.render({
            elem: '#moveTime'
            ,type: 'datetime'
            ,format: 'yyyy-MM-dd HH:mm:ss'
            ,isInitValue: true
            ,value:move_time
            ,done: function(value, date){ //监听日期被切换
                move_time = value;
            }
        });
        //日期时间选择器
        laydate.render({
            elem: '#expireTime'
            ,type: 'datetime'
            ,format: 'yyyy-MM-dd HH:mm:ss'
            ,isInitValue: true
            ,value:expire_time
            ,done: function(value, date){ //监听日期被切换
                expire_time = value;
                console.log("move_time" + move_time);
                console.log("expire_time"+expire_time)
                days = getDaysBetween(move_time, expire_time);

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



    function getTaskTime(strDate) {
        if(null==strDate || ""==strDate){
            return "";
        }
        var dateStr=strDate.trim().split(" ");
        var strGMT = dateStr[0]+" "+dateStr[1]+" "+dateStr[2]+" "+dateStr[5]+" "+dateStr[3]+" GMT+0800";
        var date = new Date(Date.parse(strGMT));
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        h = h < 10 ? ('0' + h) : h;
        var minute = date.getMinutes();
        minute = minute < 10 ? ('0' + minute) : minute;
        var second = date.getSeconds();
        second = second < 10 ? ('0' + second) : second;

        return y+"-"+m+"-"+d+" "+h+":"+minute+":"+second;
    }
</script>
</body>
</html>