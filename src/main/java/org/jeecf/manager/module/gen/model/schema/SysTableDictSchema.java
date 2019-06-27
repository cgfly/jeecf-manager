package org.jeecf.manager.module.gen.model.schema;

/**
 * 系统表组字典schema
 * 
 * @author jianyiming
 *
 */
public class SysTableDictSchema {

    /**
     * 主键
     */
    private boolean id = true;
    /**
     * 名称
     */
    private boolean dictName = true;

    /**
     * 表名
     */
    private boolean dictTableName = true;

    /**
     * 属性
     */
    private boolean field = true;
    /**
     * 注释
     */
    private boolean comments = true;
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

    public boolean isId() {
        return id;
    }

    public void setId(boolean id) {
        this.id = id;
    }

    public boolean isDictName() {
        return dictName;
    }

    public void setDictName(boolean dictName) {
        this.dictName = dictName;
    }

    public boolean isDictTableName() {
        return dictTableName;
    }

    public void setDictTableName(boolean dictTableName) {
        this.dictTableName = dictTableName;
    }

    public boolean isField() {
        return field;
    }

    public void setField(boolean field) {
        this.field = field;
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

    public boolean isComments() {
        return comments;
    }

    public void setComments(boolean comments) {
        this.comments = comments;
    }
}
