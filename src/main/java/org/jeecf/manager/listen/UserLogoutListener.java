package org.jeecf.manager.listen;

import org.jeecf.manager.common.enums.ActionTypeEnum;
import org.jeecf.manager.common.utils.SpringContextUtils;
import org.jeecf.manager.module.operation.model.domain.CustomerActionLog;
import org.jeecf.manager.module.operation.service.CustomerActionLogService;
import org.jeecf.manager.subject.LogContextField;
import org.jeecf.manager.subject.SubjectContext;

/**
 * 用户登出 监听
 * 
 * @author jianyiming
 *
 */
public class UserLogoutListener implements Listener {

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
        customerActionLog.setActionType(ActionTypeEnum.LOGOUT.getCode());
        customerActionLog.setCreateBy(context.get(LogContextField.USER_ID));
        customerActionLog.setUpdateBy(context.get(LogContextField.USER_ID));
        customerActionLogService.insert(customerActionLog);
    }

}
