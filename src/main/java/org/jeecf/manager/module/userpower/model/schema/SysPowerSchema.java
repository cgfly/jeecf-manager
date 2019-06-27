package org.jeecf.manager.module.userpower.model.schema;

import io.swagger.annotations.ApiModelProperty;

/**
 * 系统权限 schema
 * 
 * @author jianyiming
 *
 */
public class SysPowerSchema {

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
     * 权限
     */
    @ApiModelProperty(value = "权限", name = "permission")
    private boolean permission = true;

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

    /**
     * 标签
     */
    @ApiModelProperty(value = "标签", name = "label")
    private boolean label = true;

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

    public boolean isPermission() {
        return permission;
    }

    public void setPermission(boolean permission) {
        this.permission = permission;
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

    public boolean isLabel() {
        return label;
    }

    public void setLabel(boolean label) {
        this.label = label;
    }

    public boolean isParent() {
        return parent;
    }

    public void setParent(boolean parent) {
        this.parent = parent;
    }

}
