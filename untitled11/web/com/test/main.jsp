<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/12/19
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/12/18
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>PC聊天</title>
    <link rel="stylesheet" href="chat4.css">
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script>
        var toName;
        var userName;

        //点击头像事件
        function showChat(name){
            toName=name;
            $("#chatArea").css("display","inline");
            //清空聊天区
            $("#msgs").html("");
            $("#chatMes").html("<h3>"+toName+"</h3>");

            //sessionStorage
            var chatData=sessionStorage.getItem(toName);
            if(chatData != null){
                //将聊天记录渲染到聊天区
                $("#msgs").html(chatData)
            }
        }
        $(function (){
            $.ajax({
                url:"getUsername",
                success:function (res) {
                    userName=res;
                    $("#uname").html(userName)
                }
            })
            //创建websocket对象
            var ws = null;
            //判断当前浏览器是否支持WebSocket
            if ('WebSocket' in window) {
                ws = new WebSocket("ws://localhost:8080/chat");
            }
            else {
                alert('当前浏览器 Not support websocket')
            }

            //连接发生错误的回调方法
            ws.onerror = function () {
                alert("WebSocket连接发生错误");
            };
            //给ws绑定事件
            ws.onopen= function(){
                //建立连接后做什莫
                $("#uname").html(userName)
            }

            ws.onmessage= function(evt){
                //获取服务端推送到消息
                var datastr=evt.data;
                //将datastr转化为json
                var res=JSON.parse(datastr);
                //判断是否是系统消息
                if(res.isSystem){
                    var names=res.message;
                    //是系统消息
                    //好友列表展示
                    var userliststr="";
                    for(var name of names){
                        if(name != userName) {
                            userliststr += " <div class=\"list-box\" onclick='showChat(\"" + name + "\")'><img class=\"chat-head\" src=\"../static/img/img-header2.jpg\" alt=\"\">\n" +
                                "                <div class=\"chat-rig\"><p class=\"title\">" + name + "</p>\n" +
                                "                    </div>" +
                                "            </div>";
                        }
                    }
                    //渲染好友列表
                    $("#userlist").html(userliststr);
                }else{
                    //不是系统消息
                    //将服务端推送的消息进行展示

                    var str="                        <li class=\"other\">\n" +
                        "                            <div class=\"avatar\"><img src=\"/img/img-header2.jpg\" alt=\"\"></div>\n" +
                        "                            <div class=\"msg\">\n" +
                        "                                <p class=\"msg-text\">"+res.message+" <emoji class=\"pizza\"></emoji></p>\n" +
                        "                                <time>20:18</time>\n" +
                        "                            </div>\n" +
                        "                        </li>";

                    if(toName==res.fromName){
                        $("#msgs").append(str);
                    }
                    var chatData=sessionStorage.getItem(res.fromName);
                    if(chatData!= null){
                        str = chatData+str;
                    }
                    sessionStorage.setItem(res.fromName,str);
                }
            }

            ws.onclose=function(){

            }

            $("#submit1").click(function () {
                //获取输入内容
                var data=$("#contest_test").val();
                //清空输入区
                $("#contest_test").val("");

                var json={"toName":toName,"message":data};

                //将消息数据展示在聊天区
                var str="<li class=\"self\">\n" +
                    "                            <div class=\"avatar\"><img src=\"../static/img/img-header2.jpg\" alt=\"\"></div>\n" +
                    "                            <div class=\"msg\">\n" +
                    "                                <p class=\"msg-text\">"+data+"<emoji class=\"pizza\"></emoji></p>\n" +
                    "                                <time>20:18</time>\n" +
                    "                            </div>\n" +
                    "                        </li>";
                $("#msgs").append(str);

                var chatData=sessionStorage.getItem(toName);
                if(chatData!= null){
                    str = chatData+str;
                }
                sessionStorage.setItem(toName,str);
                //发送数据给服务端
                ws.send(JSON.stringify(json));
            });


        });
    </script>
</head>
<body>
<div class="main">
    <div class="top">
        <div class="top-left">
            <div class="header" ></div>
            <div class="search">
                <input type="text">
                <i class="icon-sear"></i>
            </div>
        </div>
        <div class="top-type">
            <a href="#" class="news icon-site"></a>
            <a href="#" class="friend icon-site"></a>
            <a href="#" class="file icon-site"></a>
        </div>
        <div class="top-right"id="uname">
        </div>
    </div>
    <div class="box">
        <div class="chat-list"  id="userlist">
            <!-- </div>
             <div class="list-box select" onclick='showChat("宋温暖")'><img class="chat-head" src="../static/img/img-header.jpeg" alt="">
                 <div class="chat-rig"><p class="title">宋温暖</p>
                     <p class="text">在？</p></div>
             </div>
             <div class="list-box" onclick='showChat("安安安")'><img class="chat-head" src="../static/img/img-header2.jpg" alt="">
                 <div class="chat-rig"><p class="title">安安安</p>
                     <p class="text">你好，我这里有个任务帮我做一下</p></div>
             </div>-->
        </div>
        <div class="box-right"id="chatArea" style="display: none;">
            <div class="recvfrom">
                <div class="nav-top" id="chatMes">
                    <!--正在聊天的人的名字-->
                    <!--<p>公众号</p>-->
                </div>
                <div class="news-top">
                    <ul id="msgs">
                        <!--对方的话-->
                        <!--<li class="other">
                            <div class="avatar"><img src="../static/img/img-header2.jpg" alt=""></div>
                            <div class="msg">
                                <p class="msg-name">宋温暖</p>
                                <p class="msg-text">请接下这个活 <emoji class="pizza"></emoji></p>
                                <time>20:18</time>
                            </div>
                        </li>-->
                        <!--自己的话-->
                        <!--<li class="self">
                            <div class="avatar"><img src="../static/img/img-header2.jpg" alt=""></div>
                            <div class="msg">
                                <p class="msg-name">安安安</p>
                                <p class="msg-text">请接下这个下这个活请接下接下这个活请接下接下这个活请接下下这个活请接下这个活<emoji class="pizza"></emoji></p>
                                <time>20:18</time>
                            </div>
                        </li>-->
                    </ul>
                </div>
            </div>
            <div class="sendto">
                <div class="but-nav">
                    <ul>
                        <li class="font"></li>
                        <li class="face"></li>
                        <li class="cut"></li>
                        <li class="page"></li>
                        <li class="old"></li>
                    </ul>
                </div>
                <!--编写消息的区域-->
                <div class="but-text">
                    <textarea name="" id="contest_test" cols="110" rows="6"></textarea>
                    <div class="button" id="submit1">发送</div>
                </div>
            </div>
        </div>

    </div>


</div>

</body>
</html>
