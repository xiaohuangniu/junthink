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

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Index extends Admin{
    // 框架页
    public function index(){
        return $this->fetch();
    }

    // 主体
    public function main(){
        return $this->fetch();
    }

    


}
