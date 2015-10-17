package me.rainssong.RainAvgEngine.events 
{
	import flash.events.Event;
	import me.rainssong.events.ObjectEvent;
	
	/**
	 * @date 2015/10/1 1:55
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class AssetManagerEvent extends ObjectEvent 
	{
		static public const RESOURCE_COMPLETE:String = "resourceComplete";
		static public const CONFIG_COMPLETE:String = "configComplete";
		
		public function AssetManagerEvent(type:String,data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type,data, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new AssetManagerEvent(type,data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AssetManagerEvent","data", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}