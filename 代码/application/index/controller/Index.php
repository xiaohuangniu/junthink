<?php
/*
 +----------------------------------------------------------------------
 + Title        : 
 + Author       : 小黄牛
 + Version      : V1.0.0.1
 + Initial-Time : 2017-09-21 14:41
 + Last-time    : 2017-09-26 17:34 + 小黄牛
 + Desc         : 
 +----------------------------------------------------------------------
*/

# 命名空间申明     
namespace app\index\controller;
# 父类控制器加载
use app\Controller\Main;

class Index extends Main{

    public function index(){
        # 使用$HOOK实例内的trigger方法，触发插件内部的方法
        $this->HOOK->trigger('demo3',['id'=>1, 'name'=>'小黄牛'], 'Yun');
        
        # trigger方法的入参如下：
        # 第一个：钩子名
        # 第二个：调用方法的传参，上例就是将一个数组参数传递给插件内部的Yun方法
        # 第三个：触发插件所对应的方法名，不带()号
    }
}

