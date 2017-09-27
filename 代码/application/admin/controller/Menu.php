<?php
/*
 +----------------------------------------------------------------------
 + Title        : 菜单管理
 + Author       : 小黄牛
 + Version      : V1.0.0.1
 + Initial-Time : 2017-09-25 09:06
 + Last-time    : 2017-09-25 09:06 + 小黄牛
 + Desc         : 
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Menu extends Admin{
    protected $DB;

    public function _initialize() {
		parent::_initialize();  
        $this->DB = Db::name('menu');
    }

    /**
     * 列表
     * AJAX时返回对应的信息
     * @param int|string : $id ajax下传递的POST[id]
    */
    public function showlist(){
        # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $pid  = Request::instance()->post('id');
			$list = $this->DB->where("m_pid = '{$pid}' OR m_id = '{$pid}'")->select();
            echo json_encode($list);
        } else {
            # 获取一级菜单
            $list = $this->DB->where('m_pid = 0')->select();
            $this->assign('list', $list);
            # 获取所有地区节点
            $list = $this->DB->field('m_id as id, m_name as name,  m_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            return $this->fetch();
        }
    }

    /**
     * 删除
    */
    public function del(){
        $id   = Request::instance()->param('id');
        $info = $this->DB->where("m_id = '{$id}'")->find();

        if (!$info) $this->error('需要删除的菜单不存在');
            
        $info = $this->DB->where("m_pid = '{$id}'")->find();
        if ($info) $this->error('该菜单下还存在节点，请先删除所有子节点');

        $res = $this->DB->where("m_id = '{$id}'")->delete();
        if ($res) $this->error('删除成功');
        
        $this->error('删除失败');
    }

    
    /**
     * 新增
    */
    public function add(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $name = Request::instance()->post('name');
            $pid  = Request::instance()->post('pid');
            $controller  = Request::instance()->post('controller');
            $action      = Request::instance()->post('action');
            $type        = Request::instance()->post('type');
            $status      = Request::instance()->post('status');
            $request     = Request::instance()->post('request');
            $remark      = Request::instance()->post('remark');
            $icon        = Request::instance()->post('icon');
            $data = [
                'm_pid'       => $pid,
                'm_name'      => $name,
                'm_controller'=> $controller,
                'm_action'    => $action,
                'm_type'      => $type,
                'm_display'   => $status,
                'm_icon'      => $icon,
                'm_remark'    => $remark,
                'm_request'   => $request,
            ];
            $id  = $this->DB->insertGetId($data);
            # 顶级栏目
            if ($pid == 0) {
                $upd_data = ['m_path' => $id];
            # 次级栏目
            }else{
                $m_path = $this->DB->where('m_id', $pid)->value('m_path');
                $upd_data = ['m_path' => $m_path.'/'.$id];
            }
            $res =  $this->DB->where('m_id', $id)->update($upd_data);
            if ($res > 0) echoJson('00', '新增成功');
            echoJson('01', '新增失败');
        }else{
            $pid  = Request::instance()->param('pid');
            $this->assign('pid', $pid);
			if ($pid == 0) {
                $this->assign('name', '顶级菜单');
            }else{
                $name = $this->DB->where('m_id', $pid)->value('m_name');
                $this->assign('name', $name);
            }
			return $this->fetch();
		}
    }

    /**
     * 修改
    */
    public function upd(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $id   = Request::instance()->post('id');
            $name = Request::instance()->post('name');
            $controller  = Request::instance()->post('controller');
            $action      = Request::instance()->post('action');
            $type        = Request::instance()->post('type');
            $status      = Request::instance()->post('status');
            $request     = Request::instance()->post('request');
            $remark      = Request::instance()->post('remark');
            $icon        = Request::instance()->post('icon');
            $upd_data    = [
                'm_name'      => $name,
                'm_controller'=> $controller,
                'm_action'    => $action,
                'm_type'      => $type,
                'm_display'   => $status,
                'm_icon'      => $icon,
                'm_remark'    => $remark,
                'm_request'   => $request,
            ];
            
            $res =  $this->DB->where('m_id', $id)->update($upd_data);
            if ($res > 0) echoJson('00', '修改成功');
            echoJson('01', '修改失败');
        }else{
            $id   = Request::instance()->param('id');
            $res  = $this->DB->where('m_id', $id)->find();
            $name = $this->DB->where('m_id', $res['m_pid'])->value('m_name');
            $name = $name?:'顶级菜单';
            $this->assign('id', $id);
            $this->assign('name', $name);
            $this->assign('info', $res);
			return $this->fetch();
		}
    }
}
