package me.rainssong.RainAvgEngine.utils 
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * @date 2015/3/9 5:21
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ShakeManager extends EventDispatcher
	{
		private var _target:DisplayObject;
		private var _timer:Timer = new Timer(50, 0);
		private var _originX:Number=0;
		private var _originY:Number = 0;
		private var _value:Number = 5;
		public function ShakeManager(target:DisplayObject=null) 
		{
			_target = target;
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
		}
		
		private function onComplete(e:TimerEvent):void 
		{
			dispatchEvent(e.clone());
			endShake();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_target.x = _originX + Math.random() * _value * 2 - _value;
			_target.y = _originY + Math.random() * _value * 2 - _value;
		}
		
		public function startShake(value:Number = 100,delay:Number=20, repeatCount:Number = 2):void
		{
			endShake();
			_timer.reset();
			_value = value;
			_originX = _target.x;
			_originY = _target.y;
			_timer.delay = delay;
			_timer.repeatCount = repeatCount;
			_timer.start();
		}
		
		public function endShake():void 
		{
			_target.x = _originX;
			_target.y = _originY;
		}
		
		public function get target():DisplayObject 
		{
			return _target;
		}
		
		public function set target(value:DisplayObject):void 
		{
			_target = value;
		}
		
	}

}