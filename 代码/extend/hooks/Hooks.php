<?php
/*
 +----------------------------------------------------------------------
 + Title        : 插件机制的核心类 
 + Author       : 小黄牛
 + Version      : V1.0.0.1
 + Initial-Time : 2017-10-09 14:38
 + Last-time    : 2017-10-09 14:38 + 小黄牛
 + Desc         : 
 +----------------------------------------------------------------------
*/

namespace hooks;

class Hooks {
	public  $root_dir = 'hook/';  // 插件根目录
	public  $config   = 'config'; // 有关插件的信息的文件名
	public  $_array   = array();  // 所有插件目录
	public  $con_list = array();  // 所有插件的配置信息
	private $pattern  = '/[\'"]type[\'"]\s*=>\s*[\'"]([\s\S]*?)[\'"],/'; 

	private $_listeners = array(); // 监听已注册的插件 

	/** 
	 * 构造函数 
	*/
	public function __construct() {
		// 监听插件目录
		$this->path($this->root_dir);

		$plugins = [];
		// 解析插件参数
		foreach ($this->_array as $key=>$value) {
			$arr = explode('/',$value);
			$plugins[$key]['path'] = $arr[0];                   // 插件的目录名
			$plugins[$key]['name']      = trim($arr[1],'.class.php');// 插件的名称
		} 
		$this->_array = $plugins;
    }

	/**
	 * 获得插件的名称和安装目录
	 * @access public 
	 * @dir_name 插件根目录
     * @var array 
	*/
	public function path($dir_name){
		$dir_handle = opendir($dir_name);
		if (!$dir_handle) die("目录打开错误！");
		
		// 文件名为'0'时，readdir返回FALSE，判断返回值是否不全等
		while (false!==($filename=readdir($dir_handle))) {
			if ($filename!='.' && $filename!='..') {
				// 判断 是否为一个目录
				if (is_dir($dir_name.$filename)) {
					// $dir_flag标志目录树层次
					$this->path($dir_name.$filename.'/');
				}else{ 
					if (strpos($filename,'.class.php') !== false) {
						$this->_array[] = ltrim($dir_name,$this->root_dir).$filename;
					}
				}			
			}
		}
		closedir($dir_handle);//关闭目录句柄
	}

	/**
	 * 获得所有插件的配置信息
	 * @access public
     * @var array 
	*/
	public function ont(){
		$conf = [];
		foreach ($this->_array as $plugin) {
		// 假定每个插件文件夹中包含一个(未知).class.php文件，它是插件的具体实现 
			$conf[] = $this->config($plugin['path']);
		}
		return $conf;
	}

	/**
	 * 获得钩子的介绍信息
	 * @access public
	 * @dir    插件目录名 
	 * @return string
	*/
	public function config($dir='demo'){
		$url = $this->root_dir . $dir .'/'. $this->config . '.php';
		if(file_exists($url)){
			$dir  =  include $url;
			$txt['name']    = $dir['name'];    // 插件名
			$txt['hook']    = $dir['hook'];    // 钩子名
			$txt['title']   = $dir['title'];   // 插件别名
			$txt['edition'] = $dir['edition']; // 版本
			$txt['content'] = $dir['content']; // 插件描述
			$txt['author']  = $dir['author'];  // 作者
			$txt['type']    = $dir['type'];    // 插件状态
			$txt['install'] = $dir['install']; // 是否需要安装才能使用
			$txt['time']    = $dir['time'];    // 发布时间
			return $txt;
		}
		return false;
	}

	/**
	 * 初始化所有插件
	 * @access public 
	*/
	public function hook(){
		if ($this->_array) { 
            foreach ($this->_array as $plugin) {
				$type = $this->config($plugin['path']);
				# 只能激活已经安装的钩子 或者 申明不需要安装的钩子
				if ($type['type']!='3' || $type['install'] == '2') {
					# 假定每个插件文件夹中包含一个(未知).class.php文件，它是插件的具体实现 
					if (file_exists($this->root_dir.$plugin['path'].'/'.$plugin['name'].'.class.php')) { 
						# 初始化所有插件
						include_once($this->root_dir.$plugin['path'].'/'.$plugin['name'].'.class.php'); 
						$class = $plugin['name']; 
						if (class_exists($class)) {
						   # $this 是本类的引用
						   new $class($this); 
						}
					} 
				}
            } 
        } 
	# 此处做些日志记录方面的东西 
	}

	/** 
     * 注册需要监听的插件方法（钩子） 
     * 
     * @param string $hook 
     * @param object $reference 
     * @param string $method 
    */ 
	public function register($hook, &$reference, $method) { 
		# 获取插件要实现的方法 
		$key = get_class($reference).'->'.$method; 
		# 将插件的引用连同方法push进监听数组中 
		$this->_listeners[$hook][$key] = array(&$reference, $method); 
		# 此处做些日志记录方面的东西
	}

