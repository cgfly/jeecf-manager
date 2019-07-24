package org.jeecf.manager.gen.model;

/**
 * gen 参数
 * 
 * @author jianyiming
 * @since1 1.0
 */
public class GenParams {
    /**
     * 名称
     */
    private String fieldColumnName;
    /**
     * 值
     */
    private String value;
    /**
     * 描述
     */
    private String descrition;

    public String getFieldColumnName() {
        return fieldColumnName;
    }

    public void setFieldColumnName(String fieldColumnName) {
        this.fieldColumnName = fieldColumnName;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescrition() {
        return descrition;
    }

    public void setDescrition(String descrition) {
        this.descrition = descrition;
    }

}
