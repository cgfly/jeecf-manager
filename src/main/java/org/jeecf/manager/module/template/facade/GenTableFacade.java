package org.jeecf.manager.module.template.facade;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.jeecf.common.lang.StringUtils;
import org.jeecf.common.model.Response;
import org.jeecf.common.utils.ResponseUtils;
import org.jeecf.manager.common.enums.JdbcToFormEnum;
import org.jeecf.manager.module.template.model.domain.GenTable;
import org.jeecf.manager.module.template.model.domain.GenTableColumn;
import org.jeecf.manager.module.template.model.po.GenTableColumnPO;
import org.jeecf.manager.module.template.model.po.GenTablePO;
import org.jeecf.manager.module.template.model.query.GenTableColumnQuery;
import org.jeecf.manager.module.template.model.query.GenTableQuery;
import org.jeecf.manager.module.template.model.result.GenTableColumnResult;
import org.jeecf.manager.module.template.model.result.GenTableResult;
import org.jeecf.manager.module.template.service.GenTableColumnService;
import org.jeecf.manager.module.template.service.GenTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * genTable 门面
 * 
 * @author jianyiming
 *
 */
@Service
@Transactional(readOnly = true, rollbackFor = RuntimeException.class)
public class GenTableFacade {

    @Autowired
    private GenTableColumnService genTableColumnService;

    @Autowired
    private GenTableService genTableService;

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<GenTableResult> saveTable(GenTable genTable) {
        Response<GenTableResult> genTableRes = genTableService.saveByAuth(genTable);
        List<GenTableColumnResult> columnList = genTable.getGenTableColumns();
        if (CollectionUtils.isNotEmpty(columnList)) {
            if (StringUtils.isNotEmpty(genTable.getId())) {
                GenTableColumn delTableColumn = new GenTableColumn();
                delTableColumn.setGenTable(genTable);
                genTableColumnService.delete(delTableColumn);
            }
            columnList.forEach(column -> {
                column.setNewRecord(true);
                column.setGenTable(genTable);
                genTableColumnService.save(column);
            });
        }
        return genTableRes;
    }

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<GenTableResult> saveTableByUpdate(GenTable genTable) {
        Response<GenTableResult> genTableRes = genTableService.saveByAuth(genTable);
        List<GenTableColumnResult> columnList = genTable.getGenTableColumns();
        if (CollectionUtils.isNotEmpty(columnList)) {
            if (!genTable.isNewRecord()) {
                GenTableColumnQuery genTableColumnQuery = new GenTableColumnQuery();
                genTableColumnQuery.setGenTable(genTable);
                GenTableColumnPO genTableColumnPO = new GenTableColumnPO(genTableColumnQuery);
                List<GenTableColumnResult> oldGenTableColumnList = genTableColumnService.findList(genTableColumnPO).getData();
                columnList.forEach(column -> {
                    GenTableColumnResult oldGenTableColumnResult = this.containByName(oldGenTableColumnList, column);
                    if (oldGenTableColumnResult != null) {
                        if (StringUtils.isEmpty(column.getComments())) {
                            column.setComments(oldGenTableColumnResult.getComments());
                        }
                        column.setField(oldGenTableColumnResult.getField());
                        column.setId(oldGenTableColumnResult.getId());
                        genTableColumnService.save(column);
                    } else {
                        column.setFormType(this.toFormType(column.getJdbcType()));
                        column.setGenTable(genTable);
                        genTableColumnService.save(column);
                    }
                });
                oldGenTableColumnList.forEach(oldColumn -> {
                    GenTableColumnResult newGenTableColumnResult = this.containByName(columnList, oldColumn);
                    if (newGenTableColumnResult == null) {
                        genTableColumnService.delete(oldColumn);
                    }
                });
            } else {
                columnList.forEach(column -> {
                    column.setNewRecord(true);
                    column.setFormType(this.toFormType(column.getJdbcType()));
                    column.setGenTable(genTable);
                    genTableColumnService.save(column);
                });
            }
        }
        return genTableRes;
    }

    /**
     * 通过列名判断是否包含当前列
     * 
     * @param columnList
     * @param oldColumn
     * @return
     */
    private GenTableColumnResult containByName(List<GenTableColumnResult> columnList, GenTableColumnResult oldColumn) {
        for (GenTableColumnResult column : columnList) {
            if (column.getGenColumnName().equals(oldColumn.getGenColumnName())) {
                return column;
            }
        }
        return null;
    }

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<Integer> deleteTable(GenTable genTable) {
        Response<Integer> genTableRes = genTableService.deleteByAuth(genTable);
        if (ResponseUtils.isNotEmpty(genTableRes)) {
            GenTableColumn deleteTableColumn = new GenTableColumn();
            deleteTableColumn.setGenTable(genTable);
            genTableColumnService.delete(deleteTableColumn);
        }
        return new Response<Integer>(true);
    }

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<GenTable> findParentTable(String parentId) {
        GenTable parentTable = null;
        if (StringUtils.isNotEmpty(parentId)) {
            GenTable queryTable = new GenTable();
            queryTable.setId(parentId);
            parentTable = this.genTableService.get(queryTable).getData();
            if (parentTable != null) {
                GenTableColumnQuery queryGenTableColumn = new GenTableColumnQuery();
                queryGenTableColumn.setGenTable(parentTable);
                List<GenTableColumnResult> genTableColumnResultList = genTableColumnService.findList(new GenTableColumnPO(queryGenTableColumn)).getData();
                parentTable.setGenTableColumns(genTableColumnResultList);
            }
        }
        return new Response<>(parentTable);
    }

    @Transactional(readOnly = false, rollbackFor = RuntimeException.class)
    public Response<List<GenTableResult>> findChildTables(String id) {
        GenTableQuery queryGenTable = new GenTableQuery();
        queryGenTable.setParentTableId(id);
        List<GenTableResult> childTableList = this.genTableService.findList(new GenTablePO(queryGenTable)).getData();
        if (CollectionUtils.isNotEmpty(childTableList)) {
            childTableList.forEach(tableResult -> {
                GenTableColumnQuery queryGenTableColumn = new GenTableColumnQuery();
                queryGenTableColumn.setGenTable(tableResult);
                List<GenTableColumnResult> genTableColumnResultList = genTableColumnService.findList(new GenTableColumnPO(queryGenTableColumn)).getData();
                tableResult.setGenTableColumns(genTableColumnResultList);
            });
        }
        return new Response<>(childTableList);
    }

    /**
     * 根据jdbcType 获取formType值
     * 
     * @param jdbcType
     * @return
     */
    private Integer toFormType(String jdbcType) {
        if (StringUtils.isNotEmpty(jdbcType)) {
            String type = jdbcType.split("\\(")[0];
            for (JdbcToFormEnum formEnum : JdbcToFormEnum.values()) {
                if (formEnum.getName().contains(type)) {
                    return formEnum.getCode();
                }
            }
        }
        return null;
    }

}
