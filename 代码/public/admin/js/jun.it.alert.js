(function($){
	var MaskNum      = 0;      // 弹窗总数
	var Color        = 'cyan'; // 颜色风格统一
	var ColorClass   = 'cyan';
	var BagClass     = 'alert-cyan';
	var BorderClass  = 'border-cyan';
	var FontClass    = 'font-cyan';
	/**
	 * 全局绑定配色方案
	*/
	$.MaskColor = function (Color) {
		Color  = arguments[0]    ? arguments[0]    : Color;   
		switch(Color)
		{
			case 'cyan':   ColorClass = 'cyan';   BagClass = 'alert-cyan';   BorderClass = 'border-cyan';    FontClass = 'font-cyan';    break;
			case 'green':  ColorClass = 'green';  BagClass = 'alert-green';  BorderClass = 'border-green';   FontClass = 'font-green';   break;
			case 'blue':   ColorClass = 'blue';   BagClass = 'alert-blue';   BorderClass = 'border-blue';    FontClass = 'font-blue';    break;
			case 'orange': ColorClass = 'orange'; BagClass = 'alert-orange'; BorderClass = 'border-orange';  FontClass = 'font-orange';  break;
			case 'dark':   ColorClass = 'dark';   BagClass = 'alert-dark';   BorderClass = 'border-dark';    FontClass = 'font-dark';    break;
			/*case '': ColorClass = '';break;*/
			default:
			$.warning({
				Title       : '警告',
				Content     : '暂无该颜色配置方案，已使用默认配色方案-> cyan ~',
				OutTime     : 2000,
			});
		}
	}
	
	/**
	 * 绑定JQ的点击事件
	*/
	$.MaskClose = function (Id) {
		$('#'+Id+' .mkter-close').on('click', function(){
			// 父窗ID
			var Id = $(this).parent().parent().attr('id');
			// 向上滑动渐变退出
			$("#"+Id).animate({top:"0px",opacity:'0'},300);
			// 删除HTML实体
			window.setTimeout(function(){
				$("#"+Id).remove();
			},1000); 
			// 弹窗数-1
			MaskNum = MaskNum-1;
			$.MaskEnd();
		});
	}

	/**
	 * 极资源 - IT部 - 关闭弹窗
	 * @desc  建议用在业务处理时，弹窗关闭处
	 * @param Id      弹窗Id
	*/
	$.MaskClick = function (Id) {
		// 向上滑动渐变退出
		$("#"+Id).animate({top:"0px",opacity:'0'},300);
		// 删除HTML实体
		window.setTimeout(function(){
			$("#"+Id).remove();
		},1000); 
		// 弹窗数-1
		MaskNum = MaskNum-1;
		$.MaskEnd();
	}

	/**
	 * 极资源 - IT部 - 打开遮罩层
	 * @desc  只有弹窗数为0时，才打开遮罩层
	 * @param MaskColor      遮罩层颜色
	 * @param MaskBright     遮罩层不透明读
	 * @return bool
	*/
	$.MaskStart = function (MaskColor, MaskBright) {
		var Id   = 'app-mask';
		if(MaskNum == 0 && ($("#"+Id).length==0) ){
			
			var html = 	'<div id="'+Id+'" class="app-mask" style="background-color:'+MaskColor+';filter: alpha(opacity='+MaskBright*100+'); opacity:'+MaskBright+'; -moz-opacity:'+MaskBright+';"></div>';
			$(document.body).append(html);
			$("#"+Id).css("height",$(document).height());     
			$("#"+Id).css("width",$(document).width());     
			$("#"+Id).show();  
			return true;
		}
		return false; 
	}

	/**
	 * 极资源 - IT部 - 关闭遮罩层
	 * @desc  只有弹窗数为1时，才关闭遮罩层
	 * @return bool
	*/
	$.MaskEnd = function () {
		if(MaskNum == 0){
			var Id   = 'app-mask';
			$("#"+Id).fadeOut(300);
			// 删除HTML实体
			window.setTimeout(function(){
				$("#"+Id).remove();
			},1000);
			return true;
		}
		return false; 
	}

	/**
	 * 极资源 - IT部 - 弹窗插件 - 弹出编辑框
	 * @param Data.Id             唯一ID值
	 * @param Data.Title          头部弹窗文字
	 * @param Data.Botton         底部按钮文字
	 * @param Data.Width          弹窗宽度
	 * @param Data.Top            距离顶部多少PX
	 * @param Data.MaskColor      遮罩层颜色
	 * @param Data.MaskBright     遮罩层不透明读
	 * @param Data.Form           json表单配置
	 * @param Data.Click          点击保存按钮回调函数
	 * 
	*/
	$.mkter = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : 'App';  
		var Title      = Data.Title      ? Data.Title      : '新建项目';   
		var Botton     = Data.Botton     ? Data.Botton     : '保存';   
		var Width      = Data.Width      ? Data.Width      : '320';
		var Top        = Data.Top        ? Data.Top        : '50';
		var MaskColor  = Data.MaskColor  ? Data.MaskColor  : '#000';
		var MaskBright = Data.MaskBright ? Data.MaskBright : 0.8;
		var Form       = Data.Form       ? Data.Form       : '{}';
		var Click      = Data.Click      ? Data.Click      : '';

		// 验证ID是否已经存在
		if($("#"+Id).length > 1){
			console.log('ID已存在，请修改！');
			return false;
		}

		// 打开遮罩层
		$.MaskStart(MaskColor, MaskBright);
		// 弹窗数+1
		MaskNum += 1;

		// 开始组合弹窗HTML结构
		var html = '';
		html += '<div id="'+Id+'" class="app-mkter-border app-mkter" style="width: '+Width+'px; margin-left: -'+(Width/2)+'px;opacity:0; top:0px; z-index: 11;">';
		html += '<div class="mkter-top">';
		html += Title;
		html += '<button type="button" class="mkter-close">×</button>';
		html += '</div>';

		html += '<div class="mkter-content">';
		var array = eval(Form);
		for(var i=0; i<array.length; i++){
			var type = Form[i]['type'];
			if(type == 'text' || type == 'password' || type == 'hidden'){
				html += '<div style="position: relative;"><input class="mkter-form-input" type="'+type+'" id="'+Form[i]['id']+'" placeholder="'+Form[i]['title']+'" value="'+Form[i]['value']+'"></input><span id="'+Form[i]['id']+'-vif"></span></div>';
			}else if(type == 'textarea'){
				html += '<div><textarea class="mkter-form-input mkter-form-textarea" id="'+Form[i]['id']+'" placeholder="'+Form[i]['title']+'">'+Form[i]['value']+'</textarea><span id="'+Form[i]['id']+'-vif"></span></div>';
			}else if(type == 'select'){
				html += '<div class="mkter-form-select">';
				html += '<select id="'+Form[i]['id']+'">';
				var option =  eval(Form[i]['option']);
				for(var k=0; k<option.length; k++){
					if (option[k]['id'] != Form[i]['value']) {
						html += '<option value="'+option[k]['id']+'">'+option[k]['title']+'</option>';
					}else{
						html += '<option value="'+option[k]['id']+'" selected>'+option[k]['title']+'</option>';
					}
				}
				html += '</select>';
				html += '<span id="'+Form[i]['id']+'-vif"></span></div>';
			}else if(type == 'more'){
				var option =  eval(Form[i]['option']);
				var value  =  eval(Form[i]['value']);
				var More_Click = Form[i]['dui_click'];
				var length = option.length;
				var width  = 80 / length+'%';

				var dui    = '';
				if(Form[i]['dui'] == true){
					dui = '<span class="icon-dui '+FontClass+'">√</span>';
				}

				// 生成已选参数
				var geshu = 0; //全局变量
				html += '<div id="mkter-more">';
				for(var x=0; x<value.length; x++){
					geshu = x;
					html += '<div class="mkter-form-more-num">';
					if((x+1) == value.length){
						for(var k=0; k<length; k++){
							var key = option[k]['id'];
							html += '<input class="mkter-form-more '+BorderClass+'" style="width:'+width+'" type="text" name="'+Form[i]['id']+'['+x+']'+'['+key+']" data-title="'+key+'" placeholder="'+option[k]['title']+'" value="'+value[x][key]+'"></input>';
						}
					}else{
						for(var k=0; k<length; k++){
							var key = option[k]['id'];
							html += '<input class="mkter-form-more '+BorderClass+'" style="width:'+width+'" type="text" name="'+Form[i]['id']+'['+x+']'+'['+key+']" data-title="'+key+'" placeholder="'+option[k]['title']+'" value="'+value[x][key]+'"></input>';
						}
					}
					
					html += dui+'<span class="icon-cuo">×</span></div>';
				}
				html += '</div>';
				html += '<div><div class="mkter-form-more-click '+ColorClass+'">新增</div></div>';

				var add_array = new Array();
				var add_key   = Form[i]['id'];

				for(var k=0; k<length; k++){
					add_array[k] = option[k];
				}
			}
		}
		html += '</div>';
		html += '<div class="mkter-bottom">';
		html += '<button type="button" class="mkter-click '+ColorClass+'">'+Botton+'</button>';
		html += '</div>';
		html += '</div>';
		$(document.body).append(html);
		// 向下滑动渐现
		$("#"+Id).animate({top:Top+"px",opacity:'1'},700);
		// 点击保存按钮回调
		$("#"+Id+" .mkter-click").on('click', function(){
			if(Click != ''){
				eval(Click);
			}
		});


		// more类型时 - 点击新增更多时，在最下方新增一个
		$(".mkter-form-more-click").on('click', function(){
			var height = parseInt($('#'+Id).css('height'))-100;
			if(height >= $(document).height()-Top-250){
				$('#'+Id).css('height', height+'px');
				$('#'+Id).css('overflow', 'auto');
			}

			var add_txt = '<div class="mkter-form-more-num">';
			for(var k=0; k<add_array.length; k++){
				add_txt += '<input class="mkter-form-more '+BorderClass+'" style="width:'+width+'" type="text" name="'+add_key+'['+(geshu+1)+']'+'['+add_array[k]['id']+']" data-title="'+add_array[k]['id']+'" placeholder="'+add_array[k]['title']+'" value="'+add_array[k]['value']+'"></input>';		
			}

			add_txt += dui+'<span class="icon-cuo">×</span></div>';

			$('#mkter-more').append(add_txt);
			geshu++;

			// more类型时 - 点击删除，把当前的删除掉
			$(".mkter-form-more-num .icon-cuo").on('click', function(){
				$(this).parent('.mkter-form-more-num').remove();
			});

			// more类型时 - 点击确认，调用回调函数
			$(".mkter-form-more-num .icon-dui").on('click', function(){
				var _this = $(this).parent('.mkter-form-more-num');
				var _t    = _this.find('input');

				var ajax_more = '{';
				for(var i=0; i<_t.length; i++){
					 var more_key = _this.find('input:eq('+i+')').attr('data-title');
					 var more_val = _this.find('input:eq('+i+')').val();
					 ajax_more += '"'+more_key+'":"'+more_val+'",';
				}
				ajax_more += '}';	
				
				eval(More_Click);
			});
		});

		// more类型时 - 点击删除，把当前的删除掉
		$(".mkter-form-more-num .icon-cuo").on('click', function(){
			$(this).parent('.mkter-form-more-num').remove();
		});

		// 开启监听关闭框
		$.MaskClose(Id);
		
	};  

	/**
	 * 极资源 - IT部 - 弹窗插件 - 提示框1
	 * @param Data.Id             唯一ID值
	 * @param Data.Title          头部弹窗文字
	 * @param Data.Content        弹窗内容实体
	 * @param Data.Out            取消按钮文字
	 * @param Data.Confirm        确认按钮文字
	 * @param Data.Width          弹窗宽度
	 * @param Data.MaskColor      遮罩层颜色
	 * @param Data.MaskBright     遮罩层不透明读
	 * @param Data.OutState       是否需要取消按钮
	 * @param Data.Click_O        点击取消按钮回调函数
	 * @param Data.Click_C        点击确认按钮回调函数
	*/
	$.confirm = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : 'App-alert-1';  
		var Title      = Data.Title      ? Data.Title      : '提示';   
		var Content    = Data.Content    ? Data.Content    : '不要反驳，小黄牛帅得一B！';   
		var Out        = Data.Out        ? Data.Out        : '取消';   
		var Confirm    = Data.Confirm    ? Data.Confirm    : '确认';   
		var Width      = Data.Width      ? Data.Width      : '320';
		var MaskColor  = Data.MaskColor  ? Data.MaskColor  : '#000';
		var MaskBright = Data.MaskBright ? Data.MaskBright : 0.8;
		var OutState   = Data.OutState   ? Data.OutState   : true;
		var Click_O    = Data.Click_O    ? Data.Click_O    : '';
		var Click_C    = Data.Click_C    ? Data.Click_C    : '';

		// 验证ID是否已经存在
		if($("#"+Id).length > 1){
			console.log('ID已存在，请修改！');
			return false;
		}

		// 打开遮罩层
		$.MaskStart(MaskColor, MaskBright);
		// 弹窗数+1
		MaskNum += 1;

		// 开始组合弹窗HTML结构
		var html = '';
		html +='<div id="'+Id+'" class="app-mkter-border app-mkter app-alert '+BagClass+'" style="width: '+Width+'px; margin-left: -'+(Width/2)+'px;opacity:0; height:220px; top:100%; z-index: 12;">';
		html +='<div class="mkter-top alert-top '+ColorClass+'"><span>'+Title+'</span><button type="button" class="mkter-close alert-close">×</button></div>';
		html +='<div class="mkter-content alert-content">';
		html +='<span>'+Content+'</span>';
		html +='</div>';
		html +='<div class="mkter-bottom alert-bottom">';
		if(OutState == true){
			html +='<button type="button" class="mkter-close alert-out">'+Out+'</button>';
		}
		html +='<button type="button" class="mkter-click alert-click '+ColorClass+'">'+Confirm+'</button>';
		html +='</div>';
		html +='</div>';
		$(document.body).append(html);

		// 向下滑动渐现
		$("#"+Id).animate({top:'50%','margin-top':'-110px',opacity:'1'},400);
		// 点击确认按钮回调
		$("#"+Id+" .alert-click").on('click', function(){
			if(Click_C != ''){
				eval(Click_C);
			}
		});
		// 点击取消按钮回调
		$("#"+Id+" .alert-out").on('click', function(){
			if(Click_O != ''){
				eval(Click_O);
			}
		});

		// 开启监听关闭框
		$.MaskClose(Id);
	};  

	/**
	 * 极资源 - IT部 - 弹窗插件 - 提示框2
	 * @param Data.Id             唯一ID值
	 * @param Data.Title          头部弹窗文字
	 * @param Data.Content        弹窗内容实体
	 * @param Data.Width          弹窗宽度
	 * @param Data.MaskColor      遮罩层颜色
	 * @param Data.MaskBright     遮罩层不透明读
	*/
	$.alert = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : 'App-alert-2';  
		var Title      = Data.Title      ? Data.Title      : '提示';   
		var Content    = Data.Content    ? Data.Content    : '不要反驳，小黄牛帅得一B！';   
		var Width      = Data.Width      ? Data.Width      : '320';
		var MaskColor  = Data.MaskColor  ? Data.MaskColor  : '#000';
		var MaskBright = Data.MaskBright ? Data.MaskBright : 0.8;

		// 验证ID是否已经存在
		if($("#"+Id).length > 1){
			console.log('ID已存在，请修改！');
			return false;
		}

		// 打开遮罩层
		$.MaskStart(MaskColor, MaskBright);
		// 弹窗数+1
		MaskNum += 1;

		// 开始组合弹窗HTML结构
		var html = '';
		html +='<div id="'+Id+'" class="app-mkter-border app-mkter app-alert '+BagClass+'" style="width: '+Width+'px; margin-left: -'+(Width/2)+'px;opacity:0; height:170px; top:100%; z-index: 13;">';
		html +='<div class="mkter-top alert-top '+ColorClass+'"><span>'+Title+'</span><button type="button" class="mkter-close alert-close">×</button></div>';
		html +='<div class="mkter-content alert-content">';
		html +='<span>'+Content+'</span>';
		html +='</div>';
		html +='</div>';
		$(document.body).append(html);

		// 向下滑动渐现
		$("#"+Id).animate({top:'50%','margin-top':'-85px',opacity:'1'},300);
		
		// 开启监听关闭框
		$.MaskClose(Id);
	}; 


	/**
	 * 极资源 - IT部 - 弹窗插件 - 提示框3
	 * @param Data.Id             唯一ID值
	 * @param Data.Content        弹窗内容实体
	 * @param Data.Width          弹窗宽度
	 * @param Data.MaskColor      遮罩层颜色
	 * @param Data.MaskBright     遮罩层不透明读
	 * @param Data.OutTime        自动关闭时间，(S)秒
	*/
	$.warning = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : 'App-alert-3';  
		var Content    = Data.Content    ? Data.Content    : '不要反驳，小黄牛帅得一B！';   
		var Width      = Data.Width      ? Data.Width      : '320';
		var MaskColor  = Data.MaskColor  ? Data.MaskColor  : '#000';
		var MaskBright = Data.MaskBright ? Data.MaskBright : 0.8;
		var OutTime    = Data.OutTime    ? Data.OutTime    : 1500;

		// 验证ID是否已经存在
		if($("#"+Id).length > 1){
			console.log('ID已存在，请修改！');
			return false;
		}

		// 打开遮罩层
		$.MaskStart(MaskColor, MaskBright);
		// 弹窗数+1
		MaskNum += 1;

		// 开始组合弹窗HTML结构
		var html = '';
		html +='<div id="'+Id+'" class="app-mkter-border app-mkter app-alert '+BagClass+'"  style="width: '+Width+'px; margin-left: -'+(Width/2)+'px;opacity:0; height: 110px; top: 100%; z-index: 14;">';
		html +='<div class="mkter-top alert-top2"><button type="button" class="mkter-close alert-close">×</button></div>';
		html +='<div class="mkter-content alert-content"><span>'+Content+'</span></div>';
		html +='</div>';
		
		$(document.body).append(html);

		// 向下滑动渐现
		$("#"+Id).animate({top:'50%','margin-top':'-55px',opacity:'1'},250);
		 
		// 开启监听关闭框
		$.MaskClose(Id);
		// 倒计时自动关闭
		window.setTimeout(function(){
			$('#'+Id+' .mkter-close').trigger("click");
		},OutTime);
	}; 
	
	/**
	 * 极资源 - IT部 - 弹窗插件 - 文字提示框
	 * @param Data.Id             唯一ID值
	 * @param Data.Content        提示内容
	 * @param Data.Color          字体颜色
	 * @param Data.OutState       是否开启自动关闭功能
	 * @param Data.OutTime        自动关闭时间，(S)秒
	*/
	$.prompt = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : '';  
		var Content    = Data.Content    ? Data.Content    : '不要反驳，小黄牛帅得一B！'; 
		var Color      = Data.Color      ? Data.Color      : 'red'; 
		var OutState   = Data.OutState   ? Data.OutState   : true; 
		var OutTime    = Data.OutTime    ? Data.OutTime    : 1500;
		$('#'+Id).html(Content);

		// 验证ID是否已经存在
		if($("#"+Id).length > 1){
			console.log('ID已存在，请修改！');
			return false;
		}
		
		// 修改初始化样式
		$('#'+Id).css('position','absolute');
		$('#'+Id).css('opacity','-10');
		$('#'+Id).css('right','0px');
		$('#'+Id).css('z-index','2');
		$('#'+Id).css('top','25%');
		$('#'+Id).css('color', Color);
		$('#'+Id).css('min-width','80px');
		$('#'+Id).css('min-height','30px');
		$('#'+Id).css('line-height','30px');
		$('#'+Id).css('background','#fff');

		// 向左滑渐现
		$("#"+Id).animate({right:'20px',opacity:'1'},700);

		// 开启自动关闭功能
		if(OutState == true){
			window.setTimeout(function(){
				// 向右滑渐隐
				$("#"+Id).animate({right:'0px',opacity:'0'},700);
				// 删除HTML实体
				window.setTimeout(function(){
					$("#"+Id).html('');
				},1000);
			},OutTime);
		}
	}; 

	/**
	 * 极资源 - IT部 - 弹窗插件 - 关闭文字提示框
	 * @param Data.Id             唯一ID值
	 * @param Data.OutTime        自动关闭时间，(S)秒
	*/
	$.promptEnd = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : '';  
		var OutTime    = Data.OutTime    ? Data.OutTime    : 1500;
		
		
		window.setTimeout(function(){
			// 向右滑渐隐
			$("#"+Id).animate({right:'0px',opacity:'0'},700);
			// 删除HTML实体
			window.setTimeout(function(){
				$("#"+Id).remove();
			},1000);
		},OutTime);
		
	}; 

	/**
	 * 极资源 - IT部 - 弹窗插件 - 加载等待
	 * @param Data.Id             唯一ID值
	 * @param Data.Model          文字模式en | ch
	 * @param Data.MaskColor      遮罩层颜色
	 * @param Data.MaskBright     遮罩层不透明读
	 * @param Data.OutState       是否开启自动关闭功能
	 * @param Data.OutTime        自动关闭时间，(S)秒
	*/
	$.load = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : 'App-alert-loading';  
		var Model      = Data.Model      ? Data.Model      : 'ch';
		var MaskColor  = Data.MaskColor  ? Data.MaskColor  : '#000';
		var MaskBright = Data.MaskBright ? Data.MaskBright : 0.8;
		var OutState   = Data.OutState   ? Data.OutState   : false; 
		var OutTime    = Data.OutTime    ? Data.OutTime    : 2000;

		// 验证ID是否已经存在
		if($("#"+Id).length > 1){
			console.log('ID已存在，请修改！');
			return false;
		}

		// 打开遮罩层
		$.MaskStart(MaskColor, MaskBright);
		// 弹窗数+1
		MaskNum += 1;

		// 语言包
		if(Model == 'ch'){
			var lang = '加载中，请稍等 ...';
		}else{
			var lang = 'loading ...';
		}

		// 开始组合弹窗HTML结构
		var html = '';
		html +='<div id="'+Id+'" class="app-mkter-border" style="width: 120px; margin-left: -60px; opacity:0; height: 30px;margin-top:15px; top: 0px; z-index: 15;background: none;color: #fff;text-align: center;box-shadow: none!important;border: 0;">';
		html +='<span>'+lang+'</span>';
		html +='</div>';

		$(document.body).append(html);
		// 向下滑动渐现
		$("#"+Id).animate({top:'50%',opacity:'1'},700);

		// 开启自动关闭功能
		if(OutState == true){
			// 弹窗数-1
			MaskNum = MaskNum-1;
			window.setTimeout(function(){
				// 向右滑渐隐
				$("#"+Id).animate({top:'0px',opacity:'0'},700);
				// 关闭遮罩层
				$.MaskEnd();
				// 删除HTML实体
				window.setTimeout(function(){
					$("#"+Id).remove();
				},1000);
			},OutTime);
		}
	}; 

	/**
	 * 极资源 - IT部 - 弹窗插件 - 关闭加载等待
	 * @param Data.Id             唯一ID值
	 * @param Data.OutTime        延迟关闭时间，(S)秒
	*/
	$.loadEnd = function (Data) {  
		// 设置默认值
		var Data       = arguments[0]    ? arguments[0]    : '{}';   
		var Id         = Data.Id         ? Data.Id         : 'App-alert-loading';  
		var OutTime    = Data.OutTime    ? Data.OutTime    : 400;
		// 弹窗数-1
		MaskNum = MaskNum-1;
		// 向右边渐隐
		window.setTimeout(function(){
			// 向右滑渐隐
			$("#"+Id).animate({top:'0px',opacity:'0'},700);
			// 关闭遮罩层
			$.MaskEnd();
			// 删除HTML实体
			window.setTimeout(function(){
				$("#"+Id).remove();
			},1000);
		},OutTime);
		
	}; 
	

})(jQuery);