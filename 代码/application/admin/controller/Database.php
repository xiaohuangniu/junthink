<?php
/*
 +----------------------------------------------------------------------
 + Title        : 数据库管理
 + Author       : 小黄牛
 + Version      : V1.0.0.2
 + Initial-Time : 2017-09-28 15:28
 + Last-time    : 2017-09-28 15:28 + 小黄牛
 + Desc         : 添加操作日志记录
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;
use think\Config;
use org\Baksql;

class Database extends Admin{
    private $db;

    /**
     * 初始化数据库连接
     */
    public function __construct() {
        parent::__construct();
        $this->db = new Baksql(Config::get('database'));
    }

    /*
     * 备份数据表
     */
    public function backup() {
        $request = Request::instance();
        $type    = $request->param('type');

        # 单表备份
        if ($type == 1) {
            $tabName[] = $request->param('id');             // 获取表名
            $res = $this->db->backup($tabName,$tabName[0]); // 开始备份
            if (!$res) $this->addLog('单表备份数据库', $tabName[0] . "：备份失败", 2);
            $this->addLog('单表备份数据库', $tabName[0] . "：备份成功", 1);
        # 完全备份
        }else{
            $tables = $this->db->get_dbname();    // 全部表
            $res    = $this->db->backup($tables); // 开始备份
            if (!$res) $this->addLog('完全备份数据库', "备份失败", 2);
            $this->addLog('完全备份数据库', "备份成功", 1);
        }
    }

    /*
     * 下载备份文件
     */
    public function download() {
        $request = Request::instance();
        $type    = $request->param('type');

        # 单表下载
        if ($type == 1) {
            $table = $request->param('id');
            $this->db->backup($table , $table);  // 进行最新备份
            $tabName = $table.".sql";            // 获取表名
            $this->db->downloadFile($tabName);   // 下载文件
            $this->addLog('下载单表备份文件', $table, 1);
        # 完全下载
        }else{
            $table = $this->db->get_completely();// 获取最新的完全备份
            if (!$table) $this->addLog('下载完全备份文件', '获取失败，暂无最新备份文件', 3);
            $this->db->backup($table , $table);  // 进行最新备份
            $tabName = $table.".sql";            // 获取表名
            $this->db->downloadFile($tabName);   // 下载文件
            $this->addLog('下载完全备份文件', '下载成功', 1);
        }
    }

    /**
     * 备份还原
     */
    public function restore(){
        $request = Request::instance();
        $type    = $request->param('type');

        # 单表还原
        if ($type == 1) {
            $table = $request->param('id');
            $size  = $this->db->get_size($table);
            if ($size > 200) $this->addLog('备份还原', $table.'：暂不支持还原大于200KB的备份文件', 3);
            $this->db->_import($table);
            $this->addLog('备份还原', '还原成功', 1);
        }
    }
    
    /**
     * 列表
     */
    public function showlist(){
        # 获取所有表名
        $tables = $this->db->get_dbname();
        $data   = [];

        # 执行其余查询
        foreach ($tables as $k=>$v) {
            # 表名
            $data[$k]['table'] = $v;
            # 表结构
            $res = Db::query("SHOW CREATE TABLE `{$v}`");
            $res = explode("COMMENT='", $res[0]['Create Table']);
            # 表注释
            $data[$k]['remark'] = str_replace("'",'',$res[1]);
            # 表编码
            $res = explode('CHARSET=', $res[0]);
            $data[$k]['code'] = str_replace(' ','',$res[1]);
            # 总记录数
            $res = Db::query("SELECT COUNT(1) ROWS FROM `{$v}`");
            $data[$k]['count'] = $res[0]['ROWS'];
        }

        $this->assign('tables', $data);
        return $this->fetch();
    }

    /**
     * 查看数据表详情
     */
    public function details(){
        $table = Request::instance()->param('id');
        $data  = [];
        # 表名
        $data['table'] = $table;
        # 表结构
        $res = Db::query("SHOW CREATE TABLE `{$table}`");
        $res = explode("COMMENT='", $res[0]['Create Table']);
        # 表注释
        $data['remark'] = str_replace("'",'',$res[1]);
        # 表编码
        $res = explode('CHARSET=', $res[0]);
        $data['code'] = str_replace(' ','',$res[1]);
        # 总记录数
        $res = Db::query("SELECT COUNT(1) ROWS FROM `{$table}`");
        $data['count'] = $res[0]['ROWS'];
        $this->assign('data', $data);

        # 获得字段详情
        $res = Db::query("SHOW FULL COLUMNS FROM `{$table}`");
        $this->assign('list', $res);

        return $this->fetch();
    }

}
