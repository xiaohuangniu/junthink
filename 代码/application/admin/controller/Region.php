<?php
/*
 +----------------------------------------------------------------------
 + Title        : 地区管理
 + Author       : 小黄牛
 + Version      : V1.0.0.1
 + Initial-Time : 2017-09-21 16:29
 + Last-time    : 2017-09-22 16:03 + 小黄牛
 + Desc         : 已完善，地区可自行做缓存处理
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Region extends Admin{
    protected $DB;

    public function _initialize() {
		parent::_initialize();  
        $this->DB = Db::name('region');
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
			$list = $this->DB->where("r_pid = '{$pid}' OR r_id = '{$pid}'")->select();
            echo json_encode($list);
        } else {
            # 获取一级省
            $list = $this->DB->where('r_pid = 1')->select();
            $this->assign('list', $list);
            # 获取所有地区节点
            $list = $this->DB->field('r_id as id, r_name as name,  r_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            return $this->fetch();
        }
    }

    /**
     * 删除
    */
    public function del(){
        $id   = Request::instance()->param('id');
        $info = $this->DB->where("r_id = '{$id}'")->find();

        if (!$info) $this->error('需要删除的地区不存在');
            
        $info = $this->DB->where("r_pid = '{$id}'")->find();
        if ($info) $this->error('该地区下还存在节点，请先删除所有子节点');

        $res = $this->DB->where("r_id = '{$id}'")->delete();
        if ($res) $this->error('删除成功');
        
        $this->error('删除失败');
    }

    /**
     * 修改
    */
    public function upd(){
		# 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$id     = Request::instance()->post('region_id');
			$pid    = Request::instance()->post('pid');
			$sort   = Request::instance()->post('sort');
			$name   = Request::instance()->post('name');
			$code   = Request::instance()->post('code');
			$pinyin = Request::instance()->post('pinyin');

            # 简单过滤数据
            if (empty($pid))  echoJson('01', '请选择对应的上级地区');
            if (empty($name)) echoJson('01', '地区名称不能为空');
            if (empty($code)) echoJson('01', '地区编码不能为空或0');
           
            # 查询出原数据
			$path  = $this->DB->where('r_id', $id)->value('r_id');
			if ($path==false && $path != 0) echoJson('01', '原数据不存在');
			$data = [
                'r_pid'    => $pid,
                'r_name'   => $name,
                'r_pinyin' => $pinyin,
                'r_code'   => $code,
                'r_sort'   => $sort,		
            ];
            $res = $this->DB->where('r_id', $id)->update($data);	
			if ($res > 0) echoJson('00', '修改成功');
            echoJson('01', '修改失败');
        }else{
			# 获取所有地区节点
            $list = $this->DB->field('r_id as id, r_name as name,  r_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
			
			$id   = Request::instance()->param('id');
			
			$info = $this->DB->where('r_id', $id)->find();
			$this->assign('info', $info);
			$region_name = $this->DB->where('r_id', $info['r_pid'])->value('r_name');
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
			$sort   = Request::instance()->post('sort');
			$name   = Request::instance()->post('name');
			$code   = Request::instance()->post('code');
			$pinyin = Request::instance()->post('pinyin');

            # 简单过滤数据
            if (empty($pid))  echoJson('01', '请选择对应的上级地区');
            if (empty($name)) echoJson('01', '地区名称不能为空');
            if (empty($code)) echoJson('01', '地区编码不能为空或0');
           
			$data = [
                'r_pid'    => $pid,
                'r_name'   => $name,
                'r_pinyin' => $pinyin,
                'r_code'   => $code,
                'r_sort'   => $sort,		
            ];
            $res = $this->DB->insert($data);	
			if ($res > 0) echoJson('00', '新增成功');
            echoJson('01', '新增失败');
        }else{
			# 获取所有地区节点
            $list = $this->DB->field('r_id as id, r_name as name,  r_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
			return $this->fetch();
		}
    }
}
