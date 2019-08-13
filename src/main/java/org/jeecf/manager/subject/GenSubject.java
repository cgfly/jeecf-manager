package org.jeecf.manager.subject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jeecf.manager.config.TaskPoolConfiguration;
import org.jeecf.manager.listen.Listener;
import org.springframework.scheduling.annotation.Async;

/**
 * 代码生成主题
 * 
 * @author jianyiming
 *
 */
public class GenSubject implements Subject {

    private Map<Listener, String> listeners = new HashMap<>();

    public static final String[] TOPIC_ELEMENTS = {"code" };

    @Override
    public void register(String topic, Listener listener) {
        String[] topics = GenSubject.TOPIC_ELEMENTS;
        for (String tp : topics) {
            if (tp.equals(topic)) {
                listeners.put(listener, topic);
                return;
            }
        }
    }

    @Override
    public List<Listener> getListeners(String topic) {
        List<Listener> listenersTopic = new ArrayList<>();
        for (Map.Entry<Listener, String> entry : listeners.entrySet()) {
            if (entry.getValue().equals(topic)) {
                listenersTopic.add(entry.getKey());
            }
        }
        return listenersTopic;
    }

    /**
     * 代码生成 监听
     * 
     * @param user
     */
    @Async(TaskPoolConfiguration.TASK_EXECUTOR_NAME)
    public void updateCode(String userId, String userName, String targetId, String ip) {
        SubjectContext context = new SubjectContext();
        Map<String, String> data = new HashMap<>(10);
        data.put(LogContextField.USER_ID, userId);
        data.put(LogContextField.USER_NAME, userName);
        data.put(LogContextField.TARGET_ID, targetId);
        data.put(LogContextField.IP, ip);
        context.setData(data);
        List<Listener> listenersTopic = getListeners(TOPIC_ELEMENTS[0]);
        for (Listener listener : listenersTopic) {
            listener.notice(context);
        }
    }

}
