package org.jeecf.manager.listen;

import org.jeecf.manager.common.enums.ActionTypeEnum;
import org.jeecf.manager.common.utils.SpringContextUtils;
import org.jeecf.manager.module.operation.model.domain.CustomerActionLog;
import org.jeecf.manager.module.operation.service.CustomerActionLogService;
import org.jeecf.manager.subject.LogContextField;
import org.jeecf.manager.subject.SubjectContext;

/**
 * 模版生成监听
 * 
 * @author jianyiming
 *
 */
public class TemplateGenListener implements Listener {

    private CustomerActionLogService customerActionLogService = null;

    private void initParam() {
        if (customerActionLogService == null) {
            customerActionLogService = SpringContextUtils.getBean("customerActionLogService", CustomerActionLogService.class);
        }
    }

    @Override
    public void notice(SubjectContext context) {
        initParam();
        CustomerActionLog customerActionLog = new CustomerActionLog();
        customerActionLog.setIp(context.get(LogContextField.IP));
        customerActionLog.setUserId(context.get(LogContextField.USER_ID));
        customerActionLog.setUserName(context.get(LogContextField.USER_NAME));
        customerActionLog.setTargetId(context.get(LogContextField.TARGET_ID));
        customerActionLog.setActionType(ActionTypeEnum.CODE_GEN.getCode());
        customerActionLog.setCreateBy(context.get(LogContextField.USER_ID));
        customerActionLog.setUpdateBy(context.get(LogContextField.USER_ID));
        customerActionLogService.insert(customerActionLog);
    }

}
