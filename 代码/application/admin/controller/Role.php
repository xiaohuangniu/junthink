<?php
/*
 +----------------------------------------------------------------------
 + Title        : 角色管理
 + Author       : 小黄牛
 + Version      : V1.0.0.1
 + Initial-Time : 2017-09-25 11:12
 + Last-time    : 2017-09-25 11:12 + 小黄牛
 + Desc         : 
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Role extends Admin{
    protected $ROLE;
    protected $MENU;

    public function _initialize() {
		parent::_initialize();  
        $this->ROLE = Db::name('role');           // 角色表
        $this->MENU = Db::name('menu');           // 权限表
    }

    /**
     * 列表
     */
    public function showlist(){
        $list = $this->ROLE->paginate(20);
        $page = $list->render();
        $this->assign('list', $list);
        $this->assign('page', $page);
        return $this->fetch();
    }    

    /**
     * 新增
     */
    public function add(){
        # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $name   = Request::instance()->post('name');
            $pid    = json_decode(Request::instance()->post('id'), true);
            $status = Request::instance()->post('status');
            $remark = Request::instance()->post('remark');
            if (!$pid) echoJson('01', '请先选择对应的权限');
            $menu   = implode(',', $pid);

            $data = [
                'r_name'   => $name,
                'r_status' => $status,
                'r_remark' => $remark,
                'r_menu_list' => $menu,
            ];

            $res  = $this->ROLE->insert($data);
            if ($res > 0) echoJson('00', '新增成功');
            echoJson('01', '新增失败');
        }else{
            $list = $this->MENU->field('m_id as checkboxValue, m_name as name,  m_pid as pid')->where('m_type = 1 AND m_display = 1')->select();
            $this->assign('json', json_encode( roleAdd($list)) );
            return $this->fetch();
        }
    }

    /**
     * 修改
     */
    public function upd(){
        # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $name   = Request::instance()->post('name');
            $pid    = json_decode(Request::instance()->post('id'), true);
            $status = Request::instance()->post('status');
            $remark = Request::instance()->post('remark');
            if (!$pid) echoJson('01', '请先选择对应的权限');
            $menu   = implode(',', $pid);
            $upd_id = Request::instance()->post('upd_id');

            $data = [
                'r_name'   => $name,
                'r_status' => $status,
                'r_remark' => $remark,
                'r_menu_list' => $menu,
            ];

            $res  = $this->ROLE->where('r_id', $upd_id)->update($data);
            if ($res > 0) echoJson('00', '修改成功');
            echoJson('01', '修改失败');
        }else{
            $list = $this->MENU->field('m_id as checkboxValue, m_name as name,  m_pid as pid')->where('m_type = 1 AND m_display = 1')->select();
            $id   = Request::instance()->param('id');
            $info = Db::name('role')->where('r_id', $id)->find();
            $this->assign('json', json_encode( roleUpd($list, $info['r_menu_list'])) );
            $this->assign('info', $info);
            return $this->fetch();
        }
    }

    /**
     * 删除
    */
    public function del(){
        $id  = Request::instance()->param('id');
        # 先删除
        $res = Db::name('role')->where("r_id = '{$id}'")->delete();
        if ($res) $this->error('删除成功');
         $this->error('删除失败');
    }
    
}
