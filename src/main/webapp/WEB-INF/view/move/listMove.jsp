<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <%--<form class="layui-form layui-form-pane" action="">--%>
            <%--<div class="layui-form-item">--%>
                <%--<div class="layui-inline">--%>
                    <%--<label class="layui-form-label">客户姓名</label>--%>
                    <%--<div class="layui-input-inline">--%>
                        <%--<input type="text" name="roomNo" autocomplete="off" class="layui-input">--%>
                    <%--</div>--%>
                <%--</div>--%>

                <%--<div class="layui-inline">--%>
                    <%--<button type="submit" class="layui-btn layui-btn-primary" lay-submit  lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</form>--%>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <%--<button class="layui-btn layui-btn-sm data-add-btn" lay-event="add"> 添加入住 </button>--%>
                <%--<button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除房间 </button>--%>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <%--<a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>--%>
        </script>

    </div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>


<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '/move/listMoveAct',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {field: 'id', title: 'ID', sort: true},
                {field: 'customerName', title: '客户姓名', width:"100"},
                {field: 'roomNo', title: '房间号', width:"100", sort: true},
                {field: 'moveTime', title: '入住时间', width:"200",templet : '<div>{{ formatTime(d.moveTime,"yyyy-MM-dd hh:mm:ss")}}</div>'},
                {field: 'expireTime', title: '到期时间', width:"200",templet : '<div>{{ formatTime(d.expireTime,"yyyy-MM-dd hh:mm:ss")}}</div>'},
                {field: 'totalPrice', title: '总价', width:"100"},
                {title: '操作', templet: '#currentTableBar', width:"120", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            layer.alert(result, {
                title: '最终的搜索信息'
            });

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

            return false;
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑入住',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/move/editMove/'+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });
    });

    // 格式化时间
    function formatTime(datetime, fmt) {
        if (datetime == null || datetime == 0) {
            return "";
        }
        if (parseInt(datetime) == datetime) {
            if (datetime.length == 10) {
                datetime = parseInt(datetime) * 1000;
            } else if (datetime.length == 13) {
                datetime = parseInt(datetime);
            }
        }
        datetime = new Date(datetime);
        var o = {
            "M+" : datetime.getMonth() + 1, // 月份
            "d+" : datetime.getDate(), // 日
            "h+" : datetime.getHours(), // 小时
            "m+" : datetime.getMinutes(), // 分
            "s+" : datetime.getSeconds(), // 秒
            "q+" : Math.floor((datetime.getMonth() + 3) / 3), // 季度
            "S" : datetime.getMilliseconds()
            // 毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (datetime.getFullYear() + "")
                .substr(4 - RegExp.$1.length));
        for ( var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1,
                    (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k])
                        .substr(("" + o[k]).length)));
        return fmt;
    }
</script>
<script>

</script>

</body>
</html>