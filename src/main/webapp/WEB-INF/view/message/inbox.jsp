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
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <%--<form class="layui-form layui-form-pane" action="">--%>
            <%--<div class="layui-form-item">--%>
                <%--<div class="layui-inline">--%>
                    <%--<label class="layui-form-label">搜索用户</label>--%>
                    <%--<div class="layui-input-inline">--%>
                        <%--<input type="text" name="name" autocomplete="off" class="layui-input">--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="layui-inline">--%>
                    <%--<button type="submit" class="layui-btn layui-btn-primary" lay-submit  lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</form>--%>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-add-btn" lay-event="add"> 写消息 </button>
                <%--<button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除房型 </button>--%>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="detail">详情</a>
        </script>

    </div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

<script id="rankTpl" type="text/html">
    {{#  if(d.rank == 1){ }}
        <button type="button" class="layui-btn layui-btn-xs" style="background-color: #ff8e54">紧急</button>
    {{# } else { }}
        <button type="button" class="layui-btn layui-btn-xs" style="background-color: #46ff00">普通</button>
    {{#  } }}
</script>
<script id="readFlagTpl" type="text/html">
    {{#  if(d.readFlag == 1){ }}
        <button type="button" class="layui-btn layui-btn-xs layui-btn-primary">未读</button>
    {{# } else if(d.readFlag == 2) { }}
        <button type="button" class="layui-btn layui-btn-xs layui-btn-normal">已读</button>
    {{#  } }}
</script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '/message/getInboxMessage',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {field: 'sendId', title: '发件人', minWidth:"120", templet:'<div>{{d.sendUser.username}}</div>'},
                {field: 'rank', title: '等级', minWidth:"80", templet:'#rankTpl'},
                {field: 'readFlag', title: '是否已读', minWidth:"80", templet:'#readFlagTpl'},
                {title: '操作', templet: '#currentTableBar', minWidth:"200", align: "left"}
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

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                window.location.href="/message/addMessage"
            }
        });
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {

                var index = layer.open({
                    title: '信息详情',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/message/detail/'+data.id
                });
                $(window).on("resize", function () {
                    layer.full(index);

                });
                return false;
            }
        });

    });
</script>
<script>

</script>

</body>
</html>