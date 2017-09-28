<?php
/*
 +----------------------------------------------------------------------
 + Title        : 登录
 + Author       : 小黄牛
 + Version      : V1.0.0.2
 + Initial-Time : 2017-09-26 17:01
 + Last-time    : 2017-09-28 11:02 + 小黄牛
 + Desc         : 新增登录日志记录
 +----------------------------------------------------------------------
*/

# 命名空间申明
namespace app\admin\controller;
# 基类控制器加载
use think\Controller;
use think\Db;
use think\Request;
use think\Session;

class Login extends Controller {
	/**
	 * 页面
	 */
	public function index(){
		# 判断是否已经登录
		if (!empty(Session::get('admin'))) $this->redirect('index/index');
		return $this->fetch();
	}

	/**
	 * 处理登录
	 */
	public function vif(){
        if (Request::instance()->isAjax()) {
			$name = Request::instance()->post('name');
			$pwd  = Request::instance()->post('pwd');
			$vif  = Request::instance()->post('vif');

			# 验证码核验
		    if (!captcha_check($vif)) echoJson('01', '验证码错误', 'vif-no');
			if (empty($name) || empty($pwd)) echoJson('01', '用户名或密码错误', 'vif-name');
			
			$res = Db::name('manager')->where('m_name','=',$name)->find();
			
			if (!$res) echoJson('01', '用户名或密码错误', 'vif-name');
			if (md5($pwd . $res['m_time']) != $res['m_pwd']) echoJson('01', '用户名或密码错误', 'vif-name');

			Session::set('admin', $res);
			# 写入日志
			$this->add_login_log($res['m_id']);
			echoJson('00', '登录成功');
        }

		echoJson('02', '非法请求');
	}

	/**
	 * 退出登录
	 */
	public function out(){
		Session::delete('admin');
		$this->redirect('login/index');
	}

	/**
	 * 添加日志记录
	 * @param int $id 管理员ID
	 */
	private function add_login_log($id){
		$request = Request::instance();
		$data    = [
			'm_id'   => $id,
			'l_ip'   => $request->ip(),
			'l_time' => time(),
		];
		Db::name('manager_login_log')->insert($data);
	}
}
