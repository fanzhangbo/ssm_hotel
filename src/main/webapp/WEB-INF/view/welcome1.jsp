<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/resources/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="/resources/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="/resources/css/public.css" media="all">
    <style>
        .layui-card {border:1px solid #f2f2f2;border-radius:5px;}
        .icon {margin-right:10px;color:#1aa094;}
        .icon-cray {color:#ffb800!important;}
        .icon-blue {color:#1e9fff!important;}
        .icon-tip {color:#ff5722!important;}
        .layuimini-qiuck-module {text-align:center;margin-top: 10px}
        .layuimini-qiuck-module a i {display:inline-block;width:100%;height:60px;line-height:60px;text-align:center;border-radius:2px;font-size:30px;background-color:#F8F8F8;color:#333;transition:all .3s;-webkit-transition:all .3s;}
        .layuimini-qiuck-module a cite {position:relative;top:2px;display:block;color:#666;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;font-size:14px;}
        .welcome-module {width:100%;height:210px;}
        .panel {background-color:#fff;border:1px solid transparent;border-radius:3px;-webkit-box-shadow:0 1px 1px rgba(0,0,0,.05);box-shadow:0 1px 1px rgba(0,0,0,.05)}
        .panel-body {padding:10px}
        .panel-title {margin-top:0;margin-bottom:0;font-size:12px;color:inherit}
        .label {display:inline;padding:.2em .6em .3em;font-size:75%;font-weight:700;line-height:1;color:#fff;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25em;margin-top: .3em;}
        .layui-red {color:red}
        .main_btn > p {height:40px;}
        .layui-bg-number {background-color:#F8F8F8;}
        .layuimini-notice:hover {background:#f6f6f6;}
        .layuimini-notice {padding:7px 16px;clear:both;font-size:12px !important;cursor:pointer;position:relative;transition:background 0.2s ease-in-out;}
        .layuimini-notice-title,.layuimini-notice-label {
            padding-right: 70px !important;text-overflow:ellipsis!important;overflow:hidden!important;white-space:nowrap!important;}
        .layuimini-notice-title {line-height:28px;font-size:14px;}
        .layuimini-notice-extra {position:absolute;top:50%;margin-top:-8px;right:16px;display:inline-block;height:16px;color:#999;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12" id="listMessage">

                <c:forEach items="${msgs}" var="msg">
                    <div class="layui-card" <c:if test="${msg.rank==1}">style="background-color: #ffb830;"</c:if> >
                    <div class="layui-card-header">
                        <i class="fa fa-paper-plane-o icon"></i>
                        来自：${msg.sendUser.username}的消息
                        <span style="float: right;color: grey;">
                            <fmt:formatDate value="${msg.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                    <div class="layui-card-body layui-text layadmin-text">
                        <p>
                            ${msg.content}
                        </p>
                    </div>
                </div>
                </c:forEach>

            </div>
        </div>
    </div>
</div>
<script src="/resources/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="/resources/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab;
        miniTab.listen();
        // setInterval(function() {
        //     $.ajax({
        //         url:"/message/getUnreadMessage",
        //         dataType:"json",
        //         type: "get",
        //         success: function(data) {
        //             if (data.data.length < 1) {
        //                 return;
        //             }
        //             var h = "";
        //             for (var i in data.data) {
        //
        //                 h += '<div class="layui-card" ';
        //                 if (data.data[i].rank == 1) {
        //                     h += 'style="background-color: #ffb830;"'
        //                 }
        //                 h += ' ><div class="layui-card-header"><i class="fa fa-paper-plane-o icon"></i>' +
        //                     '来自：' + data.data[i].sendUser.username + '的消息' +
        //                     '<span style="float: right;color: grey;">' +
        //                     formatDate(data.data[i].createTime) +
        //                     '</span></div><div class="layui-card-body layui-text layadmin-text"><p>' +
        //                     data.data[i].content + '</p></div></div>'
        //             }
        //             $("#listMessage").html(h)
        //         }
        //     })
        // }, 2000);


        function formatDate(date, format) {

            if (!format) format = "yyyy-MM-dd HH:mm:ss";
            date = new Date(parseInt(date));
            var dict = {
                "yyyy": date.getFullYear(),
                "M": date.getMonth() + 1,
                "d": date.getDate(),
                "H": date.getHours(),
                "m": date.getMinutes(),
                "s": date.getSeconds(),
                "S": ("" + (date.getMilliseconds() + 1000)).substr(1),
                "MM": ("" + (date.getMonth() + 101)).substr(1),
                "dd": ("" + (date.getDate() + 100)).substr(1),
                "HH": ("" + (date.getHours() + 100)).substr(1),
                "mm": ("" + (date.getMinutes() + 100)).substr(1),
                "ss": ("" + (date.getSeconds() + 100)).substr(1)
            };
            return format.replace(/(y+|M+|d+|H+|s+|m+|S)/g,
                function(a) {
                    return dict[a];
                });
        }





    });
</script>
</body>
</html>
