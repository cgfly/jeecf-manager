package org.jeecf.manager.module.template.model.schema;

import io.swagger.annotations.ApiModelProperty;

/**
 * 代码模版 schema
 * 
 * @author jianyiming
 *
 */
public class GenTemplateSchema {

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键", name = "id")
    private boolean id = true;
    /**
     * 名称
     */
    @ApiModelProperty(value = "名称", name = "templateName")
    private boolean templateName = true;
    /**
     * 语言
     */
    @ApiModelProperty(value = "语言", name = "language")
    private boolean language = true;
    /**
     * 模版文件基础路径
     */
    @ApiModelProperty(value = "模版文件基础路径", name = "fileBasePath")
    private boolean fileBasePath = true;
    /**
     * wiki地址
     */
    @ApiModelProperty(value = "wiki地址", name = "wikiUri")
    private boolean wikiUri = true;
    /**
     * 版本号
     */
    @ApiModelProperty(value = "版本号", name = "version")
    private boolean version = true;
    /**
     * 标签
     */
    @ApiModelProperty(value = "标签", name = "tags")
    private boolean tags = true;
    /**
     * 标签
     */
    @ApiModelProperty(value = "模版类型", name = "templateType")
    private boolean templateType = true;
    /**
     * 描述
     */
    @ApiModelProperty(value = "描述", name = "description")
    private boolean description = true;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间", name = "createDate")
    private boolean createDate = true;
    /**
     * 创建人
     */
    @ApiModelProperty(value = "创建人", name = "createBy")
    private boolean createBy = true;
    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间", name = "updateDate")
    private boolean updateDate = true;
    /**
     * 命名空间
     */
    @ApiModelProperty(value = "命名空间", name = "sysNamespaceId")
    private boolean sysNamespaceId = true;

    public boolean isId() {
        return id;
    }

    public void setId(boolean id) {
        this.id = id;
    }

    public boolean isTemplateName() {
        return templateName;
    }

    public void setTemplateName(boolean templateName) {
        this.templateName = templateName;
    }

    public boolean isLanguage() {
        return language;
    }

    public void setLanguage(boolean language) {
        this.language = language;
    }

    public boolean isFileBasePath() {
        return fileBasePath;
    }

    public void setFileBasePath(boolean fileBasePath) {
        this.fileBasePath = fileBasePath;
    }

    public boolean isVersion() {
        return version;
    }

    public void setVersion(boolean version) {
        this.version = version;
    }

    public boolean isWikiUri() {
        return wikiUri;
    }

    public void setWikiUri(boolean wikiUri) {
        this.wikiUri = wikiUri;
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

    public boolean isUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(boolean updateDate) {
        this.updateDate = updateDate;
    }

    public boolean isSysNamespaceId() {
        return sysNamespaceId;
    }

    public void setSysNamespaceId(boolean sysNamespaceId) {
        this.sysNamespaceId = sysNamespaceId;
    }

    public boolean isTags() {
        return tags;
    }

    public void setTags(boolean tags) {
        this.tags = tags;
    }

    public boolean isCreateDate() {
        return createDate;
    }

    public void setCreateDate(boolean createDate) {
        this.createDate = createDate;
    }

    public boolean isTemplateType() {
        return templateType;
    }

    public void setTemplateType(boolean templateType) {
        this.templateType = templateType;
    }

}
