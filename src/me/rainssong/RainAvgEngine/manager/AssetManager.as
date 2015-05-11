package me.rainssong.RainAvgEngine.manager 
{
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
	
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public class AssetManager extends EventDispatcher
	{
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
		
		private function onProgress(e:BulkProgressEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onComplete(e:BulkProgressEvent):void 
		{
			dispatchEvent(e);
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.PROGRESS, onProgress);
			SingletonManager.bulkLoader.removeEventListener(BulkProgressEvent.COMPLETE, onComplete);
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