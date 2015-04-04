package me.rainssong.RainAvgEngine.manager
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import me.rainssong.rainMVC.view.TipTextFieldMediator;
	import me.rainui.components.Label;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TextFieldCore
	{
		public static var animDic:Dictionary = new Dictionary();
		public function TextFieldCore() 
		{
			
		}
		
		public static function getAnimation(tf:Label):TextFieldAnimation
		{
			return animDic[tf] ||= new TextFieldAnimation(tf) ;
		}
		
		public static function anim(tf:Label, vars:Object =null ):void
		{
			getAnimation(tf).reset(vars);
		}
		
		public static function isFinished(tf:Label):Boolean
		{
			return getAnimation(tf).isFinished;
		}
		
		public static function finish(tf:Label):void
		{
			getAnimation(tf).finish();
		}
		
		
		
	}

}