<?php
// +----------------------------------------------------------------------
// | JunThink - demo3插件 - demo3
// +----------------------------------------------------------------------
// | Copyright (c) 2017 www.junphp.com/think/
// +----------------------------------------------------------------------
// | Author: JunThink官方 - JunThink插件式内容管理系统 <1731223728@qq.com>
// +---------------------------------------------------------------------
class demo3 {
	// 插件配置参数,一维数组
	private $config;

	// 构造方法
	public function __construct(&$pluginManager) {
        // 注册这个插件
        // 第一个参数是钩子的名称
        // 第二个参数是pluginManager的引用
        // 第三个是插件所执行的方法
        $pluginManager->register("demo3", $this,"Yun");

		// 获得配置参数
		$url = "hook/demo3/Parameter.php";
		if(file_exists($url)){
			$this->config = include $url;
		}
    }

 	// 插件默认执行的方法
    public function Yun() {

    }
}