	/** 
     * 触发一个钩子 
     * 
     * @param string $hook 钩子的名称 
     * @param mixed $data  钩子的入参 
	 * @param mixed $type  动态调用钩子内的方法
     * @return mixed 
    */
	public function trigger($hook, $data='',$type='') {
        $result = ''; 
        # 查看要实现的钩子，是否在监听数组之中 
        if (isset($this->_listeners[$hook]) && is_array($this->_listeners[$hook]) && count($this->_listeners[$hook]) > 0) { 
            # 循环调用开始 
            foreach ($this->_listeners[$hook] as $listener) { 
                // 取出插件对象的引用和方法 
                $class  =& $listener[0]; 
                $method = $listener[1]; 
                if (method_exists($class,$method)) { 
					if(empty($type)){
                   		$result .= $class->$method($data); 
					}else{
						// 动态调用插件的方法 
                    	$result .= $class->$type($data); 
					}
                } 
            } 
        }
        #此处做些日志记录方面的东西 
        return $result; 
    }

	/**
	 * 删除一个插件
	 * @param string $path 插件名
	 * @return bool
	 */
	public function delHook($path){
		if(file_exists($path)){
			if($dir_handle = opendir($path)){
				while($filename=readdir($dir_handle)){ 
					if($filename!='.' && $filename!='..'){  
						$subFile=$path."/".$filename; 
						if(is_dir($subFile)){
							$this->delHook($subFile);
						}  
						if(is_file($subFile)){
							unlink($subFile);
						}  
					}  
				}  
				closedir($dir_handle);
				rmdir($path); 
				return true;
			}  
		}
		return false;
	}

	/**
	 * 启动一个插件
	 * @param string $name 插件名
	 * @return bool
	 */
	public function enableHook($name){
		$url     = $this->root_dir . $name . '/' . $this->config . '.php';
		$content = file_get_contents($url);
		$res     = preg_replace($this->pattern, "'type' => '1',", $content);
		# 修改插件状态
		$res = file_put_contents($url, $res);
		if ($res) return true;
		return false;
	}

	/**
	 * 启动一个插件
	 * @param string $name 插件名
	 * @return bool
	 */
	public function disableHook($name){
		$url     = $this->root_dir . $name . '/' . $this->config . '.php';
		$content = file_get_contents($url);
		$res     = preg_replace($this->pattern, "'type' => '3',", $content);
		# 修改插件状态
		$res = file_put_contents($url, $res);
		if ($res) return true;
		return false;
	}

	/**
	 * 安装一个插件
	 * @param string $name 插件名
	 * @param string $hook 钩子名
	 * @return bool
	 */
	public function installHook($name, $hook){
		$this->hook();
		$url     = $this->root_dir . $name . '/' . $this->config . '.php';
		$content = file_get_contents($url);
		# 执行插件自带的安装方法
		$res     = $this->trigger($hook,'','Add');

		if ($res) {
			$res = preg_replace($this->pattern, "'type' => '2',", $content);
			# 修改插件状态
			$res = file_put_contents($url, $res);
			if ($res) return true;
		}
		return false;
	}

	/**
	 * 卸载一个插件
	 * @param string $name 插件名
	 * @param string $hook 钩子名
	 * @return bool
	 */
	public function uninstallHook($name, $hook){
		$this->hook();
		$url     = $this->root_dir . $name . '/' . $this->config . '.php';
		$content = file_get_contents($url);
		# 自行插件自带的安装方法
		$res     = $this->trigger($hook,'','Del');
		if ($res) {
			$res = preg_replace($this->pattern, "'type' => '1',", $content);
			# 修改插件状态
			$res = file_put_contents($url, $res);
			if ($res) return true;
		}
		return false;
	}
	

