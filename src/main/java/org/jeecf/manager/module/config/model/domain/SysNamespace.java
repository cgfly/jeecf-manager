package org.jeecf.manager.module.config.model.domain;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.manager.common.model.PermissionEntity;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 系统命名空间
 * 
 * @author GloryJian
 * @version 1.0
 */
@ScriptAssert.List({
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.namespaceName)", message = "{namespace.namespaceName.isEmpty}", groups = { Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.description)", message = "{namespace.description.isEmpty}", groups = {
                Add.class }) })
@ApiModel(value = "sysNamespace", description = "命名空间配置实体")
public class SysNamespace extends PermissionEntity implements Serializable {

    private static final long serialVersionUID = 1L;
    /**
     * 名称
     */
    @ApiModelProperty(value = "名称", name = "namespaceName")
    private String namespaceName;
    /**
     * 描述
     */
    @ApiModelProperty(value = "描述", name = "description")
    private String description;

    public SysNamespace() {
        super();
    }

    public SysNamespace(String id) {
        super(id);
    }

    @Length(min = 1, max = 20, message = "{namespace.namespaceName.length}", groups = { Add.class })
    @Pattern(regexp = "^[a-zA-Z0-9_.-]+$", message = "{namespace.namespaceName.pattern}", groups = { Add.class })
    public String getNamespaceName() {
        return namespaceName;
    }

    public void setNamespaceName(String namespaceName) {
        this.namespaceName = namespaceName;
    }

    @Length(min = 1, max = 50, message = "{namespace.description.length}", groups = { Add.class })
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}