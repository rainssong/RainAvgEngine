package me.rainssong.RainAvgEngine.manager 
{
	import ascb.util.StringUtilities;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import com.reintroducing.sound.SoundManager;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import me.rainssong.events.ObjectEvent;
	import me.rainssong.filesystem.FileCore;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.RainAvgEngine.events.AssetManagerEvent;
	import me.rainssong.utils.StringCore;
	import me.rainui.events.RainUIEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public class AssetManager extends EventDispatcher
	{
		private var _configData:Object;
		public function AssetManager() 
		{
			
		}
		
		public function startLoad(dic:String = "assets/"):void
		{
			var assetsFile:File= File.applicationDirectory.resolvePath(dic);
			var files:Array.<File> = FileCore.getAllFiles(assetsFile);
			
			for (var i:int = 0; i < files.length; i++) 
			{
				if (!files[i].isDirectory)
				{
					var f1:File = files[i];
					var f2:File = File.applicationDirectory;
					if (f1.extension == "mp3")
						SoundManager.getInstance().addExternalSound(f2.getRelativePath(f1), f2.getRelativePath(f1));
					else
						SingletonManager.bulkLoader.add(f2.getRelativePath(f1));
				}
			}
			
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onComplete);
			SingletonManager.bulkLoader.start(1);
		}
		
		public function loadDictionary(dic:String = "assets/"):void
		{
			startLoad(dic);
		}
		
		public function loadConfigFile(url:String):void
		{
			SingletonManager.bulkLoader.add(url, { id:"configFile" } );
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.PROGRESS, onConfigProgress);
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onConfigComplete);
			SingletonManager.bulkLoader.start(1);
		}
		
		private function onConfigComplete(e:BulkProgressEvent):void 
		{
			
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.PROGRESS, onConfigProgress);
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.COMPLETE, onConfigComplete);
			var _configStr:String=SingletonManager.bulkLoader.getText("configFile");
			_configData =  JSON.parse(_configStr);
			loadAllByConfig();
			
			dispatchEvent(new AssetManagerEvent(AssetManagerEvent.CONFIG_COMPLETE));
		}
		
		public function loadAllByConfig():void 
		{
			if (_configData == null)
			{
				powerTrace("no configData");
				return;
			}
			if (!_configData.hasOwnProperty("resources"))
			{
				powerTrace("no resources data");
				return;
			}
			var resources:Array = _configData.resources as Array;
			
			for (var i:int = 0; i < resources.length; i++) 
			{
				var res:Object = resources[i];
				
				SingletonManager.bulkLoader.add(res.url, { id:res.name } );
			}
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			SingletonManager.bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onComplete);
			SingletonManager.bulkLoader.start(1);
		}
		
		//public function loadGroup(indexOrName:*):void 
		//{
			//var gs:Array = groups;
			//if (indexOrName is String)
			//{
				//for (var i:int = 0; i <gs.length ; i++) 
				//{
					//if (gs[i].hasOwnProperty("name"))
						//if (gs[i].name == indexOrName)
							//
				//}
			//}
		//}
		
		public function get groups():Array
		{
			if (_configData.hasOwnProperty("groups"))
			{
				return _configData["groups"] as Array;
			}
			else
				return [];
		}
		
		private function onConfigProgress(e:BulkProgressEvent):void 
		{
			
		}
		
		private function onProgress(e:BulkProgressEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onComplete(e:BulkProgressEvent):void 
		{
			
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.PROGRESS, onProgress);
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.COMPLETE, onComplete);
			
			dispatchEvent(new AssetManagerEvent(AssetManagerEvent.RESOURCE_COMPLETE));
		}
		
		public function dispose():void
		{
			clear();
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.PROGRESS, onProgress);
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.COMPLETE, onComplete);
		}
		
		public function clear():void
		{
			SingletonManager.bulkLoader.pauseAll();
			SingletonManager.bulkLoader.clear();
			SoundManager.getInstance().removeAllSounds();
		}
		
		
		
		/* DELEGATE br.com.stimuli.loading.BulkLoader */
		
		public function getBinary(key:*, clearMemory:Boolean = false):ByteArray 
		{
			return SingletonManager.bulkLoader.getBinary(key, clearMemory);
		}
		
		public function getBitmap(key:String, clearMemory:Boolean = false):Bitmap 
		{
			return SingletonManager.bulkLoader.getBitmap(key, clearMemory);
		}
		
		public function getBitmapData(key:*, clearMemory:Boolean = false):BitmapData 
		{
			return SingletonManager.bulkLoader.getBitmapData(key, clearMemory);
		}
		
		public function getContent(key:String, clearMemory:Boolean = false):* 
		{
			return SingletonManager.bulkLoader.getContent(key, clearMemory);
		}
		
		public function getMovieClip(key:String, clearMemory:Boolean = false):MovieClip 
		{
			return SingletonManager.bulkLoader.getMovieClip(key, clearMemory);
		}
		
		public function getSprite(key:String, clearMemory:Boolean = false):Sprite 
		{
			return SingletonManager.bulkLoader.getSprite(key, clearMemory);
		}
		
		public function getText(key:*, clearMemory:Boolean = false):String 
		{
			return SingletonManager.bulkLoader.getText(key, clearMemory);
		}
		
		public function getXML(key:*, clearMemory:Boolean = false):XML 
		{
			return SingletonManager.bulkLoader.getXML(key, clearMemory);
		}
		
		
	}

}