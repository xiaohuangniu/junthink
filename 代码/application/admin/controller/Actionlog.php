<?php
/*
 +----------------------------------------------------------------------
 + Title        : 操作日志
 + Author       : 小黄牛
 + Version      : V1.0.0.3
 + Initial-Time : 2017-09-28 14:19
 + Last-time    : 2017-10-09 10:21 + 小黄牛
 + Desc         : 修复操作日志在详情页内点击清空后，返回上一页报错
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Actionlog extends Admin{
    
    /**
     * 列表
     */
    public function showlist(){
       $list = Db::name('manager_action_log')
               ->field('A.*, B.m_nice')
               ->alias('A')
               ->join('__MANAGER__ B',' A.m_id = B.m_id')
               ->order('A. mal_time DESC')
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

        $res = Db::name('manager_action_log')->where("mal_id in($id)")->delete();
        if ($res) $this->addLog('删除操作日志', '删除成功', 1);
        $this->error('删除操作日志', '删除失败', 2);
    }

    /**
     * 清空所有操作日志
     */
    public function emptyall(){
        $res = Db::name('manager_action_log')->where("mal_id > 0")->delete();
        if ($res) $this->addLog('清空操作日志', '清空成功', 1);
        $this->error('清空操作日志', '清空失败', 2);
    }

    /**
     * 查询详情
     */
    public function details(){
        $id= Request::instance()->param('id');
        $info = Db::name('manager_action_log')
               ->field('A.*, B.m_nice, B.j_id')
               ->alias('A')
               ->join('__MANAGER__ B',' A.m_id = B.m_id')
               ->where('A.mal_id', '=', $id)
               ->find();

        if (!$info) $this->redirect('actionlog/showlist');
        
        if ($info['j_id'] == 0) {
            $info['j_id'] = '超级管理员';
            $info['s_id'] = '总部';
            $info['r_id'] = '无';
        } else {
           $job = Db::name('job')->field('j_name, s_id, r_id')->where('j_id', '=', $info['j_id'])->find();
           $info['j_id'] = $job['j_name'];
           $structure = Db::name('structure')->where('s_id', '=', $job['s_id'])->value('s_name');
           $info['s_id'] = $structure;
           $role = Db::name('role')->field('r_name')->where('r_id in('.$job['r_id'].')')->select();
           $txt  = '';
           foreach ($role as $v) {
               $txt .= '<font style="color: #2F4056">'.$v['r_name'].'</font><br/>';
           }
           $info['r_id'] = $txt;
        }

        $this->assign('info', $info);

        # 获取IP所属地区
        $res    = isTaobao($info['mal_ip']);
        $region = $res['region'] ?: '无';
        $city   = $res['city']   ?: '无';
        $area   = $res['county'] ?: '无';
        $isp    = $res['isp'];

        $this->assign('region', $region .' - '. $city .' - '. $area);
        $this->assign('isp', $isp);
        return $this->fetch();
    }

}
