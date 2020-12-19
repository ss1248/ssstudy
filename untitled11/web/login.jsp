<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js">
    </script>
    <script>
        $(function(){
            $("#btn").click(function(){
                $.get("login",$("#loginForm").serialize(),function(res){
                    if(res.flag){
                        location.href="main.jsp";
                    }else{
                        $("#err_msg").html(res.message);
                    }
                },"json");
            });
        })
    </script>
</head>
<body>

<form id="loginForm">
    账号: <input type="text" name="username"/><br>
    密码: <input type="text" name="password"/><br>
</form>
<button id="btn">登录</button>
<div id="err_msg"> </div>

</body>
</html>
