package com.ncu.ws;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ncu.pojo.Message;
import com.ncu.utils.MessageUtils;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/chat",configurator = GetHttpSessionConfigurator.class)
@Component
public class ChatEndpoint {

    //用来存储每个客户端对象对应的ChatEndpoint对象
    private static Map<String,ChatEndpoint> onlineUser=new ConcurrentHashMap<String, ChatEndpoint>();

    //声明Session对象，通过该对象可以发送消息给指定的用户
    private Session session;

    //声明HttpSession对象，在HttpSession中存放了用户名
    private HttpSession httpSession;

    @OnOpen
    public  void onOpen(Session session, EndpointConfig config){
        //将局部session赋值给成员session
        this.session=session;
        //获取httpSession对象
        HttpSession httpSession=(HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        this.httpSession=httpSession;

        String username=(String)httpSession.getAttribute("user");
        //将对象存储在容器中
        onlineUser.put(username,this);

        //将当前在线用户的用户名推送给所有客户端
        //1获取消息
        String message= MessageUtils.getMessage(true,null,getNames());
        //2推送给所有客户端
        broadcastAllUsers(message);
    }

    private void broadcastAllUsers(String message) {
        try {

            //将消息推送给所有客户端
            Set<String> names = onlineUser.keySet();
            for (String name : names) {
                ChatEndpoint chatEndpoint = onlineUser.get(name);
                chatEndpoint.session.getBasicRemote().sendText(message);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    private Set<String> getNames(){
        return onlineUser.keySet();
    }

    @OnMessage
    public  void onMessage(String message,Session session) {
        try {
            //将message转换成message对象
            ObjectMapper mapper = new ObjectMapper();
            Message mess=mapper.readValue(message,Message.class);
            //获取要将数据要发送的用户
            String toName=mess.getToName();
            //获取消息数据
            String data=mess.getMessage();
            //获取当前登录的用户
            String username=(String) httpSession.getAttribute("user");
            //获取推送给指定用户的消息格式的数据
            String resultMessage= MessageUtils.getMessage(false,username,data);
            //发送数据
            onlineUser.get(toName).session.getBasicRemote().sendText(resultMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session){
        String username=(String) httpSession.getAttribute("user");
        //从容器中删除指定的用户
        onlineUser.remove(username);
        //获取推送的消息
        String message= MessageUtils.getMessage(true,null,getNames());
        broadcastAllUsers(message);
    }
}
