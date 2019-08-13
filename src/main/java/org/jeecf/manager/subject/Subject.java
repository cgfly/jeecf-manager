package org.jeecf.manager.subject;

import java.util.List;

import org.jeecf.manager.listen.Listener;

/**
 * 监听者 主题接口
 * 
 * @author jianyiming
 *
 */
public interface Subject {
    /**
     * 主题注册
     * 
     * @param topic
     * @param listener
     */
    void register(String topic, Listener listener);

    /**
     * 根据主题获取监听者
     * 
     * @param topic
     * @return
     */
    List<Listener> getListeners(String topic);

}
