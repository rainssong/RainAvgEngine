package me.rainssong.RainAvgEngine.view 
{
	import com.codeazur.as3swf.data.consts.BitmapFormat;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import me.rainssong.events.GameEvent;
	import me.rainui.components.Page;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/4/7 17:16
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class PauseMenuView extends OptionsPanel 
	{
		
		public function PauseMenuView() 
		{
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//addChild(optionsPanel);
			this.centerX = 0;
			this.percentCenterY = -0.15;
			this.percentHeight = 0.4;
			this.percentWidth = 0.6;
			this.showOptions(["继续", "保存", "读取", "退出"]);
			
		}
		
		private function onSelect(e:GameEvent):void 
		{
			dispatchEvent(e);
			//addChild(optionsPanel);
		}
		
	}

}