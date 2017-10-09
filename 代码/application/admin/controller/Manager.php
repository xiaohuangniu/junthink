<?php
/*
 +----------------------------------------------------------------------
 + Title        : 管理员
 + Author       : 小黄牛
 + Version      : V1.0.0.3
 + Initial-Time : 2017-09-26 10:17
 + Last-time    : 2017-10-08 18:55 + 小黄牛
 + Desc         : 新增管理员地区权限关联，新增管理员预览功能
 +----------------------------------------------------------------------
*/

namespace app\admin\controller;
use app\Controller\Admin;
use think\Db;
use think\Request;

class Manager extends Admin{
    
    /**
     * 列表
     */
    public function showlist(){
        # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$s_id   = Request::instance()->post('id'); // 组织ID
            $s_name = Db::name('structure')->where('s_id', '=', $s_id)->value('s_name');
            $job    = Db::name('job')->where('s_id','=',$s_id)->field('j_id, j_name')->find();
            $list   = Db::name('manager')->where("j_id = 0 OR j_id = '".$job['j_id']."'")->order('j_id ASC')->select();
            foreach ($list as $k=>$v) {
                $list[$k]['m_time'] = date('Y-m-d H:i:s', $v['m_time']);
                
                if ($v['j_id'] == 0) {
                    $list[$k]['j_id'] = '超级管理员';
                    $list[$k]['s_id'] = '总部';
                } else {
                    $list[$k]['j_id'] = $job['j_name'];
                    $list[$k]['s_id'] = $s_name;
                }
                if ($v['m_status'] == 1) {
                    $list[$k]['m_status'] = '开启';
                } else {
                    $list[$k]['m_status'] = '禁用';
                }
                
            }
            echo json_encode($list);
        }else{
            # 获取所有组织节点
            $list = Db::name('structure')->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
			$list = Db::name('manager')->order('j_id ASC')->paginate(20);
            $DB   = Db::name('job');
            $data = [];
            foreach ($list as $k=>$v) {
                $data[$k] = $v;
                if ($v['j_id'] == 0) {
                    $data[$k]['j_id'] = '超级管理员';
                    $data[$k]['s_id'] = '总部';
                } else {
                    $info = $DB->where('j_id','=',$v['j_id'])->field('s_id, j_name')->find();
                    $data[$k]['j_id'] = $info['j_name'];
                    $data[$k]['s_id'] = Db::name('structure')->where('s_id','=',$info['s_id'])->value('s_name');
                }
            }

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
			$type  = Request::instance()->post('type'); // 请求类型
            # 查询对应岗位
            if($type == 1) {
                $s_id = Request::instance()->post('id');
                $list = Db::name('job')->where('s_id','=', $s_id)->field('j_id as id, j_name as name')->select();
                if ($list) {echo json_encode( $list );} else { echo 0;}
            # 新增管理员
            }else{
                $nice   = Request::instance()->post('nice');
                $name   = Request::instance()->post('name');
                $pwd    = Request::instance()->post('pwd');
                $time   = time();
                $pwd    = md5($pwd . $time);
                $phone  = Request::instance()->post('phone');
                $status = Request::instance()->post('status');
                $j_id   = Request::instance()->post('pid');
				$nationwide   = Request::instance()->post('nationwide');
				$province_ids = Request::instance()->post('province_ids');
				$city_ids     = Request::instance()->post('city_ids');
				$area_ids     = Request::instance()->post('area_ids');
                
                $DB     = Db::name('manager');
                if ($DB->where('m_name','=',$name)->value('m_id')) {
                    $this->addLog('新增管理员', '用户已存在', 3, false);
                    echoJson('01', '用户已存在');
                }

                if ($j_id == 0) {
                    $count  = $DB->where('j_id = 0')->count();
                    if ($count >= 3) {
                        $this->addLog('新增管理员', '最多只能同时存在 3 个超级管理员', 3, false);
                        echoJson('01', '最多只能同时存在 3 个超级管理员');
                    }
                } 

                $data   = [
                    'm_nice' => $nice,
                    'm_name' => $name,
                    'm_pwd'  => $pwd,
                    'm_phone'=> $phone,
                    'm_time' => $time,
                    'm_status' => $status,
                    'j_id'     => $j_id,
					'm_nationwide' => $nationwide ?: 0,
                ];
				
				// 不是全国地区管理权限
				if ($nationwide != 1) {
					$data['m_province'] = $province_ids;
					$data['m_city'] = $city_ids;
					$data['m_area'] = $area_ids;
				}
				
                $res    = $DB->insert($data);
                if ($res) {
                    $this->addLog('新增管理员', '新增成功', 1, false);
                    echoJson('00', '新增成功');
                }
                $this->addLog('新增管理员', '新增失败', 2, false);
                echoJson('01', '新增失败');
            }
        }else{
			# 获取所有组织节点
            $list = Db::name('structure')->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );

