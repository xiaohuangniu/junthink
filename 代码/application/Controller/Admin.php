<?php
/*
 +----------------------------------------------------------------------
 + Title        : 后台 - 中间件
 + Author       : 小黄牛
 + Version      : V1.0.0.3
 + Initial-Time : 2017-09-21 14:39
 + Last-time    : 2017-10-09 10:32 + 小黄牛
 + Desc         : 新增地区权限验证方法、新增菜单访问类型过滤
 +----------------------------------------------------------------------
*/

# 命名空间申明
namespace app\controller;
# 基类控制器加载
use think\Controller;
use think\Db;
use think\Request;
use think\Session;

class Admin extends Controller {
	private $menu_vif; // 权限菜单

	/**
	 * 登录状态记录
	 */ 
    public function _initialize() {
		parent::_initialize();
		$admin = Session::get('admin');

		# 判断是否已经登录
		if (empty($admin)) $this->redirect('login/index');
		$this->assign('nice', $admin['m_nice']);

		# 设置公共权限
		$array = [
			['m_controller' => 'index','m_action'     => 'index'],
			['m_controller' => 'index','m_action'     => 'main'],
		];

		# 获取列表
        # 超级管理员
        if ($admin['j_id'] == 0) {
            $this->assign('admin_name', '超级管理员');
            # 获取列表
            $menu = $this->get_menu(0);
        }else{
            # 获取列表
            $menu = $this->get_menu($admin['j_id']);
        }

		# 将权限菜单传送到页面
		$this->assign('admin_menu', menuFor($menu));

		# 合并公共权限到菜单中-不过只作为验证
		$menu_vif = array_merge_recursive($menu,$array);
		$this->menu_vif = $menu_vif;

		# 验证访问权限
		$this->vif_menu($menu_vif);

		# 将控制器实例返回
		$this->assign('adminController', $this);
    }

	/**
	 * 获取对应的权限菜单
	 * @param int $j_id 岗位ID
	 * @return array 菜单
	 */
	 protected function get_menu($j_id){
		 # 超级管理员
		 if ($j_id == 0) {
			 $list = Db::name('menu')->where('m_display = 1')->order('m_path ASC')->field('m_id,m_pid,m_name,m_controller,m_action,m_icon,m_request')->select();
		 }else{
			 # 先搜出对应的角色
			 $role = Db::name('job')->where('j_id','=',$j_id)->field('r_id,j_name')->find();
			 $this->assign('admin_name', $role['j_name']);
			 # 使用角色ID搜索出现有的角色
			 $role = Db::name('role')->where('r_id','in',$role['r_id'])->field('r_status, r_menu_list')->select();
			 # 过滤已被禁用的角色
			 # 过滤重复的角色权限菜单ID
			 $menu = [];
			 foreach ($role as $v) {
			 	if ($v['r_status'] != 2) {
					 $k = explode(',', $v['r_menu_list']);
					 foreach ($k as $z) {
						 $menu[$z] = $z;
					 }
				}
			 }
			 $menu = implode(',', $menu);
			 # 使用菜单ID查询出对应的菜单
			 $list = Db::name('menu')->where("(m_display = 1 AND m_id in({$menu})) OR (m_display = 1 AND m_type = 2)")->order('m_path ASC')->field('m_id,m_pid,m_name,m_controller,m_action,m_icon,m_request')->select();
		 }
		 return $list;
	 }

	 /**
	  * 验证访问权限
	  * @param array $menu 权限菜单
	  * @return 无
	  */
	private function vif_menu($menu){
		# 获得控制器方法
		$Request    = Request::instance();
		$controller = strtolower( $Request->controller() );
		$action     = strtolower( $Request->action() );
		$status     = false;
		# 验证菜单权限
		foreach ($menu as $v) {
			if ($v['m_controller'] == $controller && $v['m_action'] == $action) {
				$status = true;
				# 验证请求类型
				if (!empty($v['m_request'])) {
					switch ($v['m_request']){
						case 'GET':
							if (!Request::instance()->isGet()) $mode = false;
						break;  
						case 'POST':
							if (!Request::instance()->isPost()) $mode = false;
						break;
						case 'Ajax':
							if (!Request::instance()->isAjax()) $mode = false;
						break;
					}
					if (!$mode) $this->error('非法请求');
				}
				break;
			}
		}
		if (!$status) $this->error('无该页面的访问权限！');
	}

	/**
	 * 单独验证菜单权限
	 * @param string $controller 控制器
	 * @param string $action     操作方法
	 * @return bool
	 */
	public function vif($controller, $action){
		$controller = strtolower( $controller );
		$action     = strtolower( $action );
		$status     = false;
		# 验证
		foreach ($this->menu_vif as $v) {
			if ($v['m_controller'] == $controller && $v['m_action'] == $action) {
				$status = true;
				break;
			}
		}
		return $status;
	}

	/**
	 * 记录操作日志
	 * @param string $type   操作类型
	 * @param string $title  详细描述
	 * @param int    $status 操作状态 1|2|3 成功|失败|异常
	 * @param bool   $model  是否需要重定向回上一页
	 * @return 无
	 */
	protected function addLog($type, $title, $status, $model=true){
		$admin   = Session::get('admin');
		$request = Request::instance();
		$data    = [
			'm_id'       => $admin['m_id'],
			'mal_type'   => $type,
			'mal_des'    => $title,
			'mal_status' => $status,
			'mal_time'   => time(),
			'mal_ip'     => $request->ip(),
			'mal_url'    => $request->url(),
			'mal_mode'   => $request->method(),
		];
		Db::name('manager_action_log')->insert($data);
		if ($model) $this->error($title);
	}

	/**
	 * 验证是否拥有地区访问权限
	 * @param int $id 地区ID
	 * @return bool
	 */
	protected function regionVif($id = ''){
		if (empty($id)) return true;
		$admin = Session::get('admin');
		# 拥有全国权限 
		if ($admin['m_nationwide'] == 1) return true;
		# 判断是否拥有权限
		$data = explode(',', $admin['m_province'].$admin['m_city'].$admin['m_area']);
		if (in_array($id, $data)) return true;
		return false;
	}

	/**
	 * 拉取地区访问权限
	 * @return bool|string
	 */
	protected function regionGet(){
		$admin = Session::get('admin');
		# 拥有全国权限 
		if ($admin['m_nationwide'] == 1) return true;
		return [
			'province' => ltrim($admin['m_province'], ','),
			'city'     => ltrim($admin['m_city'], ','),
			'area'     => ltrim($admin['m_area'], ','),
		];
	}
}
