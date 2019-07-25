package org.jeecf.manager.gen.handler;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.jeecf.gen.chain.AbstractHandler;
import org.jeecf.gen.chain.ContextConfigParams;
import org.jeecf.osgi.model.PluginRequest;
import org.jeecf.osgi.model.PluginResponse;
import org.jeecf.osgi.plugin.Plugin;

/**
 * 插件处理 责任链
 * 
 * @author jianyiming
 * @since 1.0
 */
public class PluginHandler extends AbstractHandler {

    @Override
    public void process() {
        ContextConfigParams contextParams = this.chainContext.getContextParams();
        Map<String, Object> params = this.chainContext.getParams();
        Map<String, Object> extMap = contextParams.getExtParams();
        @SuppressWarnings("unchecked")
        List<Plugin> plugins = (List<Plugin>) extMap.get("genHandlerPlugin");
        Integer language = (Integer) extMap.get("language");
        if (CollectionUtils.isNotEmpty(plugins)) {
            PluginRequest request = new PluginRequest();
            request.setAttribute("language", language);
            request.setAttribute("namespaceId", contextParams.getNamespaceId());
            request.setAttribute("usernameId", contextParams.getUserId());
            request.setAttribute("namespace", contextParams.getNamespaceName());
            request.setAttribute("username", contextParams.getUserName());
            plugins.forEach(plugin -> {
                PluginResponse res = plugin.process(request);
                if (res != null) {
                    Map<String, Object> attr = res.attr();
                    for (Map.Entry<String, Object> entry : attr.entrySet()) {
                        params.put(entry.getKey(), entry.getValue());
                    }
                }
            });
        }
        this.chainContext.next();
    }

}