	/**
	 * 创建一个插件
	 * @param string $name    插件名，也是插件的目录名，唯一
	 * @param string $hook    钩子名，唯一，例如：shop
	 * @param string $title   插件别名，例如：我是一个插件
	 * @param string $edition 版本，例如：V.1.0
	 * @param string $author  插件作者
	 * @param string $install 是否需要安装 是否 1|2
	 * @param string $conf    是否需要配置 是否 1|2
	 * @return array status|msg 状态|描述
	 */
	public function addHook($name, $hook, $title, $edition, $content, $author, $install=2, $conf=2){
		$list = $this->ont(); // 获得插件的所有配置信息
		# 验证
		foreach ($list as $value) {
			# 判断插件名是否存在
			if ($value['name'] == $name) return ['status'=> false, 'msg' => '插件名已存在，请返回修改']; 
			# 判断钩子名是否存在
			if ($value['hook'] == $hook)  return ['status'=> false, 'msg' => '钩子名已存在，请返回修改']; 
		}
		
		$type = 1;                           // 插件状态  未安装|启用|禁用 1|2|3
		$time = date('Y-m-d h:i:s', time()); // 发布时间
		# 创建目录，并设置权限
		mkdir($this->root_dir . $name . '/');
		chmod($this->root_dir . $name . '/', 0777);

		# 开始创建插件
		# 1.首先创建介绍文件
$txt = "<?php
// +----------------------------------------------------------------------
// | JunThink - '$name'插件的介绍信息
// +----------------------------------------------------------------------
// | Copyright (c) 2017 www.junphp.com/think/
// +----------------------------------------------------------------------
// | Author: 小黄牛 <1731223728@qq.com>
// +----------------------------------------------------------------------
return array(
	'name'    => '$name',//插件名
	'hook'    => '$hook',//钩子名
	'title'   => '$title',//插件别名
	'edition' => '$edition',//版本
	'content' => '$content',//插件介绍
	'author'  => '$author',//开发者
	'type'    => '$type',//插件状态
	'install' => '$install',//是否需要安装
	'time'    => '$time',//发布时间
);"; 
		$fopen = fopen($this->root_dir . $name . '/config.php','wb'); // 新建文件
		fputs($fopen, $txt);                                          // 向文件中写入内容; 
		fclose($fopen);

		# 2.判断是否需要生成配置文件
		if($conf == 1){
$txt = "<?php
// +----------------------------------------------------------------------
// | JunThink - '$name'插件的配置文件
// +----------------------------------------------------------------------
// | Copyright (c) 2017 www.junphp.com/think/
// +----------------------------------------------------------------------
// | Author: 小黄牛 <1731223728@qq.com>
// +----------------------------------------------------------------------
return array(
	//'键名' => '键值',
);"; 
			$fopen = fopen($this->root_dir . $name . '/Parameter.php','wb');// 新建文件
			fputs($fopen,$txt);                                             // 向文件中写入内容; 
			fclose($fopen);
		}

		# 3.创建插件文件，并判断是否需要配置文件，以及插件安装
		if($install == 1){
$txt = 'class '.$name.' {
	// 插件配置参数,一维数组
	private $config;

	// 构造方法
	public function __construct(&$pluginManager) {
        // 注册这个插件
        // 第一个参数是钩子的名称
        // 第二个参数是pluginManager的引用
        // 第三个是插件所执行的方法
        $pluginManager->register("'.$hook.'", $this,"Yun");

		// 获得配置参数
		$url = "'.$this->root_dir.$name.'/Parameter.php";
		if(file_exists($url)){
			$this->config = include $url;
		}
    }

	// 插件安装方法
	public function Add(){
		// 执行成功后需要返回true
		return true;
	}

	// 插件卸载方法
	public function Del(){
		// 执行成功后需要返回true
		return true;
	}

 	// 插件默认执行的方法
    public function Yun() {

    }
}';
		}else  if($conf == 1){
$txt = 'class '.$name.' {
	// 插件配置参数,一维数组
	private $config;

	// 构造方法
	public function __construct(&$pluginManager) {
        // 注册这个插件
        // 第一个参数是钩子的名称
        // 第二个参数是pluginManager的引用
        // 第三个是插件所执行的方法
        $pluginManager->register("'.$hook.'", $this,"Yun");

		// 获得配置参数
		$url = "'.$this->root_dir.$name.'/Parameter.php";
		if(file_exists($url)){
			$this->config = include $url;
		}
    }

 	// 插件默认执行的方法
    public function Yun() {

    }
}';	
		}else{
$txt = 'class '.$name.' {
	// 构造方法
	public function __construct(&$pluginManager) {
        // 注册这个插件
        // 第一个参数是钩子的名称
        // 第二个参数是pluginManager的引用
        // 第三个是插件所执行的方法
        $pluginManager->register("'.$hook.'", $this,"Yun");
    }

 	// 插件默认执行的方法
    public function Yun() {

    }
}';			
		}
$header = '<?php
// +----------------------------------------------------------------------
// | JunThink - '.$name.'插件 - '.$title.'
// +----------------------------------------------------------------------
// | Copyright (c) 2017 www.junphp.com/think/
// +----------------------------------------------------------------------
// | Author: '.$author.' - JunThink插件式内容管理系统 <1731223728@qq.com>
// +---------------------------------------------------------------------
';
		$fopen = fopen($this->root_dir . $name . '/' . $name.'.class.php','wb'); // 新建文件
		fputs($fopen, $header . $txt);                                           // 向文件中写入内容
		fclose($fopen);
		return ['status'=>true, 'msg'=>'插件创建成功'];
	}
}
