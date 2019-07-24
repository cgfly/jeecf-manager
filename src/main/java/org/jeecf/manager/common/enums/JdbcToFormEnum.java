package org.jeecf.manager.common.enums;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jeecf.common.mapper.JsonMapper;
import org.jeecf.gen.enums.FormTypeEnum;

/**
 * jdbc 类型组枚举
 * 
 * @author jianyiming
 *
 */
public enum JdbcToFormEnum {
    /**
     * 文本框对应jdbc类型
     */
    TEXT(FormTypeEnum.TEXT.getCode(), "varchar,char"),
    /**
     * 文本域对应jdbc类型
     */
    AREA(FormTypeEnum.AREA.getCode(), "text"),
    /**
     * 数字框对应jdbc类型
     */
    NUMBER(FormTypeEnum.NUMBER.getCode(), "integer,int,tinyint,bigint,long,double,decimal,bigdecimal"),
    /**
     * 时间框对应jdbc类型
     */
    TIME(FormTypeEnum.TIME.getCode(), "date,datetime,timestamp"),;

    private final int code;
    private final String name;

    public int getCode() {
        return code;
    }

    public String getName() {

        return name;
    }

    private JdbcToFormEnum(int code, String name) {
        this.code = code;
        this.name = name;
    }

    public static Integer getCode(String name) {
        for (JdbcToFormEnum e : JdbcToFormEnum.values()) {
            if (e.getName().equals(name)) {
                return e.getCode();
            }
        }
        return null;
    }

    public static String getName(int code) {
        for (JdbcToFormEnum e : JdbcToFormEnum.values()) {
            if (e.getCode() == code) {
                return e.getName();
            }
        }
        return null;
    }

    public static String toJsonString() {
        List<Map<String, Object>> dataMap = new ArrayList<>();
        for (JdbcToFormEnum e : JdbcToFormEnum.values()) {
            Map<String, Object> map = new HashMap<String, Object>(10);
            map.put("code", e.getCode());
            map.put("name", e.getName());
            dataMap.add(map);
        }
        return JsonMapper.toJson(dataMap);
    }

}
