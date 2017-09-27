<?php
/*
 +----------------------------------------------------------------------
 + Title        : 岗位管理
 + Author       : 小黄牛
 + Version      : V1.0.0.1
 + Initial-Time : 2017-09-25 17:51
 + Last-time    : 2017-09-26 09:28 + 小黄牛
 + Desc         : 
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Job extends Admin{

    /**
     * 列表
     */
    public function showlist(){
        # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$s_id  = Request::instance()->post('id'); // 组织ID
            $list = Db::name('job')
                    ->field('A.j_id, A.j_name, A.r_id, B.s_name')
                    ->alias('A')
                    ->join('__STRUCTURE__ B', 'A.s_id = B.s_id', 'INNER')
                    ->where('A.s_id','=',$s_id)
                    ->select();
            $DB   = Db::name('role');
            $data = [];
            foreach ($list as $k=>$v) {
                $data[$k]         = $v;
                $data[$k]['r_id'] = $DB->where('r_id','in', $v['r_id'])->field('r_name')->select();
            }   
            echo json_encode($data);
        }else{
			# 获取所有组织节点
            $list = Db::name('structure')->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            # 获取所有岗位
            $list = Db::name('job')
                    ->field('A.j_id, A.j_name, A.r_id, B.s_name')
                    ->alias('A')
                    ->join('__STRUCTURE__ B', 'A.s_id = B.s_id', 'INNER')
                    ->paginate(20);
            $DB   = Db::name('role');
            $data = [];
            foreach ($list as $k=>$v) {
                $data[$k]         = $v;
                $data[$k]['r_id'] = $DB->where('r_id','in', $v['r_id'])->field('r_name')->select();
            }   
            // 模板变量赋值
            $this->assign('list', $data);
            $this->assign('page', $list->render());
			return $this->fetch();
		}
    }

    /**
     * 新增
    */
    public function add(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$name   = Request::instance()->post('name');                  // 岗位名称
            $r_id   = json_decode(Request::instance()->post('id'), true); // 角色ID
            $pid    = Request::instance()->post('pid');                   // 组织ID
            if (!$r_id) echoJson('01', '请先选择所需关联的角色');
            $menu   = implode(',', $r_id);

            $data = [
                'j_name' => $name,
                'r_id'   => $menu,
                's_id'   => $pid,
            ];

            $res  = Db::name('job')->insert($data);
            if ($res > 0) echoJson('00', '新增成功');
            echoJson('01', '新增失败');
        }else{
			# 获取所有组织节点
            $list = Db::name('structure')->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            # 获取所有角色
            $role = Db::name('role')->field('r_id, r_name')->select();
            $this->assign('role', $role);
			return $this->fetch();
		}
    }

    /**
     * 修改
    */
    public function upd(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
            $upd_id = Request::instance()->post('upd_id');                // 岗位ID
			$name   = Request::instance()->post('name');                  // 岗位名称
            $r_id   = json_decode(Request::instance()->post('id'), true); // 角色ID
            $pid    = Request::instance()->post('pid');                   // 组织ID
            if (!$r_id) echoJson('01', '请先选择所需关联的角色');
            $menu   = implode(',', $r_id);

            $data = [
                'j_name' => $name,
                'r_id'   => $menu,
                's_id'   => $pid,
            ];

            $res  = Db::name('job')->where('j_id','=',$upd_id)->update($data);
            if ($res > 0) echoJson('00', '修改成功');
            echoJson('01', '修改失败');
        }else{
			# 获取所有组织节点
            $list = Db::name('structure')->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            # 获取所有角色
            $role = Db::name('role')->field('r_id, r_name')->select();
            $this->assign('role', $role);
            $id   = Request::instance()->param('id');
            # 查询当前资料
            $info = Db::name('job')
                    ->field('A.*, B.s_name')
                    ->alias('A')
                    ->join('__STRUCTURE__ B', 'A.s_id = B.s_id', 'INNER')
                    ->where('j_id','=',$id)
                    ->find();
            $this->assign('info', $info);
            $this->assign('array', explode(',', $info['r_id']));
			return $this->fetch();
		}
    }

    /**
     * 删除
    */
    public function del(){
        $id   = Request::instance()->param('id');
        $s_id = Db::name('job')->where('j_id','=',$id)->find();

        if (!$s_id) $this->error('该岗位不存在');
        $res  = Db::name('manager')->where('j_id','=',$id)->find();
        if ($res)   $this->error('该岗位已被对应的管理员所关联，请先删除这些管理员账号');

        # 此处再判断一下是否有对应的组织
        $res = Db::name('job')->where('j_id','=',$id)->delete();
        if ($res) $this->error('删除成功');
        $this->error('删除失败');
    }

}