			return $this->fetch();
		}
    }

    /**
     * 修改
     */
    public function upd(){
        # 判断是否AJAX请求
        if (Request::instance()->isAjax()) {
			$type  = Request::instance()->post('type'); // 请求类型
            # 查询对应岗位
            if($type == 1) {
                $s_id = Request::instance()->post('id');
                $list = Db::name('job')->where('s_id','=', $s_id)->field('j_id as id, j_name as name')->select();
                if ($list) {echo json_encode( $list );} else { echo 0;}
            # 新增管理员
            }else{
                $id     = Request::instance()->post('id');
                $upd_name = Request::instance()->post('upd_name');
                $upd_jid  = Request::instance()->post('upd_jid');
                $nice   = Request::instance()->post('nice');
                $name   = Request::instance()->post('name');
                $pwd    = Request::instance()->post('pwd');
                $phone  = Request::instance()->post('phone');
                $status = Request::instance()->post('status');
                $j_id   = Request::instance()->post('pid');
				$nationwide   = Request::instance()->post('nationwide');
				$province_ids = Request::instance()->post('province_ids');
				$city_ids     = Request::instance()->post('city_ids');
				$area_ids     = Request::instance()->post('area_ids');
                
                $DB     = Db::name('manager');
                if ($name != $upd_name) {
                    if ($DB->where('m_name','=',$name)->value('m_id')) {
                        $this->addLog('修改管理员', '用户已存在', 3, false);
                        echoJson('01', '用户已存在');
                    }
                }

                if ($upd_jid != 0 && $j_id == 0) {
                    $count  = $DB->where('j_id = 0')->count();
                    if ($count >= 3) {
                        $this->addLog('修改管理员', '最多只能同时存在 3 个超级管理员', 3, false);
                        echoJson('01', '最多只能同时存在 3 个超级管理员');
                    }
                }

                $time   = $DB->where('m_id','=',$id)->value('m_time');
                $pwd    = md5($pwd . $time);
                
                $data   = [
                    'm_nice' => $nice,
                    'm_name' => $name,
                    'm_pwd'  => $pwd,
                    'm_phone'=> $phone,
                    'm_time' => $time,
                    'm_status' => $status,
                    'j_id'   => $j_id,
					'm_nationwide' => $nationwide ?: 0,
                ];
				
				// 不是全国地区管理权限
				if ($nationwide != 1) {
					$data['m_province'] = $province_ids;
					$data['m_city'] = $city_ids;
					$data['m_area'] = $area_ids;
				}
				
                $res    = $DB->where('m_id','=',$id)->update($data);
                if ($res) {
                    $this->addLog('修改管理员', '修改成功', 1, false);
                    echoJson('00', '修改成功');
                }
                $this->addLog('修改管理员', '修改失败', 2, false);
                echoJson('01', '修改失败');
            }
        }else{
			# 获取所有组织节点
            $list = Db::name('structure')->field('s_id as id, s_name as name,  s_pid as pid')->select();
            $this->assign('json', json_encode( unlimitedForLayer($list)) );
            $id   = Request::instance()->param('id');
            $info = Db::name('manager')->where('m_id','=',$id)->find();
            if ($info['j_id'] == 0) {
                $info['j_name'] = '超级管理员';
                $info['s_name'] = '总部';
            }else{
                 $res = Db::name('job')->where('j_id','=',$info['j_id'])->field('s_id, j_name')->find();
                 $info['j_name'] = $res['j_name'];
                 $info['s_name'] = Db::name('structure')->where('s_id','=',$res['s_id'])->value('s_name');
            }
			
			$DB           = Db::name('region');
			$province_ids = $DB->field('r_id, r_name')->where('r_id', 'in', $info['m_province'])->select();
            $city_ids     = $DB->field('r_id, r_name')->where('r_id', 'in', $info['m_city'])->select();
            $area_ids     = $DB->field('r_id, r_name')->where('r_id', 'in', $info['m_area'])->select();
			
            $this->assign('info',$info);
			$this->assign('province_ids', $province_ids);
            $this->assign('city_ids', $city_ids);
            $this->assign('area_ids', $area_ids);
			return $this->fetch();
		}
    }
	
	/**
     * 查询详情
     */
    public function details(){
        $id= Request::instance()->param('id');
        $info = Db::name('manager')
               ->where('m_id', '=', $id)
               ->find();

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
		
		$DB           = Db::name('region');
		$province_ids = $DB->field('r_id, r_name')->where('r_id', 'in', $info['m_province'])->select();
		$city_ids     = $DB->field('r_id, r_name')->where('r_id', 'in', $info['m_city'])->select();
		$area_ids     = $DB->field('r_id, r_name')->where('r_id', 'in', $info['m_area'])->select();
		
		$this->assign('province_ids', $province_ids);
		$this->assign('city_ids', $city_ids);
		$this->assign('area_ids', $area_ids);
		
        return $this->fetch();
    }

    /**
     * 删除
    */
    public function del(){
        $id  = Request::instance()->param('id');
        $res = Db::name('manager')->where("m_id = '{$id}'")->delete();
        if ($res) $this->addLog('删除管理员', '删除成功', 1);
         $this->addLog('删除管理员', '删除失败', 2);
    }

}