package com.f.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author shkstart
 * @create 2020-09-10-11:55
 */
public class Msg {
    private boolean code;
    private String msg;
    private Map<String, Object> map = new HashMap<>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(true);
        msg.setMsg("请求处理完毕！");
        return msg;
}

    public static Msg file(){
        Msg msg = new Msg();
        msg.setCode(false);
        msg.setMsg("请求处理失败！");
        return msg;
    }

    public Msg add(String key,Object values){
        this.getMap().put(key, values);
        return this;
    }


    public boolean isCode() {
        return code;
    }

    public void setCode(boolean code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }
}
