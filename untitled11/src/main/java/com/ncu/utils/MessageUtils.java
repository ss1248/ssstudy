package com.ncu.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ncu.pojo.ResultMessage;

public class MessageUtils {
    //封装消息的工具类
    public static String getMessage(boolean isSystemMessage,String fromName,Object message){
        try{
            ResultMessage result= new ResultMessage();
            result.setISSystem(isSystemMessage);
            result.setMessage(message);
            if(fromName !=null){
                result.setFromName(fromName);
            }
            ObjectMapper mapper=new ObjectMapper();
            //将将对象转为json字符串
            return mapper.writeValueAsString(result);
        }catch (JsonProcessingException e){
            e.printStackTrace();
        }
        return null;
    }
}
