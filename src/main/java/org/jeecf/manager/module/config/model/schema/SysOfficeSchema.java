package org.jeecf.manager.module.config.model.schema;

import io.swagger.annotations.ApiModelProperty;

/**
 * 组织结构 schema
 * 
 * @author jianyiming
 *
 */
public class SysOfficeSchema {

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键", name = "id")
    private boolean id = true;

    /**
     * 名称
     */
    @ApiModelProperty(value = "名称", name = "nodeName")
    private boolean nodeName = true;

    /**
     * 英文名称
     */
    @ApiModelProperty(value = "英文名称", name = "enname")
    private boolean enname = true;

    /**
     * 父层
     */
    @ApiModelProperty(value = "父层", name = "parent")
    private boolean parent = true;

    /**
     * 父层索引
     */
    @ApiModelProperty(value = "父层索引", name = "parentId")
    private boolean parentId = true;

    /**
     * 父层索引集
     */
    @ApiModelProperty(value = "所有父层索引", name = "parentIds")
    private boolean parentIds = true;

    /**
     * 等级
     */
    @ApiModelProperty(value = "等级", name = "nodeLevel")
    private boolean nodeLevel = true;

    /**
     * 同级排序
     */
    @ApiModelProperty(value = "同级排序", name = "sort")
    private boolean sort = true;

    public boolean isId() {
        return id;
    }

    public void setId(boolean id) {
        this.id = id;
    }

    public boolean isNodeName() {
        return nodeName;
    }

    public void setNodeName(boolean nodeName) {
        this.nodeName = nodeName;
    }

    public boolean isEnname() {
        return enname;
    }

    public void setEnname(boolean enname) {
        this.enname = enname;
    }

    public boolean isParentId() {
        return parentId;
    }

    public void setParentId(boolean parentId) {
        this.parentId = parentId;
    }

    public boolean isParentIds() {
        return parentIds;
    }

    public void setParentIds(boolean parentIds) {
        this.parentIds = parentIds;
    }

    public boolean isNodeLevel() {
        return nodeLevel;
    }

    public void setNodeLevel(boolean nodeLevel) {
        this.nodeLevel = nodeLevel;
    }

    public boolean isSort() {
        return sort;
    }

    public void setSort(boolean sort) {
        this.sort = sort;
    }

    public boolean isParent() {
        return parent;
    }

    public void setParent(boolean parent) {
        this.parent = parent;
    }

}
