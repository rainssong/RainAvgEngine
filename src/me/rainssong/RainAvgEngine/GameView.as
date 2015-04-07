package  me.rainssong.RainAvgEngine
{
	//import flash.desktop.NativeApplication;
	import br.com.stimuli.loading.BulkProgressEvent;
	import com.reintroducing.sound.SoundManager;
	import flash.events.Event;
	import flash.filesystem.File;
	import me.rainssong.filesystem.FileCore;
	import me.rainssong.manager.KeyboardManager;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.RainAvgEngine.view.LoadingView;
	import me.rainssong.RainAvgEngine.view.HomeView;
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
			var assetsFile:File= File.applicationDirectory.resolvePath("assets/");
			var files:Array.<File> = FileCore.getAllFiles(assetsFile);
			for (var i:int = 0; i < files.length; i++) 
			{
				if (!files[i].isDirectory)
				{
					var f1:File = files[i];
					var f2:File = File.applicationDirectory;
					if (f1.extension == "mp3"){
						SoundManager.getInstance().addExternalSound(f2.getRelativePath(f1), f2.getRelativePath(f1));
					}
					else
						SingletonManager.bulkLoader.add(f2.getRelativePath(f1));
				}
			}
			
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onComplete);
			SingletonManager.bulkLoader.start(1);
		}
		
		private function onProgress(e:BulkProgressEvent):void 
		{
			//powerTrace(e);
		}
		
		private function onComplete(e:BulkProgressEvent):void 
		{
			AnimationCore.switchView(loadingView, new HomeView);
		}
	}
	
}