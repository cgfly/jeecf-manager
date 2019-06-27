package org.jeecf.manager.module.gen.model.domian;

import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.ScriptAssert;
import org.jeecf.common.lang.StringUtils;
import org.jeecf.manager.common.model.AbstractTreeNamespaceEntity;
import org.jeecf.manager.module.gen.model.result.SysTreeDictResult;
import org.jeecf.manager.validate.groups.Add;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 树组字典实体
 * 
 * @author jianyiming
 *
 */
@ScriptAssert.List({
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.calculation)", message = "{treeDict.calculation.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.groupName)", message = "{treeDict.groupName.isEmpty}", groups = {
                Add.class }),
        @ScriptAssert(lang = "javascript", script = "org.jeecf.manager.validate.constraints.Script.notBlank(_this.id,_this.description)", message = "{treeDict.description.isEmpty}", groups = {
                Add.class }) })
@ApiModel(value = "sysTreeDict", description = "树组字典实体")
public class SysTreeDict extends AbstractTreeNamespaceEntity<SysTreeDictResult> {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public SysTreeDict() {
    }

    public SysTreeDict(String id) {
        super(id);
    }

    /**
     * 输入
     */
    @ApiModelProperty(value = "输入", name = "input")
    private String input;
    /**
     * 计算
     */
    @ApiModelProperty(value = "计算", name = "calculation")
    private String calculation;
    /**
     * 输出
     */
    @ApiModelProperty(value = "输出", name = "output")
    private String output;
    /**
     * 组别
     */
    @ApiModelProperty(value = "组别", name = "group")
    private String groupName;
    /**
     * 描述
     */
    @ApiModelProperty(value = "描述", name = "description")
    private String description;

    @Length(min = 1, max = 50, message = "{treeDict.calculation.length}", groups = { Add.class })
    public String getCalculation() {
        return calculation;
    }

    public void setCalculation(String calculation) {
        this.calculation = calculation;
    }

    @Length(min = 1, max = 50, message = "{treeDict.groupName.length}", groups = { Add.class })
    public String getGroupName() {
        return this.groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Length(min = 1, max = 50, message = "{treeDict.description.length}", groups = { Add.class })
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Length(min = 1, max = 30, message = "{treeDict.input.length}", groups = { Add.class })
    public String getInput() {
        return input;
    }

    public void setInput(String input) {
        this.input = input;
    }

    @Length(min = 1, max = 30, message = "{treeDict.output.length}", groups = { Add.class })
    public String getOutput() {
        return output;
    }

    public void setOutput(String output) {
        this.output = output;
    }

    @Override
    public void sortList(List<SysTreeDictResult> newList, List<SysTreeDictResult> sourceList, String rootId) {
        for (int i = 0; i < sourceList.size(); i++) {
            SysTreeDictResult sysTreeDict = sourceList.get(i);
            if (("0".equals(rootId) && StringUtils.isEmpty(sysTreeDict.getParentId())) || (StringUtils.isNotEmpty(sysTreeDict.getParentId()) && sysTreeDict.getParentId().equals(rootId))) {
                newList.add(sysTreeDict);
                for (int j = 0; j < sourceList.size(); j++) {
                    SysTreeDict child = sourceList.get(j);
                    if (child.getParentId() != null && String.valueOf(child.getParentId()).equals(sysTreeDict.getId())) {
                        sysTreeDict.setHasChild(true);
                        sortList(newList, sourceList, sysTreeDict.getId());
                        break;
                    }
                }
            }
        }

    }

}
