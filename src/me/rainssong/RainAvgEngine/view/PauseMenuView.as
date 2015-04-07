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
	public class PauseMenuView extends Page 
	{
		public var optionsPanel:OptionsPanel = new OptionsPanel();
		public function PauseMenuView() 
		{
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			addChild(optionsPanel);
			optionsPanel.centerX = 0;
			optionsPanel.percentCenterY = -0.15;
			optionsPanel.percentHeight = 0.4;
			optionsPanel.percentWidth = 0.6;
			optionsPanel.addEventListener(RainUIEvent.SELECT, onSelect);
			optionsPanel.showOptions(["继续", "保存", "读取", "退出"]);
			
			bgSkin = new Bitmap(new BitmapData(100, 100, false, 0));
			bgSkin.alpha = 0.4;
		}
		
		private function onSelect(e:GameEvent):void 
		{
			dispatchEvent(e);
			addChild(optionsPanel);
		}
		
	}

}