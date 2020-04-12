<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <div class="layuimini-main">
        <div>
            <div class="layui-btn-group">
                <button class="layui-btn" id="addTopMenu">添加一级菜单</button>
            </div>
            <table id="demoTreeTable1" class="layui-table" lay-filter="munu-table"></table>
        </div>
    </div>
</div>


<!-- 表格操作列 -->
<script type="text/html" id="demoTreeTableBar1">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="addChild">添加子菜单</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="visibletpl">
{{# if (d.visible == 1) { }}
    <a class="layui-btn layui-btn-normal layui-btn-xs">显示</a>
{{# } else { }}
    <a class="layui-btn layui-btn-primary layui-btn-xs">隐藏</a>
{{# } }}
</script>

<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="/resources/js/lay-config.js?v=1.0.4" charset="utf-8"></script>

<script>
    layui.use(['layer', 'treeTable'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var treeTable = layui.treeTable;

        // 渲染表格
        var insTb = treeTable.render({
            elem: '#demoTreeTable1',
            toolbar: '#toolbarDemo',
            tree: {
                iconIndex: 0,
                idName: "id",
                childName: "child",
                openName: "child"
            },
            cols: [
                {field: 'title', title: '名称', minWidth: 200},
                {field: 'href', title: '链接', minWidth: 200, align:"center"},
                {field: 'weight', title: '排序', width: 60, align:"center"},
                {field: 'visible', title: '显示', minWidth: 80, align:"center", templet:"#visibletpl"},
                {align: 'center', toolbar: '#demoTreeTableBar1', title: '操作', minWidth: 350, align:"center"}
            ],
            reqData: function(data, callback) {
                // 在这里写ajax请求，通过callback方法回调数据
                $.get('/menu/listMenuAct', function (res) {
                    callback(res.data);  // 参数是数组类型
                });
            },
            style: 'margin-top:0;'
        });
        treeTable.on('tool(demoTreeTable1)', function (obj) {
            var data = obj.data;  // 获得当前行数据
            var event = obj.event; // 获得lay-event对应的值
            if (event == 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                        url:"/menu/deleteMenuAct",
                        type:"post",
                        data:{id:data.id},
                        dataType:"json",
                        success: function(data) {
                            if (data.code == 1) {
                                obj.del(); // 删除对应行，并更新缓存
                            } else {
                                var index = layer.alert(data.msg, {
                                    title:"提示"
                                });
                            }

                        }
                    });
                    layer.close(index);
                });
            } else if (event == 'edit') {
                var index = layer.open({
                    title: '编辑菜单',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/menu/editMenu/'+data.id
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });

                // obj.update({title: 'newname'});
            } else if (event == 'addChild') {
                var index = layer.open({
                    title: '添加子菜单',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '/menu/addMenu/',
                    success: function(layero, index){
                        layer.getChildFrame('#pid', index).val(data.id);
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });


        $('#addTopMenu').click(function () {
            var index = layer.open({
                title: '添加一级菜单',
                type: 2,
                shade: 0.2,
                maxmin:true,
                shadeClose: true,
                area: ['100%', '100%'],
                content: '/menu/addMenu/',
                success: function(layero, index){
                    layer.getChildFrame('#pid', index).val(0);
                }
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
        });

        $(document).on('mouseenter', '*[lay-tips]', function () {
            layer.tips($(this).attr('lay-tips'), this, {tips: [1, '#FF5722'], time: -1});
        }).on('mouseleave', '*[lay-tips]', function () {
            layer.closeAll('tips');
        });

        setTimeout(function () {
            $('body').children('.page-loading').hide();
            $('body').removeClass('page-no-scroll');
        }, 150);

    });
</script>
</body>
</html>