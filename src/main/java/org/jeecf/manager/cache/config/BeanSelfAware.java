package org.jeecf.manager.cache.config;

/**
 * 获取代理 织入类
 * 
 * @author jianyiming
 * @version 2.0
 */
public interface BeanSelfAware {
    /**
     * 设置私有bean
     * @param proxyBean
     */
    void setSelf(Object proxyBean);

}
