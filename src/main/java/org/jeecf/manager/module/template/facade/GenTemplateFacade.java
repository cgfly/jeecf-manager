package org.jeecf.manager.module.template.facade;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.jeecf.common.exception.BusinessException;
import org.jeecf.common.lang.StringUtils;
import org.jeecf.common.model.Response;
import org.jeecf.common.utils.FileUtils;
import org.jeecf.gen.chain.ChainContext;
import org.jeecf.gen.chain.ContextConfigParams;
import org.jeecf.manager.common.enums.BusinessErrorEnum;
import org.jeecf.manager.common.properties.ThreadLocalProperties;
import org.jeecf.manager.common.utils.NamespaceUtils;
import org.jeecf.manager.common.utils.TemplateUtils;
import org.jeecf.manager.common.utils.UserUtils;
import org.jeecf.manager.gen.hook.TableHookImpl;
import org.jeecf.manager.gen.model.GenParams;
import org.jeecf.manager.gen.template.ChainTemplate;
import org.jeecf.manager.module.config.model.domain.SysNamespace;
import org.jeecf.manager.module.config.service.SysNamespaceService;
import org.jeecf.manager.module.template.model.domain.GenFieldColumn;
import org.jeecf.manager.module.template.model.domain.GenTemplate;
import org.jeecf.manager.module.template.model.po.GenFieldColumnPO;
import org.jeecf.manager.module.template.model.query.GenFieldColumnQuery;
import org.jeecf.manager.module.template.model.result.GenFieldColumnResult;
import org.jeecf.manager.module.template.model.result.GenTemplateResult;
import org.jeecf.manager.module.template.service.GenFieldColumnService;
import org.jeecf.manager.module.template.service.GenTemplateService;
import org.jeecf.manager.module.userpower.model.domain.SysUser;
import org.jeecf.manager.subject.GenSubject;
import org.jeecf.manager.subject.LogContextField;
import org.jeecf.osgi.plugin.Plugin;
import org.springframework.beans.BeanUtils;
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

    private static final ChainTemplate CHAIN_TEMPLATE = initTemplate();

    @Autowired
    private GenFieldColumnService genFieldColumnService;

    @Autowired
    private GenTemplateService genTemplateService;

    @Autowired
    private SysNamespaceService sysNamespaceService;

    @Autowired
    private ThreadLocalProperties threadLocalProperties;

    @Autowired
    private GenSubject genSubject;

    /**
     * 初始化代码生成责任链
     * 
     * @return
     */
    private static final synchronized ChainTemplate initTemplate() {
        ChainTemplate chainTemplateImpl = new ChainTemplate();
        chainTemplateImpl.initChainContext(new TableHookImpl());
        return chainTemplateImpl;
    }

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

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<GenTemplateResult> add(Integer id) {
        Response<GenTemplateResult> checkGenTemplateRes = genTemplateService.getByAuth(new GenTemplate(String.valueOf(id)));
        if (checkGenTemplateRes.isSuccess() && checkGenTemplateRes.getData() == null) {
            Response<GenTemplateResult> genTemplateRes = genTemplateService.get(new GenTemplate(String.valueOf(id)));
            if (genTemplateRes.getData() != null) {
                GenTemplateResult genTemplateResult = genTemplateRes.getData();
                GenTemplate genTemplate = new GenTemplate();
                BeanUtils.copyProperties(genTemplateResult, genTemplate);
                genTemplate.setId(null);
                Response<GenTemplateResult> genTemplateResultRes = genTemplateService.saveByAuth(genTemplate);
                GenFieldColumnQuery genFieldColumnQuery = new GenFieldColumnQuery();
                genFieldColumnQuery.setGenTemplateId(id);
                GenFieldColumnPO genFieldColumnPO = new GenFieldColumnPO(genFieldColumnQuery);
                List<GenFieldColumnResult> genFieldColumnResultList = genFieldColumnService.findList(genFieldColumnPO).getData();
                if (CollectionUtils.isNotEmpty(genFieldColumnResultList)) {
                    genFieldColumnResultList.forEach(genFieldColumnResult -> {
                        GenFieldColumn newFieldColumn = new GenFieldColumn();
                        genFieldColumnResult.setId(null);
                        genFieldColumnResult.setNewRecord(true);
                        genFieldColumnResult.setGenTemplateId(Integer.valueOf(genTemplateResultRes.getData().getId()));
                        BeanUtils.copyProperties(genFieldColumnResult, newFieldColumn);
                        genFieldColumnService.save(newFieldColumn);
                    });
                }
                Integer sysNamespaceId = genTemplateResult.getSysNamespaceId();
                SysUser sysUser = UserUtils.getCurrentUser();
                SysNamespace sysNamespace = NamespaceUtils.getNamespace(sysUser.getId());
                SysNamespace oldNamespace = sysNamespaceService.get(new SysNamespace(String.valueOf(sysNamespaceId))).getData();
                String zipFilePath = TemplateUtils.getZipFilePath(genTemplateResult.getFileBasePath(), oldNamespace.getNamespaceName());
                String newZipPath = TemplateUtils.getZipFilePath(genTemplateResult.getFileBasePath(), sysNamespace.getNamespaceName());

                String newUnzipFilePath = TemplateUtils.getUnzipPath(genTemplateResult.getFileBasePath(), sysNamespace.getNamespaceName());

                FileUtils.copyFile(zipFilePath, newZipPath);
                FileUtils.unZipFiles(newZipPath, StringUtils.substringBeforeLast(newUnzipFilePath, File.separator));

                return genTemplateResultRes;
            }
            throw new BusinessException(BusinessErrorEnum.DATA_NOT_EXIT);
        }
        throw new BusinessException(BusinessErrorEnum.DATA_EXIT);
    }

    public String build(List<GenParams> genParamsList, String tableName, String sourcePath, Integer language, SysNamespace sysNamespace, SysUser sysUser, String templateId, List<Plugin> plugins) {
        ChainContext genChainContext = CHAIN_TEMPLATE.getChainContext();
        String outZip = sourcePath + File.separator + "code.zip";
        HashMap<String, Object> extMap = new HashMap<>(8);
        ContextConfigParams contextParams = new ContextConfigParams();
        contextParams.setNamespaceId(sysNamespace.getId());
        contextParams.setNamespaceName(sysNamespace.getNamespaceName());
        contextParams.setUserId(sysUser.getId());
        contextParams.setUserName(sysUser.getUsername());
        contextParams.setSourcePath(sourcePath);
        contextParams.setTableName(tableName);
        contextParams.setOutZip(outZip);
        extMap.put("genParamsList", genParamsList);
        extMap.put("genHandlerPlugin", plugins);
        extMap.put("language", language);
        contextParams.setExtParams(extMap);
        try {
            genChainContext.setContextParams(contextParams);
            genChainContext.next();
            if (genChainContext.isFlag()) {
                String ip = threadLocalProperties.get(LogContextField.IP);
                genSubject.updateCode(sysUser.getId(), sysUser.getUsername(), templateId, ip);
                return outZip;
            }
        } finally {
            genChainContext.remove();
        }
        return null;
    }

}
