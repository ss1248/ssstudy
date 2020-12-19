package com.ncu.pojo;

public class ResultMessage {
    //服务端给客户端发送的数据
    private boolean isSystem;
    private String fromName;
    private  Object message;

    public boolean getIsSystem() {
        return isSystem;
    }

    public void setISSystem(boolean isSystem) {
        this.isSystem = isSystem;
    }

    public String getFromName() {
        return fromName;
    }

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public Object getMessage() {
        return message;
    }

    public void setMessage(Object message) {
        this.message = message;
    }
}
