package com.ncu.pojo;

public class Result {
    //登录相关数据
    private boolean flag;
    private  String message;
    public boolean isFlag(){
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
