package org.jeecf.manager.module.gen.model.schema;

/**
 * 数据字典 schema
 * 
 * @author jianyiming
 *
 */
public class SysDictSchema {
    /**
     * 主键
     */
    private boolean id = true;

    /**
     * 类型
     */
    private boolean dictType = true;

    /**
     * 名称
     */
    private boolean dictName = true;

    /**
     * 标签
     */
    private boolean label = true;

    /**
     * 值
     */
    private boolean dictValue = true;

    /**
     * 描述
     */
    private boolean description = true;
    /**
     * 创建人
     */
    private boolean createBy = true;
    /**
     * 创建时间
     */
    private boolean createDate = true;

    public boolean isDictType() {
        return dictType;
    }

    public void setDictType(boolean dictType) {
        this.dictType = dictType;
    }

    public boolean isDictName() {
        return dictName;
    }

    public void setDictName(boolean dictName) {
        this.dictName = dictName;
    }

    public boolean isLabel() {
        return label;
    }

    public void setLabel(boolean label) {
        this.label = label;
    }

    public boolean isDictValue() {
        return dictValue;
    }

    public void setDictValue(boolean dictValue) {
        this.dictValue = dictValue;
    }

    public boolean isDescription() {
        return description;
    }

    public void setDescription(boolean description) {
        this.description = description;
    }

    public boolean isCreateBy() {
        return createBy;
    }

    public void setCreateBy(boolean createBy) {
        this.createBy = createBy;
    }

    public boolean isCreateDate() {
        return createDate;
    }

    public void setCreateDate(boolean createDate) {
        this.createDate = createDate;
    }

    public boolean isId() {
        return id;
    }

    public void setId(boolean id) {
        this.id = id;
    }

}
