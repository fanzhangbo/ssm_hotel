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

        <form class="layui-form layui-form-pane" action="">
            <div class="layui-form-item">


                <div class="layui-inline">
                    <label class="layui-form-label">房间号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="roomNo" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-input-inline">
                    <select name="status" lay-filter="aihao">
                        <option value="0">请选择状态</option>
                        <option value="1">空房</option>
                        <option value="2">打扫</option>
                        <option value="3">维修</option>
                        <option value="4">有人</option>
                    </select>
                </div>

                <div class="layui-inline">
                    <button type="submit" class="layui-btn layui-btn-primary" lay-submit  lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                </div>
            </div>
        </form>


        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-add-btn" lay-event="add"> 添加房间 </button>
                <%--<button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除房间 </button>--%>

            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>

            {{#  if(d.status == 1){ }}
            <a class="layui-btn layui-btn-xs data-count-warm" lay-event="move">入住</a>
            {{#  } }}
         </script>

    </div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

<script id="statusTpl" type="text/html">
{{#  if(d.status == 1){ }}
<button type="button" class="layui-btn layui-btn-normal layui-btn-xs" >空房</button>
{{# } else if(d.status == 2) { }}
<button type="button" class="layui-btn layui-btn-warm layui-btn-xs">打扫</button>
{{# } else if(d.status == 3) { }}
<button type="button" class="layui-btn layui-btn-danger layui-btn-xs">维修</button>
{{# } else if(d.status == 4) { }}
<button type="button" class="layui-btn layui-btn-primary layui-btn-xs">有人</button>
{{#  } }}
</script>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '/room/listRoomAct',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {field: 'roomNo', title: '房间号', align: "center", sort: true,width:100},
                {field: 'layoutName', title: '房型', width:"100" , align: "center", templet:'<div>{{ d.layout.name }}</div>'},
                {field: 'price', title: '价格', width:"100", align: "center", sort: true,templet:'<div>{{ d.layout.price }}</div>'},
                {field: 'area', title: '面积', align: "center",width:"200", sort: true,templet:'<div>{{ d.layout.area }}</div>'},
                {field: 'status', title: '状态', align: "center", templet:'#statusTpl',width:80},
                {title: '操作', templet: '#currentTableBar', align: "left",width:200}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {

            //执行搜索重载
            table.reload('currentTableId', {
                url:"/room/searchRoom",
                page: {
                    curr: 1
                }
                , where: {
                    roomNo:data.field.roomNo,
                    status:data.field.status
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加房间',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/room/addRoom',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'move') {  // 监听入住操作

                var index = layer.open({
                    title: '入住房间',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/move/addMove',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });


            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑房间',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/room/editRoom/'+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'move') {  // 监听入住操作
                console.log(obj)
                var index = layer.open({
                    title: '入住房间',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/move/addMove',
                    success: function(layero, index){
                        layer.getChildFrame('#roomNo', index).val(obj.data.roomNo);
                        layer.getChildFrame('#layoutName', index).val(obj.data.layout.name);
                        layer.getChildFrame('#roomId', index).val(obj.data.id);
                        layer.getChildFrame('#layoutPrice', index).val(obj.data.layout.price);
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });


            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                        url:"/room/deleteRoomAct",
                        type:"post",
                        data:{id:data.id},
                        dataType:"json",
                        success: function(data) {
                            if (data.code == 1) {
                                obj.del();
                            } else {
                                var index = layer.alert("删除失败", {
                                    title: data.msg
                                });
                            }

                        }
                    });
                    layer.close(index);
                });
            }
        });

    });
</script>
<script>

</script>

</body>
</html>