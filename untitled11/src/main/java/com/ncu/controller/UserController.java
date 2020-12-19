package com.ncu.controller;

import com.ncu.pojo.Result;
import com.ncu.pojo.User;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
public class UserController {
    @RequestMapping("/login")
    public Result login(User user, HttpSession session) {
        Result result = new Result();
        if (user != null && "123".equals(user.getPassword())) {
            result.setFlag(true);
            session.setAttribute("user", user.getUsername());
        } else {
            result.setFlag(false);
            result.setMessage("登陆失败");
        }
        return result;
    }
    @RequestMapping("/getUsername")
    public String getUsername(HttpSession session){
        String username=(String)session.getAttribute("user");
        return username;
    }
}