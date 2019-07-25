package org.jeecf.manager.gen.handler;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.jeecf.common.utils.DateFormatUtils;
import org.jeecf.gen.chain.AbstractHandler;
import org.jeecf.gen.chain.ContextConfigParams;
import org.jeecf.manager.gen.model.GenParams;

/**
 * 基础参数责任链
 * 
 * @author jianyiming
 * @since 1.0
 */
public class BaseParamHandler extends AbstractHandler {

    @Override
    public void process() {
        ContextConfigParams contextParams = this.chainContext.getContextParams();
        Map<String, Object> extMap = contextParams.getExtParams();
        Map<String, Object> params = this.chainContext.getParams();
        @SuppressWarnings("unchecked")
        List<GenParams> genParamsList = (List<GenParams>) extMap.get("genParamsList");

        params.put("nowDate", DateFormatUtils.getSfFormat().format(new Date()));
        params.put("namespaceId", Integer.valueOf(contextParams.getNamespaceId()));
        params.put("usernameId", contextParams.getUserId());
        params.put("namespace", contextParams.getNamespaceName());
        params.put("username", contextParams.getUserName());
        if (CollectionUtils.isNotEmpty(genParamsList)) {
            genParamsList.forEach(genParam -> {
                params.put(genParam.getFieldColumnName(), genParam.getValue());
            });
        }
        this.chainContext.next();
    }

}
