delimiter $$
CREATE PROCEDURE initDB()
 BEGIN
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='customer_action_log')
  then
  CREATE TABLE `customer_action_log` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '主机地址',
    `user_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户',
    `action_type` int(5) NOT NULL DEFAULT '0' COMMENT '操作类型',
    `action_data` varchar(255) NOT NULL DEFAULT '' COMMENT '行为数据',
    `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
    `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
    `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
    PRIMARY KEY (`id`),
    KEY `idx_user_name` (`user_name`) USING BTREE COMMENT '用户名索引',
    KEY `idx_action_type` (`action_type`) USING BTREE COMMENT '用户行为索引',
    KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户日志';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='gen_field_column')
  then 
      CREATE TABLE `gen_field_column` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `gen_template_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联gen_template',
      `field_column_name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
      `is_null` int(1) NOT NULL DEFAULT '0' COMMENT '是否允许为空',
      `default_value` varchar(30) NOT NULL DEFAULT '' COMMENT '默认值',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      KEY `idx_gen_template_id` (`gen_template_id`) USING BTREE COMMENT '关联模版索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='生成参数列表';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='gen_table')
  then
      CREATE TABLE `gen_table` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
      `gen_table_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '名称',
      `comments` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '解释',
      `class_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '实体类名称',
      `parent_table_id` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '关联父表',
      `parent_table_fk` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '关联父表外键',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '命名空间',
      `sys_dbsource_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联数据源',
      `remark` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注信息',
      `create_by` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '创建人',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_by` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '更新人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_gen_table` (`gen_table_name`,`sys_namespace_id`,`sys_dbsource_id`) USING BTREE COMMENT '唯一约束',
      KEY `idx_table_ame` (`gen_table_name`) USING BTREE COMMENT '表名索引',
      KEY `idx_namespace_id` (`sys_namespace_id`) USING BTREE COMMENT '命名空间索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务表';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='gen_table_column')
  then
      CREATE TABLE `gen_table_column` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `gen_table_id` int(11) NOT NULL DEFAULT '0' COMMENT '归属表编号',
      `gen_column_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '名称',
      `comments` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '解释',
      `jdbc_type` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'jdbc类型',
      `field` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'JAVA字段名',
      `is_key` int(1) NOT NULL DEFAULT '0' COMMENT '是否为主键',
      `is_null` int(1) NOT NULL DEFAULT '0' COMMENT '是否可为空',
      `is_insert` int(1) NOT NULL DEFAULT '0' COMMENT '是否为插入字段',
      `is_edit` int(1) NOT NULL DEFAULT '0' COMMENT '是否编辑字段',
      `is_list` int(1) NOT NULL DEFAULT '0' COMMENT '是否列表字段',
      `is_query` int(1) NOT NULL DEFAULT '0' COMMENT '是否查询字段',
      `query_type` int(2) NOT NULL DEFAULT '0' COMMENT '查询方式',
      `form_type` int(2) NOT NULL DEFAULT '0' COMMENT '表单类型',
      `sort` int(8) NOT NULL DEFAULT '0' COMMENT '排序',
      `remark` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注信息',
      `create_by` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '创建人',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_by` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '更新人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      PRIMARY KEY (`id`),
      KEY `idx_table_id` (`gen_table_id`) USING BTREE COMMENT '关联表信息索引',
      KEY `idx_sort` (`sort`) USING BTREE COMMENT '排序索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务表字段';  
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='gen_template')
  then
      CREATE TABLE `gen_template` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `template_name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属命名空间',
      `language` int(1) NOT NULL DEFAULT '1' COMMENT '语言',
      `file_base_path` varchar(100) NOT NULL DEFAULT '' COMMENT '模版文件基础路径',
      `version` varchar(20) NOT NULL DEFAULT '' COMMENT '版本号',
      `wiki_uri` varchar(100) NOT NULL DEFAULT '' COMMENT 'wiki地址',
      `tags` varchar(64) NOT NULL DEFAULT '' COMMENT '标签',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_template` (`template_name`,`sys_namespace_id`,`version`) USING BTREE COMMENT '唯一约束',
      KEY `idx_template_name` (`template_name`) USING BTREE COMMENT '关联模版名称索引',
      KEY `idx_namespace_id` (`sys_namespace_id`) USING BTREE COMMENT '关联命名空间索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成模版信息';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_dbsource')
  then
      CREATE TABLE `sys_dbsource` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `key_name` varchar(20) NOT NULL DEFAULT '' COMMENT '关键字',
      `url` varchar(150) NOT NULL DEFAULT '' COMMENT '连接串',
      `user_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
      `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
      `permission` varchar(50) NOT NULL DEFAULT '' COMMENT '权限控制',
      `Usable` int(1) NOT NULL DEFAULT '1' COMMENT '是否可用 1.可用 2.不可用',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_dbsource` (`key_name`) USING BTREE COMMENT '唯一约束',
      KEY `idx_permission` (`permission`) USING BTREE COMMENT '权限索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据库连接信息';
      START TRANSACTION;
          INSERT INTO `sys_dbsource` VALUES ('2', 'defaultDataSourceKey', 'jdbc:mysql://127.0.0.1:3306/jeecf?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull', 'root', 'ltACiHjVjIn+uVm31GQvyw==', 'config:sysDbsource:work', '1', '', '0', '2018-11-10 16:17:28', 'be50e868ce4841ebb63bb1694b2413ef', '2019-06-25 16:34:17', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_dict')
  then
      CREATE TABLE `sys_dict` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `dict_type` varchar(50) NOT NULL DEFAULT '' COMMENT '类型',
      `dict_name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
      `label` varchar(20) NOT NULL DEFAULT '' COMMENT '标签',
      `dict_value` int(5) NOT NULL DEFAULT '0' COMMENT '值',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联命名空间',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_dict` (`dict_type`,`sys_namespace_id`,`label`) USING BTREE COMMENT '唯一约束',
      KEY `idx_type` (`dict_type`) USING BTREE COMMENT '字典类型索引',
      KEY `idx_namespace_id` (`sys_namespace_id`) USING BTREE COMMENT '命名空间索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典';
      START TRANSACTION;
          INSERT INTO `sys_dict` VALUES ('90', 'sex', '男', 'MAN', '1', '性别', '1', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-01 11:42:12', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-01 21:22:29'), ('94', 'language', '汉语', 'CHINESE', '1', '语言', '1', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-15 12:58:29', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-15 12:58:29'), ('95', 'language', '英语', 'ENGLISH', '2', '语言', '1', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-15 13:01:17', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-15 13:01:17'), ('98', 'sex', '女', 'WOMAN', '2', '性别', '1', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-18 14:12:13', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-18 14:12:13');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_menu')
  then
      CREATE TABLE `sys_menu` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
      `node_name` varchar(20) NOT NULL DEFAULT '' COMMENT '菜单名',
      `label` varchar(20) NOT NULL DEFAULT '' COMMENT '标签',
      `parent_id` varchar(11) NOT NULL DEFAULT '' COMMENT '父菜单索引',
      `parent_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '所有父菜单索引',
      `node_level` int(5) NOT NULL DEFAULT '0' COMMENT '菜单等级',
      `module_label` varchar(20) NOT NULL DEFAULT '' COMMENT '模块菜单标签',
      `sort` int(8) NOT NULL DEFAULT '0' COMMENT '排序',
      `route` int(1) NOT NULL DEFAULT '0' COMMENT '路由',
      `permission` varchar(50) NOT NULL DEFAULT '' COMMENT '权限',
      `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '图标标识',
      `is_icon` int(1) NOT NULL DEFAULT '0' COMMENT '是否显示图标',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_menu` (`label`) USING BTREE COMMENT '唯一约束', 
      KEY `idx_module_label` (`module_label`) USING BTREE COMMENT '模块菜单标签索引',
      KEY `idx_permission` (`permission`) USING BTREE COMMENT '权限索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单';
      START TRANSACTION;
          INSERT INTO `sys_menu` VALUES ('4', '代码数据', 'gen', '', '', '1', 'gen', '30', '0', 'gen:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-06-09 21:43:22', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:20:35'), ('7', '数表配置', 'genTable', '34', '34', '2', 'template', '20', '1', 'template:genTable:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-06-22 21:55:25', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:21:00'), ('11', '配置中心', 'config', '', '', '1', 'config', '20', '0', 'config:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-04 22:31:34', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 10:36:48'), ('12', '菜单配置', 'sysMenu', '11', '11', '2', 'config', '10', '1', 'config:sysMenu:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-04 22:31:34', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 10:36:48'), ('23', '数据字典', 'sysDict', '4', '4', '2', 'gen', '10', '1', 'gen:sysDict:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-17 23:37:42', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:42:46'), ('24', '用户权限', 'userpower', '', '', '1', 'userpower', '20', '0', 'userpower:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-23 23:15:24', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-31 00:18:59'), ('25', '权限配置', 'sysPower', '24', '24', '2', 'userpower', '40', '1', 'userpower:sysPower:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-23 23:15:57', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-25 10:45:22'), ('26', '系统角色', 'sysRole', '24', '24', '2', 'userpower', '30', '1', 'userpower:sysRole:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-24 23:50:29', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-25 10:45:37'), ('27', '系统用户', 'sysUser', '24', '24', '2', 'userpower', '10', '1', 'userpower:sysUser:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-28 19:56:21', 'be50e868ce4841ebb63bb1694b2413ef', '2018-07-31 00:18:59'), ('28', '运维管理', 'operation', '', '', '1', 'operation', '60', '0', 'operation:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-11 19:52:44', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:21:09'), ('29', 'api 接口', 'swagger2', '28', '28', '2', 'operation', '10', '1', 'operation:swagger2:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-11 20:08:06', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:21:09'), ('30', '连接池监控', 'druid', '28', '28', '2', 'operation', '20', '1', 'operation:druid:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-11 22:06:06', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:21:09'), ('31', '密码修改', 'sysPwd', '24', '24', '2', 'userpower', '20', '1', 'userpower:sysPwd:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-25 10:45:03', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 11:27:03'), ('32', '数据库配置', 'sysDbsource', '11', '11', '2', 'config', '40', '1', 'config:sysDbsource:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-08-28 13:05:48', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 10:36:48'), ('33', '命名空间', 'sysNamespace', '11', '11', '2', 'config', '20', '1', 'config:sysNamespace:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-09-09 15:38:01', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 10:36:48'), ('34', '模版生成', 'template', '', '', '1', 'template', '40', '0', 'template:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-09-15 22:05:59', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:21:00'), ('37', '模版配置', 'genTemplate', '34', '34', '2', 'template', '30', '1', 'template:genTemplate:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-09-16 18:48:36', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-27 19:21:00'), ('39', '文档', 'doc', '', '', '1', 'doc', '10', '0', 'doc:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 10:26:04', 'be50e868ce4841ebb63bb1694b2413ef', '2019-06-23 14:21:24'), ('40', '功能介绍', 'functionIntroduction', '39', '39', '2', 'doc', '10', '1', 'doc:functionIntroduction:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-10-28 10:26:45', 'be50e868ce4841ebb63bb1694b2413ef', '2019-06-23 14:21:24'), ('41', '客户操作日志', 'customerActionLog', '28', '28', '2', 'operation', '30', '1', 'operation:customerActionLog:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-11-22 15:33:37', 'be50e868ce4841ebb63bb1694b2413ef', '2018-11-22 15:33:37'), ('42', '组织结构', 'sysOffice', '11', '11', '2', 'config', '30', '1', 'config:sysOffice:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-09 09:45:55', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-09 09:45:55'), ('43', '表组字典', 'sysTableDict', '4', '4', '2', 'gen', '40', '1', 'gen:sysTableDict:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-16 10:40:17', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-16 10:40:17'), ('44', '树组字典', 'sysTreeDict', '4', '4', '2', 'gen', '40', '1', 'gen:sysTreeDict:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-28 20:33:38', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-28 20:33:38'), ('45', '功能扩展', 'extend', '', '', '1', 'extend', '50', '0', 'extend:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-03 20:43:06', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-03 20:43:06'), ('46', '虚表配置', 'sysVirtualTable', '45', '45', '2', 'extend', '10', '1', 'extend:sysVirtualTable:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-03 20:43:36', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-03 20:43:36'), ('47', '全量插件', 'sysOsgiPluginAll', '45', '45', '2', 'extend', '30', '1', 'extend:sysOsgiPluginAll:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-09 16:13:27', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-09 16:13:27'), ('48', '插件管理', 'sysOsgiPlugin', '45', '45', '2', 'extend', '20', '1', 'extend:sysOsgiPlugin:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-10 16:23:35', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-10 16:23:35'), ('49', '全量模版', 'genTemplateAll', '34', '34', '2', 'template', '40', '1', 'template:genTemplateAll:view', '', '0', '', 'be50e868ce4841ebb63bb1694b2413ef', '2019-04-21 16:09:06', 'be50e868ce4841ebb63bb1694b2413ef', '2019-04-21 16:09:06');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_namespace')
  then
      CREATE TABLE `sys_namespace` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `namespace_name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `permission` varchar(50) NOT NULL DEFAULT '' COMMENT '权限',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_namespace` (`namespace_name`) USING BTREE COMMENT '唯一约束',
      KEY `idx_permission` (`permission`) USING BTREE COMMENT '权限索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统命名空间';
      START TRANSACTION;
          INSERT INTO `sys_namespace` VALUES ('1', 'work', '工作', 'config:sysNamespace:work', '', '0', '2018-11-24 08:53:18', 'be50e868ce4841ebb63bb1694b2413ef', '2019-06-23 15:24:22', 'be50e868ce4841ebb63bb1694b2413ef'), ('5', 'guest', '客户', 'config:sysNamespace:guest', '', '0', '2018-11-30 18:03:56', 'be50e868ce4841ebb63bb1694b2413ef', '2019-01-13 10:13:52', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_office')
  then
      CREATE TABLE `sys_office` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `node_name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
      `enname` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名称',
      `parent_id` varchar(11) NOT NULL DEFAULT '' COMMENT '父级',
      `parent_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '所有父级',
      `node_level` int(5) NOT NULL DEFAULT '0' COMMENT '等级',
      `sort` int(8) NOT NULL DEFAULT '0' COMMENT '排序',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(255) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(255) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组织机构';
      START TRANSACTION;
          INSERT INTO `sys_office` VALUES ('1', 'jeecf', 'jeecf', '', '', '1', '10', '', '2018-12-09 10:26:02', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-18 12:50:37', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_osgi_plugin')
  then
      CREATE TABLE `sys_osgi_plugin` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `plugin_name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '命名空间',
      `boundle_type` int(5) NOT NULL DEFAULT '0' COMMENT '插件类型',
      `wiki_uri` varchar(100) NOT NULL DEFAULT '' COMMENT 'wiki地址',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_osgi_plugin` (`plugin_name`,`sys_namespace_id`) USING BTREE COMMENT '唯一约束'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='OSGI 插件管理表';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_power')
  then
      CREATE TABLE `sys_power` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `node_name` varchar(20) NOT NULL DEFAULT '' COMMENT '权限名称',
      `permission` varchar(50) NOT NULL DEFAULT '' COMMENT '权限标识',
      `parent_id` varchar(11) NOT NULL DEFAULT '' COMMENT '父级',
      `parent_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '所有父级',
      `label` int(1) NOT NULL DEFAULT '0' COMMENT '标签',
      `node_level` int(5) NOT NULL DEFAULT '0' COMMENT '等级',
      `sort` int(8) NOT NULL DEFAULT '0' COMMENT '排序',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_power` (`permission`) USING BTREE COMMENT '唯一约束',
      KEY `idx_name` (`node_name`) USING BTREE COMMENT '权限名称索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统权限表';
      START TRANSACTION;
          INSERT INTO `sys_power` VALUES ('10', '代码生成菜单权限', 'gen:base', '', '', '1', '1', '40', '', '2018-07-31 23:56:01', '2018-11-04 13:42:59', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('11', '业务表菜单权限', 'template:genTable:base', '26', '26', '1', '2', '10', '', '2018-07-31 23:57:57', '2018-11-04 13:43:36', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('13', '系统用户菜单权限', 'userpower:sysUser:base', '15', '15', '1', '2', '10', '', '2018-08-01 20:28:03', '2018-11-04 13:44:45', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('14', '配置中心菜单权限', 'config:base', '', '', '1', '1', '20', '', '2018-08-01 20:49:57', '2018-11-04 13:40:10', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('15', '用户管理菜单权限', 'userpower:base', '', '', '1', '1', '30', '', '2018-08-01 20:51:17', '2018-11-04 13:42:37', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('16', '菜单配置权限', 'config:sysMenu:base', '14', '14', '1', '2', '10', '', '2018-08-02 23:41:46', '2018-11-22 23:44:43', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('17', '数据字典权限', 'gen:sysDict:base', '10', '10', '1', '2', '20', '', '2018-08-02 23:53:28', '2018-11-04 13:43:13', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('18', '系统角色权限', 'userpower:sysRole:base', '15', '15', '1', '2', '30', '', '2018-08-02 23:57:28', '2018-11-04 13:45:10', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('19', '权限配置菜单权限', 'userpower:sysPower:base', '15', '15', '1', '2', '40', '', '2018-08-02 23:58:59', '2018-11-04 13:45:42', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('20', '运维管理菜单权限', 'operation:base', '', '', '1', '1', '60', '', '2018-08-11 19:55:32', '2018-11-04 13:44:14', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('21', 'api接口菜单权限', 'operation:swagger2:base', '20', '20', '1', '2', '10', '', '2018-08-11 20:16:01', '2018-11-04 13:44:24', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('22', '数据库连接池菜单权限', 'operation:druid:base', '20', '20', '1', '2', '20', '', '2018-08-11 22:07:22', '2018-11-04 13:44:33', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('23', '密码修改权限', 'userpower:sysPwd:base', '15', '15', '1', '2', '20', '', '2018-08-25 11:02:25', '2018-11-04 13:44:59', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('24', '数据库配置权限', 'config:sysDbsource:base', '14', '14', '1', '2', '30', '', '2018-08-28 13:07:25', '2018-11-04 13:42:23', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('25', '命名空间配置权限', 'config:sysNamespace:base', '14', '14', '1', '2', '20', '', '2018-09-09 15:39:45', '2018-11-04 13:42:00', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('26', '模版生成权限', 'template:base', '', '', '1', '1', '50', '', '2018-09-15 22:12:49', '2018-11-04 13:43:27', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('29', '模版配置权限', 'template:genTemplate:base', '26', '26', '1', '2', '30', '', '2018-09-16 19:04:36', '2018-11-04 13:43:49', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('31', '文档权限', 'doc:base', '', '', '1', '1', '10', '', '2018-10-28 10:37:37', '2019-06-23 22:50:58', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('32', '功能介绍文档权限', 'doc:functionIntroduction:base', '31', '31', '1', '2', '10', '', '2018-10-28 10:39:06', '2019-06-23 22:50:58', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('33', '数据库配置视图权限', 'config:sysDbsource:view', '24', '14,24', '1', '3', '10', '', '2018-11-01 11:08:42', '2018-11-01 11:08:42', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('34', '菜单配置视图权限', 'config:sysMenu:view', '16', '14,16', '1', '3', '10', '', '2018-11-01 12:57:16', '2018-11-01 12:57:16', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('35', '菜单配置编辑权限', 'config:sysMenu:edit', '16', '14,16', '1', '3', '20', '', '2018-11-01 12:57:56', '2018-11-01 12:57:56', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('36', '命名空间配置视图权限', 'config:sysNamespace:view', '25', '14,25', '1', '3', '10', '', '2018-11-01 13:01:07', '2018-11-01 13:01:07', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('37', '命名空间配置编辑权限', 'config:sysNamespace:edit', '25', '14,25', '1', '3', '20', '', '2018-11-01 13:01:44', '2018-11-01 13:01:44', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('38', '数据库配置编辑权限', 'config:sysDbsource:edit', '24', '14,24', '1', '3', '20', '', '2018-11-01 13:02:37', '2018-11-01 13:02:37', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('39', '数据字典视图权限', 'gen:sysDict:view', '17', '10,17', '1', '3', '10', '', '2018-11-01 13:03:31', '2018-11-01 13:03:31', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('40', '数据字典编辑权限', 'gen:sysDict:edit', '17', '10,17', '1', '3', '20', '', '2018-11-01 13:04:26', '2018-11-01 13:04:26', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('41', '系统用户菜单视图权限', 'userpower:sysUser:view', '13', '15,13', '1', '3', '10', '', '2018-11-01 13:05:39', '2018-11-01 13:05:39', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('42', '系统用户菜单编辑权限', 'userpower:sysUser:edit', '13', '15,13', '1', '3', '20', '', '2018-11-01 13:06:37', '2018-11-01 13:06:37', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('43', '系统角色视图权限', 'userpower:sysRole:view', '18', '15,18', '1', '3', '10', '', '2018-11-01 13:07:49', '2018-11-01 13:07:49', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('44', '系统角色编辑权限', 'userpower:sysRole:edit', '18', '15,18', '1', '3', '40', '', '2018-11-01 13:08:33', '2018-11-01 13:08:33', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('45', '权限配置菜单视图权限', 'userpower:sysPower:view', '19', '15,19', '1', '3', '10', '', '2018-11-01 13:09:17', '2018-11-01 13:09:17', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('46', '权限配置菜单编辑权限', 'userpower:sysPower:edit', '19', '15,19', '1', '3', '20', '', '2018-11-01 13:09:58', '2018-11-01 13:09:58', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('47', '业务表菜单视图权限', 'template:genTable:view', '11', '26,11', '1', '3', '10', '', '2018-11-01 13:11:28', '2018-11-01 13:11:28', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('48', '业务表菜单编辑权限', 'template:genTable:edit', '11', '26,11', '1', '3', '20', '', '2018-11-01 13:12:02', '2018-11-01 13:12:02', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('49', '模版配置视图权限', 'template:genTemplate:view', '29', '26,29', '1', '3', '10', '', '2018-11-01 13:13:04', '2018-11-01 13:13:04', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('50', '模版配置编辑权限', 'template:genTemplate:edit', '29', '26,29', '1', '3', '20', '', '2018-11-01 13:13:48', '2018-11-01 13:13:48', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('54', '数据源work权限', 'config:sysDbsource:work', '14', '14', '3', '2', '30', '', '2018-11-02 21:06:04', '2018-11-04 13:40:10', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('55', '数据源guest权限', 'config:sysDbsource:guest', '14', '14', '3', '2', '30', '', '2018-11-03 14:38:36', '2018-11-30 17:59:48', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('57', '客户操作日志权限', 'operation:customerActionLog:view', '20', '20', '1', '2', '30', '', '2018-11-22 15:34:52', '2018-11-22 15:38:52', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('58', '命名空间work权限', 'config:sysNamespace:work', '14', '14', '2', '2', '20', '', '2018-11-24 09:06:51', '2018-11-24 09:06:51', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('62', '命名空间guest权限', 'config:sysNamespace:guest', '14', '14', '2', '2', '10', '', '2018-11-30 18:03:56', '2018-12-04 14:37:51', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('63', '组织结构权限', 'config:sysOffice:base', '14', '14', '1', '2', '30', '', '2018-12-09 09:46:42', '2018-12-09 09:46:42', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('64', '组织结构视图权限', 'config:sysOffice:view', '63', '14,63', '1', '3', '10', '', '2018-12-09 10:00:13', '2018-12-09 10:00:13', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('65', '组织结构编辑权限', 'config:sysOffice:edit', '63', '14,63', '1', '3', '20', '', '2018-12-09 10:03:30', '2018-12-09 10:03:30', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('66', '表组字典权限', 'gen:sysTableDict:base', '10', '10', '1', '2', '50', '', '2018-12-16 10:41:58', '2018-12-16 10:41:58', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('67', '表组字典编辑权限', 'gen:sysTableDict:edit', '66', '10,66', '1', '3', '10', '', '2018-12-16 10:42:28', '2018-12-16 10:42:28', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('68', '表组字典视图权限', 'gen:sysTableDict:view', '66', '10,66', '1', '3', '20', '', '2018-12-16 10:45:36', '2018-12-16 10:45:36', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('69', '树组字典权限', 'gen:sysTreeDict:base', '10', '10', '1', '2', '50', '', '2018-12-28 20:34:39', '2018-12-28 20:34:39', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('70', '树组字典视图权限', 'gen:sysTreeDict:view', '69', '10,69', '1', '3', '10', '', '2018-12-28 20:36:06', '2019-01-18 14:09:15', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('71', '树组字典编辑权限', 'gen:sysTreeDict:edit', '69', '10,69', '1', '3', '20', '', '2018-12-28 20:36:40', '2019-01-18 14:09:31', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('72', '功能扩展权限', 'extend:base', '', '', '1', '1', '70', '', '2019-01-03 20:45:01', '2019-01-03 20:45:01', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('73', '虚表权限', 'extend:sysVirtualTable:base', '72', '72', '1', '2', '10', '', '2019-01-03 20:45:48', '2019-01-03 20:45:48', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('74', '虚表视图权限', 'extend:sysVirtualTable:view', '73', '72,73', '1', '3', '10', '', '2019-01-03 20:46:34', '2019-01-03 20:46:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('75', '虚表编辑权限', 'extend:sysVirtualTable:edit', '73', '72,73', '1', '3', '20', '', '2019-01-03 20:47:01', '2019-01-03 20:47:01', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('76', 'OSGI插件权限', 'extend:sysOsgiPluginAll:base', '72', '72', '1', '2', '20', '', '2019-01-09 16:16:11', '2019-01-09 16:24:27', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('77', '全量插件视图权限', 'extend:sysOsgiPluginAll:view', '76', '72,76', '1', '3', '10', '', '2019-01-09 16:16:41', '2019-01-09 16:24:53', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('78', '全量插件编辑权限', 'extend:sysOsgiPluginAll:edit', '76', '72,76', '1', '3', '20', '', '2019-01-09 16:17:43', '2019-01-09 16:25:06', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('79', '插件管理权限', 'extend:sysOsgiPlugin:base', '72', '72', '1', '2', '80', '', '2019-01-10 16:24:20', '2019-01-10 16:24:20', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('80', '插件管理视图权限', 'extend:sysOsgiPlugin:view', '79', '72,79', '1', '3', '10', '', '2019-01-10 16:25:07', '2019-01-10 16:25:07', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('81', '插件管理编辑权限', 'extend:sysOsgiPlugin:edit', '79', '72,79', '1', '3', '20', '', '2019-01-10 16:26:32', '2019-01-10 16:26:32', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('82', '指标监控', 'operation:actuator:view', '20', '20', '1', '2', '40', '', '2019-03-09 09:14:23', '2019-03-09 09:14:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('83', '全量模版权限', 'template:genTemplateAll:base', '26', '26', '1', '2', '50', '', '2019-04-21 16:06:04', '2019-04-21 16:06:04', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('84', '全量模版视图权限', 'template:genTemplateAll:view', '83', '26,83', '1', '3', '10', '', '2019-04-21 16:06:49', '2019-04-21 16:06:49', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('85', '全量模版编辑权限', 'template:genTemplateAll:edit', '83', '26,83', '1', '3', '20', '', '2019-04-21 16:07:23', '2019-04-21 16:07:23', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_role')
  then
      CREATE TABLE `sys_role` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `role_name` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
      `enname` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_role` (`enname`) USING BTREE COMMENT '唯一约束',
      KEY `idx_role_name` (`role_name`) USING BTREE COMMENT '角色名称索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色表';
      START TRANSACTION;
          INSERT INTO `sys_role` VALUES ('4', '管理员', 'admin', 'admin', '2018-07-27 22:07:59', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('5', '客户', 'guest', 'guest', '2018-11-01 16:24:41', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_role_power')
  then
      CREATE TABLE `sys_role_power` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联角色',
      `power_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联权限',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_role_power` (`role_id`,`power_id`) USING BTREE COMMENT '唯一约束',
      KEY `idx_role_id` (`role_id`) USING BTREE COMMENT '关联角色索引',
      KEY `idx_power_id` (`power_id`) USING BTREE COMMENT '关联权限索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色权限关联信息';
      START TRANSACTION;
          INSERT INTO `sys_role_power` VALUES ('513', '5', '70', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('514', '5', '80', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('515', '5', '79', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('516', '5', '77', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('517', '5', '76', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('518', '5', '74', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('519', '5', '73', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('520', '5', '72', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('521', '5', '69', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('522', '5', '32', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('523', '5', '31', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('524', '5', '68', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('525', '5', '66', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('526', '5', '64', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('527', '5', '63', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('528', '5', '62', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('529', '5', '55', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('530', '5', '57', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('531', '5', '20', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('533', '5', '29', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('534', '5', '11', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('535', '5', '26', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('536', '5', '17', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('537', '5', '10', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('538', '5', '24', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('539', '5', '25', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('540', '5', '14', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('541', '5', '54', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('543', '5', '49', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('544', '5', '47', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('545', '5', '39', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('546', '5', '36', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('547', '5', '33', '', '2019-01-18 14:06:34', '2019-01-18 14:06:34', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4303', '4', '85', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4304', '4', '84', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4305', '4', '83', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4306', '4', '82', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4307', '4', '71', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4308', '4', '70', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4309', '4', '81', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4310', '4', '80', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4311', '4', '79', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4312', '4', '78', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4313', '4', '77', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4314', '4', '76', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4315', '4', '75', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4316', '4', '74', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4317', '4', '73', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4318', '4', '72', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4319', '4', '69', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4320', '4', '32', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4321', '4', '31', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4322', '4', '68', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4323', '4', '67', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4324', '4', '66', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4325', '4', '65', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4326', '4', '64', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4327', '4', '63', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4328', '4', '62', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4329', '4', '55', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4330', '4', '58', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4331', '4', '16', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4332', '4', '57', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4333', '4', '19', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4334', '4', '18', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4335', '4', '23', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4336', '4', '13', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4337', '4', '22', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4338', '4', '21', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4339', '4', '20', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4340', '4', '29', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4341', '4', '11', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4342', '4', '26', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4343', '4', '17', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4344', '4', '10', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4345', '4', '15', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4346', '4', '24', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4347', '4', '25', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4348', '4', '14', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4349', '4', '54', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4350', '4', '50', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4351', '4', '49', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4352', '4', '48', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4353', '4', '47', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4354', '4', '46', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4355', '4', '45', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4356', '4', '44', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4357', '4', '43', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4358', '4', '42', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4359', '4', '41', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4360', '4', '40', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4361', '4', '39', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4362', '4', '38', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4363', '4', '37', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4364', '4', '36', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4365', '4', '35', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4366', '4', '34', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef'), ('4367', '4', '33', '', '2019-06-23 17:03:38', '2019-06-23 17:03:38', 'be50e868ce4841ebb63bb1694b2413ef', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_table_dict')
  then
      CREATE TABLE `sys_table_dict` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `dict_name` varchar(20) NOT NULL DEFAULT '' COMMENT '组名',
      `dict_table_name` varchar(30) NOT NULL DEFAULT '' COMMENT '表名',
      `field` varchar(30) NOT NULL DEFAULT '' COMMENT '属性',
      `comments` varchar(50) NOT NULL DEFAULT '' COMMENT '注释',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `sys_dbsource_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联数据源',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '命名空间',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_table_dict` (`dict_name`,`dict_table_name`,`sys_dbsource_id`,`sys_namespace_id`) USING BTREE COMMENT '唯一约束'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统表组字典';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_tree_dict')
  then
      CREATE TABLE `sys_tree_dict` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `node_name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
      `parent_id` varchar(11) NOT NULL DEFAULT '' COMMENT '父节点',
      `parent_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '所有父节点',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '命名空间',
      `input` varchar(30) NOT NULL DEFAULT '' COMMENT '输入',
      `calculation` varchar(50) NOT NULL DEFAULT '0' COMMENT '计算',
      `output` varchar(30) NOT NULL DEFAULT '' COMMENT '输出',
      `node_level` int(5) NOT NULL DEFAULT '0' COMMENT '等级',
      `group_name` varchar(20) NOT NULL DEFAULT '' COMMENT '组别',
      `sort` int(8) NOT NULL DEFAULT '0' COMMENT '排序',
      `description` varchar(50) NOT NULL DEFAULT '' COMMENT '描述',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(255) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(255) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_tree_dict` (`node_name`,`sys_namespace_id`) USING BTREE COMMENT '唯一约束'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='树组字典';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_user')
  then
      CREATE TABLE `sys_user` (
      `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
      `username` varchar(20) NOT NULL DEFAULT '' COMMENT '账户',
      `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
      `real_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
      `sys_office_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联组织结构',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_user` (`username`) USING BTREE COMMENT '唯一约束',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';
      START TRANSACTION;
          INSERT INTO `sys_user` VALUES ('231e7179e1494c25acc6396576096512', 'guest', 'bff7fe14d15571cbe9d02f91083613261777c3b5cec326846469ac35', 'guest', '1', '', '0', '2018-11-01 16:24:57', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-07 12:07:13', 'be50e868ce4841ebb63bb1694b2413ef'), ('be50e868ce4841ebb63bb1694b2413ef', 'admin', '264acb675c337d8c2a159ecff10bf25f4e42497ffbbb2864dc0da848', 'admin', '1', '', '0', '2018-08-09 23:42:07', '1b6a9a1d8b2b46819fd9d4d7cefd8ecd', '2018-09-02 12:58:19', 'be50e868ce4841ebb63bb1694b2413ef');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_user_dbsource')
  then
      CREATE TABLE `sys_user_dbsource` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `user_id` varchar(50) NOT NULL DEFAULT '0' COMMENT '用户id',
      `dbsource_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据源id',
      `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(100) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(100) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_user_dbsource` (`user_id`) USING BTREE COMMENT '唯一约束',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引',
      KEY `idx_user_dbsource` (`user_id`,`dbsource_id`) USING BTREE COMMENT '关联用户与关联数据源联合索引',
      KEY `idx_dbsource` (`dbsource_id`) USING BTREE COMMENT '关联数据源索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户数据源 对应关系表';
      START TRANSACTION;
          INSERT INTO `sys_user_dbsource` VALUES ('3', 'be50e868ce4841ebb63bb1694b2413ef', '2', '', '2019-03-01 18:45:25', 'be50e868ce4841ebb63bb1694b2413ef', '2019-03-01 18:45:25', 'be50e868ce4841ebb63bb1694b2413ef'), ('4', '231e7179e1494c25acc6396576096512', '2', '', '2019-03-07 14:04:45', '231e7179e1494c25acc6396576096512', '2019-03-07 14:04:45', '231e7179e1494c25acc6396576096512');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_user_namespace')
  then
      CREATE TABLE `sys_user_namespace` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `user_id` varchar(64) NOT NULL DEFAULT '' COMMENT '用户id',
      `namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '命名空间id',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `create_by` varchar(100) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `update_by` varchar(100) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_user_namespace` (`user_id`) USING BTREE COMMENT '唯一约束',
      KEY `idx_namespace` (`namespace_id`) USING BTREE COMMENT '关联命名空间索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引',
      KEY `idx_user_namespace` (`user_id`,`namespace_id`) USING BTREE COMMENT '关联用户与关联命名空间联合索引'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户命名空间 对应关系';
      START TRANSACTION;
          INSERT INTO `sys_user_namespace` VALUES ('3', 'be50e868ce4841ebb63bb1694b2413ef', '5', '', '2018-09-27 13:57:46', 'be50e868ce4841ebb63bb1694b2413ef', '2019-06-22 19:52:49', 'be50e868ce4841ebb63bb1694b2413ef'), ('5', '231e7179e1494c25acc6396576096512', '5', '', '2018-11-30 19:32:02', '231e7179e1494c25acc6396576096512', '2018-11-30 19:32:02', '231e7179e1494c25acc6396576096512');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_user_role')
  then
      CREATE TABLE `sys_user_role` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `user_id` varchar(255) NOT NULL DEFAULT '' COMMENT '关联系统用户',
      `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联系统角色',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_by` varchar(255) NOT NULL DEFAULT '' COMMENT '创建人',
      `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_by` varchar(255) NOT NULL DEFAULT '' COMMENT '更新人',
      `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_user_role` (`user_id`,`role_id`) USING BTREE COMMENT '唯一约束',
      KEY `idx_user` (`user_id`) USING BTREE COMMENT '关联用户索引',
      KEY `idx_role` (`role_id`) USING BTREE COMMENT '关联角色索引',
      KEY `idx_create_date` (`create_date`) USING BTREE COMMENT '创建时间索引'
      ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统用户角色对应表';
      START TRANSACTION;
          INSERT INTO `sys_user_role` VALUES ('1', '231e7179e1494c25acc6396576096512', '5', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-07 12:07:13', 'be50e868ce4841ebb63bb1694b2413ef', '2018-12-07 12:07:13'), ('5', 'be50e868ce4841ebb63bb1694b2413ef', '4', '', 'be50e868ce4841ebb63bb1694b2413ef', '2018-09-02 12:58:19', 'be50e868ce4841ebb63bb1694b2413ef', '2018-09-02 12:58:19');
      COMMIT;
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_virtual_table')
  then
      CREATE TABLE `sys_virtual_table` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `virtual_table_name` varchar(20) NOT NULL DEFAULT '' COMMENT '表名',
      `comments` varchar(50) NOT NULL DEFAULT '' COMMENT '注释',
      `sys_namespace_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联系统命名空间',
      `sys_dbsource_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联系统数据源',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `create_by` varchar(255) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_by` varchar(255) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_virtual_table` (`virtual_table_name`,`sys_dbsource_id`,`sys_namespace_id`) USING BTREE COMMENT '唯一约束'
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='虚表';
  END IF;
  IF NOT EXISTS (SELECT table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB_NAME' and table_name ='sys_virtual_table_column')
  then
      CREATE TABLE `sys_virtual_table_column` (
      `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `sys_virtual_table_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联虚表',
      `table_column_name` varchar(20) NOT NULL DEFAULT '' COMMENT '列名',
      `column_type` int(3) NOT NULL DEFAULT '0' COMMENT '类型',
      `length` int(5) NOT NULL DEFAULT '0' COMMENT '长度',
      `decimal_length` int(5) NOT NULL DEFAULT '0' COMMENT '小数',
      `is_not_null` int(1) NOT NULL DEFAULT '0' COMMENT '是否为空',
      `default_value` varchar(20) NOT NULL DEFAULT '' COMMENT '默认值',
      `comments` varchar(20) NOT NULL DEFAULT '' COMMENT '注释',
      `is_key` int(1) NOT NULL DEFAULT '0' COMMENT '是否主键',
      `is_auto` int(1) NOT NULL DEFAULT '0' COMMENT '是否自增',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
      `create_by` varchar(255) NOT NULL DEFAULT '' COMMENT '创建人',
      `update_by` varchar(255) NOT NULL DEFAULT '' COMMENT '更新人',
      PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='虚表字段';
  END IF;
 END $$

call initDB();
drop PROCEDURE initDB;