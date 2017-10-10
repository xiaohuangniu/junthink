<?php
/*
 +----------------------------------------------------------------------
 + Title        : 插件管理类
 + Author       : 小黄牛
 + Version      : V1.0.0.4
 + Initial-Time : 2017-10-09 13:35
 + Last-time    : 2017-10-09 13:35 + 小黄牛
 + Desc         : 
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;
use hooks\Hooks;

class Plughook extends Admin{
    
    /**
     * 列表
     */
    public function showlist(){
        $hooks = new Hooks();
        $list  = $hooks->ont();
        $this->assign('list', $list);
        return $this->fetch();
    }

    /**
     * 删除
    */
    public function del(){
        # SB tp框架，debug就是报错，找不到原因，暂时关闭警告提示
        error_reporting(E_ALL^E_NOTICE^E_WARNING);
        $name  = Request::instance()->param('name');
        $hooks = new Hooks();
        $dir   = $hooks->root_dir . $name . '/';
        $res   = $hooks->delHook($dir);
        if ($res) $this->addLog('删除插件', '删除成功', 1);
        $this->addLog('删除插件', '删除失败', 2);
    }

    /**
     * 启用插件
     */
    public function enable(){
        $name  = Request::instance()->param('name');
        $hooks = new Hooks();
        $res   = $hooks->enableHook($name);
        if ($res) $this->addLog('启用插件', '启用成功', 1);
        $this->addLog('启用插件', '启用失败', 2);
    }

    /**
     * 禁用插件
     */
    public function disable(){
        $name  = Request::instance()->param('name');
        $hooks = new Hooks();
        $res   = $hooks->disableHook($name);
        if ($res) $this->addLog('禁用插件', '禁用成功', 1);
        $this->addLog('禁用插件', '禁用失败', 2);
    }

    /**
     * 安装
    */
    public function install(){
        $name  = Request::instance()->param('name');
        $hook  = Request::instance()->param('hooks');
        $hooks = new Hooks();
        $res   = $hooks->installHook($name, $hook);
        if ($res) $this->addLog('安装插件', '安装成功', 1);
        $this->addLog('安装插件', '安装失败', 2);
        
    }

    /**
     * 卸载
     */
    public function uninstall(){
        $name  = Request::instance()->param('name');
        $hook  = Request::instance()->param('hooks');
        $hooks = new Hooks();
        $res   = $hooks->uninstallHook($name, $hook);
        if ($res) $this->addLog('卸载插件', '卸载成功', 1);
        $this->addLog('卸载插件', '卸载失败', 2);
    }

    /**
     * 新增插件
     */
    public function add(){
         # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $data  = Request::instance()->param();
            $hooks = new Hooks();
            $res   = $hooks->addHook($data['name'], $data['hook'], $data['title'], $data['edition'], $data['content'], $data['author'], $data['install'], $data['peizhi']);
            if ($res['status']) {
                $this->addLog('创建新插件', $res['msg'], 1, false);
                echoJson('00', $res['msg']);
            } else {
                $this->addLog('创建新插件', $res['msg'], 3, false);
                echoJson('01', $res['msg']);
            }
        }else{
            return $this->fetch();
		}
    }

}
