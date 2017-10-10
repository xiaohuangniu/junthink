<?php
/*
 +----------------------------------------------------------------------
 + Title        : 后台 - 中间件
 + Author       : 小黄牛
 + Version      : V1.0.0.4
 + Initial-Time : 2017-09-21 14:39
 + Last-time    : 2017-10-09 16:37 + 小黄牛
 + Desc         : 新增插件监听
 +----------------------------------------------------------------------
*/

# 命名空间申明
namespace app\controller;
# 基类控制器加载
use think\Controller;
# 插件机制加载
use hooks\Hooks;

class Main extends Controller {
    protected $HOOK; // 插件机制的实例

	public function _initialize() {
		# 先自行父类的前置操作
		parent::_initialize();
		# 实例化插件机制
		$hooks = new Hooks();
		# 保持实例记录
		$this->HOOK = $hooks;
		# 监听所有可用的插件
		$hooks->hook();
	}
}