package me.rainssong.RainAvgEngine.view 
{
	import com.reintroducing.sound.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.RainAvgEngine.manager.AssetManager;
	import me.rainssong.application.AirManager;
	import me.rainssong.events.GameEvent;
	import me.rainssong.manager.ScriptManager;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.RainAvgEngine.manager.MSManager;
	import me.rainssong.RainAvgEngine.manager.Singleton;
	import me.rainssong.tween.AnimationCore;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.components.Button;
	import me.rainui.components.Container;
	import me.rainui.components.DisplayResizer;
	import me.rainui.components.Label;
	import me.rainui.components.Page;
	import r1.deval.D;
	
	/**
	 * @date 2015/1/10 18:18
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class HomeView extends Page
	{
		public var startBtn:Button = new Button("开始游戏");
		public var loadBtn:Button = new Button("继续游戏");
		public var optionsPanel:OptionsPanel = new OptionsPanel();
		
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
			loadBtn.centerX = 0;
			startBtn.percentCenterY = 0;
			loadBtn.percentCenterY = 0.1;
			
			//addChild(optionsPanel);
			//
			//optionsPanel.centerX = 0;
			//optionsPanel.percentCenterY = -0.15;
			//optionsPanel.percentHeight = 0.4;
			//optionsPanel.percentWidth = 0.4;
			//optionsPanel.addEventListener(Event.SELECT, onSelect);
			
			bgSkin = new DisplayResizer(SingletonManager.bulkLoader.getBitmap("assets/Background/MenuBg.jpg"));
			
			
			SoundManager.getInstance().playSound("assets/BGM/MenuBgm.mp3",1,0,9999);
			DisplayResizer(bgSkin).contentScaleMode = ScaleMode.FULL_FILL;
			
			startBtn.addEventListener(MouseEvent.CLICK, onStartBtn);
			loadBtn.addEventListener(MouseEvent.CLICK, onLoadBtn);
			
			//Singleton.scriptManager.context = this;
			D.importClass(Button);
			//var str:String = Singleton.scriptManager.scriptDic["assets/Script/Menu.xml"].motion[0].toString();
			//str=str.
			//Singleton.scriptManager.context = this;
			//D.eval(str, this, null);
			Singleton.scriptManager.runScript(0,"assets/Script/Menu.xml");
		}
		
		//public function showOptions(opts:Array.<String> = null, clickNext:Boolean = false):void
		//{
			//optionsPanel.visible = true;
			//optionsPanel.disabled = false;
			//optionsPanel.showOptions(opts);
			//_clickNext = clickNext;
			//optionsPanel.resize();
		//}
		
		//public function hideOptions():void
		//{
			//optionsPanel.visible = false;
			//optionsPanel.disabled = true;
		//}
		
		private function onLoadBtn(e:MouseEvent):void 
		{
			SoundManager.getInstance().stopSound("assets/BGM/MenuBgm.mp3");
			//
			
			SingletonManager.eventBus.dispatchEvent(new GameEvent(GameEvent.LOAD));
		}
		
		private function onStartBtn(e:MouseEvent):void 
		{
			SoundManager.getInstance().stopSound("assets/BGM/MenuBgm.mp3");
			
			SingletonManager.eventBus.dispatchEvent(new GameEvent(GameEvent.GAME_START));
		}
		
	}

}