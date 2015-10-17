package me.rainssong.RainAvgEngine.events
{
	import flash.events.Event;
	import me.rainssong.events.ObjectEvent;
	
	/**
	 * @date 2015/10/1 17:15
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class RainAVGEngineEvent extends ObjectEvent 
	{
		static public const SHOW_MENU:String = "showMenu";
		
		public function RainAVGEngineEvent(type:String, data:Object =null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type,data, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new RainAVGEngineEvent(type,data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("RainAVGEngineEvent","data", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}