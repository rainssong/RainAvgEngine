package  me.rainssong.RainAvgEngine
{
	//import flash.desktop.NativeApplication;
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.SoundItem;
	import com.reintroducing.sound.SoundManager;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.Sound;
	import me.rainssong.events.GameEvent;
	import me.rainssong.filesystem.FileCore;
	import me.rainssong.manager.KeyboardManager;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.RainAvgEngine.events.AssetManagerEvent;
	import me.rainssong.RainAvgEngine.events.RainAVGEngineEvent;
	import me.rainssong.RainAvgEngine.manager.AssetManager;
	import me.rainssong.RainAvgEngine.manager.Singleton;
	import me.rainssong.RainAvgEngine.view.LoadingView;
	import me.rainssong.RainAvgEngine.view.HomeView;
	import me.rainssong.RainAvgEngine.view.PlayView;
	import me.rainssong.tween.AnimationCore;
	import me.rainssong.utils.Snapshot;
	import me.rainui.components.Page;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class GameView extends Page
	{
		public var loadingView:LoadingView;
		public var homeView:HomeView;
		public var playView:PlayView;
		public var assetManager:AssetManager
		public function GameView():void 
		{
			
		}
		
		override protected function onAdded(e:Event):void 
		{
			super.onAdded(e);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			loadingView = new LoadingView();
			addChild(loadingView);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			assetManager = new AssetManager();
			assetManager.addEventListener(AssetManagerEvent.RESOURCE_COMPLETE, onLoadComplete)
			assetManager.loadConfigFile("assets/resource.json");
			
			SingletonManager.eventBus.addEventListener(GameEvent.GAME_START, onHomeStart);
			SingletonManager.eventBus.addEventListener(GameEvent.LOAD, onHomeLoad);
			SingletonManager.eventBus.addEventListener(GameEvent.GAME_OVER, onGameOver);
		}
		
		private function onGameOver(e:GameEvent):void 
		{
			AnimationCore.switchView(playView, homeView = new HomeView(), "move", { direction:"down" } );
			dispatchEvent(new RainAVGEngineEvent(RainAVGEngineEvent.SHOW_MENU));
		}
		
		private function onHomeLoad(e:GameEvent):void 
		{
			playView = new PlayView();
			playView.load();
			AnimationCore.switchView(homeView, playView, "move", { delay:0.5 } );
		}
		
		private function onHomeStart(e:GameEvent):void 
		{
			playView = new PlayView();
			playView.start();
			AnimationCore.switchView(homeView, playView);
		}
		
		private function onLoadComplete(e:AssetManagerEvent):void 
		{
			Singleton.scriptManager.scriptDic["assets/Script/Menu.xml"] = assetManager.getXML("assets/Script/Menu.xml");
			//Singleton.scriptManager.scriptDic["assets/Script/Main.xml"] = assetManager.getXML("assets/Script/Main.xml");
			Singleton.scriptManager.scriptDic["assets/Script/Main.xml"] = assetManager.getXML("mainXml");
			
			for (var name:String in SingletonManager.bulkLoader.contents) 
			{
				if (SingletonManager.bulkLoader.contents[name] is Sound);
					SoundManager.getInstance().addSound(SingletonManager.bulkLoader.contents[name] as Sound , name);
			}
			
			
			AnimationCore.switchView(loadingView, homeView = new HomeView(), "move", { direction:"up" } );
			loadingView.destroy();
			loadingView = null;
			
			dispatchEvent(new RainAVGEngineEvent(RainAVGEngineEvent.SHOW_MENU));
		}
	}
	
}