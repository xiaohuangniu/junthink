<?php
/*
 +----------------------------------------------------------------------
 + Title        : 后台公共方法
 + Author       : 小黄牛
 + Version      : V1.0.0.3
 + Initial-Time : 2017-10-08 18:42
 + Last-time    : 2017-10-08 18:42 + 小黄牛
 + Desc         : 无
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
# 基类控制器加载
use think\Controller;
use think\Db;
use think\Request;

class Common extends Controller {
    private $region; // 地区表

    /**
     * 初始化所有Model和配置参数
    */
    public function _initialize() {
		parent::_initialize();
    	$this->region = Db::name('region');
    }

    /**
     * 获取对应的地区列表
     * @param int|string : $id ajax下传递的POST[id]
    */
    public function city(){
        $pid  = Request::instance()->post('id');
        $list = $this->region->field('r_id as id, r_name as region_name')->where('r_pid', $pid)->select();
        echo json_encode($list);
    }

}
