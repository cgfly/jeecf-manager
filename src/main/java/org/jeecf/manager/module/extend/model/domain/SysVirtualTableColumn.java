package org.jeecf.manager.module.extend.model.domain;

import java.io.Serializable;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.manager.common.model.BaseEntity;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 虚表字段
 * 
 * @author jianyiming
 *
 */
@ScriptAssert.List({
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.tableColumnName)", message = "{virtualTableColumn.tableColumnName.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.comments)", message = "{virtualTableColumn.comments.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notNull(_this.id,_this.type)", message = "{virtualTableColumn.type.isEmpty}", groups = {
                Add.class }) })
@ApiModel(value = "sysVirtualTableColumn", description = "虚表字段实体")
public class SysVirtualTableColumn extends BaseEntity implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    /**
     * 字段名
     */
    @ApiModelProperty(value = "字段名", name = "tableColumnName")
    private String tableColumnName;
    /**
     * 虚表id
     */
    @ApiModelProperty(value = "虚表id", name = "sysVirtualTableId")
    private Integer sysVirtualTableId;
    /**
     * 注释
     */
    @ApiModelProperty(value = "注释", name = "comments")
    private String comments;
    /**
     * 类型
     */
    @ApiModelProperty(value = "类型", name = "columnType")
    private Integer columnType;
    /**
     * 长度
     */
    @ApiModelProperty(value = "长度", name = "length")
    private Integer length;
    /**
     * 小数
     */
    @ApiModelProperty(value = "小数", name = "decimal")
    private Integer decimalLength;
    /**
     * 不为空
     */
    @ApiModelProperty(value = "不为空", name = "isNotNull")
    private Integer isNotNull;
    /**
     * 默认值
     */
    @ApiModelProperty(value = "默认值", name = "defaultValue")
    private String defaultValue;
    /**
     * 主键
     */
    @ApiModelProperty(value = "主键", name = "isKey")
    private Integer isKey;
    /**
     * 自增
     */
    @ApiModelProperty(value = "自增", name = "isAuto")
    private Integer isAuto;

    @Length(min = 1, max = 20, message = "{virtualTableColumn.tableColumnName.length}", groups = { Add.class })
    @Pattern(regexp = "^[0-9a-zA-Z]+[0-9a-zA-Z_]*[0-9a-zA-Z]$", message = "{virtualTableColumn.tableColumnName.pattern}", groups = { Add.class })
    public String getTableColumnName() {
        return tableColumnName;
    }

    public void setTableColumnName(String tableColumnName) {
        this.tableColumnName = tableColumnName;
    }

    public Integer getSysVirtualTableId() {
        return sysVirtualTableId;
    }

    public void setSysVirtualTableId(Integer sysVirtualTableId) {
        this.sysVirtualTableId = sysVirtualTableId;
    }

    @Length(min = 1, max = 50, message = "{virtualTableColumn.comments.length}", groups = { Add.class })
    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public Integer getColumnType() {
        return columnType;
    }

    public void setColumnType(Integer columnType) {
        this.columnType = columnType;
    }

    @Min(value = 0, message = "{virtualTableColumn.integer.length}", groups = { Add.class })
    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    @Min(value = 0, message = "{virtualTableColumn.decimal.length}", groups = { Add.class })
    public Integer getDecimalLength() {
        return decimalLength;
    }

    public void setDecimalLength(Integer decimalLength) {
        this.decimalLength = decimalLength;
    }

    @Min(value = 0, message = "{virtualTableColumn.notNull.min}", groups = { Add.class })
    @Max(value = 1, message = "{virtualTableColumn.notNull.max}", groups = { Add.class })
    public Integer getIsNotNull() {
        return isNotNull;
    }

    public void setIsNotNull(Integer isNotNull) {
        this.isNotNull = isNotNull;
    }

    @Length(min = 0, max = 20, message = "{virtualTableColumn.defaultValue.length}", groups = { Add.class })
    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    @Min(value = 0, message = "{virtualTableColumn.isKey.min}", groups = { Add.class })
    @Max(value = 1, message = "{virtualTableColumn.isKey.max}", groups = { Add.class })
    public Integer getIsKey() {
        return isKey;
    }

    public void setIsKey(Integer isKey) {
        this.isKey = isKey;
    }

    @Min(value = 0, message = "{virtualTableColumn.isAuto.min}", groups = { Add.class })
    @Max(value = 1, message = "{virtualTableColumn.isAuto.max}", groups = { Add.class })
    public Integer getIsAuto() {
        return isAuto;
    }

    public void setIsAuto(Integer isAuto) {
        this.isAuto = isAuto;
    }

}
