<?php
/*
 +----------------------------------------------------------------------
 + Title        : 登录日志
 + Author       : 小黄牛
 + Version      : V1.0.0.2
 + Initial-Time : 2017-09-28 11:07
 + Last-time    : 2017-09-28 14:13 + 小黄牛
 + Desc         : 添加操作日志记录
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Loginlog extends Admin{
    
    /**
     * 列表
     */
    public function showlist(){
       $list = Db::name('manager_login_log')
               ->field('A.*, B.m_nice')
               ->alias('A')
               ->join('__MANAGER__ B',' A.m_id = B.m_id')
               ->order('A.l_time DESC')
               ->paginate(10);
        $this->assign('list', $list);
        $this->assign('page', $list->render());
        return $this->fetch();
    }

    /**
     * 删除
    */
    public function del(){
        $data= Request::instance()->param();
        $id  = $data['id'];
        # 检测是否批量删除
        if (is_array($id)) {
            $id = implode(',', $id);
        }

        $res = Db::name('manager_login_log')->where("l_id in($id)")->delete();
        if ($res) $this->addLog('删除管理员登录日志', '删除成功', 1);
        $this->error('删除管理员登录日志', '删除失败', 2);
    }

}
