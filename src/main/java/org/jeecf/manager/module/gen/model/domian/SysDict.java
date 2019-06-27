package org.jeecf.manager.module.gen.model.domian;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.manager.common.model.NamespaceAuthEntity;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 系统字典
 * 
 * @author GloryJian
 * @version 1.0
 */
@ScriptAssert.List({
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.dictName)", message = "{dict.dictName.isEmpty}", groups = { Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.dictType)", message = "{dict.dictType.isEmpty}", groups = { Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.label)", message = "{dict.label.isEmpty}", groups = { Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.description)", message = "{dict.description.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notNull(_this.id,_this.dictValue)", message = "{dict.dictValue.isEmpty}", groups = { Add.class }) })
@ApiModel(value = "sysDict", description = "系统字典实体")
public class SysDict extends NamespaceAuthEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 类型
     */
    @ApiModelProperty(value = "类型", name = "dictType")
    private String dictType;

    /**
     * 名称
     */
    @ApiModelProperty(value = "名称", name = "dictName")
    private String dictName;

    /**
     * 标签
     */
    @ApiModelProperty(value = "标签", name = "label")
    private String label;

    /**
     * 值
     */
    @ApiModelProperty(value = "值", name = "dictValue")
    private Integer dictValue;

    /**
     * 描述
     */
    @ApiModelProperty(value = "描述", name = "description")
    private String description;

    public SysDict() {
        super();
    }

    public SysDict(String id) {
        super(id);
    }

    @Length(min = 1, max = 50, message = "{dict.dictType.length}", groups = { Add.class })
    @Pattern(regexp = "^[a-zA-Z0-9_.-]+$", message = "{dict.dictType.pattern}", groups = { Add.class })
    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType;
    }

    @Length(min = 1, max = 20, message = "{dict.dictName.length}", groups = { Add.class })
    public String getDictName() {
        return dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }

    @Length(min = 1, max = 20, message = "{dict.label.length}", groups = { Add.class })
    @Pattern(regexp = "^[a-zA-Z]+[a-zA-Z_]*[a-zA-Z]$", message = "{dict.label.pattern}", groups = { Add.class })
    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Integer getDictValue() {
        return dictValue;
    }

    public void setDictValue(Integer dictValue) {
        this.dictValue = dictValue;
    }

    @Length(min = 1, max = 50, message = "{dict.description.length}", groups = { Add.class })
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}