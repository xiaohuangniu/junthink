<?php
/*
 +----------------------------------------------------------------------
 + Title        : 组织管理
 + Author       : 小黄牛
 + Version      : V1.0.0.2
 + Initial-Time : 2017-09-22 16:03
 + Last-time    : 2017-09-28 13:29 + 小黄牛
 + Desc         : 增加日志记录
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Structure extends Admin{
    protected $DB;

    public function _initialize() {
		parent::_initialize();  
        $this->DB = Db::name('structure');
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
			$list = $this->DB->where("s_pid = '{$pid}' OR s_id = '{$pid}'")->select();
            echo json_encode($list);
        } else {
            # 获取一级
            $list = $this->DB->where('s_pid = 1')->select();
            $this->assign('list', $list);
            # 获取所有节点
            $list = $this->DB->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            return $this->fetch();
        }
    }

    /**
     * 删除
    */
    public function del(){
        $id   = Request::instance()->param('id');
        $info = $this->DB->where("s_pid = '{$id}'")->find();

        if ($info) $this->addLog('删除组织架构', '请先删除其下面的子类架构', 3);

        if (Db::name('job')->where('s_id','=',$id)->find()) $this->addLog('删除组织架构', '该组织已被对应的岗位所关联，请先删除这些岗位', 3);

        # 此处再判断一下是否有对应的组织
        $res = $this->DB->where("s_id = '{$id}'")->delete();
        if ($res) $this->addLog('删除组织架构', '删除成功', 1);
        $this->addLog('删除组织架构', '删除失败', 2);
    }

    /**
     * 修改
    */
    public function upd(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$id     = Request::instance()->post('s_id');
			$pid    = Request::instance()->post('pid');
			$name   = Request::instance()->post('name');

            # 简单过滤数据
            if (empty($pid))  {
                $this->addLog('修改组织架构', '请选择对应的上级组织', 3, false);
                echoJson('01', '请选择对应的上级组织');
            }
            if (empty($name)) {
                $this->addLog('修改组织架构', '组织名称不能为空', 3, false);
                echoJson('01', '组织名称不能为空');
            }
           
            # 查询出原数据
			$path  = $this->DB->where('s_id', $id)->value('s_id');
            if ($path==false && $path != 0) {
                $this->addLog('修改组织架构', '原数据不存在', 3, false);
                echoJson('01', '原数据不存在');
            }

			$data = [
                's_pid'    => $pid,
                's_name'   => $name,		
            ];
            $res = $this->DB->where('s_id', $id)->update($data);	
            if ($res > 0) {
                $this->addLog('修改组织架构', '修改成功', 1, false);
                echoJson('00', '修改成功');
            }
            $this->addLog('修改组织架构', '修改失败', 2, false);
            echoJson('01', '修改失败');
        }else{
			# 获取所有节点
            $list = $this->DB->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
			
			$id   = Request::instance()->param('id');
			
			$info = $this->DB->where('s_id', $id)->find();
			$this->assign('info', $info);
			$region_name = $this->DB->where('s_id', $info['s_pid'])->value('s_name');
			$this->assign('region_name', $region_name);
			return $this->fetch();
		}
    }

     /**
     * 新增
    */
    public function add(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$pid    = Request::instance()->post('pid');
			$name   = Request::instance()->post('name');

            # 简单过滤数据
            if (empty($pid))  {
                $this->addLog('新增组织架构', '请选择对应的上级组织', 3, false);
                echoJson('01', '请选择对应的上级组织');
            }
            if (empty($name)) {
                $this->addLog('新增组织架构', '组织名称不能为空', 3, false);
                echoJson('01', '组织名称不能为空');
            }
           
			$data = [
                's_pid'    => $pid,
                's_name'   => $name,	
                'add_time' => time(),	
            ];
            $res = $this->DB->insert($data);	
            if ($res > 0) {
                $this->addLog('新增组织架构', '新增成功', 1, false);
                echoJson('00', '新增成功');
            }
            $this->addLog('新增组织架构', '新增失败', 2, false);
            echoJson('01', '新增失败');
        }else{
			# 获取所有节点
            $list = $this->DB->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
			return $this->fetch();
		}
    }

}
