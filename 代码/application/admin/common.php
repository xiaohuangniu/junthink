<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

/**
 * 多维数组无限极分类-递归
 * @param  array  : $cate  递归数组
 * @param  string : $name  多维节点名称
 * @param  int    : $pid   初始递归父级
 * @return array  : 多维数组
*/
function unlimitedForLayer ($cate, $name = 'children', $pid = 0) {
    $arr = [];

    foreach ($cate as $v) {
        if ($v['pid'] == $pid) {
            $v[$name] = unlimitedForLayer($cate, $name, $v['id']);
            $arr[] = $v;
        }
    }
    return $arr;
}

/**
 * 多维数组无限极分类-递归
 * @param  array  : $cate  递归数组
 * @param  string : $name  多维节点名称
 * @param  int    : $pid   初始递归父级
 * @return array  : 多维数组
*/
function roleAdd ($cate, $name = 'children', $pid = 0) {
    $arr = [];

    foreach ($cate as $v) {
        if ($v['pid'] == $pid) {
            unset($v['pid']);
            $v['spread'] = true;
            $v[$name] = roleAdd($cate, $name, $v['checkboxValue']);
            $arr[] = $v;
        }
    }
    return $arr;
}

/**
 * 多维数组无限极分类-递归
 * @param  array  : $cate  递归数组
 * @param  string : $id    已有权限节点
 * @param  string : $name  多维节点名称
 * @param  int    : $pid   初始递归父级
 * @return array  : 多维数组
*/
function roleUpd ($cate, $id, $name = 'children', $pid = 0) {
    $arr = [];
    if (!is_array($id)) $id = explode(',', $id);

    foreach ($cate as $v) {
        if ($v['pid'] == $pid) {
            unset($v['pid']);
            if (in_array($v['checkboxValue'], $id)) $v['checked'] = true;
            $v['spread'] = true;
            $v[$name] = roleUpd($cate, $id,$name, $v['checkboxValue']);
            $arr[] = $v;
        }
    }
    return $arr;
}

/**
 * 多维数组无限极分类-递归-菜单列表
 * @param  array  : $cate  递归数组
 * @param  string : $name  多维节点名称
 * @param  int    : $pid   初始递归父级
 * @return array  : 多维数组
*/
function menuFor ($cate, $name = 'menu', $pid = 0) {
    $arr = [];

    foreach ($cate as $v) {
        if ($v['m_pid'] == $pid) {
            $v[$name] = menuFor($cate, $name, $v['m_id']);
            $arr[] = $v;
        }
    }
    return $arr;
}


/**
 * echo json
 * @param int    $code 编码
 * @param string $msg  描述
 * @param mixed  $data 返回接口
 * @return json
 */
function echoJson($code, $msg, $data=''){
    $array = [
        'code' => "{$code}", 
        'msg'  => $msg, 
        'data' => $data,
    ];
    echo json_encode($array);
    exit;
}

/**
 * 获取MYSQL版本信息
 */
function get_mysql_server(){
    $version = db()->query("select version() as ver");
    return $version[0]['ver'];
}

/*
 * 获得IP的真实地理信息 - TaoBao
 * @param string $ip  IP地址
 * @return array      返回成功查询后的数组
*/
function isTaobao($ip=''){
	if(empty($ip)){    
       return '请输入IP地址';  
    }   
	$url="http://ip.taobao.com/service/getIpInfo.php?ip=".$ip;
	$ip=json_decode(file_get_contents($url));
	if((string)$ip->code=='1'){
  		return false;
  	}
	$data = (array)$ip->data;
	return $data; 
}

