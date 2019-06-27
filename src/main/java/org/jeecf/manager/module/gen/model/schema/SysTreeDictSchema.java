package org.jeecf.manager.module.gen.model.schema;

import io.swagger.annotations.ApiModelProperty;

/**
 * 树组字典 schema
 * 
 * @author jianyiming
 *
 */
public class SysTreeDictSchema {

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
     * 输出
     */
    @ApiModelProperty(value = "输出", name = "output")
    private boolean output = true;
    /**
     * 输入
     */
    @ApiModelProperty(value = "输入", name = "input")
    private boolean input = true;
    /**
     * 计算
     */
    @ApiModelProperty(value = "计算", name = "calculation")
    private boolean calculation = true;

    /**
     * 组别
     */
    @ApiModelProperty(value = "组别", name = "group")
    private boolean groupName = true;

    /**
     * 描述
     */
    @ApiModelProperty(value = "描述", name = "description")
    private boolean description = true;

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
     * 创建人
     */
    @ApiModelProperty(value = "创建人", name = "createBy")
    private boolean createBy = true;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间", name = "createDate")
    private boolean createDate = true;

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

    public boolean isOutput() {
        return output;
    }

    public void setOutput(boolean output) {
        this.output = output;
    }

    public boolean isInput() {
        return input;
    }

    public void setInput(boolean input) {
        this.input = input;
    }

    public boolean isCalculation() {
        return calculation;
    }

    public void setCalculation(boolean calculation) {
        this.calculation = calculation;
    }

    public boolean isGroupName() {
        return groupName;
    }

    public void setGroupName(boolean groupName) {
        this.groupName = groupName;
    }

    public boolean isDescription() {
        return description;
    }

    public void setDescription(boolean description) {
        this.description = description;
    }

    public boolean isParent() {
        return parent;
    }

    public void setParent(boolean parent) {
        this.parent = parent;
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

}
