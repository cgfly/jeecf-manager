package org.jeecf.manager.module.template.model.domain;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.manager.common.model.NamespaceAuthEntity;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 模版配置
 * 
 * @author GloryJian
 * @version 1.0
 */
@ApiModel(value = "genTemplate", description = "生成模版实体")
@ScriptAssert.List({
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.language)", message = "{genTemplate.language.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.fileBasePath)", message = "{genTemplate.fileBasePath.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.version)", message = "{genTemplate.version.isEmpty}", groups = {
                Add.class }) })
public class GenTemplate extends NamespaceAuthEntity implements Serializable {

    private static final long serialVersionUID = 1L;
    /**
     * 名称
     */
    @ApiModelProperty(value = "名称", name = "templateName")
    private String templateName;
    /**
     * 语言
     */
    @ApiModelProperty(value = "语言", name = "language")
    private Integer language;
    /**
     * 模版文件基础路径
     */
    @ApiModelProperty(value = "模版文件基础路径", name = "fileBasePath")
    private String fileBasePath;
    /**
     * 版本号
     */
    @ApiModelProperty(value = "版本号", name = "version")
    private String version;
    /**
     * wiki地址
     */
    @ApiModelProperty(value = "wiki地址", name = "wikiUri")
    private String wikiUri;
    /**
     * 标签
     */
    @ApiModelProperty(value = "标签", name = "tags")
    private String tags;
    /**
     * 描述
     */
    @ApiModelProperty(value = "描述", name = "description")
    private String description;
    /**
     * 属性参数
     */
    @ApiModelProperty(value = "属性参数", name = "genFieldColumn")
    private List<GenFieldColumn> genFieldColumn;

    public GenTemplate() {
        super();
    }

    public GenTemplate(String id) {
        super(id);
    }

    @Pattern(regexp = "^[a-zA-Z0-9_.-]+$", message = "{genTemplate.templateName.pattern}", groups = { Add.class })
    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    @Min(value = 1, message = "{genTemplate.language.min}", groups = { Add.class })
    @Max(value = 2, message = "{genTemplate.language.max}", groups = { Add.class })
    public Integer getLanguage() {
        return language;
    }

    public void setLanguage(Integer language) {
        this.language = language;
    }

    @Length(min = 1, max = 100, message = "{genTemplate.fileBasePath.length}", groups = { Add.class })
    public String getFileBasePath() {
        return fileBasePath;
    }

    public void setFileBasePath(String fileBasePath) {
        this.fileBasePath = fileBasePath;
    }

    @Length(min = 1, max = 100, message = "{genTemplate.wikiUri.length}", groups = { Add.class })
    public String getWikiUri() {
        return wikiUri;
    }

    public void setWikiUri(String wikiUri) {
        this.wikiUri = wikiUri;
    }

    @Length(min = 1, max = 50, message = "{genTemplate.description.length}", groups = { Add.class })
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Length(min = 1, max = 20, message = "{genTemplate.version.length}", groups = { Add.class })
    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public List<GenFieldColumn> getGenFieldColumn() {
        return genFieldColumn;
    }

    public void setGenFieldColumn(List<GenFieldColumn> genFieldColumn) {
        this.genFieldColumn = genFieldColumn;
    }

    @Length(min = 1, max = 64, message = "{genTemplate.tags.length}", groups = { Add.class })
    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

}