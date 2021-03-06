package org.jeecf.manager.module.template.model.domain;

import java.io.Serializable;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.common.utils.HumpUtils;
import org.jeecf.manager.common.model.NamespaceAndDbAuthEntity;
import org.jeecf.manager.module.template.model.result.GenTableColumnResult;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 业务表实体
 * 
 * @author jianyiming
 *
 */
@ScriptAssert.List({ 
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.genTableName)", message = "{genTable.genTableName.isEmpty}", groups = { Add.class }),
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.className)", message = "{genTable.className.isEmpty}", groups = { Add.class }),
    @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notNull(_this.id,_this.genTableColumns)", message = "{genTable.genTableColumns.isNull}", groups = { Add.class }) 
})
@ApiModel(value = "genTable", description = "代码生成业务表实体")
public class GenTable extends NamespaceAndDbAuthEntity implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    /**
     * 名称
     */
    @ApiModelProperty(value = "名称", name = "genTableName")
    private String genTableName;

    /**
     * 类名
     */
    @ApiModelProperty(value = "类名", name = "className")
    private String className;

    /**
     * 注释
     */
    @ApiModelProperty(value = "注释", name = "comments")
    private String comments;

    /**
     * 父表id
     */
    @ApiModelProperty(value = "父表id", name = "parentTable")
    private String parentTableId;

    /**
     * 父表外键
     */
    @ApiModelProperty(value = "父表外键", name = "parentTableFk")
    private String parentTableFk;

    /**
     * 表字段
     */
    @ApiModelProperty(value = "表字段", name = "genTableColumns")
    private List<GenTableColumnResult> genTableColumns;

    public GenTable() {
    }

    public GenTable(String id) {
        super(id);
    }

    @Length(min = 1, max = 60, message = "{genTable.genTableName.length}", groups = { Add.class })
    @Pattern(regexp = "^[a-zA-Z]+[a-zA-Z_]*[a-zA-Z]$", message = "{genTable.tableName.pattern}", groups = { Add.class })
    public String getGenTableName() {
        return genTableName;
    }

    public void setGenTableName(String genTableName) {
        if (StringUtils.isNotEmpty(genTableName)) {
            genTableName = StringUtils.lowerCase(HumpUtils.humpToLine2(genTableName));
        }
        this.genTableName = genTableName;
    }

    @Length(min = 1, max = 60, message = "{genTable.className.length}", groups = { Add.class })
    @Pattern(regexp = "^[a-zA-Z]+$", message = "{genTable.className.pattern}", groups = { Add.class })
    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    @Length(min = 1, max = 100, message = "{genTable.comments.length}", groups = { Add.class })
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    @Valid
    @Size(min = 1, max = 30, message = "{genTable.genTableColumns.size}", groups = { Add.class })
    public List<GenTableColumnResult> getGenTableColumns() {
        return genTableColumns;
    }

    public void setGenTableColumns(List<GenTableColumnResult> genTableColumns) {
        this.genTableColumns = genTableColumns;
    }

    public String getParentTableId() {
        return parentTableId;
    }

    public void setParentTableId(String parentTableId) {
        this.parentTableId = parentTableId;
    }

    public String getParentTableFk() {
        return parentTableFk;
    }

    public void setParentTableFk(String parentTableFk) {
        this.parentTableFk = parentTableFk;
    }

}
