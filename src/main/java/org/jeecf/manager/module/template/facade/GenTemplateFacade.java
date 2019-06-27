package org.jeecf.manager.module.template.facade;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.jeecf.common.lang.StringUtils;
import org.jeecf.common.model.Response;
import org.jeecf.manager.module.template.model.domain.GenFieldColumn;
import org.jeecf.manager.module.template.model.domain.GenTemplate;
import org.jeecf.manager.module.template.model.po.GenFieldColumnPO;
import org.jeecf.manager.module.template.model.query.GenFieldColumnQuery;
import org.jeecf.manager.module.template.model.result.GenFieldColumnResult;
import org.jeecf.manager.module.template.model.result.GenTemplateResult;
import org.jeecf.manager.module.template.service.GenFieldColumnService;
import org.jeecf.manager.module.template.service.GenTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * genTemplate 门面
 * 
 * @author jianyiming
 *
 */
@Service
@Transactional(readOnly = true, rollbackFor = RuntimeException.class)
public class GenTemplateFacade {

    @Autowired
    private GenFieldColumnService genFieldColumnService;

    @Autowired
    private GenTemplateService genTemplateService;

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<GenTemplateResult> save(GenTemplate genTemplate) {
        Response<GenTemplateResult> genTemplateRes = genTemplateService.saveByAuth(genTemplate);
        List<GenFieldColumn> fieldColumnList = genTemplate.getGenFieldColumn();
        if (CollectionUtils.isNotEmpty(fieldColumnList)) {
            if (StringUtils.isNotEmpty(genTemplate.getId())) {
                GenFieldColumn genFieldColumn = new GenFieldColumn();
                genFieldColumn.setGenTemplateId(Integer.valueOf(genTemplate.getId()));
                genFieldColumnService.delete(genFieldColumn);
            }
            fieldColumnList.forEach(fieldColumn -> {
                if (StringUtils.isNotEmpty(fieldColumn.getFieldColumnName())) {
                    fieldColumn.setNewRecord(true);
                    fieldColumn.setGenTemplateId(Integer.valueOf(genTemplate.getId()));
                    genFieldColumnService.save(fieldColumn);
                }
            });
        }
        return genTemplateRes;
    }

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<Integer> delete(GenTemplate genTemplate) {
        GenFieldColumnQuery genFieldColumn = new GenFieldColumnQuery();
        genFieldColumn.setGenTemplateId(Integer.valueOf(genTemplate.getId()));
        List<GenFieldColumnResult> fieldColumnList = genFieldColumnService.findList(new GenFieldColumnPO(genFieldColumn)).getData();
        if (CollectionUtils.isNotEmpty(fieldColumnList)) {
            fieldColumnList.forEach(fieldColumn -> {
                genFieldColumnService.delete(fieldColumn);
            });
        }
        return genTemplateService.deleteByAuth(genTemplate);
    }

}
