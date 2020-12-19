<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/12/19
  Time: 21:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="demo.css" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>聊天页面实现</title>
    <link rel="stylesheet" href="css/demo.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2274543_i5qzpmolf1.css">
</head>
<body>
<div style="background:#0bc8f2;position: absolute;right: 1233px;height: 700px;width: 94px;top: 50px">
    <img src="images/head3.jpg" style="height: 70px;width: 70px;margin-left: 12px;margin-top: 30px" id="heading">
    <div class="icon-box">
        <i class="iconfont icon-xiugaiziliao"
           style="color: antiquewhite;font-size: 30px;left: 30px;top: 66px;position: relative" id="changeme"
           title="change-message"></i>
    </div>
    <div class="icon-box">
        <i class="iconfont icon-lianxiren"
           style="color: antiquewhite;;font-size: 30px;left: 30px;top: 106px;position: relative" title="chat"></i>
    </div>
    <div class="icon-box">
        <i class="iconfont icon-xiaoxi"
           style="font-size: 30px;left: 30px;top: 146px;position: relative;color: antiquewhite" id="xiaoxi"
           title="message"></i>
    </div>
    <div class="icon-box">
        <i class="iconfont icon-tianjia"
           style="color: antiquewhite;font-size: 30px;left: 30px;top: 176px;position: relative" id="add"
           title="add-friends"></i>
    </div>
</div>
<img src="bgp/inbg.gif" style="position: relative;top: 50px;left: 474px;height: 700px;width: 700px;background-color:#0bc8f2 ">
<div class="chatbar">
    <div class="chatbar-box">
        <div class="chatbar-contacts">
            <div class="contacts-search-box">
                <i class="iconfont icon-icon-"></i>
                <input type="text" class="search-text" placeholder="请输入要搜索的联系人">
            </div>
            <ul class="chatbar-contacts-uls" id="lists">
            </ul>
        </div>
        <div class="chatbar-messages">
            <div class="messages-title">
                <i class="iconfont icon-ren1"></i>
                <h4>黄小小</h4>
            </div>
            <div class="messages-text" id="messages-text">
                <ul class="messages-text-uls">
                    <li class="messages-text-lis">
                    </li>
                </ul>
            </div>
            <div class="messages-box">
                <textarea class="messages-content" name="" id="" cols="30" rows="10"></textarea>
                <select id="mySelect">
                    <option value="0">A说</option>
                    <option value="1">B说</option>
                </select>
                <input class="message-btn" type="button" value="发送" id="message-btn" onclick="sendmessage()">
            </div>
        </div>
        <div id="messagemanage">
            <div>
                <div class="projectList" id="projectList">
                    <div class="item">
                        <div class="times" id="alert_time"></div>
                        <div class="content">
                            <h3 class="title">标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题</h3>
                            <div class="textcontent">
                                文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容文本内容
                            </div>
                            <div class="detail"><span class="lookdetail">查看详情</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="Content-Main">
            <form action="" method="post" class="form-userInfo">
                <p>
                    <img src="images/head3.jpg"
                         style="width: 70px;height: 70px;margin-top: 40px;margin-left: 40px;top: 0px;position: relative;">
                    <span style="margin-top: 18px;margin-left: 30px;position: relative;top: -50px;">用户名:</span>
                    <input type="text" name="name" placeholder="你登录的用户名"
                           style="position: relative;margin-left: 136px;top: -40px;width: 200px">
                    <label style="margin-top: 0px;">
                        <span>姓&emsp;&emsp;名：</span>
                        <input type="text" placeholder="您的真实姓名！">
                    </label>
                    <label>
                        <span>生&emsp;&emsp;日：</span>
                        <input type="text" name="email" placeholder="填写您的出生日期！">
                    </label>
                    <label>
                        <span>电子邮件：</span>
                        <input type="email" name="email" placeholder="@.com">
                    </label>
                    <label>
                        <span>手机号码：</span>
                        <input type="text" name="phone" placeholder="输入您的电话号码!">
                    </label>
                    <label>
                        <span>个人介绍：</span>
                        <textarea id="message" name="message" placeholder="输入您的个人介绍！"></textarea>
                    </label>
                    <label>
                        <input type="button" class="button" value="保存信息" style="position: relative;margin-left: 140px">
                    </label>
            </form>
        </div>
        <div id="friend-search">
            <div style="top: 20px">
                <i class="iconfont" style="font-size: 25px;color: #0073c6;margin-left: 15px">&#xe651;</i>
                <input type="text" class="search-text" placeholder="请输入要搜索的联系人"
                       style="margin-left: 5px;margin-bottom: 10px;height: 35px;margin-top: 15px;" size="25">
                <button type="button">搜索</button>
                <hr>
            </div>
        </div>
        <div class="Content-Other">
            <form action="" method="post" class="form-userInfo">
                <p>
                    <img src="images/head3.jpg"
                         style="width: 70px;height: 70px;margin-top: 40px;margin-left: 40px;top: 0px;position: relative;">
                    <span style="margin-top: 18px;margin-left: 30px;position: relative;top: -50px;">用户名:</span>
                    <input type="text" name="name" placeholder="好友的用户名"
                           style="position: relative;margin-left: 136px;top: -40px;width: 200px">
                    <label style="margin-top: 0px;">
                        <span>姓&emsp;&emsp;名：</span>
                        <input type="text" placeholder="好友的真实姓名！">
                    </label>
                    <label>
                        <span>生&emsp;&emsp;日：</span>
                        <input type="text" name="email" placeholder="填写您的出生日期！">
                    </label>
                    <label>
                        <span>电子邮件：</span>
                        <input type="email" name="email" placeholder="@.com">
                    </label>
                    <label>
                        <span>手机号码：</span>
                        <input type="text" name="phone" placeholder="好友的电话号码!">
                    </label>
                    <label>
                        <span>个人介绍：</span>
                        <textarea id="evaluate" name="evaluate" placeholder="好友评价！"></textarea>
                    </label>
                    <label>
                        <input type="button" class="button" value="修改好友评价" style="position: relative;margin-left: 140px">
                    </label>
            </form>
        </div>
    </div>
    <script type="text/javascript" src="<%=request.getContextPath()%>/com/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/com/js/demo.js"></script>
</div>
</body>
</html>

