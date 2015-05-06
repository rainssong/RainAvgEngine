package me.rainssong.RainAvgEngine.view 
{
	import com.reintroducing.sound.SoundManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import me.rainssong.application.AirManager;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.tween.AnimationCore;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.components.Button;
	import me.rainui.components.Container;
	import me.rainui.components.DisplayResizer;
	import me.rainui.components.Label;
	import me.rainui.components.Page;
	
	/**
	 * @date 2015/1/10 18:18
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class HomeView extends Page
	{
		//public var title:Label = new Label();
		public var startBtn:Button = new Button("开始游戏");
		public var loadBtn:Button = new Button("继续游戏");
		
		public function HomeView() 
		{
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			//addChild(title);
			addChild(startBtn);
			addChild(loadBtn);
			
			startBtn.centerX = 0;
			startBtn.percentCenterY = 0;
			startBtn.percentHeight = 0.08;
			startBtn.percentWidth = 0.2;
			loadBtn.centerX = 0;
			loadBtn.percentCenterY = 0.1;
			loadBtn.percentHeight = 0.08;
			loadBtn.percentWidth = 0.2;
			
			bgSkin = new DisplayResizer(SingletonManager.bulkLoader.getBitmap("assets/MenuBg.jpg"));
			SoundManager.getInstance().playSound("assets/MenuBgm.mp3");
			DisplayResizer(bgSkin).contentScaleMode = ScaleMode.FULL_FILL;
			
			startBtn.addEventListener(MouseEvent.CLICK, onStartBtn);
			loadBtn.addEventListener(MouseEvent.CLICK, onLoadBtn);
			
			//callLater(resize);
		}
		
		private function onLoadBtn(e:MouseEvent):void 
		{
			SoundManager.getInstance().stopSound("assets/MenuBgm.mp3");
			var pv:PlayView = new PlayView();
			pv.load();
			AnimationCore.switchView(this, pv,"move",{delay:0.5});
		}
		
		private function onStartBtn(e:MouseEvent):void 
		{
			SoundManager.getInstance().stopSound("assets/MenuBgm.mp3");
			var pv:PlayView = new PlayView();
			pv.start();
			AnimationCore.switchView(this, pv);
		}
		
	}

}