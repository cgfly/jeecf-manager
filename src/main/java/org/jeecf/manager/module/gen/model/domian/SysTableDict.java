package org.jeecf.manager.module.gen.model.domian;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.manager.common.model.NamespaceAndDbAuthEntity;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 表组字典
 * 
 * @author jianyiming
 *
 */
@ScriptAssert.List({ 
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.dictName)", message = "{tableDict.dictName.isEmpty}", groups = { Add.class }),
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.dictTableName)", message = "{tableDict.dictTableName.isEmpty}", groups = { Add.class }),
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.field)", message = "{tableDict.field.isEmpty}", groups = { Add.class }),
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.description)", message = "{tableDict.description.isEmpty}", groups = { Add.class }),
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.comments)", message = "{tableDict.comments.isEmpty}", groups = { Add.class }) 
})
@ApiModel(value = "sysTableDict", description = "系统表组字典实体")
public class SysTableDict extends NamespaceAndDbAuthEntity implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public SysTableDict() {
        super();
    }

    public SysTableDict(String id) {
        super(id);
    }

    @ApiModelProperty(value = "名称", name = "dictName")
    private String dictName;

    @ApiModelProperty(value = "表名", name = "dictTableName")
    private String dictTableName;

    @ApiModelProperty(value = "属性", name = "field")
    private String field;

    @ApiModelProperty(value = "注释", name = "comments")
    private String comments;

    @ApiModelProperty(value = "描述", name = "description")
    private String description;

    @Length(min = 1, max = 30, message = "{tableDict.dictName.length}", groups = { Add.class })
    @Pattern(regexp = "^[a-zA-Z0-9_.-]+$", message = "{tableDict.dictName.pattern}", groups = { Add.class })
    public String getDictName() {
        return dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }

    @Length(min = 1, max = 30, message = "{tableDict.dictTableName.length}", groups = { Add.class })
    public String getDictTableName() {
        return dictTableName;
    }

    public void setDictTableName(String dictTableName) {
        this.dictTableName = dictTableName;
    }

    @Length(min = 1, max = 30, message = "{tableDict.field.length}", groups = { Add.class })
    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    @Length(min = 1, max = 50, message = "{tableDict.description.length}", groups = { Add.class })
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Length(min = 1, max = 50, message = "{tableDict.comments.length}", groups = { Add.class })
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

}
